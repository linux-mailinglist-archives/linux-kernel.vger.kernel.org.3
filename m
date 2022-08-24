Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9AD59F4A9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbiHXIBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbiHXIBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:01:11 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9691783F3F;
        Wed, 24 Aug 2022 01:01:10 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27O7hjFP010737;
        Wed, 24 Aug 2022 08:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=6C2JK0hD1M4+foRQbs9qo82DnLQoH/8Yv2orjahtMkM=;
 b=Qt9VpY0r4/NLmXNZt7uJs4j9Ew26TDaKsgzPh4rPTklsay5g0gtBJeRZCfKXjXlwpkyX
 FvVe7iBc16oE9R8WdainrjXkVKYh3IQVL5LTU/kyr7wMuZBPhISWRECjta0ut8BvXxY9
 3i9h/2jDXONTvxX2ak4qPWDsLwFxXqeBUzV2Bo4lMhpqlCO3lLH2RI8Oi2zm+G5cEOY+
 BmXojlkjSiWZCjjIbSMuUBdy3eyod7tCFySbyKpLDnaq0DpW7DZ/BNx7CUOqm8T1/6BZ
 pF2A1SAwrLMfAphItAbBtBv++9+tos2SvYrYfHRxLiypSgzekc2noUhi8YHNNFr6V52a DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j5fun8gp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 08:01:09 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27O7hscP010968;
        Wed, 24 Aug 2022 08:01:09 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j5fun8gnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 08:01:09 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27O7oxvA020011;
        Wed, 24 Aug 2022 08:01:07 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3j2q88uh9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 08:01:07 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27O812lo18481610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 08:01:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A8F9A405F;
        Wed, 24 Aug 2022 08:01:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1972BA4060;
        Wed, 24 Aug 2022 08:01:02 +0000 (GMT)
Received: from osiris (unknown [9.145.48.74])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 24 Aug 2022 08:01:02 +0000 (GMT)
Date:   Wed, 24 Aug 2022 10:01:00 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Brian Foster <bfoster@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        geraldsc@de.ibm.com
Subject: Re: [PATCH] s390: fix double free of GS and RI CBs on fork() failure
Message-ID: <YwXavKvCjHp9a84E@osiris>
References: <20220816155407.537372-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816155407.537372-1-bfoster@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: waZWfcq3iPo7elkdwy-OCjLA5TlyNbnA
X-Proofpoint-GUID: olUQZxdnqg8W1AAUodOAWxm8xWmiGkC8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_04,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=807 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208240029
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 11:54:07AM -0400, Brian Foster wrote:
> The pointers for guarded storage and runtime instrumentation control
> blocks are stored in the thread_struct of the associated task. These
> pointers are initially copied on fork() via arch_dup_task_struct()
> and then cleared via copy_thread() before fork() returns. If fork()
> happens to fail after the initial task dup and before copy_thread(),
> the newly allocated task and associated thread_struct memory are
> freed via free_task() -> arch_release_task_struct(). This results in
> a double free of the guarded storage and runtime info structs
> because the fields in the failed task still refer to memory
> associated with the source task.
> 
> This problem can manifest as a BUG_ON() in set_freepointer() (with
> CONFIG_SLAB_FREELIST_HARDENED enabled) or KASAN splat (if enabled)
> when running trinity syscall fuzz tests on s390x. To avoid this
> problem, clear the associated pointer fields in
> arch_dup_task_struct() immediately after the new task is copied.
> Note that the RI flag is still cleared in copy_thread() because it
> resides in thread stack memory and that is where stack info is
> copied.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
>  arch/s390/kernel/process.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>

Thanks for debugging and fixing this!

Vasily, could you pick this one up, and also add the Fixes: and Cc:
stable tags as proposed by Gerald?
Thanks!
