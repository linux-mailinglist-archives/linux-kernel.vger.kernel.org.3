Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF16487894
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 14:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347697AbiAGNx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 08:53:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238992AbiAGNxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:53:23 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16ABC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 05:53:22 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f189-20020a1c1fc6000000b00347ac5ccf6cso907979wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 05:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rAxfAsKzV2Pe0qb3PwDKOtR13CrT8bc/2sOCHjuoqFw=;
        b=OnpWI4AZLiSo9UrT5h4eH13nvjqsTSeiW1oLL4Ka6pYQLm/Jtjx0PAS6xzq4VYCVnV
         MSWJ9Aux3dhfvLOyuVITNYGbWMQKWgsFtzRiWGyaZjHzXY68wuxfawTDuvIFNTL+LKct
         6jOx4FqFVkCi4Tful20rKutyNgxH4UZTLG8QHbEcMmax1z24Qb8yQTEbCn/kYgXKe3li
         7ENwqoFasvPhaIvScH8NzPGRCvW+4c0gGDqP73W5G9+ofNzusEWyiaZnFD7heQpVsfQ/
         eAlgm75uH7yookL2Ik/2V9kbMwAuhIF5PibTIZ9LSxelXbOkMaOs+N0goIrFqOey1OzL
         Q9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rAxfAsKzV2Pe0qb3PwDKOtR13CrT8bc/2sOCHjuoqFw=;
        b=BU287DhQnKhbO6xNB5Z9I/LAIRUn5zbcqHPXM9LarCGDTO5FaQv1yRVVYz7tfBzKKN
         CJBLPOPS5Yx8QstRWMrACFMkQNOLYsP7Nt+Nge9wrn6dHAqycC0KCah8fREINr5BhcD1
         HtqX7GaN6K+p1i9b82SlE3dS3/V7RzrzsETU6sVF0EcyZwIheKQpKST62K/TPw73xolB
         qyAlFmPrCKapE43dH+yZksGBEm4gFd0gqUiu2pra9kdp3gCGcQsKP/75V342zQBq7zCE
         SfC0KU5c9UUbzkYOrbq8lyzyOD4OW2Z2Hz7kV+hTL+xiNob9KF0WYfPMbvBJSvCkscvO
         OCYg==
X-Gm-Message-State: AOAM531jB+ZyMSqvQ4bzSfNHUC44PKC0uIriZ+9JrySLDUTrXqsqGRtv
        D9LZBAUjzJcW9XZTLneyB4EB2LHqxmOQzZax
X-Google-Smtp-Source: ABdhPJzKGqRpYwiwExY4pzGEPg7vMjL6mBq48LsmktgeX66Q8yaGm++enBP5DEwKO5Fkr6j8spun4Q==
X-Received: by 2002:a05:600c:1f0f:: with SMTP id bd15mr11021421wmb.2.1641563601216;
        Fri, 07 Jan 2022 05:53:21 -0800 (PST)
Received: from smtpclient.apple (global-5-143.nat-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id o8sm5849233wry.20.2022.01.07.05.53.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jan 2022 05:53:20 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v9 08/17] riscv: Add vector struct and assembler
 definitions
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAHCEehJhMQf9jtVkTvorriv6xY5QnEDmN_JjM-UxcCj9UL86Lg@mail.gmail.com>
Date:   Fri, 7 Jan 2022 13:53:20 +0000
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FAC07911-491C-46F5-AA96-7C97BC5BD7F4@jrtc27.com>
References: <15d09938180ee45bc5481c4a2d41ad656ca23c82.1636362169.git.greentime.hu@sifive.com>
 <mhng-a7a94a37-5791-4c76-8f2d-072130d71819@palmer-ri-x1c9>
 <CAHCEehJhMQf9jtVkTvorriv6xY5QnEDmN_JjM-UxcCj9UL86Lg@mail.gmail.com>
To:     Greentime Hu <greentime.hu@sifive.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Jan 2022, at 13:28, Greentime Hu <greentime.hu@sifive.com> wrote:
>=20
> Palmer Dabbelt <palmer@dabbelt.com> =E6=96=BC 2021=E5=B9=B412=E6=9C=8815=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8812:29=E5=AF=AB=E9=81=93=EF=BC=
=9A
>>=20
>> On Tue, 09 Nov 2021 01:48:20 PST (-0800), greentime.hu@sifive.com =
wrote:
>>> Add vector state context struct in struct thread and asm-offsets.c
>>> definitions.
>>>=20
>>> The vector registers will be saved in datap pointer of =
__riscv_v_state. It
>>> will be dynamically allocated in kernel space. It will be put right =
after
>>> the __riscv_v_state data structure in user space.
>>>=20
>>> Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
>>> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
>>> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
>>> ---
>>> arch/riscv/include/asm/processor.h   |  1 +
>>> arch/riscv/include/uapi/asm/ptrace.h | 11 +++++++++++
>>> arch/riscv/kernel/asm-offsets.c      |  6 ++++++
>>> 3 files changed, 18 insertions(+)
>>>=20
>>> diff --git a/arch/riscv/include/asm/processor.h =
b/arch/riscv/include/asm/processor.h
>>> index 46b492c78cbb..a268f1382e52 100644
>>> --- a/arch/riscv/include/asm/processor.h
>>> +++ b/arch/riscv/include/asm/processor.h
>>> @@ -35,6 +35,7 @@ struct thread_struct {
>>>      unsigned long s[12];    /* s[0]: frame pointer */
>>>      struct __riscv_d_ext_state fstate;
>>>      unsigned long bad_cause;
>>> +     struct __riscv_v_state vstate;
>>> };
>>>=20
>>> /* Whitelist the fstate from the task_struct for hardened usercopy =
*/
>>> diff --git a/arch/riscv/include/uapi/asm/ptrace.h =
b/arch/riscv/include/uapi/asm/ptrace.h
>>> index 882547f6bd5c..bd3b8a710246 100644
>>> --- a/arch/riscv/include/uapi/asm/ptrace.h
>>> +++ b/arch/riscv/include/uapi/asm/ptrace.h
>>> @@ -77,6 +77,17 @@ union __riscv_fp_state {
>>>      struct __riscv_q_ext_state q;
>>> };
>>>=20
>>> +struct __riscv_v_state {
>>> +     unsigned long vstart;
>>> +     unsigned long vl;
>>> +     unsigned long vtype;
>>> +     unsigned long vcsr;
>>=20
>> Don't we also need vlen to adequately determine the vector state?
>> Otherwise we're going to end up dropping some state when vl isn't =
vlmax,
>> which IIUC isn't legal.
>=20
> Do you mean vlenb? Since it is a constant value, we don't need to
> save/restore it in the context.
>=20
>>> +     void *datap;
>>> +#if __riscv_xlen =3D=3D 32
>>> +     __u32 __padding;
>>> +#endif
>>=20
>> Why is there padding?
>=20
> To keep vector registers saved in a 16-bytes aligned address for rv32.

That struct has an alignment of 4 bytes. It doesn=E2=80=99t make sense =
to put
the padding there; it should be wherever the 16 byte alignment is
introduced, which looks like your __sc_riscv_v_state below (assuming
you need to explicitly name the padding and can=E2=80=99t just rely on =
implicit
compiler padding; presumably you need it so you can guarantee it=E2=80=99s=
 zero
when written to userspace memory?).

Especially since the amount of padding you need in __riscv_v_state if
doing it this way depends on the size of __riscv_ctx_hdr, because that
happens to be in __sc_riscv_v_state. This is quite fragile and
non-obvious as it stands.

Jess

> struct __riscv_ctx_hdr {
>        __u32 magic;
>        __u32 size;
> };
> struct __sc_riscv_v_state {
>        struct __riscv_ctx_hdr head;
>        struct __riscv_v_state v_state;
> } __attribute__((aligned(16)));
>=20
> rv64 =3D> 48bytes -> 16byte aligned
> rv32 =3D> 32bytes -> 16byte aligned
>=20
> This struct and vector registers will be copied to
> sigcontext.reserved[] for signal handler so we'd like to keep it is
> 16-byte aligned.
>=20
> struct sigcontext {
>        struct user_regs_struct sc_regs;
>        union __riscv_fp_state sc_fpregs;
>        /*
>         * 4K + 128 reserved for vector state and future expansion.
>         * This space is enough to store the vector context whose VLENB
>         * is less or equal to 128.
>         * (The size of the vector context is 4144 byte as VLENB is =
128)
>         */
>        __u8 __reserved[4224] __attribute__((__aligned__(16)));
> };
>=20
>=20
>>> +};
>>> +
>>> #endif /* __ASSEMBLY__ */
>>>=20
>>> #endif /* _UAPI_ASM_RISCV_PTRACE_H */
>>> diff --git a/arch/riscv/kernel/asm-offsets.c =
b/arch/riscv/kernel/asm-offsets.c
>>> index 90f8ce64fa6f..34f43c84723a 100644
>>> --- a/arch/riscv/kernel/asm-offsets.c
>>> +++ b/arch/riscv/kernel/asm-offsets.c
>>> @@ -72,6 +72,12 @@ void asm_offsets(void)
>>>      OFFSET(TSK_STACK_CANARY, task_struct, stack_canary);
>>> #endif
>>>=20
>>> +     OFFSET(RISCV_V_STATE_VSTART, __riscv_v_state, vstart);
>>> +     OFFSET(RISCV_V_STATE_VL, __riscv_v_state, vl);
>>> +     OFFSET(RISCV_V_STATE_VTYPE, __riscv_v_state, vtype);
>>> +     OFFSET(RISCV_V_STATE_VCSR, __riscv_v_state, vcsr);
>>> +     OFFSET(RISCV_V_STATE_DATAP, __riscv_v_state, datap);
>>> +
>>>      DEFINE(PT_SIZE, sizeof(struct pt_regs));
>>>      OFFSET(PT_EPC, pt_regs, epc);
>>>      OFFSET(PT_RA, pt_regs, ra);
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

