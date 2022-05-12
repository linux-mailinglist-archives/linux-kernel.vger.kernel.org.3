Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22E85243E0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 06:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345952AbiELEI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 00:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiELEIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 00:08:12 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378371CC98C
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:08:08 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id r188-20020a1c44c5000000b003946c466c17so1719518wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 21:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GyMW7JKE5ri9UseraSETF0tOwJpGQyvrKdzSI8W/128=;
        b=m0wkWQXmzJubMmCCz3hb0dBvjSodoZ9dQEYU1IkfHAfvxK3OJVHUpU+yoYJBVnJxDJ
         7OmwhngCjmUyw0p79fkFhu5/hOx3+ItIrSrqmgZ2HZ3uGLyKsBPxmvY14JaG1+v7p63C
         5pNqUf95Fy9OVplO1h2hIvuiPVSrQ12ryf0D1e7Ex6veIDPHwIVYLZbLFBR04kKOMMK+
         NsflxS5PvtG9YuQOz4jXaMTTi9q+1a7YBKBmprZquPgeCgmEvybP4ON8ixUzc8d42qb/
         yICTaYvM9QmtCkAdcdfy8N41+RFnIUNaEVbSJ/66vvVLvjccI+2Z1Yl47VCpcO+o/6Jy
         em1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GyMW7JKE5ri9UseraSETF0tOwJpGQyvrKdzSI8W/128=;
        b=qY41qW8qFI9n0GgNlEkm445NbQ8dyCaCSl8Do8hu3HAsALlgAl7p+jrXFAqb6e5hBo
         u7X+MhdHbCqYYBiNXgFZvQ4oEilBkk2fjKcQVkzOLbcmoWUnpZJbAMPZX19qSNfB+EN/
         nkbw2FV+9F8lzAWBJiq07kf2GAg6ad8I7cHNZSUfDN9uKBL370FG/LamJO2V10PoBxTv
         QlLzJTVkPyUIC3IYdN3UV2l0SBAowaSUfMG2gcopasSTIg6DtIF9UvNR7MhTK57dtZVH
         VJHeZu7sRPJnN51S9/y7pOo4JioR0NV3+ZnluQZK04JXIlwyv+8bq3XEPpKjEWYjSbRN
         gP6A==
X-Gm-Message-State: AOAM530t4azQA2Regs0iAznKgrm2DP1uv58irS9sQgAGrM7E4M87F7RU
        Jum4mBRckVT1exOpRHGRnig/bTv/PEq6fCDlB8sRUQ==
X-Google-Smtp-Source: ABdhPJzSoWdXfBkndIBZoZOFwrpb7uDQjD1gAUcPFwN57z7F+LfwyMvq3mjZg+CNFRS8Bl4vV/eiaroxEfBg1N23Sko=
X-Received: by 2002:a05:600c:5113:b0:394:800c:4c36 with SMTP id
 o19-20020a05600c511300b00394800c4c36mr8028307wms.93.1652328486531; Wed, 11
 May 2022 21:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220511184408.2751850-1-masahiroy@kernel.org>
In-Reply-To: <20220511184408.2751850-1-masahiroy@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 12 May 2022 09:37:54 +0530
Message-ID: <CAAhSdy1XvMV02ye-+mZ-DewmmpQz+NZZb8HqRcxhssy=WBmNUA@mail.gmail.com>
Subject: Re: [PATCH] riscv: move errata/ and kvm/ builds to arch/riscv/Kbuild
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 12:17 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Commit 909548d6c578 ("riscv: add arch/riscv/Kbuild") intended that
> subdirectories in arch/riscv/ would be added in arch/riscv/Kbuild.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>
>  arch/riscv/Kbuild   | 2 ++
>  arch/riscv/Makefile | 3 ---
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/Kbuild b/arch/riscv/Kbuild
> index fb3397223d52..525ef2482253 100644
> --- a/arch/riscv/Kbuild
> +++ b/arch/riscv/Kbuild
> @@ -2,6 +2,8 @@
>
>  obj-y += kernel/ mm/ net/
>  obj-$(CONFIG_BUILTIN_DTB) += boot/dts/
> +obj-$(CONFIG_RISCV_ERRATA_ALTERNATIVE) += errata/
> +obj-$(CONFIG_KVM) += kvm/
>
>  # for cleaning
>  subdir- += boot
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 7d81102cffd4..fd9fda67c038 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -103,9 +103,6 @@ endif
>
>  head-y := arch/riscv/kernel/head.o
>
> -core-$(CONFIG_RISCV_ERRATA_ALTERNATIVE) += arch/riscv/errata/
> -core-$(CONFIG_KVM) += arch/riscv/kvm/
> -
>  libs-y += arch/riscv/lib/
>  libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>
> --
> 2.32.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
