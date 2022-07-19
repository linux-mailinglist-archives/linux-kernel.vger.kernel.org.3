Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B18657A445
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiGSQjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiGSQjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:39:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931F445043
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:39:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CBC3B81C0A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 16:39:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114C9C341C6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 16:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658248784;
        bh=0W/QCIeJd/PTxapDGvllkrZS/++cW7WMKwFqOsxn48A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h1/TR9XC0U9T6KEybM7/vYJRPkl3WNGPVrjZ/PrEsMGeQQE6EodjPK5Dqz0a/YiZI
         +gO8J/yVtI51Q9rRyx7eQKiEhdE33c52waKA+LfyMeOuGvZoYePJ9m5WPnQJZ3vHYd
         I257gq5tQKJH8gZQsy/r3zn/bt7rK7VeTf0Ct7BVTV5wmXCQrth6WG2e2ynSp2eHTn
         PrxP+uMK6+F/mrQu9Kz1RmYh2sUVlIJ9rSbvcQhv2r4OqDtBTSB3ZJTJuhnKjfbwjN
         cmE8haYiMpHIVYxDpdartSFYDx3G3tjSzEL/8LFI8ZBQp8PghliTBa8nkRNZc65Z1o
         cz9lOmZ6whnpg==
Received: by mail-lf1-f46.google.com with SMTP id d12so25755239lfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:39:43 -0700 (PDT)
X-Gm-Message-State: AJIora/T3Sq/CM5/H08yOeOacVReeDNi6Z5JZzCZj+akkUtwMAzT8s/r
        MPQHqByqAM1Xvvc65Wa9SspR4U6HMLr/dotfBJI=
X-Google-Smtp-Source: AGRyM1tGlEoLlq0vaN8ZQ4Lwp/heWhD5P5eOt1OBUNKhi09KvhnPgIo5SDU3upZxUXCqkMIafVH1GEvqUxYDj6kPEbs=
X-Received: by 2002:a19:9101:0:b0:489:4f34:8c29 with SMTP id
 t1-20020a199101000000b004894f348c29mr16699932lfd.620.1658248782077; Tue, 19
 Jul 2022 09:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220719132400.75407-1-emil.renner.berthing@canonical.com>
In-Reply-To: <20220719132400.75407-1-emil.renner.berthing@canonical.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 20 Jul 2022 00:39:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQW8BJKjnku8nSCTk5Ann8AdRde_g7fqA8d6GDd2MnAYg@mail.gmail.com>
Message-ID: <CAJF2gTQW8BJKjnku8nSCTk5Ann8AdRde_g7fqA8d6GDd2MnAYg@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: compat: vdso: Fix vdso_install target
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

@Palmer Dabbelt
Please have a look at the patch which fixes up the "make vdso_install"
problem. I recommend it could be fixed in 5.19.

On Tue, Jul 19, 2022 at 9:24 PM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
>
> When CONFIG_COMPAT=y the vdso_install target fails:
>
> $ make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- vdso_install
>   INSTALL vdso.so
> make[1]: *** No rule to make target 'vdso_install'.  Stop.
> make: *** [arch/riscv/Makefile:112: vdso_install] Error 2
>
> The problem is that arch/riscv/kernel/compat_vdso/Makefile doesn't
> have a vdso_install target, but instead calls it compat_vdso_install.
>
> Fixes: 0715372a06ce ("riscv: compat: vdso: Add COMPAT_VDSO base code implementation")
> Reported-by: Ben Hutchings <ben@decadent.org.uk>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> ---
> v2: Add Fixes and Reported-by tags
>
>  arch/riscv/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 34cf8a598617..5cfbef613e34 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -110,7 +110,7 @@ PHONY += vdso_install
>  vdso_install:
>         $(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso $@
>         $(if $(CONFIG_COMPAT),$(Q)$(MAKE) \
> -               $(build)=arch/riscv/kernel/compat_vdso $@)
> +               $(build)=arch/riscv/kernel/compat_vdso compat_$@)
>
>  ifeq ($(KBUILD_EXTMOD),)
>  ifeq ($(CONFIG_MMU),y)
> --
> 2.37.1
>


-- 
Best Regards
 Guo Ren
