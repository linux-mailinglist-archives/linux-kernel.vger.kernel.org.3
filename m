Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C42D4D872A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 15:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240263AbiCNOoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 10:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbiCNOow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 10:44:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A821BE9D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 07:43:42 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647269020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0/DI6YXpJMGkTpnCcqvKYgg+joL/JSfOmxQzgCHpY/U=;
        b=WA1vHC+jVY/OZy0lTC5spt32zPPavx8HYQPf06ZiyjiGneHiqmxvsGWvWKtbBRAuOwVe3n
        BleQMvzurFF6kNHB3wHxpErONJr3I3z5Xujofwq/7idBvPlnOLTvpB5mJbJg5aKF/dF2HX
        nKH+xwzoz7sOe6Z7xlCSE4saQVEkTElRU/vkAIbuW8UqBokO4ETJcZUi07l1omfWlGAsJa
        EuUuS0eGJ7F40nMAMG6Wd6fnztBmqgGpo49zfJiK+W3GdsfCkcjlLgb6i+16P9yrHFi32Z
        bNcuti92hVQSvV0to+IlBlHUV2gYu+4g+4hZe9tZdLxmA7Gn4C+d6b4roacGKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647269020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0/DI6YXpJMGkTpnCcqvKYgg+joL/JSfOmxQzgCHpY/U=;
        b=wzj5Dit5IckjlQWzZ5lXmyKzJXi43cr8owxYbBE8y984RGuS/7XURF3nkiE/5HPzaEehS+
        2Lv9eB4KfhypucAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 11/13] printk: reimplement console_lock for
 proper kthread support
In-Reply-To: <Yi9MWKt+PByLsi6Y@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-12-john.ogness@linutronix.de>
 <YhYKP/UuSKENGwfj@alley> <87tuc7xma0.fsf@jogness.linutronix.de>
 <YioMcSe0P0Z7ksiW@alley> <87wnh14wp9.fsf@jogness.linutronix.de>
 <Yisj2PEtjZfHMe6N@alley> <87czisbotz.fsf@jogness.linutronix.de>
 <Yit2LN1nCaiUo5y4@alley> <87tuc4yvsw.fsf@jogness.linutronix.de>
 <Yi9MWKt+PByLsi6Y@alley>
Date:   Mon, 14 Mar 2022 15:49:39 +0106
Message-ID: <87h780y4pw.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-14, Petr Mladek <pmladek@suse.com> wrote:
> My intention is to keep the logic as simple and as clear as possible:
>
>        + if we need lock then use lock
>
>        + if we need trylock then use trylock
>
>        + if we want direct mode then block kthreads and try enter
> 	 the direct mode ASAP.
>
>        + if kthreads mode is allowed then do nothing in
> 	 console_unlock() and leave the job to kthreads.
>
>        + console_lock() temporarily blocks kthreads but
> 	 it handle messages only when direct mode is enforced.

Thank you for your examples, detailed analysis, insight, and summaries.

This particular review became quite complicated because offline you sent
me a heavily revised version. Several of your comments are criticizing
your version and not the actual series I posted. For v2 we need to
handle it better so that the list has a chance at following our
discussion. ;-)

I will post a v2 that attempts to address your concerns and try to frame
the naming and structures to align with your suggestions.

John
