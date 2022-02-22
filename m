Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5660F4C03BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 22:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235778AbiBVV01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 16:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234356AbiBVV0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 16:26:25 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667C2111094
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:25:59 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id gi6so850209pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 13:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=3GMGpmsX5Sxh9Rowtyg+q5ai/Y4YeFDXutspTo0kPIY=;
        b=DsglCOfTfDoGrxhojDR2OSvkMLectqlyMrwgCAEGegWACO8c2TO3vAZm5AvuDGbGB/
         AfwU6PLsVNUCL9sjR8OiRWGPi4w6Mzn6aTt5qLRA31Z+7Vx5g7yvzVgn/2TGDmrXwXiR
         tX9rxjEZWMPm4qrXxdcFSUA9q65lbl/3+7CWEkc1+dNLzw9Xgu9CtqgX8I0TdrWDtoZo
         Pmw8yG1ve5uOR3VxbLyZeiSfoyP2HyAaDw2y39u7pKSZHBN4E3RsPhF6wymCys+IwJX9
         0ydnrclVrc7ceNSE2nLgoxHYLEf/goG4zfja1UxHEfgz/ElcwjHLS9z8yGLuZ+Hws1Oy
         cMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=3GMGpmsX5Sxh9Rowtyg+q5ai/Y4YeFDXutspTo0kPIY=;
        b=FM36NXB4de157G71egEcfeiaNCpaBeShPPvNFjNnswx0aVZO/U15vzoSKSc+VqiTG1
         4ssplBo/V7RqcCgUoWCa3NttQYnAMp278i/QxarVV7cufK0bSTVEJ9slErPnnWxVWTRo
         rAoWRl2LYkdrcR9YaIgfYHr0HiH8q8zhDV8CHvsrjlqCbHaDUt+cRcsqu9ySSxFf0a9k
         JES+fihzP0y/9JPgyRe2Bq03QxH8Q+YvVS+A0eUEDqwVHtYpNcdANwuXqYX3m7FrSpsR
         pHh2g4ZgecT4/HU7wRhA9BrAdyBZq79Ia+BeAe7voY4Jv+wCU7rmzLYC82JypaB3ShEL
         5PsA==
X-Gm-Message-State: AOAM532mPiJ1g38CSKfk3i8bDFlNX8OraeQN9Ah1+EwsOglmoQmk4fC+
        cfBEUR9hNVLqcA1YnlnLy5POJg==
X-Google-Smtp-Source: ABdhPJypI0+UnxdX0K60WGxnqqz7+VBknfaZQj1jQNbPKlMSomWbVprZfDl6vXHOVBZEQqXoDneoCQ==
X-Received: by 2002:a17:902:6b49:b0:149:7c73:bd6f with SMTP id g9-20020a1709026b4900b001497c73bd6fmr24550258plt.46.1645565158855;
        Tue, 22 Feb 2022 13:25:58 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id v22-20020a17090ad59600b001b7deb42251sm500928pju.15.2022.02.22.13.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 13:25:58 -0800 (PST)
Date:   Tue, 22 Feb 2022 13:25:58 -0800 (PST)
X-Google-Original-Date: Tue, 22 Feb 2022 13:25:00 PST (-0800)
Subject:     Re: [PATCH] riscv: mm: Remove the copy operation of pmd
In-Reply-To: <20220127100622.11856-1-hanchuanhua@oppo.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        jszhang@kernel.org, alexandre.ghiti@canonical.com,
        wangkefeng.wang@huawei.com, zhengqi.arch@bytedance.com,
        ebiederm@xmission.com, liushixin2@huawei.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        hanchuanhua@oppo.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     hanchuanhua@oppo.com
Message-ID: <mhng-98c8a68c-ecb2-4db1-ab3e-3a35d5e764d0@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 02:06:22 PST (-0800), hanchuanhua@oppo.com wrote:
> Since all processes share the kernel address space,
> we only need to copy pgd in case of a vmalloc page
> fault exception, the other levels of page tables are
> shared, so the operation of copying pmd is unnecessary.
>
> Signed-off-by: hanchuanhua <hanchuanhua@oppo.com>
> ---
>  arch/riscv/mm/fault.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> index 4e9efbe..40694f0 100644
> --- a/arch/riscv/mm/fault.c
> +++ b/arch/riscv/mm/fault.c
> @@ -102,9 +102,9 @@ static inline void bad_area(struct pt_regs *regs, struct mm_struct *mm, int code
>  static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long addr)
>  {
>         pgd_t *pgd, *pgd_k;
> -       pud_t *pud, *pud_k;
> -       p4d_t *p4d, *p4d_k;
> -       pmd_t *pmd, *pmd_k;
> +       pud_t *pud_k;
> +       p4d_t *p4d_k;
> +       pmd_t *pmd_k;
>         pte_t *pte_k;
>         int index;
>         unsigned long pfn;
> @@ -132,14 +132,12 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
>         }
>         set_pgd(pgd, *pgd_k);
>
> -       p4d = p4d_offset(pgd, addr);
>         p4d_k = p4d_offset(pgd_k, addr);
>         if (!p4d_present(*p4d_k)) {
>                 no_context(regs, addr);
>                 return;
>         }
>
> -       pud = pud_offset(p4d, addr);
>         pud_k = pud_offset(p4d_k, addr);
>         if (!pud_present(*pud_k)) {
>                 no_context(regs, addr);
> @@ -150,13 +148,11 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
>          * Since the vmalloc area is global, it is unnecessary
>          * to copy individual PTEs
>          */
> -       pmd = pmd_offset(pud, addr);
>         pmd_k = pmd_offset(pud_k, addr);
>         if (!pmd_present(*pmd_k)) {
>                 no_context(regs, addr);
>                 return;
>         }
> -       set_pmd(pmd, *pmd_k);
>
>         /*
>          * Make sure the actual PTE exists as well to

This looks good, but "Signed off by" lines are supposed to have real 
names associated with them and this looks like a handle to me.  There 
also seems to be something broken with the email, as this is causing git 
to blow up, but for a small patch like this that's OK as I can resurrect 
it by hand.

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com> # aside from the name

Please send a v2 with the proper Signed off by line, as that's not 
something I'm supposed to just fix up myself.

Thanks!
