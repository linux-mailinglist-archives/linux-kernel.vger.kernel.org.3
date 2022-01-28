Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA78449F2F9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 06:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241695AbiA1FYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 00:24:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231458AbiA1FYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 00:24:05 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20S4gVeN021001;
        Fri, 28 Jan 2022 05:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=N8c6f9rrM/7nONQTPrGqnOSST8MztLJ9N5JYV+zxdGs=;
 b=ncpPzwDca4czHjb6h6QnI77DLS1AqrSfaKigJDMu1Mlq5CzTYvK73PSaG2WlciKhsKhE
 v4hU+waWsPoY1xK1JSAJB3xEVDRl6oJx9Rq5mhxVGn6WKFOB7iKwb8z0wJFWThagKDeq
 x99KDtij89eItyEO1gc67BFuAJTr4xR8iJoxDrfOhGx/gY6Hp4c54KF9cT6Nw/v3H4bU
 xr+KteoVVyNkQh8MuM0i1AJmq21wMC35EXf4+07lyOG8f0w614M8icHXrYcWFbycm0pu
 HujI25cv+jOg7YPUOQmdbae5WYgCFOWgRaZKHdDpomq8MoTQa5d6Yvp4W/glARnF1mnz cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dv9purjtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 05:23:53 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20S4x8ip012621;
        Fri, 28 Jan 2022 05:23:52 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dv9purjta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 05:23:52 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20S5MIxG023963;
        Fri, 28 Jan 2022 05:23:50 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3dr9ja3qkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 05:23:50 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20S5Nmb744630430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 05:23:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6EB7AE04D;
        Fri, 28 Jan 2022 05:23:47 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B02BAE059;
        Fri, 28 Jan 2022 05:23:46 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 28 Jan 2022 05:23:45 +0000 (GMT)
Date:   Fri, 28 Jan 2022 10:53:45 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Rik van Riel <riel@surriel.com>
Subject: Re: [RFC PATCH 1/2] NUMA balancing: fix NUMA topology type for
 memory tiering system
Message-ID: <20220128052345.GA618915@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20220128023842.1946583-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20220128023842.1946583-1-ying.huang@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vS33TxzT8d0NU51wZOkmmFCK4CmChOJG
X-Proofpoint-ORIG-GUID: paZdJlyaX5HVqwiOyc6dU3bWc3_1rHTX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_06,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280029
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Huang Ying <ying.huang@intel.com> [2022-01-28 10:38:41]:

> 
> One possible fix is to ignore CPU-less nodes when detecting NUMA
> topology type in init_numa_topology_type().  That works well for the
> example system.  Is it good in general for any system with CPU-less
> nodes?
> 

A CPUless node at the time online doesn't necessarily mean a CPUless node
for the entire boot. For example: On PowerVM Lpars, aka powerpc systems,
some of the nodes may start as CPUless nodes and then CPUS may get
populated/hotplugged on them.

Hence I am not sure if adding a check for CPUless nodes at node online may
work for such systems.

> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
>  kernel/sched/topology.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

-- 
Thanks and Regards
Srikar Dronamraju
