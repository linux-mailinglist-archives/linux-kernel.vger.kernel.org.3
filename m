Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4484EAF04
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 16:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237724AbiC2OGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 10:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiC2OGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 10:06:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409B9163E06
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 07:05:05 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22TDhVIM012937;
        Tue, 29 Mar 2022 14:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=dJlka0qXhPU7f2TFEHuFeLpBGs5SfiPowXo2kN2nvp4=;
 b=YvfydyhpmeHBCAiYU/qJA71LxRTmxlwreSKyC9oMHIJSN+8yMqCdu70Pb+2KPbP74sY1
 lslEAqFWAejC59+2/rSq/8+fD7DTOLFj8DOQDKiIvyIzdxLOrUYwGCsHH2158VnSGtD1
 7EZ8eopFZdlU9f5Tx+pqDres5iv3s8MrB2MuacK5qlpfTeG3yfe8hsTJqqqS7Pq5TQfF
 Gu0h6cet4/MLQSHwJcNErkY+Yt8aoUtNu7Mthyo6rqKoKpo/6OZI1fe4IpK6Kcjqwg0I
 NdpvTATbEhcI+F4Z0LBb7XR/vMYivmNY8VJroolJVqWl2eskAH5cnqdOcokuMtQN4Tz9 fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f40q1ca11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Mar 2022 14:04:58 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22TDhTku002677;
        Tue, 29 Mar 2022 14:04:58 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f40q1ca08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Mar 2022 14:04:58 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22TE4SDT015994;
        Tue, 29 Mar 2022 14:04:55 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3f1tf8xbum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Mar 2022 14:04:55 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22TE4r5i35062128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 14:04:53 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93A0642042;
        Tue, 29 Mar 2022 14:04:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 172B742041;
        Tue, 29 Mar 2022 14:04:50 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com (unknown [9.211.138.152])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 29 Mar 2022 14:04:49 +0000 (GMT)
Date:   Tue, 29 Mar 2022 19:34:32 +0530
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, aneesh.kumar@linux.ibm.com,
        dave.hansen@linux.intel.com, ying.huang@intel.com
Subject: Re: [PATCH] mm: migrate: set demotion targets differently
Message-ID: <YkMR8OY779Bcri3I@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220329115222.8923-1-jvgediya@linux.ibm.com>
 <b7d1ab3b-e92c-d3aa-72cb-b80cc1a61e85@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7d1ab3b-e92c-d3aa-72cb-b80cc1a61e85@linux.alibaba.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B7PKZ-dEYCU-cfMUGvoteWTL5sfq-7mL
X-Proofpoint-ORIG-GUID: fRhK3oXVRX1J-cp-LaRsZNqr41sO579Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-29_05,2022-03-29_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 08:26:05PM +0800, Baolin Wang wrote:
Hi Baolin,
> Hi Jagdish,
> 
> On 3/29/2022 7:52 PM, Jagdish Gediya wrote:
> > The current implementation to identify the demotion
> > targets limits some of the opportunities to share
> > the demotion targets between multiple source nodes.
> > 
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
> >    0:  10  20  40  40  80
> >    1:  20  10  40  40  80
> >    2:  40  40  10  40  80
> >    3:  40  40  40  10  80
> >    4:  80  80  80  80  10
> > 
> > The existing implementation gives below demotion targets,
> > 
> > node    demotion_target
> >   0              3, 2
> >   1              4
> >   2              X
> >   3              X
> >   4		X
> > 
> > With this patch applied, below are the demotion targets,
> > 
> > node    demotion_target
> >   0              3, 2
> >   1              3, 2
> >   2              3
> >   3              4
> >   4		X
> 
> Node 2 and node 3 both are slow memory and have same distance, why node 2
> should demote cold memory to node 3? They should have the same target
> demotion node 4, which is the slowest memory node, right?
> 
Current demotion target finding algorithm works based on best distance, as distance between node 2 & 3 is 40 and distance between node 2 & 4 is 80, node 2 demotes to node 3.
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
> >    0:  10  20  20  40
> >    1:  20  10  20  40
> >    2:  20  20  10  40
> >    3:  40  40  40  10
> > 
> > The existing implementation gives below demotion targets,
> > 
> > node    demotion_target
> >   0              3
> >   1              X
> >   2              X
> >   3              X
> > 
> > With this patch applied, below are the demotion targets,
> > 
> > node    demotion_target
> >   0              3
> >   1              3
> >   2              3
> >   3              X
> 
> Sounds reasonable.
> 
> > 
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
> >    0:  10  40  20  80
> >    1:  40  10  80  80
> >    2:  20  80  10  40
> >    3:  80  80  40  10
> > 
> > The existing implementation gives below demotion targets,
> > 
> > node    demotion_target
> >   0              3
> >   1              X
> >   2              3
> >   3              X
> 
> If I understand correctly, this is not true. The demotion route should be as
> below with existing implementation:
> node 0 ---> node 1
> node 1 ---> X
> node 2 ---> node 3
> node 3 ---> X
> 
Its typo, It should be 0 -> 1, Will correct it in v2.
> > 
> > With this patch applied, below are the demotion targets,
> > 
> > node    demotion_target
> >   0              1
> >   1              3
> >   2              3
> >   3              X
> > 
> > As it can be seen above, node 3 can be demotion target for node
> > 1 but existing implementation doesn't configure it that way. It
> > is better to move pages from node 1 to node 3 instead of moving
> > it from node 1 to swap.
> 
> Which means node 3 is the slowest memory node?
>
Node 1 and 3 are equally slower but 1 is near to 0 and 3 is near to 2. Basically you can think of it like node 1 is slow memory logical node near to node 0 and node 3 is slow memory logical node near to node 2.
> > 
> > Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > ---
> >   mm/migrate.c | 75 ++++++++++++++++++++++++++++------------------------
> >   1 file changed, 41 insertions(+), 34 deletions(-)
> > 
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 3d60823afd2d..7ec8d934e706 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -2381,10 +2381,13 @@ static int establish_migrate_target(int node, nodemask_t *used,
> >    */
> >   static void __set_migration_target_nodes(void)
> >   {
> > -	nodemask_t next_pass	= NODE_MASK_NONE;
> > -	nodemask_t this_pass	= NODE_MASK_NONE;
> >   	nodemask_t used_targets = NODE_MASK_NONE;
> >   	int node, best_distance;
> > +	nodemask_t *src_nodes;
> > +
> > +	src_nodes = kcalloc(nr_node_ids, sizeof(nodemask_t), GFP_KERNEL);
> > +	if (!src_nodes)
> > +		return;
> >   	/*
> >   	 * Avoid any oddities like cycles that could occur
> > @@ -2393,29 +2396,39 @@ static void __set_migration_target_nodes(void)
> >   	 */
> >   	disable_all_migrate_targets();
> > -	/*
> > -	 * Allocations go close to CPUs, first.  Assume that
> > -	 * the migration path starts at the nodes with CPUs.
> > -	 */
> > -	next_pass = node_states[N_CPU];
> > -again:
> > -	this_pass = next_pass;
> > -	next_pass = NODE_MASK_NONE;
> > -	/*
> > -	 * To avoid cycles in the migration "graph", ensure
> > -	 * that migration sources are not future targets by
> > -	 * setting them in 'used_targets'.  Do this only
> > -	 * once per pass so that multiple source nodes can
> > -	 * share a target node.
> > -	 *
> > -	 * 'used_targets' will become unavailable in future
> > -	 * passes.  This limits some opportunities for
> > -	 * multiple source nodes to share a destination.
> > -	 */
> > -	nodes_or(used_targets, used_targets, this_pass);
> > +	for_each_online_node(node) {
> > +		int tmp_node;
> > -	for_each_node_mask(node, this_pass) {
> >   		best_distance = -1;
> > +		used_targets = NODE_MASK_NONE;
> > +
> > +		/*
> > +		 * Avoid adding same node as the demotion target.
> > +		 */
> > +		node_set(node, used_targets);
> > +
> > +		/*
> > +		 * Add CPU NUMA nodes to the used target list so that it
> > +		 * won't be considered a demotion target.
> > +		 */
> > +		nodes_or(used_targets, used_targets, node_states[N_CPU]);
> > +
> > +		/*
> > +		 * Add all nodes that has appeared as source node of demotion
> > +		 * for this target node.
> > +		 *
> > +		 * To avoid cycles in the migration "graph", ensure
> > +		 * that migration sources are not future targets by
> > +		 * setting them in 'used_targets'.
> > +		 */
> > +		for_each_node_mask(tmp_node, src_nodes[node])
> > +			nodes_or(used_targets, used_targets, src_nodes[tmp_node]);
> > +
> > +		/*
> > +		 * Now update the demotion src nodes with other nodes in graph
> > +		 * which got computed above.
> > +		 */
> > +		nodes_or(src_nodes[node], src_nodes[node], used_targets);
> >   		/*
> >   		 * Try to set up the migration path for the node, and the target
> > @@ -2434,20 +2447,14 @@ static void __set_migration_target_nodes(void)
> >   				best_distance = node_distance(node, target_node);
> >   			/*
> > -			 * Visit targets from this pass in the next pass.
> > -			 * Eventually, every node will have been part of
> > -			 * a pass, and will become set in 'used_targets'.
> > +			 * Add this node in the src_nodes list so that we can
> > +			 * detect the looping.
> >   			 */
> > -			node_set(target_node, next_pass);
> > +			node_set(node, src_nodes[target_node]);
> >   		} while (1);
> >   	}
> > -	/*
> > -	 * 'next_pass' contains nodes which became migration
> > -	 * targets in this pass.  Make additional passes until
> > -	 * no more migrations targets are available.
> > -	 */
> > -	if (!nodes_empty(next_pass))
> > -		goto again;
> > +
> > +	kfree(src_nodes);
> >   }
> >   /*
