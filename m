Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9B35AC7D7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbiIDVuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236271AbiIDVuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:50:03 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D556C3AE5A
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:46:02 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w5so9001513wrn.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
        bh=87Me0qXRlC4mDmY4jonV8W1fOSQITeb0ij4GwdZhmvw=;
        b=l94O0HQ6NzjN+NULQSM+r8Mm9NF3gqJFm3MCVsaj3eG21jEe6fKeP58Z5C3kzj9ldP
         zPq6LbEIsbP4t3+S0yO4DHtCvuip3yDFmoemdt01WCxSJCFxlaLEkEBInJBv4bTqSPZI
         9km2EBNmFxR31G+VBkgO6hAwqP0/95TP0q2hZQVySU59c87SNb3Zi8ag7mc3rmB++gU4
         x8yJJ3SeXSGFrFR7jvkg2xDXVWub2+drncIg63o/kVKmljIvLgj6sZ4CL3zKyQ6M+KI/
         kjQP93iMNHOjrcWBIHFqZqRzQr39zj6MHxsLZEDEF7XZKUeFIsr6AgJZfc/llSPgwiJb
         WrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=87Me0qXRlC4mDmY4jonV8W1fOSQITeb0ij4GwdZhmvw=;
        b=CAkvZNbJVyuP2VnCOeaAtN2on3pIQ+flnxmDmBXL+EZZ7/BJ4r3uCt0cg2pFj6iyj0
         tBpkbkA8srQwpom3sNBhzBEKkuws6iV9f3KTNoBwLwwo2o7QimNAwRMk0yBbGaPDO67y
         PWIIowWMCCxivscYnS7SCdaw0otsG5VOKzaEzAl+0Xwn7iOU4ONLyAhZitWfX+Wj7G8i
         oniSjlDDjV0cExYTIdYj/Yebf+Ltij5LwrZPS5w8qCyFUNVnB8rM4Ss7jdj2N0iiRAMT
         nrCDjEQYmvIXGeOsoHw22zEH30tp0pmmtSJ0Rpw/KR2ZIb4prcs6BStFT3YInaNdRVXX
         5rqg==
X-Gm-Message-State: ACgBeo14uZ17dNolxc2gTxERbq2A6gQuNccdY0L3oapdGVH185C+ZZel
        FtR77Rk3ZUJTuSslEge3taf/Ww==
X-Google-Smtp-Source: AA6agR5ywNDBMTZ5Uf4WAvvAi0cTjuxeGFYSLL5RgLZb3PlGsYof1QSK08Yqs7JUgpsSp2g3XhQ90g==
X-Received: by 2002:a5d:4e4f:0:b0:228:855d:84f6 with SMTP id r15-20020a5d4e4f000000b00228855d84f6mr1321895wrt.370.1662327924965;
        Sun, 04 Sep 2022 14:45:24 -0700 (PDT)
Received: from smtpclient.apple (global-5-141.n-2.net.cam.ac.uk. [131.111.5.141])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d5012000000b00226dedf1ab7sm1846442wrt.76.2022.09.04.14.45.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Sep 2022 14:45:24 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v9 1/7] RISC-V: Clear SIP bit only when using SBI IPI
 operations
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAK9=C2U5MjF+qv9z=_cSS4iN66dCY_goF0D_-ujcPPG9VrReDw@mail.gmail.com>
Date:   Sun, 4 Sep 2022 22:45:23 +0100
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bin Meng <bmeng.cn@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E4342C74-F530-4F7F-B5EE-B86F3682D7A8@jrtc27.com>
References: <20220903161309.32848-1-apatel@ventanamicro.com>
 <20220903161309.32848-2-apatel@ventanamicro.com>
 <6ABE254E-C7DA-468B-9A6B-D10FF32E0E89@jrtc27.com>
 <CAK9=C2U5MjF+qv9z=_cSS4iN66dCY_goF0D_-ujcPPG9VrReDw@mail.gmail.com>
To:     Anup Patel <apatel@ventanamicro.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Sept 2022, at 05:39, Anup Patel <apatel@ventanamicro.com> wrote:
>=20
> On Sun, Sep 4, 2022 at 1:46 AM Jessica Clarke <jrtc27@jrtc27.com> =
wrote:
>>=20
>> ]On 3 Sept 2022, at 17:13, Anup Patel <apatel@ventanamicro.com> =
wrote:
>>>=20
>>> The software interrupt pending (i.e. [M|S]SIP) bit is writeable for
>>> S-mode but read-only for M-mode so we clear this bit only when using
>>> SBI IPI operations.
>>=20
>> Uh, where is this specified? I don=E2=80=99t see that, and that would =
be odd.
>> The spec clearly says that if supervisor software interrupts are
>> implemented then the bit is writeable, with no caveats on when =
(beyond
>> the permissions required to access the CSR in general).
>=20
> For mip.MSIP, refer the below text from section 3.1.9 of the RISC-V =
privileged
> specification:
>=20
> "MSIP is read-only in mip, and is written by accesses to memory-mapped
> control registers, which are used by remote harts to provide =
machine-level
> interprocessor interrupts."
>=20
> For sip.SSIP, refer the below text from section 4.1.3 of the RISC-V =
privileged
> specification:
>=20
> "If implemented, SSIP is writable in sip and may also be set to 1 by a
> platform-specific interrupt controller."

I misinterpreted you; I thought you were saying SSIP could be set from
S-mode but not M-mode, not that you were talking about the bit
corresponding to the mode. I agree MSIP is different to SSIP
(unfortunately).

>> This patch does make sense for a different reason though: that IPIs =
may
>> not be using software interrupts at all (in the IMSIC case).
>=20
> Sure, let me help you understand this better.
>=20
> The IPI support in Linux RISC-V does not assume any particular IPI
> mechanism. In fact, we will be supporting multiple IPI mechanism in
> Linux RISC-V and one of these will be selected at boot-time based
> on platform capabilities:
>=20
> 1) Linux RISC-V NoMMU (M-mode) kernel will use IPIs provided by
> the CLINT timer driver (refer, drivers/clocksource/timer-clint.c). =
This
> mechanism uses the CLINT MMIO registers to update the state of
> mip.MSIP bit. The M-mode kernel cannot directly modify the mip.MSIP
> bit without going through the CLINT MMIO registers.
>=20
> 2) Linux RISC-V MMU (S-mode) kernel without IMSIC will use IPIs
> provided by the SBI IPI calls (refer, arch/riscv/kernel/sbi.c). This
> mechanism uses the SBI SEND_IPI call which sets the sip.SSIP
> bit from M-mode firmware and kernel itself will clear sip.SSIP bit
> after handling IPI on target HART.
>=20
> 3) Linux RISC-V MMU (S-mode) kernel with IMSIC will use IPIs
> as software injected MSIs (refer,
> =
https://github.com/avpatel/linux/blob/riscv_aia_v1/drivers/irqchip/irq-ris=
cv-imsic.c).
> This mechanism does not use "Software Interrupt" bits defined in
> the mip/sip CSR. Instead IPIs are regular external interrupts injected
> via IMSIC and imsic_handle_irq() of the IMSIC driver clears the
> IPI pending through stopei CSR.
>=20
> Currently, we were blindly clearing mip.[M|S]SIP bit in =
riscv_clear_ipi()
> which is a common function for all three mechanisms above which
> is not right considering the diversity in IPI mechanisms supported
> by Linux RISC-V.
>=20
> This patch moves the clearing of SSIP bit to SBI IPI code so that it =
is
> only done for mechanism #2 (described above) and not done for
> mechanisms #1 & #3 (described above).

Yes, that=E2=80=99s what I was trying to communicate as to what the =
motivation
of the patch should be (though omitted the M-mode case because I
sometimes forget that Linux tries to support this odd-ball
configuration). I always agreed with the content of the patch, just
disagreed with the message. Now you=E2=80=99ve explained what you meant =
I don=E2=80=99t
think it=E2=80=99s wrong, but I do think it could be clearer, especially =
since
the IMSIC case (and I guess ACLINT SSWI too, which is yet another
option) should be stated to justify why it=E2=80=99s tied to the SBI IPI
implementation and not under !IS_ENABLED(CONFIG_RISCV_M_MODE).

Jess

> Regards,
> Anup
>=20
>>=20
>> Jess
>>=20
>>> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>>> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
>>> ---
>>> arch/riscv/kernel/sbi.c | 8 +++++++-
>>> arch/riscv/kernel/smp.c | 2 --
>>> 2 files changed, 7 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
>>> index 775d3322b422..fc614650a2e3 100644
>>> --- a/arch/riscv/kernel/sbi.c
>>> +++ b/arch/riscv/kernel/sbi.c
>>> @@ -643,8 +643,14 @@ static void sbi_send_cpumask_ipi(const struct =
cpumask *target)
>>>      sbi_send_ipi(target);
>>> }
>>>=20
>>> +static void sbi_ipi_clear(void)
>>> +{
>>> +     csr_clear(CSR_IP, IE_SIE);
>>> +}
>>> +
>>> static const struct riscv_ipi_ops sbi_ipi_ops =3D {
>>> -     .ipi_inject =3D sbi_send_cpumask_ipi
>>> +     .ipi_inject =3D sbi_send_cpumask_ipi,
>>> +     .ipi_clear =3D sbi_ipi_clear
>>> };
>>>=20
>>> void __init sbi_init(void)
>>> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
>>> index 760a64518c58..c56d67f53ea9 100644
>>> --- a/arch/riscv/kernel/smp.c
>>> +++ b/arch/riscv/kernel/smp.c
>>> @@ -83,8 +83,6 @@ void riscv_clear_ipi(void)
>>> {
>>>      if (ipi_ops && ipi_ops->ipi_clear)
>>>              ipi_ops->ipi_clear();
>>> -
>>> -     csr_clear(CSR_IP, IE_SIE);
>>> }
>>> EXPORT_SYMBOL_GPL(riscv_clear_ipi);
>>>=20
>>> --
>>> 2.34.1
>>>=20
>>>=20
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>=20

