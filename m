Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1693757DC9E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbiGVIoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiGVIoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02D559E7B3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658479457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KPJ7NU0SBJ5IGQBa0MGzAB99cv4bRZOacuI2wl8M0yY=;
        b=ZWLOBqvXaQF8PY90zYMXThDKiKVd5w9IxB1+uT7BIE2ZM3EZHwKBRpSA7QP9dXFYUxDLgG
        e8i1sUv/4RdCdgZ8SqIMu6eO9rfQ+W/zj3crv3X78yJo++6uTmm1DaBUb+xpA6EGFB8AaH
        gBZ0FESgDong0pyUMtuKGAPtovu3z1M=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-620-ri0mfdKgNMWriFG-bxjFcg-1; Fri, 22 Jul 2022 04:44:09 -0400
X-MC-Unique: ri0mfdKgNMWriFG-bxjFcg-1
Received: by mail-pg1-f197.google.com with SMTP id f128-20020a636a86000000b0041a4b07b039so2083462pgc.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KPJ7NU0SBJ5IGQBa0MGzAB99cv4bRZOacuI2wl8M0yY=;
        b=ucj0/eiis7iltKt6Z26XKnm0eqtwOD0nD6BYpyVf0+h7vDv57B9faXE45SmRz2VTfq
         8lDqL8H/yUeHrBv6Wf/Oeh76F2eGgyAo3VRm4Z/alf2uZ/mXOx6WeRR0sUtj22MHsXsy
         Q8J1jm2qcO04G30/V+1iJagr18SZOO11xMZ6fNA3Qr+7rJaWLiM55IZNwOaNefgk8sj/
         c26bnOH+yiXSTscwJus9ODC/ncCIh5dwOZpLuXXNYioAVJt2IHclXdaie1rHOWPoy03B
         TSZpbVJc8k9mQfkpMlaYAp/Asm3Fj3cWjNLU320Q7Wqx1Dfjxmkut2il4+QQTqJgp8WB
         WpSA==
X-Gm-Message-State: AJIora8aFMMPV7mTUrKkvuGUfKR0K3avungydAgFTeiRYl8Jo+FT25rF
        nSpSAYHCnF+4AB/VUkCsF0P1aFDiRJaAtI+wT7CnHkRLym1Pd6TV6dtGiDnL1Xtsg4jYrEstTbE
        ju+jNnoklN1/x41Th9fCIxF7l8C0zDu5gAqRXurNX
X-Received: by 2002:a17:90b:4a08:b0:1ef:f36b:18e1 with SMTP id kk8-20020a17090b4a0800b001eff36b18e1mr16127734pjb.246.1658479448527;
        Fri, 22 Jul 2022 01:44:08 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vucvEYBhga7xRfvmO+fpAe+UxKmxIBDDjvW8ENwrZs/TTzp86GPuJSg32bCOVL9jphN7Wm13VUw34PY+/PHI4=
X-Received: by 2002:a17:90b:4a08:b0:1ef:f36b:18e1 with SMTP id
 kk8-20020a17090b4a0800b001eff36b18e1mr16127693pjb.246.1658479448127; Fri, 22
 Jul 2022 01:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220721153625.1282007-1-benjamin.tissoires@redhat.com>
 <20220721153625.1282007-3-benjamin.tissoires@redhat.com> <CAP01T746d18QjJH1pRaq5Wy2QtrXXKhaJge8sB=q1rNtqjTntA@mail.gmail.com>
In-Reply-To: <CAP01T746d18QjJH1pRaq5Wy2QtrXXKhaJge8sB=q1rNtqjTntA@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 22 Jul 2022 10:43:57 +0200
Message-ID: <CAO-hwJJ+SgP4US26qUFAoXxVk00BbT0Ct-3ax5B6XwQ=_vDLLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 02/24] bpf/verifier: allow kfunc to read user
 provided context
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>, Jonathan Corbet <corbet@lwn.net>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 10:15 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Thu, 21 Jul 2022 at 17:36, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > When a kfunc was trying to access data from context in a syscall eBPF
> > program, the verifier was rejecting the call.
> > This is because the syscall context is not known at compile time, and
> > so we need to check this when actually accessing it.
> >
> > Check for the valid memory access and allow such situation to happen.
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > ---
> >
>
> LGTM, with just a couple more nits.
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Thanks a lot for the quick review.

Sending the new version of just this patch now.

Cheers,
Benjamin

>
> > changes in v7:
> > - renamed access_t into atype
> > - allow zero-byte read
> > - check_mem_access() to the correct offset/size
> >
> > new in v6
> > ---
> >  kernel/bpf/verifier.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 7c1e056624f9..d5fe7e618c52 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -248,6 +248,7 @@ struct bpf_call_arg_meta {
> >         struct bpf_map *map_ptr;
> >         bool raw_mode;
> >         bool pkt_access;
> > +       bool is_kfunc;
> >         u8 release_regno;
> >         int regno;
> >         int access_size;
> > @@ -5170,6 +5171,7 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
> >                                    struct bpf_call_arg_meta *meta)
> >  {
> >         struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
> > +       enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
> >         u32 *max_access;
> >
> >         switch (base_type(reg->type)) {
> > @@ -5223,6 +5225,24 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
> >                                 env,
> >                                 regno, reg->off, access_size,
> >                                 zero_size_allowed, ACCESS_HELPER, meta);
> > +       case PTR_TO_CTX:
> > +               /* in case of a kfunc called in a program of type SYSCALL, the context is
> > +                * user supplied, so not computed statically.
> > +                * Dynamically check it now
> > +                */
> > +               if (prog_type == BPF_PROG_TYPE_SYSCALL && meta && meta->is_kfunc) {
> > +                       enum bpf_access_type atype = meta->raw_mode ? BPF_WRITE : BPF_READ;
> > +                       int offset = access_size - 1;
> > +
> > +                       /* Allow zero-byte read from NULL or PTR_TO_CTX */
>
> This will not be handling the case for NULL, only for kfunc(ptr_to_ctx, 0)
> A null pointer has its reg->type as scalar, so it will be handled by
> the default case.
>
> > +                       if (access_size == 0)
> > +                               return zero_size_allowed ? 0 : -EINVAL;
>
> We should use -EACCES, just to be consistent.
>
> > +
> > +                       return check_mem_access(env, env->insn_idx, regno, offset, BPF_B,
> > +                                               atype, -1, false);
> > +               }
> > +
> > +               fallthrough;
> >         default: /* scalar_value or invalid ptr */
> >                 /* Allow zero-byte read from NULL, regardless of pointer type */
> >                 if (zero_size_allowed && access_size == 0 &&
> > @@ -5335,6 +5355,7 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
> >         WARN_ON_ONCE(regno < BPF_REG_2 || regno > BPF_REG_5);
> >
> >         memset(&meta, 0, sizeof(meta));
> > +       meta.is_kfunc = true;
> >
> >         if (may_be_null) {
> >                 saved_reg = *mem_reg;
> > --
> > 2.36.1
> >
>

