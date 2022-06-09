Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B4D544688
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242774AbiFIIzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbiFIIz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:55:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C162EC2E6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:53:21 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJd6P0x48z67vYh;
        Thu,  9 Jun 2022 16:48:29 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 10:53:16 +0200
Received: from localhost (10.81.202.195) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 9 Jun
 2022 09:53:15 +0100
Date:   Thu, 9 Jun 2022 09:53:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>, Wei Xu <weixugc@google.com>,
        Huang Ying <ying.huang@intel.com>,
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
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v5 0/9] mm/demotion: Memory tiers and demotion
Message-ID: <20220609095313.000003f7@Huawei.com>
In-Reply-To: <8516237f-c1a0-aefa-274a-9f8794ae0ccd@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
        <YqCq0cUCnQmS6SV4@cmpxchg.org>
        <8516237f-c1a0-aefa-274a-9f8794ae0ccd@linux.ibm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.202.195]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2022 19:50:11 +0530
Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> wrote:

> On 6/8/22 7:27 PM, Johannes Weiner wrote:
> > Hi Aneesh,
> > 
> > On Fri, Jun 03, 2022 at 07:12:28PM +0530, Aneesh Kumar K.V wrote:  
> >> * The current tier initialization code always initializes
> >>    each memory-only NUMA node into a lower tier.  But a memory-only
> >>    NUMA node may have a high performance memory device (e.g. a DRAM
> >>    device attached via CXL.mem or a DRAM-backed memory-only node on
> >>    a virtual machine) and should be put into a higher tier.  
> > 
> > I have to disagree with this premise. The CXL.mem bus has different
> > latency and bandwidth characteristics. It's also conceivable that
> > cheaper and slower DRAM is connected to the CXL bus (think recycling
> > DDR4 DIMMS after switching to DDR5). DRAM != DRAM.
> > 
> > Our experiments with production workloads show regressions between
> > 15-30% in serviced requests when you don't distinguish toptier DRAM
> > from lower tier DRAM. While it's fixable with manual tuning, your
> > patches would bring reintroduce this regression it seems.
> > 
> > Making tiers explicit is a good idea, but can we keep the current
> > default that CPU-less nodes are of a lower tier than ones with CPU?
> > I'm having a hard time imagining where this wouldn't be true... Or why
> > it shouldn't be those esoteric cases that need the manual tuning.  
> 
> This was mostly driven by virtual machine configs where we can find 
> memory only NUMA nodes depending on the resource availability in the 
> hypervisor.
> 
> Will these CXL devices be initialized by a driver? 

In many cases no (almost all cases pre CXL 2.0) - they are setup by the
BIOS / firmware and presented just like normal memory (except pmem in which case
kmem will be relevant as you suggest).  Hopefully everyone will follow
the guidance and provide appropriate HMAT as well as SLIT.

If we want to do a better job of the default policy, we should take
the actual distances into account (ideally including the detail
HMAT provides).

Jonathan

> For example, if they 
> are going to be initialized via dax kmem, we already consider them lower 
> memory tier as with this patch series.
> 
> -aneesh

