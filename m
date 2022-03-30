Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5BA4EC9C6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 18:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348870AbiC3QjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 12:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbiC3Qi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:38:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CC4197ACC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 09:37:13 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22UGTJDD006468;
        Wed, 30 Mar 2022 16:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=SkzhXcpiotH1nlj/ozBAc35dIlwauL1Rz80QgCcFxvo=;
 b=eFp22MuLPlz5+X14enOdOtFclwioXIWm0yGvozhX8EuDI4FUYzX3xlWXfRW9mO6zIr0s
 yzljtVfJUnNtq4dLDkAyEj+1amCXWDrvnRmS8AQpYFw0KTYonzmd5XCJpiBPFxsY1Vw2
 kXEcINLxYtWceAQlEifdTLa6DfaeHuwexmAwqxocLE2S1bHbV0xpecDIKZHP1D4aubdX
 JIZcL2VpSBGGI4hSkdNQbyPNvWES6WwqqBsfsj2UQizQGNd6LTRB9iYPYmBB5fgm/yE0
 hIe1PwXVLBj0XzIIzbUJOeYZiMcAmTDCcrgysSY7tsd7TonF66E2CVL/SWxH96Snzq9W wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f4ts6r50m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 16:37:06 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22UGb5KR030944;
        Wed, 30 Mar 2022 16:37:05 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f4ts6r4yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 16:37:05 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22UGYMWh024873;
        Wed, 30 Mar 2022 16:37:04 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3f1tf8ymq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 16:37:03 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22UGb13u40501758
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 16:37:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B9BBAE04D;
        Wed, 30 Mar 2022 16:37:01 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71D40AE057;
        Wed, 30 Mar 2022 16:36:59 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com (unknown [9.43.118.212])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 30 Mar 2022 16:36:59 +0000 (GMT)
Date:   Wed, 30 Mar 2022 22:06:52 +0530
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH] mm: migrate: set demotion targets differently
Message-ID: <YkSHJMsHMtKzCPhS@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220329115222.8923-1-jvgediya@linux.ibm.com>
 <87pmm4c4ys.fsf@yhuang6-desk2.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmm4c4ys.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F-qg0SvYLHB3jZ2UUXIYxE40Lpozq6eZ
X-Proofpoint-ORIG-GUID: 9V6CNswQ1fV9lGS-NLrrToJ7xuE5XaIT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-30_06,2022-03-30_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203300081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huang,

On Wed, Mar 30, 2022 at 02:46:51PM +0800, Huang, Ying wrote:
> Hi, Jagdish,
> 
> Jagdish Gediya <jvgediya@linux.ibm.com> writes:
> 
> > The current implementation to identify the demotion
> > targets limits some of the opportunities to share
> > the demotion targets between multiple source nodes.
> 
> Yes.  It sounds reasonable to share demotion targets among multiple
> source nodes.
> 
> One question, are example machines below are real hardware now or in
> near future?  Or you just think they are possible?

They are not real hardware right now, they are the future possibilities.

> And, before going into the implementation details, I think that we can
> discuss the perfect demotion order firstly.
> 
> > Implement a logic to identify the loop in the demotion
> > targets such that all the possibilities of demotion can
> > be utilized. Don't share the used targets between all
> > the nodes, instead create the used targets from scratch
> > for each individual node based on for what all node this
> > node is a demotion target. This helps to share the demotion
> > targets without missing any possible way of demotion.
> >
> > e.g. with below NUMA topology, where node 0 & 1 are
> > cpu + dram nodes, node 2 & 3 are equally slower memory
> > only nodes, and node 4 is slowest memory only node,
> >
> > available: 5 nodes (0-4)
> > node 0 cpus: 0 1
> > node 0 size: n MB
> > node 0 free: n MB
> > node 1 cpus: 2 3
> > node 1 size: n MB
> > node 1 free: n MB
> > node 2 cpus:
> > node 2 size: n MB
> > node 2 free: n MB
> > node 3 cpus:
> > node 3 size: n MB
> > node 3 free: n MB
> > node 4 cpus:
> > node 4 size: n MB
> > node 4 free: n MB
> > node distances:
> > node   0   1   2   3   4
> >   0:  10  20  40  40  80
> >   1:  20  10  40  40  80
> >   2:  40  40  10  40  80
> >   3:  40  40  40  10  80
> >   4:  80  80  80  80  10
> >
> > The existing implementation gives below demotion targets,
> >
> > node    demotion_target
> >  0              3, 2
> >  1              4
> >  2              X
> >  3              X
> >  4		X
> >
> > With this patch applied, below are the demotion targets,
> >
> > node    demotion_target
> >  0              3, 2
> >  1              3, 2
> >  2              3
> >  3              4
> >  4		X
> 
> For such machine, I think the perfect demotion order is,
> 
> node    demotion_target
>  0              2, 3
>  1              2, 3
>  2              4
>  3              4
>  4              X

Current implementation works based on the best distance algorithm,
this patch doesn't change it either, so based on the distance, the
demotion list is what I have mentioned. I understand 4 is better
target for 2 but as per the mentioned numa distances and current
algorithm, it doesn't get configured like that in the kernel.

> > e.g. with below NUMA topology, where node 0, 1 & 2 are
> > cpu + dram nodes and node 3 is slow memory node,
> >
> > available: 4 nodes (0-3)
> > node 0 cpus: 0 1
> > node 0 size: n MB
> > node 0 free: n MB
> > node 1 cpus: 2 3
> > node 1 size: n MB
> > node 1 free: n MB
> > node 2 cpus: 4 5
> > node 2 size: n MB
> > node 2 free: n MB
> > node 3 cpus:
> > node 3 size: n MB
> > node 3 free: n MB
> > node distances:
> > node   0   1   2   3
> >   0:  10  20  20  40
> >   1:  20  10  20  40
> >   2:  20  20  10  40
> >   3:  40  40  40  10
> >
> > The existing implementation gives below demotion targets,
> >
> > node    demotion_target
> >  0              3
> >  1              X
> >  2              X
> >  3              X
> >
> > With this patch applied, below are the demotion targets,
> >
> > node    demotion_target
> >  0              3
> >  1              3
> >  2              3
> >  3              X
> 
> I think this is perfect already.
> 
> > with below NUMA topology, where node 0 & 2 are cpu + dram
> > nodes and node 1 & 3 are slow memory nodes,
> >
> > available: 4 nodes (0-3)
> > node 0 cpus: 0 1
> > node 0 size: n MB
> > node 0 free: n MB
> > node 1 cpus:
> > node 1 size: n MB
> > node 1 free: n MB
> > node 2 cpus: 2 3
> > node 2 size: n MB
> > node 2 free: n MB
> > node 3 cpus:
> > node 3 size: n MB
> > node 3 free: n MB
> > node distances:
> > node   0   1   2   3
> >   0:  10  40  20  80
> >   1:  40  10  80  80
> >   2:  20  80  10  40
> >   3:  80  80  40  10
> >
> > The existing implementation gives below demotion targets,
> >
> > node    demotion_target
> >  0              3
> >  1              X
> >  2              3
> >  3              X
> 
> Should be as below as you said in another email of the thread.
> 
> node    demotion_target
>  0              1
>  1              X
>  2              3
>  3              X
> 
> > With this patch applied, below are the demotion targets,
> >
> > node    demotion_target
> >  0              1
> >  1              3
> >  2              3
> >  3              X
> 
> The original demotion order looks better for me.  1 and 3 are at the
> same level from the perspective of the whole system.
> 
> Another example, node 0 & 2 are cpu + dram nodes and node 1 are slow
> memory node near node 0,
> 
> available: 3 nodes (0-2)
> node 0 cpus: 0 1
> node 0 size: n MB
> node 0 free: n MB
> node 1 cpus:
> node 1 size: n MB
> node 1 free: n MB
> node 2 cpus: 2 3
> node 2 size: n MB
> node 2 free: n MB
> node distances:
> node   0   1   2
>   0:  10  40  20
>   1:  40  10  80
>   2:  20  80  10
> 
> 
> Demotion order 1:
> 
> node    demotion_target
>  0              1
>  1              X
>  2              X
> 
> Demotion order 2:
> 
> node    demotion_target
>  0              1
>  1              X
>  2              1
> 
> Demotion order 2 looks better.  But I think that demotion order 1 makes
> some sense too (like node reclaim mode).
> 
> It seems that,
> 
> If a demotion target has same distance to several current demotion
> sources, the demotion target should be shared among the demotion
> sources.

Yes, and that is where this patch is useful.

> And as Dave pointed out, we may eventually need a mechanism to override
> the default demotion order generated automatically.  So we can just use
> some simple mechanism that makes sense in most cases in kernel
> automatically.  And leave the best demotion for users to some
> customization mechanism.

Yes, We need a mechanism to override the default demotion list prepared
by the current implementation. PowerVM can have a cpu less dram node
as well, which infact are not the right target for demotion because
it is the fast memory. We need to distinguish between memory tiers
so that slow memory can be utilized for the demotion even when there
are fast memory only numa nodes.

I think we may see implementations in future to override the default
behavior e.g. when systems have both fast only and slow only memory
nodes and in that case it will make sense to demote to slow memory
only node even if it is far, but this patch is to put the current
implementation to its intended design 'best distance based demotion
targets'.

> > As it can be seen above, node 3 can be demotion target for node
> > 1 but existing implementation doesn't configure it that way. It
> > is better to move pages from node 1 to node 3 instead of moving
> > it from node 1 to swap.
> >
> > Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> 
> Best Regards,
> Huang, Ying
> 
> [snip]
> 
Best Regards,
Jagdish
