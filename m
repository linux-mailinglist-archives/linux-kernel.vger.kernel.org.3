Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFA84E4DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242423AbiCWIFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242409AbiCWIFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A99D70F78
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648022657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cePn2HPJ3CtBPN5ynUkfrIKVQlGOlqRorjeDVtC/Lcs=;
        b=Y/gV590eC7jk89r+bJbjvNVxeqsP/NoC/AJnq7KEfHPw4rHN6pen0eF6Q+FoyOiiqpjCQj
        13Sfl33zMf0Mn8uSwvQebCfHrsSvCN1HPgb/wycL5fZESjnf0lJu5rLODSDLkxxtJTCrMk
        Mc78wyEzjsNrRSIl6k7yjS+vWF4bRFk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-nUPBJ8yUMs-Q5aZYuMJA9g-1; Wed, 23 Mar 2022 04:04:15 -0400
X-MC-Unique: nUPBJ8yUMs-Q5aZYuMJA9g-1
Received: by mail-qt1-f198.google.com with SMTP id y23-20020ac85257000000b002e06697f2ebso599836qtn.16
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cePn2HPJ3CtBPN5ynUkfrIKVQlGOlqRorjeDVtC/Lcs=;
        b=g2crfDtmF/nNZzxU5DQwQCP8y8neKIAi1qxHDXso1zU0v99l0MP4WKSs0Q6LjammNl
         UGWFVjgrM/8WgsivClSfQjb+4KVNsTGS2371vwH3IdvVcZ4Gr7dOhnKEK8sBaiNJizRz
         xkbpf/vUFkord1CqeFbCdSBdUaJOl1iYg7e1wmPUsXs1mI5kFvY/8NC5FhR0PM6sMS9/
         wkAa/010cK8FrC8PQHnX5/2+ZY5sSM3ZXIMYbCdB0k/gVe4y64ADORa3g9nVb6LDyGHP
         UUNViO7lmZf1MH/mg6dl8gEpvmHFKuaIESQ3cr3zfm1vgP+A5gbIYsk4/3+dTCwVytuK
         bvoQ==
X-Gm-Message-State: AOAM533MTSQNLG9YzgsXRUG+0lHXoYisWBjzSCtg3lsnDFQmgPsv2x1v
        QoZUopMfv5/VuJF95ZKmN3IylYYgFOxjlz1ee8clVDnTlYBu028eyIxLMnHNJ7zR4DfFkXPMEkm
        tvCDPvTmg67t8nRaFhMcH9yKh
X-Received: by 2002:a05:620a:150e:b0:67d:3243:12dd with SMTP id i14-20020a05620a150e00b0067d324312ddmr17782267qkk.229.1648022655089;
        Wed, 23 Mar 2022 01:04:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxO1+nfH+Nu1xL1m12zS/Ds8sfGdKU0u5Nq1/xW6f1tEz+ILQzmDYkM4kKd0qQ0sC/hqLtTQg==
X-Received: by 2002:a05:620a:150e:b0:67d:3243:12dd with SMTP id i14-20020a05620a150e00b0067d324312ddmr17782255qkk.229.1648022654824;
        Wed, 23 Mar 2022 01:04:14 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-114.business.telecomitalia.it. [87.12.25.114])
        by smtp.gmail.com with ESMTPSA id d13-20020a05622a15cd00b002e1df990d01sm15984553qty.71.2022.03.23.01.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 01:04:14 -0700 (PDT)
Date:   Wed, 23 Mar 2022 09:04:08 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio: use virtio_device_ready() in
 virtio_device_restore()
Message-ID: <20220323080408.ogoedasrjiqbol4m@sgarzare-redhat>
References: <20220322114313.116516-1-sgarzare@redhat.com>
 <20220322100635-mutt-send-email-mst@kernel.org>
 <CACGkMEuUpFKTyqmRh2T7cnF=1hbz3T3_DiT_t8L9Pfs_g5yJmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACGkMEuUpFKTyqmRh2T7cnF=1hbz3T3_DiT_t8L9Pfs_g5yJmA@mail.gmail.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 11:10:27AM +0800, Jason Wang wrote:
>On Tue, Mar 22, 2022 at 10:07 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Tue, Mar 22, 2022 at 12:43:13PM +0100, Stefano Garzarella wrote:
>> > After waking up a suspended VM, the kernel prints the following trace
>> > for virtio drivers which do not directly call virtio_device_ready() in
>> > the .restore:
>> >
>> >     PM: suspend exit
>> >     irq 22: nobody cared (try booting with the "irqpoll" option)
>> >     Call Trace:
>> >      <IRQ>
>> >      dump_stack_lvl+0x38/0x49
>> >      dump_stack+0x10/0x12
>> >      __report_bad_irq+0x3a/0xaf
>> >      note_interrupt.cold+0xb/0x60
>> >      handle_irq_event+0x71/0x80
>> >      handle_fasteoi_irq+0x95/0x1e0
>> >      __common_interrupt+0x6b/0x110
>> >      common_interrupt+0x63/0xe0
>> >      asm_common_interrupt+0x1e/0x40
>> >      ? __do_softirq+0x75/0x2f3
>> >      irq_exit_rcu+0x93/0xe0
>> >      sysvec_apic_timer_interrupt+0xac/0xd0
>> >      </IRQ>
>> >      <TASK>
>> >      asm_sysvec_apic_timer_interrupt+0x12/0x20
>> >      arch_cpu_idle+0x12/0x20
>> >      default_idle_call+0x39/0xf0
>> >      do_idle+0x1b5/0x210
>> >      cpu_startup_entry+0x20/0x30
>> >      start_secondary+0xf3/0x100
>> >      secondary_startup_64_no_verify+0xc3/0xcb
>> >      </TASK>
>> >     handlers:
>> >     [<000000008f9bac49>] vp_interrupt
>> >     [<000000008f9bac49>] vp_interrupt
>> >     Disabling IRQ #22
>> >
>> > This happens because we don't invoke .enable_cbs callback in
>> > virtio_device_restore(). That callback is used by some transports
>> > (e.g. virtio-pci) to enable interrupts.
>> >
>> > Let's fix it, by calling virtio_device_ready() as we do in
>> > virtio_dev_probe(). This function calls .enable_cts callback and sets
>> > DRIVER_OK status bit.
>> >
>> > This fix also avoids setting DRIVER_OK twice for those drivers that
>> > call virtio_device_ready() in the .restore.
>> >
>> > Fixes: d50497eb4e55 ("virtio_config: introduce a new .enable_cbs method")
>> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > ---
>> >
>> > I'm not sure about the fixes tag. That one is more generic, but the
>> > following one I think introduced the issue.
>> >
>> > Fixes: 9e35276a5344 ("virtio_pci: harden MSI-X interrupts")
>>
>> Jason what should we do about this one BTW? Just revert? We have other
>> issues ...
>
>Let me post a patch to revert it and give it a rework.

Thanks for reverting it.

Should we queue this patch anyway to prevent future issues and avoid 
setting DRIVER_OK twice?

Please, let me know if I have to resend it by removing the call trace 
that after the revert should no longer occur.

Thanks,
Stefano

