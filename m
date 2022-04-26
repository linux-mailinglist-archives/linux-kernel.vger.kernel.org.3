Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A3D50F8DE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347267AbiDZJXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346445AbiDZJAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:00:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760D83C4AF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 01:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650962589; x=1682498589;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PCKSkgxENXrIx/upYwDnX/aD/0BDc2Wep/1AmAXydiA=;
  b=Bo2mUW5sZNNhaEzg1cAyqflBEarN17U84adT/J0gjoCKwwH+zmOyTeji
   KUu/hg0Mvq2Fz9ocoFXvrpF3ga1yc8sJp9NJDL0g4n1d0n7dRp4365jkB
   H2P0EMu14PH6/EVXcQt4Hi9BsoVZVe+AM5+X1XP4AwjVdxeekZLPXkT00
   K64tLc9BSj6qaeC5M99dfwe4vFy2ALVKKxjVOyMiLDlhKHHJLRVdC/ztr
   Rc6Mm/kHPJkTYJ9YdsMHv/d3sdjMEIcue7BsbtNxSeN4t6oKJS02Gllek
   svjyxh7enF9I3qu9YkkyT/WdX9/obMPk01q01kQOITMqpBQCiCmrQMmP0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="245424101"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="245424101"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 01:42:55 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="579771450"
Received: from yyu16-mobl.ccr.corp.intel.com ([10.254.212.128])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 01:42:51 -0700
Message-ID: <9a0fe756ae3af78f2612dcf2df9673053a7ebab2.camel@intel.com>
Subject: Re: [PATCH v2 0/5] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        MichalHocko <mhocko@kernel.org>,
        Brice Goglin <brice.goglin@gmail.com>
Date:   Tue, 26 Apr 2022 16:42:49 +0800
In-Reply-To: <c576a992-5a50-5dd3-644c-a45d4338fc85@linux.ibm.com>
References: <CAAPL-u_pSWD6U0yQ8Ws+_Yfb_3ZEmNXJsYcRJjAFBkyDk=nq8g@mail.gmail.com>
         <ea73f6fda9cafdd0cb6ba8351139e6f4b47354a8.camel@intel.com>
         <CAAPL-u-aeceXFUNdok_GYb2aLhZa0zBBuSqHxFznQob3PbJt7Q@mail.gmail.com>
         <a80647053bba44623094995730e061f0e6129677.camel@intel.com>
         <CAAPL-u89Jxutu1VH0LnO5VGdMbkLvc2M9eapuwP-y9oG9QSsrA@mail.gmail.com>
         <610ccaad03f168440ce765ae5570634f3b77555e.camel@intel.com>
         <CAAPL-u9ktM82zAW_OVwqTmQsr-XC8XOPmAsjoiCLo18cxUWA=A@mail.gmail.com>
         <8e31c744a7712bb05dbf7ceb2accf1a35e60306a.camel@intel.com>
         <CAAPL-u9uP+FUh7Yn0ByOECo+EP32ZABnCvNPKQB9JCA68VHEqQ@mail.gmail.com>
         <78b5f4cfd86efda14c61d515e4db9424e811c5be.camel@intel.com>
         <YmKKwXa2XI/nwac0@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
         <200e95cf36c1642512d99431014db8943fed715d.camel@intel.com>
         <8735i1zurt.fsf@linux.ibm.com>
         <ea9d01e16de655af85c0041c96964d83f59fb6d2.camel@intel.com>
         <c576a992-5a50-5dd3-644c-a45d4338fc85@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-25 at 13:39 +0530, Aneesh Kumar K V wrote:
> On 4/25/22 11:40 AM, ying.huang@intel.com wrote:
> > On Mon, 2022-04-25 at 09:20 +0530, Aneesh Kumar K.V wrote:
> > > "ying.huang@intel.com" <ying.huang@intel.com> writes:
> > > 
> > > > Hi, All,
> > > > 
> > > > On Fri, 2022-04-22 at 16:30 +0530, Jagdish Gediya wrote:
> > > > 
> > > > [snip]
> > > > 
> > > > > I think it is necessary to either have per node demotion targets
> > > > > configuration or the user space interface supported by this patch
> > > > > series. As we don't have clear consensus on how the user interface
> > > > > should look like, we can defer the per node demotion target set
> > > > > interface to future until the real need arises.
> > > > > 
> > > > > Current patch series sets N_DEMOTION_TARGET from dax device kmem
> > > > > driver, it may be possible that some memory node desired as demotion
> > > > > target is not detected in the system from dax-device kmem probe path.
> > > > > 
> > > > > It is also possible that some of the dax-devices are not preferred as
> > > > > demotion target e.g. HBM, for such devices, node shouldn't be set to
> > > > > N_DEMOTION_TARGETS. In future, Support should be added to distinguish
> > > > > such dax-devices and not mark them as N_DEMOTION_TARGETS from the
> > > > > kernel, but for now this user space interface will be useful to avoid
> > > > > such devices as demotion targets.
> > > > > 
> > > > > We can add read only interface to view per node demotion targets
> > > > > from /sys/devices/system/node/nodeX/demotion_targets, remove
> > > > > duplicated /sys/kernel/mm/numa/demotion_target interface and instead
> > > > > make /sys/devices/system/node/demotion_targets writable.
> > > > > 
> > > > > Huang, Wei, Yang,
> > > > > What do you suggest?
> > > > 
> > > > We cannot remove a kernel ABI in practice.  So we need to make it right
> > > > at the first time.  Let's try to collect some information for the kernel
> > > > ABI definitation.
> > > > 
> > > > The below is just a starting point, please add your requirements.
> > > > 
> > > > 1. Jagdish has some machines with DRAM only NUMA nodes, but they don't
> > > > want to use that as the demotion targets.  But I don't think this is a
> > > > issue in practice for now, because demote-in-reclaim is disabled by
> > > > default.
> > > 
> > > It is not just that the demotion can be disabled. We should be able to
> > > use demotion on a system where we can find DRAM only NUMA nodes. That
> > > cannot be achieved by /sys/kernel/mm/numa/demotion_enabled. It needs
> > > something similar to to N_DEMOTION_TARGETS
> > > 
> > 
> > Can you show NUMA information of your machines with DRAM-only nodes and
> > PMEM nodes?  We can try to find the proper demotion order for the
> > system.  If you can not show it, we can defer N_DEMOTION_TARGETS until
> > the machine is available.
> 
> 
> Sure will find one such config. As you might have noticed this is very 
> easy to have in a virtualization setup because the hypervisor can assign 
> memory to a guest VM from a numa node that doesn't have CPU assigned to 
> the same guest. This depends on the other guest VM instance config 
> running on the system. So on any virtualization config that has got 
> persistent memory attached, this can become an easy config to end up with.
> 

Why they want to do that?  I am looking forward to a real issue, not
theoritical possibility.

> 
> > > > 2. For machines with PMEM installed in only 1 of 2 sockets, for example,
> > > > 
> > > > Node 0 & 2 are cpu + dram nodes and node 1 are slow
> > > > memory node near node 0,
> > > > 
> > > > available: 3 nodes (0-2)
> > > > node 0 cpus: 0 1
> > > > node 0 size: n MB
> > > > node 0 free: n MB
> > > > node 1 cpus:
> > > > node 1 size: n MB
> > > > node 1 free: n MB
> > > > node 2 cpus: 2 3
> > > > node 2 size: n MB
> > > > node 2 free: n MB
> > > > node distances:
> > > > node   0   1   2
> > > >    0:  10  40  20
> > > >    1:  40  10  80
> > > >    2:  20  80  10
> > > > 
> > > > We have 2 choices,
> > > > 
> > > > a)
> > > > node	demotion targets
> > > > 0	1
> > > > 2	1
> > > 
> > > This is achieved by
> > > 
> > > [PATCH v2 1/5] mm: demotion: Set demotion list differently
> > > 
> > > > 
> > > > b)
> > > > node	demotion targets
> > > > 0	1
> > > > 2	X
> > > 
> > > 
> > > > 
> > > > a) is good to take advantage of PMEM.  b) is good to reduce cross-socket
> > > > traffic.  Both are OK as defualt configuration.  But some users may
> > > > prefer the other one.  So we need a user space ABI to override the
> > > > default configuration.
> > > > 
> > > > 3. For machines with HBM (High Bandwidth Memory), as in
> > > > 
> > > > https://lore.kernel.org/lkml/39cbe02a-d309-443d-54c9-678a0799342d@gmail.com/
> > > > 
> > > > > [1] local DDR = 10, remote DDR = 20, local HBM = 31, remote HBM = 41
> > > > 
> > > > Although HBM has better performance than DDR, in ACPI SLIT, their
> > > > distance to CPU is longer.  We need to provide a way to fix this.  The
> > > > user space ABI is one way.  The desired result will be to use local DDR
> > > > as demotion targets of local HBM.
> > > 
> > > 
> > > IMHO the above (2b and 3) can be done using per node demotion targets. Below is
> > > what I think we could do with a single slow memory NUMA node 4.
> > 
> > If we can use writable per-node demotion targets as ABI, then we don't
> > need N_DEMOTION_TARGETS.
> 
> 
> Not sure I understand that. Yes, once you have a writeable per node 
> demotion target it is easy to build any demotion order.

Yes.

> But that doesn't 
> mean we should not improve the default unless you have reason to say 
> that using N_DEMOTTION_TARGETS breaks any existing config.
> 

Becuase N_DEMOTTION_TARGETS is a new kernel ABI to override the default,
not the default itself.  [1/5] of this patchset improve the default
behavior itself, and I think that's good.

Because we must maintain the kernel ABI almost for ever, we need to be
careful about adding new ABI and add less if possible.  If writable per-
node demotion targets can address your issue.  Then it's unnecessary to
add another redundant kernel ABI for that.

> > > /sys/devices/system/node# cat node[0-4]/demotion_targets
> > > 4
> > > 4
> > > 4
> > > 4
> > > 
> > > /sys/devices/system/node# echo 1 > node1/demotion_targets
> > > bash: echo: write error: Invalid argument
> > > /sys/devices/system/node# cat node[0-4]/demotion_targets
> > > 4
> > > 4
> > > 4
> > > 4
> > > 
> > > /sys/devices/system/node# echo 0 > node1/demotion_targets
> > > /sys/devices/system/node# cat node[0-4]/demotion_targets
> > > 4
> > > 0
> > > 4
> > > 4
> > > 
> > > /sys/devices/system/node# echo 1 > node0/demotion_targets
> > > bash: echo: write error: Invalid argument
> > > /sys/devices/system/node# cat node[0-4]/demotion_targets
> > > 4
> > > 0
> > > 4
> > > 4
> > > 
> > > Disable demotion for a specific node.
> > > /sys/devices/system/node# echo > node1/demotion_targets
> > > /sys/devices/system/node# cat node[0-4]/demotion_targets
> > > 4
> > > 
> > > 4
> > > 4
> > > 
> > > Reset demotion to default
> > > /sys/devices/system/node# echo -1 > node1/demotion_targets
> > > /sys/devices/system/node# cat node[0-4]/demotion_targets
> > > 4
> > > 4
> > > 4
> > > 4
> > > 
> > > When a specific device/NUMA node is used for demotion target via the user interface, it is taken
> > > out of other NUMA node targets.
> > 
> > IMHO, we should be careful about interaction between auto-generated and
> > overridden demotion order.
> > 
> 
> yes, we should avoid loop between that.

In addition to that, we need to get same result after hot-remove then
hot-add the same node.  That is, the result should be stable after NOOP.
I guess we can just always,

- Generate the default demotion order automatically without any
overriding.

- Apply the overriding, after removing the invalid targets, etc.

> But if you agree for the above 
> ABI we could go ahead and share the implementation code.

I think we need to add a way to distinguish auto-generated and overriden
demotion targets in the output of nodeX/demotion_targets.  Otherwise it
looks good to me.

Best Regards,
Huang, Ying

> > > root@ubuntu-guest:/sys/devices/system/node# cat node[0-4]/demotion_targets
> > > 4
> > > 4
> > > 4
> > > 4
> > > 
> > > /sys/devices/system/node# echo 4 > node1/demotion_targets
> > > /sys/devices/system/node# cat node[0-4]/demotion_targets
> > > 
> > > 4
> > > 
> > > 
> > > 
> > > If more than one node requies the same demotion target
> > > /sys/devices/system/node# echo 4 > node0/demotion_targets
> > > /sys/devices/system/node# cat node[0-4]/demotion_targets
> > > 4
> > > 4
> > > 
> > > 
> > > 
> > > -aneesh
> > 
> > 
> 
> -aneesh


