Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F75557687
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiFWJWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiFWJWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:22:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0F74706A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:22:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AABB61DA3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B20BC341C0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 09:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655976168;
        bh=noa0LflmElsINLkxkDjBwmgwa2qGfzyqGoF65Sy3oKs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qknkBtEZCgJLSC6x1SYArQmkXFkoh1LvUGHeQ+R6d0fXgTLKG7NOFEwhvL7d1mLF9
         uCQZr0n+XstzUyFvQnOCZRrLseey+s+Q4EVEA8bvmDYkn2mjhabAong4Pg3y+tTPcm
         UmgSpJZIsAL4KDVarLrskwWDc7HYcoBzGDHR8Lg/QFbKt5rRh2LUNsp/ur5jalBGOE
         ZK4OYsGZ6jvdyndDO7Glb6wP27Q27Vh/KJUAC05Bh2Jake5cN7ehKppN7mNUtRyXCZ
         D/rsYlbum/OPSpIOePkBU/zrj6KbtMeZmc/FEB3OXp/FaKJvF3hz/n2LxkgmtjIvzr
         zPRYLuhJDuuxg==
Received: by mail-lj1-f177.google.com with SMTP id g12so16475216ljk.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:22:47 -0700 (PDT)
X-Gm-Message-State: AJIora/SRGN0X164qnUTiFw7zFUWTixz8BF9bsKoKTPnOBOBVsxgbVXu
        OR4ohaw8OrfLhoeN8z+MtOVUqNPaqVfKmBfmqhc=
X-Google-Smtp-Source: AGRyM1vj9wdD8YDfB5HfPDhcFdoxmqaQPAsCeGYbK94WaLVDcNpvpPLcOHcHhNthDsoPINx0uld3Q6BY6+7rULU5Acc=
X-Received: by 2002:a05:651c:548:b0:25a:700e:ccfc with SMTP id
 q8-20020a05651c054800b0025a700eccfcmr4180404ljp.224.1655976165987; Thu, 23
 Jun 2022 02:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <1655527831-3661-1-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1655527831-3661-1-git-send-email-yangtiezhu@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 23 Jun 2022 17:22:33 +0800
X-Gmail-Original-Message-ID: <CAAhV-H59NVPiBoLX0Ok61tDQZA-=jphK7ZYsW8i2OTzURGFq9w@mail.gmail.com>
Message-ID: <CAAhV-H59NVPiBoLX0Ok61tDQZA-=jphK7ZYsW8i2OTzURGFq9w@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix wrong fpu version
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     WANG Xuerui <kernel@xen0n.name>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tiezhu,

On Sat, Jun 18, 2022 at 12:50 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> According to the configuration information accessible by the CPUCFG
> instruction in LoongArch Reference Manual [1], FP_ver is stored in
> bit [5: 3] of CPUCFG2, the current code to get fpu version is wrong,
> use CPUCFG2_FPVERS to fix it.
>
> [1] https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html
>
> Fixes: 628c3bb40e9a ("LoongArch: Add boot and setup routines")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/kernel/cpu-probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/cpu-probe.c b/arch/loongarch/kernel/cpu-probe.c
> index 6c87ea3..529ab8f4 100644
> --- a/arch/loongarch/kernel/cpu-probe.c
> +++ b/arch/loongarch/kernel/cpu-probe.c
> @@ -263,7 +263,7 @@ void cpu_probe(void)
>
>         c->cputype      = CPU_UNKNOWN;
>         c->processor_id = read_cpucfg(LOONGARCH_CPUCFG0);
> -       c->fpu_vers     = (read_cpucfg(LOONGARCH_CPUCFG2) >> 3) & 0x3;
> +       c->fpu_vers     = (read_cpucfg(LOONGARCH_CPUCFG2) & CPUCFG2_FPVERS) >> 3;
Looks good to me, thanks.

Huacai
>
>         c->fpu_csr0     = FPU_CSR_RN;
>         c->fpu_mask     = FPU_CSR_RSVD;
> --
> 2.1.0
>
