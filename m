Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64215301D3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 10:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241387AbiEVIVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 04:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiEVIVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 04:21:34 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9C51B79B
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 01:21:33 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2ff1ed64f82so121805247b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 01:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Znw7LJlbn1r+wdsACS1F0N9XbG/RiiVDOXyDXO5CsQE=;
        b=oI5Lsg53Bix9/s98Dk6RwCbWEJtDNIO6hHRev5nvmxWVtypqgkp09ZLZmxl7WuChR8
         LdcdeJwLgDHQzEW1HEq/uwiQpgs5NECaDSRup/YaGHZ6YCWvsXWwVsF/PB/1Oka6zHVa
         0F5wghO4TAWAr6ItAuRaO3TLHmMzJKFmnWskQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Znw7LJlbn1r+wdsACS1F0N9XbG/RiiVDOXyDXO5CsQE=;
        b=yAbMdq3jErelaPV7l7D+nv/3i1U5TUbiN7CPVxgJvqjnGbW3AcQeSj4c5GPkntiBx+
         qbGw62olCBciGagLvAub7XcnHKZFn4M/k/SgpZIGTq/5lEEKyUaJ289SZCWQR6iz9UPU
         uGuB07J1Z6fGmBRHQ+H0fwDtTsySNHcPDgb3YJOTaUz9OSY5olkOoXpHZMRTImqsmeIW
         36u6C5jDRaRRHVDoGlrMXyKxb5QHv7Y1NjYe4SkW37WLKL//ziWvayU/pTcoZleVTYdp
         mwGzc+5PS2beR/2wOXA78zLoA/YIIGaUT6v+0yCopqz31f4sWo4etTYQQMBTyqrGdl81
         CvKw==
X-Gm-Message-State: AOAM533ezYm7S/l4OSCeRyf5Wjg43nbTcBIFZ6yXaR3BpwJwxxckybrQ
        eEOcib4+l0FSWi+EepqQWIYQlKOxxVidmcEkodau
X-Google-Smtp-Source: ABdhPJzPUEYEU781zCIU9/dh8A2Evos/v/c0AEiyTU81BdY0IPzvjMDDVTC7tJgmrtM8d3WDf0TgxCnJdVQPY8Dh8N0=
X-Received: by 2002:a81:8494:0:b0:2fe:ff73:cdb7 with SMTP id
 u142-20020a818494000000b002feff73cdb7mr17834758ywf.373.1653207692599; Sun, 22
 May 2022 01:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220516143204.2603-1-jszhang@kernel.org>
In-Reply-To: <20220516143204.2603-1-jszhang@kernel.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Sun, 22 May 2022 01:21:21 -0700
Message-ID: <CAOnJCUJcEiRMKj7=77qnE8RpGmWnJALNhCTaeTo2rb9-NqEpZg@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: mm: init: make pt_ops_set_[early|late|fixmap] static
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 7:41 AM Jisheng Zhang <jszhang@kernel.org> wrote:
>
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
>         pt_ops.alloc_pte = alloc_pte_early;
>         pt_ops.get_pte_virt = get_pte_virt_early;
> @@ -871,7 +871,7 @@ void __init pt_ops_set_early(void)
>   * Note that this is called with MMU disabled, hence kernel_mapping_pa_to_va,
>   * but it will be used as described above.
>   */
> -void __init pt_ops_set_fixmap(void)
> +static void __init pt_ops_set_fixmap(void)
>  {
>         pt_ops.alloc_pte = kernel_mapping_pa_to_va((uintptr_t)alloc_pte_fixmap);
>         pt_ops.get_pte_virt = kernel_mapping_pa_to_va((uintptr_t)get_pte_virt_fixmap);
> @@ -889,7 +889,7 @@ void __init pt_ops_set_fixmap(void)
>   * MMU is enabled and page table setup is complete, so from now, we can use
>   * generic page allocation functions to setup page table.
>   */
> -void __init pt_ops_set_late(void)
> +static void __init pt_ops_set_late(void)
>  {
>         pt_ops.alloc_pte = alloc_pte_late;
>         pt_ops.get_pte_virt = get_pte_virt_late;
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


Reviewed-by: Atish Patra <atishp@rivosinc.com>

-- 
Regards,
Atish
