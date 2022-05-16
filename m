Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66AF527DEA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbiEPGzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240573AbiEPGzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:55:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE88366B1
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:55:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E71B9B80B55
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:55:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2AEAC341C5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652684112;
        bh=wiA8FGI75YrhJytAH6LfccFoNYeTu2gqXP2d9q68wmE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QBcl4ClJ6DSsqgG12TPkgIFLpZdex++xIZWM/ijBVeyIPLm7SFadVpGwPs6jFVfwS
         f+K1Qe3VdyFNR+1ajdzAmUmUJ3rhTV67Wk16lBjlTGu/ichk+GFD3Yv48lDvDT0ncD
         dewzk5kehdxZa3Gk9WEB0NIwks73bRUkPSArzey4aW/ZM/MHqlGwQcJHNPq3JBTEEh
         edMNohwGZeiaynqVgSqz30fjAb5VYdtOP3jw8XONk9XiAWr0A/yxBgfRbB7TrHMhxf
         hy6SVauBONMj33MHJtv8NIHf2+GKhZZKWi6myEWcQAgNkN3m6x+m5CbwG9H/nEwxvX
         uh6eKoA4os53Q==
Received: by mail-vs1-f49.google.com with SMTP id w124so14521096vsb.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:55:12 -0700 (PDT)
X-Gm-Message-State: AOAM530B/LbICDBnmVD1C/xMwZF+r51mK/oO0B5zuWeQRaWIPzjU9nMN
        HKEO659+++19tKySACWJ2NLfwg6/BwCX1dhIrzo=
X-Google-Smtp-Source: ABdhPJxqZd+B6RKf18XydNXla4kQ0DeUyoAzG1PpmIb+sedlMpCmC9EXBvzh4A5Oqa7KT0dW2lW6LBCsjdOZBV2BUBo=
X-Received: by 2002:a05:6102:390b:b0:32d:5fc3:bd2c with SMTP id
 e11-20020a056102390b00b0032d5fc3bd2cmr5079622vsu.51.1652684111598; Sun, 15
 May 2022 23:55:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220511192921.2223629-1-heiko@sntech.de> <20220511192921.2223629-6-heiko@sntech.de>
In-Reply-To: <20220511192921.2223629-6-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 16 May 2022 14:55:00 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR7WXDNfvxYaSsTaqjinyRBfQsfz+C7HvtKh4qyviFf6w@mail.gmail.com>
Message-ID: <CAJF2gTR7WXDNfvxYaSsTaqjinyRBfQsfz+C7HvtKh4qyviFf6w@mail.gmail.com>
Subject: Re: [PATCH 05/12] riscv: extend concatenated alternatives-lines to
 the same length
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
> ALT_NEW_CONTENT already uses same-length assembler lines, so
> extend this to the other elements as well.
>
> This makes it more readable when these elements need to be extended
> in the future.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
> ---
>  arch/riscv/include/asm/alternative-macros.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
> index 9e04cd53afc8..8c2bbc7bbe50 100644
> --- a/arch/riscv/include/asm/alternative-macros.h
> +++ b/arch/riscv/include/asm/alternative-macros.h
> @@ -62,14 +62,14 @@
>  #include <asm/asm.h>
>  #include <linux/stringify.h>
>
> -#define ALT_ENTRY(oldptr, newptr, vendor_id, errata_id, newlen) \
> -       RISCV_PTR " " oldptr "\n" \
> -       RISCV_PTR " " newptr "\n" \
> -       REG_ASM " " vendor_id "\n" \
> -       REG_ASM " " newlen "\n" \
> +#define ALT_ENTRY(oldptr, newptr, vendor_id, errata_id, newlen)                \
> +       RISCV_PTR " " oldptr "\n"                                       \
> +       RISCV_PTR " " newptr "\n"                                       \
> +       REG_ASM " " vendor_id "\n"                                      \
> +       REG_ASM " " newlen "\n"                                         \
>         ".word " errata_id "\n"
>
> -#define ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c) \
> +#define ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)           \
>         ".if " __stringify(enable) " == 1\n"                            \
>         ".pushsection .alternative, \"a\"\n"                            \
>         ALT_ENTRY("886b", "888f", __stringify(vendor_id), __stringify(errata_id), "889f - 888f") \
> @@ -83,10 +83,10 @@
>         ".org   . - (889b - 888b) + (887b - 886b)\n"                    \
>         ".endif\n"
>
> -#define __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, enable) \
> -       "886 :\n"       \
> -       old_c "\n"      \
> -       "887 :\n"       \
> +#define __ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, enable)  \
> +       "886 :\n"                                                       \
> +       old_c "\n"                                                      \
> +       "887 :\n"                                                       \
>         ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)
>
>  #define _ALTERNATIVE_CFG(old_c, new_c, vendor_id, errata_id, CONFIG_k) \
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
