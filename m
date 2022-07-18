Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB3357888E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbiGRRgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbiGRRgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:36:40 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0102CDCF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:36:39 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d16so18083130wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XjNKaW7NRoU376H3IAtZu9323wKhhqWkRMdq9V9ugLM=;
        b=XkYmp5LFgBH04IKeO22dXnfycbzv0+nqjpSozbbbu9hCDxe3zFHk4P7tTGXjrmSW0l
         30/pALVUq8pkMcvAN8zvAHlDW8U4aM9su/s9QWwpZO3m+kNN3qm0vJZG4Vf2zqVctLCq
         JGbW4Oi0qtAcgEszybxPuzvjRqzymsgYTh9HyXKL3Sn4Z/6XlTbYgd9SPelBSrh18GQq
         4/QEtNGAMu+3siI7I7+WHeff2gF+r667NDk7O5IE8KNpelJHJIDn3WdSm/nhUV5UW27g
         IrSt4lBaUi2nFoSHoIDI6nHsoiHfUmAa0AH4ZtuGFvPS+UaUJe3WiZnnAN9jHOkNN1XQ
         J2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XjNKaW7NRoU376H3IAtZu9323wKhhqWkRMdq9V9ugLM=;
        b=vB9DzdGFIauAFJy7UKVINaP4WSX97NQncqd4wjjSz7FuG0H0FWrXPB3JNL5lPz+wuJ
         SVffhhye7ybEKTtUlc+avl9MQr/9IxoP6KeS95Bpe67t5RUflDDM7CMFSY99/UhS1ZXW
         t1IwVeZuVUvGg5XHSM/Hv0Ae5HDJlhRKg9w66he+WPMijjuI4aSN/oFMlN43TPLd3REv
         MWo3k9tQr+rgtiYOPRnMfT337sUxU1b+jHQPBA2OIyJLD3+TLvnCjVGKW85kbMa0D2Hb
         PXGy0S7QetPaQtoj8QC2svz4g5CvS/hleO4ouJKYqZ1y6NsIyHw+p7Og/RIYcyqvj7YA
         EKXw==
X-Gm-Message-State: AJIora/QbOGVWrae5KjTSux4yV6nQYcjSPTXBBVZovYbBKx6qNE3386q
        RQXUSvGNdv9djRs2r6xR7Y5EzY8zWN5DKYaUWzcrEw==
X-Google-Smtp-Source: AGRyM1uiXo0g/V54MJg5NwiG4eamdCrDj+v/MxteMevT3CYQUP1C+atyDrRN4RaRUqYnmDPPfcX1KL5Y9jmfMDBAQvg=
X-Received: by 2002:a05:6000:1e04:b0:21d:7ec3:fe5a with SMTP id
 bj4-20020a0560001e0400b0021d7ec3fe5amr24016772wrb.116.1658165797763; Mon, 18
 Jul 2022 10:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220715061027.1612149-1-kaleshsingh@google.com>
 <20220715061027.1612149-13-kaleshsingh@google.com> <CA+EHjTw8VwFHYHzpyt+sqwo7CDhGm+F+h2+AX=5FtYcXPECGUA@mail.gmail.com>
In-Reply-To: <CA+EHjTw8VwFHYHzpyt+sqwo7CDhGm+F+h2+AX=5FtYcXPECGUA@mail.gmail.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Mon, 18 Jul 2022 10:36:22 -0700
Message-ID: <CAC_TJvfjVK1PNY-UAq8ex1HsqWEN2muM7D_hRXr6LN=hT5=aLQ@mail.gmail.com>
Subject: Re: [PATCH v4 12/18] KVM: arm64: Save protected-nVHE (pKVM) hyp stacktrace
To:     Fuad Tabba <tabba@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Will Deacon <will@kernel.org>,
        Quentin Perret <qperret@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        andreyknvl@gmail.com, russell.king@oracle.com,
        vincenzo.frascino@arm.com, Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Marco Elver <elver@google.com>, Keir Fraser <keirf@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Oliver Upton <oupton@google.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
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

On Mon, Jul 18, 2022 at 3:07 AM Fuad Tabba <tabba@google.com> wrote:
>
> Hi Kalesh,
>
> On Fri, Jul 15, 2022 at 7:11 AM Kalesh Singh <kaleshsingh@google.com> wrote:
> >
> > In protected nVHE mode, the host cannot access private owned hypervisor
> > memory. Also the hypervisor aims to remains simple to reduce the attack
> > surface and does not provide any printk support.
> >
> > For the above reasons, the approach taken to provide hypervisor stacktraces
> > in protected mode is:
> >    1) Unwind and save the hyp stack addresses in EL2 to a shared buffer
> >       with the host (done in this patch).
> >    2) Delegate the dumping and symbolization of the addresses to the
> >       host in EL1 (later patch in the series).
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  arch/arm64/include/asm/stacktrace/nvhe.h | 18 ++++++
> >  arch/arm64/kvm/hyp/nvhe/stacktrace.c     | 70 ++++++++++++++++++++++++
> >  2 files changed, 88 insertions(+)
> >
> > diff --git a/arch/arm64/include/asm/stacktrace/nvhe.h b/arch/arm64/include/asm/stacktrace/nvhe.h
> > index 36cf7858ddd8..456a6ae08433 100644
> > --- a/arch/arm64/include/asm/stacktrace/nvhe.h
> > +++ b/arch/arm64/include/asm/stacktrace/nvhe.h
> > @@ -21,6 +21,22 @@
> >
> >  #include <asm/stacktrace/common.h>
> >
> > +/**
> > + * kvm_nvhe_unwind_init - Start an unwind from the given nVHE HYP fp and pc
> > + *
> > + * @fp : frame pointer at which to start the unwinding.
> > + * @pc : program counter at which to start the unwinding.
> > + */
> > +static __always_inline void kvm_nvhe_unwind_init(struct unwind_state *state,
> > +                                                unsigned long fp,
> > +                                                unsigned long pc)
> > +{
> > +       unwind_init_common(state, NULL);
> > +
> > +       state->fp = fp;
> > +       state->pc = pc;
> > +}
> > +
> >  static inline bool on_accessible_stack(const struct task_struct *tsk,
> >                                        unsigned long sp, unsigned long size,
> >                                        struct stack_info *info)
> > @@ -33,6 +49,8 @@ static inline bool on_accessible_stack(const struct task_struct *tsk,
> >   */
> >  #ifdef __KVM_NVHE_HYPERVISOR__
> >
> > +extern void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc);
> > +
> >  #ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
> >  static inline bool on_overflow_stack(unsigned long sp, unsigned long size,
> >                                      struct stack_info *info)
> > diff --git a/arch/arm64/kvm/hyp/nvhe/stacktrace.c b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> > index 96c8b93320eb..832a536e440f 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/stacktrace.c
> > @@ -11,4 +11,74 @@ DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overflow_stack)
> >
> >  #ifdef CONFIG_PROTECTED_NVHE_STACKTRACE
> >  DEFINE_PER_CPU(unsigned long [NVHE_STACKTRACE_SIZE/sizeof(long)], pkvm_stacktrace);
> > +
> > +/**
> > + * pkvm_save_backtrace_entry - Saves a protected nVHE HYP stacktrace entry
> > + *
> > + * @arg    : the position of the entry in the stacktrace buffer
> > + * @where  : the program counter corresponding to the stack frame
> > + *
> > + * Save the return address of a stack frame to the shared stacktrace buffer.
> > + * The host can access this shared buffer from EL1 to dump the backtrace.
> > + */
> > +static bool pkvm_save_backtrace_entry(void *arg, unsigned long where)
> > +{
> > +       unsigned long **stacktrace_pos = (unsigned long **)arg;
> > +       unsigned long stacktrace_start, stacktrace_end;
> > +
> > +       stacktrace_start = (unsigned long)this_cpu_ptr(pkvm_stacktrace);
> > +       stacktrace_end = stacktrace_start + NVHE_STACKTRACE_SIZE - (2 * sizeof(long));
>
> I guess this is related to my comment in patch 9, but why does the end
> happen at 2 * instead of just 1 * before the actual end? I guess
> because it's inclusive. That said, a comment would be helpful.
>

The intention is to check that we can fit 2 entries (the stacktrace
entry and null entry). I think the "end" naming is a bit misleading.
Let me try to clarify it better in the next version.

Thanks,
Kalesh

> Thanks,
> /fuad
>
> > +
> > +       if ((unsigned long) *stacktrace_pos > stacktrace_end)
> > +               return false;
> > +
> > +       /* Save the entry to the current pos in stacktrace buffer */
> > +       **stacktrace_pos = where;
> > +
> > +       /* A zero entry delimits the end of the stacktrace. */
> > +       *(*stacktrace_pos + 1) = 0UL;
> > +
> > +       /* Increment the current pos */
> > +       ++*stacktrace_pos;
> > +
> > +       return true;
> > +}
> > +
> > +/**
> > + * pkvm_save_backtrace - Saves the protected nVHE HYP stacktrace
> > + *
> > + * @fp : frame pointer at which to start the unwinding.
> > + * @pc : program counter at which to start the unwinding.
> > + *
> > + * Save the unwinded stack addresses to the shared stacktrace buffer.
> > + * The host can access this shared buffer from EL1 to dump the backtrace.
> > + */
> > +static void pkvm_save_backtrace(unsigned long fp, unsigned long pc)
> > +{
> > +       void *stacktrace_start = (void *)this_cpu_ptr(pkvm_stacktrace);
> > +       struct unwind_state state;
> > +
> > +       kvm_nvhe_unwind_init(&state, fp, pc);
> > +
> > +       unwind(&state, pkvm_save_backtrace_entry, &stacktrace_start);
> > +}
> > +#else /* !CONFIG_PROTECTED_NVHE_STACKTRACE */
> > +static void pkvm_save_backtrace(unsigned long fp, unsigned long pc)
> > +{
> > +}
> >  #endif /* CONFIG_PROTECTED_NVHE_STACKTRACE */
> > +
> > +/**
> > + * kvm_nvhe_prepare_backtrace - prepare to dump the nVHE backtrace
> > + *
> > + * @fp : frame pointer at which to start the unwinding.
> > + * @pc : program counter at which to start the unwinding.
> > + *
> > + * Saves the information needed by the host to dump the nVHE hypervisor
> > + * backtrace.
> > + */
> > +void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc)
> > +{
> > +       if (is_protected_kvm_enabled())
> > +               pkvm_save_backtrace(fp, pc);
> > +}
> > --
> > 2.37.0.170.g444d1eabd0-goog
> >
