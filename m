Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C36A50AC4E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442757AbiDUXvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442767AbiDUXu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:50:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D7C35A9C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 16:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650584888; x=1682120888;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/iAfJbA00NhJs+oCOoBffPoIVvo9aQv+NOCiGNBITsA=;
  b=DaFWIgKyRk6kDuHprs0WhbebfyrOlzlBhULqgx3kVRBNviGIKClNBJP+
   zFrsYah8wV/YdI3khmUXhD34sInPGfsCs4wTOqLHMoOqHXkSEJcJXfHuZ
   jjEcwjppJ5wSkth1rxQ+0tQ8UOs6nrDj68UF1NEv1YhfwtG254iOu4sOo
   mpYLsfZLtwB3VX+F+eZlgwBro09qxpuXKWy+Sz5PE89T7Kb22OHw0e0ZU
   eJVZTSiVWKgmRlLvqgXJJdk7QRyCapMZ5Ynji1TjrfHvh5LXnmRhSa6U2
   h9PHMPK9ozsu8tJ81VeUOVTHVCmq88/vMtl6l7mj0dOOilb4Ii5er5THv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264289224"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="264289224"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 16:48:07 -0700
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="556052718"
Received: from zhouju8x-mobl.ccr.corp.intel.com ([10.254.212.221])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 16:48:04 -0700
Message-ID: <0dc429a8e8349f82df7e1f10971929b71e45a87f.camel@intel.com>
Subject: Re: [PATCH v2 0/5] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Yang Shi <shy828301@gmail.com>, Wei Xu <weixugc@google.com>
Cc:     Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Thelen <gthelen@google.com>
Date:   Fri, 22 Apr 2022 07:48:01 +0800
In-Reply-To: <CAHbLzkqrxTpWT9q9xavGF+HZQNeNp13OATj248fb1rfCGKTu8A@mail.gmail.com>
References: <20220413092206.73974-1-jvgediya@linux.ibm.com>
         <6365983a8fbd8c325bb18959c51e9417fd821c91.camel@intel.com>
         <CAHbLzkpGzEaSDfM=GBzBxw=dZTBy12vgDDhMG+q4dbG+bCgR6A@mail.gmail.com>
         <CAAPL-u9=-OHuUk=ZkNRDf3Dm_+3cBd2APL5MQpQr3_sVk_voJg@mail.gmail.com>
         <CAHbLzkqrxTpWT9q9xavGF+HZQNeNp13OATj248fb1rfCGKTu8A@mail.gmail.com>
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

On Thu, 2022-04-21 at 10:56 -0700, Yang Shi wrote:
> On Wed, Apr 20, 2022 at 10:41 PM Wei Xu <weixugc@google.com> wrote:
> > 
> > On Wed, Apr 20, 2022 at 8:12 PM Yang Shi <shy828301@gmail.com> wrote:
> > > 
> > > On Thu, Apr 14, 2022 at 12:00 AM ying.huang@intel.com
> > > <ying.huang@intel.com> wrote:
> > > > 
> > > > On Wed, 2022-04-13 at 14:52 +0530, Jagdish Gediya wrote:
> > > > > Current implementation to find the demotion targets works
> > > > > based on node state N_MEMORY, however some systems may have
> > > > > dram only memory numa node which are N_MEMORY but not the
> > > > > right choices as demotion targets.
> > > > > 
> > > > > This patch series introduces the new node state
> > > > > N_DEMOTION_TARGETS, which is used to distinguish the nodes which
> > > > > can be used as demotion targets, node_states[N_DEMOTION_TARGETS]
> > > > > is used to hold the list of nodes which can be used as demotion
> > > > > targets, support is also added to set the demotion target
> > > > > list from user space so that default behavior can be overridden.
> > > > 
> > > > It appears that your proposed user space interface cannot solve all
> > > > problems.  For example, for system as follows,
> > > > 
> > > > Node 0 & 2 are cpu + dram nodes and node 1 are slow memory node near
> > > > node 0,
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
> > > >   0:  10  40  20
> > > >   1:  40  10  80
> > > >   2:  20  80  10
> > > > 
> > > > Demotion order 1:
> > > > 
> > > > node    demotion_target
> > > >  0              1
> > > >  1              X
> > > >  2              X
> > > > 
> > > > Demotion order 2:
> > > > 
> > > > node    demotion_target
> > > >  0              1
> > > >  1              X
> > > >  2              1
> > > > 
> > > > The demotion order 1 is preferred if we want to reduce cross-socket
> > > > traffic.  While the demotion order 2 is preferred if we want to take
> > > > full advantage of the slow memory node.  We can take any choice as
> > > > automatic-generated order, while make the other choice possible via user
> > > > space overridden.
> > > > 
> > > > I don't know how to implement this via your proposed user space
> > > > interface.  How about the following user space interface?
> > > > 
> > > > 1. Add a file "demotion_order_override" in
> > > >         /sys/devices/system/node/
> > > > 
> > > > 2. When read, "1" is output if the demotion order of the system has been
> > > > overridden; "0" is output if not.
> > > > 
> > > > 3. When write "1", the demotion order of the system will become the
> > > > overridden mode.  When write "0", the demotion order of the system will
> > > > become the automatic mode and the demotion order will be re-generated.
> > > > 
> > > > 4. Add a file "demotion_targets" for each node in
> > > >         /sys/devices/system/node/nodeX/
> > > > 
> > > > 5. When read, the demotion targets of nodeX will be output.
> > > > 
> > > > 6. When write a node list to the file, the demotion targets of nodeX
> > > > will be set to the written nodes.  And the demotion order of the system
> > > > will become the overridden mode.
> > > 
> > > TBH I don't think having override demotion targets in userspace is
> > > quite useful in real life for now (it might become useful in the
> > > future, I can't tell). Imagine you manage hundred thousands of
> > > machines, which may come from different vendors, have different
> > > generations of hardware, have different versions of firmware, it would
> > > be a nightmare for the users to configure the demotion targets
> > > properly. So it would be great to have the kernel properly configure
> > > it *without* intervening from the users.
> > > 
> > > So we should pick up a proper default policy and stick with that
> > > policy unless it doesn't work well for the most workloads. I do
> > > understand it is hard to make everyone happy. My proposal is having
> > > every node in the fast tier has a demotion target (at least one) if
> > > the slow tier exists sounds like a reasonable default policy. I think
> > > this is also the current implementation.
> > > 
> > 
> > This is reasonable.  I agree that with a decent default policy, the
> > overriding of per-node demotion targets can be deferred.  The most
> > important problem here is that we should allow the configurations
> > where memory-only nodes are not used as demotion targets, which this
> > patch set has already addressed.
> 
> Yes, I agree. Fixing the bug and allowing override by userspace are
> totally two separate things.
> 

Yes.  I agree with the separating thing, although [1/5] doesn't fix the
bug, but improve the automatic order generation method.  So I think it's
better to separate this patchset into 2 patchsets.  [1/5] is for
improving the automatic order generation.  The [2-5/5] is for user space
overriding.

Best Regards,
Huang, Ying

> > 
> > > > 
> > > > To reduce the complexity, the demotion order of the system is either in
> > > > overridden mode or automatic mode.  When converting from the automatic
> > > > mode to the overridden mode, the existing demotion targets of all nodes
> > > > will be retained before being changed.  When converting from overridden
> > > > mode to automatic mode, the demotion order of the system will be re-
> > > > generated automatically.
> > > > 
> > > > In overridden mode, the demotion targets of the hot-added and hot-
> > > > removed node will be set to empty.  And the hot-removed node will be
> > > > removed from the demotion targets of any node.
> > > > 
> > > > This is an extention of the interface used in the following patch,
> > > > 
> > > > https://lore.kernel.org/lkml/20191016221149.74AE222C@viggo.jf.intel.com/
> > > > 
> > > > What do you think about this?
> > > > 
> > > > > node state N_DEMOTION_TARGETS is also set from the dax kmem
> > > > > driver, certain type of memory which registers through dax kmem
> > > > > (e.g. HBM) may not be the right choices for demotion so in future
> > > > > they should be distinguished based on certain attributes and dax
> > > > > kmem driver should avoid setting them as N_DEMOTION_TARGETS,
> > > > > however current implementation also doesn't distinguish any
> > > > > such memory and it considers all N_MEMORY as demotion targets
> > > > > so this patch series doesn't modify the current behavior.
> > > > > 
> > > > 
> > > > Best Regards,
> > > > Huang, Ying
> > > > 
> > > > [snip]
> > > > 


