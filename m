Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB2F516ADC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 08:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377987AbiEBG37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 02:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiEBG3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 02:29:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A219641E
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 23:26:25 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2425PxBM023753;
        Mon, 2 May 2022 06:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=/bN9H5J34zj0F4jdbLgzwCkZsU1qqfHCCMvbF+K5ZjE=;
 b=GoCKF/eeLLHo73MoELpUdmpMYHk60oRH7q/1Vy+hJ7uxVo3ZRsz1wkDFKbxJvbdMoHMC
 8QIj7EQfn+irIzwQZr8qjKpXEiWe/FsDc7LdbaSYnNSciA3SHwYk9vmCnv/WjxRzaghy
 CaMgcpzhAa+itgxWnY+anGXBoAT4n3V31QWdeQMyaz9dW6Y/crhK4Dr/5lvoWHa2+xje
 PPoUrd0karReqsvq2dTnfKYS65TIHn+lKvRgZI/KEQSsO1u+EEeppri0A1tb49FpN8tJ
 4HQD4wg8hqXwBNO0lfp1vCet21t4NnBsKdJOMTjyASpbtbGvlnnVOJcrUE5M7219O0kV dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ft9588xjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 06:25:57 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2426PvBd003053;
        Mon, 2 May 2022 06:25:57 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ft9588xjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 06:25:57 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2426NBK2022414;
        Mon, 2 May 2022 06:25:55 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma05wdc.us.ibm.com with ESMTP id 3frvr9khkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 May 2022 06:25:55 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2426PtxB34013476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 May 2022 06:25:55 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48812B2066;
        Mon,  2 May 2022 06:25:55 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 585C0B206C;
        Mon,  2 May 2022 06:25:49 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.74.71])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  2 May 2022 06:25:49 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Yang Shi <shy828301@gmail.com>, Linux MM <linux-mm@kvack.org>,
        Greg Thelen <gthelen@google.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Michal Hocko <mhocko@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Feng Tang <feng.tang@intel.com>, Jonathan.Cameron@huawei.com
Subject: Re: RFC: Memory Tiering Kernel Interfaces
In-Reply-To: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
References: <CAAPL-u9sVx94ACSuCVN8V0tKp+AMxiY89cro0japtyB=xNfNBw@mail.gmail.com>
Date:   Mon, 02 May 2022 11:55:43 +0530
Message-ID: <87ilqov4bc.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tBavHxFj9p49AMvjwO992uc9yzn1wJcY
X-Proofpoint-ORIG-GUID: kbeYfgTovJHWY9wLdyPg4GJZLn40DBM1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_01,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 bulkscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205020046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Xu <weixugc@google.com> writes:

....

>
> Tiering Hierarchy Initialization
> ================================
>
> By default, all memory nodes are in the top tier (N_TOPTIER_MEMORY).
>
> A device driver can remove its memory nodes from the top tier, e.g.
> a dax driver can remove PMEM nodes from the top tier.

Should we look at the tier in which to place the memory an option that
device drivers like dax driver can select? Or dax driver just selects
the desire to mark a specific memory only numa node as demotion target
and won't explicity specify the tier in which it should be placed. I
would like to go for the later and choose the tier details based on the
current memory tiers and the NUMA distance value (even HMAT at some
point in the future). The challenge with NUMA distance though is which
distance value we will pick. For example, in your example1. 

 node   0    1    2    3
    0  10   20   30   40
    1  20   10   40   30
    2  30   40   10   40
    3  40   30   40   10

When Node3 is registered, how do we decide to create a Tier2 or add it
to Tier1? . We could say devices that wish to be placed in the same tier
will have same distance as the existing tier device ie, for the above
case,

node_distance[2][2] == node_distance[2][3] ? Can we expect the firmware
to have distance value like that? 

>
> The kernel builds the memory tiering hierarchy and per-node demotion
> order tier-by-tier starting from N_TOPTIER_MEMORY.  For a node N, the
> best distance nodes in the next lower tier are assigned to
> node_demotion[N].preferred and all the nodes in the next lower tier
> are assigned to node_demotion[N].allowed.
>
> node_demotion[N].preferred can be empty if no preferred demotion node
> is available for node N.
>
> If the userspace overrides the tiers via the memory_tiers sysfs
> interface, the kernel then only rebuilds the per-node demotion order
> accordingly.
>
> Memory tiering hierarchy is rebuilt upon hot-add or hot-remove of a
> memory node, but is NOT rebuilt upon hot-add or hot-remove of a CPU
> node.
>
>
> Memory Allocation for Demotion
> ==============================
>
> When allocating a new demotion target page, both a preferred node
> and the allowed nodemask are provided to the allocation function.
> The default kernel allocation fallback order is used to allocate the
> page from the specified node and nodemask.
>
> The memopolicy of cpuset, vma and owner task of the source page can
> be set to refine the demotion nodemask, e.g. to prevent demotion or
> select a particular allowed node as the demotion target.
>
>
> Examples
> ========
>
> * Example 1:
>   Node 0 & 1 are DRAM nodes, node 2 & 3 are PMEM nodes.
>
>   Node 0 has node 2 as the preferred demotion target and can also
>   fallback demotion to node 3.
>
>   Node 1 has node 3 as the preferred demotion target and can also
>   fallback demotion to node 2.
>
>   Set mempolicy to prevent cross-socket demotion and memory access,
>   e.g. cpuset.mems=0,2
>
> node distances:
> node   0    1    2    3
>    0  10   20   30   40
>    1  20   10   40   30
>    2  30   40   10   40
>    3  40   30   40   10
>
> /sys/devices/system/node/memory_tiers
> 0-1
> 2-3

How can I make Node3 the demotion target for Node2 in this case? Can
we have one file for each tier? ie, we start with
/sys/devices/system/node/memory_tier0. Removing a node with memory from
the above file/list results in the creation of new tiers.

/sys/devices/system/node/memory_tier0
0-1
/sys/devices/system/node/memory_tier1
2-3

echo 2 > /sys/devices/system/node/memory_tier1
/sys/devices/system/node/memory_tier1
2
/sys/devices/system/node/memory_tier2
3

>
> N_TOPTIER_MEMORY: 0-1
>
> node_demotion[]:
>   0: [2], [2-3]
>   1: [3], [2-3]
>   2: [],  []
>   3: [],  []
>
> * Example 2:
>   Node 0 & 1 are DRAM nodes.
>   Node 2 is a PMEM node and closer to node 0.
>
>   Node 0 has node 2 as the preferred and only demotion target.
>
>   Node 1 has no preferred demotion target, but can still demote
>   to node 2.
>
>   Set mempolicy to prevent cross-socket demotion and memory access,
>   e.g. cpuset.mems=0,2
>
> node distances:
> node   0    1    2
>    0  10   20   30
>    1  20   10   40
>    2  30   40   10
>
> /sys/devices/system/node/memory_tiers
> 0-1
> 2
>
> N_TOPTIER_MEMORY: 0-1
>
> node_demotion[]:
>   0: [2], [2]
>   1: [],  [2]
>   2: [],  []
>
>
> * Example 3:
>   Node 0 & 1 are DRAM nodes.
>   Node 2 is a PMEM node and has the same distance to node 0 & 1.
>
>   Node 0 has node 2 as the preferred and only demotion target.
>
>   Node 1 has node 2 as the preferred and only demotion target.
>
> node distances:
> node   0    1    2
>    0  10   20   30
>    1  20   10   30
>    2  30   30   10
>
> /sys/devices/system/node/memory_tiers
> 0-1
> 2
>
> N_TOPTIER_MEMORY: 0-1
>
> node_demotion[]:
>   0: [2], [2]
>   1: [2], [2]
>   2: [],  []
>
>
> * Example 4:
>   Node 0 & 1 are DRAM nodes, Node 2 is a memory-only DRAM node.
>
>   All nodes are top-tier.
>
> node distances:
> node   0    1    2
>    0  10   20   30
>    1  20   10   30
>    2  30   30   10
>
> /sys/devices/system/node/memory_tiers
> 0-2
>
> N_TOPTIER_MEMORY: 0-2
>
> node_demotion[]:
>   0: [],  []
>   1: [],  []
>   2: [],  []
>
>
> * Example 5:
>   Node 0 is a DRAM node with CPU.
>   Node 1 is a HBM node.
>   Node 2 is a PMEM node.
>
>   With userspace override, node 1 is the top tier and has node 0 as
>   the preferred and only demotion target.
>
>   Node 0 is in the second tier, tier 1, and has node 2 as the
>   preferred and only demotion target.
>
>   Node 2 is in the lowest tier, tier 2, and has no demotion targets.
>
> node distances:
> node   0    1    2
>    0  10   21   30
>    1  21   10   40
>    2  30   40   10
>
> /sys/devices/system/node/memory_tiers (userspace override)
> 1
> 0
> 2
>
> N_TOPTIER_MEMORY: 1
>
> node_demotion[]:
>   0: [2], [2]
>   1: [0], [0]
>   2: [],  []
>
> -- Wei
