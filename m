Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546404E589A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 19:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343957AbiCWSon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 14:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiCWSok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 14:44:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6B415F5A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648060988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GPHRJrOley9SnFxNP5QQI8FCtrq/8HttXGFrhV18jDU=;
        b=il05ZnYusjfGf4idL+2Idq1cl94IVlExKm74KRk1MKFULGil7izWBs8eFNI1Wvy3dsTCg1
        OdQpb2pxMcncG7fJZSnELVjA3vjHysefqOdUKI0j7aVnn5eq019CaAOd3mb0zHNA1FCIOk
        U5uHwdRd7K1Hxk7fExbGTDI4qznO0AI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-NPDaNTzLN_Cc-Ca7k6ok9g-1; Wed, 23 Mar 2022 14:43:06 -0400
X-MC-Unique: NPDaNTzLN_Cc-Ca7k6ok9g-1
Received: by mail-wr1-f72.google.com with SMTP id f14-20020adfc98e000000b001e8593b40b0so786050wrh.14
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 11:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=GPHRJrOley9SnFxNP5QQI8FCtrq/8HttXGFrhV18jDU=;
        b=YMgEHgyk158y4BHdbadUWzR6KbZZZd1jUrJTP7/FfccaJezKq0pYF98Z33/fcSbjOm
         yssOutnFENn+5xv+FyOv6yjDvk2ViNH0L0AxKtZOasi0dFXmCbvCCD1G1DTpazv2n3yZ
         9GV4tDgj/+z3jewgqlH58RACgbwfgoIyldpJfV0b5+G2z+1Hc/OhnA/1ckGdZg+v6UCy
         MMhI0sibwhFaJkAGwHKFyAbnk+g969zJU1Eqs5zJjhkoaFvBAKFkcuh8HeLFfmcXQ38N
         DshxcpH8oGns94yAcBH+8NkXLeAaWRM72/Mro6V4fst5rF4pzbzLbR4uiityWiLzSj/j
         Cz4Q==
X-Gm-Message-State: AOAM533/8j8iEfBuS9lIrTSwt17zzDiy197UJMExqlE+sbe17FMguczX
        InLrT7VYmO/s+XSPPqA88nx7Mg7AkQd9kil274d2UPwtjrhkC98eA4KlVSX7nvi4nwDQDysiGsC
        d5/a7kB5dk3D92b7QVx8/p9g2
X-Received: by 2002:a5d:40ce:0:b0:203:f29f:7447 with SMTP id b14-20020a5d40ce000000b00203f29f7447mr1141236wrq.477.1648060985713;
        Wed, 23 Mar 2022 11:43:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOYbNFRnlYPUEiyiewa/tU01HWlSWpgMsaJci9hELtKkoaaTWsF35k/xaY5GbeEqNtFwgOYw==
X-Received: by 2002:a5d:40ce:0:b0:203:f29f:7447 with SMTP id b14-20020a5d40ce000000b00203f29f7447mr1141218wrq.477.1648060985441;
        Wed, 23 Mar 2022 11:43:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:a300:f7c1:f4a5:f958:a561? (p200300cbc704a300f7c1f4a5f958a561.dip0.t-ipconnect.de. [2003:cb:c704:a300:f7c1:f4a5:f958:a561])
        by smtp.gmail.com with ESMTPSA id q11-20020adfcd8b000000b001e320028660sm488768wrj.92.2022.03.23.11.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 11:43:04 -0700 (PDT)
Message-ID: <614b33de-cdf0-73d2-08e3-196363d816d2@redhat.com>
Date:   Wed, 23 Mar 2022 19:43:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     cgel.zte@gmail.com, akpm@linux-foundation.org
Cc:     yang.yang29@zte.com.cn, dave.hansen@linux.intel.com,
        ran.xiaokai@zte.com.cn, yang.shi@linux.alibaba.com,
        saravanand@fb.com, minchan@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xu xin <xu.xin16@zte.com.cn>
References: <20220323075714.2345743-1-yang.yang29@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2] mm/vmstat: add events for ksm cow
In-Reply-To: <20220323075714.2345743-1-yang.yang29@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.03.22 08:57, cgel.zte@gmail.com wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> Users may use ksm by calling madvise(, , MADV_MERGEABLE) when they want
> to save memory, it's a tradeoff by suffering delay on ksm cow. Users can
> get to know how much memory ksm saved by reading
> /sys/kernel/mm/ksm/pages_sharing, but they don't know what's the costs
> of ksm cow, and this is important of some delay sensitive tasks.
> 
> So add ksm cow events to help users evaluate whether or how to use ksm.
> 
> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> ---
> v2:
> - fix compile error when CONFIG_KSM is not set
> ---
>  include/linux/vm_event_item.h |  2 ++
>  mm/memory.c                   | 20 +++++++++++++++++---
>  mm/vmstat.c                   |  2 ++
>  3 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index 16a0a4fd000b..6f32be04212f 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -131,6 +131,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  		SWAP_RA_HIT,
>  #ifdef CONFIG_KSM
>  		KSM_SWPIN_COPY,
> +		KSM_COW_SUCCESS,
> +		KSM_COW_FAIL,
>  #endif
>  #endif
>  #ifdef CONFIG_X86
> diff --git a/mm/memory.c b/mm/memory.c
> index 4111f97c91a0..c24d5f04fab5 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3257,6 +3257,8 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  	__releases(vmf->ptl)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
> +	vm_fault_t ret = 0;
> +	bool ksm = 0;
>  
>  	if (userfaultfd_pte_wp(vma, *vmf->pte)) {
>  		pte_unmap_unlock(vmf->pte, vmf->ptl);
> @@ -3294,6 +3296,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  	 */
>  	if (PageAnon(vmf->page)) {
>  		struct page *page = vmf->page;
> +		ksm = PageKsm(page);
>  
>  		/*
>  		 * We have to verify under page lock: these early checks are
> @@ -3302,7 +3305,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  		 *
>  		 * PageKsm() doesn't necessarily raise the page refcount.
>  		 */
> -		if (PageKsm(page) || page_count(page) > 3)
> +		if (ksm || page_count(page) > 3)
>  			goto copy;
>  		if (!PageLRU(page))
>  			/*
> @@ -3316,7 +3319,7 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  			goto copy;
>  		if (PageSwapCache(page))
>  			try_to_free_swap(page);
> -		if (PageKsm(page) || page_count(page) != 1) {
> +		if (ksm || page_count(page) != 1) {

I think we really want to recheck here, after locking the page.
Consequently, just do a PageKsm() check below.

>  			unlock_page(page);
>  			goto copy;
>  		}
> @@ -3339,7 +3342,18 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  	get_page(vmf->page);
>  
>  	pte_unmap_unlock(vmf->pte, vmf->ptl);
> -	return wp_page_copy(vmf);
> +	ret = wp_page_copy(vmf);
> +
> +#ifdef CONFIG_KSM
> +	if (ksm) {
> +		if (unlikely(ret & VM_FAULT_ERROR))
> +			count_vm_event(KSM_COW_FAIL);
> +		else
> +			count_vm_event(KSM_COW_SUCCESS);
> +	}
> +#endif

Do we really care if we failed or not? I mean, the failure case will
usually make your app crash either way ... due to OOM.


Doing

#ifdef CONFIG_KSM
if (PageKsm(page))
	count_vm_event(COW_KSM);
#endif

before the wp_page_copy(vmf) should be good enough, no?

Should be good enough IMHO.

-- 
Thanks,

David / dhildenb

