Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205E857C863
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbiGUJ7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbiGUJ7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:59:19 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E42881B34
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:59:18 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id os14so2279317ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lj/0wM6NAt2u4+QegECU3k06tWmQYzBPAjiO9RdsPZg=;
        b=TWW8k4hNmMq9Daa63lNZ1ib4dK8on5MllaStr0wGK4hJZvkqqOaXSM2ogqz6vmexvT
         s1EFTwlXjIYmge/HQBuFO/YI4JOHjW3jTR7Gi7XBL+sGUCe4hkywaCi6yHxj6NwE3trP
         q7F9lxawv6hAriazOGeT3RgXZhSRqpd+JxiCUn3uA0FzHF00YC19vLx9T5YJCDuQcx0y
         vnkexEUgnkxjmB2lgv+fgrbbd+zU99FxRC40IOhRageMos4P34CJvhkDwiAqY4W5Qkh4
         BwimYmXY7nJDTNPzJjvkW2atxkxPiwcaXPug33Eyu2aU6u/x+//9WQ2aRh9H+/l4DRjs
         vWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lj/0wM6NAt2u4+QegECU3k06tWmQYzBPAjiO9RdsPZg=;
        b=k+uC9R+W1zsRTmma5dLUa7xH9slMJKv8pXrSQX6akPgfs621a6X5Ntmj9uOHD3plnn
         rGu5ACMjYEVKfYYUYyKgpaHiZ4x80fkYP+DUEwjWyDT1srgxVWry6kdmWo186LkTSUwv
         I548PccOu/qtDqfC9MDO7SNTcBgV8Xa7tzggYwgf7MeelXuM9ULo3T11wrn7pQ+RIwgE
         F5rUCp3BCd/pRuuwP040WwjSglTDEyQgbGtOjKBH/jcWdXhfQbfMaqK88m0eLqi6ju4W
         AcA5zEXUgTiK7a6MACaTB02hltwG9M35VukER0SPv1Y5oymM+zdroagHvADhAhkzFQq/
         +fRg==
X-Gm-Message-State: AJIora8eDPLW6dEn2ha+ea9s43h7qvLabNWhI4j+prTKl9ZVdetSplyU
        3vo6VzrZB20yJ1j4bMcU3BPge7gPoGErgNFH55qmgg==
X-Google-Smtp-Source: AGRyM1vFVHjD2TFnvN66RJojUMjD/iIsLidEphqOnhp9/G1jJM7kym/Lso/S89nbkov9+VZ0as59TPn0TDwUL1SEHts=
X-Received: by 2002:a17:907:6297:b0:72f:9aad:fcb with SMTP id
 nd23-20020a170907629700b0072f9aad0fcbmr1588686ejc.161.1658397556502; Thu, 21
 Jul 2022 02:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com> <20220721055728.718573-15-kaleshsingh@google.com>
In-Reply-To: <20220721055728.718573-15-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 21 Jul 2022 10:58:40 +0100
Message-ID: <CA+EHjTzyK+bhtbC3xU5zCnsTDHpAKFqP3sp3LYFXjkHfPn8o-Q@mail.gmail.com>
Subject: Re: [PATCH v5 14/17] KVM: arm64: Implement protected nVHE hyp stack unwinder
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, broonie@kernel.org,
        madvenka@linux.microsoft.com, will@kernel.org, qperret@google.com,
        james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com,
        andreyknvl@gmail.com, vincenzo.frascino@arm.com,
        mhiramat@kernel.org, ast@kernel.org, wangkefeng.wang@huawei.com,
        elver@google.com, keirf@google.com, yuzenghui@huawei.com,
        ardb@kernel.org, oupton@google.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalesh,

On Thu, Jul 21, 2022 at 6:58 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> Implements the common framework necessary for unwind() to work in
> the protected nVHE context:
>    - on_accessible_stack()
>    - on_overflow_stack()
>    - unwind_next()
>
> Protected nVHE unwind() is used to unwind and save the hyp stack
> addresses to the shared stacktrace buffer. The host reads the
> entries in this buffer, symbolizes and dumps the stacktrace (later
> patch in the series).
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad


>  arch/arm64/include/asm/stacktrace/common.h |  2 ++
>  arch/arm64/include/asm/stacktrace/nvhe.h   | 34 ++++++++++++++++++++--
>  2 files changed, 34 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/stacktrace/common.h b/arch/arm64/include/asm/stacktrace/common.h
> index be7920ba70b0..73fd9e143c4a 100644
> --- a/arch/arm64/include/asm/stacktrace/common.h
> +++ b/arch/arm64/include/asm/stacktrace/common.h
> @@ -34,6 +34,7 @@ enum stack_type {
>         STACK_TYPE_OVERFLOW,
>         STACK_TYPE_SDEI_NORMAL,
>         STACK_TYPE_SDEI_CRITICAL,
> +       STACK_TYPE_HYP,
>         __NR_STACK_TYPES
>  };
>
> @@ -186,6 +187,7 @@ static inline int unwind_next_common(struct unwind_state *state,
>          *
>          * TASK -> IRQ -> OVERFLOW -> SDEI_NORMAL
>          * TASK -> SDEI_NORMAL -> SDEI_CRITICAL -> OVERFLOW
> +        * HYP -> OVERFLOW
>          *
>          * ... but the nesting itself is strict. Once we transition from one
>          * stack to another, it's never valid to unwind back to that first
> diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
> index 8f02803a005f..c3688e717136 100644
> --- a/arch/arm64/include/asm/stacktrace/nvhe.h
> +++ b/arch/arm64/include/asm/stacktrace/nvhe.h
> @@ -39,10 +39,19 @@ static inline void kvm_nvhe_unwind_init(struct unwind_state *state,
>         state->pc = pc;
>  }
>
> +static inline bool on_hyp_stack(unsigned long sp, unsigned long size,
> +                               struct stack_info *info);
> +
>  static inline bool on_accessible_stack(const struct task_struct *tsk,
>                                        unsigned long sp, unsigned long size,
>                                        struct stack_info *info)
>  {
> +       if (on_accessible_stack_common(tsk, sp, size, info))
> +               return true;
> +
> +       if (on_hyp_stack(sp, size, info))
> +               return true;
> +
>         return false;
>  }
>
> @@ -60,12 +69,27 @@ DECLARE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
>  static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
>                                      struct stack_info *info)
>  {
> -       return false;
> +       unsigned long low = (unsigned long)this_cpu_ptr(overflow_stack);
> +       unsigned long high = low + OVERFLOW_STACK_SIZE;
> +
> +       return on_stack(sp, size, low, high, STACK_TYPE_OVERFLOW, info);
> +}
> +
> +static inline bool on_hyp_stack(unsigned long sp, unsigned long size,
> +                               struct stack_info *info)
> +{
> +       struct kvm_nvhe_init_params *params = this_cpu_ptr(&kvm_init_params);
> +       unsigned long high = params->stack_hyp_va;
> +       unsigned long low = high - PAGE_SIZE;
> +
> +       return on_stack(sp, size, low, high, STACK_TYPE_HYP, info);
>  }
>
>  static inline int notrace unwind_next(struct unwind_state *state)
>  {
> -       return 0;
> +       struct stack_info info;
> +
> +       return unwind_next_common(state, &info, NULL);
>  }
>  NOKPROBE_SYMBOL(unwind_next);
>  #else  /* !CONFIG_PROTECTED_NVHE_STACKTRACE */
> @@ -75,6 +99,12 @@ static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
>         return false;
>  }
>
> +static inline bool on_hyp_stack(unsigned long sp, unsigned long size,
> +                               struct stack_info *info)
> +{
> +       return false;
> +}
> +
>  static inline int notrace unwind_next(struct unwind_state *state)
>  {
>         return 0;
> --
> 2.37.0.170.g444d1eabd0-goog
>
