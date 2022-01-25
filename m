Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D8749BC0A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 20:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiAYT0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 14:26:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229907AbiAYT0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 14:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643138788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I4oqhYaOJzCMND/PHbdluqZlT5cXmCHSNgWuLWdmml8=;
        b=aIYPcVMmAaA9C8g8WLCntgU8E7WCjSZPugTp8XGm4B+IclXmXZ8pLVReBvndbaBnuTO+PO
        w9udvENQ2LTuTcX4KJGw8oNAUgZWyHe8R7PQox54SnvSeJ6Km3jamguQykPdXtnk1bm3IE
        lkpi45bUttkfKddo/lDYG3vyOFGzhyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-7-OCr_ibQWPMa7Po-5trzdPg-1; Tue, 25 Jan 2022 14:26:26 -0500
X-MC-Unique: OCr_ibQWPMa7Po-5trzdPg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04512192D786;
        Tue, 25 Jan 2022 19:26:25 +0000 (UTC)
Received: from starship (unknown [10.40.192.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F69419C59;
        Tue, 25 Jan 2022 19:26:22 +0000 (UTC)
Message-ID: <6f0d9b07073ca6d3657500ec076edc1ad2a3e40a.camel@redhat.com>
Subject: Re: [PATCH 0/5] iommu/amd: fixes for suspend/resume
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Mike Lothian <mike@fireburn.co.uk>
Cc:     dwmw@amazon.co.uk, iommu@lists.linux-foundation.org,
        joro@8bytes.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, tglx@linutronix.de, will@kernel.org
Date:   Tue, 25 Jan 2022 21:26:21 +0200
In-Reply-To: <20220125150832.1570-1-mike@fireburn.co.uk>
References: <20211123161038.48009-1-mlevitsk@redhat.com>
         <20220125150832.1570-1-mike@fireburn.co.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-25 at 15:08 +0000, Mike Lothian wrote:
> Hi
> 
> I'm seeing a WARNING that I think might be related to these patches, unfortunately another issue is making bisecting difficult
> 
> [    0.359362] AMD-Vi: X2APIC enabled
> [    0.395140] ------------[ cut here ]------------
> [    0.395142] WARNING: CPU: 0 PID: 1 at amd_iommu_enable_interrupts+0x1da/0x440
> [    0.395146] Modules linked in:
> [    0.395148] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc1-tip+ #2995
> [    0.395150] Hardware name: ASUSTeK COMPUTER INC. ROG Strix G513QY_G513QY/G513QY, BIOS G513QY.316 11/29/2021
> [    0.395152] RIP: 0010:amd_iommu_enable_interrupts+0x1da/0x440
> [    0.395154] Code: 4b 38 48 89 41 18 b8 a0 86 01 00 0f 1f 44 00 00 48 8b 4b 38 8b 89 20 20 00 00 f7 c1 00 01 00 00 0f 85 7a fe ff ff ff c8 75 e6 <0f> 0b e9 6f fe ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
> [    0.395157] RSP: 0018:ffff88810022fc68 EFLAGS: 00010246
> [    0.395158] RAX: 0000000000000000 RBX: ffff88810004b000 RCX: 0000000000000018
> [    0.395160] RDX: 0000000000000008 RSI: ffff88810022fc70 RDI: ffffc900000800f0
> [    0.395161] RBP: ffff88810022fc68 R08: ffff888100fce088 R09: 0000000000000000
> [    0.395162] R10: 0000000000000000 R11: ffffffffffffffff R12: ffffffff7fffffff
> [    0.395163] R13: 0000777f80000000 R14: 0000000000000000 R15: ffffffff8357c9e8
> [    0.395165] FS:  0000000000000000(0000) GS:ffff888fde400000(0000) knlGS:0000000000000000
> [    0.395166] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.395167] CR2: ffff88901e1ff000 CR3: 00000000b440c000 CR4: 0000000000150ef0
> [    0.395169] Call Trace:
> [    0.395170]  <TASK>
> [    0.395171]  ? iommu_setup+0x29a/0x29a
> [    0.395174]  ? state_next+0x6e/0x1c9
> [    0.395177]  ? iommu_setup+0x29a/0x29a
> [    0.395178]  ? iommu_go_to_state+0x1f/0x33
> [    0.395180]  ? amd_iommu_init+0xa/0x23
> [    0.395182]  ? pci_iommu_init+0xf/0x45
> [    0.395183]  ? iommu_setup+0x29a/0x29a
> [    0.395184]  ? __initstub__kmod_pci_dma__250_136_pci_iommu_initrootfs+0x5/0x8
> [    0.395186]  ? do_one_initcall+0x100/0x290
> [    0.395190]  ? do_initcall_level+0x8b/0xe5
> [    0.395192]  ? do_initcalls+0x44/0x6d
> [    0.395194]  ? kernel_init_freeable+0xc7/0x10d
> [    0.395196]  ? rest_init+0xc0/0xc0
> [    0.395198]  ? kernel_init+0x11/0x150
> [    0.395200]  ? ret_from_fork+0x22/0x30
> [    0.395201]  </TASK>
> [    0.395202] ---[ end trace 0000000000000000 ]---
> [    0.395204] PCI-DMA: Using software bounce buffer
> 
> Let me know if you need any more info
> 
> Cheers
> 
> Mike


Could you just apply these patches on top of 5.15 kernel and see if you get the warning?

If something could case it is I think patch 1, it does move the GA log enabled
to be a bit later.
I also added few warnings there. I wonder why your dmesg quote doesn't contain the C line
where the warning happens.

In partucular I added:

if (WARN_ON(status & (MMIO_STATUS_GALOG_RUN_MASK)))

That will fire if GA log is already running (maybe BIOS enabled it? - it really shouldn't do that)


And that:

if (WARN_ON(i >= LOOP_TIMEOUT))

also should not happen and worth to be logged IMHO.

Best regards,
	Maxim Levitsky



