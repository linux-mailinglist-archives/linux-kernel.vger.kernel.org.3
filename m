Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96F24FEEB3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiDMFsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiDMFsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:48:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187424FC53
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649828773; x=1681364773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IrNsHOC0jQhqTNGVvI4WqlFCg4JXfzht0G6G+u7v/NM=;
  b=cMx0dTcgULv/NaG16mAMWwM3jAtlSifluRvE8MD6kR6HPC/M8QZwJTQ4
   YmW8COqPemgBVOx2e8BrmxkFqYsgJtGuwuAfnyblSyCgVrIRZenv1V01W
   G9FrHbEpHGK+hjmmNWq39nXJQ76XmhnHh3f4t6n03L4/UJan10tlU+MRX
   eZ2uUtQuirJaAfzjy4m4aBrGmIxh4PWr6uMKCKexDcmJEQl/8tCt4mTxO
   sSVeK72SRY+PA1SjjPyGSgWkXp2BgmWqG3gH+yEmBy2r4cpcCiPhGr5W/
   BA7RWYP0LaOrqlHBI6drFTALqgEhuUM/MHmRIHfBwF/XB+zpTeQi1LJsU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="249869305"
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="249869305"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 22:46:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="552060313"
Received: from gao-cwp.sh.intel.com (HELO gao-cwp) ([10.239.159.23])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 22:46:10 -0700
Date:   Wed, 13 Apr 2022 13:46:06 +0800
From:   Chao Gao <chao.gao@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, m.szyprowski@samsung.com,
        Wang Zhaoyang1 <zhaoyang1.wang@intel.com>,
        Gao Liang <liang.gao@intel.com>,
        Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH] dma-direct: avoid redundant memory sync for swiotlb
Message-ID: <20220413054600.GA23023@gao-cwp>
References: <20220412113805.3210-1-chao.gao@intel.com>
 <e25fbb7e-a67e-5421-b7be-700fd0209b0d@arm.com>
 <20220413010157.GA10502@gao-cwp>
 <20220413045958.GA31209@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413045958.GA31209@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 06:59:58AM +0200, Christoph Hellwig wrote:
>So for now I'd be happy with the one liner presented here, but
>eventually the whole area could use an overhaul.

Thanks. Do you want me to post a new version with the Fixes tag or you
will take care of it?

Fixes: 55897af63091 ("dma-direct: merge swiotlb_dma_ops into the dma_direct code")
