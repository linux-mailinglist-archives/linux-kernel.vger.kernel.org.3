Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BC850A68A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358704AbiDURIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiDURI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:08:29 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C28B3ED01
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:05:38 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id bg24so5530121pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=5gmIij74AnDbY6qgr01UCnK6HzZogNxUIMK/+QoMp5g=;
        b=pM6fVZiauwUEHH9GIOQ7ii10p9f8+vmUKQ3AZQXvSVOyYpmrdeVJXqZ3gVAaXvEWIb
         qQYl4kET7hzWq+UBVuBLR3NhkTm4nVshvjF3JDmpxICdfecWmGHB04aLJ2sx6rFX6Fpf
         oc1NeoXWW21u2K5sz1/Xob4hzfcFubhIOtg3rPKyv7o1YyMOMDaJsUXg+NaG4VCDhL+C
         Mziu8u5sTDqbl2xd71Fh5h+QQCoCYNgmCL9cR4SchNBvU3swo5SdRH6xmPMBCKgQkzUp
         yvMzci+GHzKLqj0sVn1nf/QT7X6JkWpue6d62p4ilbzEZgZ5O9f7AYXYhuU0JCXP0tKm
         TbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=5gmIij74AnDbY6qgr01UCnK6HzZogNxUIMK/+QoMp5g=;
        b=FAbWz5TzwixXxe8/EuUBsyZIWgxTA9WWlG6sfMLPFADvobc4gE4L3QzQqXWOM8jSwX
         jDz5svorcP9OaorMN0Zx1/5H4sXCRBrt3+ndoWob281bexBJRgxF6IkMl7fLZJnQFZ+S
         7Bif2B45egNQNwoj9bsoE8+DYsXoC95psrV0CYVongOsVGY2m12wq4V8ASUv+0JRc2Tq
         tmjcR80CCjsfuesyWyN8HTNrYRFAa5671Iv93GOd7y2bCzsykEMjfD51KVR/nALr06nB
         hZp+CtRO7aNtPx75AAH/hAaY2SusuC2et3PK7RbQ2CdHUicQQyAWAACcSKbQkNSNzcWZ
         TW0g==
X-Gm-Message-State: AOAM533KUFk9n38l7NIpZIDxrx34Qaj5aqdI07AaSjRvF7TpDqvUIX4O
        Sg38pQW2i9665V2KNkgyANNpquB43TEenw==
X-Google-Smtp-Source: ABdhPJytsH5waRAiVkAmq21l+Ij9qBhY0E5qN6lPrVZhHH/1g1nDZiZgCJ+6vs/jotE6GkZYBNDK8w==
X-Received: by 2002:a17:902:9a4c:b0:158:b6f0:4aa2 with SMTP id x12-20020a1709029a4c00b00158b6f04aa2mr354677plv.163.1650560737879;
        Thu, 21 Apr 2022 10:05:37 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id c16-20020a631c50000000b003a39244fe8esm19043710pgm.68.2022.04.21.10.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:05:36 -0700 (PDT)
Date:   Thu, 21 Apr 2022 10:05:36 -0700 (PDT)
X-Google-Original-Date: Thu, 21 Apr 2022 09:51:26 PDT (-0700)
Subject:     Re: [PATCH v4] riscv: mm: Remove the copy operation of pmd
In-Reply-To: <20220401024320.98510-1-hanchuanhua@oppo.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        alexandre.ghiti@canonical.com, jszhang@kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org,
        zhengqi.arch@bytedance.com, ebiederm@xmission.com,
        liushixin2@huawei.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, hanchuanhua@oppo.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     hanchuanhua@oppo.com
Message-ID: <mhng-2e84f176-f077-4a7a-b1e0-66813b2c0e7d@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022 19:43:20 PDT (-0700), hanchuanhua@oppo.com wrote:
> Since all processes share the kernel address space,
> we only need to copy pgd in case of a vmalloc page
> fault exception, the other levels of page tables are
> shared, so the operation of copying pmd is unnecessary.
>
> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> ---
> Changes in v4:
>   -Modify incorrect author name.
>
> Changes in v3:
>   -Change the real name of signed-off-by.
>
> Changes in v2:
>   -Delete incorrect default signatures.
>
>
>  arch/riscv/mm/fault.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 4e9efbe46d5f..40694f0cab9e 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -102,9 +102,9 @@ static inline void bad_area(struct pt_regs *regs, struct mm_struct *mm, int code
>  static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long addr)
>  {
>  	pgd_t *pgd, *pgd_k;
> -	pud_t *pud, *pud_k;
> -	p4d_t *p4d, *p4d_k;
> -	pmd_t *pmd, *pmd_k;
> +	pud_t *pud_k;
> +	p4d_t *p4d_k;
> +	pmd_t *pmd_k;
>  	pte_t *pte_k;
>  	int index;
>  	unsigned long pfn;
> @@ -132,14 +132,12 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
>  	}
>  	set_pgd(pgd, *pgd_k);
>
> -	p4d = p4d_offset(pgd, addr);
>  	p4d_k = p4d_offset(pgd_k, addr);
>  	if (!p4d_present(*p4d_k)) {
>  		no_context(regs, addr);
>  		return;
>  	}
>
> -	pud = pud_offset(p4d, addr);
>  	pud_k = pud_offset(p4d_k, addr);
>  	if (!pud_present(*pud_k)) {
>  		no_context(regs, addr);
> @@ -150,13 +148,11 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
>  	 * Since the vmalloc area is global, it is unnecessary
>  	 * to copy individual PTEs
>  	 */
> -	pmd = pmd_offset(pud, addr);
>  	pmd_k = pmd_offset(pud_k, addr);
>  	if (!pmd_present(*pmd_k)) {
>  		no_context(regs, addr);
>  		return;
>  	}
> -	set_pmd(pmd, *pmd_k);
>
>  	/*
>  	 * Make sure the actual PTE exists as well to

Thanks, this is on for-next (it was last night, but looks like I forgot 
to send the email).
