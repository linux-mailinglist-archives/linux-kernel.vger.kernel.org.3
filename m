Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6989F54CC9E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349555AbiFOPYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348298AbiFOPX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:23:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69531C13E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655306637; x=1686842637;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ykflRw68m1/+YtPghFKGX38ewwpPpqo6gmWZMbFFPxE=;
  b=O69YS5MPKx7XnxjP2UU4lCeiZ48iyuCydIErohYRWXq1LAjq2pos9oIk
   G2Z8zoRzVXeXw8XOz9OQQYng4X8oJfc7Yb9Z6cfhIr4lrNlxtHpWE+KXK
   rWLgDVF6XnbDrR3OU4VRDChxTmHFC6QjLwgfw4MgRW/NcREhPIDCBvd2p
   NLMeRqu85uV4Prp3i1yJQNKCOxfTs5OpRGe2SXU/clif1xEZT1lQueTss
   avmL5qQZmegiou9Geiej6U2fIhiZpt3VA/OKBK9FvO3HN3EAZm6Pw5I5v
   RDoSXOa8Y6Xww4pPHNlKxofESGPh774pv8cKiSdn7BHzlpACkmYXP/8qH
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="267687500"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="267687500"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 08:23:57 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="712984367"
Received: from lgankov-mobl1.amr.corp.intel.com (HELO schen9-mobl.amr.corp.intel.com) ([10.209.78.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 08:23:57 -0700
Message-ID: <34f985f63e6dbaa60bb9d1edb6022e83b98304e4.camel@linux.intel.com>
Subject: Re: [RFC PATCH 0/3] Cgroup accounting of memory tier usage
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Brice Goglin <brice.goglin@gmail.com>,
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
Date:   Wed, 15 Jun 2022 08:23:56 -0700
In-Reply-To: <Yqm+ZnHfkxuyuzyD@dhcp22.suse.cz>
References: <cover.1655242024.git.tim.c.chen@linux.intel.com>
         <Yqm+ZnHfkxuyuzyD@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-15 at 13:11 +0200, Michal Hocko wrote:
> On Tue 14-06-22 15:25:32, Tim Chen wrote:
> > For controlling usage of a top tiered memory by a cgroup, accounting
> > of top tier memory usage is needed.  This patch set implements the
> > following:
> > 
> > Patch 1 introduces interface and simple implementation to retrieve
> > 	cgroup tiered memory usage
> > Patch 2 introduces more efficient accounting with top tier memory page counter 
> > Patch 3 provides a sysfs interface to repot the the top tiered memory
> > 	usage.
> 
> I guess you meant cgroupfs here, right?

Yes.

> 
> > The patchset works with Aneesh's v6 memory-tiering implementation [1].
> > It is a preparatory patch set before introducing features to
> > control top tiered memory in cgroups.
> > 
> > I'll like to first get feedback to see if 
> > (1) Controllng the topmost tiered memory is enough 
> > or
> > (2) Multiple tiers at the top levels need to be grouped into "toptier"
> > or
> > (3) There are use cases not covered by (1) and (2). 
> 
> I would start by asking why do we need a dedicated interface in the
> first place. Why the existing numa_stat is not a proper interface. Right
> now we only report LRU per node stats. Is this insufficient?
> What is userspace expect to do based on the reported data?

Exporting the toptier information here is convenient for me for debugging
purpose of seeing whether a cgroup's toptier usage is under control.
Otherwise writing a script to parse numastat and the memtier heirachy will
work too. Exporting toptier usage directly is optional and we don't have to do it.

Tim

