Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575FF579275
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiGSFa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbiGSFaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:30:16 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A074DFE4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:30:14 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ez10so25061406ejc.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3zr7CI+f7CcBEW2brvjOReL5MtpWs8VeKfSR7ZaUhQ8=;
        b=X5I4TlvvCOecKYavZ9dyN3VzSk7rtFIO7Ohqzn4tfVxXZV+tMVjRDk8PjyYJiEQs5j
         mqNltJJR9yFSwCIeQ/o5qXI/Zy8u0GIRgtCuvZfDWJCpo58TnebHV1Ws0cAKR82yiung
         nyvki+bcANHUXM/m4gTRZvPl8LXkmv44EsD7lKqU4uIYz5DPp/Pl6FotVcxBETpOJR8Y
         ryesLB+n9f18V/G2K8iJlrxR1hKF+iZXlYOnjffSNzHxRhRn+HSjwI9m2X1/aRDQEXU6
         zMjJpht0PhUF2BnI+a0wtAMXRWTQ5dZkFc3gJYz2S4lRQ7XRMmjrRcy4+j4kqK/TKTMc
         6CMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3zr7CI+f7CcBEW2brvjOReL5MtpWs8VeKfSR7ZaUhQ8=;
        b=HBmaF9f5E0psw6K5pAwOj+BmfemSd9WRQn/RB7ySFfo/I3l+IGNRZbOiMgLbBjh220
         ed8yAE124tDv00FevmRgOKsUE2zVdGdt7aGPEAOH6kZu9q/91fx75ZyrTxBtU+bqfSLf
         yW9A0nvxNrbWHGPYLtx6EyRbH1MACeoUzktdefiNQc78yrUHVAzzTtNwgVF/VF4Xdz6g
         zzAlLKcXBjZL3j5Sbc0Dofb+gS0rl8dHj0Aq06nJyMp5JcETBap5FQ63Q29hVE+Go2Ex
         3Y41hv5BxcjbFtpBqeF72kGsLyAac4biBOH/uQECsQf47tpwmt34Rs4keo2PSIYWzz5L
         NEsw==
X-Gm-Message-State: AJIora9jbS2NAv1PqPbOF5MVplu57cCSaFaawJ6QILUWqzcg/cZN5QYE
        +aMXHzxBJe8up1cTSS/uaQDojRFVT295EW8zghI=
X-Google-Smtp-Source: AGRyM1ukDFzxgmPs2PvcAG84rlcbGbNRvy8tYIzSc1MVR4KRGsW39RRJ57o9emOtHp6wEcOiY84F1/fMV7lnphTS/8M=
X-Received: by 2002:a17:907:3f07:b0:72b:54b2:f57f with SMTP id
 hq7-20020a1709073f0700b0072b54b2f57fmr28319432ejc.502.1658208612985; Mon, 18
 Jul 2022 22:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220716230344.239749011@linutronix.de> <20220716230954.898341815@linutronix.de>
In-Reply-To: <20220716230954.898341815@linutronix.de>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 18 Jul 2022 22:30:01 -0700
Message-ID: <CAADnVQJb6vY5j+RAW9NYA1gcPXsocytFTL1xvNx+eyWojy3deg@mail.gmail.com>
Subject: Re: [patch 37/38] x86/bpf: Emit call depth accounting if required
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2022 at 4:18 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Ensure that calls in BPF jitted programs are emitting call depth accounting
> when enabled to keep the call/return balanced. The return thunk jump is
> already injected due to the earlier retbleed mitigations.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  arch/x86/include/asm/alternative.h |    6 +++++
>  arch/x86/kernel/callthunks.c       |   19 ++++++++++++++++
>  arch/x86/net/bpf_jit_comp.c        |   43 ++++++++++++++++++++++++-------------
>  3 files changed, 53 insertions(+), 15 deletions(-)
>
> --- a/arch/x86/include/asm/alternative.h
> +++ b/arch/x86/include/asm/alternative.h
> @@ -95,6 +95,7 @@ extern void callthunks_patch_module_call
>  extern void callthunks_module_free(struct module *mod);
>  extern void *callthunks_translate_call_dest(void *dest);
>  extern bool is_callthunk(void *addr);
> +extern int x86_call_depth_emit_accounting(u8 **pprog, void *func);
>  #else
>  static __always_inline void callthunks_patch_builtin_calls(void) {}
>  static __always_inline void
> @@ -109,6 +110,11 @@ static __always_inline bool is_callthunk
>  {
>         return false;
>  }
> +static __always_inline int x86_call_depth_emit_accounting(u8 **pprog,
> +                                                         void *func)
> +{
> +       return 0;
> +}
>  #endif
>
>  #ifdef CONFIG_SMP
> --- a/arch/x86/kernel/callthunks.c
> +++ b/arch/x86/kernel/callthunks.c
> @@ -706,6 +706,25 @@ int callthunk_get_kallsym(unsigned int s
>         return ret;
>  }
>
> +#ifdef CONFIG_BPF_JIT
> +int x86_call_depth_emit_accounting(u8 **pprog, void *func)
> +{
> +       unsigned int tmpl_size = callthunk_desc.template_size;
> +       void *tmpl = callthunk_desc.template;
> +
> +       if (!thunks_initialized)
> +               return 0;
> +
> +       /* Is function call target a thunk? */
> +       if (is_callthunk(func))
> +               return 0;
> +
> +       memcpy(*pprog, tmpl, tmpl_size);
> +       *pprog += tmpl_size;
> +       return tmpl_size;
> +}
> +#endif
> +
>  #ifdef CONFIG_MODULES
>  void noinline callthunks_patch_module_calls(struct callthunk_sites *cs,
>                                             struct module *mod)
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -340,6 +340,12 @@ static int emit_call(u8 **pprog, void *f
>         return emit_patch(pprog, func, ip, 0xE8);
>  }
>
> +static int emit_rsb_call(u8 **pprog, void *func, void *ip)
> +{
> +       x86_call_depth_emit_accounting(pprog, func);
> +       return emit_patch(pprog, func, ip, 0xE8);
> +}
> +
>  static int emit_jump(u8 **pprog, void *func, void *ip)
>  {
>         return emit_patch(pprog, func, ip, 0xE9);
> @@ -1431,19 +1437,26 @@ st:                     if (is_imm8(insn->off))
>                         break;
>
>                         /* call */
> -               case BPF_JMP | BPF_CALL:
> +               case BPF_JMP | BPF_CALL: {
> +                       int offs;
> +
>                         func = (u8 *) __bpf_call_base + imm32;
>                         if (tail_call_reachable) {
>                                 /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
>                                 EMIT3_off32(0x48, 0x8B, 0x85,
>                                             -round_up(bpf_prog->aux->stack_depth, 8) - 8);
> -                               if (!imm32 || emit_call(&prog, func, image + addrs[i - 1] + 7))
> +                               if (!imm32)
>                                         return -EINVAL;
> +                               offs = 7 + x86_call_depth_emit_accounting(&prog, func);

It's a bit hard to read all the macro magic in patches 28-30,
but I suspect the asm inside
callthunk_desc.template
that will be emitted here before the call
will do
some math on %rax
movq %rax, PER_CPU_VAR(__x86_call_depth).

Only %rax register is scratched by the callthunk_desc, right?
If so, it's ok for all cases except this one.
See the comment few lines above
after if (tail_call_reachable)
and commit ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall
handling in JIT")
We use %rax to keep the tail_call count.
The callthunk_desc would need to preserve %rax.
I guess extra push %rax/pop %rax would do it.

>                         } else {
> -                               if (!imm32 || emit_call(&prog, func, image + addrs[i - 1]))
> +                               if (!imm32)
>                                         return -EINVAL;
> +                               offs = x86_call_depth_emit_accounting(&prog, func);
>                         }
> +                       if (emit_call(&prog, func, image + addrs[i - 1] + offs))
> +                               return -EINVAL;
>                         break;
> +               }
