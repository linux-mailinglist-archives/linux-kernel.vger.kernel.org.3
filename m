Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B8E53A076
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351101AbiFAJcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351057AbiFAJcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:32:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 75E0AC29
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 02:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654075961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BmPZwKNl0qsdfgB3OGMArzoWUPSA+8ZPWezDO9FEGpk=;
        b=Uc/uZFOSW8nznhPpb+bR9MB16VbWNs1YANz8+aBp9j2WOqMt3lHdeB/5dVPzvdBOafzrXk
        rIrsAAlvJ7yR3O9vANjA9pU9pLWnTlGHTmmwosoMxlWnM02hfMqPJJ7rREgi0xH6e2CC9D
        93mct8BnczYCFQ/iL8fMO3LRDbyVibE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-r2lXi3C2MOaUac7Rkio6tg-1; Wed, 01 Jun 2022 05:32:40 -0400
X-MC-Unique: r2lXi3C2MOaUac7Rkio6tg-1
Received: by mail-wm1-f70.google.com with SMTP id o3-20020a05600c4fc300b003946a9764baso3071833wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 02:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=BmPZwKNl0qsdfgB3OGMArzoWUPSA+8ZPWezDO9FEGpk=;
        b=QbOHittmBivgwpO/CqW+EqepaYfiG9Hc3aPhzI3wRsd/7v/mAZjZcoBiZXU/+iR5PJ
         c+AAFNmrQT4xmXWPcMPu24VbALRaanYUr9GxjzSZZF/YT5uDE4VlC8PcmrkNOJ4ouSif
         5jcbI4GQTunQpegnad/5g5mirtAHJZg1VLR4pe7rZMp6oiPaNvhqw563JYWH7+MUUbV5
         RcgM8YngQLBru2A++WakYTqjV2DnebfQMkJYyR+IwRBRmldGmIdp7Vu7ku9ELLmIQ88O
         Jq8pGV+n+btgXhya988Ag9F1v3Apt5dFGpkHLI6nOcWeZoAwpPF/2duizf88uUIfQjVm
         vPGQ==
X-Gm-Message-State: AOAM531D9C4RuHw5HDR6+rx7Kqm/bYYs97fVk+XJ3BlhHkRy6qvm+R29
        OX01Ohh8SA1HpzkWLkUuD92YRW3sLhh8vIcItu17Gc9R/TX/izfIzIKgGXbavZg1CA2SrVyNrWG
        0+IhczW4xMLBYe1hQtMoNOWx7
X-Received: by 2002:a5d:6d48:0:b0:20e:5f80:bd29 with SMTP id k8-20020a5d6d48000000b0020e5f80bd29mr53450099wri.428.1654075959291;
        Wed, 01 Jun 2022 02:32:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFtaO8hX+03ZBiEC4YQZfSqnLeiaEPaMeCvQfa0m+TWmUqq82gqOyLIU6Zs1St55ZbuVQl1w==
X-Received: by 2002:a5d:6d48:0:b0:20e:5f80:bd29 with SMTP id k8-20020a5d6d48000000b0020e5f80bd29mr53450073wri.428.1654075959000;
        Wed, 01 Jun 2022 02:32:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:2600:951d:63df:c091:3b45? (p200300cbc7052600951d63dfc0913b45.dip0.t-ipconnect.de. [2003:cb:c705:2600:951d:63df:c091:3b45])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c485600b0039756cdc8e1sm1361072wmo.37.2022.06.01.02.32.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 02:32:38 -0700 (PDT)
Message-ID: <ba64cd1b-c8ee-a4eb-f0cd-e16c26777d46@redhat.com>
Date:   Wed, 1 Jun 2022 11:32:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 3/3] mm: hugetlb_vmemmap: cleanup
 CONFIG_HUGETLB_PAGE_FREE_VMEMMAP*
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        smuchun@bytedance.com
References: <20220404074652.68024-1-songmuchun@bytedance.com>
 <20220404074652.68024-4-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220404074652.68024-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.04.22 09:46, Muchun Song wrote:
> The word of "free" is not expressive enough to express the feature of optimizing
> vmemmap pages associated with each HugeTLB, rename this keywork to "optimeze".
> In this patch , cheanup configs to make code more expressive.

Nit: why not simply CONFIG_HUGETLB_OPTIMIZE_VMEMMAP if we're touching
this already? At least I don't see value in the additional "PAGE" :)

> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  4 ++--
>  Documentation/admin-guide/mm/hugetlbpage.rst    |  2 +-
>  arch/arm64/Kconfig                              |  2 +-
>  arch/arm64/mm/flush.c                           |  2 +-
>  arch/x86/Kconfig                                |  2 +-
>  arch/x86/mm/init_64.c                           |  2 +-
>  fs/Kconfig                                      | 16 ++++++++--------
>  include/linux/hugetlb.h                         |  2 +-
>  include/linux/mm.h                              |  2 +-
>  include/linux/page-flags.h                      |  6 +++---
>  mm/Makefile                                     |  2 +-
>  mm/hugetlb_vmemmap.c                            |  4 ++--
>  mm/hugetlb_vmemmap.h                            |  4 ++--
>  mm/sparse-vmemmap.c                             |  4 ++--
>  14 files changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 56edbe3f458f..89a58ac49d5f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1660,7 +1660,7 @@
>  			Format: size[KMG]
>  
>  	hugetlb_free_vmemmap=

We didn't change the parameter name in #2, correct?


-- 
Thanks,

David / dhildenb

