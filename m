Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1270651E55C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 09:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446038AbiEGIAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 04:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiEGIAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 04:00:05 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740E918353
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 00:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651910179; x=1683446179;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QjP7gFNkYoRcvp5aKs/kvkBClgI5+qwDadM8XMqpay0=;
  b=LQTx8XtY8CtFPxEkaTPtZIhP4L6mvOU9prXvZWMFmA9KRZRhuP5Rq9uM
   y9PRH/kotP+/YtAEJeOf44LKV5WO6CfxVTCyTs2IDJBqZXi0DAdBVc1PQ
   qu+Lu+kSYfTnovnrglWYKHRSiBwvlDbUrsrdIwCWMi30rMohq1cMixYnV
   rHKxhxk0HwSV+CCQ+MJFlB0c6Ifs+gY2y+IZfwSr9ovtByG08h5EjW9kC
   qm5orWWpkriJilL8vFsU+quLraDBoyED13w45gdiY7WQb3d90qh7VWqKl
   A9yRkyklWmYPKtmkdHPPMmaZAk68JWAmQr7GFVb2achsKWPXarnEsB/Q/
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="355108371"
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="355108371"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 00:56:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,206,1647327600"; 
   d="scan'208";a="564227035"
Received: from sjin6-mobl1.ccr.corp.intel.com ([10.254.214.15])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2022 00:56:14 -0700
Message-ID: <b5aa57a50bcc29c775587af81e629bac345ab25a.camel@intel.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Yang Shi <shy828301@gmail.com>
Cc:     Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Sat, 07 May 2022 15:56:12 +0800
In-Reply-To: <CAPcyv4g7kyPsSKGT1rR4yy680VD6UJ8V7wzj0OUqN2y2-PjOpQ@mail.gmail.com>
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
         <CAHbLzkq1YXXLMiREpGnzhJjPssu4WpSsnkTmrLJ=hAEhZVUr9w@mail.gmail.com>
         <CAPcyv4g7kyPsSKGT1rR4yy680VD6UJ8V7wzj0OUqN2y2-PjOpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Dan,

On Sun, 2022-05-01 at 11:35 -0700, Dan Williams wrote:
> On Fri, Apr 29, 2022 at 8:59 PM Yang Shi <shy828301@gmail.com> wrote:
> > 
> > Hi Wei,
> > 
> > Thanks for the nice writing. Please see the below inline comments.
> > 
> > On Fri, Apr 29, 2022 at 7:10 PM Wei Xu <weixugc@google.com> wrote:
> > > 
> > > The current kernel has the basic memory tiering support: Inactive
> > > pages on a higher tier NUMA node can be migrated (demoted) to a lower
> > > tier NUMA node to make room for new allocations on the higher tier
> > > NUMA node.  Frequently accessed pages on a lower tier NUMA node can be
> > > migrated (promoted) to a higher tier NUMA node to improve the
> > > performance.
> > > 
> > > A tiering relationship between NUMA nodes in the form of demotion path
> > > is created during the kernel initialization and updated when a NUMA
> > > node is hot-added or hot-removed.  The current implementation puts all
> > > nodes with CPU into the top tier, and then builds the tiering hierarchy
> > > tier-by-tier by establishing the per-node demotion targets based on
> > > the distances between nodes.
> > > 
> > > The current memory tiering interface needs to be improved to address
> > > several important use cases:
> > > 
> > > * The current tiering initialization code always initializes
> > >   each memory-only NUMA node into a lower tier.  But a memory-only
> > >   NUMA node may have a high performance memory device (e.g. a DRAM
> > >   device attached via CXL.mem or a DRAM-backed memory-only node on
> > >   a virtual machine) and should be put into the top tier.
> > > 
> > > * The current tiering hierarchy always puts CPU nodes into the top
> > >   tier. But on a system with HBM (e.g. GPU memory) devices, these
> > >   memory-only HBM NUMA nodes should be in the top tier, and DRAM nodes
> > >   with CPUs are better to be placed into the next lower tier.
> > > 
> > > * Also because the current tiering hierarchy always puts CPU nodes
> > >   into the top tier, when a CPU is hot-added (or hot-removed) and
> > >   triggers a memory node from CPU-less into a CPU node (or vice
> > >   versa), the memory tiering hierarchy gets changed, even though no
> > >   memory node is added or removed.  This can make the tiering
> > >   hierarchy much less stable.
> > 
> > I'd prefer the firmware builds up tiers topology then passes it to
> > kernel so that kernel knows what nodes are in what tiers. No matter
> > what nodes are hot-removed/hot-added they always stay in their tiers
> > defined by the firmware. I think this is important information like
> > numa distances. NUMA distance alone can't satisfy all the usecases
> > IMHO.
> 
> Just want to note here that the platform firmware can only describe
> the tiers of static memory present at boot. CXL hotplug breaks this
> model and the kernel is left to dynamically determine the device's
> performance characteristics and the performance of the topology to
> reach that device. Now, the platform firmware does set expectations
> for the perfomance class of different memory ranges, but there is no
> way to know in advance the performance of devices that will be asked
> to be physically or logically added to the memory configuration. That
> said, it's probably still too early to define ABI for those
> exceptional cases where the kernel needs to make a policy decision
> about a device that does not fit into the firmware's performance
> expectations, but just note that there are limits to the description
> that platform firmware can provide.
> 

Does this mean we will need some kind of in-kernel memory latency
measurement mechanism to determine the tier of the memory device
finally?

Best Regards,
Huang, Ying

> I agree that NUMA distance alone is inadequate and the kernel needs to
> make better use of data like ACPI HMAT to determine the default
> tiering order.


