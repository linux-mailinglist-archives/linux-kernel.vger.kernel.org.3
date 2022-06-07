Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF935403DD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345062AbiFGQhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345049AbiFGQhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:37:35 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72E41EEF9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 09:37:31 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2ec42eae76bso181934927b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 09:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l+dfyGXg71t6EG1I1B0LTDArA2xlLZtV5Fm9wbpRGuw=;
        b=VJO8PzyV5CICNSpQOyZZZHG0ePKdf2Oi1DgI9XQItzmtY3sgJzWhpI/fJzOM3fAfDa
         IZYCQMcLILyqzDnXFShQ95qW8YuteG/uAzuI3fhwpD2RCyVwuXX0Qmu6WEfwiVUNaDYP
         sEUY7dmZVsdPlV927UMTZdPZZ/rhzy3BJ6sTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l+dfyGXg71t6EG1I1B0LTDArA2xlLZtV5Fm9wbpRGuw=;
        b=rkI9669XtgO//ty69y446UCr2AXyHo56UdESXtCxrm2EXjZItv87H5r0KWhbq71VIN
         QQyu8Su0ix9gA9GikdIq8BMjijXq2cAQEgzcFYT9m07gJKSVts+/ZHQiNszL5S/RHA+n
         dVMZ24Ycl0Df8dzzdMjlvsMVtMCoNdqgoC6tkZvt3OBNlRxQ7r6Uey6S9eC0xU7M9hj9
         vXeYYdhhqtlxJbGJJXDAiSOaezh2kKWSRTeXhz8DRWJEAQ5nl7hf57bFrLmDHmo446L/
         tr7YdXeizNMKdDTETp+1WiREhrju4fWSi2WtB0NcGlR6QB5odHWfDIiUOwO6oKftnfDz
         bStA==
X-Gm-Message-State: AOAM531uWSJv0mnCwQdLQlM65WofnAYhHA3lu2uWHk9kMleLu/eiCWK3
        iiVbDGpN1RIulRVF8hh9JqE32Y25wyQYXrwtH+10
X-Google-Smtp-Source: ABdhPJwfmmI65JOMj5cv1kXrR4819PlxuXlEbS1ungDbRjbNtZYPjbef+zuvALGG6jZL+m0qcjpdAaCnQN9rMKr66qc=
X-Received: by 2002:a05:690c:28b:b0:30c:bcc2:240d with SMTP id
 bf11-20020a05690c028b00b0030cbcc2240dmr33841028ywb.19.1654619850904; Tue, 07
 Jun 2022 09:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220607131648.29439-1-nikita.shubin@maquefel.me> <20220607131648.29439-2-nikita.shubin@maquefel.me>
In-Reply-To: <20220607131648.29439-2-nikita.shubin@maquefel.me>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 7 Jun 2022 09:37:19 -0700
Message-ID: <CAOnJCULuQw2E3cD5KQKVs8EbcbPPeJQDqvikagxnkDSH+UWqjQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] RISC-V: Create unique identification for SoC PMU
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Genevieve Chan <genevieve.chan@starfivetech.com>,
        =?UTF-8?B?Sm/Do28gTcOhcmlvIERvbWluZ29z?= 
        <joao.mario@tecnico.ulisboa.pt>,
        Nikita Shubin <n.shubin@yadro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM PMU PROFILING AND DEBUGGING" 
        <linux-arm-kernel@lists.infradead.org>
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

On Tue, Jun 7, 2022 at 6:17 AM Nikita Shubin <nikita.shubin@maquefel.me> wr=
ote:
>
> From: Jo=C3=A3o M=C3=A1rio Domingos <joao.mario@tecnico.ulisboa.pt>
>
> The SBI PMU platform driver did not provide any identification for
> perf events matching. This patch introduces a new sysfs file inside the
> platform device (soc:pmu/id) for pmu identification.
>
> The identification is a 64-bit value generated as:
> [63-32]: mvendorid;
> [31]: marchid[MSB];
> [30-16]: marchid[15-0];
> [15-0]: mimpid[15MSBs];
>

This is not entirely correct as marchid or mimpid can be MXLEN. The
encoding scheme is left upto the
vendor. We can not assume anything about it.

The purpose of the PMU ID is to distinguish between different
vendors/generations. The perf tool expects
a json string.
I think you can just keep all these 3 registers into the JSON string
as it is to avoid any pitfalls with vendor weirdness.

> The CSRs are detailed in the RISC-V privileged spec [1].
> The marchid is split in MSB + 15LSBs, due to the MSB being used for
> open-source architecture identification.
>
> [1] https://github.com/riscv/riscv-isa-manual
>
> Signed-off-by: Jo=C3=A3o M=C3=A1rio Domingos <joao.mario@tecnico.ulisboa.=
pt>
> Tested-by: Nikita Shubin <n.shubin@yadro.com>
> ---
>  arch/riscv/kernel/sbi.c      |  3 +++
>  drivers/perf/riscv_pmu_sbi.c | 47 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
>
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 775d3322b422..50dd9b6ecc9e 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -627,16 +627,19 @@ long sbi_get_mvendorid(void)
>  {
>         return __sbi_base_ecall(SBI_EXT_BASE_GET_MVENDORID);
>  }
> +EXPORT_SYMBOL(sbi_get_mvendorid);
>
>  long sbi_get_marchid(void)
>  {
>         return __sbi_base_ecall(SBI_EXT_BASE_GET_MARCHID);
>  }
> +EXPORT_SYMBOL(sbi_get_marchid);
>
>  long sbi_get_mimpid(void)
>  {
>         return __sbi_base_ecall(SBI_EXT_BASE_GET_MIMPID);
>  }
> +EXPORT_SYMBOL(sbi_get_mimpid);
>
>  static void sbi_send_cpumask_ipi(const struct cpumask *target)
>  {
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index a1317a483512..15ab3dc68e7a 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -693,6 +693,46 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu,=
 struct platform_device *pde
>         return 0;
>  }
>
> +static uint64_t pmu_sbi_get_pmu_id(void)
> +{
> +       union sbi_pmu_id {
> +               uint64_t value;
> +               struct {
> +                       uint16_t imp:16;
> +                       uint16_t arch:16;
> +                       uint32_t vendor:32;
> +               };
> +       } pmuid;
> +
> +       pmuid.value =3D 0;
> +       pmuid.vendor =3D (uint32_t) sbi_get_mvendorid();
> +       pmuid.arch =3D (sbi_get_marchid() >> (63 - 15) & (1 << 15)) | (sb=
i_get_marchid() & 0x7FFF);
> +       pmuid.imp =3D (sbi_get_mimpid() >> 16);
> +
> +       return pmuid.value;
> +}
> +
> +static ssize_t pmu_sbi_id_show(struct device *dev,
> +               struct device_attribute *attr, char *buf)
> +{
> +       int len;
> +
> +       len =3D sprintf(buf, "0x%llx\n", pmu_sbi_get_pmu_id());
> +       if (len <=3D 0)
> +               dev_err(dev, "mydrv: Invalid sprintf len: %dn", len);
> +
> +       return len;
> +}
> +
> +static DEVICE_ATTR(id, S_IRUGO | S_IWUSR, pmu_sbi_id_show, 0);
> +
> +static struct attribute *pmu_sbi_attrs[] =3D {
> +       &dev_attr_id.attr,
> +       NULL
> +};
> +
> +ATTRIBUTE_GROUPS(pmu_sbi);
> +
>  static int pmu_sbi_device_probe(struct platform_device *pdev)
>  {
>         struct riscv_pmu *pmu =3D NULL;
> @@ -729,6 +769,13 @@ static int pmu_sbi_device_probe(struct platform_devi=
ce *pdev)
>         pmu->ctr_clear_idx =3D pmu_sbi_ctr_clear_idx;
>         pmu->ctr_read =3D pmu_sbi_ctr_read;
>
> +       ret =3D sysfs_create_group(&pdev->dev.kobj, &pmu_sbi_group);
> +       if (ret) {
> +               dev_err(&pdev->dev, "sysfs creation failed\n");
> +               return ret;
> +       }
> +       pdev->dev.groups =3D pmu_sbi_groups;
> +
>         ret =3D cpuhp_state_add_instance(CPUHP_AP_PERF_RISCV_STARTING, &p=
mu->node);
>         if (ret)
>                 return ret;
> --
> 2.35.1
>


--
Regards,
Atish
