Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9C650DA51
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbiDYHoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238882AbiDYHop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:44:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B48B3BA55
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650872501; x=1682408501;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ypRaFhfgGoMckctkb+UqL7k4rnajuSRtG45ikgdAanE=;
  b=dt4PuQlOL5GaZIfy+q2lWWZwL1hGo8v1j0ZmhAjeiPmIi407am1IXxMb
   K4UBzCoHgDwvlEneMztk+PvyZxMP+z9ob9TiDHKdFvuLy8gKbv2VvtifN
   eVHyJBORMWQkPVFPrZe3KwjSRmXTAsjfxQfeUt32SvOVmNTgC0jOJ43K7
   85NviFrP37mLDFhlD39IYmscSwubW9IBKSmqYrHXHQeAMDVnNLgH3BJik
   U3i1rU2Fazx6fEpAeYuTHbblJLJyBU+gEgS4R/k1HZJlTsUR+pYt4fdBp
   g6LnzVMQxIVH3al5HPzL1g9L2HRFHt2E/O8hBCN3AahxeaYwYW6+/Zpc9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="264022261"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="264022261"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 00:41:33 -0700
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="676565732"
Received: from wupeng-mobl.ccr.corp.intel.com ([10.254.215.115])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 00:41:27 -0700
Message-ID: <8aeebc2f0b2a251d3d70402cd0edf063ba911013.camel@intel.com>
Subject: Re: [PATCH v3 1/3] mm/swapfile: unuse_pte can map random data if
 swap read fails
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, david@redhat.com, apopple@nvidia.com,
        surenb@google.com, minchan@kernel.org, peterx@redhat.com,
        sfr@canb.auug.org.au, naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 25 Apr 2022 15:41:25 +0800
In-Reply-To: <20220424091105.48374-2-linmiaohe@huawei.com>
References: <20220424091105.48374-1-linmiaohe@huawei.com>
         <20220424091105.48374-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Miaohe,

On Sun, 2022-04-24 at 17:11 +0800, Miaohe Lin wrote:
> There is a bug in unuse_pte(): when swap page happens to be unreadable,
> page filled with random data is mapped into user address space.  In case
> of error, a special swap entry indicating swap read fails is set to the
> page table.  So the swapcache page can be freed and the user won't end up
> with a permanently mounted swap because a sector is bad.  And if the page
> is accessed later, the user process will be killed so that corrupted data
> is never consumed.  On the other hand, if the page is never accessed, the
> user won't even notice it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> ---
>  include/linux/swap.h    |  7 ++++++-
>  include/linux/swapops.h | 10 ++++++++++
>  mm/memory.c             |  5 ++++-
>  mm/swapfile.c           | 11 +++++++++++
>  4 files changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 5553189d0215..b82c196d8867 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -55,6 +55,10 @@ static inline int current_is_kswapd(void)
>   * actions on faults.
>   */
> 
> +#define SWP_SWAPIN_ERROR_NUM 1
> +#define SWP_SWAPIN_ERROR     (MAX_SWAPFILES + SWP_HWPOISON_NUM + \
> +			     SWP_MIGRATION_NUM + SWP_DEVICE_NUM + \
> +			     SWP_PTE_MARKER_NUM)
> 
> 

It appears wasteful to use another swap device number.  Is it possible
to use a special swap offset?  For example, 0 or -1?

Best Regards,
Huang, Ying


[snip]


