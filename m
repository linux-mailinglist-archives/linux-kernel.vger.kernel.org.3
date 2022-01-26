Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F5F49C45D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 08:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbiAZHez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 02:34:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53319 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229665AbiAZHey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 02:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643182493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N/qUgEiGIVOkvJ8elRfl1xMuKai6mJI9yF8F1bcLYAQ=;
        b=DoMqiPeh6xD5tCSkdGXQI/FyBCRPdcvO27i6oFuEvQEr1vLUDBYqWNDU8isylw+DsIQbYR
        qFijSjZ3B6gurffnThnrKsg4hhj5tpLDnEyf5QaxcK6vBYkauOznUbnw6IP+p1l6UmqpNQ
        WL++MYin7qNFgiOMe/PTNbXzf/u2+zk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-39q-7M3MMv-kNksOUJuQiA-1; Wed, 26 Jan 2022 02:34:48 -0500
X-MC-Unique: 39q-7M3MMv-kNksOUJuQiA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A889983DD22;
        Wed, 26 Jan 2022 07:34:46 +0000 (UTC)
Received: from starship (unknown [10.40.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C4014E2DD;
        Wed, 26 Jan 2022 07:34:44 +0000 (UTC)
Message-ID: <7809c3253a997330102b9d779206312d6b3bcaf1.camel@redhat.com>
Subject: Re: [PATCH 0/5] iommu/amd: fixes for suspend/resume
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Mike Lothian <mike@fireburn.co.uk>
Cc:     dwmw@amazon.co.uk, iommu@lists.linux-foundation.org,
        joro@8bytes.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, tglx@linutronix.de, will@kernel.org
Date:   Wed, 26 Jan 2022 09:34:43 +0200
In-Reply-To: <CAHbf0-FJ0c1yAumKCnXLKKFN=tzeJxSd3HyP=dUOBgBTxVG5fw@mail.gmail.com>
References: <20211123161038.48009-1-mlevitsk@redhat.com>
         <20220125150832.1570-1-mike@fireburn.co.uk>
         <6f0d9b07073ca6d3657500ec076edc1ad2a3e40a.camel@redhat.com>
         <CAHbf0-FJ0c1yAumKCnXLKKFN=tzeJxSd3HyP=dUOBgBTxVG5fw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-25 at 23:25 +0000, Mike Lothian wrote:
> On Tue, 25 Jan 2022 at 19:26, Maxim Levitsky <mlevitsk@redhat.com> wrote:
> > Could you just apply these patches on top of 5.15 kernel and see if you get the warning?
> > 
> > If something could case it is I think patch 1, it does move the GA log enabled
> > to be a bit later.
> > I also added few warnings there. I wonder why your dmesg quote doesn't contain the C line
> > where the warning happens.
> > 
> > In partucular I added:
> > 
> > if (WARN_ON(status & (MMIO_STATUS_GALOG_RUN_MASK)))
> > 
> > That will fire if GA log is already running (maybe BIOS enabled it? - it really shouldn't do that)
> > 
> > 
> > And that:
> > 
> > if (WARN_ON(i >= LOOP_TIMEOUT))
> > 
> > also should not happen and worth to be logged IMHO.
> > 
> > Best regards,
> >         Maxim Levitsky
> > 
> 
> Hi
> 
> I applied on top of another kernel as you asked, I also enabled some debugging
> 
> [    0.398833] ------------[ cut here ]------------
> [    0.398835] WARNING: CPU: 0 PID: 1 at drivers/iommu/amd/init.c:839
> amd_iommu_enable_interrupts+0x1da/0x440
> [    0.398840] Modules linked in:
> [    0.398841] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0-rc5-agd5f+ #1388
> [    0.398843] Hardware name: ASUSTeK COMPUTER INC. ROG Strix
> G513QY_G513QY/G513QY, BIOS G513QY.316 11/29/2021
> [    0.398845] RIP: 0010:amd_iommu_enable_interrupts+0x1da/0x440
> [    0.398847] Code: 4b 38 48 89 41 18 b8 a0 86 01 00 0f 1f 44 00 00
> 48 8b 4b 38 8b 89 20 20 00 00 f7 c1 00 01 00 00 0f 85 7a fe ff ff ff
> c8 75 e6 <0f> 0b e9 6f fe ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44
> 0
> 0 00
> [    0.398850] RSP: 0018:ffff888100927c68 EFLAGS: 00010246
> [    0.398851] RAX: 0000000000000000 RBX: ffff88810004b000 RCX: 0000000000000018
> [    0.398853] RDX: 0000000000000008 RSI: ffff888100927c70 RDI: ffffc900000800f0
> [    0.398854] RBP: ffff888100927c68 R08: ffff8881015b8f88 R09: 0000000000000000
> [    0.398855] R10: 0000000000000000 R11: ffffffffffffffff R12: ffffffff7fffffff
> [    0.398856] R13: 0000777f80000000 R14: 0000000000000000 R15: ffffffff8357a758
> [    0.398858] FS:  0000000000000000(0000) GS:ffff888fde400000(0000)
> knlGS:0000000000000000
> [    0.398859] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.398860] CR2: 0000000000000000 CR3: 00000000ac40c000 CR4: 0000000000150ef0
> [    0.398862] Call Trace:
> [    0.398864]  <TASK>
> [    0.398864]  ? iommu_setup+0x29a/0x29a
> [    0.398867]  ? state_next+0x6e/0x1c9
> [    0.398870]  ? iommu_setup+0x29a/0x29a
> [    0.398872]  ? iommu_go_to_state+0x1f/0x33
> [    0.398873]  ? amd_iommu_init+0xa/0x23
> [    0.398875]  ? pci_iommu_init+0xf/0x45
> [    0.398876]  ? iommu_setup+0x29a/0x29a
> [    0.398878]  ? __initstub__kmod_pci_dma__244_136_pci_iommu_initrootfs+0x5/0x8
> [    0.398880]  ? do_one_initcall+0x100/0x290
> [    0.398882]  ? do_initcall_level+0x8b/0xe5
> [    0.398884]  ? do_initcalls+0x44/0x6d
> [    0.398885]  ? kernel_init_freeable+0xc7/0x10d
> [    0.398886]  ? rest_init+0xc0/0xc0
> [    0.398888]  ? kernel_init+0x11/0x150
> [    0.398889]  ? ret_from_fork+0x22/0x30
> [    0.398891]  </TASK>
> [    0.398892] ---[ end trace f048a4ec907dc976 ]---
> 
> Which points to patch one and "if (WARN_ON(i >= LOOP_TIMEOUT))"


Could you post the whole dmesg, or at least:

dmesg | grep AMD-Vi


What CPU does your system have?

I suspect that your system doesn't GA log feature enabled in the IOMMU, and the code never checks
for that, and here it fails enabling it, which  before my patches was just
ignoring it silently.


Best regards,
	Maxim Levitsky
> 
> Hope that helps
> 
> Mike
> 


