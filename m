Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CB75AA4D9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 03:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbiIBBGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 21:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbiIBBGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 21:06:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B816AA1A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 18:06:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D4B461AA6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39EDC43143
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662080777;
        bh=Prz6huqpGc3sAjiqIyxG23zXRVYhVNAPIq+MFkac75s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=usGfjgRfCP5QtD04dEK0BvZ/Rzto8p8E3Yi5lsxT5snV5ib1pFvEkTaFJrSXzDHAV
         vwgW77mUDWFrbpz/kOQt4HaSizRbPYqDle0p6jTPysOP7Ey/gHfrP6xWRYoQDmOSXU
         Fle+WOhd7FSGyp+L/QH2SsNzgjG6n2tvD+eoUavMI3ZOPz/VVdjAxNm9HzuzjRXSqX
         5IitQGhIbxu7rYYPNy1EM7Z3dmhN2pyZ3KuzJ9shpWTj9+vCr+uq12HbQIJ7KCH5Gn
         Xu3H+nnjeLr6B5tW6VT81y7+JEwKFhhdH1VQZyzHeL9t3JuC0btl7BsSMFLpCOgT0G
         sahDWMa9Q8Exg==
Received: by mail-oo1-f45.google.com with SMTP id p48-20020a4a95f3000000b0044b0f5a8d17so152846ooi.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 18:06:17 -0700 (PDT)
X-Gm-Message-State: ACgBeo3IIjoE9/isWjKHCOkv5HD0pNjZH15PL4BT8Q0GA5Sjjy9EeiM/
        d/S1GYnGANPaDcjPS/rOKBtWyl9dduY8h9f2H2M=
X-Google-Smtp-Source: AA6agR5NqMItBdtvXB9BAykCDEdumC+b8gYuo70Xd3IgiIerOP5apbw/FOpVDrXRHQxS/id91QvEzMzE/nUYZor5uQ8=
X-Received: by 2002:a4a:dc93:0:b0:44b:6d0:c4a8 with SMTP id
 g19-20020a4adc93000000b0044b06d0c4a8mr11496804oou.48.1662080776979; Thu, 01
 Sep 2022 18:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220901222744.2210215-1-heiko@sntech.de> <20220901222744.2210215-3-heiko@sntech.de>
In-Reply-To: <20220901222744.2210215-3-heiko@sntech.de>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 2 Sep 2022 09:06:05 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTYFWk0T7kbiURaMc_QO4O=sjdFFjOxnaxGApuMYsopZw@mail.gmail.com>
Message-ID: <CAJF2gTTYFWk0T7kbiURaMc_QO4O=sjdFFjOxnaxGApuMYsopZw@mail.gmail.com>
Subject: Re: [PATCH 3/4] riscv: use BIT macros in t-head errata init
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, conor.dooley@microchip.com,
        apatel@ventanamicro.com, atishp@rivosinc.com,
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

Reviewed-by: Guo Ren <guoren@kernel.org>

On Fri, Sep 2, 2022 at 6:28 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Using the appropriate BIT macro makes the code better readable.
>
> Suggested-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  arch/riscv/errata/thead/errata.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index bffa711aaf64..a6f4bd8ccf3f 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -49,10 +49,10 @@ static u32 thead_errata_probe(unsigned int stage,
>         u32 cpu_req_errata = 0;
>
>         if (errata_probe_pbmt(stage, archid, impid))
> -               cpu_req_errata |= (1U << ERRATA_THEAD_PBMT);
> +               cpu_req_errata |= BIT(ERRATA_THEAD_PBMT);
>
>         if (errata_probe_cmo(stage, archid, impid))
> -               cpu_req_errata |= (1U << ERRATA_THEAD_CMO);
> +               cpu_req_errata |= BIT(ERRATA_THEAD_CMO);
>
>         return cpu_req_errata;
>  }
> --
> 2.35.1
>


-- 
Best Regards
 Guo Ren
