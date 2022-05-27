Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C21535A1F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 09:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345528AbiE0HOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 03:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244981AbiE0HO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 03:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B016F3A5E6
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653635661;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KVraxte1vrcRlqC53OEcc6nFbHRHftbMtAJLs4yYTCI=;
        b=LFOhmu1V1A8bBSajI/8w7IpiS8gfZAuM/dVEIuIVuWe251SL5mcQwmqr2G4TTyNBvdXgdy
        WfZNqSoLAxF3e6Kwu8IvbuF760TRfnHeZVVOclJthZWS9q/IzoKuDKRx+ik5/JytPhocaO
        5b15mEcVAbkDrvd0csUpfesfcVEEmJQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-CkBTD7vpPbulWZldrmxtOA-1; Fri, 27 May 2022 03:14:17 -0400
X-MC-Unique: CkBTD7vpPbulWZldrmxtOA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58B478219B2;
        Fri, 27 May 2022 07:13:21 +0000 (UTC)
Received: from [10.72.12.91] (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 14DC9C212C;
        Fri, 27 May 2022 07:12:55 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] arm64/hugetlb: Fix building errors in
 huge_ptep_clear_flush()
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        naresh.kamboju@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <814e20c19b110209ee12ecae7cb05f8a78d021c8.1653625820.git.baolin.wang@linux.alibaba.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <4707e621-c167-8fff-b210-9babb6a3f2df@redhat.com>
Date:   Fri, 27 May 2022 15:12:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <814e20c19b110209ee12ecae7cb05f8a78d021c8.1653625820.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

On 5/27/22 12:51 PM, Baolin Wang wrote:
> Fix below building errors which was caused by commit ae07562909f3
> ("mm: change huge_ptep_clear_flush() to return the original pte")
> interacting with commit fb396bb459c1 ("arm64/hugetlb: Drop TLB flush
> from get_clear_flush()").
> 
> Due to the new get_clear_contig() has dropped TLB flush, we should
> add an explicit TLB flush in huge_ptep_clear_flush() to keep original
> semantics when changing to use new get_clear_contig().
> 
> "
> arch/arm64/mm/hugetlbpage.c: In function ‘huge_ptep_clear_flush’:
> arch/arm64/mm/hugetlbpage.c:515:9: error: implicit declaration of
> function ‘get_clear_flush’; did you mean ‘ptep_clear_flush’?
> [-Werror=implicit-function-declaration]
>    515 |  return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
>        |         ^~~~~~~~~~~~~~~
>        |         ptep_clear_flush
> "
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>   arch/arm64/mm/hugetlbpage.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 

I ran to the compiling failure either and it would be caused by
commit fb396bb459c1 ("arm64/hugetlb: Drop TLB flush from get_clear_flush()").
It's worthy to have a "Fixes" tag. With those fixed:

Reviewed-by: Gavin Shan <gshan@redhat.com>


> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 0f0c17dfeb9c..e2a5ec9fdc0d 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -507,12 +507,15 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>   {
>   	size_t pgsize;
>   	int ncontig;
> +	pte_t orig_pte;
>   
>   	if (!pte_cont(READ_ONCE(*ptep)))
>   		return ptep_clear_flush(vma, addr, ptep);
>   
>   	ncontig = find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
> -	return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
> +	orig_pte = get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
> +	flush_tlb_range(vma, addr, addr + pgsize * ncontig);
> +	return orig_pte;
>   }
>   
>   static int __init hugetlbpage_init(void)
> 

Thanks,
Gavin

