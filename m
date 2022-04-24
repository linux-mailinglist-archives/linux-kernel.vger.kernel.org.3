Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFBF50CED8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 05:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237962AbiDXDXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237350AbiDXDXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:23:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08627694A0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 20:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650770400; x=1682306400;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eaFh1Nyg1sQQwzopr5P66vVylHMWiOOzfgw1YkUrkzI=;
  b=VU5HsMjzqPdvhpVUi7xkdTkkAByZh/RsV8EV678B5jQ4IGxMq93FKdMv
   nj09LCPK0zJ6/xKxsEE01PMjy9fTOAdfMUGqgXYitRV2libPr6og9ghhc
   d6rec4pkh6MSE7/8FQDbHf6UvvTj7vvQdBXiiIMGVq46mdedCjxbSdVez
   AlufrM6YopXBzaayG5h8tVqeXdCyBm7IOtRI4EQCEuOfi6rQqvulUypC4
   YiluPVdG3xjorL3tG5EKX6KQMTvyH0HBM9VAkGjDR2KZgcYH+ZnKlM6bF
   KBJs7yKqXbFraG61EB3uKH6Sf8bry/g6ScvGob9yqiIS5WptctYce//XZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="351436087"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="351436087"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 20:19:57 -0700
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="674710499"
Received: from dafeixu-mobl1.ccr.corp.intel.com ([10.254.212.194])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 20:19:55 -0700
Message-ID: <4b986b46afb2fe888c127d8758221d0f0d3ec55f.camel@intel.com>
Subject: Re: [PATCH v3 0/7] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        aneesh.kumar@linux.ibm.com, shy828301@gmail.com,
        weixugc@google.com, gthelen@google.com, dan.j.williams@intel.com
Date:   Sun, 24 Apr 2022 11:19:53 +0800
In-Reply-To: <20220422195516.10769-1-jvgediya@linux.ibm.com>
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-04-23 at 01:25 +0530, Jagdish Gediya wrote:
> Some systems(e.g. PowerVM) can have both DRAM(fast memory) only
> NUMA node which are N_MEMORY and slow memory(persistent memory)
> only NUMA node which are also N_MEMORY. As the current demotion
> target finding algorithm works based on N_MEMORY and best distance,
> it will choose DRAM only NUMA node as demotion target instead of
> persistent memory node on such systems. If DRAM only NUMA node is
> filled with demoted pages then at some point new allocations can
> start falling to persistent memory, so basically cold pages are in
> fast memor (due to demotion) and new pages are in slow memory, this
> is why persistent memory nodes should be utilized for demotion and
> dram node should be avoided for demotion so that they can be used
> for new allocations.
> 
> Current implementation can work fine on the system where the memory
> only numa nodes are possible only for persistent/slow memory but it
> is not suitable for the like of systems mentioned above.

Can you share the NUMA topology information of your machine?  And the
demotion order before and after your change?

Whether it's good to use the PMEM nodes as the demotion targets of the
DRAM-only node too?

Best Regards,
Huang, Ying

> This patch series introduces the new node state N_DEMOTION_TARGETS,
> which is used to distinguish the nodes which can be used as demotion
> targets, node_states[N_DEMOTION_TARGETS] is used to hold the list of
> nodes which can be used as demotion targets.
> 
> node state N_DEMOTION_TARGETS is also set from the dax kmem driver,
> certain type of memory which registers through dax kmem (e.g. HBM)
> may not be the right choices for demotion so in future they should
> be distinguished based on certain attributes and dax kmem driver
> should avoid setting them as N_DEMOTION_TARGETS, however current
> implementation also doesn't distinguish any  such memory and it
> considers all N_MEMORY as demotion targets so this patch series
> doesn't modify the current behavior.
> 
> below command can be used to view the available demotion targets in
> the system,
> 
> $ cat /sys/devices/system/node/demotion_targets
> 
> This patch series sets N_DEMOTION_TARGET from dax device kmem driver,
> It may be possible that some memory node desired as demotion target
> is not detected in the system from dax-device kmem probe path. It is
> also possible that some of the dax-devices are not preferred as
> demotion target e.g. HBM, for such devices, node shouldn't be set to
> N_DEMOTION_TARGETS, so support is also added to set the demotion
> target list from user space so that default behavior can be overridden
> to avoid or add specific node to demotion targets manually.
> 
> Override the demotion targets in the system (which sets the
> node_states[N_DEMOTION_TARGETS] in kernel),
> $ echo <node list> > /sys/devices/system/node/demotion_targets
> 
> As by default node attributes under /sys/devices/system/node/ are read-
> only, support is added to write node_states[] via sysfs so that
> node_states[N_DEMOTION_TARGETS] can be modified from user space via
> sysfs.
> 
> It is also helpful to know per node demotion target path prepared by
> kernel to understand the demotion behaviour during reclaim, so this
> patch series also adds a /sys/devices/system/node/nodeX/demotion_targets
> interface to view per-node demotion targets via sysfs.
> 
> Current code which sets migration targets is modified in
> this patch series to avoid some of the limitations on the demotion
> target sharing and to use N_DEMOTION_TARGETS only nodes while
> finding demotion targets.
> 
> Changelog
> ----------
> 
> v2:
> In v1, only 1st patch of this patch series was sent, which was
> implemented to avoid some of the limitations on the demotion
> target sharing, however for certain numa topology, the demotion
> targets found by that patch was not most optimal, so 1st patch
> in this series is modified according to suggestions from Huang
> and Baolin. Different examples of demotion list comparasion
> between existing implementation and changed implementation can
> be found in the commit message of 1st patch.
> 
> v3:
> - Modify patch 1 subject to make it more specific
> - Remove /sys/kernel/mm/numa/demotion_targets interface, use
>   /sys/devices/system/node/demotion_targets instead and make
>   it writable to override node_states[N_DEMOTION_TARGETS].
> - Add support to view per node demotion targets via sysfs
> 
> Jagdish Gediya (8):
>   mm: demotion: Fix demotion targets sharing among sources
>   mm: demotion: Add new node state N_DEMOTION_TARGETS
>   drivers/base/node: Add support to write node_states[] via sysfs
>   device-dax/kmem: Set node state as N_DEMOTION_TARGETS
>   mm: demotion: Build demotion list based on N_DEMOTION_TARGETS
>   mm: demotion: expose per-node demotion targets via sysfs
>   docs: numa: Add documentation for demotion
> 
>  Documentation/admin-guide/mm/index.rst        |  1 +
>  .../admin-guide/mm/numa_demotion.rst          | 57 +++++++++++++++
>  drivers/base/node.c                           | 70 ++++++++++++++++---
>  drivers/dax/kmem.c                            |  2 +
>  include/linux/migrate.h                       |  1 +
>  include/linux/nodemask.h                      |  1 +
>  mm/migrate.c                                  | 54 ++++++++++----
>  7 files changed, 162 insertions(+), 24 deletions(-)
>  create mode 100644 Documentation/admin-guide/mm/numa_demotion.rst
> 


