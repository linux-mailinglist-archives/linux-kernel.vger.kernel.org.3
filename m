Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95B44CD865
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbiCDP5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbiCDP5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:57:48 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5051C6EF0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 07:56:59 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A1FF61F385;
        Fri,  4 Mar 2022 15:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646409418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bGT8Ow4NIxBkj0yHGqhgln0GynFbynwDxe/+jElokrM=;
        b=inuxdLvIghYVTeB3ztgSE0TSH7BdmBLA6EGRlhiiA8Znrxnf/S5cGvhDvH8g9qQGZ8k+jh
        /ffikZgPj7eJviIXTeG4YPqc2qOeJj1XDB7XGiBGy7P+6mxQzydAPNqoYHHPiiBWTUrIG6
        Xd7hQiBFyGkQyKEKLkGdukmekl5y814=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 68013A3B83;
        Fri,  4 Mar 2022 15:56:58 +0000 (UTC)
Date:   Fri, 4 Mar 2022 16:56:55 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 03/13] printk: use percpu flag instead of
 cpu_online()
Message-ID: <YiI2x6K5IhsADEmK@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-4-john.ogness@linutronix.de>
 <YgaJZtY+EH9JIGyo@alley>
 <YgoGNmYER8xni34K@google.com>
 <YguCuFYeZ52mkr4r@alley>
 <87zgm8h1tt.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgm8h1tt.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-03-02 15:27:50, John Ogness wrote:
> I have taken some time to investigate the percpu implementation so that
> I could provide clear answers here.
> 
> On 2022-02-15, Petr Mladek <pmladek@suse.com> wrote:
> > I am not 100% sure. But it seems that static per-CPU variables might
> > actually be used since the boot.
> 
> You are correct, but until per-cpu areas are setup, they all point to
> CPU0. Normally that is not a problem since usually code is using
> this_cpu_ptr() (which will always be the CPU0 in early boot), rather
> than specifying foreign CPUs with per_cpu_ptr().
> 
> > Most likely, only dynamically allocated per-cpu variables have to wait
> > until the per-cpu areas are initialized.
> 
> It is also important to wait if data will be stored that is no longer
> valid after per-cpu areas are setup. setup_per_cpu_areas() copies the
> static CPU0 per-cpu value to all the newly setup per-cpu areas.
> 
> This is actually the cause for the mystery [0] of failing irq_work when
> printk_deferred was added with commit
> 15341b1dd409749fa5625e4b632013b6ba81609b ("char/random: silence a
> lockdep splat with printk()".

Just for record, the right commit ID in the mainline is
1b710b1b10eff9d466. It used printk_deferred() in _warn_unseeded_randomness():

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1687,8 +1687,9 @@ static void _warn_unseeded_randomness(const char *func_name, void *caller,
 	print_once = true;
 #endif
 	if (__ratelimit(&unseeded_warning))
-		pr_notice("random: %s called from %pS with crng_init=%d\n",
-			  func_name, caller, crng_init);
+		printk_deferred(KERN_NOTICE "random: %s called from %pS "
+				"with crng_init=%d\n", func_name, caller,
+				crng_init);
 }
 
 /*



> By avoiding queueing irq_work before setup_per_cpu_areas(), we correctly
> avoided this problem. (I considered sending a patch so that
> irq_work_claim() will fail if a global @percpu_complete is not yet
> set.

That is a great TODO :-)

> But for now, our set_percpu_data_ready() solution is at least good
> enough for the printk subsystem.)

Yes but it is most likely not needed for CON_ANYTIME consoles,
see below.

> > We should probably revisit the code and remove the fallback to
> > normal static variables.
> 
> Definitely. Now it is clear that @printk_count and @printk_count_nmi do
> not need early variants.

Note the ordering:

asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
{
[...]
	early_security_init();
[...]
	setup_per_cpu_areas();
[...]
	parse_early_param();
	after_dashes = parse_args("Booting kernel",


My guess is that _warn_unseeded_randomness() was called from a code
before early_security_init(). It was bad because per-CPU variables
were not ready yet.

The early consoles are enabled by parse_early_param(). It happens
after setup_per_cpu_areas(). It means that all console drivers
should be on the safe side.

Best Regards,
Petr
