Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B420D592EDD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiHOMZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241851AbiHOMZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:25:28 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1BC5FEB;
        Mon, 15 Aug 2022 05:25:23 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z20so9340349edb.9;
        Mon, 15 Aug 2022 05:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=HuV6ZnXA4g77sAz8lv0IoaoXUF+lgKniFR4loQkFu7s=;
        b=hem/w74dGCE7vRtJDFaAnyfuNb1UvqzjYYxYy7Dl18calZdt/AoPp+OXRCitRPw4g5
         cIvd8YsjdgGyaLUsi9ep3/UM4jVfGEwwQ+Rj+4ULIMhQYcDVUlnaepthzrHS8J7gX5yb
         aBnL844ntmBOPftM+PvGd6XpKrwFXpO19c5kjRCgw2vmH99bW6Dy2mpeYGqNh4+de0JT
         a6JfwPoe2nWTWacR+kNcSoJvQX4hF797XdxiXj7GFbDNnXOw6Q6r1MSR0tyQSyca3aBg
         iLD0jAmeNOTWhjisENWiiBV6NxLqbgCOvcA/sXxegSM1v5UP1BVjjVJHhRINm1Tqjt/R
         8CPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=HuV6ZnXA4g77sAz8lv0IoaoXUF+lgKniFR4loQkFu7s=;
        b=v9FVUayU6cx8DHNjwYj7o2mqb3E6KILQaNOp/L2CfLSS4xDEs4eP5cJAWFZ/NrHxBI
         ZaGpqj53d5df0jwBFt1lIzPCI3DUyj2LXvNlG9YiZ4yS1h3lsmAPQiSKv/hDrcG49xWp
         LD2dgnEKgepUxgvmab3GAOis+l9mnoJAmbTWe5sdd0RTUOm/J+8KXGD+eJoVSyJgjzfI
         8us+tMRtPcRokIvlXlz/s8MSRS9FtGIQ3aEhnC2FjjTXO6WS1iWlVoP2pwn1CKUQ3OBy
         SBG+7hGiq4J/A2drcJGQkCbmBaqc7HFdSTejRyLQt3FhCT/dkgSvF5LrVawSCu45k4NM
         8+/Q==
X-Gm-Message-State: ACgBeo2Poh0sJYjqi70IbmMZsKoTt1jqUO5qJlWrNXSvGLqg77vxrJK5
        DvGfXZkRPcF435QjGHSLYqh3F67qmd7E63w3KgU=
X-Google-Smtp-Source: AA6agR4Q7CswgoEuf6wKDrJSLMawgXZ02/67A9XTjfkrBSPCyjHEeWP90PAyu2EA0FT7E+z0jwY1rQHH1+QbzdzlW5E=
X-Received: by 2002:aa7:d159:0:b0:43d:73ba:64cf with SMTP id
 r25-20020aa7d159000000b0043d73ba64cfmr14794679edo.36.1660566322365; Mon, 15
 Aug 2022 05:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220815092815.11597-1-yangyicong@huawei.com> <YvotEZigh0+I/RIb@FVFF77S0Q05N>
In-Reply-To: <YvotEZigh0+I/RIb@FVFF77S0Q05N>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 16 Aug 2022 00:25:10 +1200
Message-ID: <CAGsJ_4zgaLdPJ5smOMYp2MQMw_ofkhrRNnWo+21DKx0+U5v6QA@mail.gmail.com>
Subject: Re: [PATCH] drivers/perf: Change WARN_ON() to dev_err() on
 irq_set_affinity() failure
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Yicong Yang <yangyicong@huawei.com>, will@kernel.org,
        Frank.li@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        zhangshaokun@hisilicon.com, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        khuong@os.amperecomputing.com, john.garry@huawei.com,
        jonathan.cameron@huawei.com, yangyicong@hisilicon.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 12:06 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Mon, Aug 15, 2022 at 05:28:15PM +0800, Yicong Yang wrote:
> > From: Yicong Yang <yangyicong@hisilicon.com>
> >
> > The WARN_ON() on irq_set_affinity() failure is misused according to the [1]
> > and may crash people's box unintentionally. This may also be redundant since
> > in the failure case we may also trigger the WARN and dump the stack in the
> > perf core[2] for a second time.
>
> In what way do you think are these misused? I can't immediately see what you
> think applies from [1].
>
> In perf we rely upon interrupt affinity to enforce serialization in a few
> places, so if we fail to set the interrupt affinity there are a number of
> things which could go wrong (e.g. memory corruption, and all the fun that could
> result from that). We use WARN_ON() to catch that early.

Hi Mark,

If this is the case, is it better for us to return an ERROR after
printing a dev_err then
let the driver fail?

I really don't understand how a WARN_ON can help fix or even alert something is
wrong if we always need a successful irq_sey_affinity to make the driver work.

>
> I can't immediately see how [2] is relevant, since that's in the context of an
> IPI handler, and this patch affects the affinity of the PMU HW IRQ handler.
>
> Thanks,
> Mark.
>
> >
> > So change the WARN_ON() to dev_err() to just print the failure message.
> >
> > [1] https://github.com/torvalds/linux/blob/master/include/asm-generic/bug.h#L74
> > [2] https://github.com/torvalds/linux/blob/master/kernel/events/core.c#L313
> >
> > Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> > [https://lore.kernel.org/lkml/YuOi3i0XHV++z1YI@kroah.com/]
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > ---
> >  drivers/perf/arm-ccn.c                   | 5 +++--
> >  drivers/perf/arm_dmc620_pmu.c            | 3 ++-
> >  drivers/perf/arm_smmuv3_pmu.c            | 6 ++++--
> >  drivers/perf/fsl_imx8_ddr_perf.c         | 3 ++-
> >  drivers/perf/hisilicon/hisi_pcie_pmu.c   | 6 ++++--
> >  drivers/perf/hisilicon/hisi_uncore_pmu.c | 6 ++++--
> >  drivers/perf/qcom_l2_pmu.c               | 8 ++++++--
> >  drivers/perf/xgene_pmu.c                 | 6 ++++--
> >  8 files changed, 29 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
> > index 728d13d8e98a..83abd909ba49 100644
> > --- a/drivers/perf/arm-ccn.c
> > +++ b/drivers/perf/arm-ccn.c
> > @@ -1210,8 +1210,9 @@ static int arm_ccn_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> >               return 0;
> >       perf_pmu_migrate_context(&dt->pmu, cpu, target);
> >       dt->cpu = target;
> > -     if (ccn->irq)
> > -             WARN_ON(irq_set_affinity(ccn->irq, cpumask_of(dt->cpu)));
> > +     if (ccn->irq && irq_set_affinity(ccn->irq, cpumask_of(dt->cpu)))
> > +             dev_err(ccn->dev, "Failed to set interrupt affinity\n");
> > +
> >       return 0;
> >  }
> >
> > diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
> > index 280a6ae3e27c..b59d3d9eb779 100644
> > --- a/drivers/perf/arm_dmc620_pmu.c
> > +++ b/drivers/perf/arm_dmc620_pmu.c
> > @@ -621,7 +621,8 @@ static int dmc620_pmu_cpu_teardown(unsigned int cpu,
> >               perf_pmu_migrate_context(&dmc620_pmu->pmu, irq->cpu, target);
> >       mutex_unlock(&dmc620_pmu_irqs_lock);
> >
> > -     WARN_ON(irq_set_affinity(irq->irq_num, cpumask_of(target)));
> > +     if (irq_set_affinity(irq->irq_num, cpumask_of(target)))
> > +             dev_err(dmc620_pmu->pmu.dev, "Failed to set interrupt affinity\n");
> >       irq->cpu = target;
> >
> >       return 0;
> > diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
> > index 00d4c45a8017..05e1b3e274d7 100644
> > --- a/drivers/perf/arm_smmuv3_pmu.c
> > +++ b/drivers/perf/arm_smmuv3_pmu.c
> > @@ -646,7 +646,8 @@ static int smmu_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> >
> >       perf_pmu_migrate_context(&smmu_pmu->pmu, cpu, target);
> >       smmu_pmu->on_cpu = target;
> > -     WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(target)));
> > +     if (irq_set_affinity(smmu_pmu->irq, cpumask_of(target)))
> > +             dev_err(smmu_pmu->dev, "Failed to set interrupt affinity\n");
> >
> >       return 0;
> >  }
> > @@ -892,7 +893,8 @@ static int smmu_pmu_probe(struct platform_device *pdev)
> >
> >       /* Pick one CPU to be the preferred one to use */
> >       smmu_pmu->on_cpu = raw_smp_processor_id();
> > -     WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)));
> > +     if (irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)))
> > +             dev_err(dev, "Failed to set interrupt affinity\n");
> >
> >       err = cpuhp_state_add_instance_nocalls(cpuhp_state_num,
> >                                              &smmu_pmu->node);
> > diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
> > index 8e058e08fe81..c44192e2d9db 100644
> > --- a/drivers/perf/fsl_imx8_ddr_perf.c
> > +++ b/drivers/perf/fsl_imx8_ddr_perf.c
> > @@ -671,7 +671,8 @@ static int ddr_perf_offline_cpu(unsigned int cpu, struct hlist_node *node)
> >       perf_pmu_migrate_context(&pmu->pmu, cpu, target);
> >       pmu->cpu = target;
> >
> > -     WARN_ON(irq_set_affinity(pmu->irq, cpumask_of(pmu->cpu)));
> > +     if (irq_set_affinity(pmu->irq, cpumask_of(pmu->cpu)))
> > +             dev_err(pmu->dev, "Failed to set interrupt affinity\n");
> >
> >       return 0;
> >  }
> > diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> > index 21771708597d..90aed9e51396 100644
> > --- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
> > +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> > @@ -655,7 +655,8 @@ static int hisi_pcie_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
> >
> >       if (pcie_pmu->on_cpu == -1) {
> >               pcie_pmu->on_cpu = cpu;
> > -             WARN_ON(irq_set_affinity(pcie_pmu->irq, cpumask_of(cpu)));
> > +             if (irq_set_affinity(pcie_pmu->irq, cpumask_of(cpu)))
> > +                     pci_err(pcie_pmu->pdev, "Failed to set interrupt affinity\n");
> >       }
> >
> >       return 0;
> > @@ -681,7 +682,8 @@ static int hisi_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> >       perf_pmu_migrate_context(&pcie_pmu->pmu, cpu, target);
> >       /* Use this CPU for event counting */
> >       pcie_pmu->on_cpu = target;
> > -     WARN_ON(irq_set_affinity(pcie_pmu->irq, cpumask_of(target)));
> > +     if (irq_set_affinity(pcie_pmu->irq, cpumask_of(target)))
> > +             pci_err(pcie_pmu->pdev, "Failed to set interrupt affinity\n");
> >
> >       return 0;
> >  }
> > diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> > index fbc8a93d5eac..74397b5ec889 100644
> > --- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
> > +++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
> > @@ -492,7 +492,8 @@ int hisi_uncore_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
> >       hisi_pmu->on_cpu = cpu;
> >
> >       /* Overflow interrupt also should use the same CPU */
> > -     WARN_ON(irq_set_affinity(hisi_pmu->irq, cpumask_of(cpu)));
> > +     if (irq_set_affinity(hisi_pmu->irq, cpumask_of(cpu)))
> > +             dev_err(hisi_pmu->dev, "Failed to set interrupt affinity\n");
> >
> >       return 0;
> >  }
> > @@ -525,7 +526,8 @@ int hisi_uncore_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> >       perf_pmu_migrate_context(&hisi_pmu->pmu, cpu, target);
> >       /* Use this CPU for event counting */
> >       hisi_pmu->on_cpu = target;
> > -     WARN_ON(irq_set_affinity(hisi_pmu->irq, cpumask_of(target)));
> > +     if (irq_set_affinity(hisi_pmu->irq, cpumask_of(target)))
> > +             dev_err(hisi_pmu->dev, "Failed to set interrupt affinity\n");
> >
> >       return 0;
> >  }
> > diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
> > index 30234c261b05..c6fe01c7e637 100644
> > --- a/drivers/perf/qcom_l2_pmu.c
> > +++ b/drivers/perf/qcom_l2_pmu.c
> > @@ -793,7 +793,9 @@ static int l2cache_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
> >       cpumask_set_cpu(cpu, &l2cache_pmu->cpumask);
> >       cluster_pmu_reset();
> >
> > -     WARN_ON(irq_set_affinity(cluster->irq, cpumask_of(cpu)));
> > +     if (irq_set_affinity(cluster->irq, cpumask_of(cpu)))
> > +             dev_err(&l2cache_pmu->pdev->dev,
> > +                     "Failed to set interrupt affinity\n");
> >       enable_irq(cluster->irq);
> >
> >       return 0;
> > @@ -831,7 +833,9 @@ static int l2cache_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> >       perf_pmu_migrate_context(&l2cache_pmu->pmu, cpu, target);
> >       cluster->on_cpu = target;
> >       cpumask_set_cpu(target, &l2cache_pmu->cpumask);
> > -     WARN_ON(irq_set_affinity(cluster->irq, cpumask_of(target)));
> > +     if (irq_set_affinity(cluster->irq, cpumask_of(target)))
> > +             dev_err(&l2cache_pmu->pdev->dev,
> > +                     "Failed to set interrupt affinity\n");
> >
> >       return 0;
> >  }
> > diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
> > index 0c32dffc7ede..f31e678fdb69 100644
> > --- a/drivers/perf/xgene_pmu.c
> > +++ b/drivers/perf/xgene_pmu.c
> > @@ -1790,7 +1790,8 @@ static int xgene_pmu_online_cpu(unsigned int cpu, struct hlist_node *node)
> >               cpumask_set_cpu(cpu, &xgene_pmu->cpu);
> >
> >       /* Overflow interrupt also should use the same CPU */
> > -     WARN_ON(irq_set_affinity(xgene_pmu->irq, &xgene_pmu->cpu));
> > +     if (irq_set_affinity(xgene_pmu->irq, &xgene_pmu->cpu))
> > +             dev_err(xgene_pmu->dev, "Failed to set interrupt affinity\n");
> >
> >       return 0;
> >  }
> > @@ -1823,7 +1824,8 @@ static int xgene_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> >
> >       cpumask_set_cpu(target, &xgene_pmu->cpu);
> >       /* Overflow interrupt also should use the same CPU */
> > -     WARN_ON(irq_set_affinity(xgene_pmu->irq, &xgene_pmu->cpu));
> > +     if (irq_set_affinity(xgene_pmu->irq, &xgene_pmu->cpu))
> > +             dev_err(xgene_pmu->dev, "Failed to set interrupt affinity\n");
> >
> >       return 0;
> >  }
> > --
> > 2.24.0
> >

Thanks
Barry
