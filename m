Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EF1512854
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 02:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239312AbiD1BAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 21:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiD1A76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 20:59:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8EDBE24
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 17:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651107405; x=1682643405;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bTii8rU78HdZ/UWhjpXzrq83u14xeBJWe0Ohqjd2PJU=;
  b=lEq8FlukVW+XI2bsP404NGWE1ht8ykpVcIvS8g+f2uWTO3WtT1GxxFTj
   zH83J7ZbQSZGHeTh98fkmzRSQRO1K0SY9y6bbYMzRvkz9q+2j2krF+mu+
   XkMLjib0RErkohNyhLrcKFXnOzD7M27imWEicFExp10mKdHQ3yCCP2uAx
   6FDKdvwncLwKoOKUkkaDewU/OmFOGdOfA7lTUoc2e4/BJWiUriCae915A
   o9WqlBqey9AcUU0TCYQAbnyHhhZBu7QaPvl/BXdcxobOEiUZEeHZRgYgK
   CKaxHXFt6TwcHHFrQmpSqS/tAFUCiF9n0r97grYwvA50CUB9GB8KEh2jp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="263707099"
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="263707099"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 17:56:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,294,1643702400"; 
   d="scan'208";a="580941009"
Received: from shanlinl-mobl.ccr.corp.intel.com ([10.254.212.81])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 17:56:40 -0700
Message-ID: <9d9ef67127b1e2cf0b6c72f60cb7304dc573c28b.camel@intel.com>
Subject: Re: [PATCH v2 0/5] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Wei Xu <weixugc@google.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Jagdish Gediya <jvgediya@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        MichalHocko <mhocko@kernel.org>,
        Brice Goglin <brice.goglin@gmail.com>, feng.tang@intel.com
Date:   Thu, 28 Apr 2022 08:56:37 +0800
In-Reply-To: <CAAPL-u9ZDcM48-76+wJeP-HeJf92YdA8ad3qX65p5d+0A9Puuw@mail.gmail.com>
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
         <CAAPL-u94H9FLjVtYLhi_A2AqLTOCTMRh6=Sx9cX8A3WGNM-OdA@mail.gmail.com>
         <b1f58fd4-e23b-f617-b4a7-b80b1ffbe13f@linux.ibm.com>
         <CAAPL-u9ZDcM48-76+wJeP-HeJf92YdA8ad3qX65p5d+0A9Puuw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-27 at 11:27 -0700, Wei Xu wrote:
> On Tue, Apr 26, 2022 at 10:06 PM Aneesh Kumar K V
> <aneesh.kumar@linux.ibm.com> wrote:
> > 
> > On 4/25/22 10:26 PM, Wei Xu wrote:
> > > On Sat, Apr 23, 2022 at 8:02 PM ying.huang@intel.com
> > > <ying.huang@intel.com> wrote:
> > > > 
> > 
> > ....
> > 
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
> > > > node    demotion targets
> > > > 0       1
> > > > 2       1
> > > > 
> > > > b)
> > > > node    demotion targets
> > > > 0       1
> > > > 2       X
> > > > 
> > > > a) is good to take advantage of PMEM.  b) is good to reduce cross-socket
> > > > traffic.  Both are OK as defualt configuration.  But some users may
> > > > prefer the other one.  So we need a user space ABI to override the
> > > > default configuration.
> > > 
> > > I think 2(a) should be the system-wide configuration and 2(b) can be
> > > achieved with NUMA mempolicy (which needs to be added to demotion).
> > > 
> > > In general, we can view the demotion order in a way similar to
> > > allocation fallback order (after all, if we don't demote or demotion
> > > lags behind, the allocations will go to these demotion target nodes
> > > according to the allocation fallback order anyway).  If we initialize
> > > the demotion order in that way (i.e. every node can demote to any node
> > > in the next tier, and the priority of the target nodes is sorted for
> > > each source node), we don't need per-node demotion order override from
> > > the userspace.  What we need is to specify what nodes should be in
> > > each tier and support NUMA mempolicy in demotion.
> > > 
> > 
> > I have been wondering how we would handle this. For ex: If an
> > application has specified an MPOL_BIND policy and restricted the
> > allocation to be from Node0 and Node1, should we demote pages allocated
> > by that application
> > to Node10? The other alternative for that demotion is swapping. So from
> > the page point of view, we either demote to a slow memory or pageout to
> > swap. But then if we demote we are also breaking the MPOL_BIND rule.
> 
> IMHO, the MPOL_BIND policy should be respected and demotion should be
> skipped in such cases.  Such MPOL_BIND policies can be an important
> tool for applications to override and control their memory placement
> when transparent memory tiering is enabled.  If the application
> doesn't want swapping, there are other ways to achieve that (e.g.
> mlock, disabling swap globally, setting memcg parameters, etc).
> 
>
> > The above says we would need some kind of mem policy interaction, but
> > what I am not sure about is how to find the memory policy in the
> > demotion path.
> 
> This is indeed an important and challenging problem.  One possible
> approach is to retrieve the allowed demotion nodemask from
> page_referenced() similar to vm_flags.

This works for mempolicy in struct vm_area_struct, but not for that in
struct task_struct.  Mutiple threads in a process may have different
mempolicy.

Best Regards,
Huang, Ying

> > 
> > > Cross-socket demotion should not be too big a problem in practice
> > > because we can optimize the code to do the demotion from the local CPU
> > > node (i.e. local writes to the target node and remote read from the
> > > source node).  The bigger issue is cross-socket memory access onto the
> > > demoted pages from the applications, which is why NUMA mempolicy is
> > > important here.
> > > 
> > > 
> > -aneesh


