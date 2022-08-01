Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DF2586B32
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiHAMrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiHAMqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:46:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB729FC4
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:36:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FC56B81173
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 12:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82336C433C1;
        Mon,  1 Aug 2022 12:36:55 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QKy5U0pN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1659357413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2KISeyaLsqCiN/ZJ9W/b9JY9pxQfrQ535e2JkH7NRdo=;
        b=QKy5U0pNaRsUuee6rzIdJoho7WGmWC88MH+HC0/QhQnrkwUue4McSlqbOm7yWKOi6YDS5D
        wVEaDn0wdi8jdD9dB+cDuCDh0uoO8qsG/eqJuK5s8diBtB9Xl5PWVnHt0PCzYdVOTwCF3n
        6l1Xk2avoWWVR6cdUhfJK4pnf40AUoM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c7938d60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Aug 2022 12:36:53 +0000 (UTC)
Date:   Mon, 1 Aug 2022 14:36:48 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2 v3] lib/vsprintf: Initialize vsprintf's pointer hash
 once the random core is ready.
Message-ID: <YufHN7fF0dROMETj@zx2c4.com>
References: <20220729154716.429964-1-bigeasy@linutronix.de>
 <20220729154716.429964-3-bigeasy@linutronix.de>
 <YuRtSGCfe2qxHrqT@zx2c4.com>
 <YueBnnnnvpxxjE4N@linutronix.de>
 <YueeIgPGUJgsnsAh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YueeIgPGUJgsnsAh@linutronix.de>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 11:34:26AM +0200, Sebastian Andrzej Siewior wrote:
> The printk code invokes vnsprintf in order to compute the complete
> string before adding it into its buffer. This happens in an IRQ-off
> region which leads to a warning on PREEMPT_RT in the random code if the
> format strings contains a %p for pointer printing. This happens because
> the random core acquires locks which become sleeping locks on PREEMPT_RT
> which must not be acquired with disabled interrupts and or preemption
> disabled.
> By default the pointers are hashed which requires a random value on the
> first invocation (either by printk or another user which comes first.
> 
> One could argue that there is no need for printk to disable interrupts
> during the vsprintf() invocation which would fix the just mentioned
> problem. However printk itself can be invoked in a context with
> disabled interrupts which would lead to the very same problem.
> 
> Move the initialization of ptr_key into a worker and schedule it from
> subsys_initcall(). This happens early but after the workqueue subsystem
> is ready. Use get_random_bytes() to retrieve the random value if the RNG
> core is ready, otherwise schedule a worker in two seconds and try again.
> 
> Reported-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v2…v3:
>    - schedule a worker every two seconds if the RNG core is not ready.
> 
>  lib/vsprintf.c |   46 +++++++++++++++++++++++++++-------------------
>  1 file changed, 27 insertions(+), 19 deletions(-)
> 
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -751,31 +751,39 @@ static int __init debug_boot_weak_hash_e
>  early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
>  
>  static bool filled_random_ptr_key;
> +static siphash_key_t ptr_key __read_mostly;
> +static void fill_ptr_key_workfn(struct work_struct *work);
> +static DECLARE_DELAYED_WORK(fill_ptr_key_work, fill_ptr_key_workfn);
> +
> +static void fill_ptr_key_workfn(struct work_struct *work)
> +{
> +	if (!rng_is_initialized()) {
> +		queue_delayed_work(system_unbound_wq, &fill_ptr_key_work, HZ  * 2);
> +		return;
> +	}

This seems kind of crazy and over-complex. You only need this on RT,
right? Because of the raw lock issue? So just schedule it for the right
time on RT and not elsewhere.

I'll send a more basic patch.

Jason
