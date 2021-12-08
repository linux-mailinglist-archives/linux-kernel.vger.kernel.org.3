Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DED46DB79
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239276AbhLHSsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:48:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229528AbhLHSse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:48:34 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8IRd3D028203;
        Wed, 8 Dec 2021 18:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=xWGwN7U4Fr1BsnnzuECdtDGI0IheBomIYjVi5FXjfaU=;
 b=FnD539QLTLl2b8DprLleipTmKWnarBq4Thyy941uP1zsQb0RmjuLwvgGjqofom94ss+t
 xwN1zMyPdIoHw1dsZJ3rtNWu25A/2fZWkQJ6RIY65XqDoFcCK9480DMGN0Qn03+FBtmc
 qj9ZpwXi/SH2xB8XB4GPje1kOJNGNIkCi6NPliR0LzH3ZCEvFUhsTqmw+HbV9M96QwuO
 haYzokoTwL+R4paLqkjUh520qXkjo9MBiP18HdAEu9sXfW9bdHI+qrNTJPD2+hASB8+E
 kz6ajgCp7HeLVHU/iHRlf/OTsAvbZiqdCAD/4veFudxgQFKGnqSM5mVS8qRsem68UpeK xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cu20kr9p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 18:44:45 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B8Ii5I8005430;
        Wed, 8 Dec 2021 18:44:45 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cu20kr9nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 18:44:45 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B8IcTA7013328;
        Wed, 8 Dec 2021 18:44:43 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3cqyy9s4ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 18:44:43 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B8Iidfu32702940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Dec 2021 18:44:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A238111C04C;
        Wed,  8 Dec 2021 18:44:39 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4997A11C052;
        Wed,  8 Dec 2021 18:44:39 +0000 (GMT)
Received: from osiris (unknown [9.145.73.233])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  8 Dec 2021 18:44:39 +0000 (GMT)
Date:   Wed, 8 Dec 2021 19:44:37 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "open list:S390" <linux-s390@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] s390: remove useless preempt_(dis/en)able calls in
 ftrace code
Message-ID: <YbD9FVUlKHqNxqbX@osiris>
References: <20211208162719.178393-1-wander@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208162719.178393-1-wander@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GGzKTnFl586odG2iTulWfzWN8OgzTV6b
X-Proofpoint-ORIG-GUID: TevYcqzpw_1NOWdtqmR1NHAJUOKLXK_E
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_07,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 impostorscore=0 spamscore=0 mlxlogscore=916 clxscore=1015
 lowpriorityscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112080104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 01:27:19PM -0300, Wander Lairson Costa wrote:
> Commit ce5e48036c9e("ftrace: disable preemption when recursion locked")
> moved the preempt disabling/enabling code to
> ftrace_test_recursion_trylock() and ftrace_test_recursion_unlock(), and
> cleaned up all direct calls in the ftrace code. But it left s390 behind.
> 
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
>  arch/s390/kernel/ftrace.c | 2 --
>  1 file changed, 2 deletions(-)

Thanks, but I applied already this one:
https://lore.kernel.org/r/20211208151503.1510381-1-jmarchan@redhat.com
