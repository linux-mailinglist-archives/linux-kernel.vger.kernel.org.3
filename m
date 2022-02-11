Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CA24B260B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347793AbiBKMmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:42:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238205AbiBKMm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:42:28 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258951A4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 04:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644583347; x=1676119347;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HIsmyyzxnOL+9tGfKWdV0u2iF9CQusQW1c1Ow4acMmI=;
  b=oWSt2FvWInbJOWZyx8m6FBfDtbubtPo0kkcTI0fr9s5IQn2sd87iz34p
   WfR+KGKuIBd7MlH7mZ3rMYUr2LvDoBSg0FKGyru8n92woL4ChdmY+7QBO
   6r6hvVbnx0aus/QL7GqxIClESanqAcSmBm2jr+tWmYxd5IOsOD1SdD1SZ
   dhvlyXFK+VsOHcHQiizEF1hBCkeeJGlaYnCNKjRoMKuWE5k/L5LU66sYS
   hpJx7uG3cXPL/Omly711OuVMt1xNBOuV5w9Mr5K8J1zPANl1Ra1D6fcwI
   qEHerFfTsoFdHw5lYH0N1KtAgTwzN6I8nqRIaNY18MqB11IjdpyPL/3AR
   w==;
X-IronPort-AV: E=Sophos;i="5.88,360,1635177600"; 
   d="scan'208";a="304599334"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2022 20:42:26 +0800
IronPort-SDR: LQxj5oI8mx0/X8Cr0MeCtf3E4IPS4uxKR6xzYU8YT0cxbO9uqCXOe7SBrFOyd4B8qbz2A+MVf7
 TDRPhT3lOIl8/LvniO+K1BK1VfZMbRRg//Paeju7HoKyWaYUtiYR2mdcoPo/lNx+AlmNE/HykV
 KgyivN0Qy4H30Ogqxm46YJIncSMY/zoCe4rPuwzrINIv7qlhDmCFywvyMj7Eapn1m3PXxfz9gu
 Ssejq5QjC9tu/43oRz6mlVl+6V4x0VReDu9MurXglfkDR5ncHaXZ5W8qWsVmcO8drDXd69pBiu
 d4Woulfg0ud7iTms/1Te6Mu+
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 04:14:13 -0800
IronPort-SDR: f7oeJ7J/vtkQy9F6+28n1C3QCmagkzqkU7wMmFhVfI0RaUUdl7sVSKVqbLjqD+uiyM9/1E8mCA
 gDde6p1hnfMZD8kAd72gbLUlo1HeCoLwz14W65PAsO1yAQvJAscjZtkedma2guCCH+QaFq2Cm8
 cCDhl9ryAkbpCFuuFILG+oP8J1SoTjVFa1Jyl9/Pks7sOhtsorp9x1+zUMkcd3NvVRmi8uVN+3
 93Ya4cpGR9wL6ob9zsknrg9Q3KyiWrBq5EhDVlhmZcQFM3k9adP53rlkRbGWKeEOp4yXSX+GpC
 ENw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 04:42:27 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JwCtp1C7Tz1SVny
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 04:42:26 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644583345; x=1647175346; bh=HIsmyyzxnOL+9tGfKWdV0u2iF9CQusQW1c1
        Ow4acMmI=; b=NgqVOoHtwDArmRjZbY48Xu4IAbnBTgFUYcBqJ/SlRdrqjamYaD8
        hGP6mg1BruTMl64bTIFleULFcRZQJ/LDpkqMCOK95Hb9QsSBLzz/xOfqyfWyLman
        6JF+c6wYVvPoiRwZpDKOxSNhB4f150y4JZdUfboBCikoRD7MD9xpOV69s8CTVnFC
        cAS1POaWMzybUMRBUVcm0/thTw8vH68AXqjKtDLeOQsfAN636dOiri1AyTC0RTN/
        VBz8lFYAuYdgVcntthULQ38p+ESk/OIgrFxJ7el868HH7obLkvgbA5YfJdY9cVD+
        MZAwvcvHs3Tdu2RZKYMG7otDJ1oe91EcB/A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id njEzf5Q-YPtv for <linux-kernel@vger.kernel.org>;
        Fri, 11 Feb 2022 04:42:25 -0800 (PST)
Received: from [10.225.163.67] (unknown [10.225.163.67])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JwCtm3vFWz1Rwrw;
        Fri, 11 Feb 2022 04:42:24 -0800 (PST)
Message-ID: <472dc8ad-1fe4-a87f-1301-09b475abd9d0@opensource.wdc.com>
Date:   Fri, 11 Feb 2022 21:42:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: DMA-API: tegra-ahci 70027000.sata: device driver maps memory from
 kernel text or rodata
Content-Language: en-US
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-ide@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <YgY+57iPSHo+YXHC@Red>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YgY+57iPSHo+YXHC@Red>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 19:48, Corentin Labbe wrote:
> Hello
> 
> I boot my tegra-jetson-tk1 with some debug enabled and I got:
> [   46.232240] WARNING: CPU: 1 PID: 2144 at kernel/dma/debug.c:1073 check_for_illegal_area+0xec/0x180
> [   46.232255] DMA-API: tegra-ahci 70027000.sata: device driver maps memory from kernel text or rodata [addr=3f4026ed] [len=4096]
> [   46.232262] Modules linked in:
> [   46.232271] CPU: 1 PID: 2144 Comm: containerd Not tainted 5.16.9-dirty #8
> [   46.232277] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
> [   46.232283] [<c0110c24>] (unwind_backtrace) from [<c010b4d4>] (show_stack+0x10/0x14)
> [   46.232294] [<c010b4d4>] (show_stack) from [<c0ce90b0>] (dump_stack_lvl+0x58/0x70)
> [   46.232305] [<c0ce90b0>] (dump_stack_lvl) from [<c0124648>] (__warn+0xd0/0x134)
> [   46.232314] [<c0124648>] (__warn) from [<c0ce2b00>] (warn_slowpath_fmt+0x90/0xb4)
> [   46.232322] [<c0ce2b00>] (warn_slowpath_fmt) from [<c01cdcd8>] (check_for_illegal_area+0xec/0x180)
> [   46.232330] [<c01cdcd8>] (check_for_illegal_area) from [<c01cfab4>] (debug_dma_map_sg+0xa4/0x424)
> [   46.232340] [<c01cfab4>] (debug_dma_map_sg) from [<c01ca4d8>] (__dma_map_sg_attrs+0xc4/0x140)

It seems to be the command buffer that is at a weird address. So it may
not be the driver but the IO issuer that is doing something wrong.
The stack shows that this comes from a page fault and there does not
seem to be any filesystem involved.

What is the reproducer for this ?

Note that I do not have such hardware, so I will not be able to do
anything about this.

> [   46.232349] [<c01ca4d8>] (__dma_map_sg_attrs) from [<c01ca568>] (dma_map_sg_attrs+0x14/0x20)
> [   46.232357] [<c01ca568>] (dma_map_sg_attrs) from [<c07cc408>] (ata_qc_issue+0x16c/0x414)
> [   46.232366] [<c07cc408>] (ata_qc_issue) from [<c07d64f4>] (__ata_scsi_queuecmd+0x27c/0x4c4)
> [   46.232376] [<c07d64f4>] (__ata_scsi_queuecmd) from [<c07d679c>] (ata_scsi_queuecmd+0x60/0x90)
> [   46.232385] [<c07d679c>] (ata_scsi_queuecmd) from [<c07b36bc>] (scsi_queue_rq+0x440/0xb98)
> [   46.232397] [<c07b36bc>] (scsi_queue_rq) from [<c05808fc>] (blk_mq_dispatch_rq_list+0x1d0/0x87c)
> [   46.232406] [<c05808fc>] (blk_mq_dispatch_rq_list) from [<c0586628>] (__blk_mq_do_dispatch_sched+0x14c/0x2dc)
> [   46.232415] [<c0586628>] (__blk_mq_do_dispatch_sched) from [<c0586b38>] (__blk_mq_sched_dispatch_requests+0x10c/0x168)
> [   46.232423] [<c0586b38>] (__blk_mq_sched_dispatch_requests) from [<c0586c64>] (blk_mq_sched_dispatch_requests+0x34/0x5c)
> [   46.232432] [<c0586c64>] (blk_mq_sched_dispatch_requests) from [<c057da8c>] (__blk_mq_run_hw_queue+0x5c/0xcc)
> [   46.232442] [<c057da8c>] (__blk_mq_run_hw_queue) from [<c057dc9c>] (__blk_mq_delay_run_hw_queue+0x18c/0x1b4)
> [   46.232451] [<c057dc9c>] (__blk_mq_delay_run_hw_queue) from [<c0586f80>] (blk_mq_sched_insert_requests+0xd0/0x320)
> [   46.232460] [<c0586f80>] (blk_mq_sched_insert_requests) from [<c0581604>] (blk_mq_flush_plug_list+0x1c4/0x434)
> [   46.232468] [<c0581604>] (blk_mq_flush_plug_list) from [<c0573d40>] (blk_flush_plug+0xd4/0x114)
> [   46.232475] [<c0573d40>] (blk_flush_plug) from [<c0573f9c>] (blk_finish_plug+0x1c/0x28)
> [   46.232482] [<c0573f9c>] (blk_finish_plug) from [<c0285740>] (read_pages+0x190/0x2bc)
> [   46.232493] [<c0285740>] (read_pages) from [<c0285c1c>] (page_cache_ra_unbounded+0x164/0x230)
> [   46.232501] [<c0285c1c>] (page_cache_ra_unbounded) from [<c027846c>] (filemap_fault+0x6d4/0xd04)
> [   46.232509] [<c027846c>] (filemap_fault) from [<c02bacd0>] (__do_fault+0x38/0x104)
> [   46.232519] [<c02bacd0>] (__do_fault) from [<c02c0920>] (handle_mm_fault+0xaa0/0xea8)
> [   46.232528] [<c02c0920>] (handle_mm_fault) from [<c011563c>] (do_page_fault+0x15c/0x484)
> [   46.232537] [<c011563c>] (do_page_fault) from [<c0115b2c>] (do_DataAbort+0x3c/0xb0)
> [   46.232544] [<c0115b2c>] (do_DataAbort) from [<c0100e98>] (__dabt_usr+0x58/0x60)
> [   46.232552] Exception stack(0xc6bc9fb0 to 0xc6bc9ff8)
> [   46.232558] 9fa0:                                     00000001 bea726d8 014d40e0 01911fb8
> [   46.232563] 9fc0: 00490000 0004cb15 00523858 006f6b68 00000000 b6f0c9c8 b6f0c9c8 bea72724
> [   46.232569] 9fe0: 00000000 bea72678 b6ee2cbc b6ee41ec 200d0010 ffffffff
> [   46.232573] irq event stamp: 15628
> [   46.232577] hardirqs last  enabled at (15627): [<c01dba64>] ktime_get+0x1a4/0x1c8
> [   46.232585] hardirqs last disabled at (15628): [<c0cfbfb0>] _raw_spin_lock_irqsave+0x68/0x6c
> [   46.232594] softirqs last  enabled at (15332): [<c01015d8>] __do_softirq+0x328/0x590
> [   46.232600] softirqs last disabled at (15327): [<c012cda8>] __irq_exit_rcu+0x128/0x1a8
> [   46.232607] ---[ end trace 8655230c4b3626fb ]---
> 
> Regards


-- 
Damien Le Moal
Western Digital Research
