Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B454FEC02
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 03:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiDMBEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 21:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiDMBE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 21:04:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918B8220D9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 18:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649811729; x=1681347729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jCOzTEFGDySWdZhcnJIZg2QMTm3MGx0Arwq3UD8MWIw=;
  b=JkRaaZbfVBiX8b1Q4PZp5M2JN1Sr9Hcn4bck8e/U/L3ky1lmIBR+SUnW
   5gKCD9BdCS98qWXDjFK3idoCpTOuklgHwA/h9ALNJ1i1+DG1wvJnPB19f
   QDN5XiZHJs+rCSioiJZnVCmSkaFfFedCc98e8qkqYAij8Nm9t2F1i8BxH
   /3Jeo3GLgLkiiDZZWrd8m6vwZwnfOl1GTgYVEJatf8OcvaaAGLjKK2f8V
   ebKrTc76Q0DeRQv4OWn1sQ5XnbsQ/pp108m1xGt3cEI27fMc6DytaWmOe
   0S0DFbtWuPVs1PbruaQzgZJZ6I7esSsPeUhf1i/kiXhdUNklE1c2lseXm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="348979605"
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="348979605"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 18:02:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,255,1643702400"; 
   d="scan'208";a="551987361"
Received: from gao-cwp.sh.intel.com (HELO gao-cwp) ([10.239.159.23])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 18:02:07 -0700
Date:   Wed, 13 Apr 2022 09:02:02 +0800
From:   Chao Gao <chao.gao@intel.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        m.szyprowski@samsung.com, hch@lst.de,
        Wang Zhaoyang1 <zhaoyang1.wang@intel.com>,
        Gao Liang <liang.gao@intel.com>,
        Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH] dma-direct: avoid redundant memory sync for swiotlb
Message-ID: <20220413010157.GA10502@gao-cwp>
References: <20220412113805.3210-1-chao.gao@intel.com>
 <e25fbb7e-a67e-5421-b7be-700fd0209b0d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e25fbb7e-a67e-5421-b7be-700fd0209b0d@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 02:33:05PM +0100, Robin Murphy wrote:
>On 12/04/2022 12:38 pm, Chao Gao wrote:
>> When we looked into FIO performance with swiotlb enabled in VM, we found
>> swiotlb_bounce() is always called one more time than expected for each DMA
>> read request.
>> 
>> It turns out that the bounce buffer is copied to original DMA buffer twice
>> after the completion of a DMA request (one is done by in
>> dma_direct_sync_single_for_cpu(), the other by swiotlb_tbl_unmap_single()).
>> But the content in bounce buffer actually doesn't change between the two
>> rounds of copy. So, one round of copy is redundant.
>> 
>> Pass DMA_ATTR_SKIP_CPU_SYNC flag to swiotlb_tbl_unmap_single() to
>> skip the memory copy in it.
>
>It's still a little suboptimal and non-obvious to call into SWIOTLB twice
>though - even better might be for SWIOTLB to call arch_sync_dma_for_cpu() at
>the appropriate place internally,

Hi Robin,

dma_direct_sync_single_for_cpu() also calls arch_sync_dma_for_cpu_all()
and arch_dma_mark_clean() in some cases. if SWIOTLB does sync internally,
should these two functions be called by SWIOTLB?

Personally, it might be better if swiotlb can just focus on bounce buffer
alloc/free. Adding more DMA coherence logic into swiotlb will make it
a little complicated.

How about an open-coded version of dma_direct_sync_single_for_cpu
in dma_direct_unmap_page with swiotlb_sync_single_for_cpu replaced by
swiotlb_tbl_unmap_single?
