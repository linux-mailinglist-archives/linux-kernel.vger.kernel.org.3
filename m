Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B033E4C66C8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 11:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbiB1KEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 05:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbiB1KEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 05:04:50 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641E12C650
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 02:04:11 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id v21so14503639wrv.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 02:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yPvOIdycXQv0CBu7pmocJI7OMI66VIOa7x9qdeQslIs=;
        b=d53iGwE3xhZsK5rLeA1vM2S47Vce3tog6ZsY0kRQlxX6tRHqSOExJk2DZvxFv1ociQ
         21ui5eSo0k3AxTFOeZQ8c6RVK3YQeRrlv8J6iUxcqkMOoSKr2OvyofAaxJnxCK9mxaxc
         M9jKBHTJ6N/6ZAvzVqWgaUrkkujnLNznxJIzJDxCEsQ8Hwd3gdhY59hPP4oycPJyQZX1
         vFxwUWDwlst2nTwldyDYuLICAZll1WX1ce6qJAo61db967AgmAzskPZLcYbMDUaFAdCc
         OWlP3PT95GxVyeSza/8UCHWO++xGejdvdlKx4bYKm3JiIAMCvLx5Hi0HqUmSFS13yDru
         8+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yPvOIdycXQv0CBu7pmocJI7OMI66VIOa7x9qdeQslIs=;
        b=oPKd9iEsfUsMgXJMYTq1ZYedc/x0XerCvc8bPFudHYtG9Bs/5lHYFfIg4k9m9ci6YF
         H0mvAyLeYFyfOv+AfC8hsBhvYN8gvSMq8YzF8G9f2nlzrh7aPTBFx15NOWk68C35Usza
         SZCKWpejaTdTAwU2oSS9T4ay9jbLVknsNG34mDkYqZWlBBXFy73fQOQvnX40+fg0cKFU
         1lHOCaRB/UUILQlxIrHcLsMUvJwAoNi7vZBE5+5d0ZG8peBTZCgMeXkHDNcmFm08l8sh
         VfVj6Nhut9MycS747QtgEiGWUFgOCkEoLaRguZtEwF1eYDmNf+9ouGV260BfB0bu7Qks
         q7zg==
X-Gm-Message-State: AOAM532XzSS219UAlv+A0jLIQ0ueG540kFKmjHwcX4HqWqvvP6h8Rj6Z
        4HkMSsjLGCaNAHCaATd5z7+FwiiTOsOpn8yJL7EQpg==
X-Google-Smtp-Source: ABdhPJz+dwMIpoPKHtsSvMxSg9mYl/o51zxWOSIpNJCWK9SSTsShpG6/JXrk0EdmFjp7jJ9NsUjiI7CD6D9Hqp3R9Kk=
X-Received: by 2002:a5d:64a8:0:b0:1ef:f99c:8c12 with SMTP id
 m8-20020a5d64a8000000b001eff99c8c12mr174925wrp.214.1646042649763; Mon, 28 Feb
 2022 02:04:09 -0800 (PST)
MIME-Version: 1.0
References: <20220222204811.2281949-1-atishp@rivosinc.com> <20220222204811.2281949-4-atishp@rivosinc.com>
In-Reply-To: <20220222204811.2281949-4-atishp@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 28 Feb 2022 15:33:51 +0530
Message-ID: <CAAhSdy2STy3vniy_VjGOgaMLUj1En2rfCfENXUdRDZrBzmtgqg@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] RISC-V: Extract multi-letter extension names from
 "riscv, isa"
To:     Atish Patra <atishp@rivosinc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        DTML <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 2:18 AM Atish Patra <atishp@rivosinc.com> wrote:
>
> From: Tsukasa OI <research_trasio@irq.a4lg.com>
>
> Currently, there is no usage for version numbers in extensions as
> any ratified non base ISA extension will always at v1.0.
>
> Extract the extension names in place for future parsing.
>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Tsukasa OI <research_trasio@irq.a4lg.com>
> [Improved commit text and comments]
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/kernel/cpufeature.c | 35 ++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 72c5f6ef56b5..b0df7eff47f7 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -124,8 +124,28 @@ void __init riscv_fill_hwcap(void)
>                                 ext_long = true;
>                                 /* Multi-letter extension must be delimited */
>                                 for (; *isa && *isa != '_'; ++isa)
> -                                       if (!islower(*isa) && !isdigit(*isa))
> +                                       if (unlikely(!islower(*isa)
> +                                                    && !isdigit(*isa)))
>                                                 ext_err = true;
> +                               /* Parse backwards */
> +                               ext_end = isa;
> +                               if (unlikely(ext_err))
> +                                       break;
> +                               if (!isdigit(ext_end[-1]))
> +                                       break;
> +                               /* Skip the minor version */
> +                               while (isdigit(*--ext_end))
> +                                       ;
> +                               if (ext_end[0] != 'p'
> +                                   || !isdigit(ext_end[-1])) {
> +                                       /* Advance it to offset the pre-decrement */
> +                                       ++ext_end;
> +                                       break;
> +                               }
> +                               /* Skip the major version */
> +                               while (isdigit(*--ext_end))
> +                                       ;
> +                               ++ext_end;
>                                 break;
>                         default:
>                                 if (unlikely(!islower(*ext))) {
> @@ -151,14 +171,13 @@ void __init riscv_fill_hwcap(void)
>                         }
>                         if (*isa != '_')
>                                 --isa;
> -                       /*
> -                        * TODO: Full version-aware handling including
> -                        * multi-letter extensions will be added in-future.
> -                        */
> -                       if (ext_err || ext_long)
> +
> +                       if (unlikely(ext_err))
>                                 continue;
> -                       this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
> -                       this_isa |= (1UL << (*ext - 'a'));
> +                       if (!ext_long) {
> +                               this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
> +                               this_isa |= (1UL << (*ext - 'a'));
> +                       }
>                 }
>
>                 /*
> --
> 2.30.2
>
