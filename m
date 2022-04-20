Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621BD508F44
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381459AbiDTSTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiDTSTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:19:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE519FD3;
        Wed, 20 Apr 2022 11:16:57 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KI0shV020011;
        Wed, 20 Apr 2022 18:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=8uhPUsPO5Owws7Bjf6Vxskq3KKfsHHNUxbKMMmLdx1w=;
 b=dD9snOoj4/Mxwdxj8LyF7NCKVbgAb4Ho82D65ezMhtMUp/YkYJGJVKxaFVA5b8BAm2g5
 dy4AJKj4EfrqSHyHflSBFgSSYvGut5wU+c53f9GapKA6Wt9aJlO/Ss7pTn4gbZzxHrVY
 eZaKu0yT3wZUWyX0+/duP7RBufYMFpybihsxnHpbr4pz+me/ChUO7DEKLjWrg+sU05IX
 1ax6c2mcrF1zPqmGCsrDIyvR+BPEHDXsGe0gzTMsTO3OlvfzlA+0dCOJRzj/je5RNUTk
 rmMWh8Wy57gS1FYmxv3etJaX4LUvXZt/kCdJeIYq+7jLR2tRh24sFGvHzpHojrkwtUnM FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjm2hd514-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 18:16:45 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23KIGjQq020248;
        Wed, 20 Apr 2022 18:16:45 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjm2hd50g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 18:16:45 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23KIEACN029771;
        Wed, 20 Apr 2022 18:16:43 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3ffn2hxqh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 18:16:42 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23KIGdr551118570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 18:16:39 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACA84A405F;
        Wed, 20 Apr 2022 18:16:39 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54986A405C;
        Wed, 20 Apr 2022 18:16:39 +0000 (GMT)
Received: from osiris (unknown [9.145.42.46])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 20 Apr 2022 18:16:39 +0000 (GMT)
Date:   Wed, 20 Apr 2022 20:16:37 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/9] s390/irq: utilize RCU instead of irq_lock_sparse()
 in show_msi_interrupt()
Message-ID: <YmBOBRMWlk4H11sc@osiris>
References: <20220420140521.45361-1-kernelfans@gmail.com>
 <20220420140521.45361-5-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420140521.45361-5-kernelfans@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Tmdi8VJ_xmfYAKJR6QOD66jCxD7Tamwm
X-Proofpoint-ORIG-GUID: 5YrumQ7X8EDTWkf9JoF7AxUiYVLL9Ho-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_05,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 suspectscore=0 mlxlogscore=658 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 10:05:16PM +0800, Pingfan Liu wrote:
> irq_desc can be accessed safely in RCU read section as demonstrated by
> kstat_irqs_usr(). And raw_spin_lock_irqsave() context can provide a rcu
> read section, which can be utilized to get rid of irq_lock_sparse().
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
> ---
>  arch/s390/kernel/irq.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
> index 3033f616e256..6302dc7874cf 100644
> --- a/arch/s390/kernel/irq.c
> +++ b/arch/s390/kernel/irq.c
> @@ -205,12 +205,13 @@ static void show_msi_interrupt(struct seq_file *p, int irq)
>  	unsigned long flags;
>  	int cpu;
>  
> -	irq_lock_sparse();
> +	raw_spin_lock_irqsave(&desc->lock, flags);
>  	desc = irq_to_desc(irq);

How is this supposed to work? desc get's initialized after its random
stack value has been used as a pointer to lock something...
