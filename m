Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9212A54F90B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382681AbiFQOVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiFQOVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:21:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7D946B02
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:21:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D09CC21DF8;
        Fri, 17 Jun 2022 14:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655475675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AoMA7wBr+paG/i85/41XbAdh1quVJxGCMyNZ98196S4=;
        b=WzU4WQAPCdTIM5/lqe61HmKX7T6mdkVce7Pf0MxDFWIn8zkJWcrvl9O5RAkpPN2Qcz7+ht
        Mgcm4ziMDrtOciVFpwEwSOnItnYNqeE2Sbxw0tFxJP2nQ80PY9CGk0/9eU/rwN7IVM6vcg
        /n6W8Ppvug8Bw/4bvxtIRl72NaQynj4=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AE6932C141;
        Fri, 17 Jun 2022 14:21:15 +0000 (UTC)
Date:   Fri, 17 Jun 2022 16:21:15 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: Re: 5.19 printk breaks message ordering
Message-ID: <YqyN20jpRw1SaaTw@alley>
References: <YqyANveL50uxupfQ@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqyANveL50uxupfQ@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-06-17 15:23:02, Jason A. Donenfeld wrote:
> Hi John & folks,
> 
> In 5.19, I'm seeing some changes in message ordering / interleaving
> which lead to confusion. The most obvious (and benign) example appears
> on system boot, in which the "Run /init as init process" message gets
> intermixed with the messages that init actually writes() to stdout. For
> example, here's a snippet from build.wireguard.com:
> 
>     [    0.469732] Freeing unused kernel image (initmem) memory: 4576K
>     [    0.469738] Write protecting the kernel read-only data: 10240k
>     [    0.473823] Freeing unused kernel image (text/rodata gap) memory: 2044K
>     [    0.475228] Freeing unused kernel image (rodata/data gap) memory: 1136K
>     [    0.475236] Run /init as init process
>     
>     
>         WireGuard Test Suite on Linux 5.19.0-rc2+ x86_64
>     
>     
>     [+] Mounting filesystems...
>     [+] Module self-tests:
>      *  allowedips self-tests: pass
>      *  nonce counter self-tests: pass
>      *  ratelimiter self-tests: pass
>     [+] Enabling logging...
>     [+] Launching tests...
>     [    0.475237]   with arguments:
>     [    0.475238]     /init
>     [    0.475238]   with environment:
>     [    0.475239]     HOME=/
>     [    0.475240]     TERM=linux
>     [+] ip netns add wg-test-46-0
>     [+] ip netns add wg-test-46-1

I see.

> But the bigger issue for me is that it makes it very confusing to
> interpret CI results later on. Prior, I would nice a nice correlation
> of:
> 
> [+] some userspace command
> [    1.2345 ] some kernel log output
> [+] some userspace command
> [    1.2346 ] some kernel log output
> [+] some userspace command
> [    1.2347 ] some kernel log output
> 
> I assume this is mostly caused by your threaded printk patchset

Console has never been fully synchronous. printk() did console_trylock()
and flushed the message to the console only the lock was available.
The console kthreads made it asynchronous always when the kthreads
are available and system is in normal state.

> This probably has important benefits. But it certainly makes CI
> and related debugging a bit trickier as a result.

I could imagine.

> So I was wondering if there was some way to boot the kernel with a
> command line option or compile-time flag that always flushes printk
> messages when they're made, or does something to make the ordering a bit
> more faithful.

I am pretty sure that we will have to add such an option sooner or
later. We did not want to do it from the beginning because otherwise
people would use it and would not tell use about their problematic
use-cases ;-)

In fact, in your case you might get even better synchronization
if you do it the other way and write userspace messages into
the kernel log via /dev/kmsg:

     echo "Hello world" > /dev/kmsg

That said. I am going to look at your patch the following week.
I also want to wait for an opinion from John.

Best Regards,
Petr
