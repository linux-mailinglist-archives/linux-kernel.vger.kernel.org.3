Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D8E527DF1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240587AbiEPGzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240570AbiEPGzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:55:44 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460E6366A8
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:55:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7E743CE1101
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:55:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F5EC36AE7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652684136;
        bh=VqIRCv2LMNB0QFdFUt96jLC25HR73ExKxi3u86pjpWE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qru5duK8wRBYYrhrERVxr3VWex79J7Nw+63a7Aegi/amXc63tnm9Lnl4KH2VR3bjy
         WezbNMt1G3ZeDuJeUN2+cOU0TL/R6HOlmcxTmaym2uH5d7nEqmiFuLFs5R3zYD/ZHC
         qZBuX6hY8fYIHQ2h+E7Bam7Cbg+2mbGDswRhsloejAvGDtm1Ijkmni3pjg+Ejekgoh
         hhICXed1kIIujYIoqSN/DUaKtjlPo3QfCY6kKbQFiULvN8A4M3LIahmO7LwyjUB9U4
         qHCVxD0kFrldnbmhQoaYMf1nz9Eb/98f7rLlorzE3RdfteoYAMOlhaBzFaCP6+9kki
         oGHUU1S/6bIBg==
Received: by mail-ua1-f51.google.com with SMTP id ay15so5450314uab.9
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:55:36 -0700 (PDT)
X-Gm-Message-State: AOAM5319E2FSIiiiahVcJKqvPykBPSf5DjQw6thBBZzUHN1hcBuI0uP5
        /g7qDrwoKgtz+AaLooEjsi47PcWhw+vQEo/0MKU=
X-Google-Smtp-Source: ABdhPJxmtz2zRffn70WwdXZCEN/EtZzhyD5YAzH08JCQyLUCluirTTig9RHWjzPE9xvnfEBH+E790EU75vYagB1kBNc=
X-Received: by 2002:a9f:23c2:0:b0:365:958:e807 with SMTP id
 60-20020a9f23c2000000b003650958e807mr5603921uao.114.1652684135694; Sun, 15
 May 2022 23:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220511192921.2223629-1-heiko@sntech.de> <20220511192921.2223629-7-heiko@sntech.de>
In-Reply-To: <20220511192921.2223629-7-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 16 May 2022 14:55:24 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTDnqXKuEBGttN-1sJD9GH8Y5FLP2R5cpxnWnkfyqaFVA@mail.gmail.com>
Message-ID: <CAJF2gTTDnqXKuEBGttN-1sJD9GH8Y5FLP2R5cpxnWnkfyqaFVA@mail.gmail.com>
Subject: Re: [PATCH 06/12] riscv: prevent compressed instructions in alternatives
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>, liush <liush@allwinnertech.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Drew Fustini <drew@beagleboard.org>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        "Xinhaoqu (Freddie)" <xinhaoqu@huawei.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Thu, May 12, 2022 at 3:29 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Instructions are opportunistically compressed by the RISC-V assembler
> when possible, but in alternatives-blocks both the old and new content
> need to be the same size, so having the toolchain do somewhat random
> optimizations will cause strange side-effects like
> "attempt to move .org backwards" compile-time errors.
>
> Already a simple "and" used in alternatives assembly will cause these
> mismatched code sizes.
>
> So prevent compressed instructions to be generated in alternatives-
> code and use option-push and -pop to only limit this to the relevant
> code blocks
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
> ---
>  arch/riscv/include/asm/alternative-macros.h | 24 +++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
> index 8c2bbc7bbe50..e13b1f6bb400 100644
> --- a/arch/riscv/include/asm/alternative-macros.h
> +++ b/arch/riscv/include/asm/alternative-macros.h
> @@ -21,7 +21,11 @@
>         .popsection
>         .subsection 1
>  888 :
> +       .option push
> +       .option norvc
> +       .option norelax
>         \new_c
> +       .option pop
>  889 :
>         .previous
>         .org    . - (889b - 888b) + (887b - 886b)
> @@ -31,7 +35,11 @@
>
>  .macro __ALTERNATIVE_CFG old_c, new_c, vendor_id, errata_id, enable
>  886 :
> +       .option push
> +       .option norvc
> +       .option norelax
>         \old_c
> +       .option pop
>  887 :
>         ALT_NEW_CONTENT \vendor_id, \errata_id, \enable, \new_c
>  .endm
> @@ -42,7 +50,11 @@
>  .macro __ALTERNATIVE_CFG_2 old_c, new_c_1, vendor_id_1, errata_id_1, enable_1, \
>                                   new_c_2, vendor_id_2, errata_id_2, enable_2
>  886 :
> +       .option push
> +       .option norvc
> +       .option norelax
>         \old_c
> +       .option pop
>  887 :
>         ALT_NEW_CONTENT \vendor_id_1, \errata_id_1, \enable_1, \new_c_1
>         ALT_NEW_CONTENT \vendor_id_2, \errata_id_2, \enable_2, \new_c_2
> @@ -76,7 +88,11 @@
>         ".popsection\n"                                                 \
>         ".subsection 1\n"                                               \
>         "888 :\n"                                                       \
> +       ".option push\n"                                                \
> +       ".option norvc\n"                                               \
> +       ".option norelax\n"                                             \
>         new_c "\n"                                                      \
> +       ".option pop\n"                                                 \
>         "889 :\n"                                                       \
>         ".previous\n"                                                   \
>         ".org   . - (887b - 886b) + (889b - 888b)\n"                    \
> @@ -85,7 +101,11 @@
>
>  #define __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, enable)  \
>         "886 :\n"                                                       \
> +       ".option push\n"                                                \
> +       ".option norvc\n"                                               \
> +       ".option norelax\n"                                             \
>         old_c "\n"                                                      \
> +       ".option pop\n"                                                 \
>         "887 :\n"                                                       \
>         ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
>
> @@ -97,7 +117,11 @@
>                                    new_c_2, vendor_id_2, errata_id_2,   \
>                                         enable_2)                       \
>         "886 :\n"                                                       \
> +       ".option push\n"                                                \
> +       ".option norvc\n"                                               \
> +       ".option norelax\n"                                             \
>         old_c "\n"                                                      \
> +       ".option pop\n"                                                 \
>         "887 :\n"                                                       \
>         ALT_NEW_CONTENT(vendor_id_1, errata_id_1, enable_1, new_c_1)    \
>         ALT_NEW_CONTENT(vendor_id_2, errata_id_2, enable_2, new_c_2)
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
