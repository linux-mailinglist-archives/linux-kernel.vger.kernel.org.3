Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A912A5098D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385598AbiDUHLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355444AbiDUHLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:11:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBD4167CE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650524934; x=1682060934;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HaRBg4+XLdpGv2/lsuEUgBRp2eJFtmoR9sNtCjPghKE=;
  b=PpPdGehbnIYwWFQLm6y6aNovYeU4xkAyPc3uXRlvgvCKv87KrK5xNRHs
   8LJQPQxzO/tMK8jOFpK3lZQEzFfpfqGKMDI6q1De/w0HTOwfV6EnJIIMO
   9MbSsyYo2gB+FNOO49SdCb2bkPWgUipTRcbewlR8EVGy4Vw8fsuJr/Tbc
   4vfTXIgPMc/Dvd/lGxOUgb9h7JRNJlqa04h7u3Ea3LtGXvxoxuzprDmxR
   F//Y75PLNrUvUk5xBgQnzmLGuxkXqlDa4kRg1u7/zzf9tqY4eNXBNuVcH
   dsl3M7pxmxsoGzl7S7WZfwY3aSThPMhY6gq7nvbSg5KWae6ROj59BlYlY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263728412"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="263728412"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 00:08:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="577062744"
Received: from hanyulon-mobl1.ccr.corp.intel.com ([10.254.214.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 00:08:50 -0700
Message-ID: <ea73f6fda9cafdd0cb6ba8351139e6f4b47354a8.camel@intel.com>
Subject: Re: [PATCH v2 0/5] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Wei Xu <weixugc@google.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Thelen <gthelen@google.com>
Date:   Thu, 21 Apr 2022 15:08:48 +0800
In-Reply-To: <CAAPL-u_pSWD6U0yQ8Ws+_Yfb_3ZEmNXJsYcRJjAFBkyDk=nq8g@mail.gmail.com>
References: <20220413092206.73974-1-jvgediya@linux.ibm.com>
         <6365983a8fbd8c325bb18959c51e9417fd821c91.camel@intel.com>
         <CAHbLzkpGzEaSDfM=GBzBxw=dZTBy12vgDDhMG+q4dbG+bCgR6A@mail.gmail.com>
         <CAAPL-u9=-OHuUk=ZkNRDf3Dm_+3cBd2APL5MQpQr3_sVk_voJg@mail.gmail.com>
         <de1bc3647c8696fd931a37d314ccd60a2c8cc0db.camel@intel.com>
         <CAAPL-u_pSWD6U0yQ8Ws+_Yfb_3ZEmNXJsYcRJjAFBkyDk=nq8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-20 at 23:49 -0700, Wei Xu wrote:
> On Wed, Apr 20, 2022 at 11:24 PM ying.huang@intel.com
> <ying.huang@intel.com> wrote:
> > 
> > On Wed, 2022-04-20 at 22:41 -0700, Wei Xu wrote:
> > > On Wed, Apr 20, 2022 at 8:12 PM Yang Shi <shy828301@gmail.com> wrote:
> > > > 
> > > > On Thu, Apr 14, 2022 at 12:00 AM ying.huang@intel.com
> > > > <ying.huang@intel.com> wrote:
> > > > > 
> > > > > On Wed, 2022-04-13 at 14:52 +0530, Jagdish Gediya wrote:
> > > > > > Current implementation to find the demotion targets works
> > > > > > based on node state N_MEMORY, however some systems may have
> > > > > > dram only memory numa node which are N_MEMORY but not the
> > > > > > right choices as demotion targets.
> > > > > > 
> > > > > > This patch series introduces the new node state
> > > > > > N_DEMOTION_TARGETS, which is used to distinguish the nodes which
> > > > > > can be used as demotion targets, node_states[N_DEMOTION_TARGETS]
> > > > > > is used to hold the list of nodes which can be used as demotion
> > > > > > targets, support is also added to set the demotion target
> > > > > > list from user space so that default behavior can be overridden.
> > > > > 
> > > > > It appears that your proposed user space interface cannot solve all
> > > > > problems.  For example, for system as follows,
> > > > > 
> > > > > Node 0 & 2 are cpu + dram nodes and node 1 are slow memory node near
> > > > > node 0,
> > > > > 
> > > > > available: 3 nodes (0-2)
> > > > > node 0 cpus: 0 1
> > > > > node 0 size: n MB
> > > > > node 0 free: n MB
> > > > > node 1 cpus:
> > > > > node 1 size: n MB
> > > > > node 1 free: n MB
> > > > > node 2 cpus: 2 3
> > > > > node 2 size: n MB
> > > > > node 2 free: n MB
> > > > > node distances:
> > > > > node   0   1   2
> > > > >   0:  10  40  20
> > > > >   1:  40  10  80
> > > > >   2:  20  80  10
> > > > > 
> > > > > Demotion order 1:
> > > > > 
> > > > > node    demotion_target
> > > > >  0              1
> > > > >  1              X
> > > > >  2              X
> > > > > 
> > > > > Demotion order 2:
> > > > > 
> > > > > node    demotion_target
> > > > >  0              1
> > > > >  1              X
> > > > >  2              1
> > > > > 
> > > > > The demotion order 1 is preferred if we want to reduce cross-socket
> > > > > traffic.  While the demotion order 2 is preferred if we want to take
> > > > > full advantage of the slow memory node.  We can take any choice as
> > > > > automatic-generated order, while make the other choice possible via user
> > > > > space overridden.
> > > > > 
> > > > > I don't know how to implement this via your proposed user space
> > > > > interface.  How about the following user space interface?
> > > > > 
> > > > > 1. Add a file "demotion_order_override" in
> > > > >         /sys/devices/system/node/
> > > > > 
> > > > > 2. When read, "1" is output if the demotion order of the system has been
> > > > > overridden; "0" is output if not.
> > > > > 
> > > > > 3. When write "1", the demotion order of the system will become the
> > > > > overridden mode.  When write "0", the demotion order of the system will
> > > > > become the automatic mode and the demotion order will be re-generated.
> > > > > 
> > > > > 4. Add a file "demotion_targets" for each node in
> > > > >         /sys/devices/system/node/nodeX/
> > > > > 
> > > > > 5. When read, the demotion targets of nodeX will be output.
> > > > > 
> > > > > 6. When write a node list to the file, the demotion targets of nodeX
> > > > > will be set to the written nodes.  And the demotion order of the system
> > > > > will become the overridden mode.
> > > > 
> > > > TBH I don't think having override demotion targets in userspace is
> > > > quite useful in real life for now (it might become useful in the
> > > > future, I can't tell). Imagine you manage hundred thousands of
> > > > machines, which may come from different vendors, have different
> > > > generations of hardware, have different versions of firmware, it would
> > > > be a nightmare for the users to configure the demotion targets
> > > > properly. So it would be great to have the kernel properly configure
> > > > it *without* intervening from the users.
> > > > 
> > > > So we should pick up a proper default policy and stick with that
> > > > policy unless it doesn't work well for the most workloads. I do
> > > > understand it is hard to make everyone happy. My proposal is having
> > > > every node in the fast tier has a demotion target (at least one) if
> > > > the slow tier exists sounds like a reasonable default policy. I think
> > > > this is also the current implementation.
> > > > 
> > > 
> > > This is reasonable.  I agree that with a decent default policy,
> > > 
> > 
> > I agree that a decent default policy is important.  As that was enhanced
> > in [1/5] of this patchset.
> > 
> > > the
> > > overriding of per-node demotion targets can be deferred.  The most
> > > important problem here is that we should allow the configurations
> > > where memory-only nodes are not used as demotion targets, which this
> > > patch set has already addressed.
> > 
> > Do you mean the user space interface proposed by [3/5] of this patchset?
> 
> Yes.
> 
> > IMHO, if we want to add a user space interface, I think that it should
> > be powerful enough to address all existing issues and some potential
> > future issues, so that it can be stable.  I don't think it's a good idea
> > to define a partial user space interface that works only for a specific
> > use case and cannot be extended for other use cases.
> 
> I actually think that they can be viewed as two separate problems: one
> is to define which nodes can be used as demotion targets (this patch
> set), and the other is how to initialize the per-node demotion path
> (node_demotion[]).  We don't have to solve both problems at the same
> time.
> 
> If we decide to go with a per-node demotion path customization
> interface to indirectly set N_DEMOTION_TARGETS, I'd prefer that there
> is a single global control to turn off all demotion targets (for the
> machines that don't use memory-only nodes for demotion).
> 

There's one already.  In commit 20b51af15e01 ("mm/migrate: add sysfs
interface to enable reclaim migration"), a sysfs interface

	/sys/kernel/mm/numa/demotion_enabled

is added to turn off all demotion targets.

Best Regards,
Huang, Ying


