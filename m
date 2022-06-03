Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827B653C23D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240896AbiFCBeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 21:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236587AbiFCBem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 21:34:42 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B403336D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 18:34:41 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id x12so6115416pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 18:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Gm53BT7MDI0h04lUx/Z9qg/q0JdibF254ksd3FSQzS0=;
        b=RihMf5zvQKoxS3UikQN41JNEW5ejVZG1gzhMmEhfJ99jOAB1zQeWutzq5DZRWl/S5c
         Y98wCrxW2sf/LSckrraDaWgERlqSJ+HGWDLjrOP0iPb9cM3Mw3yjUS0U4BmRUEaL1KCz
         6yBPZxxjJQ26aCqySHaPGfyMHPsk1+Hm99Nn/iJa2tRVDtozwH9Jg4pNs5p3cczNKzPP
         xeopEMW6ozdmHNexHZyG9nA28ov7suqGNcC7cBeb+9L3so48G4J20Qq+MsZG+6gRNb2S
         VC0Sd94otPff43edaASoc86nDVQTcFjPLmCn816CQQ4VNY4zBvtCqFxmhFXf3TGy9TE1
         RTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Gm53BT7MDI0h04lUx/Z9qg/q0JdibF254ksd3FSQzS0=;
        b=1pxkzQiB3KUlO6k0TIn17WBWEFvJKPLpORsUw8lzu6ZguxkF1MlOJ99wXDVsimKa/1
         wjixls8flEjajp51Ko0SyChq+tcenCGVD0w52YysQAtnx0K+v6EOvrgBoFXCRpw/Yg/W
         8qQ5GIYslK5xD5o24Ifgmwull4FOXdfNTgBGCn1zx8Zfm2pOaGmwbdTiLBP7rcbGhy0G
         5NBtxhH3jy2Tu7LqCp0hOI2fHkL/ND6H9vh0JQHbiMshAG4Avlp9Cu1yu3De3QI5IOJt
         irZNI8FW1SNr6pcoMoVTYs2a0CXmCRss6j9qJztBA2P9QTmfyQL08vmYQlweQ/XtGqe7
         fp3Q==
X-Gm-Message-State: AOAM533iKxHf6H/x9CrzGsisQY5dzCNcFPaBXnb/9uNXLzEBNoM7a9xb
        VypPTh8ffGVbElXkUZSSP+QAEQ==
X-Google-Smtp-Source: ABdhPJz0q60A75VG204nrUdMksgumztgNgvXrccsvB2/VYrODvIYn1XTipjVkGeblMZiDbgoYbphvQ==
X-Received: by 2002:a63:84c3:0:b0:3fc:8c46:2447 with SMTP id k186-20020a6384c3000000b003fc8c462447mr6554374pgd.285.1654220080533;
        Thu, 02 Jun 2022 18:34:40 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id k1-20020a17090a590100b001e33e264fd6sm3892645pji.40.2022.06.02.18.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 18:34:39 -0700 (PDT)
Date:   Thu, 02 Jun 2022 18:34:39 -0700 (PDT)
X-Google-Original-Date: Thu, 02 Jun 2022 15:54:05 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: mm: init: make pt_ops_set_[early|late|fixmap] static
In-Reply-To: <20220516143204.2603-1-jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang@kernel.org
Message-ID: <mhng-6828d6a5-d8c6-43f7-8145-311bdd5188d1@palmer-ri-x1c9>
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

On Mon, 16 May 2022 07:32:04 PDT (-0700), jszhang@kernel.org wrote:
> These three functions are only used in init.c, so make them static.
> Fix W=1 warnings like below:
>
> arch/riscv/mm/init.c:721:13: warning: no previous prototype for function
> 'pt_ops_set_early' [-Wmissing-prototypes]
>    void __init pt_ops_set_early(void)
>                ^
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---
>
> since v1:
>  - collect Reviewed-by tag
>  - move out from the static key series as a separate patch
>
>  arch/riscv/mm/init.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 05ed641a1134..5f3f26dd9f21 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -849,7 +849,7 @@ static void __init create_fdt_early_page_table(pgd_t *pgdir, uintptr_t dtb_pa)
>   * MMU is not enabled, the page tables are allocated directly using
>   * early_pmd/pud/p4d and the address returned is the physical one.
>   */
> -void __init pt_ops_set_early(void)
> +static void __init pt_ops_set_early(void)
>  {
>  	pt_ops.alloc_pte = alloc_pte_early;
>  	pt_ops.get_pte_virt = get_pte_virt_early;
> @@ -871,7 +871,7 @@ void __init pt_ops_set_early(void)
>   * Note that this is called with MMU disabled, hence kernel_mapping_pa_to_va,
>   * but it will be used as described above.
>   */
> -void __init pt_ops_set_fixmap(void)
> +static void __init pt_ops_set_fixmap(void)
>  {
>  	pt_ops.alloc_pte = kernel_mapping_pa_to_va((uintptr_t)alloc_pte_fixmap);
>  	pt_ops.get_pte_virt = kernel_mapping_pa_to_va((uintptr_t)get_pte_virt_fixmap);
> @@ -889,7 +889,7 @@ void __init pt_ops_set_fixmap(void)
>   * MMU is enabled and page table setup is complete, so from now, we can use
>   * generic page allocation functions to setup page table.
>   */
> -void __init pt_ops_set_late(void)
> +static void __init pt_ops_set_late(void)
>  {
>  	pt_ops.alloc_pte = alloc_pte_late;
>  	pt_ops.get_pte_virt = get_pte_virt_late;

Thanks, this is on for-next.
