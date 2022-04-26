Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3762E50F926
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345384AbiDZJxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347924AbiDZJxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:53:25 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6DB1DA74
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650964217; x=1682500217;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mhc1LkdFmJv5cdHaRlQmMd4IHZo0mxKiF8Rnx8DSyb4=;
  b=eZ8IqjlK0n/cMo5eTyfPPZyo+Ehdp88vjoREeFbvHjmtfzmh2rcv2L1O
   q5ogC0ClkccvRpv1OqVR14+UHP1rwXPvdbGLXQpV9PHKv9pkUrFZh34cy
   znorVHM81AwvgcPgl2NyHdNd6I6XCOYAz3cJf66MNGH3gADhv9lBHzfF9
   xZvlBlVcvINvdDNiQLfWGPA+kYESZvdtJ4u5mDfGOCJ3KSPJqabIiR3PS
   0UPsAdWPBZEHcoohcEv5lnIp8ho3GMeZuLwfJltqowVYxaGlKqmDH2WD2
   yI2EsP92p1+fSDTCH/qyB6lcib+yE1DAjOJWO8Z6gZ7pNQuBV/B9pE+J/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="246073676"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="246073676"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 02:10:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="532564643"
Received: from yyu16-mobl.ccr.corp.intel.com ([10.254.212.128])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 02:10:07 -0700
Message-ID: <8cd54998029dd59dc2f6a04b698f75df021294c2.camel@intel.com>
Subject: Re: [PATCH v3 0/7] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        dave.hansen@linux.intel.com, shy828301@gmail.com,
        weixugc@google.com, gthelen@google.com, dan.j.williams@intel.com
Date:   Tue, 26 Apr 2022 17:10:04 +0800
In-Reply-To: <63b0c4ab-861c-3d07-4912-e6cd842d0bfd@linux.ibm.com>
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
         <4b986b46afb2fe888c127d8758221d0f0d3ec55f.camel@intel.com>
         <YmaC2jw6WaQ4X+8W@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
         <085260285e48093f48d889994aaa500a78577bf2.camel@intel.com>
         <63b0c4ab-861c-3d07-4912-e6cd842d0bfd@linux.ibm.com>
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

On Tue, 2022-04-26 at 14:37 +0530, Aneesh Kumar K V wrote:
> On 4/26/22 1:25 PM, ying.huang@intel.com wrote:
> > On Mon, 2022-04-25 at 16:45 +0530, Jagdish Gediya wrote:
> > > On Sun, Apr 24, 2022 at 11:19:53AM +0800, ying.huang@intel.com wrote:
> > > > On Sat, 2022-04-23 at 01:25 +0530, Jagdish Gediya wrote:
> > > > > Some systems(e.g. PowerVM) can have both DRAM(fast memory) only
> > > > > NUMA node which are N_MEMORY and slow memory(persistent memory)
> > > > > only NUMA node which are also N_MEMORY. As the current demotion
> > > > > target finding algorithm works based on N_MEMORY and best distance,
> > > > > it will choose DRAM only NUMA node as demotion target instead of
> > > > > persistent memory node on such systems. If DRAM only NUMA node is
> > > > > filled with demoted pages then at some point new allocations can
> > > > > start falling to persistent memory, so basically cold pages are in
> > > > > fast memor (due to demotion) and new pages are in slow memory, this
> > > > > is why persistent memory nodes should be utilized for demotion and
> > > > > dram node should be avoided for demotion so that they can be used
> > > > > for new allocations.
> > > > > 
> > > > > Current implementation can work fine on the system where the memory
> > > > > only numa nodes are possible only for persistent/slow memory but it
> > > > > is not suitable for the like of systems mentioned above.
> > > > 
> > > > Can you share the NUMA topology information of your machine?  And the
> > > > demotion order before and after your change?
> > > > 
> > > > Whether it's good to use the PMEM nodes as the demotion targets of the
> > > > DRAM-only node too?
> > > 
> > > $ numactl -H
> > > available: 2 nodes (0-1)
> > > node 0 cpus: 0 1 2 3 4 5 6 7
> > > node 0 size: 14272 MB
> > > node 0 free: 13392 MB
> > > node 1 cpus:
> > > node 1 size: 2028 MB
> > > node 1 free: 1971 MB
> > > node distances:
> > > node   0   1
> > >    0:  10  40
> > >    1:  40  10
> > > 
> > > 1) without N_DEMOTION_TARGETS patch series, 1 is demotion target
> > >     for 0 even when 1 is DRAM node and there is no demotion targets for 1.
> > > 
> > > $ cat /sys/bus/nd/devices/dax0.0/target_node
> > > 2
> > > $
> > > # cd /sys/bus/dax/drivers/
> > > :/sys/bus/dax/drivers# ls
> > > device_dax  kmem
> > > :/sys/bus/dax/drivers# cd device_dax/
> > > :/sys/bus/dax/drivers/device_dax# echo dax0.0 > unbind
> > > :/sys/bus/dax/drivers/device_dax# echo dax0.0 >  ../kmem/new_id
> > > :/sys/bus/dax/drivers/device_dax# numactl -H
> > > available: 3 nodes (0-2)
> > > node 0 cpus: 0 1 2 3 4 5 6 7
> > > node 0 size: 14272 MB
> > > node 0 free: 13380 MB
> > > node 1 cpus:
> > > node 1 size: 2028 MB
> > > node 1 free: 1961 MB
> > > node 2 cpus:
> > > node 2 size: 0 MB
> > > node 2 free: 0 MB
> > > node distances:
> > > node   0   1   2
> > >    0:  10  40  80
> > >    1:  40  10  80
> > >    2:  80  80  10
> > > 
> > 
> > This looks like a virtual machine, not a real machine.  That's
> > unfortunate.  I am looking forward to a real issue, not a theoritical
> > possible issue.
> > 
> 
> This is the source of confusion i guess. A large class of ppc64 systems 
> are virtualized. The firmware include a hypervisor (PowerVM) and end 
> user creates guest (aka LPAR) on them. That is the way end user will use 
> this system. There is no baremetal access on this (There is an openpower 
> variant, but all new systems built by IBM these days do have PowerVM on 
> them).
> 
> 
> So this is not a theoretical possibility.
> 

Now I get it.  Thanks for detailed explanation.

Best Regards,
Huang, Ying



