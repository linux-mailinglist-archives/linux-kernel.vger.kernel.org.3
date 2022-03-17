Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6790C4DC5E3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 13:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbiCQMeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 08:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbiCQMeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:34:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4D9B111
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647520372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RqZn3YEdFU/3QM8GNjB727vmGwyW7baEAHXNzBFmN58=;
        b=P+7EcgeDBk2HgeKO/dKNZ/V/oI3KFHDXgqi1NN++H78lt0VG28G6qjyI6Il0sJkQOOhNfI
        GuuwKGKwb88/7vX+ls7om1Zzmc3vPTiAvTHkNZr2fIktlGBwcXlSdeTe++gpt+9uA4wYIk
        DXeUssbJyBCVakB7eE/eMd5+CQB2mw8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-327-7dgaMqvgMS6szpr1aCgQ5w-1; Thu, 17 Mar 2022 08:32:51 -0400
X-MC-Unique: 7dgaMqvgMS6szpr1aCgQ5w-1
Received: by mail-wm1-f72.google.com with SMTP id c126-20020a1c3584000000b00380dee8a62cso1583240wma.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 05:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=RqZn3YEdFU/3QM8GNjB727vmGwyW7baEAHXNzBFmN58=;
        b=r/b834LJlwQFTZC27p9+m4tJoZVvOBU7ayGfW6ZEDDo19JWtThh8kwwgzIcRavqx+l
         AHGqaI3baDRKs83OkWvk30x2r9p98FR1zyUr4VvhpuJdu5Vd9Ti0wwnVvcg+s5hONN+9
         TdAbswHY0+N/XSyxmtcnsLp6EMlgnkYAhRQQAgPiEjzwkg1FB8b1D/FMotxg+TkVkTA4
         LwOKFkWovfP3UkBZbU+OONj3znK7tXGvqKjoVZhdzoX+KcEEHiWtiuCICWzOkIi28kpn
         OEYQY6HkBbPkd18MZWr6eEulGHtb1+srtDXvNLrP5C7SSiPP7BjilFtWue2bUs0PJpqj
         +oBA==
X-Gm-Message-State: AOAM533TrIJOOmVDF+kEvU3fX38fL/1iBYvyfAcB+xt4mcBifzZXoWLY
        scdmWI00duFHxy7GK7VPdlctzwiTdddQOltNnTnGgHLx9bXAszc8khW9g5rXLhnma2zf+E2EQE9
        Ug17FJGFniCh/J+I9HtVpMnKK
X-Received: by 2002:a05:600c:35ce:b0:389:ec57:1d7f with SMTP id r14-20020a05600c35ce00b00389ec571d7fmr11300166wmq.149.1647520370167;
        Thu, 17 Mar 2022 05:32:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3JJPrnhs22W6QOIN0f6W698/5NBzUwmz9dFnbq5r13BFbXwjnF9xBibZjPDlORrMQzpMBjg==
X-Received: by 2002:a05:600c:35ce:b0:389:ec57:1d7f with SMTP id r14-20020a05600c35ce00b00389ec571d7fmr11300146wmq.149.1647520369813;
        Thu, 17 Mar 2022 05:32:49 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id v13-20020adfe28d000000b0020375f27a5asm4109290wri.4.2022.03.17.05.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 05:32:49 -0700 (PDT)
Message-ID: <fbe8f659-44dd-dd10-a3c3-acaf387abd4d@redhat.com>
Date:   Thu, 17 Mar 2022 13:32:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2] mm: add access/dirty bit on numa page fault
Content-Language: en-US
To:     Bibo Mao <maobibo@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20220317065033.2635123-1-maobibo@loongson.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220317065033.2635123-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.03.22 07:50, Bibo Mao wrote:
> On platforms like x86/arm which supports hw page walking, access
> and dirty bit is set by hw, however on some platforms without
> such hw functions, access and dirty bit is set by software in
> next trap.
> 
> During numa page fault, dirty bit can be added for old pte if
> fail to migrate on write fault. And if it succeeds to migrate,
> access bit can be added for migrated new pte, also dirty bit
> can be added for write fault.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  mm/memory.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index c125c4969913..65813bec9c06 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4404,6 +4404,22 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	if (migrate_misplaced_page(page, vma, target_nid)) {
>  		page_nid = target_nid;
>  		flags |= TNF_MIGRATED;
> +
> +		/*
> +		 * update pte entry with access bit, and dirty bit for
> +		 * write fault
> +		 */
> +		spin_lock(vmf->ptl);

Ehm, are you sure? We did a pte_unmap_unlock(), so you most certainly need a

vmf->pte = pte_offset_map(vmf->pmd, vmf->address);


Also, don't we need pte_same() checks before we do anything after
dropping the PT lock?

> +		pte = *vmf->pte;
> +		pte = pte_mkyoung(pte);
> +		if (was_writable) {
> +			pte = pte_mkwrite(pte);
> +			if (vmf->flags & FAULT_FLAG_WRITE)
> +				pte = pte_mkdirty(pte);
> +		}
> +		set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> +		update_mmu_cache(vma, vmf->address, vmf->pte);
> +		pte_unmap_unlock(vmf->pte, vmf->ptl);
>  	} else {
>  		flags |= TNF_MIGRATE_FAIL;
>  		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
> @@ -4427,8 +4443,11 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
>  	old_pte = ptep_modify_prot_start(vma, vmf->address, vmf->pte);
>  	pte = pte_modify(old_pte, vma->vm_page_prot);
>  	pte = pte_mkyoung(pte);
> -	if (was_writable)
> +	if (was_writable) {
>  		pte = pte_mkwrite(pte);
> +		if (vmf->flags & FAULT_FLAG_WRITE)
> +			pte = pte_mkdirty(pte);
> +	}
>  	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
>  	update_mmu_cache(vma, vmf->address, vmf->pte);
>  	pte_unmap_unlock(vmf->pte, vmf->ptl);


-- 
Thanks,

David / dhildenb

