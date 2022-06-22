Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AC7554BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 15:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357210AbiFVNsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 09:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357605AbiFVNs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 09:48:26 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2885F6345;
        Wed, 22 Jun 2022 06:48:22 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25MCq2ub022393;
        Wed, 22 Jun 2022 13:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=JNsEAZjYGCRfduROd0FU3UywMgvbOkJkcHWpbho9RzU=;
 b=aXmeCAfuUSEJl315nPS+4sarsF/8zUWWaatZCNS3+DbpHCVD/fP0MI0GSU1prnjuE+qC
 t41bprfMQn+zV7sOO2/D2Xg6sQQYC4hhRiSzZPyGg0yTVHHO5SQmIdXhDVw13Lw9kLUY
 MEDrOyHBxLo7e/dOIT3PjuU+eM53FOsAkxVJXxNi5BEgWPdVRMCovJAiJPRGeRmYJPfy
 f8aGvl2WeWVr5+2PHCkbX5lRw4v+nObwsyxATApsXkhozT1rFDHk7pefqkk99TmQ4NgK
 POHhqIzOlJZV082GZJJWslHsMWfKxnX4rzrM1MhAarvPof2GarLWb+gwWjmlQxtEFyZh mg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gv3fb9pqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 13:48:19 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25MDabe1023826;
        Wed, 22 Jun 2022 13:48:17 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3gs6b8vgyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 13:48:17 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25MDmER221627374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 13:48:14 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D099A405F;
        Wed, 22 Jun 2022 13:48:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEEA5A405C;
        Wed, 22 Jun 2022 13:48:13 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.145.144.178])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 22 Jun 2022 13:48:13 +0000 (GMT)
Date:   Wed, 22 Jun 2022 15:48:12 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] s390/purgatory: hard-code obj-y in Makefile
Message-ID: <YrMdnEB686tSGARZ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20220613170902.1775211-1-masahiroy@kernel.org>
 <20220613170902.1775211-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613170902.1775211-2-masahiroy@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PLL7oUnDriV4RzueXKpMtszAMwKjC0KJ
X-Proofpoint-GUID: PLL7oUnDriV4RzueXKpMtszAMwKjC0KJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-22_04,2022-06-22_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=910 mlxscore=0
 spamscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 02:09:01AM +0900, Masahiro Yamada wrote:
> The purgatory/ directory is entirely guarded in arch/s390/Kbuild.
> CONFIG_ARCH_HAS_KEXEC_PURGATORY is bool type.
> 
> $(CONFIG_ARCH_HAS_KEXEC_PURGATORY) is always 'y' when Kbuild visits
> this Makefile for building.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/s390/purgatory/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
> index 360ada80d20c..3e2c17ba04de 100644
> --- a/arch/s390/purgatory/Makefile
> +++ b/arch/s390/purgatory/Makefile
> @@ -51,4 +51,4 @@ $(obj)/purgatory.ro: $(obj)/purgatory $(obj)/purgatory.chk FORCE
>  $(obj)/kexec-purgatory.o: $(obj)/kexec-purgatory.S $(obj)/purgatory.ro FORCE
>  	$(call if_changed_rule,as_o_S)
>  
> -obj-$(CONFIG_ARCH_HAS_KEXEC_PURGATORY) += kexec-purgatory.o
> +obj-y += kexec-purgatory.o

Applied, thanks!

BTW, it looks like x86 and riscv also need similar change.

In addition, x86 use of CONFIG_ARCH_HAS_KEXEC_PURGATORY vs CONFIG_KEXEC_FILE
is not consistent with other architectures (may be even incorrect?).

> -- 
> 2.32.0
> 
