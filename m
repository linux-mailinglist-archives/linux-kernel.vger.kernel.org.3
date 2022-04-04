Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1F04F1ECC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380404AbiDDWHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 18:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379540AbiDDR0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:26:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B8B31909
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 10:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N24CpBDygfALbt/hrcJkTFYe4AX/XLB390dNSfysj5g=; b=NVYwAi0WWPljQrXbqyVfROhDET
        Yia/c6sRhlxlfiABHHpesebhHQjtnVtRPI7ShBOv/6Eq1SP3n0t6faH96gj+xfWQ6ORQTfK4Plt4j
        WgCLKfbqhOU/yRzepQHfQ8eEWl0qaGp6rTobEXAEg41NGF13ZC0++grPjTX0ENG/sTkyNp2jJpHV2
        8qgXWugQhy8Qux2xZu6rlNSffJCdWpeuVdlLsex6Nbrnerg22khrz62qDjPyGKtHJid9ney+hx58n
        EtN3vqK6Ss/pqCTABq4+L0b/rmyE/yi62/XVUy+EwV6CHHTsUntUszvh8dB36LsGCiGrSPb0+HmHH
        +4VlDutw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbQRJ-00G0Q6-1x; Mon, 04 Apr 2022 17:24:29 +0000
Date:   Mon, 4 Apr 2022 10:24:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Hegde, Vasant" <Vasant.Hegde@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Fix issues with untrusted devices and AMD IOMMU
Message-ID: <YkspzQLcfvTQfJ9i@infradead.org>
References: <20220404164707.1128-1-mario.limonciello@amd.com>
 <YksizUJzRgEEdHLJ@infradead.org>
 <BL1PR12MB51573B811E1F7321E25EF785E2E59@BL1PR12MB5157.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB51573B811E1F7321E25EF785E2E59@BL1PR12MB5157.namprd12.prod.outlook.com>
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

On Mon, Apr 04, 2022 at 05:05:00PM +0000, Limonciello, Mario wrote:
> I do expect that solves it as well.  The reason I submitted the way I
> did is that there seemed to be a strong affinity for having swiotlb
> disabled when IOMMU is enabled on AMD IOMMU.  The original code that
> disabled SWIOTLB in AMD IOMMU dates all the way back to 2.6.33 (commit
> 75f1cdf1dda92cae037ec848ae63690d91913eac) and it has ping ponged around
> since then to add more criteria that it would be or wouldn't be
> disabled, but was never actually dropped until your suggestion.

Well, that was before we started bounce buffering for untrusted devices.
We can't just have a less secure path for them because some conditions
are not met.  Especially given that most AMD systems right now probably
don't have that swiotlb buffer if the IOMMU is enabled.  So not freeing
the buffer in this case is a bug fix that is needed to properly
support the bounce buffering for unaligned I/O to untrusted devices.

> I do think that my messaging patch (1/2) may still be useful for
> debugging in the future if for another reason SWIOTLB is disabled.

I think the warning is useful.  For dma-direct we have it in the caller
so I'd be tempted todo the same for dma-iommu.
