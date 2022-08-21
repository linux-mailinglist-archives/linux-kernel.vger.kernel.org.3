Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AAD59B47F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 16:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiHUOiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 10:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHUOiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 10:38:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74B91DA6E
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 07:38:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 66450CE098B
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 14:38:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CF4C433B5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 14:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661092686;
        bh=eUoxZaV850V7I73F63glT/eaPAo9OplEnZdMkKkslSM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EJlKZKCtPKg+cXb7k/9Kaen+hy/daM+dup7Wc/aGisTvKGB8lQLOV4hfg91unD7Lk
         pT08Ibryy6s9Bn5M4KnjxbMJPg79PMHEUFIkQESSb08twLVZWUri5BxAY0+LB+a0QH
         OHhgBl2+S55C7ad7enraI+tRVXDiRWMR++8dd7/YkEU+F4AeqQvvK1lv5suyaR+UBG
         1HM3oDqXHXQlkF3LYRGJATJCY84Yn49rK1RGfbmTSS3uQMGhMYp5JxJi238pcIHoTr
         F96nRUkI+wfBPLdjPXSpAMljHYdh3OOncGpvv/oX7alG/GTdlxu9widC5cpwR3ljy+
         oU2rNGDFhw8ag==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-11c4d7d4683so10116025fac.8
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 07:38:06 -0700 (PDT)
X-Gm-Message-State: ACgBeo0CMTyvkyJqQCMjLw4xlN/gnK3kCgZK9AWHgVfJL81u0IbuRdiR
        uGA4SfDFD837jHExwiIXv0GHDBerhgQKt07/uRA=
X-Google-Smtp-Source: AA6agR4z+NpywmulN5IWHAE4YVRoE8nrcwnBsgi3VC8DYGMO28oU9w1dHLnzLAfHtwke5YO4pyyFtGCDxKoWTeeNanY=
X-Received: by 2002:a05:6870:c596:b0:101:6409:ae62 with SMTP id
 ba22-20020a056870c59600b001016409ae62mr10627308oab.112.1661092685876; Sun, 21
 Aug 2022 07:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220821141819.3804-1-jszhang@kernel.org>
In-Reply-To: <20220821141819.3804-1-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 21 Aug 2022 22:37:53 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTTWP1sWmYgUgJnqwkOhB9F_wOPTGywucvXbjZdrcHdHQ@mail.gmail.com>
Message-ID: <CAJF2gTTTWP1sWmYgUgJnqwkOhB9F_wOPTGywucvXbjZdrcHdHQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: compat: s/failed/unsupported if compat mode isn't supported
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 21, 2022 at 10:27 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> When compat mode isn't supported(I believe this is the most case now),
> kernel will emit somthing as:
> [    0.050407] riscv: ELF compat mode failed
>
> This msg may make users think there's something wrong with the kernel
> itself, replace "failed" with "unsupported" to make it clear. In fact
Acked-by: Guo Ren <guoren@kernel.org>

> this is the real compat_mode_supported meaning. After the patch, the
> msg would be:
> [    0.050407] riscv: ELF compat mode unsupported
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/process.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index ceb9ebab6558..b0c63e8e867e 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -105,7 +105,7 @@ static int __init compat_mode_detect(void)
>         csr_write(CSR_STATUS, tmp);
>
>         pr_info("riscv: ELF compat mode %s",
> -                       compat_mode_supported ? "supported" : "failed");
> +                       compat_mode_supported ? "supported" : "unsupported");
>
>         return 0;
>  }
> --
> 2.34.1
>


-- 
Best Regards
 Guo Ren
