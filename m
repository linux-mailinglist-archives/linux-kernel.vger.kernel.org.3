Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6E052431E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 05:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245258AbiELDOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 23:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244981AbiELDOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 23:14:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FA7210126
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 20:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652325239; x=1683861239;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=caZlbfjgZOant41JIEcgL5HRsSvgBxitC5oYYew431M=;
  b=FN7gAjocReHemjL4E1b5uxFBgodRCDduBZWBMCMbLYyKJlvdV3z7jkP1
   hg2UhgWbpgOHDfhCo0mo8tpEhr0PHbTPklNnqqzKiZyU/sNTvdNcTyF2Y
   LIOZ1OPBJwc+jpz7bxmMYpPqM7WV5KHtA9jxPrcmUGXrghyK9jCU4e0oo
   gUCi3+S+giVSHU4Kv/qmXdVJ/e/HrPxO1Q9fwWa7mUyVo9h81Mf1ZWuKA
   YehQxNUraOqeJ+WN5iRsP6QcdqlcdGd5RVI8s1h+wAJi+Y517BIn79TJf
   ccb5aXeW2mk84G7pPQBtJwOxD805W0JmHmzJzyQrC09c0ZXZIIqTiXel7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269814285"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="269814285"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 20:13:58 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="594453592"
Received: from ruonanwa-mobl.ccr.corp.intel.com ([10.254.212.157])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 20:13:53 -0700
Message-ID: <be3b9f239fa46e968b333291910b2afd3e38bcba.camel@intel.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Wei Xu <weixugc@google.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Date:   Thu, 12 May 2022 11:13:48 +0800
In-Reply-To: <CAAPL-u_40Zxe2AtYbOedDXPBfDPDCqi-OS=yYXf2FcZQS-6v4g@mail.gmail.com>
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
         <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com>
         <CAAPL-u-r2Pc_MaHQmKKNH_icAa_fH1COWb5qSPpr8xffREQ_cQ@mail.gmail.com>
         <87tua3h5r1.fsf@nvdebian.thelocal>
         <CAAPL-u-0HwL6p1SA73LPfFyywG55QqE9O+q=83fhShoJAVVxyQ@mail.gmail.com>
         <875ymerl81.fsf@nvdebian.thelocal> <87fslhhb2l.fsf@linux.ibm.com>
         <CAAPL-u9FvCfgA7xsqStLNZ=W03iyWBmvHrpVzPKyitsGN2v_KQ@mail.gmail.com>
         <68333b21a58604f3fd0e660f1a39921ae22849d8.camel@intel.com>
         <CAAPL-u80BFYTKK=0HRBXOeDTULyPOtbgu5V3fEYDOczTMxgJ1g@mail.gmail.com>
         <0a92d0040edb3b74ac259062d241b8cd28924edf.camel@intel.com>
         <CAAPL-u_40Zxe2AtYbOedDXPBfDPDCqi-OS=yYXf2FcZQS-6v4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-11 at 19:39 -0700, Wei Xu wrote:
> On Wed, May 11, 2022 at 6:42 PM ying.huang@intel.com
> <ying.huang@intel.com> wrote:
> > 
> > On Wed, 2022-05-11 at 10:07 -0700, Wei Xu wrote:
> > > On Wed, May 11, 2022 at 12:49 AM ying.huang@intel.com
> > > <ying.huang@intel.com> wrote:
> > > > 
> > > > On Tue, 2022-05-10 at 22:30 -0700, Wei Xu wrote:
> > > > > On Tue, May 10, 2022 at 4:38 AM Aneesh Kumar K.V
> > > > > <aneesh.kumar@linux.ibm.com> wrote:
> > > > > > 
> > > > > > Alistair Popple <apopple@nvidia.com> writes:
> > > > > > 
> > > > > > > Wei Xu <weixugc@google.com> writes:
> > > > > > > 
> > > > > > > > On Thu, May 5, 2022 at 5:19 PM Alistair Popple <apopple@nvidia.com> wrote:
> > > > > > > > > 
> > > > > > > > > Wei Xu <weixugc@google.com> writes:
> > > > > > > > > 
> > > > > > > > > [...]
> > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > Tiering Hierarchy Initialization
> > > > > > > > > > > > `=============================='
> > > > > > > > > > > > 
> > > > > > > > > > > > By default, all memory nodes are in the top tier (N_TOPTIER_MEMORY).
> > > > > > > > > > > > 
> > > > > > > > > > > > A device driver can remove its memory nodes from the top tier, e.g.
> > > > > > > > > > > > a dax driver can remove PMEM nodes from the top tier.
> > > > > > > > > > > 
> > > > > > > > > > > With the topology built by firmware we should not need this.
> > > > > > > > > 
> > > > > > > > > I agree that in an ideal world the hierarchy should be built by firmware based
> > > > > > > > > on something like the HMAT. But I also think being able to override this will be
> > > > > > > > > useful in getting there. Therefore a way of overriding the generated hierarchy
> > > > > > > > > would be good, either via sysfs or kernel boot parameter if we don't want to
> > > > > > > > > commit to a particular user interface now.
> > > > > > > > > 
> > > > > > > > > However I'm less sure letting device-drivers override this is a good idea. How
> > > > > > > > > for example would a GPU driver make sure it's node is in the top tier? By moving
> > > > > > > > > every node that the driver does not know about out of N_TOPTIER_MEMORY? That
> > > > > > > > > could get messy if say there were two drivers both of which wanted their node to
> > > > > > > > > be in the top tier.
> > > > > > > > 
> > > > > > > > The suggestion is to allow a device driver to opt out its memory
> > > > > > > > devices from the top-tier, not the other way around.
> > > > > > > 
> > > > > > > So how would demotion work in the case of accelerators then? In that
> > > > > > > case we would want GPU memory to demote to DRAM, but that won't happen
> > > > > > > if both DRAM and GPU memory are in N_TOPTIER_MEMORY and it seems the
> > > > > > > only override available with this proposal would move GPU memory into a
> > > > > > > lower tier, which is the opposite of what's needed there.
> > > > > > 
> > > > > > How about we do 3 tiers now. dax kmem devices can be registered to
> > > > > > tier 3. By default all numa nodes can be registered at tier 2 and HBM or
> > > > > > GPU can be enabled to register at tier 1. ?
> > > > > 
> > > > > This makes sense.  I will send an updated RFC based on the discussions so far.
> > > > 
> > > > Are these tier number fixed?  If so, it appears strange that the
> > > > smallest tier number is 0 on some machines, but 1 on some other
> > > > machines.
> > > 
> > > When the kernel is configured to allow 3 tiers, we can always show all
> > > the 3 tiers. It is just that some tiers (e.g. tier 0) may be empty on
> > > some machines.
> > 
> > I still think that it's better to have no empty tiers for auto-generated
> > memory tiers by kernel.  Yes, the tier number will be not absolutely
> > stable, but that only happens during system bootup in practice, so it's
> > not a big issue IMHO.
> 
> It should not be hard to hide empty tiers (e.g. tier-0) if we prefer.
> But even if tier-0 is empty, we should still keep this tier in the
> kernel and not move DRAM nodes into this tier.  One reason is that a
> HBM node might be hot-added into tier-0 at a later time.
> 

Yes.  The in-kernel representation and the user space interface could be
different.

I have thought something like below.  We always make the main memory
(DRAM here, CPU local) as tier 0.  Then the slower memory will be
positive, tier 1, 2, 3, ..., and the faster memory will be negative,
tier -1, -2, -3, ....  Then, GPU driver can regesiter its memory as tier
-1.  And the tier number could be more stable.  But I'm not sure whether
users will be happy with negtive tier number.

> > And, I still think it's better to make only N-1 tiers writable for
> > totally N tiers (or even readable).  Considering "tier0" is written, how
> > to deal with nodes in "tier0" before but not after writing?  One
> > possible way is to put them into "tierN".  And during a user customize
> > the tiers, the union of "N tiers" may be not complete.
> 
> The sysfs interfaces that I have in mind now are:
> 
> * /sys/devices/system/memtier/memtierN/nodelist (N=0, 1, 2)
> 
> This is read-only to list the memory nodes for a specific tier.
> 
> * /sys/devices/system/node/nodeN/memtier. (N=0, 1, ...,)
> 
> This is a read-write interface. When written, the kernel moves the
> node into the user-specified tier.  No other nodes are affected.
> 
> This interface should be able to avoid the above issue.

Yes.  This works too.

Best Regards,
Huang, Ying

> > > BTW, the userspace should not assume a specific meaning of a
> > > particular tier id because it can change depending on the number of
> > > tiers that the kernel is configured with.  For example, the userspace
> > > should not assume that tier-2 always means PMEM nodes.  In a system
> > > with 4 tiers, PMEM nodes may be in tier-3, not tier-2.
> > 
> > Yes.  This sounds good.
> > 
> > Best Regards,
> > Huang, Ying
> > 


