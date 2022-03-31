Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2334ED850
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 13:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbiCaLTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 07:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbiCaLS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:18:59 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF916206EC0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 04:17:07 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KTgg63tx7z67yyF;
        Thu, 31 Mar 2022 19:14:26 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 31 Mar 2022 13:17:04 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 31 Mar
 2022 12:17:04 +0100
Date:   Thu, 31 Mar 2022 12:17:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
CC:     "Huang, Ying" <ying.huang@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <aneesh.kumar@linux.ibm.com>, <baolin.wang@linux.alibaba.com>,
        <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] mm: migrate: set demotion targets differently
Message-ID: <20220331121702.000070d1@Huawei.com>
In-Reply-To: <YkSHJMsHMtKzCPhS@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220329115222.8923-1-jvgediya@linux.ibm.com>
        <87pmm4c4ys.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <YkSHJMsHMtKzCPhS@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2022 22:06:52 +0530
Jagdish Gediya <jvgediya@linux.ibm.com> wrote:

> Hi Huang,
> 
> On Wed, Mar 30, 2022 at 02:46:51PM +0800, Huang, Ying wrote:
> > Hi, Jagdish,
> > 
> > Jagdish Gediya <jvgediya@linux.ibm.com> writes:
> >   
> > > The current implementation to identify the demotion
> > > targets limits some of the opportunities to share
> > > the demotion targets between multiple source nodes.  
> > 
> > Yes.  It sounds reasonable to share demotion targets among multiple
> > source nodes.
> > 
> > One question, are example machines below are real hardware now or in
> > near future?  Or you just think they are possible?  
> 
> They are not real hardware right now, they are the future possibilities.

I'll strengthen that a bit to say they are highly likely to turn up
fairly soon.  Often they will be result of specific interleaving decisions
and might not come from SRAT (e.g. might be added later as a result of
CXL discovery) but the principal will be the same.  Also, in some
cases the firmware will have done the CXL setup so it will be via SRAT.

example 1:
> > e.g. with below NUMA topology, where node 0 & 1 are
> > cpu + dram nodes, node 2 & 3 are equally slower memory
> > only nodes, and node 4 is slowest memory only node,
> >

Couple of near term examples of systems that will look like this.

2 socket system, each socket has DRAM (0,1) + NVDIMM (2,3) being
used as DRAM.
Also CXL attached memory and to get maximum bandwidth to a large
remote pool, interleave across host bridges in the two sockets
(Node 4) 
An alternative for node 4 is a that the system is using an IO expander
bridge on the CPU interconnect (effectively a CPU less CPU :)

Example 2:
> > e.g. with below NUMA topology, where node 0, 1 & 2 are
> > cpu + dram nodes and node 3 is slow memory node,
> >
3 CPU socket machines are still unusual, but the 2 or 4 socket
equivalents are simplifications of example 1.

Example 3:
> > with below NUMA topology, where node 0 & 2 are cpu + dram
> > nodes and node 1 & 3 are slow memory nodes,
I believe this is what today's simple DRAM + NVDIMM (as cheap
DRAM) 2 sockets servers look like.

Example 4:
> Another example, node 0 & 2 are cpu + dram nodes and node 1 are slow
> memory node near node 0,
> 
Normal system with CXL attached DRAM below an RP in node 0

...

Jonathan


