Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E624B23AB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbiBKKsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:48:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245739AbiBKKsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:48:14 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBE5D56;
        Fri, 11 Feb 2022 02:48:12 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id m14so14444484wrg.12;
        Fri, 11 Feb 2022 02:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=bCUpXie1BjF5aw3zIaqGdHgYbe3cImW5CK/1os9UVP8=;
        b=U0RtXGn03HuAqI1zZNVc6wTuuwXNI9w4mWCRySDb5eFW89oTnzj+MmUgzWQWsu9yDz
         134gUuadTX6SCnqRu82HJSOdEyTIvfPR4npbbuADgbENiT5fzGmPX+CRJ3zVW7pivkmu
         egad/5qOWZEW01EEABEqSDsuMDxCtXhQsRdjrvWTkWto9cbrQwrhNpwf2ekrAmv4Y3oK
         Tu5gHvXPfZCKNn7I88O38/NQmgKsCtxi93m/rDsDuUtPmAQUi7Mtn6HU7KjINm2AAuJw
         LQQazbgj1kuCiRRqHvIJsEuG3iBR9fGOfZXKzQDPRp8xKHK57IqFWMPongB6c/Gy+AJg
         iEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bCUpXie1BjF5aw3zIaqGdHgYbe3cImW5CK/1os9UVP8=;
        b=5RQj6vLKixHme+ocvnWx0JomZFmNOIgSOuvWvlA6rLW66pGIvZCp7thrP5pLr1j92m
         0/cqKDX8WcW/cdt7hsjlWz6TWivUkXJse4jN9NmWwIHYXeSiNNHfxlp7GplfuQsTlQdK
         fxrE8WFdMKK59rByge3ZAFRvViQDp5VgoSviOOXr4QAeTVq50lIinZlNEjK/eaUaZJfn
         0Kxsac3j9qn+8SXWhSTxJg7cNjWDDzxqOXd4gE89itML0pwzjC+Sh5URU8/5oUQgxrDU
         1jA18eZvSv1f+0Mrq1i5/ynnLe/Zo5kKjxTS9p8knibz51Qu5uyzJMHih6GHWmGxfkVe
         BNDg==
X-Gm-Message-State: AOAM533AX5I1YjS/lL3vM8oM6wxsGV0jI+vtK9dqnRXn1BM2NSEoGXIQ
        fTyXOiY4ZksUGMmdgsuE5yQ=
X-Google-Smtp-Source: ABdhPJwOrDq3U69i6BYs7v4S+gIA9HGlNXWo6YcKSuVeDoKdatrErtKkBn9iDuShchuyMPYq26I53A==
X-Received: by 2002:a5d:4539:: with SMTP id j25mr934418wra.232.1644576491120;
        Fri, 11 Feb 2022 02:48:11 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id n29sm3660426wms.8.2022.02.11.02.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 02:48:10 -0800 (PST)
Date:   Fri, 11 Feb 2022 11:48:07 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     damien.lemoal@opensource.wdc.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com
Cc:     linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: DMA-API: tegra-ahci 70027000.sata: device driver maps memory from
 kernel text or rodata
Message-ID: <YgY+57iPSHo+YXHC@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I boot my tegra-jetson-tk1 with some debug enabled and I got:
[   46.232240] WARNING: CPU: 1 PID: 2144 at kernel/dma/debug.c:1073 check_for_illegal_area+0xec/0x180
[   46.232255] DMA-API: tegra-ahci 70027000.sata: device driver maps memory from kernel text or rodata [addr=3f4026ed] [len=4096]
[   46.232262] Modules linked in:
[   46.232271] CPU: 1 PID: 2144 Comm: containerd Not tainted 5.16.9-dirty #8
[   46.232277] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[   46.232283] [<c0110c24>] (unwind_backtrace) from [<c010b4d4>] (show_stack+0x10/0x14)
[   46.232294] [<c010b4d4>] (show_stack) from [<c0ce90b0>] (dump_stack_lvl+0x58/0x70)
[   46.232305] [<c0ce90b0>] (dump_stack_lvl) from [<c0124648>] (__warn+0xd0/0x134)
[   46.232314] [<c0124648>] (__warn) from [<c0ce2b00>] (warn_slowpath_fmt+0x90/0xb4)
[   46.232322] [<c0ce2b00>] (warn_slowpath_fmt) from [<c01cdcd8>] (check_for_illegal_area+0xec/0x180)
[   46.232330] [<c01cdcd8>] (check_for_illegal_area) from [<c01cfab4>] (debug_dma_map_sg+0xa4/0x424)
[   46.232340] [<c01cfab4>] (debug_dma_map_sg) from [<c01ca4d8>] (__dma_map_sg_attrs+0xc4/0x140)
[   46.232349] [<c01ca4d8>] (__dma_map_sg_attrs) from [<c01ca568>] (dma_map_sg_attrs+0x14/0x20)
[   46.232357] [<c01ca568>] (dma_map_sg_attrs) from [<c07cc408>] (ata_qc_issue+0x16c/0x414)
[   46.232366] [<c07cc408>] (ata_qc_issue) from [<c07d64f4>] (__ata_scsi_queuecmd+0x27c/0x4c4)
[   46.232376] [<c07d64f4>] (__ata_scsi_queuecmd) from [<c07d679c>] (ata_scsi_queuecmd+0x60/0x90)
[   46.232385] [<c07d679c>] (ata_scsi_queuecmd) from [<c07b36bc>] (scsi_queue_rq+0x440/0xb98)
[   46.232397] [<c07b36bc>] (scsi_queue_rq) from [<c05808fc>] (blk_mq_dispatch_rq_list+0x1d0/0x87c)
[   46.232406] [<c05808fc>] (blk_mq_dispatch_rq_list) from [<c0586628>] (__blk_mq_do_dispatch_sched+0x14c/0x2dc)
[   46.232415] [<c0586628>] (__blk_mq_do_dispatch_sched) from [<c0586b38>] (__blk_mq_sched_dispatch_requests+0x10c/0x168)
[   46.232423] [<c0586b38>] (__blk_mq_sched_dispatch_requests) from [<c0586c64>] (blk_mq_sched_dispatch_requests+0x34/0x5c)
[   46.232432] [<c0586c64>] (blk_mq_sched_dispatch_requests) from [<c057da8c>] (__blk_mq_run_hw_queue+0x5c/0xcc)
[   46.232442] [<c057da8c>] (__blk_mq_run_hw_queue) from [<c057dc9c>] (__blk_mq_delay_run_hw_queue+0x18c/0x1b4)
[   46.232451] [<c057dc9c>] (__blk_mq_delay_run_hw_queue) from [<c0586f80>] (blk_mq_sched_insert_requests+0xd0/0x320)
[   46.232460] [<c0586f80>] (blk_mq_sched_insert_requests) from [<c0581604>] (blk_mq_flush_plug_list+0x1c4/0x434)
[   46.232468] [<c0581604>] (blk_mq_flush_plug_list) from [<c0573d40>] (blk_flush_plug+0xd4/0x114)
[   46.232475] [<c0573d40>] (blk_flush_plug) from [<c0573f9c>] (blk_finish_plug+0x1c/0x28)
[   46.232482] [<c0573f9c>] (blk_finish_plug) from [<c0285740>] (read_pages+0x190/0x2bc)
[   46.232493] [<c0285740>] (read_pages) from [<c0285c1c>] (page_cache_ra_unbounded+0x164/0x230)
[   46.232501] [<c0285c1c>] (page_cache_ra_unbounded) from [<c027846c>] (filemap_fault+0x6d4/0xd04)
[   46.232509] [<c027846c>] (filemap_fault) from [<c02bacd0>] (__do_fault+0x38/0x104)
[   46.232519] [<c02bacd0>] (__do_fault) from [<c02c0920>] (handle_mm_fault+0xaa0/0xea8)
[   46.232528] [<c02c0920>] (handle_mm_fault) from [<c011563c>] (do_page_fault+0x15c/0x484)
[   46.232537] [<c011563c>] (do_page_fault) from [<c0115b2c>] (do_DataAbort+0x3c/0xb0)
[   46.232544] [<c0115b2c>] (do_DataAbort) from [<c0100e98>] (__dabt_usr+0x58/0x60)
[   46.232552] Exception stack(0xc6bc9fb0 to 0xc6bc9ff8)
[   46.232558] 9fa0:                                     00000001 bea726d8 014d40e0 01911fb8
[   46.232563] 9fc0: 00490000 0004cb15 00523858 006f6b68 00000000 b6f0c9c8 b6f0c9c8 bea72724
[   46.232569] 9fe0: 00000000 bea72678 b6ee2cbc b6ee41ec 200d0010 ffffffff
[   46.232573] irq event stamp: 15628
[   46.232577] hardirqs last  enabled at (15627): [<c01dba64>] ktime_get+0x1a4/0x1c8
[   46.232585] hardirqs last disabled at (15628): [<c0cfbfb0>] _raw_spin_lock_irqsave+0x68/0x6c
[   46.232594] softirqs last  enabled at (15332): [<c01015d8>] __do_softirq+0x328/0x590
[   46.232600] softirqs last disabled at (15327): [<c012cda8>] __irq_exit_rcu+0x128/0x1a8
[   46.232607] ---[ end trace 8655230c4b3626fb ]---

Regards
