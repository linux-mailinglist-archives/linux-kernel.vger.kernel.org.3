Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319B250AA9F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiDUVTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441839AbiDUVTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:19:11 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94944C403
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:16:20 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2eba37104a2so66432687b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TBOLYdFLXPu73TVN7CymFowM0QIrUj97zla05FMsFmw=;
        b=X3/DiqjRlQU/pF0tYaTzm6xYDxBl9BJtrdHnRKE13u1Wz2URA7HF19ckJ4zY647Qvm
         6wTQcD6ddhubt2kFOzm9no+X1AlTHyHDDtrC9T6TSxQo4GUjadqSGOiqm1IoicWf53Wn
         sC2JBvaICqD2kCfdIapD1e7pAPqkl51MTFGVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TBOLYdFLXPu73TVN7CymFowM0QIrUj97zla05FMsFmw=;
        b=RsMtpURVNaxQq3xYybqr6ANsDmFbL9hX0sP+HH1VV/Ghdsiwvm9uWzcpXB8zTo2Txr
         Xab+8aHK+uneoMwKOQlpqJEV6PXN4bSiNnN7/zvkne+GxB96rpqQSh2nNJh8hHkig6AB
         TNmkT16TBOvYiLSfV3U1u+HTZIALxxtAamu7N2yhG6eJuFRbAfO//DFRZzAIbLk5m3T1
         /o4v/WhEFPJ1mKnmEJH+9ev3BmUxJsWkPtyhZBcxJv0lCUTb2YK24ADc/ZLagi8QUv9r
         423ZLgKAWF2or2sXgGM3QqErAW5PdLWHmDJ/Oyb0k/VNaQwfJTMAb3ncudSfIvQeQVWF
         uV+Q==
X-Gm-Message-State: AOAM532oKGf0Zoo6/Csb7TIQjfX3cx2NcMpcyCgdwztCsVXXF7Z6Irgy
        dPTDz3jp+AzIIwNZrJ6wF7E+S+dc8/mop04ZGO7g
X-Google-Smtp-Source: ABdhPJzFo0EHc3hgRUGRSf40BDuaLTDCUGRjMcvgkSfCbwsEa0mAJD3OVPnMyv3BFEcQCEs3N1OuASUGW0KklcABQmg=
X-Received: by 2002:a05:690c:16:b0:2db:cfed:de0e with SMTP id
 bc22-20020a05690c001600b002dbcfedde0emr1788900ywb.271.1650575780073; Thu, 21
 Apr 2022 14:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220421170354.10555-1-palmer@rivosinc.com>
In-Reply-To: <20220421170354.10555-1-palmer@rivosinc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 21 Apr 2022 14:16:09 -0700
Message-ID: <CAOnJCUJp3f2v_ZOy_YxrGOWu-E0k-NZMvDuiP4NykaT0H5nBrw@mail.gmail.com>
Subject: Re: [PATCH v1] RISC-V: Only default to spinwait on SBI-0.1 and M-mode
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 10:05 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
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


Reviewed-by: Atish Patra <atishp@rivosinc.com>


-- 
Regards,
Atish
