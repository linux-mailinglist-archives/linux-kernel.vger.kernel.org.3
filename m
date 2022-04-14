Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AF5500AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242210AbiDNKTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242200AbiDNKTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:19:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A43E716CA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 03:17:07 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EA51kW027799;
        Thu, 14 Apr 2022 10:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=3b36n74eKaezjOFzVbV4tP/HH1v9dsc7nWFlqd4Oh4c=;
 b=InpyNVXdHEZ7e0DxJpGrb7OEfT4LReQCedW364LUPJTqTC2DHWSZTftwVEhCGunJIk7P
 rjWmMlWq0Knn8EgIyhOSCsfU9PvEAEG0CuuctpLZlc0ZbmzkbbKd2/HqK3F4dUvzoC+O
 SeN7Rh02TUn+1jKT/t0NgSdofKTa1syjSm1eS4M0R/v/31xsjSxPOGaafzyCL99N2pMN
 7r+KbtamzCbr27NnnQxY0UQP7TE+LygMHSCp1vjdCLwZIf/QoRuOYUZM5XeU4srEwIMA
 Dk3EQmFak1yFEEtRXIaxJRIEsyoKzb4oPK+feh+YWKKmMdMssIonJqUlOB9U6NjOlI2L +A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3febx9xrsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 10:17:03 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23EA6Fbh033625;
        Thu, 14 Apr 2022 10:17:02 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3febx9xrrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 10:17:02 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23EACHuZ016823;
        Thu, 14 Apr 2022 10:17:00 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3fb1s906xf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 10:17:00 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23EAGvGc53346786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 10:16:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1E134C046;
        Thu, 14 Apr 2022 10:16:57 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 408544C05C;
        Thu, 14 Apr 2022 10:16:54 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com (unknown [9.43.11.20])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 14 Apr 2022 10:16:53 +0000 (GMT)
Date:   Thu, 14 Apr 2022 15:46:47 +0530
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, baolin.wang@linux.alibaba.com,
        dave.hansen@linux.intel.com, ying.huang@intel.com
Subject: Re: [PATCH v2 0/5] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
Message-ID: <Ylf0j6T1wzpxsZv/@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <20220413092206.73974-1-jvgediya@linux.ibm.com>
 <20220413144434.6eedb827c629a3a7e08f56b6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413144434.6eedb827c629a3a7e08f56b6@linux-foundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wyD4wyb6_bTKTckYCfyMuH-A_CP9Eeea
X-Proofpoint-ORIG-GUID: Eme84XOi6IpMbGrBDiA9SuOjxsP9rL-R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-14_02,2022-04-14_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 02:44:34PM -0700, Andrew Morton wrote:
> On Wed, 13 Apr 2022 14:52:01 +0530 Jagdish Gediya <jvgediya@linux.ibm.com> wrote:
> 
> > Current implementation to find the demotion targets works
> > based on node state N_MEMORY, however some systems may have
> > dram only memory numa node which are N_MEMORY but not the
> > right choices as demotion targets.
> 
> Why are they not the right choice?  Please describe this fully so we
> can understand the motivation and end-user benefit of the proposed
> change.  And please more fully describe the end-user benefits of this
> change.

Some systems(e.g. PowerVM) have DRAM(fast memory) only NUMA node
which are N_MEMORY as well as slow memory(persistent memory) only
NUMA node which are also N_MEMORY. As the current demotion target
finding algorithm works based on N_MEMORY and best distance, it will
choose DRAM only NUMA node as demotion target instead of persistent
memory node on such systems. If DRAM only NUMA node is filled with
demoted pages then at some point new allocations can start falling
to persistent memory, so basically cold pages are in fast memor
(due to demotion) and new pages are in slow memory, this is why
persistent memory nodes should be utilized for demotion and dram node
should be avoided for demotion so that they can be used for new
allocations.

Current implementation can work fine on the system where the memory
only numa nodes are possible only for persistent/slow memory but it
is not suitable for the like of systems I have mentioned above.

Introduction of this new node state N_DEMOTION_TARGETS will provide
the solution to handle demotion for the like of systems I have mentioned,
without affecting the existing behavior.

> > This patch series introduces the new node state
> > N_DEMOTION_TARGETS, which is used to distinguish the nodes which
> > can be used as demotion targets, node_states[N_DEMOTION_TARGETS]
> > is used to hold the list of nodes which can be used as demotion
> > targets, support is also added to set the demotion target
> > list from user space so that default behavior can be overridden.
> 
> Permanently extending the kernel ABI is a fairly big deal.  Please
> fully explain the end-user value, usage scenarios, etc.
> 
> What would go wrong if we simply omitted this interface?

I am going to modify this interface according to review feedback in
next version, but let me explain why it is needed with examples,

Based on topology, and available memory tiers in the system, it may
be possible that users don't want to utilize all the demotion targets
configured by kernel by default for e.g.,

1. To reduce cross socket traffic
2. To use only slowest memory as demotion targets when there are
   multiple slow memory only nodes available

The current patch series handles option 2 above, but doesn't handle
option 1 so next version will have that support and might be different
implementation to handle such scenarios.

Examples 1
----------

with below NUMA topology, where node 0 & 1 are cpu + dram nodes,
node 2 & 3 are equally slower memory only nodes, and node 4
is slowest memory only node,

available: 5 nodes (0-4)
node 0 cpus: 0 1
node 0 size: n MB
node 0 free: n MB
node 1 cpus: 2 3
node 1 size: n MB
node 1 free: n MB
node 2 cpus:
node 2 size: n MB
node 2 free: n MB
node 3 cpus:
node 3 size: n MB
node 3 free: n MB
node 4 cpus:
node 4 size: n MB
node 4 free: n MB
node distances:
node   0   1   2   3   4
  0:  10  20  40  40  80
  1:  20  10  40  40  80
  2:  40  40  10  40  80
  3:  40  40  40  10  80
  4:  80  80  80  80  10

This patch series by default prepares below demotion list,

node    demotion_target
 0              3, 2
 1              3, 2
 2              4
 3              4
 4              X

but It may be possible that user want to utilize node 2 & 3 only
for new allocations and only node 4 for demotion.

Example 2
---------

with below NUMA topology where Node 0 & 2 are cpu + dram nodes and
node 1 is slow memory node near node 0,

available: 3 nodes (0-2)
node 0 cpus: 0 1
node 0 size: n MB
node 0 free: n MB
node 1 cpus:
node 1 size: n MB
node 1 free: n MB
node 2 cpus: 2 3
node 2 size: n MB
node 2 free: n MB
node distances:
node   0   1   2
  0:  10  40  20
  1:  40  10  80
  2:  20  80  10

This patch series by default prepares below demotion list,

node    demotion_target
0              1
1              X
2              1

However it may be possible that user may want to avoid node 1 as
demotion target for node 2 to reduce cross socket traffic.

> > node state N_DEMOTION_TARGETS is also set from the dax kmem
> > driver, certain type of memory which registers through dax kmem
> > (e.g. HBM) may not be the right choices for demotion so in future
> > they should be distinguished based on certain attributes and dax
> > kmem driver should avoid setting them as N_DEMOTION_TARGETS,
> > however current implementation also doesn't distinguish any 
> > such memory and it considers all N_MEMORY as demotion targets
> > so this patch series doesn't modify the current behavior.
> > 
> > Current code which sets migration targets is modified in
> > this patch series to avoid some of the limitations on the demotion
> > target sharing and to use N_DEMOTION_TARGETS only nodes while
> > finding demotion targets.
> > 
> > Changelog
> > ----------
> > 
> > v2:
> > In v1, only 1st patch of this patch series was sent, which was
> > implemented to avoid some of the limitations on the demotion
> > target sharing, however for certain numa topology, the demotion
> > targets found by that patch was not most optimal, so 1st patch
> > in this series is modified according to suggestions from Huang
> > and Baolin. Different examples of demotion list comparasion
> > between existing implementation and changed implementation can
> > be found in the commit message of 1st patch.
> > 
> > Jagdish Gediya (5):
> >   mm: demotion: Set demotion list differently
> >   mm: demotion: Add new node state N_DEMOTION_TARGETS
> >   mm: demotion: Add support to set targets from userspace
> >   device-dax/kmem: Set node state as N_DEMOTION_TARGETS
> >   mm: demotion: Build demotion list based on N_DEMOTION_TARGETS
> > 
> >  .../ABI/testing/sysfs-kernel-mm-numa          | 12 ++++
> 
> This description is rather brief.  Some additional user-facing material
> under Documentation/ would help.  Describe the format for writing to the
> file, what is seen when reading from it, provide a bit of help to the
> user so they can understand how to use it, what effects they might see,
> etc.

Sure, Will do in next version.

> >  drivers/base/node.c                           |  4 ++
> >  drivers/dax/kmem.c                            |  2 +
> >  include/linux/nodemask.h                      |  1 +
> >  mm/migrate.c                                  | 67 +++++++++++++++----
> >  5 files changed, 72 insertions(+), 14 deletions(-)
> 
