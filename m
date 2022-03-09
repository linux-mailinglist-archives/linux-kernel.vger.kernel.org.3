Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2034D2940
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiCIHFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiCIHFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:05:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A6DAE6844
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646809452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cZlxSCuMLBQaOXGBfR9hCieMl+CRPGYnGKDTh2qEHUI=;
        b=WOoiNpY5DIHceaiV/X7Mz92waocsz1ggEu4zLEaeqtEDtm/ntCA9X8MHxBdB7c2VP0Jwrs
        4iNk5TKDMr9OZV3J7tZ9p7sTXTSj03qjLFJVDyRw1qlkru/FCe26RMDGuU38gWjHCLZufa
        rdFPmpTqwrqg3mCDEdLbR23VIAsb34Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-353-B12dBrLePjWxN0fkKJDpqw-1; Wed, 09 Mar 2022 02:04:10 -0500
X-MC-Unique: B12dBrLePjWxN0fkKJDpqw-1
Received: by mail-wm1-f69.google.com with SMTP id l2-20020a1ced02000000b0038482a47e7eso2205014wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 23:04:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cZlxSCuMLBQaOXGBfR9hCieMl+CRPGYnGKDTh2qEHUI=;
        b=uQx64I/AokzNIR4A8dFXQGSyRjUVNOesHwVJAfq71bZ/rG5zIAuo+gKx2iR5OhfvQj
         Byc2vhLEuki2sJoz7QISi2AqFVsVhp4mp4YO0IBzjFqzysLMFu4hLEm8GVZlbt208171
         A6rtYQHelPPzqQcSe7syXHA7JWrzn+Xr7qCAGU1Y3vJmpdwn3b+0GYYY4LW8ZQRcgN6m
         1GGUTqGobGrIm0vVu3cAO+vGg5gkJYfSs11TT0BGtPHyl3l5stEhlcs8lhEFoozc0vXf
         s4E1C6ft6o45UqOLVlIyHu4+9WAStxj1nrk0aYnSQ2ErOsY8IWZX5IZU8HD3gSE4qBVM
         gKJw==
X-Gm-Message-State: AOAM532CFBNQj2poO1Q523Re9rjUP/KYvNbgNkEO8VFk17AbtGOK7/sJ
        hQl3OGfH5vqsiDOHDlmI/khVtPECjLFPVM+sIBC7hb6CkwvS6phK1cLLp275jP4DjN+I/RzJEFY
        AThP/Z4LzcQBdZX+35Svv/Rrx
X-Received: by 2002:a5d:5887:0:b0:1f1:eb44:724e with SMTP id n7-20020a5d5887000000b001f1eb44724emr12027327wrf.44.1646809448422;
        Tue, 08 Mar 2022 23:04:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwsy6Ytwma5gqRDMKuXAQewkNAd01cq5kPhy3hzhCjwT33e0tUETPpdiECHZdsMyGjAfTEcHQ==
X-Received: by 2002:a5d:5887:0:b0:1f1:eb44:724e with SMTP id n7-20020a5d5887000000b001f1eb44724emr12027302wrf.44.1646809448122;
        Tue, 08 Mar 2022 23:04:08 -0800 (PST)
Received: from redhat.com ([2.55.46.250])
        by smtp.gmail.com with ESMTPSA id s17-20020adfbc11000000b001f023d197b8sm830608wrg.68.2022.03.08.23.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 23:04:07 -0800 (PST)
Date:   Wed, 9 Mar 2022 02:04:03 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>, keirf@google.com
Subject: Re: [PATCH V3 04/10] virtio_pci: harden MSI-X interrupts
Message-ID: <20220309020123-mutt-send-email-mst@kernel.org>
References: <20211019070152.8236-1-jasowang@redhat.com>
 <20211019070152.8236-5-jasowang@redhat.com>
 <87y21kzd3f.wl-maz@kernel.org>
 <20220308113119-mutt-send-email-mst@kernel.org>
 <CACGkMEszR12BoEV=tds3u1DcC3VrChKuc9H3FzxAg1rH8im=_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEszR12BoEV=tds3u1DcC3VrChKuc9H3FzxAg1rH8im=_g@mail.gmail.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 11:41:01AM +0800, Jason Wang wrote:
> 
> 
> On Wed, Mar 9, 2022 at 12:36 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
>     On Tue, Mar 08, 2022 at 03:19:16PM +0000, Marc Zyngier wrote:
>     > On Tue, 19 Oct 2021 08:01:46 +0100,
>     > Jason Wang <jasowang@redhat.com> wrote:
>     > >
>     > > We used to synchronize pending MSI-X irq handlers via
>     > > synchronize_irq(), this may not work for the untrusted device which
>     > > may keep sending interrupts after reset which may lead unexpected
>     > > results. Similarly, we should not enable MSI-X interrupt until the
>     > > device is ready. So this patch fixes those two issues by:
>     > >
>     > > 1) switching to use disable_irq() to prevent the virtio interrupt
>     > >    handlers to be called after the device is reset.
>     > > 2) using IRQF_NO_AUTOEN and enable the MSI-X irq during .ready()
>     > >
>     > > This can make sure the virtio interrupt handler won't be called before
>     > > virtio_device_ready() and after reset.
>     > >
>     > > Cc: Thomas Gleixner <tglx@linutronix.de>
>     > > Cc: Peter Zijlstra <peterz@infradead.org>
>     > > Cc: Paul E. McKenney <paulmck@kernel.org>
>     > > Signed-off-by: Jason Wang <jasowang@redhat.com>
>     > > ---
>     > >  drivers/virtio/virtio_pci_common.c | 27 +++++++++++++++++++++------
>     > >  drivers/virtio/virtio_pci_common.h |  6 ++++--
>     > >  drivers/virtio/virtio_pci_legacy.c |  5 +++--
>     > >  drivers/virtio/virtio_pci_modern.c |  6 ++++--
>     > >  4 files changed, 32 insertions(+), 12 deletions(-)
>     > >
>     > > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/
>     virtio_pci_common.c
>     > > index b35bb2d57f62..8d8f83aca721 100644
>     > > --- a/drivers/virtio/virtio_pci_common.c
>     > > +++ b/drivers/virtio/virtio_pci_common.c
>     > > @@ -24,8 +24,8 @@ MODULE_PARM_DESC(force_legacy,
>     > >              "Force legacy mode for transitional virtio 1 devices");
>     > >  #endif
>     > > 
>     > > -/* wait for pending irq handlers */
>     > > -void vp_synchronize_vectors(struct virtio_device *vdev)
>     > > +/* disable irq handlers */
>     > > +void vp_disable_cbs(struct virtio_device *vdev)
>     > >  {
>     > >     struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>     > >     int i;
>     > > @@ -34,7 +34,20 @@ void vp_synchronize_vectors(struct virtio_device
>     *vdev)
>     > >             synchronize_irq(vp_dev->pci_dev->irq);
>     > > 
>     > >     for (i = 0; i < vp_dev->msix_vectors; ++i)
>     > > -           synchronize_irq(pci_irq_vector(vp_dev->pci_dev, i));
>     > > +           disable_irq(pci_irq_vector(vp_dev->pci_dev, i));
>     > > +}
>     > > +
>     > > +/* enable irq handlers */
>     > > +void vp_enable_cbs(struct virtio_device *vdev)
>     > > +{
>     > > +   struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>     > > +   int i;
>     > > +
>     > > +   if (vp_dev->intx_enabled)
>     > > +           return;
>     > > +
>     > > +   for (i = 0; i < vp_dev->msix_vectors; ++i)
>     > > +           enable_irq(pci_irq_vector(vp_dev->pci_dev, i));
>     >
>     > This results in a splat at boot time if you set maxcpus=<whatever>,
>     > see below. Enabling interrupts that are affinity managed is *bad*. You
>     > don't even know whether the CPU which is supposed to handle this is
>     > online or not.
>     >
>     > The core kernel notices it, shouts and keeps the interrupt disabled,
>     > but this should be fixed. The whole point of managed interrupts is to
>     > let them be dealt with outside of the drivers, and tied into the CPUs
>     > being brought up and down. If virtio needs (for one reason or another)
>     > to manage interrupts on its own, so be it. But this patch isn't the
>     > way to do it, I'm afraid.
>     >
>     >       M.
> 
>     Thanks for reporting this!
> 
>     What virtio is doing here isn't unique however.
> 
>     If device driver is to be hardened against device sending interrupts
>     while driver is initializing/cleaning up, it needs kernel to provide
>     capability to disable these.
> 
>     If we then declare that that is impossible for managed interrupts
>     then that will mean most devices can't use managed interrupts
>     because ideally we'd have all drivers hardened.
> 
> 
> Or that probably means we need to use a driver specific mechanism as what we
> did for INTX instead of using NO_AUTO_EN.
> 
> Thanks 

What we did for INTX was pretty expensive, we justified this
by saying INTX handling involves expensive IO reads anyway
so it's in the noise.

Let's see what does Thomas suggest.

> 
> 
>     Thomas I think you were the one who suggested enabling/disabling
>     interrupts originally - thoughts?
> 
>     Feedback appreciated.
> 
> 
> 
>     > [    3.434849] ------------[ cut here ]------------
>     > [    3.434850] WARNING: CPU: 0 PID: 93 at kernel/irq/chip.c:210
>     irq_startup+0x10
>     > e/0x120
>     > [    3.434861] Modules linked in: virtio_net(E+) net_failover(E) failover
>     (E) vir
>     > tio_blk(E+) bochs(E+) drm_vram_helper(E) drm_ttm_helper(E) ttm(E) ahci
>     (E+) libah
>     > ci(E) virtio_pci(E) virtio_pci_legacy_dev(E) virtio_pci_modern_dev(E)
>     virtio(E)
>     > drm_kms_helper(E) cec(E) libata(E) crct10dif_pclmul(E) crct10dif_common
>     (E) crc32
>     > _pclmul(E) scsi_mod(E) i2c_i801(E) crc32c_intel(E) psmouse(E) i2c_smbus
>     (E) scsi_
>     > common(E) lpc_ich(E) virtio_ring(E) drm(E) button(E)
>     > [    3.434890] CPU: 0 PID: 93 Comm: systemd-udevd Tainted: G           
>     E     5.
>     > 17.0-rc7-00020-gea4424be1688 #63
>     > [    3.434893] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>     0.0.0 02
>     > /06/2015
>     > [    3.434897] RIP: 0010:irq_startup+0x10e/0x120
>     > [    3.434904] Code: c0 75 2b 4c 89 e7 31 d2 4c 89 ee e8 dc c5 ff ff 48
>     89 ef e8
>     >  94 fe ff ff 41 89 c4 e9 33 ff ff ff e8 e7 ca ff ff e9 50 ff ff ff <0f>
>     0b eb ac
>     >  0f 0b eb a8 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
>     > [    3.434906] RSP: 0018:ffff972c402bbbf0 EFLAGS: 00010002
>     > [    3.434908] RAX: 0000000000000004 RBX: 0000000000000001 RCX:
>     0000000000000040
>     > [    3.434912] RDX: 0000000000000000 RSI: ffffffffa768dee0 RDI:
>     ffff8bcf8ce34648
>     > [    3.434913] RBP: ffff8bcfb007a800 R08: 0000000000000004 R09:
>     ffffffffa74cb828
>     > [    3.434915] R10: 0000000000000000 R11: 0000000000000000 R12:
>     0000000000000001
>     > [    3.434916] R13: ffff8bcf8ce34648 R14: ffff8bcf8d185c70 R15:
>     0000000000000200
>     > [    3.434918] FS:  00007f5b3179f8c0(0000) GS:ffff8bcffbc00000(0000)
>     knlGS:00000
>     > 00000000000
>     > [    3.434919] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     > [    3.434921] CR2: 000055ca47bab6b8 CR3: 000000017bc40003 CR4:
>     0000000000170ef0
>     > [    3.434928] Call Trace:
>     > [    3.434936]  <TASK>
>     > [    3.434938]  enable_irq+0x48/0x90
>     > [    3.434943]  vp_enable_cbs+0x36/0x70 [virtio_pci]
>     > [    3.434948]  virtblk_probe+0x457/0x7dc [virtio_blk]
>     > [    3.434954]  virtio_dev_probe+0x1ae/0x280 [virtio]
>     > [    3.434959]  really_probe+0x1f5/0x3d0
>     > [    3.434966]  __driver_probe_device+0xfe/0x180
>     > [    3.434969]  driver_probe_device+0x1e/0x90
>     > [    3.434971]  __driver_attach+0xc0/0x1c0
>     > [    3.434974]  ? __device_attach_driver+0xe0/0xe0
>     > [    3.434976]  ? __device_attach_driver+0xe0/0xe0
>     > [    3.434978]  bus_for_each_dev+0x78/0xc0
>     > [    3.434982]  bus_add_driver+0x149/0x1e0
>     > [    3.434985]  driver_register+0x8b/0xe0
>     > [    3.434987]  ? 0xffffffffc01aa000
>     > [    3.434990]  init+0x52/0x1000 [virtio_blk]
>     > [    3.434994]  do_one_initcall+0x44/0x200
>     > [    3.435001]  ? kmem_cache_alloc_trace+0x300/0x400
>     > [    3.435006]  do_init_module+0x4c/0x260
>     > [    3.435013]  __do_sys_finit_module+0xb4/0x120
>     > [    3.435018]  do_syscall_64+0x3b/0xc0
>     > [    3.435027]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>     > [    3.435037] RIP: 0033:0x7f5b31c589b9
>     > [    3.435040] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
>     48 89 f8
>     >  48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48>
>     3d 01 f0
>     >  ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 01 48
>     > [    3.435042] RSP: 002b:00007ffc608fc198 EFLAGS: 00000246 ORIG_RAX:
>     00000000000
>     > 00139
>     > [    3.435045] RAX: ffffffffffffffda RBX: 000055ca47ba8700 RCX:
>     00007f5b31c589b9
>     > [    3.435046] RDX: 0000000000000000 RSI: 00007f5b31de3e2d RDI:
>     0000000000000005
>     > [    3.435048] RBP: 0000000000020000 R08: 0000000000000000 R09:
>     000055ca47ba9030
>     > [    3.435049] R10: 0000000000000005 R11: 0000000000000246 R12:
>     00007f5b31de3e2d
>     > [    3.435050] R13: 0000000000000000 R14: 000055ca47ba7060 R15:
>     000055ca47ba8700
>     > [    3.435053]  </TASK>
>     > [    3.435059] ---[ end trace 0000000000000000 ]---
>     > [    3.440593]  vda: vda1 vda2 vda3
>     > [    3.445283] scsi host0: Virtio SCSI HBA
>     > [    3.450373] scsi 0:0:0:0: CD-ROM            QEMU     QEMU CD-ROM     
>     2.5+ PQ
>     > : 0 ANSI: 5
>     >
>     > --
>     > Without deviation from the norm, progress is not possible.
> 
> 

