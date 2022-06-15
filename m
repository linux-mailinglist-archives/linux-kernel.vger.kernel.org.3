Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7382454C0FE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242754AbiFOE7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 00:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbiFOE67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 00:58:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50A83B016
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 21:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655269138; x=1686805138;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dw66JPwioy0ZxhOB3enfq+e+5LXA5Jwr+DWaxTerOp4=;
  b=fOnK8idtLMzvqr7FJXNpTZqhEYJ6/yPmaCoaVoq69NfQXaypCPvdHosZ
   vPTMIwyVqIzZ2ZMoWBWKEtHHkDxe6Yq1x4aSHtu6NxA3ZQQp9QXMaLWul
   NmdJJk3Kl57JXZzVOLizbExNuQRgDX7HYYlJvC8hl0ZVofxzJpjtq7NsI
   dfAJont/pbSNpx2rTPUmT78JDCKrdga0cRWfR1TMvgqi7O+VVTvJ2rljd
   Y0yrrkT+4ONmXwalSyWMZU1A+xx2FG4ji1ktMP1DuyPzpI7eHMT/oJ4AU
   5+zSEzoUlTXFzwIn5oVsboNBx9lgcEQoUHf+75vxfXyyDGttVrprf72LV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="340498688"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="340498688"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 21:58:58 -0700
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="640781265"
Received: from yutang-mobl.ccr.corp.intel.com ([10.254.214.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 21:58:53 -0700
Message-ID: <68b6a7e92d48a3285a5707378459bb9ae805f333.camel@intel.com>
Subject: Re: [RFC PATCH 0/3] Cgroup accounting of memory tier usage
From:   Ying Huang <ying.huang@intel.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
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
Date:   Wed, 15 Jun 2022 12:58:50 +0800
In-Reply-To: <cover.1655242024.git.tim.c.chen@linux.intel.com>
References: <cover.1655242024.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-14 at 15:25 -0700, Tim Chen wrote:
> For controlling usage of a top tiered memory by a cgroup, accounting
> of top tier memory usage is needed.  This patch set implements the
> following:
> 
> Patch 1 introduces interface and simple implementation to retrieve
> 	cgroup tiered memory usage
> Patch 2 introduces more efficient accounting with top tier memory page counter 
> Patch 3 provides a sysfs interface to repot the the top tiered memory
> 	usage.
> 
> The patchset works with Aneesh's v6 memory-tiering implementation [1].
> It is a preparatory patch set before introducing features to
> control top tiered memory in cgroups.
> 
> I'll like to first get feedback to see if 
> (1) Controllng the topmost tiered memory is enough 
> or
> (2) Multiple tiers at the top levels need to be grouped into "toptier"
> or

If we combine top-N tiers, I think the better name could be "fast-tier",
in contrast to "slow-tier".

> (3) There are use cases not covered by (1) and (2). 

Is it necessary to control memory usage of each tier (except the
lowest/slowest)?  I am not the right person to answer the question, but
I want to ask it.

Best Regards,
Huang, Ying

> Thanks.
> 
> Tim
> 
> [1] https://lore.kernel.org/linux-mm/20220610135229.182859-1-aneesh.kumar@linux.ibm.com/ 
> 
> Tim Chen (3):
>   mm/memory-tiers Add functions for tier memory usage in a cgroup
>   mm/memory-tiers: Use page counter to track toptier memory usage
>   mm/memory-tiers: Show toptier memory usage for cgroup
> 
>  include/linux/memcontrol.h   |  1 +
>  include/linux/memory-tiers.h |  2 +
>  mm/memcontrol.c              | 86 +++++++++++++++++++++++++++++++++++-
>  mm/memory-tiers.c            |  3 +-
>  4 files changed, 89 insertions(+), 3 deletions(-)
> 


