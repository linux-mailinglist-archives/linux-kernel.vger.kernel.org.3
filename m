Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283D0544124
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 03:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbiFIBjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 21:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiFIBjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 21:39:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C709C1BF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 18:39:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70058B82BAE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:39:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CDEC3411F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654738776;
        bh=XrNFivstGcREotp/ejreDD8MYrzaaoJ1HDe+rHV6SiI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SO9yRAN+z/Wx/+RHafCFXpnTtQEjhI5cmYLqrKfZZ79PiJ27hYXyAEu2RAsPsYWrM
         w1r+NrnL3krC5y8F208gWHSvnsbZUZ3GU1mvIrDZhWVXWWNcODcUmkov0l13jviFlC
         vOTj48HGAZiJQPNxjXUxYNvQtTRilz+NJtVtns31+w2dxy+GvKuodXcErwKWADdbv+
         LzT4twV0kYGhieg9PoWQaBTrnRX2+82iKvI50r8zxczZ1OUX3rCLQgruYuW125423+
         29ciTLE12vPw5kLpVIefSt/0i15OH1qsXQtgfWzq5yt1hvszjUjR9N42syOLrmL2OV
         Y/5hU68y1ov0g==
Received: by mail-vk1-f180.google.com with SMTP id 140so1173842vky.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 18:39:36 -0700 (PDT)
X-Gm-Message-State: AOAM532h6COqvEH29hvtXf2hi2uMOO7dH1/KLOwHy5FwO+g1qzieLD4o
        HVYVcPakAeJG43xkkcGBQgOkk305omO6zuQD0/A=
X-Google-Smtp-Source: ABdhPJxl6MrvZBaZBkp2TXQkBzbGPPoQcmZjY6ux9wf7A5CXRZX0XwIDyj2z2t6RfyS7wnT5fvJeO1He/0YXZwhNfmk=
X-Received: by 2002:a1f:2093:0:b0:35e:21fb:1b65 with SMTP id
 g141-20020a1f2093000000b0035e21fb1b65mr7691636vkg.35.1654738775080; Wed, 08
 Jun 2022 18:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220608120849.1695191-1-heiko@sntech.de>
In-Reply-To: <20220608120849.1695191-1-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 9 Jun 2022 09:39:24 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT_xihu58V43bQ0X-WS0STCT5RNjiEHdwPBaoXmrnX2OA@mail.gmail.com>
Message-ID: <CAJF2gTT_xihu58V43bQ0X-WS0STCT5RNjiEHdwPBaoXmrnX2OA@mail.gmail.com>
Subject: Re: [PATCH] riscv: don't warn for sifive erratas in modules
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>, Ron Economos <re@w6rz.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 8:09 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> The SiFive errata code contains code checking applicable erratas
> vs. actually applied erratas to suggest missing erratas to the
> user when their Kconfig options are not enabled.
>
> In the main kernel image one can be quite sure that all available
> erratas appear at least once, so that check will succeed.
> On the other hand modules can very well not use any errata-relevant
> code, so the newly added module-alternative support may also patch
> the module code, but not touch SiFive-specific erratas at all.
>
> So to restore the original behaviour don't warn when patching
> modules. This will keep the warning if necessary for the main kernel
> image but prevent spurious warnings for modules.
>
> Of course having such a vendor-specific warning may not be needed at
> all, as CONFIG_ERRATA_SIFIVE is selected by CONFIG_SOC_SIFIVE and the
> individual erratas are default-y so disabling them requires
> deliberate action anyway. But for now just restore the old behaviour.
>
> Fixes: a8e910168bba ("riscv: implement module alternatives")
> Reported-by: Ron Economos <re@w6rz.net>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/errata/sifive/errata.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
> index 672f02b21ce0..1031038423e7 100644
> --- a/arch/riscv/errata/sifive/errata.c
> +++ b/arch/riscv/errata/sifive/errata.c
> @@ -111,6 +111,7 @@ void __init_or_module sifive_errata_patch_func(struct alt_entry *begin,
>                         cpu_apply_errata |= tmp;
>                 }
>         }
> -       if (cpu_apply_errata != cpu_req_errata)
> +       if (stage != RISCV_ALTERNATIVES_MODULE &&
> +           cpu_apply_errata != cpu_req_errata)
if (cpu_apply_errata &= ~cpu_req_errata)

Shall we still guarantee the module's must be a subset of the main kernel.'s?

>                 warn_miss_errata(cpu_req_errata - cpu_apply_errata);
>  }
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
