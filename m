Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C255524A6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 21:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244213AbiFTTkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 15:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbiFTTke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 15:40:34 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8D8764E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 12:40:32 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id t1so20745482ybd.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 12:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MF9w10rX2iwd2h9iSBKKxPfiedtUNAOz+4kVUvfb89E=;
        b=GG1JkThoq/+mdEhocGlISJpVEjHwAeMStlF2BWci9LDLNiYtOlkacsBNZIpZecrjsh
         fdXdX+wm2DII0sQ2l84LTw9a/+ECRVwrXXQMYmTPPX4YFQciutNx+K6WKcrFhhntyfrc
         nVkj0ns8Zakha5fZW91ck71QyOYRNYgY4qVg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MF9w10rX2iwd2h9iSBKKxPfiedtUNAOz+4kVUvfb89E=;
        b=Me9/g6fz1aSX6g0uB8nlS+gTviUghSJwZGmr1eoU4w4hTjTHvI9xCBGlG5anRw/Tlr
         UOit9s9cMNNXhtd96Qz5mxGKxOfbO9tP5Na6hVm+CrvHaMBHf0WEx718n7yuf3WK29T1
         lE3+vW2wUhmoEIpezagpP7io1kD06yGD/E6ieeZ5HQeaNtBTPurJ2ui9mAY5yVbBGNrO
         UdpRxoJq3Zazc38exvQBhVeykdQHEwI1VviCz4x2JOdfELoOeiNrBCQfXXveYr+knFnb
         GqLq5+Kl2WIMa1QV1HsnrP8M4zQCeNLBqJp/8WgzYGQ0sYeixJpDS0lLlDc8ayJaXbx2
         bAjA==
X-Gm-Message-State: AJIora+usMDrmbzJ8HgXSAmcVZkn5xNYGUICP/s/x3O15MbcrWh8nTBR
        v38IMQXyTksXdS9C+v0Qjze8iToXyAq7xgsP7oQp
X-Google-Smtp-Source: AGRyM1vHKyKvtBgGAkqodprREujJq6noPO8phYFn9Ku3wdUySOubjCEpjD6+RZIwfTH5ngx3N8ua9ZZ8yggE0FO1wYY=
X-Received: by 2002:a25:2612:0:b0:664:b1e1:3774 with SMTP id
 m18-20020a252612000000b00664b1e13774mr26937447ybm.228.1655754031926; Mon, 20
 Jun 2022 12:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220619111115.6354-1-nikita.shubin@maquefel.me>
 <20220619111115.6354-2-nikita.shubin@maquefel.me> <CAK9=C2X4TTCEjZya4wz-W6ndBaxzUpLBtzQAGJ4zphVM8NSgdg@mail.gmail.com>
 <20220620174006.1c86a456@redslave.neermore.group>
In-Reply-To: <20220620174006.1c86a456@redslave.neermore.group>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 20 Jun 2022 12:40:20 -0700
Message-ID: <CAOnJCU+7_z1WN_Z6frQcUwzztVL4itbPSfmLUa_7Ob5xCtLo+Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] RISC-V: Create unique identification for SoC PMU
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Will Deacon <will@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        =?UTF-8?B?Sm/Do28gTcOhcmlvIERvbWluZ29z?= 
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
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Jun 20, 2022 at 7:40 AM Nikita Shubin <nikita.shubin@maquefel.me> w=
rote:
>
> On Mon, 20 Jun 2022 17:30:58 +0530
> Anup Patel <apatel@ventanamicro.com> wrote:
>
> > On Sun, Jun 19, 2022 at 4:41 PM Nikita Shubin
> > <nikita.shubin@maquefel.me> wrote:
> > >
> > > From: Nikita Shubin <n.shubin@yadro.com>
> > >
> > > Provide RISC-V SBI PMU id to distinguish different cores or SoCs via
> > > "devices/platform/riscv-pmu/id" sysfs entry.
> > >
> > > The identification is generated as string of marchid, mimpid,
> > > mvendorid in hex format separated by coma - "0x70032,0x70032,0x0".
> > >
> > > The CSRs are detailed in the RISC-V privileged spec [1].
> > > [1] https://github.com/riscv/riscv-isa-manual
> > >
> > > Inspired-by: Jo=C3=A3o M=C3=A1rio Domingos <joao.mario@tecnico.ulisbo=
a.pt>
> > > Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
> >
> > The mvendorid, marchid, and mimpid can be useful to apps other than
> > perf tool.
> >
> > I have tried to extend /proc/cpuinfo with this information which can
> > be parsed by perf tool:
> > https://lore.kernel.org/all/20220620115549.1529597-1-apatel@ventanamicr=
o.com/
>
> Atish, what do you think about this ?
>
> RISC-V perf can rely on "/proc/cpuinfo", in some similar manner like
> "tools/perf/arch/s390/util/header.c" does.
>

Yes. We can expose these three values either in sysfs or procfs (/proc/cpui=
nfo).
For perf tool, it shouldn't matter as the header.c will need to
generate the unique cpuid
string from either.

I am not sure if any other userspace tool prefers to parse sysfs
instead of cpuinfo.

> Can it create problems with pmu identification in case of hetergenous
> harts ?
>

Does perf support hetergenous harts at all ? ARM64 code
(tool/perf/arch/arm64/util/header.c)
just breaks out of the loop after finding the first MIDR.

> >
> > Regards,
> > Anup
> >
> > > ---
> > > v3->v4:
> > > - use string for pmuid
> > > - rename pmu_sbi_id_show to id_show
> > > - fix error print message in id_show
> > > - fix DEVICE_ATTR to use octal permissions
> > > ---
> > >  arch/riscv/kernel/sbi.c        |  3 +++
> > >  drivers/perf/riscv_pmu_sbi.c   | 41
> > > ++++++++++++++++++++++++++++++++++ include/linux/perf/riscv_pmu.h |
> > >  1 + 3 files changed, 45 insertions(+)
> > >
> > > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > > index 775d3322b422..50dd9b6ecc9e 100644
> > > --- a/arch/riscv/kernel/sbi.c
> > > +++ b/arch/riscv/kernel/sbi.c
> > > @@ -627,16 +627,19 @@ long sbi_get_mvendorid(void)
> > >  {
> > >         return __sbi_base_ecall(SBI_EXT_BASE_GET_MVENDORID);
> > >  }
> > > +EXPORT_SYMBOL(sbi_get_mvendorid);
> > >
> > >  long sbi_get_marchid(void)
> > >  {
> > >         return __sbi_base_ecall(SBI_EXT_BASE_GET_MARCHID);
> > >  }
> > > +EXPORT_SYMBOL(sbi_get_marchid);
> > >
> > >  long sbi_get_mimpid(void)
> > >  {
> > >         return __sbi_base_ecall(SBI_EXT_BASE_GET_MIMPID);
> > >  }
> > > +EXPORT_SYMBOL(sbi_get_mimpid);
> > >
> > >  static void sbi_send_cpumask_ipi(const struct cpumask *target)
> > >  {
> > > diff --git a/drivers/perf/riscv_pmu_sbi.c
> > > b/drivers/perf/riscv_pmu_sbi.c index dca3537a8dcc..be812f855617
> > > 100644 --- a/drivers/perf/riscv_pmu_sbi.c
> > > +++ b/drivers/perf/riscv_pmu_sbi.c
> > > @@ -693,6 +693,28 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu
> > > *pmu, struct platform_device *pde return 0;
> > >  }
> > >
> > > +static ssize_t id_show(struct device *dev,
> > > +                               struct device_attribute *attr, char
> > > *buf) +{
> > > +       int len;
> > > +       struct riscv_pmu *pmu =3D container_of(dev_get_drvdata(dev),
> > > struct riscv_pmu, pmu); +
> > > +       len =3D sprintf(buf, "%s\n", pmu->pmuid);
> > > +       if (len <=3D 0)
> > > +               dev_err(dev, "invalid sprintf len: %d\n", len);
> > > +
> > > +       return len;
> > > +}
> > > +
> > > +static DEVICE_ATTR(id, 0644, id_show, NULL);
> > > +
> > > +static struct attribute *pmu_sbi_attrs[] =3D {
> > > +       &dev_attr_id.attr,
> > > +       NULL
> > > +};
> > > +
> > > +ATTRIBUTE_GROUPS(pmu_sbi);
> > > +
> > >  static int pmu_sbi_device_probe(struct platform_device *pdev)
> > >  {
> > >         struct riscv_pmu *pmu =3D NULL;
> > > @@ -714,6 +736,14 @@ static int pmu_sbi_device_probe(struct
> > > platform_device *pdev) if (pmu_sbi_get_ctrinfo(num_counters))
> > >                 goto out_free;
> > >
> > > +       /* fill pmuid */
> > > +       pmu->pmuid =3D kasprintf(GFP_KERNEL, "0x%lx,0x%lx,0x%lx",
> > > +                              sbi_get_marchid(),
> > > +                              sbi_get_mimpid(),
> > > +                              sbi_get_mvendorid());
> > > +       if (!pmu->pmuid)
> > > +               goto out_free_pmuid;
> > > +
> > >         ret =3D pmu_sbi_setup_irqs(pmu, pdev);
> > >         if (ret < 0) {
> > >                 pr_info("Perf sampling/filtering is not supported
> > > as sscof extension is not available\n"); @@ -739,8 +769,19 @@
> > > static int pmu_sbi_device_probe(struct platform_device *pdev)
> > > return ret; }
> > >
> > > +       ret =3D sysfs_create_group(&pdev->dev.kobj, &pmu_sbi_group);
> > > +       if (ret) {
> > > +               dev_err(&pdev->dev, "sysfs creation failed\n");
> > > +               return ret;
> > > +       }
> > > +
> > > +       pdev->dev.groups =3D pmu_sbi_groups;
> > > +       dev_set_drvdata(&pdev->dev, pmu);
> > > +
> > >         return 0;
> > >
> > > +out_free_pmuid:
> > > +       kfree(pmu->pmuid);
> > >  out_free:
> > >         kfree(pmu);
> > >         return ret;
> > > diff --git a/include/linux/perf/riscv_pmu.h
> > > b/include/linux/perf/riscv_pmu.h index 46f9b6fe306e..cf3557b77fb8
> > > 100644 --- a/include/linux/perf/riscv_pmu.h
> > > +++ b/include/linux/perf/riscv_pmu.h
> > > @@ -42,6 +42,7 @@ struct cpu_hw_events {
> > >  struct riscv_pmu {
> > >         struct pmu      pmu;
> > >         char            *name;
> > > +       char            *pmuid;
> > >
> > >         irqreturn_t     (*handle_irq)(int irq_num, void *dev);
> > >
> > > --
> > > 2.35.1
> > >
>


--=20
Regards,
Atish
