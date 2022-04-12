Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC2B4FCBBC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 03:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347651AbiDLBNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 21:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351414AbiDLBCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 21:02:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C6313E28
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 17:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649725188; x=1681261188;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ID7Dlx34WXaq5itFE0ozcc4Gc9FFa/Ra2b7+KNAMdtE=;
  b=Yn2dcjwHzdBS89SggZQt88MyvDd8EiG3a8Su9GhqFtZq3Q/2pY/3KnHa
   bcNoU0/N+A3R8rr+A9bMHcQjFCt0v6HKVEf1ereLChWNfQ+gROxpz1KXH
   9vh6NMTiGv1KeLfJq7ZcQUJqS+y2LpkCStioUrCR0XBAek89oscU1JGdm
   E8RAq+85UhqWxrHplIODTEA4JBJcAmomdMadSO9S5fSxlbanrIGV0Y581
   BOF2nmrk5iqc/sRToqfrfjWDT1re6+ZgfaLccvYU84L/b2Otw1HhBIdA6
   l/tJ48B0MAyYxa1RWHUKzEeS4JKYoDI+xcBh6fsDM1/J/mer4qRMmrQCD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="348686910"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="348686910"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 17:59:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="551469928"
Received: from joliu-mobl2.ccr.corp.intel.com ([10.254.214.243])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 17:59:20 -0700
Message-ID: <be4253d45d473f56aa54f69f46978cc15c3bb1cb.camel@intel.com>
Subject: Re: [PATCH v2 5/9] mm/vmscan: activate swap-backed executable
 folios after first usage
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     songmuchun@bytedance.com, hch@infradead.org, willy@infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Apr 2022 08:59:17 +0800
In-Reply-To: <20220409093500.10329-6-linmiaohe@huawei.com>
References: <20220409093500.10329-1-linmiaohe@huawei.com>
         <20220409093500.10329-6-linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-04-09 at 17:34 +0800, Miaohe Lin wrote:
> We should activate swap-backed executable folios (e.g. tmpfs) after first
> usage so that executable code gets yet better chance to stay in memory.
> 
> Suggested-by: Huang, Ying <ying.huang@intel.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Reviewed-by: Huang, Ying <ying.huang@intel.com>

Best Regards,
Huang, Ying

> ---
>  mm/vmscan.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 0e5818970998..cc1193e320c2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1412,9 +1412,9 @@ static enum page_references folio_check_references(struct folio *folio,
>  			return PAGEREF_ACTIVATE;
>  
> 
> 
> 
>  		/*
> -		 * Activate file-backed executable folios after first usage.
> +		 * Activate executable folios after first usage.
>  		 */
> -		if ((vm_flags & VM_EXEC) && !folio_test_swapbacked(folio))
> +		if (vm_flags & VM_EXEC)
>  			return PAGEREF_ACTIVATE;
>  
> 
> 
> 
>  		return PAGEREF_KEEP;


