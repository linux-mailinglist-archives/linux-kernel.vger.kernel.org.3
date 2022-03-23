Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721DA4E4B44
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 04:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbiCWDMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 23:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiCWDMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 23:12:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DFEC70902
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 20:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648005041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oGgo2QAozxKREy7KkTi56vaqwR7d3TFN694TEyxqgzw=;
        b=IbjZ2AEfx/JDT0e7XEyZwxp2o/iLKQ36d1nueCSLOL/4mwbmDVhIz2Sj7+/oJYVJ9/EsEP
        FuULSxq+LddPvHQ3Asjl1NFEGWNFAenbfTPPXZKx1V5QhmqNNjfcZabsSM0+namRAxMTff
        to4xiqO4LpbZHYXOLSO+DAFu3+I7WrY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-IFcowEbSNRaXhIKAOUGS4Q-1; Tue, 22 Mar 2022 23:10:39 -0400
X-MC-Unique: IFcowEbSNRaXhIKAOUGS4Q-1
Received: by mail-lf1-f70.google.com with SMTP id w25-20020a0565120b1900b004489048b5d9so133718lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 20:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oGgo2QAozxKREy7KkTi56vaqwR7d3TFN694TEyxqgzw=;
        b=7/72i0D3E/YheDne/mfL0c9zo3zlMIYEJq7tTqUTpG2VXOK1Y2kQpDwcqiEXQC1lGt
         34fRQxcbdmjXORJIxMuXFU8KH4XgFe5UIgfUAowKpSo29ngkEEswpCUOqQ7mrYH2INj9
         jOMeOw66cTCX14I/MSJz2ErM2bsk6tdyTunbET6fNfJ2fB8eUsFDyS+PrgLY8tbSK2K4
         LSD6/ly2qFPrLuR+cjPurknAbZyavKR83dNIZjm6pUsdHAcrbLr0dZaFe6DcYMNKtL96
         1r7nKZP+IZsjUQGcXKkfPhjlXUR2saixiG1myVA6inzu8KrePtoCd2rjw24WdkCCK6rH
         I2mw==
X-Gm-Message-State: AOAM533Wuwj3bkJZzOAD+QAOy9CNPpdY8v1D68ILPIjMSAPDt1k7COTg
        mjSgnSnRe/dGjzd/aGNqv+yR77PG42/dzQRgcHw5jxoM+Jw2+pL8l8QwVncb6ISni47bTGbWdL7
        Z+k0dJdSwNAxifao00SuOBMYvxQYXOEE1xMnlcWfS
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id b1-20020a0565120b8100b00448b342513cmr20337156lfv.257.1648005038327;
        Tue, 22 Mar 2022 20:10:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxiqwJ/kbpPgsK45vw/El7oQ7v37X0Q2cKgv7r1FOUy5FXu/SiMPslSTD1xQjyEymdBzlAsxwuQghtxfpQChsg=
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr20337143lfv.257.1648005038112; Tue, 22
 Mar 2022 20:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220322114313.116516-1-sgarzare@redhat.com> <20220322100635-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220322100635-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 23 Mar 2022 11:10:27 +0800
Message-ID: <CACGkMEuUpFKTyqmRh2T7cnF=1hbz3T3_DiT_t8L9Pfs_g5yJmA@mail.gmail.com>
Subject: Re: [PATCH] virtio: use virtio_device_ready() in virtio_device_restore()
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Parav Pandit <parav@nvidia.com>
Cc:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 10:07 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Mar 22, 2022 at 12:43:13PM +0100, Stefano Garzarella wrote:
> > After waking up a suspended VM, the kernel prints the following trace
> > for virtio drivers which do not directly call virtio_device_ready() in
> > the .restore:
> >
> >     PM: suspend exit
> >     irq 22: nobody cared (try booting with the "irqpoll" option)
> >     Call Trace:
> >      <IRQ>
> >      dump_stack_lvl+0x38/0x49
> >      dump_stack+0x10/0x12
> >      __report_bad_irq+0x3a/0xaf
> >      note_interrupt.cold+0xb/0x60
> >      handle_irq_event+0x71/0x80
> >      handle_fasteoi_irq+0x95/0x1e0
> >      __common_interrupt+0x6b/0x110
> >      common_interrupt+0x63/0xe0
> >      asm_common_interrupt+0x1e/0x40
> >      ? __do_softirq+0x75/0x2f3
> >      irq_exit_rcu+0x93/0xe0
> >      sysvec_apic_timer_interrupt+0xac/0xd0
> >      </IRQ>
> >      <TASK>
> >      asm_sysvec_apic_timer_interrupt+0x12/0x20
> >      arch_cpu_idle+0x12/0x20
> >      default_idle_call+0x39/0xf0
> >      do_idle+0x1b5/0x210
> >      cpu_startup_entry+0x20/0x30
> >      start_secondary+0xf3/0x100
> >      secondary_startup_64_no_verify+0xc3/0xcb
> >      </TASK>
> >     handlers:
> >     [<000000008f9bac49>] vp_interrupt
> >     [<000000008f9bac49>] vp_interrupt
> >     Disabling IRQ #22
> >
> > This happens because we don't invoke .enable_cbs callback in
> > virtio_device_restore(). That callback is used by some transports
> > (e.g. virtio-pci) to enable interrupts.
> >
> > Let's fix it, by calling virtio_device_ready() as we do in
> > virtio_dev_probe(). This function calls .enable_cts callback and sets
> > DRIVER_OK status bit.
> >
> > This fix also avoids setting DRIVER_OK twice for those drivers that
> > call virtio_device_ready() in the .restore.
> >
> > Fixes: d50497eb4e55 ("virtio_config: introduce a new .enable_cbs method")
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >
> > I'm not sure about the fixes tag. That one is more generic, but the
> > following one I think introduced the issue.
> >
> > Fixes: 9e35276a5344 ("virtio_pci: harden MSI-X interrupts")
>
> Jason what should we do about this one BTW? Just revert? We have other
> issues ...

Let me post a patch to revert it and give it a rework.

Thanks

>
>
> > Thanks,
> > Stefano
> > ---
> >  drivers/virtio/virtio.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index 22f15f444f75..75c8d560bbd3 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -526,8 +526,9 @@ int virtio_device_restore(struct virtio_device *dev)
> >                       goto err;
> >       }
> >
> > -     /* Finally, tell the device we're all set */
> > -     virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
> > +     /* If restore didn't do it, mark device DRIVER_OK ourselves. */
> > +     if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
> > +             virtio_device_ready(dev);
> >
> >       virtio_config_enable(dev);
> >
> > --
> > 2.35.1
>

