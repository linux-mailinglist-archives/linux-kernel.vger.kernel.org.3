Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FA7589AB3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239581AbiHDLCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239572AbiHDLBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:01:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88B3261B37
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 04:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659610878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ja8DJZE704PWhWiVwa+IkYEZUfwBCbT5/nl9Rxcn20s=;
        b=XvlVdUmdJTfGh4bn78RyXDffSoWZV5/cldhyJipa2Gfh3wVkYWiBb+eRSa2O7bdXdtbkPF
        WNtV83s7YW4f8KlomynjeX9WsDHRJW57i+Y3wQG4ara/acKjpJNtMLuoixSBLRtBoCWeDg
        XupJHLUndZNCiA7PcHpgAttOpoBvW84=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-_IGKsNlxOfq_yc9Ex3lKgg-1; Thu, 04 Aug 2022 07:01:09 -0400
X-MC-Unique: _IGKsNlxOfq_yc9Ex3lKgg-1
Received: by mail-ej1-f71.google.com with SMTP id qk37-20020a1709077fa500b00730c2d975a0so615492ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 04:01:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=Ja8DJZE704PWhWiVwa+IkYEZUfwBCbT5/nl9Rxcn20s=;
        b=2GhI7WCJl5pFk9uR2Dh+FFxhnxnVVUm5Ao5O3E2kEmzLzeHatqHkxKLsaOXONfIDsP
         JAKZkzpPO7NVxeIaRAQCi8+jUkj7TRBBbMpX/6+YPnOO7CpLPMhVm+lS75VElsVpUYhc
         d7oNc+SR868A8CjRLP5UemeZNe68nbt+5NmVHC81Lj3av235hi/lTVS9PbE++PcTu1/s
         GIj+4vRI9qDGCDa0gfvzHrX3ErnQNu1FuUISYtleukxRRXWMnCvQQ47KAREEOL0vq2R7
         A0hFVRjgUWBkKHS2V89ijNMGNUs8QRfxG1nxp7f/Q6Q8kmOPHGxGyINudyxy0RbkFAYM
         uB9w==
X-Gm-Message-State: ACgBeo0SJOyhBHLRSHEZHqLD4rk4LnI7qHDevs4alfbTtTvxcVedYRfZ
        RSJFJe9IksTLBAM/Abb0nJVsaa4j1vLq4SKNR071Q5+2pq3ZBcGuS4ZEA53gnh+uAH9jiJ/A9Dd
        d1tOYBIZchdkfFehCi/p5n0OY
X-Received: by 2002:a17:907:3e0e:b0:72b:568f:7fa7 with SMTP id hp14-20020a1709073e0e00b0072b568f7fa7mr1028669ejc.119.1659610867853;
        Thu, 04 Aug 2022 04:01:07 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4cIXLgva61l3MByTN1QLsYZYOv8abIXXSRU/VwPQHdywWn7XZbzNgvDk3iuWQUuxjDBy7l9g==
X-Received: by 2002:a17:907:3e0e:b0:72b:568f:7fa7 with SMTP id hp14-20020a1709073e0e00b0072b568f7fa7mr1028657ejc.119.1659610867576;
        Thu, 04 Aug 2022 04:01:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:8900:2c18:b992:1fa1:f88b? (p200300cbc70689002c18b9921fa1f88b.dip0.t-ipconnect.de. [2003:cb:c706:8900:2c18:b992:1fa1:f88b])
        by smtp.gmail.com with ESMTPSA id b8-20020a170906038800b0072af56103casm185015eja.220.2022.08.04.04.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 04:01:07 -0700 (PDT)
Message-ID: <daffa3ff-5016-732d-f842-bdeed5e6a0de@redhat.com>
Date:   Thu, 4 Aug 2022 13:01:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] mm/smaps: Don't access young/dirty bit if pte unpresent
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@openvz.org>
References: <20220803220329.46299-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220803220329.46299-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.22 00:03, Peter Xu wrote:
> These bits should only be valid when the ptes are present.  Introducing two
> booleans for it and set it to false when !pte_present().
> 
> Cc: Konstantin Khlebnikov <khlebnikov@openvz.org>
> Fixes: b1d4d9e0cbd0 ("proc/smaps: carefully handle migration entries", 2012-05-31)
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  fs/proc/task_mmu.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 9913f3be9fd2..482f91577f8c 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -527,10 +527,12 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
>  	struct vm_area_struct *vma = walk->vma;
>  	bool locked = !!(vma->vm_flags & VM_LOCKED);
>  	struct page *page = NULL;
> -	bool migration = false;
> +	bool migration = false, young = false, dirty = false;
>  
>  	if (pte_present(*pte)) {
>  		page = vm_normal_page(vma, addr, *pte);
> +		young = pte_young(*pte);
> +		dirty = pte_dirty(*pte);
>  	} else if (is_swap_pte(*pte)) {
>  		swp_entry_t swpent = pte_to_swp_entry(*pte);
>  
> @@ -560,8 +562,7 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
>  	if (!page)
>  		return;
>  
> -	smaps_account(mss, page, false, pte_young(*pte), pte_dirty(*pte),
> -		      locked, migration);
> +	smaps_account(mss, page, false, young, dirty, locked, migration);
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

