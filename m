Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DE25B0D4C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 21:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiIGTee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 15:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiIGTea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 15:34:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DD713A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 12:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662579261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7MsVI8c1fxq0sSSjaJXYEOch1npprYIC2451+xAyYa0=;
        b=iUjtBjWYDTJXmcZd3y7NVONygZYd715cujpPALtiXPzuOIPtqtY4E+VV/hzeTDzJAS4eIY
        wDHHZMJupcQZN7hJOZ07O9Ef5UuffmWTiggcPw2bGQYTVniOqNDlse32bhFAt3QJArl9yb
        o55zpBO8n4jAOtqGuo5+kS0NFheMtag=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-88-TMcVl7djNlWSf1cDE3ENZQ-1; Wed, 07 Sep 2022 15:34:20 -0400
X-MC-Unique: TMcVl7djNlWSf1cDE3ENZQ-1
Received: by mail-wm1-f71.google.com with SMTP id q10-20020a1ce90a000000b003a60123678aso2540634wmc.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 12:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=7MsVI8c1fxq0sSSjaJXYEOch1npprYIC2451+xAyYa0=;
        b=RIDUQYHfABJeCgH+q32wOImPVSErW+q4Rq+YBL38xSdaXIEsa3DhAnGHUicZSwMgK7
         G5s8YGn8Hcn+9sV2Ww6KYQv21HRjEtcRjpNthxvGAIzB4HhsOEtcTPnAcmKCLrO7VPPw
         9HqFAAEv1TEFDd6prD4NBC40Rjv/ywd419QggorQU6Hs0upNB29FFvL/5BqdQqfAV3ko
         RdRSkYw+dnYza21LxILTvVSzN2xqtDVBkWqGTzIljriw7LZg+MBnM3Awc490lvumEK1y
         VgcpxJgo0Lt6+xgz4N8dIHbfpS9FdNG1er3dhbDXhkZKwgLjHj4/OoK/godSY6Yl0dCD
         DW6w==
X-Gm-Message-State: ACgBeo3GonaVTtU7O78jGIoq4foypKQ2vDDCyxnagz0A4z4MXu394k/G
        4ByU5gdeSLLY7HLzX/gd730kyEujRGDgx3S+SSp93wGswqDrNutKj/NBEHrkBDxKbleEdW7b0d9
        OHEyxUqQkWAPhj8He8AvBrp3j
X-Received: by 2002:adf:e9c2:0:b0:228:62a5:a59b with SMTP id l2-20020adfe9c2000000b0022862a5a59bmr3023773wrn.47.1662579257739;
        Wed, 07 Sep 2022 12:34:17 -0700 (PDT)
X-Google-Smtp-Source: AA6agR47W6WNql5ZeWImeEUS0k3WgwW8frzlFbU39PqtW0jo90OD5KShj425J9bGCwCzIr1xpbbM3g==
X-Received: by 2002:adf:e9c2:0:b0:228:62a5:a59b with SMTP id l2-20020adfe9c2000000b0022862a5a59bmr3023766wrn.47.1662579257500;
        Wed, 07 Sep 2022 12:34:17 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0? (p200300d82f0dba00c95131d7b2b08ba0.dip0.t-ipconnect.de. [2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0])
        by smtp.gmail.com with ESMTPSA id bz9-20020a056000090900b0022584c82c80sm19260207wrb.19.2022.09.07.12.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 12:34:17 -0700 (PDT)
Message-ID: <684b9004-fad2-3727-b215-a4b2bfe36712@redhat.com>
Date:   Wed, 7 Sep 2022 21:34:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [v2 PATCH 2/2] powerpc/64s/radix: don't need to broadcast IPI for
 radix pmd collapse flush
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>, peterx@redhat.com,
        kirill.shutemov@linux.intel.com, jhubbard@nvidia.com,
        jgg@nvidia.com, hughd@google.com, akpm@linux-foundation.org,
        aneesh.kumar@linux.ibm.com
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20220907180144.555485-1-shy828301@gmail.com>
 <20220907180144.555485-2-shy828301@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220907180144.555485-2-shy828301@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.09.22 20:01, Yang Shi wrote:
> The IPI broadcast is used to serialize against fast-GUP, but fast-GUP
> will move to use RCU instead of disabling local interrupts in fast-GUP.
> Using an IPI is the old-styled way of serializing against fast-GUP
> although it still works as expected now.
> 
> And fast-GUP now fixed the potential race with THP collapse by checking
> whether PMD is changed or not.  So IPI broadcast in radix pmd collapse
> flush is not necessary anymore.  But it is still needed for hash TLB.
> 
> Suggested-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>   arch/powerpc/mm/book3s64/radix_pgtable.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
> index 698274109c91..e712f80fe189 100644
> --- a/arch/powerpc/mm/book3s64/radix_pgtable.c
> +++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
> @@ -937,15 +937,6 @@ pmd_t radix__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addre
>   	pmd = *pmdp;
>   	pmd_clear(pmdp);
>   
> -	/*
> -	 * pmdp collapse_flush need to ensure that there are no parallel gup
> -	 * walk after this call. This is needed so that we can have stable
> -	 * page ref count when collapsing a page. We don't allow a collapse page
> -	 * if we have gup taken on the page. We can ensure that by sending IPI
> -	 * because gup walk happens with IRQ disabled.
> -	 */
> -	serialize_against_pte_lookup(vma->vm_mm);
> -
>   	radix__flush_tlb_collapsed_pmd(vma->vm_mm, address);
>   
>   	return pmd;

Makes sense to me

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

