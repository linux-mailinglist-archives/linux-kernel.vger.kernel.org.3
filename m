Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31FD5A7B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiHaKnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiHaKnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:43:20 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F19C8777;
        Wed, 31 Aug 2022 03:43:18 -0700 (PDT)
X-UUID: 9770c0a5a4344fd69741819be046347b-20220831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Es87NlIhjYHpg4dZrG96TP+dhMTbFw0ydOaC4lEEmKE=;
        b=KwM9lxn+c0JVvWg3oWMOALZiJE8/kfWQWSWEsOcGsRc1MJhN57COKW1Js8RJ+vXYYt2ul/lVkcdJcA3fWcT/XeSkd7FtiYKisQ1xOsZE4f1TqvqE8qAyvqBwN3FeriVC/OMaXrO1ptRLx0NweRkrjBp26H9lKuTTxV/xa5nDCD0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:3d9de0a7-2ca3-49df-b3a4-fac8c4c089db,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:-25
X-CID-META: VersionHash:84eae18,CLOUDID:e4442656-e800-47dc-8adf-0c936acf4f1b,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 9770c0a5a4344fd69741819be046347b-20220831
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yf.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 212749007; Wed, 31 Aug 2022 18:43:11 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 31 Aug 2022 18:43:10 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 31 Aug 2022 18:43:10 +0800
From:   <yf.wang@mediatek.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        <christian.koenig@amd.com>, <linux-media@vger.kernel.org>
CC:     <wsd_upstream@mediatek.com>, Libo Kang <Libo.Kang@mediatek.com>,
        Ning Li <Ning.Li@mediatek.com>, Yong Wu <Yong.Wu@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [bug report] dma-buf: Add debug option
Date:   Wed, 31 Aug 2022 18:35:21 +0800
Message-ID: <20220831103521.3019-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel Vetter,

The patch https://patchwork.freedesktop.org/patch/414455/:
"dma-buf: Add debug option" from Jan. 15, 2021, leads to the following expection:

Backtrace:

[<ffffffc0081a2258>] atomic_notifier_call_chain+0x9c/0xe8
[<ffffffc0081a2d54>] notify_die+0x114/0x19c
[<ffffffc0080348d8>] __die+0xec/0x468
[<ffffffc008034648>] die+0x54/0x1f8
[<ffffffc0080631e8>] die_kernel_fault+0x80/0xbc
[<ffffffc0080630fc>] __do_kernel_fault+0x268/0x2d4
[<ffffffc008062c4c>] do_bad_area+0x68/0x148
[<ffffffc00a6dab34>] do_translation_fault+0xbc/0x108
[<ffffffc0080619f8>] do_mem_abort+0x6c/0x1e8
[<ffffffc00a68f5cc>] el1_abort+0x3c/0x64
[<ffffffc00a68f54c>] el1h_64_sync_handler+0x5c/0xa0
[<ffffffc008011ae4>] el1h_64_sync+0x78/0x80
[<ffffffc008063b9c>] dcache_inval_poc+0x40/0x58
[<ffffffc009236104>] iommu_dma_sync_sg_for_cpu+0x144/0x280
[<ffffffc0082b4870>] dma_sync_sg_for_cpu+0xbc/0x110
[<ffffffc002c7538c>] system_heap_dma_buf_begin_cpu_access+0x144/0x1e0 [system_heap]
[<ffffffc0094154e4>] dma_buf_begin_cpu_access+0xa4/0x10c
[<ffffffc004888df4>] isp71_allocate_working_buffer+0x3b0/0xe8c [mtk_hcp]
[<ffffffc004884a20>] mtk_hcp_allocate_working_buffer+0xc0/0x108 [mtk_hcp]

Because of CONFIG_DMABUF_DEBUG will default enable when DMA_API_DEBUG enable,
and when not support dma coherent, since the main function of user calling
dma_buf_begin_cpu_access and dma_buf_end_cpu_access is to do cache sync during
dma_buf_map_attachment and dma_buf_unmap_attachment, which get PA error from
sgtable by sg_phys(sg), this leads to the expection.

1.dma_buf_map_attachement()
 -.> mangle_sg_table(sg)  // "sg->page_link ^= ~0xffUL" to rotate PA in this patch.

2.dma_buf_begin_cpu_access()
 -.> system_heap_dma_buf_begin_cpu_access() in system_heap.c  // do cache sync if mapped attachment before
    -.> iommu_dma_sync_sg_for_cpu() in dma-iommu.c
        -.>  arch_sync_dma_for_device(sg_phys(sg), sg->length, dir) // get PA error since PA mix up

3.dma_buf_end_cpu_access() and dma_buf_begin_cpu_access are similar.

4.dma_buf_unmap_attachement()
       -.> mangle_sg_table(sg) // "sg->page_link ^= ~0xffUL" to rotate PA



drivers/dma-buf/Kconfig:
config DMABUF_DEBUG
	bool "DMA-BUF debug checks"
	default y if DMA_API_DEBUG


drivers/dma-buf/dma-buf.c:
static void mangle_sg_table(struct sg_table *sg_table)
{
#ifdef CONFIG_DMABUF_DEBUG
	int i;
	struct scatterlist *sg;

	/* To catch abuse of the underlying struct page by importers mix
	 * up the bits, but take care to preserve the low SG_ bits to
	 * not corrupt the sgt. The mixing is undone in __unmap_dma_buf
	 * before passing the sgt back to the exporter. */
	for_each_sgtable_sg(sg_table, sg, i)
		sg->page_link ^= ~0xffUL;
#endif
}


drivers/iommu/dma-iommu.c:
static void iommu_dma_sync_sg_for_cpu(struct device *dev,
		struct scatterlist *sgl, int nelems,
		enum dma_data_direction dir)
{
	struct scatterlist *sg;
	int i;

	if (dev_is_dma_coherent(dev) && !dev_is_untrusted(dev))
		return;

	for_each_sg(sgl, sg, nelems, i) {
		if (!dev_is_dma_coherent(dev))
			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);

		if (is_swiotlb_buffer(sg_phys(sg)))
			swiotlb_tbl_sync_single(dev, sg_phys(sg), sg->length,
						dir, SYNC_FOR_CPU);
	}
}


Thanks,
Yunfei.
