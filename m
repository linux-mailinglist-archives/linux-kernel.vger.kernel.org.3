Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446B354D92E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 06:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356948AbiFPEP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 00:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358690AbiFPENO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 00:13:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C7F58E79
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 21:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655352778; x=1686888778;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nlm6al6P2Z1ikmMxhWHFF1HPFaPtHUR/HHWwJb+v9bI=;
  b=A0CKMjfJLP+PAjiQ/GCp9ZYYcCxK6iuKj0UwOoXhxRG14zNTqiiCAei7
   cxPy8x4PvwmQwa2TNzJg/lgxn+szpr28Cpr3TTKcb8qE36MJR7VHM2rFN
   m1UvKLGP01uot1aXXg+Ip3yRKQug1jnHqfMEe6jmiUZXySmH4SBG+RBGu
   OIlYm/3iCqvjXrybH+EoiwLXyiABeYGU7PuPXxMsWrBtY3ZWboBNqSdtW
   /RPUtt1B4ethqHXnLDQ2uY356qiyppBu5HvaSA2fgDWvrh4ooss3csSmU
   /O3AxxBCo+K2s97JvPDYx+49pizNIJfiaiMo21Rxiqq9NzrbsnBoNgEDX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="340816689"
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="340816689"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 21:12:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,304,1647327600"; 
   d="scan'208";a="652991681"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.78.147])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 21:12:47 -0700
Message-ID: <bf3d68f9c328d4574119df5870d0ecb5f69bdd67.camel@linux.intel.com>
Subject: Re: [RFC PATCH 2/3] mm/memory-tiers: Use page counter to track
 toptier memory usage
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Wei Xu <weixugc@google.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Shakeel Butt <shakeelb@google.com>
Date:   Wed, 15 Jun 2022 21:12:47 -0700
In-Reply-To: <CAAPL-u-GgtYy9rNJxnSUA5+PH75g2hvNgt=bnra=fQra-bHk9w@mail.gmail.com>
References: <cover.1655242024.git.tim.c.chen@linux.intel.com>
         <cefeb63173fa0fac7543315a2abbd4b5a1b25af8.1655242024.git.tim.c.chen@linux.intel.com>
         <CAAPL-u-GgtYy9rNJxnSUA5+PH75g2hvNgt=bnra=fQra-bHk9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-14 at 17:30 -0700, Wei Xu wrote:


Thanks for your comments.

> When we don't know which pages are being charged, we should still
> charge the usage to toptier (assuming that toptier always include the
> default tier), e.g. from try_charge_memcg().
> 

I delayed the charging of the toptier a bit till we know which page
is being used and the memcg is being assigned to the page.  
That's when mem_cgroup_charge_toptier is invoked. 

Otherwise if we charge to toptier first, we will have additional 
work to deduct the count when pages used are not toptier.

> The idea is that when lower tier memory is not used, memcg->toptier
> and memcg->memory should have the same value. Otherwise, it can cause
> confusions about where the pages of (memcg->memory - memcg->toptier)
> go.

Any difference should be very small as the charge will go into toptier
too quickly. The values will be different even if
memcg->memory is read at slightly different time anyway.

Tim


