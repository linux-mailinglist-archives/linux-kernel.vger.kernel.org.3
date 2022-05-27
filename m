Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87245357DB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 04:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236574AbiE0Csc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 22:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiE0Csa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 22:48:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434C269CEC
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:48:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE8DD61D78
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08AEC3411B
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653619707;
        bh=lYtZ/6P5eMtzXk+deuEB2yU0KAz6cUfOhQlu+NizlJM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C4H5NOwaUqURMgxnWg+/u4j9dWb/33ZYM01ogjiBR/xZyouylvWSmCSNf3Zpx6YiG
         gyTdI846Y6UrkhJ9Jwcj4LHj2dVt1R/4OYFxQPwySDL8NFx3LUc2nmf4XyoH/RFiRW
         wmASHKCtSG+DrMB1tINmAQkJMmZxgUgyoEmatPsLkgZJ9ZFT9amhD8zjIQLvIL5scC
         Kcx0wHXRudIw5VILeaFhC2LeMgFma46n7XMOQpQuyPRBQoskqMbQZ/9y8xfYpYPtFR
         Mxv2dAnKJLj3ZPoLqaNaITP602Sz74HcILGDAk26ZHsrIxQvSuczWVfbYCKduoCj7y
         XU94AgD4DUG+Q==
Received: by mail-vs1-f47.google.com with SMTP id h4so3090393vsr.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 19:48:26 -0700 (PDT)
X-Gm-Message-State: AOAM532E/TL0lqssO2qeEWR5EQYJWOACu1sAeeHknHmuQcPPIjg91QuS
        8iJQDrSRrR/K/MJyC++8VsWF/Jp+9EyDkWqamnw=
X-Google-Smtp-Source: ABdhPJzcTwWBMG9c+TPVk9yGa3IRggU9hfJbCZvdgATbLXoJzJHGgt2WvBmsLK7Cop4ISYZgN5e+X5d53y3EWaseqr4=
X-Received: by 2002:a67:e046:0:b0:335:d1a2:6192 with SMTP id
 n6-20020a67e046000000b00335d1a26192mr16970483vsl.8.1653619705914; Thu, 26 May
 2022 19:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220526205646.258337-1-heiko@sntech.de> <20220526205646.258337-2-heiko@sntech.de>
In-Reply-To: <20220526205646.258337-2-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 27 May 2022 10:48:14 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQwT1hhOxqNYiV8ReQdq2xJSbxDeART0fiLLatSg+Yq+g@mail.gmail.com>
Message-ID: <CAJF2gTQwT1hhOxqNYiV8ReQdq2xJSbxDeART0fiLLatSg+Yq+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] riscv: drop cpufeature_apply_feature tracking variable
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>, Nick Kossifidis <mick@ics.forth.gr>,
        Samuel Holland <samuel@sholland.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Safe modification.

Reviewed-by: Guo Ren <guoren@kernel.org>

On Fri, May 27, 2022 at 4:57 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> The variable was tracking which feature patches got applied
> but that information was never actually used - and thus resulted
> in a warning as well.
>
> Drop the variable.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/kernel/cpufeature.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index dea3ea19deee..b33564df81e1 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -294,7 +294,6 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
>                                                   unsigned int stage)
>  {
>         u32 cpu_req_feature = cpufeature_probe(stage);
> -       u32 cpu_apply_feature = 0;
>         struct alt_entry *alt;
>         u32 tmp;
>
> @@ -308,10 +307,8 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
>                 }
>
>                 tmp = (1U << alt->errata_id);
> -               if (cpu_req_feature & tmp) {
> +               if (cpu_req_feature & tmp)
>                         patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
> -                       cpu_apply_feature |= tmp;
> -               }
>         }
>  }
>  #endif
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
