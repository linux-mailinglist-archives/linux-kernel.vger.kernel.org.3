Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB708551FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbiFTPFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241048AbiFTPEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:04:46 -0400
Received: from forward501j.mail.yandex.net (forward501j.mail.yandex.net [5.45.198.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6602DCE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 07:40:13 -0700 (PDT)
Received: from sas2-4b68358e232a.qloud-c.yandex.net (sas2-4b68358e232a.qloud-c.yandex.net [IPv6:2a02:6b8:c08:6803:0:640:4b68:358e])
        by forward501j.mail.yandex.net (Yandex) with ESMTP id 67C8E6237C1;
        Mon, 20 Jun 2022 17:40:11 +0300 (MSK)
Received: from sas1-1f4a002bb12a.qloud-c.yandex.net (sas1-1f4a002bb12a.qloud-c.yandex.net [2a02:6b8:c14:3908:0:640:1f4a:2b])
        by sas2-4b68358e232a.qloud-c.yandex.net (mxback/Yandex) with ESMTP id ld9oySLxkA-e8fqEW2c;
        Mon, 20 Jun 2022 17:40:11 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1655736011;
        bh=9KhuHwBW1BLeXqIGFoV6GgamoThrMvdQ7vOpwMEvjvs=;
        h=In-Reply-To:Subject:Cc:To:From:References:Date:Message-ID;
        b=e2BwUtCpX3/VJ6cnQoA9FwxleXqizx9JHvaXeau6BnGZbAOcCmXGvE1psq2m+0yrY
         fMMlPZbTvqOZs6bG/fFxkRgNyanAstKuOWbzRvXYz1vNxDGKCRhIzX8jBENfct/p26
         x5qoXM5iORvTTIrb8M1qvoN5fbTBuXGTO/tHjDrM=
Authentication-Results: sas2-4b68358e232a.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by sas1-1f4a002bb12a.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id s10qvb0JwR-e7NaGZRG;
        Mon, 20 Jun 2022 17:40:08 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Mon, 20 Jun 2022 17:40:06 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Will Deacon <will@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        =?UTF-8?B?Sm/Do28gTcOhcmlv?= Domingos 
        <joao.mario@tecnico.ulisboa.pt>, linux <linux@yadro.com>,
        Nikita Shubin <n.shubin@yadro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 1/1] RISC-V: Create unique identification for SoC PMU
Message-ID: <20220620174006.1c86a456@redslave.neermore.group>
In-Reply-To: <CAK9=C2X4TTCEjZya4wz-W6ndBaxzUpLBtzQAGJ4zphVM8NSgdg@mail.gmail.com>
References: <20220619111115.6354-1-nikita.shubin@maquefel.me>
        <20220619111115.6354-2-nikita.shubin@maquefel.me>
        <CAK9=C2X4TTCEjZya4wz-W6ndBaxzUpLBtzQAGJ4zphVM8NSgdg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jun 2022 17:30:58 +0530
Anup Patel <apatel@ventanamicro.com> wrote:

> On Sun, Jun 19, 2022 at 4:41 PM Nikita Shubin
> <nikita.shubin@maquefel.me> wrote:
> >
> > From: Nikita Shubin <n.shubin@yadro.com>
> >
> > Provide RISC-V SBI PMU id to distinguish different cores or SoCs via
> > "devices/platform/riscv-pmu/id" sysfs entry.
> >
> > The identification is generated as string of marchid, mimpid,
> > mvendorid in hex format separated by coma - "0x70032,0x70032,0x0".
> >
> > The CSRs are detailed in the RISC-V privileged spec [1].
> > [1] https://github.com/riscv/riscv-isa-manual
> >
> > Inspired-by: Jo=C3=A3o M=C3=A1rio Domingos <joao.mario@tecnico.ulisboa.=
pt>
> > Signed-off-by: Nikita Shubin <n.shubin@yadro.com> =20
>=20
> The mvendorid, marchid, and mimpid can be useful to apps other than
> perf tool.
>=20
> I have tried to extend /proc/cpuinfo with this information which can
> be parsed by perf tool:
> https://lore.kernel.org/all/20220620115549.1529597-1-apatel@ventanamicro.=
com/

Atish, what do you think about this ?

RISC-V perf can rely on "/proc/cpuinfo", in some similar manner like
"tools/perf/arch/s390/util/header.c" does.

Can it create problems with pmu identification in case of hetergenous
harts ?

>=20
> Regards,
> Anup
>=20
> > ---
> > v3->v4:
> > - use string for pmuid
> > - rename pmu_sbi_id_show to id_show
> > - fix error print message in id_show
> > - fix DEVICE_ATTR to use octal permissions
> > ---
> >  arch/riscv/kernel/sbi.c        |  3 +++
> >  drivers/perf/riscv_pmu_sbi.c   | 41
> > ++++++++++++++++++++++++++++++++++ include/linux/perf/riscv_pmu.h |
> >  1 + 3 files changed, 45 insertions(+)
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
> > b/drivers/perf/riscv_pmu_sbi.c index dca3537a8dcc..be812f855617
> > 100644 --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -693,6 +693,28 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu
> > *pmu, struct platform_device *pde return 0;
> >  }
> >
> > +static ssize_t id_show(struct device *dev,
> > +                               struct device_attribute *attr, char
> > *buf) +{
> > +       int len;
> > +       struct riscv_pmu *pmu =3D container_of(dev_get_drvdata(dev),
> > struct riscv_pmu, pmu); +
> > +       len =3D sprintf(buf, "%s\n", pmu->pmuid);
> > +       if (len <=3D 0)
> > +               dev_err(dev, "invalid sprintf len: %d\n", len);
> > +
> > +       return len;
> > +}
> > +
> > +static DEVICE_ATTR(id, 0644, id_show, NULL);
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
> > @@ -714,6 +736,14 @@ static int pmu_sbi_device_probe(struct
> > platform_device *pdev) if (pmu_sbi_get_ctrinfo(num_counters))
> >                 goto out_free;
> >
> > +       /* fill pmuid */
> > +       pmu->pmuid =3D kasprintf(GFP_KERNEL, "0x%lx,0x%lx,0x%lx",
> > +                              sbi_get_marchid(),
> > +                              sbi_get_mimpid(),
> > +                              sbi_get_mvendorid());
> > +       if (!pmu->pmuid)
> > +               goto out_free_pmuid;
> > +
> >         ret =3D pmu_sbi_setup_irqs(pmu, pdev);
> >         if (ret < 0) {
> >                 pr_info("Perf sampling/filtering is not supported
> > as sscof extension is not available\n"); @@ -739,8 +769,19 @@
> > static int pmu_sbi_device_probe(struct platform_device *pdev)
> > return ret; }
> >
> > +       ret =3D sysfs_create_group(&pdev->dev.kobj, &pmu_sbi_group);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "sysfs creation failed\n");
> > +               return ret;
> > +       }
> > +
> > +       pdev->dev.groups =3D pmu_sbi_groups;
> > +       dev_set_drvdata(&pdev->dev, pmu);
> > +
> >         return 0;
> >
> > +out_free_pmuid:
> > +       kfree(pmu->pmuid);
> >  out_free:
> >         kfree(pmu);
> >         return ret;
> > diff --git a/include/linux/perf/riscv_pmu.h
> > b/include/linux/perf/riscv_pmu.h index 46f9b6fe306e..cf3557b77fb8
> > 100644 --- a/include/linux/perf/riscv_pmu.h
> > +++ b/include/linux/perf/riscv_pmu.h
> > @@ -42,6 +42,7 @@ struct cpu_hw_events {
> >  struct riscv_pmu {
> >         struct pmu      pmu;
> >         char            *name;
> > +       char            *pmuid;
> >
> >         irqreturn_t     (*handle_irq)(int irq_num, void *dev);
> >
> > --
> > 2.35.1
> > =20

