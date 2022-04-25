Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5635750DF03
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241783AbiDYLnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241737AbiDYLmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:42:53 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04242F3A5;
        Mon, 25 Apr 2022 04:39:48 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23PBMUKW009006;
        Mon, 25 Apr 2022 11:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=MDTOIXJfavf+w5wx+LCRBdmnS44P7vHM3YGFPJBKp3U=;
 b=g1VPIS/Tj+9N0cfPKpibiFf+5D88TsH6n0YKVImsyIUCBz3cHJ67K9BjSInY8bPBPv2B
 IEsIG3wurBTEuFy7RXGGkU4NdrodJ0KUh9T4X9E5sc1YH8MU5VgMK5TkH/L+v1awiOrN
 04g/wLnHqacbRVWY17G0Pfpj9OppDu5ir95O6zfhtYiFugkuJhlrLnoP5kUiZ9cSpr9l
 n1RKRru5blzjfJ0Xmdyrnm09JLy/gCwI81B573ZXp97JCmEKBlRcI66nvpWWyeVphVBe
 0OY2xeCCZiflhj3bYy1ExG6yKCK9sTct4Oc4uP3EshXcTcB+yuaSo+T9HmtZO0s7I/QA xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fnqha4sgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 11:39:46 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23PB14HE039798;
        Mon, 25 Apr 2022 11:39:45 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3fnqha4sgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 11:39:45 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23PBZqjj029159;
        Mon, 25 Apr 2022 11:39:43 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 3fm938swd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Apr 2022 11:39:43 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23PBdeSR58065224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Apr 2022 11:39:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F02F11C050;
        Mon, 25 Apr 2022 11:39:40 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 375E911C04C;
        Mon, 25 Apr 2022 11:39:40 +0000 (GMT)
Received: from osiris (unknown [9.145.60.82])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Apr 2022 11:39:40 +0000 (GMT)
Date:   Mon, 25 Apr 2022 13:39:38 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] s390/irq: utilize RCU instead of irq_lock_sparse() in
 show_msi_interrupt()
Message-ID: <YmaIeqtLzPegsgZP@osiris>
References: <20220420140521.45361-5-kernelfans@gmail.com>
 <20220422100212.22666-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422100212.22666-1-kernelfans@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qmAiJy-Ss_F-r1XjzhmlayPSYJVhQgvu
X-Proofpoint-GUID: RlXP01ILsTZ-IHF9oL2yZ50U3NAkJZPH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-25_06,2022-04-25_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0
 mlxlogscore=646 lowpriorityscore=0 phishscore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204250049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 06:02:12PM +0800, Pingfan Liu wrote:
> As demonstrated by commit 74bdf7815dfb ("genirq: Speedup show_interrupts()"),
> irq_desc can be accessed safely in RCU read section.
> 
> Hence here resorting to rcu read lock to get rid of irq_lock_sparse().
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> To: linux-s390@vger.kernel.org
> 
> ---
>  arch/s390/kernel/irq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks!
