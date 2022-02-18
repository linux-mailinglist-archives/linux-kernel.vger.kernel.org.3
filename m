Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672A84BC07D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 20:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbiBRTuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 14:50:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235164AbiBRTuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 14:50:10 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603C128F970;
        Fri, 18 Feb 2022 11:49:53 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IJbsEc019615;
        Fri, 18 Feb 2022 19:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=0bNWs3y7alJX9yOw12cdKbGps4DI3+y9jedSaQwlQ9g=;
 b=SdAjwMoUHkyBRUbK5faHeWPVQzH2eXy8xao1WvzppO3VyeN/Cb8nKGoKIKYh8RXEGSJP
 Ge2hywMtgWPo/biv/pVv3l2tMEC9Rd+vHsdNLGbHm/oVCpydJvJT1mLHr329/PQeh2ft
 7azGDHumghiA4AAuqtEySgPOD3RBEtl1gZrbezD+CYjHFcyMuUpccrKrYvDPlLGke8EN
 RRumqZonOb4GI30DDUQAxAlR11zmwkDMyKxKXqI2FL5/yC4SDBiqs378VoMd0YQiCKG9
 GP/IsLllqT0Fy6qalY6I1tykC0dWD3CL2kco1lT/D9fWBjE3tsnZR4+w5pROcFyHCOyo yA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eafqqke7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 19:49:32 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21IJf9jb032150;
        Fri, 18 Feb 2022 19:49:31 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3eafqqke7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 19:49:31 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21IJhxNA026396;
        Fri, 18 Feb 2022 19:49:29 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3e645km8gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Feb 2022 19:49:29 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21IJnPXg22610194
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 19:49:25 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECBAB4C04A;
        Fri, 18 Feb 2022 19:49:24 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E5AC4C058;
        Fri, 18 Feb 2022 19:49:22 +0000 (GMT)
Received: from sig-9-65-86-101.ibm.com (unknown [9.65.86.101])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Feb 2022 19:49:22 +0000 (GMT)
Message-ID: <5a71b96d0969cb7222d5b8637a19ed34cb08c72e.camel@linux.ibm.com>
Subject: Re: [PATCH v10 17/27] ima: Add functions for creating and freeing
 of an ima_namespace
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Christian Brauner <brauner@kernel.org>
Date:   Fri, 18 Feb 2022 14:49:21 -0500
In-Reply-To: <20220201203735.164593-18-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
         <20220201203735.164593-18-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AaC2QZgmvwzkGCqGsL3sAqsqFZpw7HLx
X-Proofpoint-ORIG-GUID: bzhxvu5uARNS9Bp7LEAChImnpE-VW5SN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-18_08,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202180119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote:
> Implement create_ima_ns() to create an empty ima_namespace. Defer its
> initialization to a later point outside this function. Implement
> free_ima_ns() to free it.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Christian Brauner <brauner@kernel.org>
> 
> ---
> v9:
>  - Set user_ns->ims_ns = NULL in free_ima_ns()
>  - Refactored create_ima_ns() to defer initialization
>  - Removed pr_debug functions
> ---
>  include/linux/ima.h                      | 13 ++++++
>  security/integrity/ima/Makefile          |  1 +
>  security/integrity/ima/ima.h             | 15 +++++++
>  security/integrity/ima/ima_init_ima_ns.c |  2 +-
>  security/integrity/ima/ima_ns.c          | 53 ++++++++++++++++++++++++
>  5 files changed, 83 insertions(+), 1 deletion(-)
>  create mode 100644 security/integrity/ima/ima_ns.c
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 0cf2a80c8b35..964a08702573 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -220,4 +220,17 @@ static inline bool ima_appraise_signature(enum kernel_read_file_id func)
>  	return false;
>  }
>  #endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
> +
> +#ifdef CONFIG_IMA_NS
> +
> +void free_ima_ns(struct user_namespace *ns);
> +
> +#else
> +
> +static inline void free_ima_ns(struct user_namespace *user_ns)
> +{
> +}
> +
> +#endif /* CONFIG_IMA_NS */
> +
>  #endif /* _LINUX_IMA_H */
> diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
> index f8a5e5f3975d..b86a35fbed60 100644
> --- a/security/integrity/ima/Makefile
> +++ b/security/integrity/ima/Makefile
> @@ -14,6 +14,7 @@ ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
>  ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
>  ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
>  ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
> +ima-$(CONFIG_IMA_NS) += ima_ns.o
>  
>  ifeq ($(CONFIG_EFI),y)
>  ima-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT) += ima_efi.o
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 8c757223d549..751e936a6311 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -167,6 +167,7 @@ extern bool ima_canonical_fmt;
>  int ima_init(void);
>  int ima_fs_init(void);
>  int ima_ns_init(void);
> +int ima_init_namespace(struct ima_namespace *ns);
>  int ima_add_template_entry(struct ima_namespace *ns,
>  			   struct ima_template_entry *entry, int violation,
>  			   const char *op, struct inode *inode,
> @@ -502,4 +503,18 @@ static inline struct ima_namespace
>  	return NULL;
>  }
>  
> +#ifdef CONFIG_IMA_NS
> +
> +struct ima_namespace *create_ima_ns(void);
> +
> +#else
> +
> +static inline struct ima_namespace *create_ima_ns(void)
> +{
> +	WARN(1, "Cannot create an IMA namespace\n");
> +	return ERR_PTR(-EFAULT);
> +}
> +
> +#endif /* CONFIG_IMA_NS */
> +
>  #endif /* __LINUX_IMA_H */
> diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
> index 1cba545ae477..166dab4a3126 100644
> --- a/security/integrity/ima/ima_init_ima_ns.c
> +++ b/security/integrity/ima/ima_init_ima_ns.c
> @@ -8,7 +8,7 @@
>  
>  #include "ima.h"
>  
> -static int ima_init_namespace(struct ima_namespace *ns)
> +int ima_init_namespace(struct ima_namespace *ns)
>  {
>  	int rc;
>  
> diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
> new file mode 100644
> index 000000000000..b3b81a1e313e
> --- /dev/null
> +++ b/security/integrity/ima/ima_ns.c
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2016-2021 IBM Corporation
> + * Author:
> + *  Yuqiong Sun <suny@us.ibm.com>
> + *  Stefan Berger <stefanb@linux.vnet.ibm.com>
> + */
> +
> +#include <linux/ima.h>
> +
> +#include "ima.h"
> +
> +static struct kmem_cache *imans_cachep;
> +
> +struct ima_namespace *create_ima_ns(void)
> +{
> +	struct ima_namespace *ns;
> +
> +	ns = kmem_cache_zalloc(imans_cachep, GFP_KERNEL);
> +	if (!ns)
> +		return ERR_PTR(-ENOMEM);
> +
> +	return ns;
> +}
> +
> +/* destroy_ima_ns() must only be called after ima_init_namespace() was called */
> +static void destroy_ima_ns(struct ima_namespace *ns)
> +{
> +	unregister_blocking_lsm_notifier(&ns->ima_lsm_policy_notifier);
> +	kfree(ns->arch_policy_entry);

Oh!  Here's the missing free of the architecture specific rules
(comment on 16/27).  Even if these rules have already been freed after
a custom policy is loaded, I guess it is safe to free them again.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> +	ima_free_policy_rules(ns);
> +}
> +
> +void free_ima_ns(struct user_namespace *user_ns)
> +{
> +	struct ima_namespace *ns = user_ns->ima_ns;
> +
> +	if (!ns || WARN_ON(ns == &init_ima_ns))
> +		return;
> +
> +	destroy_ima_ns(ns);
> +
> +	kmem_cache_free(imans_cachep, ns);
> +
> +	user_ns->ima_ns = NULL;
> +}
> +
> +static int __init imans_cache_init(void)
> +{
> +	imans_cachep = KMEM_CACHE(ima_namespace, SLAB_PANIC);
> +	return 0;
> +}
> +subsys_initcall(imans_cache_init)


