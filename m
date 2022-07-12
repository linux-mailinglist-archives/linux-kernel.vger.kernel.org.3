Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0690157215E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbiGLQub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiGLQu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:50:28 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5E6BF552;
        Tue, 12 Jul 2022 09:50:28 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26CGBVaI022563;
        Tue, 12 Jul 2022 16:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=RYwp+YtDSCff/wQqHeUwTyAjBYTByIi6+8XH5HemPZs=;
 b=np8uv2v+WOYHhtzbM7QLtKkDFbk5ikKSB1lckySlU5dBmfCBLKFrSJZM6uUv4SPp8hlv
 1ePa5kkBdL2Iv5hcUYJMzYuGeS8OsiHnuci1UtL5aWH7H+/fx8lctHY8QQHP4o5YRkAD
 PL6/i+xksY2WNIX9H4nhtSRYmKD6CpDqlo4KaAfvkaTLGw1Ja9k07G8/PnpW4nmqp2DE
 1zKkz71XO3t/RXe0+7MwYwYcrzkJEgJpFunhuM+8RIsNXRceWDZMnCrUPm1CTgi/GMjA
 yLKPG2y9NIG5SsQ6XwitT+7NiS+vpULsnJsch12WhR5y5O06K72zbO38sVUIYV/p6XjK Ag== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h9974xtbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 16:50:24 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26CGLFOD007719;
        Tue, 12 Jul 2022 16:50:23 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3h71a8kr96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jul 2022 16:50:23 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26CGoK2c20906332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jul 2022 16:50:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE66142042;
        Tue, 12 Jul 2022 16:50:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7021242045;
        Tue, 12 Jul 2022 16:50:19 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.1.61])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jul 2022 16:50:19 +0000 (GMT)
Date:   Tue, 12 Jul 2022 18:46:19 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Steffen Eiden <seiden@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, nrb@linux.ibm.com
Subject: Re: [PATCH 1/3] s390/cpufeature: rework to allow more than only
 hwcap bits
Message-ID: <20220712184619.45edd420@p-imbrenda>
In-Reply-To: <20220712105220.325010-2-seiden@linux.ibm.com>
References: <20220712105220.325010-1-seiden@linux.ibm.com>
        <20220712105220.325010-2-seiden@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -Uzcnb3egHVSEuImscYwNKO8H59-pgrt
X-Proofpoint-ORIG-GUID: -Uzcnb3egHVSEuImscYwNKO8H59-pgrt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_10,2022-07-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxscore=0
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

On Tue, 12 Jul 2022 12:52:18 +0200
Steffen Eiden <seiden@linux.ibm.com> wrote:

> Rework cpufeature implementation to allow for various cpu feature
> indications, which is not only limited to hwcap bits. This is achieved
> by adding a sequential list of cpu feature numbers, where each of them
> is mapped to an entry which indicates what this number is about.
> 
> Each entry contains a type member, which indicates what feature
> name space to look into (e.g. hwcap, or cpu facility). If wanted this
> allows also to automatically load modules only in e.g. z/VM
> configurations.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

[...]

> +
> +/*
> + * cpu_have_feature - Test CPU features on module initialization
> + */
> +int cpu_have_feature(unsigned int num)
> +{
> +	struct s390_cpu_feature *feature;
> +
> +	feature = &s390_cpu_features[num];

I would put some check to make sure you are going past the end of the
array. 

Maybe something like

if (num >= MAX_CPU_FEATURES) {
	WARN(1, "Invalid feature %d", num);
	return 0;
}

> +	switch (feature->type) {
> +	case TYPE_HWCAP:
> +		return !!(elf_hwcap & (1UL << feature->num));
> +	default:
> +		WARN_ON_ONCE(1);
> +		return 0;
> +	}
> +}
> +EXPORT_SYMBOL(cpu_have_feature);
> diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
> index aa0e0e7fc773..a194611ba88c 100644
> --- a/arch/s390/kernel/processor.c
> +++ b/arch/s390/kernel/processor.c
> @@ -8,7 +8,6 @@
>  #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
>  
>  #include <linux/stop_machine.h>
> -#include <linux/cpufeature.h>
>  #include <linux/bitops.h>
>  #include <linux/kernel.h>
>  #include <linux/random.h>
> @@ -96,15 +95,6 @@ void cpu_init(void)
>  	enter_lazy_tlb(&init_mm, current);
>  }
>  
> -/*
> - * cpu_have_feature - Test CPU features on module initialization
> - */
> -int cpu_have_feature(unsigned int num)
> -{
> -	return elf_hwcap & (1UL << num);
> -}
> -EXPORT_SYMBOL(cpu_have_feature);
> -
>  static void show_facilities(struct seq_file *m)
>  {
>  	unsigned int bit;
> diff --git a/drivers/char/hw_random/s390-trng.c b/drivers/char/hw_random/s390-trng.c
> index 2beaa35c0d74..12fbac0ed8ca 100644
> --- a/drivers/char/hw_random/s390-trng.c
> +++ b/drivers/char/hw_random/s390-trng.c
> @@ -261,5 +261,5 @@ static void __exit trng_exit(void)
>  	trng_debug_exit();
>  }
>  
> -module_cpu_feature_match(MSA, trng_init);
> +module_cpu_feature_match(S390_CPU_FEATURE_MSA, trng_init);
>  module_exit(trng_exit);
> diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
> index 7329caa7d467..5a05d1cdfec2 100644
> --- a/drivers/s390/crypto/pkey_api.c
> +++ b/drivers/s390/crypto/pkey_api.c
> @@ -2115,5 +2115,5 @@ static void __exit pkey_exit(void)
>  	pkey_debug_exit();
>  }
>  
> -module_cpu_feature_match(MSA, pkey_init);
> +module_cpu_feature_match(S390_CPU_FEATURE_MSA, pkey_init);
>  module_exit(pkey_exit);

