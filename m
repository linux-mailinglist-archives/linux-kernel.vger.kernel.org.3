Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62F054D04C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 19:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349731AbiFORrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 13:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243182AbiFORrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 13:47:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C59C54037
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 10:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655315232; x=1686851232;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9HiCA51SRONvHgM/bRjjatEdWaF6sXtZEEtO7ayhDgs=;
  b=IxRxdE2WoGwsNDIxGwjeIHsPaWhzjLjBYgEbC0SRKZTiTtTrS22CQ0Fc
   OyL/tgkzBqheaWxM8wXTt/LhIXCH3HeMSl0gkIjpS/xWhXk+qSHl6G+/B
   8DfAyCucHDEjsQianide3ujfkvppGdV86+P5fYm0L4VIEpK6HqID0U1XP
   AaOTZsVyCZafdNy5I1rTjtR0nNgtegOkStqrIyRKYWBbSqy3CMo9RjPT3
   MZceYf3tNZNz3haC723eHnYen1YgVKqZujYi5uhn4DRadyM5rQvpmKrdo
   k9wQbHSZPH0VObSHoMbOcFdbjZcT7Dtmd1+hTvIH9fSBmMcdE65yuR2id
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="280085794"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="280085794"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 10:47:11 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="536143684"
Received: from schen9-mobl.amr.corp.intel.com ([10.209.78.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 10:47:11 -0700
Message-ID: <64e3e50508b0bf27ed5d6957161e2b3631c1164b.camel@linux.intel.com>
Subject: Re: [RFC PATCH 0/3] Cgroup accounting of memory tier usage
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
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
Date:   Wed, 15 Jun 2022 10:47:11 -0700
In-Reply-To: <68b6a7e92d48a3285a5707378459bb9ae805f333.camel@intel.com>
References: <cover.1655242024.git.tim.c.chen@linux.intel.com>
         <68b6a7e92d48a3285a5707378459bb9ae805f333.camel@intel.com>
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

On Wed, 2022-06-15 at 12:58 +0800, Ying Huang wrote:
> On Tue, 2022-06-14 at 15:25 -0700, Tim Chen wrote:
> > For controlling usage of a top tiered memory by a cgroup, accounting
> > of top tier memory usage is needed.  This patch set implements the
> > following:
> > 
> > Patch 1 introduces interface and simple implementation to retrieve
> > 	cgroup tiered memory usage
> > Patch 2 introduces more efficient accounting with top tier memory page counter 
> > Patch 3 provides a sysfs interface to repot the the top tiered memory
> > 	usage.
> > 
> > The patchset works with Aneesh's v6 memory-tiering implementation [1].
> > It is a preparatory patch set before introducing features to
> > control top tiered memory in cgroups.
> > 
> > I'll like to first get feedback to see if 
> > (1) Controllng the topmost tiered memory is enough 
> > or
> > (2) Multiple tiers at the top levels need to be grouped into "toptier"
> > or
> 
> If we combine top-N tiers, I think the better name could be "fast-tier",
> in contrast to "slow-tier".
> 

I can see use cases for grouping tiers. For example, it makese sense for HBM and 
DRAM tiers be grouped together into a "fast-tier-group".

To make things simple, we can define any tiers above or equal
to the rank of DRAM will belong to this fast-tier-group.

An implication for page promotion/demotion is it needs
to take tier grouping into consideration.  You want to demote
pages away from current tier-group.  For example,
you want to demote HBM (fast-tier-group) into PMEM (slow-tier-group)
instead of into DRAM (fast-tier-group).  

The question is whether fast/slow tier groups are sufficient.
Or you need fast/slow/slower groups?

> > (3) There are use cases not covered by (1) and (2). 
> 
> Is it necessary to control memory usage of each tier (except the
> lowest/slowest)?  I am not the right person to answer the question, but
> I want to ask it.
> 

I have the same question.

Tim


