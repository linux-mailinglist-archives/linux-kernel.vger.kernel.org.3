Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE44542B82
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiFHJZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbiFHJZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:25:16 -0400
X-Greylist: delayed 70217 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Jun 2022 01:47:22 PDT
Received: from forward500j.mail.yandex.net (forward500j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E122124A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:47:21 -0700 (PDT)
Received: from vla1-6796d9dd75b4.qloud-c.yandex.net (vla1-6796d9dd75b4.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:518f:0:640:6796:d9dd])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id 23B396CB6FDA;
        Wed,  8 Jun 2022 11:47:19 +0300 (MSK)
Received: from vla5-3832771863b8.qloud-c.yandex.net (vla5-3832771863b8.qloud-c.yandex.net [2a02:6b8:c18:3417:0:640:3832:7718])
        by vla1-6796d9dd75b4.qloud-c.yandex.net (mxback/Yandex) with ESMTP id wZforJNtKg-lHfW1R9F;
        Wed, 08 Jun 2022 11:47:19 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1654678039;
        bh=kJRph6KRLggjdnB4kRNp3R8IpwrXtJ9L63C1WZIOf6o=;
        h=In-Reply-To:Subject:Cc:To:From:References:Date:Message-ID;
        b=H8JvBCdhmkU8EzCfdJIP0ALb48Cum9Cadp2KNOQW8Oqs4K4elYv5+6Qa0mC/HBJP+
         0MXswL5D1Cib7JsQZjrm8M5tZhpqD6v7XdU6YTZjjudSgZtQ0B7TY1QvHUgcG8xCnP
         aOHb1Q+keoU6CxD8/NqTQ5JKNwh7LDZA8S0g1QII=
Authentication-Results: vla1-6796d9dd75b4.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by vla5-3832771863b8.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id V56VOmdH7z-lFN0tPc1;
        Wed, 08 Jun 2022 11:47:15 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Wed, 8 Jun 2022 11:47:12 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Genevieve Chan <genevieve.chan@starfivetech.com>,
        =?UTF-8?B?Sm/Do28g?= =?UTF-8?B?TcOhcmlv?= Domingos 
        <joao.mario@tecnico.ulisboa.pt>,
        Nikita Shubin <n.shubin@yadro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/4] RISC-V: Create unique identification for SoC PMU
Message-ID: <20220608114712.608239a5@redslave.neermore.group>
In-Reply-To: <CAOnJCULuQw2E3cD5KQKVs8EbcbPPeJQDqvikagxnkDSH+UWqjQ@mail.gmail.com>
References: <20220607131648.29439-1-nikita.shubin@maquefel.me>
        <20220607131648.29439-2-nikita.shubin@maquefel.me>
        <CAOnJCULuQw2E3cD5KQKVs8EbcbPPeJQDqvikagxnkDSH+UWqjQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Atish!

On Tue, 7 Jun 2022 09:37:19 -0700
Atish Patra <atishp@atishpatra.org> wrote:

> On Tue, Jun 7, 2022 at 6:17 AM Nikita Shubin
> <nikita.shubin@maquefel.me> wrote:
> >
> > From: Jo=C3=A3o M=C3=A1rio Domingos <joao.mario@tecnico.ulisboa.pt>
> >
> > The SBI PMU platform driver did not provide any identification for
> > perf events matching. This patch introduces a new sysfs file inside
> > the platform device (soc:pmu/id) for pmu identification.
> >
> > The identification is a 64-bit value generated as:
> > [63-32]: mvendorid;
> > [31]: marchid[MSB];
> > [30-16]: marchid[15-0];
> > [15-0]: mimpid[15MSBs];
> > =20
>=20
> This is not entirely correct as marchid or mimpid can be MXLEN. The
> encoding scheme is left upto the
> vendor. We can not assume anything about it.
>=20
> The purpose of the PMU ID is to distinguish between different
> vendors/generations. The perf tool expects
> a json string.
> I think you can just keep all these 3 registers into the JSON string
> as it is to avoid any pitfalls with vendor weirdness.

This make sense to me. I'll rework this patch according your
suggestions.

Yours,
Nikita Shubin.

>=20
> > The CSRs are detailed in the RISC-V privileged spec [1].
> > The marchid is split in MSB + 15LSBs, due to the MSB being used for
> > open-source architecture identification.
> >
> > [1] https://github.com/riscv/riscv-isa-manual
> >
> > Signed-off-by: Jo=C3=A3o M=C3=A1rio Domingos <joao.mario@tecnico.ulisbo=
a.pt>
> > Tested-by: Nikita Shubin <n.shubin@yadro.com>
> > ---
> >  arch/riscv/kernel/sbi.c      |  3 +++
> >  drivers/perf/riscv_pmu_sbi.c | 47
> > ++++++++++++++++++++++++++++++++++++ 2 files changed, 50
> > insertions(+)
> >
> > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > index 775d3322b422..50dd9b6ecc9e 100644
> > --- a/arch/riscv/kernel/sbi.c
> > +++ b/arch/riscv/kernel/sbi.c
> > @@ -627,16 +627,19 @@ long sbi_get_mvendorid(void)
> >  {
> >         return __sbi_base_ecall(SBI_EXT_BASE_GET_MVENDORID);
> >  }
> > +EXPORT_SYMBOL(sbi_get_mvendorid);
> >
> >  long sbi_get_marchid(void)
> >  {
> >         return __sbi_base_ecall(SBI_EXT_BASE_GET_MARCHID);
> >  }
> > +EXPORT_SYMBOL(sbi_get_marchid);
> >
> >  long sbi_get_mimpid(void)
> >  {
> >         return __sbi_base_ecall(SBI_EXT_BASE_GET_MIMPID);
> >  }
> > +EXPORT_SYMBOL(sbi_get_mimpid);
> >
> >  static void sbi_send_cpumask_ipi(const struct cpumask *target)
> >  {
> > diff --git a/drivers/perf/riscv_pmu_sbi.c
> > b/drivers/perf/riscv_pmu_sbi.c index a1317a483512..15ab3dc68e7a
> > 100644 --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -693,6 +693,46 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu
> > *pmu, struct platform_device *pde return 0;
> >  }
> >
> > +static uint64_t pmu_sbi_get_pmu_id(void)
> > +{
> > +       union sbi_pmu_id {
> > +               uint64_t value;
> > +               struct {
> > +                       uint16_t imp:16;
> > +                       uint16_t arch:16;
> > +                       uint32_t vendor:32;
> > +               };
> > +       } pmuid;
> > +
> > +       pmuid.value =3D 0;
> > +       pmuid.vendor =3D (uint32_t) sbi_get_mvendorid();
> > +       pmuid.arch =3D (sbi_get_marchid() >> (63 - 15) & (1 << 15)) |
> > (sbi_get_marchid() & 0x7FFF);
> > +       pmuid.imp =3D (sbi_get_mimpid() >> 16);
> > +
> > +       return pmuid.value;
> > +}
> > +
> > +static ssize_t pmu_sbi_id_show(struct device *dev,
> > +               struct device_attribute *attr, char *buf)
> > +{
> > +       int len;
> > +
> > +       len =3D sprintf(buf, "0x%llx\n", pmu_sbi_get_pmu_id());
> > +       if (len <=3D 0)
> > +               dev_err(dev, "mydrv: Invalid sprintf len: %dn",
> > len); +
> > +       return len;
> > +}
> > +
> > +static DEVICE_ATTR(id, S_IRUGO | S_IWUSR, pmu_sbi_id_show, 0);
> > +
> > +static struct attribute *pmu_sbi_attrs[] =3D {
> > +       &dev_attr_id.attr,
> > +       NULL
> > +};
> > +
> > +ATTRIBUTE_GROUPS(pmu_sbi);
> > +
> >  static int pmu_sbi_device_probe(struct platform_device *pdev)
> >  {
> >         struct riscv_pmu *pmu =3D NULL;
> > @@ -729,6 +769,13 @@ static int pmu_sbi_device_probe(struct
> > platform_device *pdev) pmu->ctr_clear_idx =3D pmu_sbi_ctr_clear_idx;
> >         pmu->ctr_read =3D pmu_sbi_ctr_read;
> >
> > +       ret =3D sysfs_create_group(&pdev->dev.kobj, &pmu_sbi_group);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "sysfs creation failed\n");
> > +               return ret;
> > +       }
> > +       pdev->dev.groups =3D pmu_sbi_groups;
> > +
> >         ret =3D
> > cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
> > if (ret) return ret;
> > --
> > 2.35.1
> > =20
>=20
>=20
> --
> Regards,
> Atish

