Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42ED24E4DF6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242581AbiCWISX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242617AbiCWIR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:17:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D4366D386
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648023386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vnuSgpHYe4+kaFzuDCRUytBvJ7SkYMJ/tCQLfbkYDOw=;
        b=FjEQewAM0uBoyQaClOkpbSdp3QKoOBB0mLO9vI8aOyTsyegPWVJ9UZp4XNBZqkWN4POVQE
        ++B/Ukz3JLMoOpR82G1Ej033Fnno4mjL1XFcYqkYYEzIgvGfuLLQtmYW5SHRDZ2mn7cHdX
        7ECb7xm4bUgnQf5cZbbuPKcfXJQloVo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-GZUV-1r1OPS5jywQciXBbA-1; Wed, 23 Mar 2022 04:16:25 -0400
X-MC-Unique: GZUV-1r1OPS5jywQciXBbA-1
Received: by mail-lj1-f200.google.com with SMTP id q5-20020a2e9145000000b002497bf0eaa1so297198ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:16:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vnuSgpHYe4+kaFzuDCRUytBvJ7SkYMJ/tCQLfbkYDOw=;
        b=7RCh5As0qDGRqKo3KZwmaouKR2l3djiWgju0pDG5hICRh+DaS4wfbqhIlOtRousIeC
         nkGVW0d+nQox7FaIUNNTTyqSNZjTw5fCuwCYzjE64H2eCouvty/5wGuX5znkZHOLi7bl
         Qz6L8uq9BOfQPkxXCeiC82quafTBP6AdzXjHjZqX4W1nHwG6bep95o2lOm4/BOpv8ZPd
         PgUAVA1iJyrWy2nfNkf7Nk209JrOhfphEBM7VIYOQK8751hoKpm/o/ciOHHj+ZHyC/Ka
         2mj2A+XxqdvLhWxsfG/eEzWOOAbTyi/qZZzf5KDpos7B7XpC7lN6x3G+K1DXQwpq4A1y
         pUDg==
X-Gm-Message-State: AOAM533OHndM9oGD4VCQai7U1gTOD0LIbpfz6ePhBDBibW0wW30SqucD
        /XTKWzmAwQtzv0+xaAFRfU4CAwCqxEDTwaKzp0BkNiWZv6gDd9AoyKmdE2fS3yQeezz9hkOYeLL
        sezDi05T1H4xrV9hYKAwEN5W8kHSGr6fErFTPt07E
X-Received: by 2002:a2e:54d:0:b0:249:8213:f970 with SMTP id 74-20020a2e054d000000b002498213f970mr11608112ljf.315.1648023383802;
        Wed, 23 Mar 2022 01:16:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxeecRAmB2VmOwb5nw++BO3YvxDg933DtJoEkzYqXR4btJkrva8lntOp+9O3PJt0+U7IJnYrj7sZWMvSePf6/Y=
X-Received: by 2002:a2e:54d:0:b0:249:8213:f970 with SMTP id
 74-20020a2e054d000000b002498213f970mr11608093ljf.315.1648023383515; Wed, 23
 Mar 2022 01:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220322114313.116516-1-sgarzare@redhat.com> <20220322100635-mutt-send-email-mst@kernel.org>
 <CACGkMEuUpFKTyqmRh2T7cnF=1hbz3T3_DiT_t8L9Pfs_g5yJmA@mail.gmail.com> <20220323080408.ogoedasrjiqbol4m@sgarzare-redhat>
In-Reply-To: <20220323080408.ogoedasrjiqbol4m@sgarzare-redhat>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 23 Mar 2022 16:16:12 +0800
Message-ID: <CACGkMEuGhvV_jVJY6k54gPABdeJO3+7gR+vUwjwFneqxzUdorg@mail.gmail.com>
Subject: Re: [PATCH] virtio: use virtio_device_ready() in virtio_device_restore()
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
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

On Wed, Mar 23, 2022 at 4:04 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Wed, Mar 23, 2022 at 11:10:27AM +0800, Jason Wang wrote:
> >On Tue, Mar 22, 2022 at 10:07 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >>
> >> On Tue, Mar 22, 2022 at 12:43:13PM +0100, Stefano Garzarella wrote:
> >> > After waking up a suspended VM, the kernel prints the following trace
> >> > for virtio drivers which do not directly call virtio_device_ready() in
> >> > the .restore:
> >> >
> >> >     PM: suspend exit
> >> >     irq 22: nobody cared (try booting with the "irqpoll" option)
> >> >     Call Trace:
> >> >      <IRQ>
> >> >      dump_stack_lvl+0x38/0x49
> >> >      dump_stack+0x10/0x12
> >> >      __report_bad_irq+0x3a/0xaf
> >> >      note_interrupt.cold+0xb/0x60
> >> >      handle_irq_event+0x71/0x80
> >> >      handle_fasteoi_irq+0x95/0x1e0
> >> >      __common_interrupt+0x6b/0x110
> >> >      common_interrupt+0x63/0xe0
> >> >      asm_common_interrupt+0x1e/0x40
> >> >      ? __do_softirq+0x75/0x2f3
> >> >      irq_exit_rcu+0x93/0xe0
> >> >      sysvec_apic_timer_interrupt+0xac/0xd0
> >> >      </IRQ>
> >> >      <TASK>
> >> >      asm_sysvec_apic_timer_interrupt+0x12/0x20
> >> >      arch_cpu_idle+0x12/0x20
> >> >      default_idle_call+0x39/0xf0
> >> >      do_idle+0x1b5/0x210
> >> >      cpu_startup_entry+0x20/0x30
> >> >      start_secondary+0xf3/0x100
> >> >      secondary_startup_64_no_verify+0xc3/0xcb
> >> >      </TASK>
> >> >     handlers:
> >> >     [<000000008f9bac49>] vp_interrupt
> >> >     [<000000008f9bac49>] vp_interrupt
> >> >     Disabling IRQ #22
> >> >
> >> > This happens because we don't invoke .enable_cbs callback in
> >> > virtio_device_restore(). That callback is used by some transports
> >> > (e.g. virtio-pci) to enable interrupts.
> >> >
> >> > Let's fix it, by calling virtio_device_ready() as we do in
> >> > virtio_dev_probe(). This function calls .enable_cts callback and sets
> >> > DRIVER_OK status bit.
> >> >
> >> > This fix also avoids setting DRIVER_OK twice for those drivers that
> >> > call virtio_device_ready() in the .restore.
> >> >
> >> > Fixes: d50497eb4e55 ("virtio_config: introduce a new .enable_cbs method")
> >> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> > ---
> >> >
> >> > I'm not sure about the fixes tag. That one is more generic, but the
> >> > following one I think introduced the issue.
> >> >
> >> > Fixes: 9e35276a5344 ("virtio_pci: harden MSI-X interrupts")
> >>
> >> Jason what should we do about this one BTW? Just revert? We have other
> >> issues ...
> >
> >Let me post a patch to revert it and give it a rework.
>
> Thanks for reverting it.
>
> Should we queue this patch anyway to prevent future issues and avoid
> setting DRIVER_OK twice?
>
> Please, let me know if I have to resend it by removing the call trace
> that after the revert should no longer occur.

I think we can have another version.

Thanks

>
> Thanks,
> Stefano
>

