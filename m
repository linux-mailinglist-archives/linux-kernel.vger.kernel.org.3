Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099E750AF44
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 06:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444004AbiDVE4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 00:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443528AbiDVE4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 00:56:02 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A561965A4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 21:53:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u3so9362617wrg.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 21:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqW1sJzlV4aSvanIKfDeQQY+sx3syjrs7XXIQkRWQtw=;
        b=ExaW9k1Vitir2nINZomSBatVKKgAReK/fsbXvrAbn5dB27O90V3mOmiO3YAOwCQbjQ
         KO5nRkXFQ2jkYtOGrCSAW2kHDHqTx+r4K7qW3xyoxlzKKHpKJj3C2mHxXPBXEjhfW05K
         VwN3yjyHJ62HDahQZqTeMjLhjF38r9RSs6KFHp2iHHfMF9J4gRozQr6M8wzL6caMHMg1
         pVfrKha+2YMwqqQn+cSK/cobq6zGK0HCRIgP93d48oGZUZxHzEjmJkKTiOlZ++2PKerr
         5dnVo7MhjEaLGiwzbJt1TbXG1MT28I3fQJv9yvaAZ+1NF7eZocbk5BHj0OeqG9yV02sb
         hGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqW1sJzlV4aSvanIKfDeQQY+sx3syjrs7XXIQkRWQtw=;
        b=ZPRnfPVfdWEEcLAOyvdqhufYuLCf0ybOoXbTk1Xvt0Z3dkwPvvDbPUTKwa1c7ecXPO
         CbjYDW2QqAMh+ZKOa01VrCLjRbfirZQYckZ1vpaau83s1yezkHwJIk/8D2RgqJS71gbN
         P+Jn7giAueEM+cZT2cApcSyG6TXL8WyyxvXqjsAi1yhJ0a/AV5pgGoe3a2e2ZzwG9ekq
         Ki5baTCpw0gjgJks436q/c8nWjdrQ8k7DB+HrgqhpadpBMMtd6Kzbw3u2pHu1JFI+vE0
         hLFipy3nSOizHlWI54XNDHKcqMyVG8+sqgt1JXqRzdeilSVn40EU0xPnXUOKxSFX8Png
         GawA==
X-Gm-Message-State: AOAM533+9rUv1gjrSpj4aoYJNI/MqaPBymGTMuG+31Q3REzSX3WHo6bG
        hZ2DVL1lr8QKm1+DS0lyHSCr46RxZY/vgGI1vtoxXw==
X-Google-Smtp-Source: ABdhPJwO8Ppu4TLD2X9dPtcPRS8bzrDXPNIiNgP5tsIUWjZSMW2c0vzfNNqDaJges1D52AHkvsKdSGVlgSzajGlMeIc=
X-Received: by 2002:adf:db86:0:b0:205:bccf:8cbf with SMTP id
 u6-20020adfdb86000000b00205bccf8cbfmr2055381wri.346.1650603188036; Thu, 21
 Apr 2022 21:53:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220421170354.10555-1-palmer@rivosinc.com>
In-Reply-To: <20220421170354.10555-1-palmer@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 22 Apr 2022 10:22:56 +0530
Message-ID: <CAAhSdy0QpShLVXhaT+meSvzkAkDzkG5SqHGbMa4wXdaG22KVWA@mail.gmail.com>
Subject: Re: [PATCH v1] RISC-V: Only default to spinwait on SBI-0.1 and M-mode
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 10:35 PM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> From: Palmer Dabbelt <palmer@rivosinc.com>
>
> The spinwait boot method has been superseeded by the SBI HSM extension
> for some time now, but it still enabled by default.  This causes some
> issues on large hart count systems, which will hang if a physical hart
> exists that is larger than NR_CPUS.
>
> Users on modern SBI implemenation don't need spinwait, and while it's
> probably possible to deal with some of the spinwait issues let's just
> restrict the default to systems that are likely to actually use it.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
> This seems to be the source of many of my new hangs when trying to test
> the NR_CPUS=512 support.  It's not really related, just fallout from
> testing different setups.
> ---
>  arch/riscv/Kconfig | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 00fd9c548f26..dd5e975abe37 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -359,7 +359,7 @@ config RISCV_SBI_V01
>  config RISCV_BOOT_SPINWAIT
>         bool "Spinwait booting method"
>         depends on SMP
> -       default y
> +       default y if RISCV_SBI_V01 || RISCV_M_MODE
>         help
>           This enables support for booting Linux via spinwait method. In the
>           spinwait method, all cores randomly jump to Linux. One of the cores
> @@ -370,6 +370,12 @@ config RISCV_BOOT_SPINWAIT
>           rely on ordered booting via SBI HSM extension which gets chosen
>           dynamically at runtime if the firmware supports it.
>
> +         Since spinwait is incompatible with sparse hart IDs, it requires
> +         NR_CPUS be large enough to contain the physical hart ID of the first
> +         hart to enter Linux.
> +
> +         If unsure what to do here, say N.
> +
>  config KEXEC
>         bool "Kexec system call"
>         select KEXEC_CORE
> --
> 2.34.1
>
