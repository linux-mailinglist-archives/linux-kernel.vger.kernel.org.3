Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2CF4527E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 09:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241111AbiEPH2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 03:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240998AbiEPH2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 03:28:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287031E3ED
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 00:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rbs61TdTiI6i6SlTkgOYEqrF4kqWmCSNPXnH343zn4o=; b=zkINHdszgACmI/fzh//RKBm1YX
        5Z5LEqTUwX+l8euQuEm3vGOmtp2GaWR+oB2Rx9rENisveABaculMx3ybmxVXdBW0UDs+DPV/9xsGt
        wPOcPZJSM306yzbrU1bKsE2ih7mLF7m8wwW29GamovpogfoobKJsooctChTQB9Npnx2ym7yAC0aRN
        RwKMLUG0UR/j9yNqvaqDGAT3T1O+ahsO3SvPmON+s3r6AKmszMnzR9k+Mr3wcBi0WHWQRP1Lmptkh
        q+JEdhZEAvGGbhheEd/54ILLsj/XSOefi/fxDG4RefMht3LQm3r4lkwgW/TDKEEks/nojhGEr240F
        5y0LpzRQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqV8n-006SAS-Df; Mon, 16 May 2022 07:27:41 +0000
Date:   Mon, 16 May 2022 00:27:41 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iommu: Add blocking_domain_ops field in iommu_ops
Message-ID: <YoH87WKnqtGgVCHt@infradead.org>
References: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
 <20220516015759.2952771-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516015759.2952771-3-baolu.lu@linux.intel.com>
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

On Mon, May 16, 2022 at 09:57:56AM +0800, Lu Baolu wrote:
> Each IOMMU driver must provide a blocking domain ops. If the hardware
> supports detaching domain from device, setting blocking domain equals
> detaching the existing domain from the deivce. Otherwise, an UNMANAGED
> domain without any mapping will be used instead.

blocking in this case means not allowing any access?  The naming
sounds a bit odd to me as blocking in the kernel has a specific
meaning.  Maybe something like noaccess ops might be a better name?
