Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1723459F707
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbiHXJ7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbiHXJ7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:59:46 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3407A519;
        Wed, 24 Aug 2022 02:59:43 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27O9WFJq035230;
        Wed, 24 Aug 2022 09:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=wNN/FM1pslClq4PA/Vw/Ikr2p+6VyIzMoVg3UFHtxuc=;
 b=CQUmVIOMoTf9R6uN9RGaT4JX8h63ZNJX3NBAzV4Np9vblqLm+iA+Mx9XzabMs2qG//aC
 HkvAFYNUDuQ9P+DzqHJDHftf9tTo++uvx+BmOi0d+l8shAGQRxledLjD6k3bEcrrqZRY
 OyecI87xpZVLXnStoWnRBWFcVJzAz5IhHSqotujZ79/S0wKZjXpjITtEkN1lXGC3aPvI
 +CCM+ZTyykwAfk7qN8Qoo8aLX2EiEVXVBxjH6l0IuAL6iDbH8zjcYsdfhrOgA3ssY9xm
 BsUyoB7LBhpXxv9dLD5IWjr5uNa0/XNq6RMjUGmAYQdryQ1yCmmlNIfdwMR+ClK9GVS3 Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j5hedgvpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 09:59:42 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27O9Zs5T006799;
        Wed, 24 Aug 2022 09:59:42 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j5hedgvnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 09:59:42 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27O9okl8016026;
        Wed, 24 Aug 2022 09:59:40 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3j2q88umgt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 09:59:40 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27O9xYb330015804
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Aug 2022 09:59:34 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF3FC4C040;
        Wed, 24 Aug 2022 09:59:34 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A5894C044;
        Wed, 24 Aug 2022 09:59:34 +0000 (GMT)
Received: from localhost (unknown [9.171.51.29])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 24 Aug 2022 09:59:34 +0000 (GMT)
Date:   Wed, 24 Aug 2022 11:59:32 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Brian Foster <bfoster@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        geraldsc@de.ibm.com
Subject: Re: [PATCH] s390: fix double free of GS and RI CBs on fork() failure
Message-ID: <your-ad-here.call-01661335172-ext-9896@work.hours>
References: <20220816155407.537372-1-bfoster@redhat.com>
 <YwXavKvCjHp9a84E@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YwXavKvCjHp9a84E@osiris>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rVHBxEW5pgclDN5D3gI5N2knT1doseyY
X-Proofpoint-ORIG-GUID: O8YZxl3kp01fY_NXVl5X6SN8yKRtLfZc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_05,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0 mlxlogscore=974
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208240036
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 10:01:00AM +0200, Heiko Carstens wrote:
> On Tue, Aug 16, 2022 at 11:54:07AM -0400, Brian Foster wrote:
> > The pointers for guarded storage and runtime instrumentation control
> > blocks are stored in the thread_struct of the associated task. These
> > pointers are initially copied on fork() via arch_dup_task_struct()
> > and then cleared via copy_thread() before fork() returns. If fork()
> > happens to fail after the initial task dup and before copy_thread(),
> > the newly allocated task and associated thread_struct memory are
> > freed via free_task() -> arch_release_task_struct(). This results in
> > a double free of the guarded storage and runtime info structs
> > because the fields in the failed task still refer to memory
> > associated with the source task.
> > 
> > This problem can manifest as a BUG_ON() in set_freepointer() (with
> > CONFIG_SLAB_FREELIST_HARDENED enabled) or KASAN splat (if enabled)
> > when running trinity syscall fuzz tests on s390x. To avoid this
> > problem, clear the associated pointer fields in
> > arch_dup_task_struct() immediately after the new task is copied.
> > Note that the RI flag is still cleared in copy_thread() because it
> > resides in thread stack memory and that is where stack info is
> > copied.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  arch/s390/kernel/process.c | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
> 
> Thanks for debugging and fixing this!
> 
> Vasily, could you pick this one up, and also add the Fixes: and Cc:
> stable tags as proposed by Gerald?
> Thanks!

Applied, Thank you!
