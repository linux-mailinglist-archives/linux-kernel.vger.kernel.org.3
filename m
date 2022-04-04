Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459B24F1D03
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382449AbiDDV3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379298AbiDDQ4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:56:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53053B3EC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=juT257hsMDR0kNSqLpseTautg+enIq2U1DAPgu8Wesk=; b=s/vYPj0Nor2v9/P0q0FW0qkQdS
        //RkASVpogRE49d7MHgaKIv7L75NGdkMsqGz4tgko3CrOzdXyUI81IDqNth8GY32HjluEeiAgDXwP
        CS3s3rWZV+Uno8cm94Bb3AGHi9cu6tY2tyAdFvn4K5HD66JDcEpjyz0rzpoJNuQQiUFoT4Pm9OArc
        IOOG2bCYiwDOK26J/YlKuykhePNHMWz08kfsbpLLS6I6J1Viygh6qyt3SOTCj32+Jm9xqVc9xAYkt
        w4+g+WGp9adapRaa9FjfGqEVZ0Qm9EK1wJ3zdnqTtbOvaDJtt9ae1O48psTeU0SQHTzs5kXP7PrXa
        j9YnusPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbPyP-00FryS-Ni; Mon, 04 Apr 2022 16:54:37 +0000
Date:   Mon, 4 Apr 2022 09:54:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Suthikulpanit Suravee <Suravee.Suthikulpanit@amd.com>,
        Hegde Vasant <Vasant.Hegde@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Fix issues with untrusted devices and AMD IOMMU
Message-ID: <YksizUJzRgEEdHLJ@infradead.org>
References: <20220404164707.1128-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404164707.1128-1-mario.limonciello@amd.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 11:47:05AM -0500, Mario Limonciello wrote:
> The bounce buffers were originally set up, but torn down during
> the boot process.
> * This happens because as part of IOMMU initialization
>   `amd_iommu_init_dma_ops` gets called and resets the global swiotlb to 0.
> * When late_init gets called `pci_swiotlb_late_init` `swiotlb_exit` is
>   called and the buffers are torn down.

I think the proper thing is to do this:

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a1ada7bff44e6..079694f894b85 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1838,17 +1838,10 @@ void amd_iommu_domain_update(struct protection_domain *domain)
 	amd_iommu_domain_flush_complete(domain);
 }
 
-static void __init amd_iommu_init_dma_ops(void)
-{
-	swiotlb = (iommu_default_passthrough() || sme_me_mask) ? 1 : 0;
-}
-
 int __init amd_iommu_init_api(void)
 {
 	int err;
 
-	amd_iommu_init_dma_ops();
-
 	err = bus_set_iommu(&pci_bus_type, &amd_iommu_ops);
 	if (err)
 		return err;
