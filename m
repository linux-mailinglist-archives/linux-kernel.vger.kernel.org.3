Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D2354BEAE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 02:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237113AbiFOA3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 20:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiFOA3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 20:29:37 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B26530F5D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:29:36 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id u18so9087589plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 17:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dxhxrXlTOKyC77+K4zyxT72ODZS2TX2T4T14AmDweLc=;
        b=OJ3B/h8Mzq/D47niMnxNxGPAJVmSCVeMouYFywcmbeGR1llOr/t5UdSJVefQmxife1
         LtXKocaFTZQjVy3X1EFaA2DpgcbzJviGe+bnM/L0qfWXthDfTlngS/0BAbgs8O68NlXi
         GTdkt4zhqdHkI/ogwoNE/rvirRwd2cy6d9GbMYdidFAdZznMPh+g33SBQtBuSTNEvLiI
         f6Sp9KVxHvtRTP0xm1+3+eMIFtNTvKJ6Y5gaSucRs6mpPzKkpVHpx5LMa2nCdKPKUjSz
         cpZyD9ks2GF6alN2pEKbi6r9QKGq1GuaFqcWn+vXLFgBJ6y087SBoDhQN1BHodpwuuhf
         vovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dxhxrXlTOKyC77+K4zyxT72ODZS2TX2T4T14AmDweLc=;
        b=o72lXZRPlj1GvigztCD/wjLkcbicLnaQT2iLu2QnMq5kibgQ5b1cmIWfgJdFBVIdCV
         xAPrp7XX8roA3MqmY14JfbNepiATkkjSpFkNUcLdXtNY1sB+vS5TDvI+OX/sqqBP0GFj
         EuP7iC+IHjTq/lye8y0V7VQK4RsKYdrs/tibshsncMCbJ3z84GDnkIKSNdaHtHbGiEKH
         imuq6Ow2OtFTJOtVfF9PSRCAZPHPX3Q3w3Fw+JTvfhnexQPNenebHa+reJ4fatrSpCyR
         gn3Eej2qHPUVoPuR3yXgwyiw20ZLVhN+ZtDwhUprXrU+zQwdwVL1fIsfMI7bfqMWydp0
         uB/A==
X-Gm-Message-State: AJIora8rkZpW1kSRZgTyPYyrGQXTFm6ADNJ7IuERoezHgHxn4OJDpO4f
        iGVNGcA/Opwq/ahHVSdsBlaMeA==
X-Google-Smtp-Source: AGRyM1sMlGm77Mw3gkrg0EHNJVM7rmExx8ODE7hZi9Wqr0iy4jHhaEdSq8fk8shV/YfRljTe3fNIew==
X-Received: by 2002:a17:90a:740e:b0:1e2:a631:87e6 with SMTP id a14-20020a17090a740e00b001e2a63187e6mr7249027pjg.115.1655252975722;
        Tue, 14 Jun 2022 17:29:35 -0700 (PDT)
Received: from google.com (55.212.185.35.bc.googleusercontent.com. [35.185.212.55])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090a428700b001e2f383110bsm215946pjg.11.2022.06.14.17.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 17:29:34 -0700 (PDT)
Date:   Tue, 14 Jun 2022 17:29:31 -0700
From:   Zach O'Keefe <zokeefe@google.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, aarcange@redhat.com,
        willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, david@redhat.com,
        surenb@google.com, peterx@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] mm/khugepaged: use helper macro __ATTR_RW
Message-ID: <Yqkn65gGKfQE1Lg1@google.com>
References: <20220611084731.55155-1-linmiaohe@huawei.com>
 <20220611084731.55155-6-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220611084731.55155-6-linmiaohe@huawei.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Jun 16:47, Miaohe Lin wrote:
> Use helper macro __ATTR_RW to define the khugepaged attributes. Minor
> readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/khugepaged.c | 37 +++++++++++++++----------------------
>  1 file changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 8e6fad7c7bd9..142e26e4bdbf 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -147,8 +147,7 @@ static ssize_t scan_sleep_millisecs_store(struct kobject *kobj,
>  	return count;
>  }
>  static struct kobj_attribute scan_sleep_millisecs_attr =
> -	__ATTR(scan_sleep_millisecs, 0644, scan_sleep_millisecs_show,
> -	       scan_sleep_millisecs_store);
> +	__ATTR_RW(scan_sleep_millisecs);
>  
>  static ssize_t alloc_sleep_millisecs_show(struct kobject *kobj,
>  					  struct kobj_attribute *attr,
> @@ -175,8 +174,7 @@ static ssize_t alloc_sleep_millisecs_store(struct kobject *kobj,
>  	return count;
>  }
>  static struct kobj_attribute alloc_sleep_millisecs_attr =
> -	__ATTR(alloc_sleep_millisecs, 0644, alloc_sleep_millisecs_show,
> -	       alloc_sleep_millisecs_store);
> +	__ATTR_RW(alloc_sleep_millisecs);
>  
>  static ssize_t pages_to_scan_show(struct kobject *kobj,
>  				  struct kobj_attribute *attr,
> @@ -200,8 +198,7 @@ static ssize_t pages_to_scan_store(struct kobject *kobj,
>  	return count;
>  }
>  static struct kobj_attribute pages_to_scan_attr =
> -	__ATTR(pages_to_scan, 0644, pages_to_scan_show,
> -	       pages_to_scan_store);
> +	__ATTR_RW(pages_to_scan);
>  
>  static ssize_t pages_collapsed_show(struct kobject *kobj,
>  				    struct kobj_attribute *attr,
> @@ -221,13 +218,13 @@ static ssize_t full_scans_show(struct kobject *kobj,
>  static struct kobj_attribute full_scans_attr =
>  	__ATTR_RO(full_scans);
>  
> -static ssize_t khugepaged_defrag_show(struct kobject *kobj,
> +static ssize_t defrag_show(struct kobject *kobj,
>  				      struct kobj_attribute *attr, char *buf)
>  {
>  	return single_hugepage_flag_show(kobj, attr, buf,
>  					 TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG);
>  }
> -static ssize_t khugepaged_defrag_store(struct kobject *kobj,
> +static ssize_t defrag_store(struct kobject *kobj,
>  				       struct kobj_attribute *attr,
>  				       const char *buf, size_t count)
>  {
> @@ -235,8 +232,7 @@ static ssize_t khugepaged_defrag_store(struct kobject *kobj,
>  				 TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG);
>  }
>  static struct kobj_attribute khugepaged_defrag_attr =
> -	__ATTR(defrag, 0644, khugepaged_defrag_show,
> -	       khugepaged_defrag_store);
> +	__ATTR_RW(defrag);
>  
>  /*
>   * max_ptes_none controls if khugepaged should collapse hugepages over
> @@ -246,13 +242,13 @@ static struct kobj_attribute khugepaged_defrag_attr =
>   * runs. Increasing max_ptes_none will instead potentially reduce the
>   * free memory in the system during the khugepaged scan.
>   */
> -static ssize_t khugepaged_max_ptes_none_show(struct kobject *kobj,
> +static ssize_t max_ptes_none_show(struct kobject *kobj,
>  					     struct kobj_attribute *attr,
>  					     char *buf)
>  {
>  	return sysfs_emit(buf, "%u\n", khugepaged_max_ptes_none);
>  }
> -static ssize_t khugepaged_max_ptes_none_store(struct kobject *kobj,
> +static ssize_t max_ptes_none_store(struct kobject *kobj,
>  					      struct kobj_attribute *attr,
>  					      const char *buf, size_t count)
>  {
> @@ -268,17 +264,16 @@ static ssize_t khugepaged_max_ptes_none_store(struct kobject *kobj,
>  	return count;
>  }
>  static struct kobj_attribute khugepaged_max_ptes_none_attr =
> -	__ATTR(max_ptes_none, 0644, khugepaged_max_ptes_none_show,
> -	       khugepaged_max_ptes_none_store);
> +	__ATTR_RW(max_ptes_none);
>  
> -static ssize_t khugepaged_max_ptes_swap_show(struct kobject *kobj,
> +static ssize_t max_ptes_swap_show(struct kobject *kobj,
>  					     struct kobj_attribute *attr,
>  					     char *buf)
>  {
>  	return sysfs_emit(buf, "%u\n", khugepaged_max_ptes_swap);
>  }
>  
> -static ssize_t khugepaged_max_ptes_swap_store(struct kobject *kobj,
> +static ssize_t max_ptes_swap_store(struct kobject *kobj,
>  					      struct kobj_attribute *attr,
>  					      const char *buf, size_t count)
>  {
> @@ -295,17 +290,16 @@ static ssize_t khugepaged_max_ptes_swap_store(struct kobject *kobj,
>  }
>  
>  static struct kobj_attribute khugepaged_max_ptes_swap_attr =
> -	__ATTR(max_ptes_swap, 0644, khugepaged_max_ptes_swap_show,
> -	       khugepaged_max_ptes_swap_store);
> +	__ATTR_RW(max_ptes_swap);
>  
> -static ssize_t khugepaged_max_ptes_shared_show(struct kobject *kobj,
> +static ssize_t max_ptes_shared_show(struct kobject *kobj,
>  					       struct kobj_attribute *attr,
>  					       char *buf)
>  {
>  	return sysfs_emit(buf, "%u\n", khugepaged_max_ptes_shared);
>  }
>  
> -static ssize_t khugepaged_max_ptes_shared_store(struct kobject *kobj,
> +static ssize_t max_ptes_shared_store(struct kobject *kobj,
>  					      struct kobj_attribute *attr,
>  					      const char *buf, size_t count)
>  {
> @@ -322,8 +316,7 @@ static ssize_t khugepaged_max_ptes_shared_store(struct kobject *kobj,
>  }
>  
>  static struct kobj_attribute khugepaged_max_ptes_shared_attr =
> -	__ATTR(max_ptes_shared, 0644, khugepaged_max_ptes_shared_show,
> -	       khugepaged_max_ptes_shared_store);
> +	__ATTR_RW(max_ptes_shared);
>  
>  static struct attribute *khugepaged_attr[] = {
>  	&khugepaged_defrag_attr.attr,
> -- 
> 2.23.0
> 
> 

For function names that changed, can we align args that don't fit on opening
line with the opening brace?

Thanks,
Zach
