Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E135159C9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 04:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240347AbiD3CYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 22:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240220AbiD3CYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 22:24:34 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B815E179
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 19:21:13 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id v139so9229111vsv.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 19:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gK3d26AggPNcsYkk3oP2ItRgWODUL1HBUrPTw0t1O2k=;
        b=ABePdfQLv1VyGE6WM1Eju5dvGiTwUcCXwrai/Eo1D/0yws3gjSA0UmUmVhD3FO9tsK
         iDT7t9xUF7rktuxv8dtFMGPHEOFG1iMr2pEELbdg/0dDRqsFdYgqCuv6vYdBVrUkLLqd
         z8g7L0m33fV58f1QRf19Oi9qBc+LowjnnIV5DxszBFtZfXcH0sVsbRaAXrEbBDqheriv
         U3Cnkuzi0IILFrPO9fSUOU7ZycFPaMOKCYeKenGzY8mS4xGoaASLEY4nsZ09yxUAtVxA
         QO4D4ysVCdAKeD2vThLZC9CcsQizcPYTiwfHWyD158KYqWWrc//Vfypv+YPo1Wh65WMd
         +VMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gK3d26AggPNcsYkk3oP2ItRgWODUL1HBUrPTw0t1O2k=;
        b=FDysE7VvhP6cgvE1oJNjPL8v+C1LjDMOebbri4pInLOFe7CuHQw5SimjG2T7oezBcE
         BcUeNq3n+CoQqDrpZzP8zV9lb/nrRszy7ww5685euMsDVRWt8eEQwHB/kHMF5qi8jbCY
         pTgx5MXpsmFU/uwtEJTC71KkEGR8wISc8s4pMO7pKS/1kT07YGE0qXos0IBwcAazJXaG
         fKyJcp3a4pEnuVN0R5YEP8BYKVW2iIo+b8IjUR/IC1HM19q3Ukd7vlt0/32nfgEqB/Br
         hRO4ZmTaRv2mit7nOqKempHPeABN24rBx/OtyRWWChZ/O2+3lZjrmITMk4KJ8N7l5pzk
         2BkQ==
X-Gm-Message-State: AOAM530W2gT8Sa1D2a4L6kz8AVtspUSLxCN6to9/CR8aWYdoXNb9qasw
        t+soQ06zpT9o64zn14YOrhB/UIKO3cqavDOdPlbO0w==
X-Google-Smtp-Source: ABdhPJwNcnlz4agwzIEkIQQstRZ5b59FGzGhsMwoAZbH+KbUAYQ07KPASxhwUL4imyloNgve9kK7zIB/ir16DgQUuC4=
X-Received: by 2002:a67:fd0b:0:b0:31b:e36d:31b1 with SMTP id
 f11-20020a67fd0b000000b0031be36d31b1mr607631vsr.44.1651285272306; Fri, 29 Apr
 2022 19:21:12 -0700 (PDT)
MIME-Version: 1.0
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
 <a1b875913df743355e1ff3752c0eb7ddf74bae91.camel@intel.com>
 <CAAPL-u8b3m2yx8A-MhPmJUasuz8Ra9mW2E2dwT2KvJ06FeZofQ@mail.gmail.com>
 <cb424fff95cf2b1a6e31616ebb261660e8000425.camel@intel.com> <DM6PR11MB4107867291AFE0C210D9052ADCFD9@DM6PR11MB4107.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB4107867291AFE0C210D9052ADCFD9@DM6PR11MB4107.namprd11.prod.outlook.com>
From:   Wei Xu <weixugc@google.com>
Date:   Fri, 29 Apr 2022 19:21:01 -0700
Message-ID: <CAAPL-u95dyPHYZfHUzYN531AYW+CUBYRYTy5f0rWAhKG9md+Yw@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] mm: demotion: Introduce new node state N_DEMOTION_TARGETS
To:     "Chen, Tim C" <tim.c.chen@intel.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        MichalHocko <mhocko@kernel.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 12:30 PM Chen, Tim C <tim.c.chen@intel.com> wrote:
>
> >
> >On Wed, 2022-04-27 at 09:27 -0700, Wei Xu wrote:
> >> On Wed, Apr 27, 2022 at 12:11 AM ying.huang@intel.com
> >> <ying.huang@intel.com> wrote:
> >> >
> >> > On Mon, 2022-04-25 at 09:56 -0700, Wei Xu wrote:
> >> > > On Sat, Apr 23, 2022 at 8:02 PM ying.huang@intel.com
> >> > > <ying.huang@intel.com> wrote:
> >> > > >
> >> > > > Hi, All,
> >> > > >
> >> > > > On Fri, 2022-04-22 at 16:30 +0530, Jagdish Gediya wrote:
> >> > > >
> >> > > > [snip]
> >> > > >
> >> > > > > I think it is necessary to either have per node demotion
> >> > > > > targets configuration or the user space interface supported by
> >> > > > > this patch series. As we don't have clear consensus on how the
> >> > > > > user interface should look like, we can defer the per node
> >> > > > > demotion target set interface to future until the real need arises.
> >> > > > >
> >> > > > > Current patch series sets N_DEMOTION_TARGET from dax device
> >> > > > > kmem driver, it may be possible that some memory node desired
> >> > > > > as demotion target is not detected in the system from dax-device
> >kmem probe path.
> >> > > > >
> >> > > > > It is also possible that some of the dax-devices are not
> >> > > > > preferred as demotion target e.g. HBM, for such devices, node
> >> > > > > shouldn't be set to N_DEMOTION_TARGETS. In future, Support
> >> > > > > should be added to distinguish such dax-devices and not mark
> >> > > > > them as N_DEMOTION_TARGETS from the kernel, but for now this
> >> > > > > user space interface will be useful to avoid such devices as demotion
> >targets.
> >> > > > >
> >> > > > > We can add read only interface to view per node demotion
> >> > > > > targets from /sys/devices/system/node/nodeX/demotion_targets,
> >> > > > > remove duplicated /sys/kernel/mm/numa/demotion_target
> >> > > > > interface and instead make
> >/sys/devices/system/node/demotion_targets writable.
> >> > > > >
> >> > > > > Huang, Wei, Yang,
> >> > > > > What do you suggest?
> >> > > >
> >> > > > We cannot remove a kernel ABI in practice.  So we need to make
> >> > > > it right at the first time.  Let's try to collect some
> >> > > > information for the kernel ABI definitation.
> >> > > >
> >> > > > The below is just a starting point, please add your requirements.
> >> > > >
> >> > > > 1. Jagdish has some machines with DRAM only NUMA nodes, but they
> >> > > > don't want to use that as the demotion targets.  But I don't
> >> > > > think this is a issue in practice for now, because
> >> > > > demote-in-reclaim is disabled by default.
> >> > > >
> >> > > > 2. For machines with PMEM installed in only 1 of 2 sockets, for
> >> > > > example,
> >> > > >
> >> > > > Node 0 & 2 are cpu + dram nodes and node 1 are slow memory node
> >> > > > near node 0,
> >> > > >
> >> > > > available: 3 nodes (0-2)
> >> > > > node 0 cpus: 0 1
> >> > > > node 0 size: n MB
> >> > > > node 0 free: n MB
> >> > > > node 1 cpus:
> >> > > > node 1 size: n MB
> >> > > > node 1 free: n MB
> >> > > > node 2 cpus: 2 3
> >> > > > node 2 size: n MB
> >> > > > node 2 free: n MB
> >> > > > node distances:
> >> > > > node   0   1   2
> >> > > >   0:  10  40  20
> >> > > >   1:  40  10  80
> >> > > >   2:  20  80  10
> >> > > >
> >> > > > We have 2 choices,
> >> > > >
> >> > > > a)
> >> > > > node    demotion targets
> >> > > > 0       1
> >> > > > 2       1
> >> > > >
> >> > > > b)
> >> > > > node    demotion targets
> >> > > > 0       1
> >> > > > 2       X
> >> > > >
> >> > > > a) is good to take advantage of PMEM.  b) is good to reduce
> >> > > > cross-socket traffic.  Both are OK as defualt configuration.
> >> > > > But some users may prefer the other one.  So we need a user
> >> > > > space ABI to override the default configuration.
> >> > >
> >> > > I think 2(a) should be the system-wide configuration and 2(b) can
> >> > > be achieved with NUMA mempolicy (which needs to be added to
> >demotion).
> >> >
> >> > Unfortunately, some NUMA mempolicy information isn't available at
> >> > demotion time, for example, mempolicy enforced via set_mempolicy()
> >> > is for thread. But I think that cpusets can work for demotion.
> >> >
> >> > > In general, we can view the demotion order in a way similar to
> >> > > allocation fallback order (after all, if we don't demote or
> >> > > demotion lags behind, the allocations will go to these demotion
> >> > > target nodes according to the allocation fallback order anyway).
> >> > > If we initialize the demotion order in that way (i.e. every node
> >> > > can demote to any node in the next tier, and the priority of the
> >> > > target nodes is sorted for each source node), we don't need
> >> > > per-node demotion order override from the userspace.  What we need
> >> > > is to specify what nodes should be in each tier and support NUMA
> >mempolicy in demotion.
> >> >
> >> > This sounds interesting. Tier sounds like a natural and general
> >> > concept for these memory types. It's attracting to use it for user
> >> > space interface too. For example, we may use that for mem_cgroup
> >> > limits of a specific memory type (tier).
> >> >
> >> > And if we take a look at the N_DEMOTION_TARGETS again from the "tier"
> >> > point of view. The nodes are divided to 2 classes via
> >> > N_DEMOTION_TARGETS.
> >> >
> >> > - The nodes without N_DEMOTION_TARGETS are top tier (or tier 0).
> >> >
> >> > - The nodes with N_DEMOTION_TARGETS are non-top tier (or tier 1, 2,
> >> > 3,
> >> > ...)
> >> >
> >>
> >> Yes, this is one of the main reasons why we (Google) want this interface.
> >>
> >> > So, another possibility is to fit N_DEMOTION_TARGETS and its
> >> > overriding into "tier" concept too.  !N_DEMOTION_TARGETS == TIER0.
> >> >
> >> > - All nodes start with TIER0
> >> >
> >> > - TIER0 can be cleared for some nodes via e.g. kmem driver
> >> >
> >> > TIER0 node list can be read or overriden by the user space via the
> >> > following interface,
> >> >
> >> >   /sys/devices/system/node/tier0
> >> >
> >> > In the future, if we want to customize more tiers, we can add tier1,
> >> > tier2, tier3, .....  For now, we can add just tier0.  That is, the
> >> > interface is extensible in the future compared with
> >> > .../node/demote_targets.
> >> >
> >>
> >> This more explicit tier definition interface works, too.
> >>
> >
> >In addition to make tiering definition explicit, more importantly, this makes it
> >much easier to support more than 2 tiers.  For example, for a system with
> >HBM (High Bandwidth Memory), CPU+DRAM, DRAM only, and PMEM, that is,
> >3 tiers, we can put HBM in tier 0, CPU+DRAM and DRAM only in tier 1, and
> >PMEM in tier 2, automatically, or via user space overridding.
> >N_DEMOTION_TARGETS isn't natural to be extended to support this.
>
> Agree with Ying that making the tier explicit is fundamental to the rest of the API.
>
> I think that the tier organization should come before setting the demotion targets,
> not the other way round.
>
> That makes things clear on the demotion direction,  (node in tier X
> demote to tier Y, X<Y).  With that, explicitly specifying the demotion target or
> order is only needed when we truly want that level of control or a demotion
> order.  Otherwise all the higher numbered tiers are valid targets.
> Configuring a tier level for each node is a lot easier than fixing up all
> demotion targets for each and every node.
>
> We can prevent demotion target configuration that goes in the wrong
> direction by looking at the tier level.
>
> Tim
>

I have just posted a RFC on the tier-oriented memory tiering kernel
interface based on the discussions here.  The RFC proposes a sysfs
interface, /sys/devices/system/node/memory_tiers, to display and
override the nodes in each memory tier.  It also proposes that we rely
on the kernel allocation order to select the demotion target node from
the next tier and don't expose a userspace overriding interface for
per-node demotion order.   The RFC drops the approach of CPU nodes as
the top-tier by default, too.
