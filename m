Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79327550D93
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 01:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbiFSX2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 19:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiFSX2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 19:28:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780F464E8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 16:28:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05D05B80DF6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:28:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7770C34114;
        Sun, 19 Jun 2022 23:28:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ROnl3ZyJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655681308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rjk/L2grc9WIB0E+QhnWL95ftKF7ahlZzhnnKorlIlc=;
        b=ROnl3ZyJNTwLHXAdC8rw9hhB6CDsneVUAm8WwQgwaChfYpt3w+UoXz5evmcC6dgccPFakA
        Z6C1GNFienVARFuojv2u0fPbJ9H1WM55ZwuCYNDKg9OZ+GUTatktgK8ClETdU1Pp5gtg50
        6edppqa4IrkjqP6XiwkY7XKCFvMH6Qk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2e927867 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 19 Jun 2022 23:28:27 +0000 (UTC)
Date:   Mon, 20 Jun 2022 01:28:25 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] printk: allow direct console printing to be enabled
 always
Message-ID: <Yq+xGcBO06ILMUFy@zx2c4.com>
References: <Yq+Jjoyn/wj7yzeQ@zx2c4.com>
 <20220619204326.556923-1-Jason@zx2c4.com>
 <87letsw8en.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87letsw8en.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Mon, Jun 20, 2022 at 01:23:04AM +0206, John Ogness wrote:
> On 2022-06-19, "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
> > diff --git a/init/Kconfig b/init/Kconfig
> > index c7900e8975f1..47466aa2b0e8 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> 
> Sorry, I missed this in your v1. But I think this config belongs in
> lib/Kconfig.debug under the "printk and dmesg options" menu.

That's better. It helps drive home that it's a debug thing.

> > +static bool printk_direct = IS_ENABLED(CONFIG_PRINTK_DIRECT);
> 
> I understand why you would name the variable to match the boot arg. But
> I would prefer the _internal_ variable had a name that makes it clear
> (to us developers) that it is a permanent setting. Perhaps
> printk_direct_only or printk_direct_always?

Sure, I'll do that. The variable can also be __initdata, since it's only
used inside of an __init function.

> > +	if (printk_direct)
> 
> I'm wondering if we should output a message here. My suggestion is:
> 
> pr_info("printing threads disabled, using direct printing\n");

That seems a bit heavy to me, and just adds more log spam. Moving it
into the debug kconfig zone seems like the right way to handle this
instead.

> > +		return 0;
> > +
> >  	console_lock();
> >  	printk_kthreads_available = true;
> >  	for_each_console(con)
> 
> Otherwise it looks OK to me. But you may want to wait on a response from
> Petr, Sergey, or Steven before sending a v3. You are adding a kernel
> config and a boot argument. Both of these are sensitive topics that
> require more feedback from others.

Fair enough. It's easy enough to send a v3, and I agree with most of
your suggestions, so I'll send that now, and we'll wait to hear if the
others think it's fine too. 

Jason
