Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFF049B74C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581640AbiAYPLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581543AbiAYPIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:08:37 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42EEC06173E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 07:08:35 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n8so25546127wmk.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 07:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c0h+YN3WZ8oQh9kE3wDALdghjswXTmmA4zejnT27K50=;
        b=BxF2jD/gwk5n+uxdwkibC69S3bbAdsUYjb60OvC0MGZcwMR0slys4RJ3ITONTZE0l7
         G9QVEKMqefxo+drC29/13e7+CTE/hHnizaLW2Mg7UVAq04ND+p7LfHcS5Ku/x666oHPT
         LGd7IhyOrHX4supz9d8B7lufphNH7CItAEH0ttPMx78+FwOjbh5Iamo/5RTq9xTpiHVB
         epOCjA/OSBtkMWzq89PV+dH4JXMuzn72v/iFxquM2HXgj/m6SFMqNfWMQgxLv148N6k+
         OQ7CPh3Th+FZ8SXNZCs5yUEpgvWyKWICGUmsZYwCwrysbLg6O34IVQWU63M5oxKFewwO
         7UbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c0h+YN3WZ8oQh9kE3wDALdghjswXTmmA4zejnT27K50=;
        b=vSXoVsFwgDC/pYN/Gk9wRtvTiNcR7pg0CEe7+tHM/ddlLLajjEHW7BeBW2jIaylOY/
         xVR4WWD5zsjPJfgchrlzHmObBu4KjMyVlziAQCuGRuXGzh9TmUytU2BGcza/bOWbXzf+
         H/g2TQ3atocUQgiDycdUQN/zCF63JTJvjF80hbvfSFCEt9Zq+vZLtYoTAske087xMmJ9
         37g53XwJY7v0pr7gKFulZwvosuXQ01PiWwetxFuJ/L/OLO/Hpb9E5eN2NBqRLlq9g3ZC
         SEoKNR+Zx1+Gsi1rmZLgI4UiSIp3FlG4jyGNSQkH4aRXz8Z+R88FmqplG33oWXMKNpDX
         JYvQ==
X-Gm-Message-State: AOAM531GysWLXgGgHaackP4ZAkCyGGnauXstMnvOuVMpTMZ7/RbeT5oj
        teL8naT7+Op5+lc6U3LqWKZuZ+lhn5yKKMAy
X-Google-Smtp-Source: ABdhPJzQ0CBgzIskgvTyEcBm/E90Y3KutqvpAUmc5uI1NwV1BBCRTek9m7YPaA7cG+qCyIhTn9Spmw==
X-Received: by 2002:a1c:f205:: with SMTP id s5mr3407619wmc.33.1643123314267;
        Tue, 25 Jan 2022 07:08:34 -0800 (PST)
Received: from axion.fireburn.co.uk.lan ([2a01:4b00:f40e:900::64c])
        by smtp.gmail.com with ESMTPSA id r8sm17334224wrx.2.2022.01.25.07.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 07:08:33 -0800 (PST)
From:   Mike Lothian <mike@fireburn.co.uk>
To:     mlevitsk@redhat.com
Cc:     dwmw@amazon.co.uk, iommu@lists.linux-foundation.org,
        joro@8bytes.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, tglx@linutronix.de, will@kernel.org
Subject: Re: [PATCH 0/5] iommu/amd: fixes for suspend/resume
Date:   Tue, 25 Jan 2022 15:08:32 +0000
Message-Id: <20220125150832.1570-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20211123161038.48009-1-mlevitsk@redhat.com>
References: <20211123161038.48009-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm seeing a WARNING that I think might be related to these patches, unfortunately another issue is making bisecting difficult

[    0.359362] AMD-Vi: X2APIC enabled
[    0.395140] ------------[ cut here ]------------
[    0.395142] WARNING: CPU: 0 PID: 1 at amd_iommu_enable_interrupts+0x1da/0x440
[    0.395146] Modules linked in:
[    0.395148] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc1-tip+ #2995
[    0.395150] Hardware name: ASUSTeK COMPUTER INC. ROG Strix G513QY_G513QY/G513QY, BIOS G513QY.316 11/29/2021
[    0.395152] RIP: 0010:amd_iommu_enable_interrupts+0x1da/0x440
[    0.395154] Code: 4b 38 48 89 41 18 b8 a0 86 01 00 0f 1f 44 00 00 48 8b 4b 38 8b 89 20 20 00 00 f7 c1 00 01 00 00 0f 85 7a fe ff ff ff c8 75 e6 <0f> 0b e9 6f fe ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
[    0.395157] RSP: 0018:ffff88810022fc68 EFLAGS: 00010246
[    0.395158] RAX: 0000000000000000 RBX: ffff88810004b000 RCX: 0000000000000018
[    0.395160] RDX: 0000000000000008 RSI: ffff88810022fc70 RDI: ffffc900000800f0
[    0.395161] RBP: ffff88810022fc68 R08: ffff888100fce088 R09: 0000000000000000
[    0.395162] R10: 0000000000000000 R11: ffffffffffffffff R12: ffffffff7fffffff
[    0.395163] R13: 0000777f80000000 R14: 0000000000000000 R15: ffffffff8357c9e8
[    0.395165] FS:  0000000000000000(0000) GS:ffff888fde400000(0000) knlGS:0000000000000000
[    0.395166] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.395167] CR2: ffff88901e1ff000 CR3: 00000000b440c000 CR4: 0000000000150ef0
[    0.395169] Call Trace:
[    0.395170]  <TASK>
[    0.395171]  ? iommu_setup+0x29a/0x29a
[    0.395174]  ? state_next+0x6e/0x1c9
[    0.395177]  ? iommu_setup+0x29a/0x29a
[    0.395178]  ? iommu_go_to_state+0x1f/0x33
[    0.395180]  ? amd_iommu_init+0xa/0x23
[    0.395182]  ? pci_iommu_init+0xf/0x45
[    0.395183]  ? iommu_setup+0x29a/0x29a
[    0.395184]  ? __initstub__kmod_pci_dma__250_136_pci_iommu_initrootfs+0x5/0x8
[    0.395186]  ? do_one_initcall+0x100/0x290
[    0.395190]  ? do_initcall_level+0x8b/0xe5
[    0.395192]  ? do_initcalls+0x44/0x6d
[    0.395194]  ? kernel_init_freeable+0xc7/0x10d
[    0.395196]  ? rest_init+0xc0/0xc0
[    0.395198]  ? kernel_init+0x11/0x150
[    0.395200]  ? ret_from_fork+0x22/0x30
[    0.395201]  </TASK>
[    0.395202] ---[ end trace 0000000000000000 ]---
[    0.395204] PCI-DMA: Using software bounce buffer

Let me know if you need any more info

Cheers

Mike
