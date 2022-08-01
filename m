Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A221586B5B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbiHAMwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiHAMvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:51:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039972E9ED
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:46:38 -0700 (PDT)
Date:   Mon, 1 Aug 2022 14:46:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659357996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Axnk2F+6LBHUQxdComROfBL2Iw/LZzYHPtdiCi0kCF0=;
        b=I9qt9ha4hA+DF/6ydb+2lOxE5kiYKegAvfg8DPv/Gd5ey3Q5zirho+xPxl11GgZAA2zN8v
        E1YDRNqWy6Vw0Bo5+q3KKPPWZwpohbBjsB4xBLDtHYga7AmmRNl7QQq5tJpuyr0KbgVIge
        /iNNDGSTqG0XMlYXDZqNw7yBRe/dumurlTABsC/VKOr24SHhclF5PRjOy3VGoIQRIJtYN6
        w4r3Q336dSyzmS4LpBy2aZ0sCeFhY4n6NUYK092QAvcw81hvPADRKTYcNn2eIl35BewRE9
        MxSjoT13QGktESoH7Heou4ndevVku/38zrltjFVVCIGgavW6HS2ZZ0we7ohMuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659357996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Axnk2F+6LBHUQxdComROfBL2Iw/LZzYHPtdiCi0kCF0=;
        b=GMauYTtb2AD8hi3X6NpzXiDXMva7yk4lD/0+NO58WcHQAMCBkTXYWcLJEyy0Bczm+9gn6x
        iAf1W/KpGjoWDyBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4] lib/vsprintf: defer filling siphash key on RT
Message-ID: <YufLK6hio/v1gfmq@linutronix.de>
References: <YufHN7fF0dROMETj@zx2c4.com>
 <20220801123945.43081-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220801123945.43081-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-01 14:39:46 [+0200], Jason A. Donenfeld wrote:
> On RT, we can't call get_random_bytes() from inside of the raw locks
> that callers of vsprintf might take, because get_random_bytes() takes
> normal spinlocks. So on those RT systems, defer the siphash key
> generation to a worker.
> 
> Also, avoid using a static_branch, as this isn't the fast path.
> Using static_branch_likely() to signal that ptr_key has been filled is a
> bit much given that it is not a fast path.
> 
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reported-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Sebastian - feel free to take this and tweak it as needed. Sending this
> mostly as something illustrative of what the "simpler" thing would be
> that I had in mind. -Jason

Can have the same behaviour regardless of CONFIG_PREEMPT_RT? Here
lockdep _may_ yell with !RT because it is broken for RT.
If we agree that we drop the first %p print here, can we do this on
both (regardless of CONFIG_PREEMPT_RT)?

Sebastian
