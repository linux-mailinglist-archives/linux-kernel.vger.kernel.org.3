Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB546487836
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 14:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347567AbiAGN3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 08:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238674AbiAGN3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:29:02 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F16C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 05:29:02 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id a1so5474108qtx.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 05:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=G93pNib2AdYHJFPzHxQ0fNlVSs9vGqI40MeIunwH1I4=;
        b=dVopYzfU+vYmuHEIGsl7xDGblp+DXnUgl2XAUswDynW9EppOkRKAk1H0adUgdQ3RC+
         Tfyro2/t3gmle6RyTotvf4UyCj8ZSAp+TiO6L8KWWL9BjUYJHRVeqGT4ZOCHUrwDu4IF
         oLBxaA0CkKD1ZSDvphgC6Q+M65UvtmLZkHomAup5Z+T3lED4kKw7OZrKbo3ZbdTzI7DK
         qALOLVAw1m/AveRPnFbj95xqbgYD/83l1irj7WAwkdtFinOpk0qTaSjYblDQ9V/ZMDZ7
         rfma75ea7kRyGXWGoOYwK6i6XnQq/QyQwW9mRzr8sv70OQuBASjU83DqaK3Ys8HqkqBE
         YWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=G93pNib2AdYHJFPzHxQ0fNlVSs9vGqI40MeIunwH1I4=;
        b=hmXCw5hgL096X/FDfgaOa/99AxTvhjMHcEeqXmnsZN5V9C//onXDCpK202I3OvjSaZ
         yM1A/IeofCS7EhPl7FE5jfi0I4Ad8hcTc/DgLTc8IktTH+vNcrYeCkrZihlaYIjVSgY+
         5FjKV5SAmOFts8dWfAbilZovpoG9CkrkJEPF9kXat4HYF/AMKnzZLGtBU5ls1fKjh8gj
         q88xe5/oxaVghvp9kY6Kr54ZcXZYBE6IaXB/yRs0t0DK5RSwAmoGiMHI60hf/AIDERNk
         J5dBgoKLB3dByjhs05X+EzSaI0zR/HqKueGI6yYnmIU/ts2RIFeF1ssyErCDrVCxZrt7
         Fptw==
X-Gm-Message-State: AOAM5332hafwXpbweyidTf9a3moXNH50qFukY8phSI86WOiAir9Ei3/v
        rkVFzSaqyFaDS5/KamvCr4sj4o+P7mmpaDPVOVtDK2CUXVN3oQ==
X-Google-Smtp-Source: ABdhPJx5S+KrFZFdaW06QLf/K5Z8D9nNip9g3mX/Qb+GJz3jTcjVqkt4OL9dHv90IsMsXAvxk9GoTqbB1AYxcCuWXis=
X-Received: by 2002:a05:622a:1386:: with SMTP id o6mr56067325qtk.64.1641562141301;
 Fri, 07 Jan 2022 05:29:01 -0800 (PST)
MIME-Version: 1.0
References: <15d09938180ee45bc5481c4a2d41ad656ca23c82.1636362169.git.greentime.hu@sifive.com>
 <mhng-a7a94a37-5791-4c76-8f2d-072130d71819@palmer-ri-x1c9>
In-Reply-To: <mhng-a7a94a37-5791-4c76-8f2d-072130d71819@palmer-ri-x1c9>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Fri, 7 Jan 2022 21:28:50 +0800
Message-ID: <CAHCEehJhMQf9jtVkTvorriv6xY5QnEDmN_JjM-UxcCj9UL86Lg@mail.gmail.com>
Subject: Re: [PATCH v9 08/17] riscv: Add vector struct and assembler definitions
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Palmer Dabbelt <palmer@dabbelt.com> =E6=96=BC 2021=E5=B9=B412=E6=9C=8815=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8812:29=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Tue, 09 Nov 2021 01:48:20 PST (-0800), greentime.hu@sifive.com wrote:
> > Add vector state context struct in struct thread and asm-offsets.c
> > definitions.
> >
> > The vector registers will be saved in datap pointer of __riscv_v_state.=
 It
> > will be dynamically allocated in kernel space. It will be put right aft=
er
> > the __riscv_v_state data structure in user space.
> >
> > Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> > ---
> >  arch/riscv/include/asm/processor.h   |  1 +
> >  arch/riscv/include/uapi/asm/ptrace.h | 11 +++++++++++
> >  arch/riscv/kernel/asm-offsets.c      |  6 ++++++
> >  3 files changed, 18 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/as=
m/processor.h
> > index 46b492c78cbb..a268f1382e52 100644
> > --- a/arch/riscv/include/asm/processor.h
> > +++ b/arch/riscv/include/asm/processor.h
> > @@ -35,6 +35,7 @@ struct thread_struct {
> >       unsigned long s[12];    /* s[0]: frame pointer */
> >       struct __riscv_d_ext_state fstate;
> >       unsigned long bad_cause;
> > +     struct __riscv_v_state vstate;
> >  };
> >
> >  /* Whitelist the fstate from the task_struct for hardened usercopy */
> > diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/=
uapi/asm/ptrace.h
> > index 882547f6bd5c..bd3b8a710246 100644
> > --- a/arch/riscv/include/uapi/asm/ptrace.h
> > +++ b/arch/riscv/include/uapi/asm/ptrace.h
> > @@ -77,6 +77,17 @@ union __riscv_fp_state {
> >       struct __riscv_q_ext_state q;
> >  };
> >
> > +struct __riscv_v_state {
> > +     unsigned long vstart;
> > +     unsigned long vl;
> > +     unsigned long vtype;
> > +     unsigned long vcsr;
>
> Don't we also need vlen to adequately determine the vector state?
> Otherwise we're going to end up dropping some state when vl isn't vlmax,
> which IIUC isn't legal.

Do you mean vlenb? Since it is a constant value, we don't need to
save/restore it in the context.

> > +     void *datap;
> > +#if __riscv_xlen =3D=3D 32
> > +     __u32 __padding;
> > +#endif
>
> Why is there padding?

To keep vector registers saved in a 16-bytes aligned address for rv32.

struct __riscv_ctx_hdr {
        __u32 magic;
        __u32 size;
};
struct __sc_riscv_v_state {
        struct __riscv_ctx_hdr head;
        struct __riscv_v_state v_state;
} __attribute__((aligned(16)));

rv64 =3D> 48bytes -> 16byte aligned
rv32 =3D> 32bytes -> 16byte aligned

This struct and vector registers will be copied to
sigcontext.reserved[] for signal handler so we'd like to keep it is
16-byte aligned.

struct sigcontext {
        struct user_regs_struct sc_regs;
        union __riscv_fp_state sc_fpregs;
        /*
         * 4K + 128 reserved for vector state and future expansion.
         * This space is enough to store the vector context whose VLENB
         * is less or equal to 128.
         * (The size of the vector context is 4144 byte as VLENB is 128)
         */
        __u8 __reserved[4224] __attribute__((__aligned__(16)));
};


> > +};
> > +
> >  #endif /* __ASSEMBLY__ */
> >
> >  #endif /* _UAPI_ASM_RISCV_PTRACE_H */
> > diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-of=
fsets.c
> > index 90f8ce64fa6f..34f43c84723a 100644
> > --- a/arch/riscv/kernel/asm-offsets.c
> > +++ b/arch/riscv/kernel/asm-offsets.c
> > @@ -72,6 +72,12 @@ void asm_offsets(void)
> >       OFFSET(TSK_STACK_CANARY, task_struct, stack_canary);
> >  #endif
> >
> > +     OFFSET(RISCV_V_STATE_VSTART, __riscv_v_state, vstart);
> > +     OFFSET(RISCV_V_STATE_VL, __riscv_v_state, vl);
> > +     OFFSET(RISCV_V_STATE_VTYPE, __riscv_v_state, vtype);
> > +     OFFSET(RISCV_V_STATE_VCSR, __riscv_v_state, vcsr);
> > +     OFFSET(RISCV_V_STATE_DATAP, __riscv_v_state, datap);
> > +
> >       DEFINE(PT_SIZE, sizeof(struct pt_regs));
> >       OFFSET(PT_EPC, pt_regs, epc);
> >       OFFSET(PT_RA, pt_regs, ra);
