Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B073C572161
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbiGLQuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbiGLQuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:50:35 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132BEC5489;
        Tue, 12 Jul 2022 09:50:34 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CEnZJp019476;
        Tue, 12 Jul 2022 16:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=aMM0mCDz6Ex5LuP04YAGXssTInY/FxG3OqUy4auQHh4=;
 b=G7PfpM0Mg6wmtKWwK945YhQPpVoYepPrPhcQ6z5v1v2jc4JIUYvgOFl8U5F2oVnuc80E
 SLEZoV2AoQ0MsGSuvZ3tsZhsUXSQhOJRsm9q5g2/o2ojhUbD4jX4qJUG7lG42f5hv4sX
 i/0WHu1oECdzYm8FlGTuGTL1c4VwY0eHSfuPQ46+kEIc/MJgffSZFn5AAXfDqfe6+4qj
 gtxezbQCaUuyKE4qEtXE+dTaGl/itGW5Cen1qcxdy/vF25RMzHk/6A+6AieFZFGTYwaJ
 p5YqntfMPQ1+Fn51GGw6D8WTsmtxgMRjC3H0xfnaiAu+bdmBuJa3Q31MEdQqCGtrE2Dr IQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9b2fk7sw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 16:50:31 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26CGLhNv026537;
        Tue, 12 Jul 2022 16:50:29 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3h8rrn1cjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 16:50:29 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26CGoQIC21954992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 16:50:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4057842042;
        Tue, 12 Jul 2022 16:50:26 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5BA94203F;
        Tue, 12 Jul 2022 16:50:25 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.1.61])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jul 2022 16:50:25 +0000 (GMT)
Date:   Tue, 12 Jul 2022 18:49:24 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Steffen Eiden <seiden@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, nrb@linux.ibm.com
Subject: Re: [PATCH 3/3] s390/uvdevice: autoload module based on CPU
 facility
Message-ID: <20220712184924.0d80c474@p-imbrenda>
In-Reply-To: <20220712105220.325010-4-seiden@linux.ibm.com>
References: <20220712105220.325010-1-seiden@linux.ibm.com>
        <20220712105220.325010-4-seiden@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: c-2OtE8ICOGKMmKQh0HfTKWmO0mc4zp3
X-Proofpoint-GUID: c-2OtE8ICOGKMmKQh0HfTKWmO0mc4zp3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_10,2022-07-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207120065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 12:52:20 +0200
Steffen Eiden <seiden@linux.ibm.com> wrote:

> Make sure the uvdevice driver will be automatically loaded when
> facility 158 is available.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>  arch/s390/include/asm/cpufeature.h | 1 +
>  arch/s390/kernel/cpufeature.c      | 1 +
>  drivers/s390/char/uvdevice.c       | 5 ++---
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/include/asm/cpufeature.h b/arch/s390/include/asm/cpufeature.h
> index aa8081dad411..4b17f876ab54 100644
> --- a/arch/s390/include/asm/cpufeature.h
> +++ b/arch/s390/include/asm/cpufeature.h
> @@ -33,6 +33,7 @@ enum {
>  	S390_CPU_FEATURE_NNPA,
>  	S390_CPU_FEATURE_PCI_MIO,
>  	S390_CPU_FEATURE_SIE,
> +	S390_CPU_FEATURE_UV,
>  	MAX_CPU_FEATURES
>  };
>  
> diff --git a/arch/s390/kernel/cpufeature.c b/arch/s390/kernel/cpufeature.c
> index e70b29804db4..0b854d37edcb 100644
> --- a/arch/s390/kernel/cpufeature.c
> +++ b/arch/s390/kernel/cpufeature.c
> @@ -42,6 +42,7 @@ static struct s390_cpu_feature s390_cpu_features[MAX_CPU_FEATURES] = {
>  	[S390_CPU_FEATURE_NNPA]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_NNPA},
>  	[S390_CPU_FEATURE_PCI_MIO]	= {.type = TYPE_HWCAP, .num = HWCAP_NR_PCI_MIO},
>  	[S390_CPU_FEATURE_SIE]		= {.type = TYPE_HWCAP, .num = HWCAP_NR_SIE},
> +	[S390_CPU_FEATURE_UV]		= {.type = TYPE_FACILITY, .num = 158},
>  };
>  
>  /*
> diff --git a/drivers/s390/char/uvdevice.c b/drivers/s390/char/uvdevice.c
> index 66505d7166a6..1d40457c7b10 100644
> --- a/drivers/s390/char/uvdevice.c
> +++ b/drivers/s390/char/uvdevice.c
> @@ -27,6 +27,7 @@
>  #include <linux/stddef.h>
>  #include <linux/vmalloc.h>
>  #include <linux/slab.h>
> +#include <linux/cpufeature.h>
>  
>  #include <asm/uvdevice.h>
>  #include <asm/uv.h>
> @@ -244,12 +245,10 @@ static void __exit uvio_dev_exit(void)
>  
>  static int __init uvio_dev_init(void)
>  {
> -	if (!test_facility(158))
> -		return -ENXIO;
>  	return misc_register(&uvio_dev_miscdev);
>  }
>  
> -module_init(uvio_dev_init);
> +module_cpu_feature_match(S390_CPU_FEATURE_UV, uvio_dev_init);

does this still prevent manual loading when the feature is not present?

>  module_exit(uvio_dev_exit);
>  
>  MODULE_AUTHOR("IBM Corporation");

