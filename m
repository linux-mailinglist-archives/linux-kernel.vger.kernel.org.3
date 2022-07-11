Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ABE570B40
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiGKUSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGKUSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:18:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE30CCB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:18:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93D7A615F2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 20:18:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F244C341C0;
        Mon, 11 Jul 2022 20:18:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GTT1Sv3r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657570710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mS6nwVmzJpgwQmYPFFWSMUwjGu7ENCHphKaSUFH+R00=;
        b=GTT1Sv3rUWAUutaAZS0H2XiMfqezx4gZpflmZw3vCTTXjmuYnF6TYYHXtyZRQQyVTwEsl8
        rmEQviw+OGypBGXHzFEn00j/jgW9arSjzFvHFlOtiPMxy9PJhUB1WLlKdUAA4IS4F4sAGp
        KaXCeFGhBOGg17FpbwG9x0zcgFHzv5w=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6ef4addd (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 11 Jul 2022 20:18:27 +0000 (UTC)
Date:   Mon, 11 Jul 2022 22:18:13 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] signal: break out of wait loops on kthread_stop()
Message-ID: <YsyFhfAunVfVQKci@zx2c4.com>
References: <YrslT9h0whngMIhw@zx2c4.com>
 <20220628161441.892925-1-Jason@zx2c4.com>
 <YsLbggVXONPJcZsn@zx2c4.com>
 <CAHmME9qt9hUTgJQSdv3_Yzkc3e7H8OkhPSv_pUaXV_2AOA1S=g@mail.gmail.com>
 <87o7xvcw98.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o7xvcw98.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

Thanks for the review.

On Mon, Jul 11, 2022 at 01:57:55PM -0500, Eric W. Biederman wrote:
> For kthread_stop clearing TIF_NOTIFY_SIGNAL seems pointless as the
> process has exited.

Alright, I'll get rid of the clear there.

> I wonder if we should clear TIF_NOTIFY_SIGNAL in kthread_parkme.
> 
> Ordinarily TIF_NOTIFY_SIGNAL gets cleared when the target process
> calls get_signal.  Which doesn't happen for kernel threads.
> So I am not certain what the best pattern is, but my sense is that
> keeping things as close to how TIF_NOTIFY_SIGNAL is processed
> in the rest of the kernel seems the least error prone pattern.
> 
> So I am thinking the code should do something like:
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 544fd4097406..c80e8d44e405 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -266,6 +266,7 @@ static void __kthread_parkme(struct kthread *self)
>  		 * changin from TASK_PARKED and us failing the
>  		 * wait_task_inactive() in kthread_park().
>  		 */
> +		clear_notify_signal();
>  		set_special_state(TASK_PARKED);
>  		if (!test_bit(KTHREAD_SHOULD_PARK, &self->flags))
>  			break;

That seems at least semantically correct for how parkers usually work.

> I am trying to think about how things interact if two threads call
> kthread_park.  If the target thread is not responsible for clearing
> TIF_NOTIFY_SIGNAL it feels like two threads could get into a race.  A
> race where one thread sees the target thread has parked itself right
> after another thread calls kthread_park and sets TIF_NOTIFY_SIGNAL.
> 
> Given the nature of kthread_park that scenario is probably completely
> ridiculous, but it is all I can think of at the moment to demonstrate
> my concerns.

Right, it's a bit of a stretch to consider two threads racing on
kthread_park(), and were it to happen, maybe the right response would
be, "take a mutex so you don't race for that weird case." But it still
seems semantically correct to clear the flag as your diff does.

> In practice kthread_park is pretty specialized.  Do you have any
> evidence that we need to break out of interruptible loops to make it
> more reliable.  Perhaps it is best just to handle kthread_stop, and
> leave kthread_park for when it actually matters.  Which would ensure
> there are examples that people care about to help sort through exactly
> how the code should behave in the kthread_park case.

Oh, okay. I guess I can do that and we'll address the park case sometime
later if it ever comes up? But actually, upon very very cursory look, it
might actually be an issue now... The uses of it currently break down
into:

Core kernel things:
- kernel/stop_machine.c
- kernel/smpboot.c
- kernel/cpu.c

Drivers:
- drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
- drivers/gpu/drm/msm/adreno/adreno_device.c
- drivers/gpu/drm/scheduler/sched_main.c
- drivers/net/wireless/mediatek/mt76/util.h
- drivers/firmware/psci/psci_checker.c
- drivers/md/raid5-cache.c
- fs/btrfs/disk-io.c

btrfs makes calls to _interruptible() functions (though I'm not sure how
the context stack traces work out). The drm scheduler appears to use
wait_event_interruptible() in the first couple lines of the thread's
loop, though it's wait condition does check for kthread_should_stop(). 

So I don't know...

> Which I guess my long way of saying I think you can just change
> kthread_stop to say:
> 
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 544fd4097406..52e9b3432496 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -704,6 +704,7 @@ int kthread_stop(struct task_struct *k)
>  	kthread = to_kthread(k);
>  	set_bit(KTHREAD_SHOULD_STOP, &kthread->flags);
>  	kthread_unpark(k);
> +	set_tsk_thread_flag(k, TIF_NOTIFY_SIGNAL);
>  	wake_up_process(k);
>  	wait_for_completion(&kthread->exited);
>  	ret = kthread->result;
> 

Okay. I'll constrain it to just kthread_stop(). But please file away in
the back of your mind the potential for kthread_park() to be problematic
down the line, in case we have to fix that later.

Jason
