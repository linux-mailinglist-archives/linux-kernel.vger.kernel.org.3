Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C7859D548
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 11:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244052AbiHWId1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 04:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245064AbiHWIa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:30:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19856D546
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661242496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q4OFDEuwYbQDCKzuYI2RJrZUWdrjR+wzBeiq9XfU9DY=;
        b=I3oBjDEBdvty1UO7qRBPvHutITNYGoBlixT3XNfhGyvPfYugZ4jZ790Dk121MqnvmOBXX6
        OL7p+QB5DY202SUBkm46xy6Abm9jMAR9GDriKZnJXRTF4vpONIMLD+ygx/O6BVF/0CcFww
        I5Xa5/5UAaGdTEQ3Xjx5Lxo6ltmujMw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-588-qAL3STF4MBaGtTxt8g1Edw-1; Tue, 23 Aug 2022 04:14:53 -0400
X-MC-Unique: qAL3STF4MBaGtTxt8g1Edw-1
Received: by mail-wm1-f71.google.com with SMTP id az42-20020a05600c602a00b003a552086ba9so9897554wmb.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=Q4OFDEuwYbQDCKzuYI2RJrZUWdrjR+wzBeiq9XfU9DY=;
        b=tZuQ2v38iObg4pmF0UYe1aXsaWGELXx8MlzR1dyFdTuNR7O/vBAi9bnwX5XOt75OiH
         Kv3SiltpvT2yCI0Trd/QmfJU5eC0cN3i7aGEjjNJvEpm120CbdbMTzt1blGV868breqA
         STbEafqA+u7+AYVmEVDZCa0a+enOPFHMhNCviHuxTvuxPUGQu0xyhE6K8Vw4pQhwZmQK
         We5q3QkqsfexV8H8IPj7UfLNO2Wewp2Hh71BVgmiyr/RuybVt9Ty7A5HmwN/0L3sARKG
         Hl049s6alfEzcKLYdmP+Jp7vcfKYV84P8qed8DCv+mXZ1S0/M1bPlMkdl2+LcKVxqgzr
         g3iw==
X-Gm-Message-State: ACgBeo0eIqIxSntCSjpPAASFqC9B8v5XH3qqAyEgJMNzGNWdea+KWcFN
        oB8aZ+rkH3x4euGlbTeRVouXWSFGDd6A1s0z5LQ1qz1Jg5iDFqU2wa0UKlBH3WrBgcJ5zwZezbT
        fYwCVVjvYmIKcDGo0yb1+daC7
X-Received: by 2002:a05:600c:19c8:b0:3a5:ec6a:8d16 with SMTP id u8-20020a05600c19c800b003a5ec6a8d16mr1326388wmq.182.1661242492178;
        Tue, 23 Aug 2022 01:14:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR56NJF8GDn308rkUs+Zfpk4q4pHfO+tAGT0u5/7P6jaJlCgKT5AD40J8/IGy1sBaecI3jlPaA==
X-Received: by 2002:a05:600c:19c8:b0:3a5:ec6a:8d16 with SMTP id u8-20020a05600c19c800b003a5ec6a8d16mr1326371wmq.182.1661242491858;
        Tue, 23 Aug 2022 01:14:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:1600:c48b:1fab:a330:5182? (p200300cbc70b1600c48b1faba3305182.dip0.t-ipconnect.de. [2003:cb:c70b:1600:c48b:1fab:a330:5182])
        by smtp.gmail.com with ESMTPSA id bg2-20020a05600c3c8200b003a5e9337967sm17314448wmb.13.2022.08.23.01.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 01:14:51 -0700 (PDT)
Message-ID: <3661415c-6069-24ed-b647-6fe6993bddae@redhat.com>
Date:   Tue, 23 Aug 2022 10:14:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/5] mm/hugetlb: use PMD page lock to protect CONT-PTE
 entries
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1661240170.git.baolin.wang@linux.alibaba.com>
 <88c8a8c68d87429f0fc48e81100f19b71f6e664f.1661240170.git.baolin.wang@linux.alibaba.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <88c8a8c68d87429f0fc48e81100f19b71f6e664f.1661240170.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.08.22 09:50, Baolin Wang wrote:
> Considering the pmd entries of a CONT-PMD hugetlb can not span on
> multiple PMDs, we can change to use the PMD page lock, which can
> be much finer grain that lock in the mm.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  include/linux/hugetlb.h | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 3a96f67..d4803a89 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -892,9 +892,17 @@ static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
>  static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
>  					   struct mm_struct *mm, pte_t *pte)
>  {
> -	VM_BUG_ON(huge_page_size(h) == PAGE_SIZE);
> +	unsigned long hp_size = huge_page_size(h);
>  
> -	if (huge_page_size(h) == PMD_SIZE) {
> +	VM_BUG_ON(hp_size == PAGE_SIZE);
> +
> +	/*
> +	 * Considering CONT-PMD size hugetlb, since the CONT-PMD entry
> +	 * can not span multiple PMDs, then we can use the fine grained
> +	 * PMD page lock.
> +	 */
> +	if (hp_size == PMD_SIZE ||
> +	    (hp_size > PMD_SIZE && hp_size < PUD_SIZE)) {
>  		return pmd_lockptr(mm, (pmd_t *) pte);
>  	} else if (huge_page_size(h) < PMD_SIZE) {
>  		unsigned long mask = ~(PTRS_PER_PTE * sizeof(pte_t) - 1);

Is there a measurable performance gain? IOW, do we really care?

-- 
Thanks,

David / dhildenb

