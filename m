Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE04350DA49
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238138AbiDYHmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbiDYHmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:42:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1CA071CFEC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650872354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYIpSctnaXqJRrJZY7KOLeHqatclb2EJy7kwxJNXcEA=;
        b=IyKM/hBr8A6e6AZR8Hkrfb/MtPj8v4zdrULVxMFwzp9SDCSmQS0aO0kUnpOgHXyybY4dTV
        wdXc1E9ATUSHWmsa4t1PbQkpOgALe/Uw02ZWBnSn5uF33Lm6A2J1Rqyec1vzPHL5i6IhEu
        XEsG1TsV25LlNx+WaW94YfPxleiqiQQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-UYDry00NNgKJYPonTEWswA-1; Mon, 25 Apr 2022 03:39:12 -0400
X-MC-Unique: UYDry00NNgKJYPonTEWswA-1
Received: by mail-wm1-f72.google.com with SMTP id i131-20020a1c3b89000000b00392b57fbdaaso6396924wma.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 00:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=JYIpSctnaXqJRrJZY7KOLeHqatclb2EJy7kwxJNXcEA=;
        b=dPtm0HElE/MY0C4Ca2VXDucPv44DWQLatFTAFyHBdM1yHKyfSo6AfCzF777QlfJ8z/
         xr08U3au6de8fjA+mdLwcO73zJMFm3TkmlZf4gXwc+1N0DqoQg6Dh8ayDZAtkE79xis4
         w1LGxmOcRmKqHur2qz0Sdn0L5mNYI0TOhRwTAGHZNWiZy5TQern49J6u5CDClN6MGn/j
         ZrnOhjp+ouLCDJLuyKPUiAzhAZh7Uh6a8as4rTvu7bKT7Vxcfbn2Oc+gPjCgc2soaIPE
         +8pBLgTkjIWxwF1GTa1GMT+F5HIOWSJncLDBk+tMXLYnbEW5G3hQxTvdMlucYJM4SgkI
         UObQ==
X-Gm-Message-State: AOAM533YeJ6wzdnAk3de3e054M8xkx8nvBv1a8uU3wNJB55PN47yGNnO
        tSe6XzF/gNRusBVIBpI35mJ9lqW2R4Fl3dXb4rdSeSS+UAf0So9+P3oYozluD8VH76oHp7L7Pop
        MYejq7SdYtOBo0x+FXiN4Oh19
X-Received: by 2002:a5d:6843:0:b0:20a:def2:5545 with SMTP id o3-20020a5d6843000000b0020adef25545mr1252117wrw.89.1650872351758;
        Mon, 25 Apr 2022 00:39:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyj70WP2fyKeHfPoCu95Q+61xddwrribEw7PcH9kHB3qmPDdktTVAhutfLF8c9SCnQEime/Sg==
X-Received: by 2002:a5d:6843:0:b0:20a:def2:5545 with SMTP id o3-20020a5d6843000000b0020adef25545mr1252092wrw.89.1650872351517;
        Mon, 25 Apr 2022 00:39:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:fc00:490d:ed6a:8b22:223a? (p200300cbc700fc00490ded6a8b22223a.dip0.t-ipconnect.de. [2003:cb:c700:fc00:490d:ed6a:8b22:223a])
        by smtp.gmail.com with ESMTPSA id y9-20020a05600015c900b0020adb0e106asm2756818wry.93.2022.04.25.00.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 00:39:10 -0700 (PDT)
Message-ID: <fcf69d7c-dded-666c-def1-4ce9f58ed852@redhat.com>
Date:   Mon, 25 Apr 2022 09:39:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 2/3] mm/swapfile: Fix lost swap bits in unuse_pte()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, dhowells@redhat.com,
        neilb@suse.de, apopple@nvidia.com, surenb@google.com,
        minchan@kernel.org, peterx@redhat.com, sfr@canb.auug.org.au,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220424091105.48374-1-linmiaohe@huawei.com>
 <20220424091105.48374-3-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220424091105.48374-3-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.04.22 11:11, Miaohe Lin wrote:
> This is observed by code review only but not any real report.
> 
> When we turn off swapping we could have lost the bits stored in the swap
> ptes. The new rmap-exclusive bit is fine since that turned into a page
> flag, but not for soft-dirty and uffd-wp. Add them.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/swapfile.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 95b63f69f388..522a0eb16bf1 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1783,7 +1783,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>  {
>  	struct page *swapcache;
>  	spinlock_t *ptl;
> -	pte_t *pte;
> +	pte_t *pte, new_pte;
>  	int ret = 1;
>  
>  	swapcache = page;
> @@ -1832,8 +1832,12 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
>  		page_add_new_anon_rmap(page, vma, addr);
>  		lru_cache_add_inactive_or_unevictable(page, vma);
>  	}
> -	set_pte_at(vma->vm_mm, addr, pte,
> -		   pte_mkold(mk_pte(page, vma->vm_page_prot)));
> +	new_pte = pte_mkold(mk_pte(page, vma->vm_page_prot));
> +	if (pte_swp_soft_dirty(*pte))
> +		new_pte = pte_mksoft_dirty(new_pte);
> +	if (pte_swp_uffd_wp(*pte))
> +		new_pte = pte_mkuffd_wp(new_pte);
> +	set_pte_at(vma->vm_mm, addr, pte, new_pte);
>  	swap_free(entry);
>  out:
>  	pte_unmap_unlock(pte, ptl);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

