Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A502E527B99
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 03:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbiEPB51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 21:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbiEPB5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 21:57:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77F7120B2
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 18:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652666239; x=1684202239;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5sJgBSyY05b4qS9qR14JupIuhy3CGzHPfdFfFtG7b+U=;
  b=CjmMVYP/HjTKtbTnNGiT+ii5lBuUAevk4HkEZHK5z94wGX4OsLx8pRjg
   rHpYbgHqUR/6Wjiq3beSf0FrnZxUidB/PNneQ6tWyI6tWmhSBHHsHQjmj
   Uu2hMxEpEej6q1Xi0fydfci92UJBgVEXnyw/N1JfEnaVPrrXqEn5s0xEh
   lBx7XdM/gLOYcaBbkf1eOR4wWI0isnV2sx14kZ9piofBVzcH+LM+O22Wk
   Dam2KJ+oP0G/XebaGM/ntLXm06A8fOQjROYV5pvlKT5FMbbPSf7k3kY41
   sC7/IqRtdzmDq4vxHWiyjwDAn5Z98glesvsWfEHkpgQnP/c0v7wwGTjMA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="270658125"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="270658125"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 18:57:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="568088155"
Received: from rmo-mobl1.ccr.corp.intel.com ([10.254.215.134])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 18:57:12 -0700
Message-ID: <83b2229ce198d446ace6112b39ceaa34c0864b41.camel@intel.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v2)
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Wei Xu <weixugc@google.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim C Chen <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Feng Tang <feng.tang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Brice Goglin <brice.goglin@gmail.com>,
        Hesham Almatary <hesham.almatary@huawei.com>
Date:   Mon, 16 May 2022 09:57:10 +0800
In-Reply-To: <CAAPL-u-vPgCKVYOLqiScYu5Q_jApPsoHZnNGNfN+k2YuFFR_nw@mail.gmail.com>
References: <CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com>
         <56b41ce6922ed5f640d9bd46a603fa27576532a9.camel@intel.com>
         <c5d55131-76ff-7354-2954-7cfac365a9a5@linux.ibm.com>
         <CAAPL-u-g86QqHaHGGtVJMER8ENC2dpekK+2qOkxoRFmC0F_80g@mail.gmail.com>
         <87y1z7jj85.fsf@linux.ibm.com>
         <CAAPL-u90Gzrepbsdpc62FGRBYOx1LAVwZWHg1E7UyVD_CmcROw@mail.gmail.com>
         <c8f253839505adec4d68cd2aa3f3769866915ad3.camel@intel.com>
         <f36273d9a2fa09342972cd49e31bf2fe91e7c9e4.camel@intel.com>
         <CAAPL-u-vPgCKVYOLqiScYu5Q_jApPsoHZnNGNfN+k2YuFFR_nw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-13 at 00:00 -0700, Wei Xu wrote:
> On Thu, May 12, 2022 at 7:53 PM ying.huang@intel.com
> <ying.huang@intel.com> wrote:
> > 
> > On Thu, 2022-05-12 at 16:37 +0800, ying.huang@intel.com wrote:
> > > On Thu, 2022-05-12 at 01:15 -0700, Wei Xu wrote:
> > > > On Thu, May 12, 2022 at 12:36 AM Aneesh Kumar K.V
> > > > <aneesh.kumar@linux.ibm.com> wrote:
> > > > > 
> > > > > Wei Xu <weixugc@google.com> writes:
> > > > > 
> > > > > > On Thu, May 12, 2022 at 12:12 AM Aneesh Kumar K V
> > > > > > <aneesh.kumar@linux.ibm.com> wrote:
> > > > > > > 
> > > > > > > On 5/12/22 12:33 PM, ying.huang@intel.com wrote:
> > > > > > > > On Wed, 2022-05-11 at 23:22 -0700, Wei Xu wrote:
> > > > > > > > > Sysfs Interfaces
> > > > > > > > > ================
> > > > > > > > > 
> > > > > > > > > * /sys/devices/system/memtier/memtierN/nodelist
> > > > > > > > > 
> > > > > > > > >    where N = 0, 1, 2 (the kernel supports only 3 tiers for now).
> > > > > > > > > 
> > > > > > > > >    Format: node_list
> > > > > > > > > 
> > > > > > > > >    Read-only.  When read, list the memory nodes in the specified tier.
> > > > > > > > > 
> > > > > > > > >    Tier 0 is the highest tier, while tier 2 is the lowest tier.
> > > > > > > > > 
> > > > > > > > >    The absolute value of a tier id number has no specific meaning.
> > > > > > > > >    What matters is the relative order of the tier id numbers.
> > > > > > > > > 
> > > > > > > > >    When a memory tier has no nodes, the kernel can hide its memtier
> > > > > > > > >    sysfs files.
> > > > > > > > > 
> > > > > > > > > * /sys/devices/system/node/nodeN/memtier
> > > > > > > > > 
> > > > > > > > >    where N = 0, 1, ...
> > > > > > > > > 
> > > > > > > > >    Format: int or empty
> > > > > > > > > 
> > > > > > > > >    When read, list the memory tier that the node belongs to.  Its value
> > > > > > > > >    is empty for a CPU-only NUMA node.
> > > > > > > > > 
> > > > > > > > >    When written, the kernel moves the node into the specified memory
> > > > > > > > >    tier if the move is allowed.  The tier assignment of all other nodes
> > > > > > > > >    are not affected.
> > > > > > > > > 
> > > > > > > > >    Initially, we can make this interface read-only.
> > > > > > > > 
> > > > > > > > It seems that "/sys/devices/system/node/nodeN/memtier" has all
> > > > > > > > information we needed.  Do we really need
> > > > > > > > "/sys/devices/system/memtier/memtierN/nodelist"?
> > > > > > > > 
> > > > > > > > That can be gotten via a simple shell command line,
> > > > > > > > 
> > > > > > > > $ grep . /sys/devices/system/node/nodeN/memtier | sort -n -k 2 -t ':'
> > > > > > > > 
> > > > > > > 
> > > > > > > It will be really useful to fetch the memory tier node list in an easy
> > > > > > > fashion rather than reading multiple sysfs directories. If we don't have
> > > > > > > other attributes for memorytier, we could keep
> > > > > > > "/sys/devices/system/memtier/memtierN" a NUMA node list there by
> > > > > > > avoiding /sys/devices/system/memtier/memtierN/nodelist
> > > > > > > 
> > > > > > > -aneesh
> > > > > > 
> > > > > > It is harder to implement memtierN as just a file and doesn't follow
> > > > > > the existing sysfs pattern, either.  Besides, it is extensible to have
> > > > > > memtierN as a directory.
> > > > > 
> > > > > diff --git a/drivers/base/node.c b/drivers/base/node.c
> > > > > index 6248326f944d..251f38ec3816 100644
> > > > > --- a/drivers/base/node.c
> > > > > +++ b/drivers/base/node.c
> > > > > @@ -1097,12 +1097,49 @@ static struct attribute *node_state_attrs[] = {
> > > > >         NULL
> > > > >  };
> > > > > 
> > > > > +#define MAX_TIER 3
> > > > > +nodemask_t memory_tier[MAX_TIER];
> > > > > +
> > > > > +#define _TIER_ATTR_RO(name, tier_index)                                        \
> > > > > +       { __ATTR(name, 0444, show_tier, NULL), tier_index, NULL }
> > > > > +
> > > > > +struct memory_tier_attr {
> > > > > +       struct device_attribute attr;
> > > > > +       int tier_index;
> > > > > +       int (*write)(nodemask_t nodes);
> > > > > +};
> > > > > +
> > > > > +static ssize_t show_tier(struct device *dev,
> > > > > +                        struct device_attribute *attr, char *buf)
> > > > > +{
> > > > > +       struct memory_tier_attr *mt = container_of(attr, struct memory_tier_attr, attr);
> > > > > +
> > > > > +       return sysfs_emit(buf, "%*pbl\n",
> > > > > +                         nodemask_pr_args(&memory_tier[mt->tier_index]));
> > > > > +}
> > > > > +
> > > > >  static const struct attribute_group memory_root_attr_group = {
> > > > >         .attrs = node_state_attrs,
> > > > >  };
> > > > > 
> > > > > +
> > > > > +#define TOP_TIER 0
> > > > > +static struct memory_tier_attr memory_tiers[] = {
> > > > > +       [0] = _TIER_ATTR_RO(memory_top_tier, TOP_TIER),
> > > > > +};
> > > > > +
> > > > > +static struct attribute *memory_tier_attrs[] = {
> > > > > +       &memory_tiers[0].attr.attr,
> > > > > +       NULL
> > > > > +};
> > > > > +
> > > > > +static const struct attribute_group memory_tier_attr_group = {
> > > > > +       .attrs = memory_tier_attrs,
> > > > > +};
> > > > > +
> > > > >  static const struct attribute_group *cpu_root_attr_groups[] = {
> > > > >         &memory_root_attr_group,
> > > > > +       &memory_tier_attr_group,
> > > > >         NULL,
> > > > >  };
> > > > > 
> > > > > 
> > > > > As long as we have the ability to see the nodelist, I am good with the
> > > > > proposal.
> > > > > 
> > > > > -aneesh
> > > > 
> > > > I am OK with moving back the memory tier nodelist into node/.  When
> > > > there are more memory tier attributes needed, we can then create the
> > > > memory tier subtree and replace the tier nodelist in node/ with
> > > > symlinks.
> > > 
> > > What attributes do you imagine that we may put in memory_tierX/ sysfs
> > > directory?  If we have good candidates in mind, we may just do that.
> > > What I can imagine now is "demote", like "memory_reclaim" in nodeX/ or
> > > node/ directory you proposed before.  Is it necessary to show something
> > > like "meminfo", "vmstat" there?
> > 
> > My words may be confusing, so let me say it in another way.
> 
> I can understand. :)
> 
> > Just for brainstorm, if we have
> > 
> >   /sys/devices/system/memtier/memtierN/
> > 
> > What can we put in it in addition to "nodelist" or links to the nodes?
> > For example,
> > 
> >   /sys/devices/system/memtier/memtierN/demote
> > 
> > When write a page number to it, the specified number of pages will be
> > demoted from memtierN to memtierN+1, like the
> > /sys/devices/system/node/memory_reclaim interface you proposed before.
> 
> "demote" might be fine to add there.  Just to clarify, we (Google)
> currently don't yet have the need for an interface to do system-wide
> demotion from one tier to another.  What we need is memory.demote
> (similar to memory.reclaim) for memory cgroup based demotions.
> 
> Other things that might be added include tier-specific properties
> (e.g. expected latency and bandwidth when available) and tier-specific
> stats.
> 
> Under /sys/devices/system/memtier/, we may add global properties about
> memory tiers, e.g. max number of tiers, min/max tier ids (which might
> be useful if we hide unpopulated memory tiers).
> 
> > Or, is it necessary to add
> > 
> >   /sys/devices/system/memtier/memtierN/meminfo
> >   /sys/devices/system/memtier/memtierN/vmstat
> 
> The userspace can aggregate such data from node/nodeN/{meminfo,
> vmstat} based on the memory tier nodelist. But I am not against adding
> these files to memtierN/ for user convenience.
> 
> > I don't mean to propose these.  Just want to know whether there's
> > requirement for these kind of stuff?  And what else may be required.
> 
> This sounds good.  I think a memtier directory may eventually become a
> necessity, though I don't feel too strongly about adding it right now.

If a memtier directory may eventually become a necessity and we really
want convenient nodelist somewhere, I'm OK to add the memtier directory
now.

Best Regards,
Huang, Ying

> > Best Regards,
> > Huang, Ying
> > 
> > > > 
> > > > So the revised sysfs interfaces are:
> > > > 
> > > > * /sys/devices/system/node/memory_tierN (read-only)
> > > > 
> > > >   where N = 0, 1, 2
> > > > 
> > > >   Format: node_list
> > > > 
> > > > * /sys/devices/system/node/nodeN/memory_tier (read/write)
> > > > 
> > > >   where N = 0, 1, ...
> > > > 
> > > >   Format: int or empty
> > > 
> > 
> > 
> > 


