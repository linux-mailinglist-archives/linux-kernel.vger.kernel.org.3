Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8978957C85B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiGUJ6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbiGUJ6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:58:46 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2E681B1E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:58:45 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y8so1503337eda.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AERHviI4+0lw5BuAPlcVYCLTAkZUrRuqNMfCTEsNzwA=;
        b=IR6NulFxPs9l1r3DCpl0GsssXvQTjDkW96EKXvU5yfQ1DuHCOFid3C9fRUblWfinVN
         jkvwy1uGlqg3qi1PwdrEdMPqIL3ytQH2v0fHrO5119cVr6AboHr/9ipOsvIIy0ywQHCV
         cGfTR/4mknReSjL2XtzUhWNhs/5mBjOHIP41w6fFXI5HJ+HkL3kaFjoIEBDQOoR+pRAi
         dw9YmlE8NGbcSxgBt3tpMHWpqOm0PxJBC2m0cuKVU5YYdeUYcz2k0ibc2APu9p092jI6
         q282U60M68ovgG6MLOJkrDogSHMg7/8e9leob//39z5sF9nva4vx2dWLM7ldCfXqQNVv
         ZdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AERHviI4+0lw5BuAPlcVYCLTAkZUrRuqNMfCTEsNzwA=;
        b=peeo/QmcqNYfv6fTfecn7T9q9nVy7EHaKk2zN2V2Dsh8MxD8SlcdIwg9l4xieaNVrG
         85zia+QO7yLSqi8SuXGjvwvGURlMwdZzb8ZOzrg8Dsx+rXrW85NT7Oz3U2Q+yqxl0OHT
         PwpUOEGO6Z83J32BRRAd5SkOfyfVlOMEoF7fx9hTO6gfUFpk67vrNQTNvdvrYG4N5dBk
         nlmjiZiUwKa2/qL8JZi6YJ0Ec8JlBePdI5PuEjbNkNmby2N5hOBFF8VdwQTiS+2VKvSu
         UBtN2AZC2JfVfQJdtVOLuLwf/NpBk/oM3f4I5pCRgiEU/5E0VAUvEe9/xNGggifntF+e
         HlLw==
X-Gm-Message-State: AJIora8ai2E7T3FK3z+f62o3tFbGN054kHOn0BtPeHw0Zx5i8l996p/y
        xNFhb9q5btwObvZbpG4INamUX8H0JIQNgmVNLG8YJw==
X-Google-Smtp-Source: AGRyM1swg11Ki2871ymoOzicSCKaS/ZXXCwRw72mjD6HJVcQJ4xYR7fgViWJ5PqxZxzOVd77ydBJeAMS/hAwpybi8bM=
X-Received: by 2002:aa7:cd86:0:b0:43a:26e3:d333 with SMTP id
 x6-20020aa7cd86000000b0043a26e3d333mr56365170edv.178.1658397523919; Thu, 21
 Jul 2022 02:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220721055728.718573-1-kaleshsingh@google.com> <20220721055728.718573-11-kaleshsingh@google.com>
In-Reply-To: <20220721055728.718573-11-kaleshsingh@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Thu, 21 Jul 2022 10:58:04 +0100
Message-ID: <CA+EHjTxJoaeSom51fGZCtFdOo0D16GYC_QUuQ26jLKgo_pfEFw@mail.gmail.com>
Subject: Re: [PATCH v5 10/17] KVM: arm64: Stub implementation of pKVM HYP
 stack unwinder
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

On Thu, Jul 21, 2022 at 6:57 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> Add some stub implementations of protected nVHE stack unwinder, for
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
>
>  arch/arm64/include/asm/stacktrace/nvhe.h | 59 ++++++++++++++++++++++++
>  arch/arm64/kvm/hyp/nvhe/stacktrace.c     |  3 +-
>  2 files changed, 60 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/include/asm/stacktrace/nvhe.h
>
> diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
> new file mode 100644
> index 000000000000..80d71932afff
> --- /dev/null
> +++ b/arch/arm64/include/asm/stacktrace/nvhe.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * KVM nVHE hypervisor stack tracing support.
> + *
> + * The unwinder implementation depends on the nVHE mode:
> + *
> + *   1) pKVM (protected nVHE) mode - the host cannot directly access
> + *      the HYP memory. The stack is unwinded in EL2 and dumped to a shared
> + *      buffer where the host can read and print the stacktrace.
> + *
> + * Copyright (C) 2022 Google LLC
> + */
> +#ifndef __ASM_STACKTRACE_NVHE_H
> +#define __ASM_STACKTRACE_NVHE_H
> +
> +#include <asm/stacktrace/common.h>
> +
> +static inline bool on_accessible_stack(const struct task_struct *tsk,
> +                                      unsigned long sp, unsigned long size,
> +                                      struct stack_info *info)
> +{
> +       return false;
> +}
> +
> +#ifdef __KVM_NVHE_HYPERVISOR__
> +/*
> + * Protected nVHE HYP stack unwinder
> + *
> + * In protected mode, the unwinding is done by the hypervisor in EL2.
> + */
> +
> +#ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
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
> +#else  /* !CONFIG_PROTECTED_NVHE_STACKTRACE */
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
> +#endif /* CONFIG_PROTECTED_NVHE_STACKTRACE */
> +
> +#endif /* __KVM_NVHE_HYPERVISOR__ */
> +#endif /* __ASM_STACKTRACE_NVHE_H */
> diff --git a/arch/arm64/kvm/hyp/nvhe/stacktrace.c b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> index 69e65b457f1c..96c8b93320eb 100644
> --- a/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> +++ b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> @@ -4,8 +4,7 @@
>   *
>   * Copyright (C) 2022 Google LLC
>   */
> -#include <asm/memory.h>
> -#include <asm/percpu.h>
> +#include <asm/stacktrace/nvhe.h>
>
>  DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
>         __aligned(16);
> --
> 2.37.0.170.g444d1eabd0-goog
>
