Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0675389BD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 03:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243455AbiEaB5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 21:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiEaB5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 21:57:31 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBED24BD8
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 18:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653962249; x=1685498249;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ySX0o1a0NBK1KoPB58FGYm0+GQ6XT4BanItUrrpKDuo=;
  b=jLUApV4vzFKmaDDJsDW4inFELpYgIgOUI0mGQxlUeiEiw14Uskrafnsm
   tScHc+HXNrzcZOgEmw3FyPFBYv+e0gWyExTDjlvYEglaeW+O86TfSOBu0
   k5rCqwNe44iI3YIFAB7erAx0GqH2tJ9WFOL3450jLPo337Q7L4JHSpU6F
   mbyqekMIAiuBiY2mRckFsI5U2p1HNTnIX7meKcW8CH09z7UNCnBq6Z+Gi
   W/fE46KxDpBPwvkTiXbUYNVD5GCobEe/BwqhSDvZRkU08T7DI9YwKtDv+
   tscj3E7tXfHr/a7eHb81m+bmnXsGLAYGRFIhFBpzmbv5LCyZg+kfC1jgL
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="273919820"
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="273919820"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 18:57:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,263,1647327600"; 
   d="scan'208";a="605413674"
Received: from quanliu1-mobl.ccr.corp.intel.com ([10.254.215.142])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 18:57:23 -0700
Message-ID: <4456dc2520cf2d9368c320eb628e0043d59dfb2f.camel@intel.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v3)
From:   Ying Huang <ying.huang@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Wei Xu <weixugc@google.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>, Linux MM <linux-mm@kvack.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
Date:   Tue, 31 May 2022 09:57:20 +0800
In-Reply-To: <20220530135043.00001e88@Huawei.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
         <c453491b-6dc1-a008-d6f4-3c806eebd2ef@linux.ibm.com>
         <CAAPL-u_NwJuxWe7Wfn3A1sut+QwEmoZh2QUBQKNPq4bU=NjybA@mail.gmail.com>
         <1281d918c07b05ac82aee290018ad08d212e0aaa.camel@intel.com>
         <20220530135043.00001e88@Huawei.com>
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

On Mon, 2022-05-30 at 13:50 +0100, Jonathan Cameron wrote:
> On Sun, 29 May 2022 12:31:30 +0800
> Ying Huang <ying.huang@intel.com> wrote:
> 
> > On Fri, 2022-05-27 at 09:30 -0700, Wei Xu wrote:
> > > On Fri, May 27, 2022 at 6:41 AM Aneesh Kumar K V
> > > <aneesh.kumar@linux.ibm.com> wrote:  
> > > > 
> > > > On 5/27/22 2:52 AM, Wei Xu wrote:
> > > >   
> > > > 
> > > > 
> > > > 
> > > > >    The order of memory tiers is determined by their rank values, not by
> > > > >    their memtier device names.
> > > > > 
> > > > >    - /sys/devices/system/memtier/possible
> > > > > 
> > > > >      Format: ordered list of "memtier(rank)"
> > > > >      Example: 0(64), 1(128), 2(192)
> > > > > 
> > > > >      Read-only.  When read, list all available memory tiers and their
> > > > >      associated ranks, ordered by the rank values (from the highest
> > > > >       tier to the lowest tier).
> > > > >   
> > > > > 
> > > > > 
> > > > > 
> > > > 
> > > > Did we discuss the need for this? I haven't done this in the patch
> > > > series I sent across.  
> > > 
> > > The "possible" file is only needed if we decide to hide the
> > > directories of memtiers that have no nodes.  We can remove this
> > > interface and always show all memtier directories to keep things
> > > simpler.  
> > 
> > When discussed offline, Tim Chen pointed out that with the proposed
> > interface, it's unconvenient to know the position of a given memory tier
> > in all memory tiers.  We must sort "rank" of all memory tiers to know
> > that.  "possible" file can be used for that.  Although "possible" file
> > can be generated with a shell script, it's more convenient to show it
> > directly.
> > 
> > Another way to address the issue is to add memtierN/pos for each memory
> > tier as suggested by Tim.  It's readonly and will show position of
> > "memtierN" in all memory tiers.  It's even better to show the relative
> > postion to the default memory tier (DRAM with CPU). That is, the
> > position of DRAM memory tier is 0.
> > 
> > Unlike memory tier device ID or rank, the position is relative and
> > dynamic.
> 
> Hi,
> 
> I'm unconvinced.  This is better done with a shell script than
> by adding ABI we'll have to live with for ever..
> 
> I'm no good at shell scripting but this does the job 
> grep "" tier*/rank | sort -n -k 2 -t : 
> 
> tier2/rank:50
> tier0/rank:100
> tier1/rank:200
> tier3/rank:240
> 
> I'm sure someone more knowledgeable will do it in a simpler fashion still.

I am OK to leave this to be added later if we found that it's useful.

Best Regards,
Huang, Ying

> Jonathan
> 
> > 
> > Best Regards,
> > Huang, Ying
> > 
> > 
> 


