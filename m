Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DE253E7FE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240209AbiFFO7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240194AbiFFO7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:59:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF693082FF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:59:26 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LGxSR3ZQmz687hk;
        Mon,  6 Jun 2022 22:58:15 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 16:59:24 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 6 Jun
 2022 15:59:22 +0100
Date:   Mon, 6 Jun 2022 15:59:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
CC:     <linux-mm@kvack.org>, <akpm@linux-foundation.org>,
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
Subject: Re: [RFC PATCH v4 2/7] mm/demotion: Expose per node memory tier to
 sysfs
Message-ID: <20220606155920.00004ce9@Huawei.com>
In-Reply-To: <fbebbd2b-2ddb-bee6-5e12-67e3e18648ee@linux.ibm.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
        <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
        <20220527122528.129445-3-aneesh.kumar@linux.ibm.com>
        <20220527151531.00002a0c@Huawei.com>
        <fbebbd2b-2ddb-bee6-5e12-67e3e18648ee@linux.ibm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
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

On Fri, 3 Jun 2022 14:10:47 +0530
Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> wrote:

> On 5/27/22 7:45 PM, Jonathan Cameron wrote:
> > On Fri, 27 May 2022 17:55:23 +0530
> > "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> >   
> >> From: Jagdish Gediya <jvgediya@linux.ibm.com>
> >>
> >> Add support to read/write the memory tierindex for a NUMA node.
> >>
> >> /sys/devices/system/node/nodeN/memtier
> >>
> >> where N = node id
> >>
> >> When read, It list the memory tier that the node belongs to.
> >>
> >> When written, the kernel moves the node into the specified
> >> memory tier, the tier assignment of all other nodes are not
> >> affected.
> >>
> >> If the memory tier does not exist, writing to the above file
> >> create the tier and assign the NUMA node to that tier.  
> > creates
> > 
> > There was some discussion in v2 of Wei Xu's RFC that what matter
> > for creation is the rank, not the tier number.
> > 
> > My suggestion is move to an explicit creation file such as
> > memtier/create_tier_from_rank
> > to which writing the rank gives results in a new tier
> > with the next device ID and requested rank.  
> 
> I think the below workflow is much simpler.
> 
> :/sys/devices/system# cat memtier/memtier1/nodelist
> 1-3
> :/sys/devices/system# cat node/node1/memtier
> 1
> :/sys/devices/system# ls memtier/memtier*
> nodelist  power  rank  subsystem  uevent
> /sys/devices/system# ls memtier/
> default_rank  max_tier  memtier1  power  uevent
> :/sys/devices/system# echo 2 > node/node1/memtier
> :/sys/devices/system#
> 
> :/sys/devices/system# ls memtier/
> default_rank  max_tier  memtier1  memtier2  power  uevent
> :/sys/devices/system# cat memtier/memtier1/nodelist
> 2-3
> :/sys/devices/system# cat memtier/memtier2/nodelist
> 1
> :/sys/devices/system#
> 
> ie, to create a tier we just write the tier id/tier index to 
> node/nodeN/memtier file. That will create a new memory tier if needed 
> and add the node to that specific memory tier. Since for now we are 
> having 1:1 mapping between tier index to rank value, we can derive the 
> rank value from the memory tier index.
> 
> For dynamic memory tier support, we can assign a rank value such that 
> new memory tiers are always created such that it comes last in the 
> demotion order.

I'm not keen on having to pass through an intermediate state where
the rank may well be wrong, but I guess it's not that harmful even
if it feels wrong ;)

Races are potentially a bit of a pain though depending on what we
expect the usage model to be.

There are patterns (CXL regions for example) of guaranteeing the
'right' device is created by doing something like 

cat create_tier > temp.txt 
#(temp gets 2 for example on first call then
# next read of this file gets 3 etc)

cat temp.txt > create_tier
# will fail if there hasn't been a read of the same value

Assuming all software keeps to the model, then there are no
race conditions over creation.  Otherwise we have two new
devices turn up very close to each other and userspace scripting
tries to create two new tiers - if it races they may end up in
the same tier when that wasn't the intent.  Then code to set
the rank also races and we get two potentially very different
memories in a tier with a randomly selected rank.

Fun and games...  And a fine illustration why sysfs based 'device'
creation is tricky to get right (and lots of cases in the kernel
don't).

Jonathan


> 
> -aneesh
> 
> 
> 
> 

