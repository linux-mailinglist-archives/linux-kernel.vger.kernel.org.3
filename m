Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A97525A0F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 05:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376736AbiEMDZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 23:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376596AbiEMDZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 23:25:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E9C1009
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 20:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652412341; x=1683948341;
  h=message-id:subject:from:to:date:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=6JbJ7g7D2Yn2WY7qd9fnqK8G+aJNQ1BIcCplhlKlw6I=;
  b=JhID5sbcsn3Fla1qE+f555PVnMbIaXCaokLl56bliE4uY4G7LAvICCTX
   3AdtpWgI6HxCdpBH0zWYSjcvQtcG7eh2TIOGEK5ophymfqCxG9M/sf1un
   uqOw3r4GKulb1qhgOtJWF4FXyW+4m2fjDYwvCGrHG3vTGg6cC71niLOVF
   Z79lzFc4Qyy3l/j5vbCV0Y4fm8J28dpixKVUpAD9vuyOGNlyV9keafoO7
   kfOuSHI7gFhIfg9hDjFQPUoxBxdoz7Rvah2I33Ozp5UhseLSCafuoom9N
   bsGGYVZlf/jmElifeeF9PX5hXAGjNA1yulUmWytjQk2T0W80vh+E5psvE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="330802694"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="330802694"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 20:25:41 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="566997853"
Received: from jliu69-mobl.ccr.corp.intel.com ([10.254.212.158])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 20:25:36 -0700
Message-ID: <69f2d063a15f8c4afb4688af7b7890f32af55391.camel@intel.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim C Chen <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Hesham Almatary <hesham.almatary@huawei.com>
Date:   Fri, 13 May 2022 11:25:34 +0800
In-Reply-To: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-11 at 23:22 -0700, Wei Xu wrote:
> 
> Memory Allocation for Demotion
> ==============================
> 
> To allocate a new page as the demotion target for a page, the kernel
> calls the allocation function (__alloc_pages_nodemask) with the
> source page node as the preferred node and the union of all lower
> tier nodes as the allowed nodemask.  The actual target node selection
> then follows the allocation fallback order that the kernel has
> already defined.
> 
> The pseudo code looks like:
> 
>     targets = NODE_MASK_NONE;
>     src_nid = page_to_nid(page);
>     src_tier = node_tier_map[src_nid];
>     for (i = src_tier + 1; i < MAX_MEMORY_TIERS; i++)
>             nodes_or(targets, targets, memory_tiers[i]);
>     new_page = __alloc_pages_nodemask(gfp, order, src_nid, targets);
> 
> The memopolicy of cpuset, vma and owner task of the source page can
> be set to refine the demotion target nodemask, e.g. to prevent
> demotion or select a particular allowed node as the demotion target.

Consider a system with 3 tiers, if we want to demote some pages from
tier 0, the desired behavior is,

- Allocate pages from tier 1
- If there's no enough free pages in tier 1, wakeup kswapd of tier 1 so
demote some pages from tier 1 to tier 2
- If there's still no enough free pages in tier 1, allocate pages from
tier 2.

In this way, tier 0 will have the hottest pages, while tier 1 will have
the coldest pages.

With your proposed method, the demoting from tier 0 behavior is,

- Allocate pages from tier 1
- If there's no enough free pages in tier 1, allocate pages in tier 2

The kswapd of tier 1 will not be waken up until there's no enough free
pages in tier 2.  In quite long time, there's no much hot/cold
differentiation between tier 1 and tier 2.

This isn't hard to be fixed, just call __alloc_pages_nodemask() for each
tier one by one considering page allocation fallback order.

Best Regards,
Huang, Ying


