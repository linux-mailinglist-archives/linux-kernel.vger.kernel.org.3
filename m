Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA0157C85D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiGUJ7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbiGUJ67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:58:59 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF28820D2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:58:51 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t3so1539735edd.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RmAIjKGWk0hNqXTnjY9ohH0Hfcr8vg917Lo9awM+QzI=;
        b=rHaT/SOwOYka0T4gC642ubUIOA0nOV6Jrx+k8lfSVuNlZCg6k9HusWWKOzy0JL+JKA
         jG9X9xcgQRmAxFdk+rHJ0EpPcUdzKyeBNPP0S+LaVIIqDuyZgPVe0CAMZDk/znoO8kWZ
         oChbddtj0Yu/vqRZ9BQlFUNEjQ/2x6N4VHSc/W1gxQZsZcTbZga34SHoqbzEFEuqMXte
         4d+4Ped7pzDLPByLcPp4OQtrtwenH22oVXC+0Z9bxo4xjnalQHOXkXxTA8Fo0UR0mhxk
         Mi/vPWa75OjwrFQMtPjzMxSkzM2QJn5VgQlf9wykEtwE7Ga8b48SPxhJ/tHGH0k2FaBS
         NlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RmAIjKGWk0hNqXTnjY9ohH0Hfcr8vg917Lo9awM+QzI=;
        b=TSYdew526mWOO82Z5THNe7kirxul7rzUSJZy4VHRAY/1E0HCXNlp6TrFtPK034FK3W
         6UCaG2xup2o8XZgav6sK2acZMQp3vbYFsjQPPhv8tYECqz5BD/a3aUsvu2ig4f/XKHDg
         vV3Ct4yInH4bp1YkvGiZJA+KzEQz2VjNs2u/e+tlhiwzHCg/u2neer0qRF4i8K/2znuB
         uP2/O+k3RKAesJ/KevXJaUGgCwyXbgv6UncQe+hwNLtB6ehTQkQay2JJvTBH1HhlC92r
         8hi1KXVslgWvOhF7JPfCjfI/1htVVAiO85umwsnZLcs5stylbj2bYHgrDRngaZynYCck
         yvwA==
X-Gm-Message-State: AJIora8gH/qBcT4dZZqFaZXGoKQwmERC+H8fXKnxSDmGC24egkjWPWE/
        9WDEre/E8Iswx4XOXcvJbFT99kL6PqbvRQrLZUVB0g==
X-Google-Smtp-Source: AGRyM1uNyQGAgyUyWlicYyKFzueKx1CnxNhfO10Jlea4E3AIWxJJXx09bUiJbLYyg+XFDZNmbcrgYnmqe6s5k3VegI8=
X-Received: by 2002:a05:6402:753:b0:43b:a416:3963 with SMTP id
 p19-20020a056402075300b0043ba4163963mr13570370edy.267.1658397530188; Thu, 21
 Jul 2022 02:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com> <20220721055728.718573-12-kaleshsingh@google.com>
In-Reply-To: <20220721055728.718573-12-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 21 Jul 2022 10:58:13 +0100
Message-ID: <CA+EHjTzb9cEAP=p39tbNynymnTXSNVuta74sQp05V1VsFVDaJg@mail.gmail.com>
Subject: Re: [PATCH v5 11/17] KVM: arm64: Stub implementation of non-protected
 nVHE HYP stack unwinder
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalesh,

On Thu, Jul 21, 2022 at 6:58 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> Add stub implementations of non-protected nVHE stack unwinder, for
> building. These are implemented later in this series.
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>
> Changes in v5:
>   - Mark unwind_next() as inline, per Marc
>   - Comment !__KVM_NVHE_HYPERVISOR__ unwinder path, per Marc
>
>  arch/arm64/include/asm/stacktrace/nvhe.h | 26 ++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
> index 80d71932afff..3078501f8e22 100644
> --- a/arch/arm64/include/asm/stacktrace/nvhe.h
> +++ b/arch/arm64/include/asm/stacktrace/nvhe.h
> @@ -8,6 +8,12 @@
>   *      the HYP memory. The stack is unwinded in EL2 and dumped to a shared
>   *      buffer where the host can read and print the stacktrace.
>   *
> + *   2) Non-protected nVHE mode - the host can directly access the
> + *      HYP stack pages and unwind the HYP stack in EL1. This saves having
> + *      to allocate shared buffers for the host to read the unwinded
> + *      stacktrace.
> + *
> + *
>   * Copyright (C) 2022 Google LLC
>   */
>  #ifndef __ASM_STACKTRACE_NVHE_H
> @@ -55,5 +61,25 @@ static inline int notrace unwind_next(struct unwind_state *state)
>  NOKPROBE_SYMBOL(unwind_next);
>  #endif /* CONFIG_PROTECTED_NVHE_STACKTRACE */
>
> +#else  /* !__KVM_NVHE_HYPERVISOR__ */
> +/*
> + * Conventional (non-protected) nVHE HYP stack unwinder
> + *
> + * In non-protected mode, the unwinding is done from kernel proper context
> + * (by the host in EL1).
> + */
> +
> +static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
> +                                    struct stack_info *info)
> +{
> +       return false;
> +}
> +
> +static inline int notrace unwind_next(struct unwind_state *state)
> +{
> +       return 0;
> +}
> +NOKPROBE_SYMBOL(unwind_next);
> +
>  #endif /* __KVM_NVHE_HYPERVISOR__ */
>  #endif /* __ASM_STACKTRACE_NVHE_H */
> --
> 2.37.0.170.g444d1eabd0-goog
>
