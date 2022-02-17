Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6974BAB14
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343683AbiBQUaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:30:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238692AbiBQUaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:30:15 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A294CC335F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 12:29:59 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 124so15363239ybn.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 12:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IUl1+sbxUPJhNhrxqJaq+c36PTDFKTH/KVRlSQmIXs8=;
        b=Vx98KnCngkenU+PXAobN/H3fGJpONX7rpPSfP45QOYevZFRetL3e4+v94QEhhi+ce1
         vJe8bvtS4kDfUkppkTIY20jDgwzPlSXJFdpbqXtHLnee62S1cLB+aI2/AN7SQc5AW8Pt
         yB96SyH1nLRLOICDYADYPYQ81gNW+hpIFEtLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IUl1+sbxUPJhNhrxqJaq+c36PTDFKTH/KVRlSQmIXs8=;
        b=PAy28og9obvesh5bYgpSMn/5Od1Gn2lG411zgGNr5Le1UTrFVVpRkyPvXVDzCfzfoT
         3oI06Yuw0NMLv0Qkncdl8qeRk9N0BG7bnrSyk81JIiErketgk7XqYse9WOM2Y8eRnH6P
         lwIgGDUxRkPdMDqms6nzr1xBRuZ6pKDTFcKJkxOtxHxDj8qmrcjNo0X2O20IU+iq9Ane
         7PeOFk4rVqowvxFRXZqbJq4CU8FE14ZRwmnjC2eMx+KcDm+SphfEinIQ3RAT3K2Fg8hr
         4Q5J65F0B6IeiqtNEEtzL91I4J4JQMWFom9doPCj1WV7BXicZzne0s9cbLesTmvfM2t0
         eQbA==
X-Gm-Message-State: AOAM532DDX2LXbXb9dpvxZ1RzlNHQxgVbvFtqcFa+yDiVnqbaqfkzsqJ
        soDfJBsdhxDcQIYsEB+jyu5qjY+zmyuSmU3vysxiU7v+v9sx
X-Google-Smtp-Source: ABdhPJwtifBjREmUKE8lnzM07bCU1YQ5vaFRwlmUKCwZZHYsIXoEnYXAMPM3uD+1xbRX1g5Vjn8xH9uMFCDx57j0jc4=
X-Received: by 2002:a25:86c9:0:b0:61e:188a:d71f with SMTP id
 y9-20020a2586c9000000b0061e188ad71fmr4135038ybm.14.1645129798862; Thu, 17 Feb
 2022 12:29:58 -0800 (PST)
MIME-Version: 1.0
References: <20211225054647.1750577-1-atishp@rivosinc.com> <20211225054647.1750577-7-atishp@rivosinc.com>
 <13483045.gklhn8uf4L@diego>
In-Reply-To: <13483045.gklhn8uf4L@diego>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 17 Feb 2022 12:29:48 -0800
Message-ID: <CAOnJCUJ_TB9+e=W6aC2gFn-iiQe9YDNAM6RzQx646+9_7MVu6w@mail.gmail.com>
Subject: Re: [v5 6/9] RISC-V: Add perf platform driver based on SBI PMU extension
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 5:16 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Samstag, 25. Dezember 2021, 06:46:44 CET schrieb Atish Patra:
> > From: Atish Patra <atish.patra@wdc.com>
> >
> > RISC-V SBI specification added a PMU extension that allows to configure
> > start/stop any pmu counter. The RISC-V perf can use most of the generic
> > perf features except interrupt overflow and event filtering based on
> > privilege mode which will be added in future.
> >
> > It also allows to monitor a handful of firmware counters that can provi=
de
> > insights into firmware activity during a performance analysis.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
>
> [...]
>
> > +static int pmu_sbi_device_probe(struct platform_device *pdev)
> > +{
> > +     struct riscv_pmu *pmu =3D NULL;
> > +     int num_counters;
> > +     int ret;
> > +
> > +     pr_info("SBI PMU extension is available\n");
> > +     /* Notify legacy implementation that SBI pmu is available*/
> > +     riscv_pmu_legacy_init(true);
>
> Just wondering, shouldn't the riscv_pmu_legacy_init() call live in
> pmu_sbi_devinit) below?
>

That works too. Fixed it. Thanks.

> I.e. when you detected the presence of the PMU sbi extension you already
> know that you don't want the legacy one and you have less control over
> probe-ordering (when the driver actually probes) than the initcall itself=
.
>
>
> Also, I think a better naming for the function might be good.
> Right now just reading
>
>         riscv_pmu_legacy_init(true);
>
> suggests that you _want_ the legacy-init to be enabled, while
> in reality the function means the opposite, disabling the legacy init.
>
> So maybe something like
>         riscv_pmu_disable_legacy(true); ?
>

yeah. Anup had a similar suggestion as well. I have changed it to
riscv_pmu_legacy_skip_init
without any argument.

>
> Heiko
>
> > +     pmu =3D riscv_pmu_alloc();
> > +     if (!pmu)
> > +             return -ENOMEM;
> > +
> > +     num_counters =3D pmu_sbi_find_num_ctrs();
> > +     if (num_counters < 0) {
> > +             pr_err("SBI PMU extension doesn't provide any counters\n"=
);
> > +             return -ENODEV;
> > +     }
> > +
> > +     /* cache all the information about counters now */
> > +     if (pmu_sbi_get_ctrinfo(num_counters))
> > +             return -ENODEV;
> > +
> > +     pmu->num_counters =3D num_counters;
> > +     pmu->ctr_start =3D pmu_sbi_ctr_start;
> > +     pmu->ctr_stop =3D pmu_sbi_ctr_stop;
> > +     pmu->event_map =3D pmu_sbi_event_map;
> > +     pmu->ctr_get_idx =3D pmu_sbi_ctr_get_idx;
> > +     pmu->ctr_get_width =3D pmu_sbi_ctr_get_width;
> > +     pmu->ctr_clear_idx =3D pmu_sbi_ctr_clear_idx;
> > +     pmu->ctr_read =3D pmu_sbi_ctr_read;
> > +
> > +     ret =3D cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &p=
mu->node);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
> > +     if (ret) {
> > +             cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING,=
 &pmu->node);
> > +             return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static struct platform_driver pmu_sbi_driver =3D {
> > +     .probe          =3D pmu_sbi_device_probe,
> > +     .driver         =3D {
> > +             .name   =3D RISCV_PMU_PDEV_NAME,
> > +     },
> > +};
> > +
> > +static int __init pmu_sbi_devinit(void)
> > +{
> > +     int ret;
> > +     struct platform_device *pdev;
> > +
> > +     if (((sbi_major_version() =3D=3D 0) && (sbi_minor_version() < 3))=
 ||
> > +             sbi_probe_extension(SBI_EXT_PMU) <=3D 0) {
> > +             return 0;
> > +     }
> > +
> > +     ret =3D cpuhp_setup_state_multi(CPUHP_AP_PERF_RISCV_STARTING,
> > +                                   "perf/riscv/pmu:starting",
> > +                                   pmu_sbi_starting_cpu, pmu_sbi_dying=
_cpu);
> > +     if (ret) {
> > +             pr_err("CPU hotplug notifier for RISC-V PMU could not be =
registered: %d\n",
> > +                    ret);
> > +             return ret;
> > +     }
> > +
> > +     ret =3D platform_driver_register(&pmu_sbi_driver);
> > +     if (ret)
> > +             return ret;
> > +
> > +     pdev =3D platform_device_register_simple(RISCV_PMU_PDEV_NAME, -1,=
 NULL, 0);
> > +     if (IS_ERR(pdev)) {
> > +             platform_driver_unregister(&pmu_sbi_driver);
> > +             return PTR_ERR(pdev);
> > +     }
> > +
> > +     return ret;
> > +}
> > +device_initcall(pmu_sbi_devinit)
> >
>
>
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Regards,
Atish
