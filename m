Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4ED4B4D74
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349857AbiBNLAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:00:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349793AbiBNLAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:00:19 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CFA6E577
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:27:30 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21E9vJ8M012845;
        Mon, 14 Feb 2022 10:27:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=5Cql8dXf6zpFttdIUI1qH8Ky6jjwEbhazuyRpGNMdrQ=;
 b=TColJU3zPeIiecOdVHNnk7IRgYtMgHo/h2zDVfSItx3sI8J0BFDPgHLu1nW5m9BWu0v6
 +qjrrOOvbdYcRYXdr0Ja6dsIW076zjnOjoujAhukra7rzf5jSB7t1JXaQ1GHQ+Criovv
 fn2WObsppvvXXzbWsEM20JP5mjXe8Ip4Z4qJsEynJ15SGHfITj8p0sFhjF0Cxeh7YWio
 I6YewztWaE/40JVO01a4rN3Py9NRZO0nUSnVO034JqtRlbUM5dsbTIfZXQVoHogsQWZC
 ahC4ETpBlMLRdzy7uxp1M1TrWhFGnt0m7dInhbNiMcZ3Qn33TODz1nz6SR4OvZ03uWwc WA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e71jvkyg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:27:17 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21EA7XdD024705;
        Mon, 14 Feb 2022 10:27:16 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e71jvkyf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:27:16 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21EAHem7007376;
        Mon, 14 Feb 2022 10:27:14 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3e64h9kw1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 10:27:14 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21EARB1G15860194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 10:27:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F1984C040;
        Mon, 14 Feb 2022 10:27:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11D2D4C058;
        Mon, 14 Feb 2022 10:27:09 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 14 Feb 2022 10:27:08 +0000 (GMT)
Date:   Mon, 14 Feb 2022 15:57:07 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Gautham Shenoy <gautham.shenoy@amd.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <20220214102707.GI618915@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20220208094334.16379-1-mgorman@techsingularity.net>
 <20220208094334.16379-3-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20220208094334.16379-3-mgorman@techsingularity.net>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: E9AafZgo0-M2AmVBocERWu99ZZcjUrXz
X-Proofpoint-GUID: _pFjGU5jWjesqayOsdCGO9Jr7hw_bIpH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_01,2022-02-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140058
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mel Gorman <mgorman@techsingularity.net> [2022-02-08 09:43:34]:

> Commit 7d2b5dd0bcc4 ("sched/numa: Allow a floating imbalance between NUMA
> nodes") allowed an imbalance between NUMA nodes such that communicating
> tasks would not be pulled apart by the load balancer. This works fine when
> there is a 1:1 relationship between LLC and node but can be suboptimal
> for multiple LLCs if independent tasks prematurely use CPUs sharing cache.
> 
> Zen* has multiple LLCs per node with local memory channels and due to
> the allowed imbalance, it's far harder to tune some workloads to run
> optimally than it is on hardware that has 1 LLC per node. This patch
> allows an imbalance to exist up to the point where LLCs should be balanced
> between nodes.
> 
> On a Zen3 machine running STREAM parallelised with OMP to have on instance
> per LLC the results and without binding, the results are
> 
>                             5.17.0-rc0             5.17.0-rc0
> 

Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju
