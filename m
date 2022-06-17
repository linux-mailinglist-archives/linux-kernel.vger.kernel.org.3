Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905BF54F8FF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382654AbiFQOPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382326AbiFQOPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F24151E73
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655475340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=45WsYeBZBgVP+tO+Yp5wRnejBKTYaIp3okpekaDuC30=;
        b=Yx70f3IZl3hchqt9SNW5eda6c6igfIqTwXKF1IQX8MZJeWwbTSbufptwtKQNY/xL/jb+Co
        F1U4ccllBU/kTN5QyJwv79G0KH6FVQgesX1pCP+cs0+vMrZGVsEWhV/R8B/0iuTduuJSuU
        ViyIcMWbjiOfDPM0LQ7kcuh3SNVwYO4=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-NV2UimHgORWbuEIH8iWVDQ-1; Fri, 17 Jun 2022 10:15:38 -0400
X-MC-Unique: NV2UimHgORWbuEIH8iWVDQ-1
Received: by mail-io1-f72.google.com with SMTP id e195-20020a6bb5cc000000b0066cc9ece80fso2593266iof.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=45WsYeBZBgVP+tO+Yp5wRnejBKTYaIp3okpekaDuC30=;
        b=thpcAzz+PFkRydgqjqfttmlELRKMIgZyxMcPHdqCBH5Yp6ncrLRJ6X7smcC/ezTlds
         yU9Cg+YTsIieZe9Z4PTc0GR64M35l5d9UZeTnEaXMCOb5fdHcxVH1qoOm1LntJ0TeoZk
         JmVRPLAI6k+99AK2Bxgma6V4UjA22iLVFG0Y+OaH1YbXc+PEE4bUV7QcCokHuwxmN8Pz
         2vXVrSPlwekjG5oU8AmgZMsr0tKouzLb6ZXa3Xt6A43ERMU3Xml+t5m3yIzSlvabbbmY
         5p+/VBT8OXX0+VPxFXshbWgUNo59O2qoArSv8nBayA+ujbmGY0pAGOSpypN8u0SLVmzc
         679g==
X-Gm-Message-State: AJIora/7kJ65UH0fOV9ap0xX8EVlq5AUZuvJbcq+5rSKDS1FhWZEDORH
        tXzNQs/0Z091w0Mfqjyo/W4ukJjflNDPOwzp61FADJKt9du8C3/sU6NjjEw/hadH65zpcGSrZv5
        1ks80tkfdexARtiY7VEqNGM3I
X-Received: by 2002:a92:da4c:0:b0:2d5:4942:151c with SMTP id p12-20020a92da4c000000b002d54942151cmr5595274ilq.54.1655475337977;
        Fri, 17 Jun 2022 07:15:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t5+pBPw8qcp/W9vVk3R5y0UpR770R+5zi051+5lmo73AcdTcYx/JcpFCItROcYKy2t53b2mA==
X-Received: by 2002:a92:da4c:0:b0:2d5:4942:151c with SMTP id p12-20020a92da4c000000b002d54942151cmr5595259ilq.54.1655475337682;
        Fri, 17 Jun 2022 07:15:37 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id h22-20020a02c736000000b0033792143bf5sm649986jao.67.2022.06.17.07.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 07:15:36 -0700 (PDT)
Date:   Fri, 17 Jun 2022 10:15:34 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Muchun Song <songmuchun@bytedance.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        catalin.marinas@arm.com, will@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] hugetlb: skip to end of PT page mapping when pte not
 present
Message-ID: <YqyMhmAjrQ4C+EyA@xz-m1.local>
References: <20220616210518.125287-1-mike.kravetz@oracle.com>
 <20220616210518.125287-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220616210518.125287-2-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mike,

On Thu, Jun 16, 2022 at 02:05:15PM -0700, Mike Kravetz wrote:
> @@ -6877,6 +6896,39 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>  	return (pte_t *)pmd;
>  }
>  
> +/*
> + * Return a mask that can be used to update an address to the last huge
> + * page in a page table page mapping size.  Used to skip non-present
> + * page table entries when linearly scanning address ranges.  Architectures
> + * with unique huge page to page table relationships can define their own
> + * version of this routine.
> + */
> +unsigned long hugetlb_mask_last_page(struct hstate *h)
> +{
> +	unsigned long hp_size = huge_page_size(h);
> +
> +	switch (hp_size) {
> +	case P4D_SIZE:
> +		return PGDIR_SIZE - P4D_SIZE;
> +	case PUD_SIZE:
> +		return P4D_SIZE - PUD_SIZE;
> +	case PMD_SIZE:
> +		return PUD_SIZE - PMD_SIZE;
> +	default:

Should we add a WARN_ON_ONCE() if it should never trigger?

> +		break; /* Should never happen */
> +	}
> +
> +	return ~(0UL);
> +}
> +
> +#else
> +
> +/* See description above.  Architectures can provide their own version. */
> +__weak unsigned long hugetlb_mask_last_page(struct hstate *h)
> +{
> +	return ~(0UL);

I'm wondering whether it's better to return 0 rather than ~0 by default.
Could an arch with !CONFIG_ARCH_WANT_GENERAL_HUGETLB wrongly skip some
valid address ranges with ~0, or perhaps I misread?

Thanks,

-- 
Peter Xu

