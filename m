Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F7E524727
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351087AbiELHle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbiELHla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:41:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13C8116A5C7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652341287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UB9mU9YOUuvmjC8HW/bQVlMThaY/Mp776ejEpkktyQo=;
        b=eHaw1Sk6PnqDxj8lxBsRMkosXrdA7ikqSvBzmH6O4PN60xoqy+Upf8s3szCp8tRn4KDR6c
        jHWTW7+M0sPCBbPq72ASbASV6v1B7NfPT+iqAln4EcObBH2+/3SlrHl1LyaSB+pzWBc7df
        Duu99xeJTRv3Qab3lXu7Twb2zqA9t2c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-dVbtp8ZcNGm0YP64gzHWeA-1; Thu, 12 May 2022 03:41:25 -0400
X-MC-Unique: dVbtp8ZcNGm0YP64gzHWeA-1
Received: by mail-wm1-f71.google.com with SMTP id k5-20020a05600c0b4500b003941ca130f9so1311363wmr.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 00:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=UB9mU9YOUuvmjC8HW/bQVlMThaY/Mp776ejEpkktyQo=;
        b=HetEigtHEfgKBGZltwcbYPMJtLYnHBNvS+ThpHGbQjQJQJRTe+BIoED95lb14DLIGe
         feqxWZJGEKyTl7lA2bSWiTIu0Wxy1V+Ki3I3P5dmblTwopU8pcE0O7au3aU9lgx4hQIc
         TG5DG6RTLehTWo3BkAA9vBL68p+5QT2oI+EfQ9c+UXvrwnrGbEQHC4XKjBlU/mbMS7r8
         37ePZ8XjcmRjD3L9sUb6B2tX+MMNCRXrhII4qxKckz84ak7gvu0TlpBGaqIo7rcpbXyF
         kh+IZwc3Su6jVrTgys8aVymJT9u/kOqbkgxGJyPtHmFibKO8myNUNNBSFfYYxV6ciQiO
         W3uw==
X-Gm-Message-State: AOAM532wdXqrW9XgCsj6CdZa80sCd5GD+fRkyRi3qQ2vWxeIHRpGuxLX
        7WdDwR2BZNTr6r/cSrcVobf1+lLjreMMC8aaaaI96WCXl164DLxZrAHjwfLAclU4dX3gjF1gCpC
        /CJ546M+jxVADftHlElnpaQxV
X-Received: by 2002:adf:cc82:0:b0:20a:cf3b:4624 with SMTP id p2-20020adfcc82000000b0020acf3b4624mr25667672wrj.573.1652341284518;
        Thu, 12 May 2022 00:41:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBjlod8MeuObO/DAktAps0EDmVeiibZR+PFFNEWdAxgv5/5LuDiW4y70u4NNJMfK7KQAGFgA==
X-Received: by 2002:adf:cc82:0:b0:20a:cf3b:4624 with SMTP id p2-20020adfcc82000000b0020acf3b4624mr25667655wrj.573.1652341284263;
        Thu, 12 May 2022 00:41:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c701:d200:ee5d:1275:f171:136d? (p200300cbc701d200ee5d1275f171136d.dip0.t-ipconnect.de. [2003:cb:c701:d200:ee5d:1275:f171:136d])
        by smtp.gmail.com with ESMTPSA id y12-20020adff6cc000000b0020c5253d920sm3989255wrp.108.2022.05.12.00.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 00:41:23 -0700 (PDT)
Message-ID: <21aae898-d54d-cc4b-a11f-1bb7fddcfffa@redhat.com>
Date:   Thu, 12 May 2022 09:41:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v10 3/4] mm: hugetlb_vmemmap: use kstrtobool for
 hugetlb_vmemmap param parsing
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, masahiroy@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com
References: <20220509062703.64249-1-songmuchun@bytedance.com>
 <20220509062703.64249-4-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220509062703.64249-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.22 08:27, Muchun Song wrote:
> Use kstrtobool rather than open coding "on" and "off" parsing in
> mm/hugetlb_vmemmap.c,  which is more powerful to handle all kinds
> of parameters like 'Yy1Nn0' or [oO][NnFf] for "on" and "off".
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  6 +++---
>  mm/hugetlb_vmemmap.c                            | 10 +++++-----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 308da668bbb1..43b8385073ad 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1703,10 +1703,10 @@
>  			enabled.
>  			Allows heavy hugetlb users to free up some more
>  			memory (7 * PAGE_SIZE for each 2MB hugetlb page).
> -			Format: { on | off (default) }
> +			Format: { [oO][Nn]/Y/y/1 | [oO][Ff]/N/n/0 (default) }

Really? Can we make the syntax even harder to parse for human beings?! :)

Not to mention that it's partially wrong? What about "oFf" ? That would
have to be [oO][Ff][Ff]

Honestly, "on | off" is good enough. That "oN" and friends work is just
a "nice to have" IMHO. No need to over-complicate this description.
>  
> -			on:  enable the feature
> -			off: disable the feature
> +			[oO][Nn]/Y/y/1: enable the feature
> +			[oO][Ff]/N/n/0: disable the feature
>  
>  			Built with CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON=y,
>  			the default is on.
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 6254bb2d4ae5..cc4ec752ec16 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -28,15 +28,15 @@ EXPORT_SYMBOL(hugetlb_optimize_vmemmap_key);
>  
>  static int __init hugetlb_vmemmap_early_param(char *buf)
>  {
> -	if (!buf)
> +	bool enable;
> +
> +	if (kstrtobool(buf, &enable))
>  		return -EINVAL;
>  
> -	if (!strcmp(buf, "on"))
> +	if (enable)
>  		static_branch_enable(&hugetlb_optimize_vmemmap_key);
> -	else if (!strcmp(buf, "off"))
> -		static_branch_disable(&hugetlb_optimize_vmemmap_key);
>  	else
> -		return -EINVAL;
> +		static_branch_disable(&hugetlb_optimize_vmemmap_key);
>  
>  	return 0;
>  }


Apart from that

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

