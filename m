Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E6250FB45
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349336AbiDZKrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349315AbiDZKq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:46:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EF21105
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 03:38:00 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KndXQ0PCPz6F94R;
        Tue, 26 Apr 2022 18:33:58 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 12:37:57 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 11:37:56 +0100
Date:   Tue, 26 Apr 2022 11:37:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
CC:     Jagdish Gediya <jvgediya@linux.ibm.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <baolin.wang@linux.alibaba.com>,
        <dave.hansen@linux.intel.com>, <shy828301@gmail.com>,
        <weixugc@google.com>, <gthelen@google.com>,
        <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 0/7] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
Message-ID: <20220426113755.00004721@Huawei.com>
In-Reply-To: <132150b3-73f8-ea94-2839-91b92e5d2991@linux.ibm.com>
References: <20220422195516.10769-1-jvgediya@linux.ibm.com>
        <4b986b46afb2fe888c127d8758221d0f0d3ec55f.camel@intel.com>
        <YmaC2jw6WaQ4X+8W@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
        <20220425145735.000007ca@Huawei.com>
        <132150b3-73f8-ea94-2839-91b92e5d2991@linux.ibm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Apr 2022 20:23:56 +0530
Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> wrote:

> On 4/25/22 7:27 PM, Jonathan Cameron wrote:
> > On Mon, 25 Apr 2022 16:45:38 +0530
> > Jagdish Gediya <jvgediya@linux.ibm.com> wrote:
> >  
> 
> ....
> 
> >> $ numactl -H
> >> available: 2 nodes (0-1)
> >> node 0 cpus: 0 1 2 3 4 5 6 7
> >> node 0 size: 14272 MB
> >> node 0 free: 13392 MB
> >> node 1 cpus:
> >> node 1 size: 2028 MB
> >> node 1 free: 1971 MB
> >> node distances:
> >> node   0   1
> >>    0:  10  40
> >>    1:  40  10
> >>
> >> 1) without N_DEMOTION_TARGETS patch series, 1 is demotion target
> >>     for 0 even when 1 is DRAM node and there is no demotion targets for 1.  
> > 
> > I'm not convinced the distinction between DRAM and persistent memory is
> > valid. There will definitely be systems with a large pool
> > of remote DRAM (and potentially no NV memory) where the right choice
> > is to demote to that DRAM pool.
> > 
> > Basing the decision on whether the memory is from kmem or
> > normal DRAM doesn't provide sufficient information to make the decision.
> >   
> >>
> >> $ cat /sys/bus/nd/devices/dax0.0/target_node
> >> 2
> >> $
> >> # cd /sys/bus/dax/drivers/
> >> :/sys/bus/dax/drivers# ls
> >> device_dax  kmem
> >> :/sys/bus/dax/drivers# cd device_dax/
> >> :/sys/bus/dax/drivers/device_dax# echo dax0.0 > unbind
> >> :/sys/bus/dax/drivers/device_dax# echo dax0.0 >  ../kmem/new_id
> >> :/sys/bus/dax/drivers/device_dax# numactl -H
> >> available: 3 nodes (0-2)
> >> node 0 cpus: 0 1 2 3 4 5 6 7
> >> node 0 size: 14272 MB
> >> node 0 free: 13380 MB
> >> node 1 cpus:
> >> node 1 size: 2028 MB
> >> node 1 free: 1961 MB
> >> node 2 cpus:
> >> node 2 size: 0 MB
> >> node 2 free: 0 MB
> >> node distances:
> >> node   0   1   2
> >>    0:  10  40  80
> >>    1:  40  10  80
> >>    2:  80  80  10
> >>
> >> 2) Once this new node brought online,  without N_DEMOTION_TARGETS
> >> patch series, 1 is demotion target for 0 and 2 is demotion target
> >> for 1.
> >>
> >> With this patch series applied,
> >> 1) No demotion target for either 0 or 1 before dax device is online  
> > 
> > I'd argue that is wrong.  At this state you have a tiered memory system
> > be it one with just DRAM.  Using it as such is correct behavior that
> > we should not be preventing.  Sure some usecases wouldn't want that
> > arrangement but some do want it.
> >   
> 
> I missed this in my earlier reply. Are you suggesting that we would want 
> Node 1 (DRAM only memory numa node) to act as demotion target for Node 
> 0?  Any reason why we would want to do that? That is clearly opposite of 
> what we are trying to do here. IMHO node using Node1 as demotion target 
> for Node0 is a better default?

In this case, because of the small size that probably wouldn't make sense.
But, if that were a CXL memory pool with multiple TB of DDR then yes
we would want the default case to use that memory for the demotion path.

So I don't think DDR vs NV via kmem alone is the right basis for a decision
on the default behavior.

Sure we can make this all a userspace problem.

Jonathan

> 
> 
> 
> -aneesh

