Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9596B537ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 14:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbiE3Muw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 30 May 2022 08:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbiE3Muu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 08:50:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1B262CEA
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 05:50:49 -0700 (PDT)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LBZtl1hd1z6H77v;
        Mon, 30 May 2022 20:47:27 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 30 May 2022 14:50:46 +0200
Received: from localhost (10.81.211.14) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 30 May
 2022 13:50:45 +0100
Date:   Mon, 30 May 2022 13:50:43 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ying Huang <ying.huang@intel.com>
CC:     Wei Xu <weixugc@google.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Greg Thelen" <gthelen@google.com>, Yang Shi <shy828301@gmail.com>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Alistair Popple" <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Feng Tang" <feng.tang@intel.com>, Linux MM <linux-mm@kvack.org>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "David Rientjes" <rientjes@google.com>
Subject: Re: RFC: Memory Tiering Kernel Interfaces (v3)
Message-ID: <20220530135043.00001e88@Huawei.com>
In-Reply-To: <1281d918c07b05ac82aee290018ad08d212e0aaa.camel@intel.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
        <c453491b-6dc1-a008-d6f4-3c806eebd2ef@linux.ibm.com>
        <CAAPL-u_NwJuxWe7Wfn3A1sut+QwEmoZh2QUBQKNPq4bU=NjybA@mail.gmail.com>
        <1281d918c07b05ac82aee290018ad08d212e0aaa.camel@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.81.211.14]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
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

On Sun, 29 May 2022 12:31:30 +0800
Ying Huang <ying.huang@intel.com> wrote:

> On Fri, 2022-05-27 at 09:30 -0700, Wei Xu wrote:
> > On Fri, May 27, 2022 at 6:41 AM Aneesh Kumar K V
> > <aneesh.kumar@linux.ibm.com> wrote:  
> > > 
> > > On 5/27/22 2:52 AM, Wei Xu wrote:
> > >   
> > > >    The order of memory tiers is determined by their rank values, not by
> > > >    their memtier device names.
> > > > 
> > > >    - /sys/devices/system/memtier/possible
> > > > 
> > > >      Format: ordered list of "memtier(rank)"
> > > >      Example: 0(64), 1(128), 2(192)
> > > > 
> > > >      Read-only.  When read, list all available memory tiers and their
> > > >      associated ranks, ordered by the rank values (from the highest
> > > >       tier to the lowest tier).
> > > >   
> > > 
> > > Did we discuss the need for this? I haven't done this in the patch
> > > series I sent across.  
> > 
> > The "possible" file is only needed if we decide to hide the
> > directories of memtiers that have no nodes.  We can remove this
> > interface and always show all memtier directories to keep things
> > simpler.  
> 
> When discussed offline, Tim Chen pointed out that with the proposed
> interface, it's unconvenient to know the position of a given memory tier
> in all memory tiers.  We must sort "rank" of all memory tiers to know
> that.  "possible" file can be used for that.  Although "possible" file
> can be generated with a shell script, it's more convenient to show it
> directly.
> 
> Another way to address the issue is to add memtierN/pos for each memory
> tier as suggested by Tim.  It's readonly and will show position of
> "memtierN" in all memory tiers.  It's even better to show the relative
> postion to the default memory tier (DRAM with CPU). That is, the
> position of DRAM memory tier is 0.
> 
> Unlike memory tier device ID or rank, the position is relative and
> dynamic.

Hi,

I'm unconvinced.  This is better done with a shell script than
by adding ABI we'll have to live with for ever..

I'm no good at shell scripting but this does the job 
grep "" tier*/rank | sort -n -k 2 -t : 

tier2/rank:50
tier0/rank:100
tier1/rank:200
tier3/rank:240

I'm sure someone more knowledgeable will do it in a simpler fashion still.

Jonathan

> 
> Best Regards,
> Huang, Ying
> 
> 

