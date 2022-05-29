Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EF1536F81
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 06:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiE2Ebl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 00:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiE2Ebk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 00:31:40 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF570506D5
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 21:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653798698; x=1685334698;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t3c/Rw6oHrKkRAWVQS+d6BYwqueqvTGSN0tvGDscmAY=;
  b=C81V/xhQOfUN74cr3mOy2MsChnz0nsp+HXHFnsq5wSm4bn7nM+xuJ90c
   f8QaXn7OiQV+8RzSOZetPMivwhkn0skuuBpMXjgz2PTXahu5C8AOC75Az
   J0RbxkVVFMfGArSzsz3btUFk3nvRUPm8kLWdQVRXMeSWwyfasyPxI90j5
   S6sm+xOdPpkZf5pJryirBqHg4ffsooQjHLnqFnOh9NggUuBnrkatAZV+I
   LJMLiKTNrAqBHaPH35tlHfcw8YdB0hwLyu6l1pln5rm2UOgFTlXLTBSr6
   eLp8DJGTTufVcnceRFbPg8Wskq+Qy+NcdO5iVdjyC9G5qTCB3V5aPPzsS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10361"; a="254624049"
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="254624049"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 21:31:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="604627739"
Received: from lli111-mobl.ccr.corp.intel.com ([10.254.214.246])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 21:31:33 -0700
Message-ID: <1281d918c07b05ac82aee290018ad08d212e0aaa.camel@intel.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v3)
From:   Ying Huang <ying.huang@intel.com>
To:     Wei Xu <weixugc@google.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>, Linux MM <linux-mm@kvack.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
Date:   Sun, 29 May 2022 12:31:30 +0800
In-Reply-To: <CAAPL-u_NwJuxWe7Wfn3A1sut+QwEmoZh2QUBQKNPq4bU=NjybA@mail.gmail.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
         <c453491b-6dc1-a008-d6f4-3c806eebd2ef@linux.ibm.com>
         <CAAPL-u_NwJuxWe7Wfn3A1sut+QwEmoZh2QUBQKNPq4bU=NjybA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-27 at 09:30 -0700, Wei Xu wrote:
> On Fri, May 27, 2022 at 6:41 AM Aneesh Kumar K V
> <aneesh.kumar@linux.ibm.com> wrote:
> > 
> > On 5/27/22 2:52 AM, Wei Xu wrote:
> > 
> > >    The order of memory tiers is determined by their rank values, not by
> > >    their memtier device names.
> > > 
> > >    - /sys/devices/system/memtier/possible
> > > 
> > >      Format: ordered list of "memtier(rank)"
> > >      Example: 0(64), 1(128), 2(192)
> > > 
> > >      Read-only.  When read, list all available memory tiers and their
> > >      associated ranks, ordered by the rank values (from the highest
> > >       tier to the lowest tier).
> > > 
> > 
> > Did we discuss the need for this? I haven't done this in the patch
> > series I sent across.
> 
> The "possible" file is only needed if we decide to hide the
> directories of memtiers that have no nodes.  We can remove this
> interface and always show all memtier directories to keep things
> simpler.

When discussed offline, Tim Chen pointed out that with the proposed
interface, it's unconvenient to know the position of a given memory tier
in all memory tiers.  We must sort "rank" of all memory tiers to know
that.  "possible" file can be used for that.  Although "possible" file
can be generated with a shell script, it's more convenient to show it
directly.

Another way to address the issue is to add memtierN/pos for each memory
tier as suggested by Tim.  It's readonly and will show position of
"memtierN" in all memory tiers.  It's even better to show the relative
postion to the default memory tier (DRAM with CPU). That is, the
position of DRAM memory tier is 0.

Unlike memory tier device ID or rank, the position is relative and
dynamic.

Best Regards,
Huang, Ying


