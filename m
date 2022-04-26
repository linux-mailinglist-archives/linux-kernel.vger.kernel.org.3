Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D6750F331
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244639AbiDZH7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241671AbiDZH6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:58:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB85186FA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650959741; x=1682495741;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qGTVGpOWIBsbz827s0W0H9uEW9OJVBxXGTBDbcXs9XE=;
  b=SlI1qbfNyX1wnLxFggbCc77ZNj0cA/Umfgt6vi1MmM7FeyoYQzDO/+Nq
   yPJO9lhT/8R0rTEDIJ+Q+ufVBqW4okv0iCBrgd39JWn9jhvaqTqZVs51u
   4cenRWNW83lohyF+lIEXRxGbf7i3LhmsnJxBilupc7zWmeJ8t1z7OBWQ/
   2DH9c1qX4alj83QS82KrhS8NV+uM2kN/AlGKoRUQSoSroHLXCeOdHFbL1
   7RPQEfy7SHCGrkh2DvA9/gb3Wgloxt+La/a3BH1SLLYwqvZxTy/tsIu/G
   nu5cIFELeHjSuvuQ0IOmrog5dX3dGvkVnaoKeeE/KLMeB62nqaRJU9/1Q
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="246052022"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="246052022"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 00:55:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="579747841"
Received: from yyu16-mobl.ccr.corp.intel.com ([10.254.212.128])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 00:55:38 -0700
Message-ID: <085260285e48093f48d889994aaa500a78577bf2.camel@intel.com>
Subject: Re: [PATCH v3 0/7] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        dave.hansen@linux.intel.com, aneesh.kumar@linux.ibm.com,
        shy828301@gmail.com, weixugc@google.com, gthelen@google.com,
        dan.j.williams@intel.com
Date:   Tue, 26 Apr 2022 15:55:36 +0800
In-Reply-To: <YmaC2jw6WaQ4X+8W@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
         <4b986b46afb2fe888c127d8758221d0f0d3ec55f.camel@intel.com>
         <YmaC2jw6WaQ4X+8W@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
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

On Mon, 2022-04-25 at 16:45 +0530, Jagdish Gediya wrote:
> On Sun, Apr 24, 2022 at 11:19:53AM +0800, ying.huang@intel.com wrote:
> > On Sat, 2022-04-23 at 01:25 +0530, Jagdish Gediya wrote:
> > > Some systems(e.g. PowerVM) can have both DRAM(fast memory) only
> > > NUMA node which are N_MEMORY and slow memory(persistent memory)
> > > only NUMA node which are also N_MEMORY. As the current demotion
> > > target finding algorithm works based on N_MEMORY and best distance,
> > > it will choose DRAM only NUMA node as demotion target instead of
> > > persistent memory node on such systems. If DRAM only NUMA node is
> > > filled with demoted pages then at some point new allocations can
> > > start falling to persistent memory, so basically cold pages are in
> > > fast memor (due to demotion) and new pages are in slow memory, this
> > > is why persistent memory nodes should be utilized for demotion and
> > > dram node should be avoided for demotion so that they can be used
> > > for new allocations.
> > > 
> > > Current implementation can work fine on the system where the memory
> > > only numa nodes are possible only for persistent/slow memory but it
> > > is not suitable for the like of systems mentioned above.
> > 
> > Can you share the NUMA topology information of your machine?  And the
> > demotion order before and after your change?
> > 
> > Whether it's good to use the PMEM nodes as the demotion targets of the
> > DRAM-only node too?
> 
> $ numactl -H
> available: 2 nodes (0-1)
> node 0 cpus: 0 1 2 3 4 5 6 7
> node 0 size: 14272 MB
> node 0 free: 13392 MB
> node 1 cpus:
> node 1 size: 2028 MB
> node 1 free: 1971 MB
> node distances:
> node   0   1
>   0:  10  40
>   1:  40  10
> 
> 1) without N_DEMOTION_TARGETS patch series, 1 is demotion target
>    for 0 even when 1 is DRAM node and there is no demotion targets for 1.
> 
> $ cat /sys/bus/nd/devices/dax0.0/target_node
> 2
> $
> # cd /sys/bus/dax/drivers/
> :/sys/bus/dax/drivers# ls
> device_dax  kmem
> :/sys/bus/dax/drivers# cd device_dax/
> :/sys/bus/dax/drivers/device_dax# echo dax0.0 > unbind
> :/sys/bus/dax/drivers/device_dax# echo dax0.0 >  ../kmem/new_id
> :/sys/bus/dax/drivers/device_dax# numactl -H
> available: 3 nodes (0-2)
> node 0 cpus: 0 1 2 3 4 5 6 7
> node 0 size: 14272 MB
> node 0 free: 13380 MB
> node 1 cpus:
> node 1 size: 2028 MB
> node 1 free: 1961 MB
> node 2 cpus:
> node 2 size: 0 MB
> node 2 free: 0 MB
> node distances:
> node   0   1   2
>   0:  10  40  80
>   1:  40  10  80
>   2:  80  80  10
> 

This looks like a virtual machine, not a real machine.  That's
unfortunate.  I am looking forward to a real issue, not a theoritical
possible issue.

> 2) Once this new node brought online,  without N_DEMOTION_TARGETS
> patch series, 1 is demotion target for 0 and 2 is demotion target
> for 1.
> 
> With this patch series applied,
> 1) No demotion target for either 0 or 1 before dax device is online
> 2) 2 is demotion target for both 0 and 1 after dax device is online.
> 

So with your change, if a node hasn't N_DEMOTION_TARGETS, it will become
a top-level demotion source even if it hasn't N_CPU?  If so, I cannot
clear N_DEMOTION_TARGETS for a node in middle or bottom level?

Best Regards,
Huang, Ying

> > 
[snip]


