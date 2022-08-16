Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B6E59661B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 01:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbiHPXmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 19:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiHPXmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 19:42:00 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3B18A6FA
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 16:41:58 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-333b049f231so79698907b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 16:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=UsDhizeqwqVetBtxTd5HgodBbkJnkh0ltjiUgUI+jQ4=;
        b=eBj+LAIZ62qECAHcmP3MzWFxnZURvHv8xBaTPA9yWQL2s+EB1YgTU3/+kQeBWwmRX4
         RswZ//VgQSbEswbgw50nSq2LEt/BVop6aWiYsAWjKw/ebMc9WFzLYaeqXB30MTl3nYlW
         N2pS+kQHxAwkJs/FK/bkNr2tmDuoVi1gDZtuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=UsDhizeqwqVetBtxTd5HgodBbkJnkh0ltjiUgUI+jQ4=;
        b=J51kDXj8jUVs1kvuXKzs6WtDnXY7koswwCE1Ki81UNr5eorIWNNixL9zmO23zux9dS
         16PzTa997OLOZXrN4P70b3CtBYJjYPALG4V10WwXXKQujk5GPhn/epSzB+W/HNPXwZu4
         daM+Exk+XRR2WMYYCVNk5laiTqvotOM1YV5qzDyDROryZB56LBhFbhsxSEpHG8JNvkKA
         I/0mIeoezqEHscUF/dZjglewy2PPy0x80DAZPLSrHlQdIYYuud93S1a6TZ3j71H74WwJ
         wZWM2CqLJe9YCYtyEygH/HM8nXnKvHLHCD7AAUMo1QbX+BrxXkpQU+tvkWD0T9PTv2Oe
         EyJw==
X-Gm-Message-State: ACgBeo1Ve2GqOAZXP08nLYM3N8VNCmTB7xfpF0ZQQag9DX4b4+4oP8Ie
        yT2bACiSOc2wPCIzfYYIWB3lmwQwoOwJ2L3hRdOq
X-Google-Smtp-Source: AA6agR6e03L1bMEBsFmMBs8EX268jro9wlTh48Fs2gowvF6cpJkq4naexopAUA5x6tZfKrUZltSZ2DYUgLPmzGJeGI8=
X-Received: by 2002:a25:37c1:0:b0:67d:5e63:3f70 with SMTP id
 e184-20020a2537c1000000b0067d5e633f70mr17792182yba.312.1660693317356; Tue, 16
 Aug 2022 16:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220816163058.3004536-1-ajones@ventanamicro.com>
In-Reply-To: <20220816163058.3004536-1-ajones@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 16 Aug 2022 16:41:46 -0700
Message-ID: <CAOnJCU+Gx44ESHWyku7Kb6u5QnzjXiZcat5XmVWjksdFpcQ6nA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Ensure isa-ext static keys are writable
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, daolu@rivosinc.com,
        jszhang@kernel.org, palmer@dabbelt.com, Conor.Dooley@microchip.com,
        re@w6rz.net, Anup Patel <apatel@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 9:31 AM Andrew Jones <ajones@ventanamicro.com> wrote:
>
> riscv_isa_ext_keys[] is an array of static keys used in the unified
> ISA extension framework. The keys added to this array may be used
> anywhere, including in modules. Ensure the keys remain writable by
> placing them in the data section.
>
> The need to change riscv_isa_ext_keys[]'s section was found when the
> kvm module started failing to load. Commit 8eb060e10185 ("arch/riscv:
> add Zihintpause support") adds a static branch check for a newly
> added isa-ext key to cpu_relax(), which kvm uses.
>
> Fixes: c360cbec3511 ("riscv: introduce unified static key mechanism for ISA extensions")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/kernel/cpufeature.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 553d755483ed..3b5583db9d80 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -28,7 +28,7 @@ unsigned long elf_hwcap __read_mostly;
>  /* Host ISA bitmap */
>  static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
>
> -__ro_after_init DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
> +DEFINE_STATIC_KEY_ARRAY_FALSE(riscv_isa_ext_keys, RISCV_ISA_EXT_KEY_MAX);
>  EXPORT_SYMBOL(riscv_isa_ext_keys);
>
>  /**
> --
> 2.37.1
>
>
> --
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv

Thanks for the quick fix. Tested with kvm guests booting in Qemu.

Tested-by: Atish Patra <atishp@rivosinc.com>

-- 
Regards,
Atish
