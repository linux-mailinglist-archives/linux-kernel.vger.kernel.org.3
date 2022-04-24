Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B8C50CECB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 05:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbiDXDFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbiDXDFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:05:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0531F1418C6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 20:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650769372; x=1682305372;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ux9PsAQmdWKorvAm6+E36dUqx1AaTnYpTj72E3+/dCk=;
  b=DEV18fvD6zBtQFIt0EIfk5oMy7MNCNj6b9QSm/nwF6Kzuuaz8jEJoa4N
   TLD4ZbbI7yGH4sdvrH5ushjXu/mCM1TmErw7LVw6AZtwV7XTU5wlx5yXU
   QYp0fKeMQjbKGee0ibBIk0XaVV4SkR6UTwpN19PMeieezoRidcduLcV02
   zoSxPmJYsyXyFVIX8DG3DYw4rtEGXfy41yKpWnGUlHYxFQwWfM14JeHR9
   3kDTGugwGCSBBI1dhcgSalLuSazvevwQp4Dbah8RH0HtV5CwFgVI5uwkm
   uRLhWNewJ/NaGmKGU4yHAtKofvS7RDtijo4ecpBvJdQcsebCgq8Xp9qmZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="290117349"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="290117349"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 20:02:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="557093768"
Received: from dafeixu-mobl1.ccr.corp.intel.com ([10.254.212.194])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 20:02:49 -0700
Message-ID: <200e95cf36c1642512d99431014db8943fed715d.camel@intel.com>
Subject: Re: [PATCH v2 0/5] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        MichalHocko <mhocko@kernel.org>,
        Brice Goglin <brice.goglin@gmail.com>
Date:   Sun, 24 Apr 2022 11:02:47 +0800
In-Reply-To: <YmKKwXa2XI/nwac0@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All,

On Fri, 2022-04-22 at 16:30 +0530, Jagdish Gediya wrote:

[snip]

> I think it is necessary to either have per node demotion targets
> configuration or the user space interface supported by this patch
> series. As we don't have clear consensus on how the user interface
> should look like, we can defer the per node demotion target set
> interface to future until the real need arises.
> 
> Current patch series sets N_DEMOTION_TARGET from dax device kmem
> driver, it may be possible that some memory node desired as demotion
> target is not detected in the system from dax-device kmem probe path.
> 
> It is also possible that some of the dax-devices are not preferred as
> demotion target e.g. HBM, for such devices, node shouldn't be set to
> N_DEMOTION_TARGETS. In future, Support should be added to distinguish
> such dax-devices and not mark them as N_DEMOTION_TARGETS from the
> kernel, but for now this user space interface will be useful to avoid
> such devices as demotion targets.
> 
> We can add read only interface to view per node demotion targets
> from /sys/devices/system/node/nodeX/demotion_targets, remove
> duplicated /sys/kernel/mm/numa/demotion_target interface and instead
> make /sys/devices/system/node/demotion_targets writable.
> 
> Huang, Wei, Yang,
> What do you suggest?

We cannot remove a kernel ABI in practice.  So we need to make it right
at the first time.  Let's try to collect some information for the kernel
ABI definitation.

The below is just a starting point, please add your requirements.

1. Jagdish has some machines with DRAM only NUMA nodes, but they don't
want to use that as the demotion targets.  But I don't think this is a
issue in practice for now, because demote-in-reclaim is disabled by
default.

2. For machines with PMEM installed in only 1 of 2 sockets, for example,

Node 0 & 2 are cpu + dram nodes and node 1 are slow
memory node near node 0,

available: 3 nodes (0-2)
node 0 cpus: 0 1
node 0 size: n MB
node 0 free: n MB
node 1 cpus:
node 1 size: n MB
node 1 free: n MB
node 2 cpus: 2 3
node 2 size: n MB
node 2 free: n MB
node distances:
node   0   1   2
  0:  10  40  20
  1:  40  10  80
  2:  20  80  10

We have 2 choices,

a)
node	demotion targets
0	1
2	1

b)
node	demotion targets
0	1
2	X

a) is good to take advantage of PMEM.  b) is good to reduce cross-socket
traffic.  Both are OK as defualt configuration.  But some users may
prefer the other one.  So we need a user space ABI to override the
default configuration.

3. For machines with HBM (High Bandwidth Memory), as in

https://lore.kernel.org/lkml/39cbe02a-d309-443d-54c9-678a0799342d@gmail.com/

> [1] local DDR = 10, remote DDR = 20, local HBM = 31, remote HBM = 41

Although HBM has better performance than DDR, in ACPI SLIT, their
distance to CPU is longer.  We need to provide a way to fix this.  The
user space ABI is one way.  The desired result will be to use local DDR
as demotion targets of local HBM.

Best Regards,
Huang, Ying

