Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD95500B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbiDNKnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiDNKnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:43:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716EE6A034
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:40:51 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EA51Yu031087;
        Thu, 14 Apr 2022 10:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=64m+OrFCZGKmJRnkY/yyl2HJ7nOdmDpJCOQGp+hxi2w=;
 b=DKuzEl+aahuv/xyBUvfbC/dYekXOV0iSrJ16qId1514sj3SJQYhDyNM6ZtYrMy7j7UUU
 NkhoLfWz9Ds8MA3MWVexYIWazxWKAej+byj7pM/TYGOmpwk4Ur0cV3RJbfFDYcraLBGr
 h5q63kRjw/1fPmNn0RVWMeHbzDdVqNRDiIDmEER/+bGLacJtCWhdtLFUgzwuI31uOjhJ
 wWZJbLERQ/O3o95UYLykJmkr9MvhV1SFzfY26Dx5zJdLY2Zf9CaZJD5PhMmXUs0GI29v
 lJDipH7a8fJORaNXcG4+s2HjxpINUyf/nbjq3LYATbt4DOYv8uCVDhC8ab7IJ3iFNDvD /A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fef9yk9xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 10:40:40 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23EAK1Z1022382;
        Thu, 14 Apr 2022 10:40:39 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fef9yk9wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 10:40:39 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23EAY0QQ030435;
        Thu, 14 Apr 2022 10:40:37 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3fb1s8pp9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 10:40:37 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23EAeZnn54264314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 10:40:35 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F6B2AE045;
        Thu, 14 Apr 2022 10:40:35 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41C25AE051;
        Thu, 14 Apr 2022 10:40:31 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com (unknown [9.43.11.20])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 14 Apr 2022 10:40:30 +0000 (GMT)
Date:   Thu, 14 Apr 2022 16:10:24 +0530
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        baolin.wang@linux.alibaba.com, dave.hansen@linux.intel.com,
        ying.huang@intel.com
Subject: Re: [PATCH v2 1/5] mm: demotion: Set demotion list differently
Message-ID: <Ylf6GI1J5cIXagyl@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220413092206.73974-1-jvgediya@linux.ibm.com>
 <20220413092206.73974-2-jvgediya@linux.ibm.com>
 <20220414100214.00005ad8@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414100214.00005ad8@Huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OAkipke1Rm2Eb2HKprdqYpk0UagB67YZ
X-Proofpoint-ORIG-GUID: b1TQBEkbt27GPHmbo6-NAnh3kTTq4cx4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-14_03,2022-04-14_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204140057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 10:02:14AM +0100, Jonathan Cameron wrote:
> On Wed, 13 Apr 2022 14:52:02 +0530
> Jagdish Gediya <jvgediya@linux.ibm.com> wrote:
> 
> > Sharing used_targets between multiple nodes in a single
> > pass limits some of the opportunities for demotion target
> > sharing.
> > 
> > Don't share the used targets between multiple nodes in a
> > single pass, instead accumulate all the used targets in
> > source nodes shared by all pass, and reset 'used_targets'
> > to source nodes while finding demotion targets for any new
> > node.
> > 
> > This results into some more opportunities to share demotion
> > targets between multiple source nodes, e.g. with below NUMA
> > topology, where node 0 & 1 are cpu + dram nodes, node 2 & 3
> > are equally slower memory only nodes, and node 4 is slowest
> > memory only node,
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
> >  4              X
> > 
> > With this patch applied, below are the demotion targets,
> > 
> > node    demotion_target
> >  0              3, 2
> >  1              3, 2
> 
> Is there an easy way to make the allocation stateful enough so
> that when it sees two identical choices, it alternates between
> them?  Whilst it's going to be workload dependent, my view
> of 'ideal' for this would be.
> 
>    0              3
>    1              2
> 
> Maybe we'll just have to make do with most systems this effects
> having to have some fun userspace code that does cleverer
> balancing - possibly using HMAT info rather than just SLIT
> to give us visibility of interconnect bottlenecks that make
> some migration paths 'unwise'.
>   
> I'm not sure the current HMAT presentation via sysfs gives
> us enough info though so we'll probably need to extend that.
> 
> Jonathan

This patch series also have the support to override the default
demotion targets found by the kernel, however current implementation
of this user space interface doesn't support to set per node demotion
targets, but I am going to modify the user space inetrface according
to Huang's suggestion which can control exact desired targets for
specific nodes.

> >  2              4
> >  3              4
> >  4              X
> > 
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
> > 
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> > ---
> >  mm/migrate.c | 25 ++++++++++++++-----------
> >  1 file changed, 14 insertions(+), 11 deletions(-)
> > 
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index de175e2fdba5..516f4e1348c1 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -2383,7 +2383,7 @@ static void __set_migration_target_nodes(void)
> >  {
> >  	nodemask_t next_pass	= NODE_MASK_NONE;
> >  	nodemask_t this_pass	= NODE_MASK_NONE;
> > -	nodemask_t used_targets = NODE_MASK_NONE;
> > +	nodemask_t source_nodes = NODE_MASK_NONE;
> >  	int node, best_distance;
> >  
> >  	/*
> > @@ -2401,20 +2401,23 @@ static void __set_migration_target_nodes(void)
> >  again:
> >  	this_pass = next_pass;
> >  	next_pass = NODE_MASK_NONE;
> > +
> >  	/*
> > -	 * To avoid cycles in the migration "graph", ensure
> > -	 * that migration sources are not future targets by
> > -	 * setting them in 'used_targets'.  Do this only
> > -	 * once per pass so that multiple source nodes can
> > -	 * share a target node.
> > -	 *
> > -	 * 'used_targets' will become unavailable in future
> > -	 * passes.  This limits some opportunities for
> > -	 * multiple source nodes to share a destination.
> > +	 * Accumulate source nodes to avoid the cycle in migration
> > +	 * list.
> >  	 */
> > -	nodes_or(used_targets, used_targets, this_pass);
> > +	nodes_or(source_nodes, source_nodes, this_pass);
> >  
> >  	for_each_node_mask(node, this_pass) {
> > +		/*
> > +		 * To avoid cycles in the migration "graph", ensure
> > +		 * that migration sources are not future targets by
> > +		 * setting them in 'used_targets'. Reset used_targets
> > +		 * to source nodes for each node in this pass so that
> > +		 * multiple source nodes can share a target node.
> > +		 */
> > +		nodemask_t used_targets = source_nodes;
> > +
> >  		best_distance = -1;
> >  
> >  		/*
> 
