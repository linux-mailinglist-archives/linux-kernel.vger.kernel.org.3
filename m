Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD15D53BDAC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 19:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbiFBR64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 13:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237757AbiFBR6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 13:58:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE01BCA4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 10:58:53 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 252F2SSS013568;
        Thu, 2 Jun 2022 17:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=xUuCcQqlY4f7d4geq8tgWU8nwAKebEBknQg7K+tn22c=;
 b=FQy1yTcoDacZpryheHI+ghM6HfpskVJTRPY6C7+i92D8vmeYWjsTahlpR67mXWSgIWm7
 Iih1q2vA8/3l2d+HL9S3HJulHqOX/cWjustqANsysYwwk+fiaJ64NMEIxNW0UYracPsc
 61jYTwNXQ5S7Hm08wkLovQLaGHtkJbBmqDzfdp3Mkch3hIHK89MBkm6xdcnKp1fx2LdM
 ma8A+KqRvRkvXhZ2/yCa/D6W919JKKzs/5dKYm3zmQEYjSl/ULr7TGLQN7hxsUXJgITf
 p5SCLAAGZw1SIFuJavvRM6pK2zL08yq2vc1dWWe8oXMvwKk1vGnoE52ftcHOYeOcujJ9 oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3geyg6u1sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 17:58:35 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 252HkRl5005700;
        Thu, 2 Jun 2022 17:58:35 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3geyg6u1s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 17:58:34 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 252Ho2Df012943;
        Thu, 2 Jun 2022 17:58:33 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02wdc.us.ibm.com with ESMTP id 3gbc9343nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Jun 2022 17:58:33 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 252HwWRR32047428
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Jun 2022 17:58:32 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6438813604F;
        Thu,  2 Jun 2022 17:58:32 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E6EF136051;
        Thu,  2 Jun 2022 17:58:32 +0000 (GMT)
Received: from localhost (unknown [9.41.178.242])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  2 Jun 2022 17:58:32 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        haren@linux.vnet.ibm.com, npiggin@gmail.com
Subject: Re: [PATCH 0/2] Disabling NMI watchdog during LPM's memory transfer
In-Reply-To: <20220601155315.35109-1-ldufour@linux.ibm.com>
References: <20220601155315.35109-1-ldufour@linux.ibm.com>
Date:   Thu, 02 Jun 2022 12:58:31 -0500
Message-ID: <87a6av0wxk.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vBiR_e7qqRwY_Se2lNxko1RNIf57vRhj
X-Proofpoint-ORIG-GUID: A9afMTaJmbDkyXUnXbHk-183ld65fIWV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-02_05,2022-06-02_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 clxscore=1011
 phishscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206020073
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Dufour <ldufour@linux.ibm.com> writes:
> When a partition is transferred, once it arrives at the destination node,
> the partition is active but much of its memory must be transferred from the
> start node.
>
> It depends on the activity in the partition, but the more CPU the partition
> has, the more memory to be transferred is likely to be. This causes latency
> when accessing pages that need to be transferred, and often, for large
> partitions, it triggers the NMI watchdog.

It also triggers warnings from other watchdogs and subsystems that
have soft latency requirements  - softlockup, RCU, workqueue. The issue
is more general than the NMI watchdog.

> The NMI watchdog causes the CPU stack to dump where it appears to be
> stuck. In this case, it does not bring much information since it can happen
> during any memory access of the kernel.

When the site of a watchdog backtrace shows a thread stuck on a routine
memory access as opposed to something like a lock acquisition, that is
actually useful information that shouldn't be discarded. It tells us the
platform is failing to adequately virtualize partition memory. This
isn't a benign situation and it's likely to unacceptably affect real
workloads. The kernel is ideally situated to detect and warn about this.

> In addition, the NMI interrupt mechanism is not secure and can generate a
> dump system in the event that the interruption is taken while
> MSR[RI]=0.

This sounds like a general problem with that facility that isn't
specific to partition migration? Maybe it should be disabled altogether
until that can be fixed?

> Given how often hard lockups are detected when transferring large
> partitions, it seems best to disable the watchdog NMI until the memory
> transfer from the start node is complete.

At this time, I'm far from convinced. Disabling the watchdog is going to
make the underlying problems in the platform and/or network harder to
understand.
