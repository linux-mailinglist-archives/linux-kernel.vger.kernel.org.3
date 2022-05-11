Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F50652299A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbiEKCXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiEKCXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B6DD14C760
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652235793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NoNShCUgG/r5sx7GtSLhujeTcuOeCXLnixMsESYMdzg=;
        b=iXiclLQi4KTDv51QJYRE2qBUztX1u5nCbw06Ohod28B8yoQNpGmq3PhqA5nWsYoICf+pgf
        R0C6JMZZ8j/H6ugX3TeC8ebnadSDFUxGgx6AYWBrutLJyKco7ivIFYurlqhaRFgaVAANuw
        45aQbAiQRamok/XooFJHy3hc0CCFKyQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-u2Fj0teqMjOEoX3dK9jImg-1; Tue, 10 May 2022 22:23:12 -0400
X-MC-Unique: u2Fj0teqMjOEoX3dK9jImg-1
Received: by mail-lj1-f199.google.com with SMTP id j20-20020a2e8014000000b00250baa159ceso176731ljg.18
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NoNShCUgG/r5sx7GtSLhujeTcuOeCXLnixMsESYMdzg=;
        b=K29p9tLEKBvx4ybzNoSDSDMghGU+AkY40ufyjIQP92snLLuJMANEAOR98+agfjY04N
         ZxcfeRenjz8dD5wb6ItFAdTeRgxtnsYzr0WwagiSbhYlGu/3Nsgd35JC6XtcqOKCEQrG
         waHtjrBf3IGZp7ZnqIeU6sSrZl+uXOnseZeDk9f85Ksgj3diy4ytkG0N5eeLYzfeAXb8
         7mXRX8LuRIkLbxKTVjMG5DcWODBnKWLmmx+GN0eHKMaCdrA9yNSb2ggri1036Lul3R+M
         8TCa9coi4He/OmciyvUsC8NrgIyvSr2dLCFo9ceGCScUJbdsqtQA6PAUPLZ5dpCfxny0
         6plQ==
X-Gm-Message-State: AOAM531kT6m0B1uCZtw5diQ0U1zJKf9ecw6PZL6VoPmRF2uB653v3n05
        0zrs/yPQ3dBToi7dI7Y114UNNbQ7etYXa3fRLSdTgTXMgPBS03qNk+P7OnamZ/9losBG4+nqOlF
        XAk22USy8usHginyfKjiU+i++Du0j4eRaHUHIJ5Bv
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id h16-20020a19ca50000000b00471f556092bmr18193781lfj.587.1652235790480;
        Tue, 10 May 2022 19:23:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfn5RF53v2JjmJJQkV8pzwLGeqEl3ZHCNTpF3vbu92pgelfIJ4hMyyAb1vY2XGHUKz6rIPN4WAR3mln3WzRxs=
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr18193766lfj.587.1652235790258; Tue, 10
 May 2022 19:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220507071954.14455-1-jasowang@redhat.com> <875ymd3fd1.fsf@redhat.com>
In-Reply-To: <875ymd3fd1.fsf@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 11 May 2022 10:22:59 +0800
Message-ID: <CACGkMEvfkUpsY4LRTuH7w18DZdq+w3=Ef6b-0sG0XvzVUVKdzg@mail.gmail.com>
Subject: Re: [PATCH V4 0/9] rework on the IRQ hardening of virtio
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 5:29 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Sat, May 07 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > Hi All:
> >
> > This is a rework on the IRQ hardening for virtio which is done
> > previously by the following commits are reverted:
> >
> > 9e35276a5344 ("virtio_pci: harden MSI-X interrupts")
> > 080cd7c3ac87 ("virtio-pci: harden INTX interrupts")
> >
> > The reason is that it depends on the IRQF_NO_AUTOEN which may conflict
> > with the assumption of the affinity managed IRQ that is used by some
> > virtio drivers. And what's more, it is only done for virtio-pci but
> > not other transports.
> >
> > In this rework, I try to implement a general virtio solution which
> > borrows the idea of the INTX hardening by re-using per virtqueue
> > boolean vq->broken and toggle it in virtio_device_ready() and
> > virtio_reset_device(). Then we can simply reuse the existing checks in
> > the vring_interrupt() and return early if the driver is not ready.
> >
> > Note that, I only did compile test on ccw and MMIO transport.
>
> Lockdep is unhappy with the ccw parts:
>
> ================================
> WARNING: inconsistent lock state
> 5.18.0-rc6+ #191 Not tainted
> --------------------------------
> inconsistent {IN-HARDIRQ-R} -> {HARDIRQ-ON-W} usage.
> kworker/u4:0/9 [HC0[0]:SC0[0]:HE1:SE1] takes:
> 00000000058e9618 (&vcdev->irq_lock){+-..}-{2:2}, at: virtio_ccw_synchronize_cbs+0x4e/0x60
> {IN-HARDIRQ-R} state was registered at:
>   __lock_acquire+0x442/0xc20
>   lock_acquire.part.0+0xdc/0x228
>   lock_acquire+0xa6/0x1b0
>   _raw_read_lock_irqsave+0x72/0x100
>   virtio_ccw_int_handler+0x84/0x238
>   ccw_device_call_handler+0x72/0xd0
>   ccw_device_irq+0x7a/0x198
>   do_cio_interrupt+0x11c/0x1d0
>   __handle_irq_event_percpu+0xc2/0x318
>   handle_irq_event_percpu+0x26/0x68
>   handle_percpu_irq+0x64/0x88
>   generic_handle_irq+0x40/0x58
>   do_irq_async+0x56/0xb0
>   do_io_irq+0x82/0x160
>   io_int_handler+0xe6/0x120
>   rcu_read_lock_sched_held+0x3e/0xb0
>   lock_acquired+0x12e/0x208
>   new_inode+0x3e/0xd0
>   debugfs_get_inode+0x22/0x68
>   __debugfs_create_file+0x78/0x1c0
>   debugfs_create_file_unsafe+0x36/0x58
>   debugfs_create_u32+0x38/0x68
>   sched_init_debug+0xb0/0x1c0
>   do_one_initcall+0x108/0x280
>   do_initcalls+0x124/0x148
>   kernel_init_freeable+0x242/0x280
>   kernel_init+0x2e/0x158
>   __ret_from_fork+0x3c/0x50
>   ret_from_fork+0xa/0x40
> irq event stamp: 539789
> hardirqs last  enabled at (539789): [<0000000000d9c632>] _raw_spin_unlock_irqrestore+0x72/0x88
> hardirqs last disabled at (539788): [<0000000000d9c2b6>] _raw_spin_lock_irqsave+0x96/0xd0
> softirqs last  enabled at (539568): [<0000000000d9e0d4>] __do_softirq+0x434/0x588
> softirqs last disabled at (539503): [<000000000018cd66>] __irq_exit_rcu+0x146/0x170
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(&vcdev->irq_lock);
>   <Interrupt>
>     lock(&vcdev->irq_lock);
>
>  *** DEADLOCK ***

It looks to me we need to use write_lock_irq()/write_unlock_irq() to
do the synchronization.

And we probably need to keep the
read_lock_irqsave()/read_lock_irqrestore() logic since I can see the
virtio_ccw_int_handler() to be called from process context (e.g from
the io_subchannel_quiesce()).

Thanks

>
> 2 locks held by kworker/u4:0/9:
>  #0: 000000000288d948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1ea/0x658
>  #1: 000003800004bdc8 ((work_completion)(&entry->work)){+.+.}-{0:0}, at: process_one_work+0x1ea/0x658
>
> stack backtrace:
> CPU: 1 PID: 9 Comm: kworker/u4:0 Not tainted 5.18.0-rc6+ #191
> Hardware name: QEMU 8561 QEMU (KVM/Linux)
> Workqueue: events_unbound async_run_entry_fn
> Call Trace:
>  [<0000000000d8af22>] dump_stack_lvl+0x92/0xd0
>  [<00000000002032ac>] mark_lock_irq+0x864/0x968
>  [<0000000000203670>] mark_lock.part.0+0x2c0/0x790
>  [<0000000000203cea>] mark_usage+0x10a/0x178
>  [<000000000020692a>] __lock_acquire+0x442/0xc20
>  [<0000000000207cc4>] lock_acquire.part.0+0xdc/0x228
>  [<0000000000207eb6>] lock_acquire+0xa6/0x1b0
>  [<0000000000d9c774>] _raw_write_lock+0x54/0xa8
>  [<0000000000d5a1f6>] virtio_ccw_synchronize_cbs+0x4e/0x60
>  [<00000000008eec04>] register_virtio_device+0xdc/0x1b0
>  [<0000000000d5aabe>] virtio_ccw_online+0x246/0x2e8
>  [<0000000000c9fecc>] ccw_device_set_online+0x1c4/0x540
>  [<0000000000d5a05e>] virtio_ccw_auto_online+0x26/0x50
>  [<00000000001ba2b0>] async_run_entry_fn+0x40/0x108
>  [<00000000001ab9b4>] process_one_work+0x2a4/0x658
>  [<00000000001abdd0>] worker_thread+0x68/0x440
>  [<00000000001b4668>] kthread+0x128/0x130
>  [<0000000000102fac>] __ret_from_fork+0x3c/0x50
>  [<0000000000d9d3aa>] ret_from_fork+0xa/0x40
> INFO: lockdep is turned off.
>

