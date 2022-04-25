Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0B850DA16
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbiDYHag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236638AbiDYHaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:30:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FCE7649
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:27:16 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23P4eJYK002375;
        Mon, 25 Apr 2022 07:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=u1UT4CUxd/YYFOMSOf/exDLoJmvo9HMj2jhqr5BX2UA=;
 b=eKgsore+6intfYeqAMNACX+VvMDB9KSUWlNtDlMLlgXRfmeAnmCICpKiQjzIlWXL5reC
 FKJYNZMK/jjMO/WKheNVl0Glh+NPNP3Qa45dqqeiWMVFcSm2Xqye4vHdR0P3yFEOEYVM
 R25E7aeilUykt/+yHAaXiFRKJHBKuwqS8XLblVZ7EQPCa5cTEiPxR1P4l7ay/d97pJkI
 ZGnp8r6D5ADbQpCqvTyRR6j/RbfvRu32x2DKqfHPJXjYNMUilN5OBm/okv19ovs/KY+9
 Kr/TfY0hJjuZJ17G4/r/dVscTZY7nZKac42REnwlhLCLeXXdcPXWfquMBea5y0R4eS48 Jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fmu3k2mu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 07:27:07 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23P70uD2013338;
        Mon, 25 Apr 2022 07:27:06 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fmu3k2mtk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 07:27:06 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23P79HeN028341;
        Mon, 25 Apr 2022 07:27:04 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 3fm8qj1ykj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 07:27:04 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23P7E3Zq35389700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 07:14:03 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4201242042;
        Mon, 25 Apr 2022 07:27:02 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D48D42041;
        Mon, 25 Apr 2022 07:26:58 +0000 (GMT)
Received: from li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com (unknown [9.43.47.198])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Apr 2022 07:26:58 +0000 (GMT)
Date:   Mon, 25 Apr 2022 12:56:51 +0530
From:   Jagdish Gediya <jvgediya@linux.ibm.com>
To:     "ying.huang@intel.com" <ying.huang@intel.com>
Cc:     Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        MichalHocko <mhocko@kernel.org>,
        Brice Goglin <brice.goglin@gmail.com>
Subject: Re: [PATCH v2 0/5] mm: demotion: Introduce new node state
 N_DEMOTION_TARGETS
Message-ID: <YmZNO3Ec+yhP+xvJ@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
References: <CAAPL-u-aeceXFUNdok_GYb2aLhZa0zBBuSqHxFznQob3PbJt7Q@mail.gmail.com>
 <a80647053bba44623094995730e061f0e6129677.camel@intel.com>
 <CAAPL-u89Jxutu1VH0LnO5VGdMbkLvc2M9eapuwP-y9oG9QSsrA@mail.gmail.com>
 <610ccaad03f168440ce765ae5570634f3b77555e.camel@intel.com>
 <CAAPL-u9ktM82zAW_OVwqTmQsr-XC8XOPmAsjoiCLo18cxUWA=A@mail.gmail.com>
 <8e31c744a7712bb05dbf7ceb2accf1a35e60306a.camel@intel.com>
 <CAAPL-u9uP+FUh7Yn0ByOECo+EP32ZABnCvNPKQB9JCA68VHEqQ@mail.gmail.com>
 <78b5f4cfd86efda14c61d515e4db9424e811c5be.camel@intel.com>
 <YmKKwXa2XI/nwac0@li-6e1fa1cc-351b-11b2-a85c-b897023bb5f3.ibm.com>
 <200e95cf36c1642512d99431014db8943fed715d.camel@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200e95cf36c1642512d99431014db8943fed715d.camel@intel.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H2_R4E_GrH1eKUI8sMbLSOf6PSJVSiT1
X-Proofpoint-ORIG-GUID: WorVUv7tIRt1tXSWRCFP6wR7nKuAFNm4
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_02,2022-04-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 clxscore=1011 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250031
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 11:02:47AM +0800, ying.huang@intel.com wrote:
> Hi, All,
> 
> On Fri, 2022-04-22 at 16:30 +0530, Jagdish Gediya wrote:
> 
> [snip]
> 
> > I think it is necessary to either have per node demotion targets
> > configuration or the user space interface supported by this patch
> > series. As we don't have clear consensus on how the user interface
> > should look like, we can defer the per node demotion target set
> > interface to future until the real need arises.
> > 
> > Current patch series sets N_DEMOTION_TARGET from dax device kmem
> > driver, it may be possible that some memory node desired as demotion
> > target is not detected in the system from dax-device kmem probe path.
> > 
> > It is also possible that some of the dax-devices are not preferred as
> > demotion target e.g. HBM, for such devices, node shouldn't be set to
> > N_DEMOTION_TARGETS. In future, Support should be added to distinguish
> > such dax-devices and not mark them as N_DEMOTION_TARGETS from the
> > kernel, but for now this user space interface will be useful to avoid
> > such devices as demotion targets.
> > 
> > We can add read only interface to view per node demotion targets
> > from /sys/devices/system/node/nodeX/demotion_targets, remove
> > duplicated /sys/kernel/mm/numa/demotion_target interface and instead
> > make /sys/devices/system/node/demotion_targets writable.
> > 
> > Huang, Wei, Yang,
> > What do you suggest?
> 
> We cannot remove a kernel ABI in practice.  So we need to make it right
> at the first time.  Let's try to collect some information for the kernel
> ABI definitation.

/sys/kernel/mm/numa/demotion_target was introduced in v2, I was
talking about removing it from next version of the series as the
similar interface is available as a result of introducing
N_DEMOTION_TARGETS at /sys/devices/system/node/demotion_targets, so
instead of introducing duplicate interface to write N_DEMOTION_TARGETS,
we can instead make /sys/devices/system/node/demotion_targets writable.

> The below is just a starting point, please add your requirements.
> 
> 1. Jagdish has some machines with DRAM only NUMA nodes, but they don't
> want to use that as the demotion targets.  But I don't think this is a
> issue in practice for now, because demote-in-reclaim is disabled by
> default.
> 
> 2. For machines with PMEM installed in only 1 of 2 sockets, for example,
> 
> Node 0 & 2 are cpu + dram nodes and node 1 are slow
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
> We have 2 choices,
> 
> a)
> node	demotion targets
> 0	1
> 2	1
> 
> b)
> node	demotion targets
> 0	1
> 2	X
> 
> a) is good to take advantage of PMEM.  b) is good to reduce cross-socket
> traffic.  Both are OK as defualt configuration.  But some users may
> prefer the other one.  So we need a user space ABI to override the
> default configuration.
> 
> 3. For machines with HBM (High Bandwidth Memory), as in
> 
> https://lore.kernel.org/lkml/39cbe02a-d309-443d-54c9-678a0799342d@gmail.com/
> 
> > [1] local DDR = 10, remote DDR = 20, local HBM = 31, remote HBM = 41
> 
> Although HBM has better performance than DDR, in ACPI SLIT, their
> distance to CPU is longer.  We need to provide a way to fix this.  The
> user space ABI is one way.  The desired result will be to use local DDR
> as demotion targets of local HBM.
> 
> Best Regards,
> Huang, Ying
> 
> 
