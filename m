Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DDF509ED9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388912AbiDULqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbiDULqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:46:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073E124970;
        Thu, 21 Apr 2022 04:43:11 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23LApW8b015963;
        Thu, 21 Apr 2022 11:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=TzGKmzTfoWC4Y0zsxNAxppY+uyfM7GYUC04vAB1rd30=;
 b=cE9hS4wMOxRbC2rkgBNrghCrP6JTr+0QCWugGBQ3P8Ri1UHZ50mtdWL7moM3xOH9TXAi
 bsJMV5BoFUjPjCKb3lASWgN8QzTU+icrxwugEPdpAadxV+PfRVIJPRKoSUFFx6o7SOCw
 7MNZEP6ox44b6xHhkLh2t8uQWTmHgvErlLbRnkSIruF90RCp8ymd26EraCJOa+eZgc4O
 ktZ8FVFe/bKgaEkMheIQIs6OePNa0u13CqR2R3vpeVvoXP4JztAxhp17JXJJtYdWCPU7
 lxsCUm0twu6T9r9/HxL4Pk8unu8EnGdyZUdXmT/7Sc6bQ4jANqfDsHNnWCaqy1+qVRq1 UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjm2hwra9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 11:43:07 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23LBfaa8019440;
        Thu, 21 Apr 2022 11:43:07 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fjm2hwr9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 11:43:07 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23LBdM2J010792;
        Thu, 21 Apr 2022 11:43:04 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3ffne9661e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Apr 2022 11:43:04 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23LBhCGh36176138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Apr 2022 11:43:12 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2215A405B;
        Thu, 21 Apr 2022 11:43:00 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 769F9A4054;
        Thu, 21 Apr 2022 11:43:00 +0000 (GMT)
Received: from osiris (unknown [9.145.171.214])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 21 Apr 2022 11:43:00 +0000 (GMT)
Date:   Thu, 21 Apr 2022 13:42:59 +0200
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
Message-ID: <YmFDQ0wH+Y15bKX0@osiris>
References: <20220420140521.45361-1-kernelfans@gmail.com>
 <20220420140521.45361-5-kernelfans@gmail.com>
 <YmBOBRMWlk4H11sc@osiris>
 <YmDRMUUzBq6uyIzj@piliu.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmDRMUUzBq6uyIzj@piliu.users.ipa.redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3F7MHwimN9XDr0Fjcvlxl_oqztMIHWGt
X-Proofpoint-ORIG-GUID: 56pkuxdQk7Sa1pIH7iXTODD4VGEdVR9Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_06,2022-04-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 suspectscore=0 mlxlogscore=598 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204210064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 11:36:17AM +0800, Pingfan Liu wrote:
> Oops. You are right. What about using rcu_read_lock() directly?
> 
> 
> diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
> index 3033f616e256..45393919fe61 100644
> --- a/arch/s390/kernel/irq.c
> +++ b/arch/s390/kernel/irq.c
> @@ -205,7 +205,7 @@ static void show_msi_interrupt(struct seq_file *p, int irq)
>  	unsigned long flags;
>  	int cpu;
>  
> -	irq_lock_sparse();
> +	rcu_read_lock();
>  	desc = irq_to_desc(irq);
>  	if (!desc)
>  		goto out;
> @@ -224,7 +224,7 @@ static void show_msi_interrupt(struct seq_file *p, int irq)
>  	seq_putc(p, '\n');
>  	raw_spin_unlock_irqrestore(&desc->lock, flags);
>  out:
> -	irq_unlock_sparse();
> +	rcu_read_unlock();

That looks like it should work. Please resend and also add a reference
to commit 74bdf7815dfb ("genirq: Speedup show_interrupts()") which
explains why this works.
