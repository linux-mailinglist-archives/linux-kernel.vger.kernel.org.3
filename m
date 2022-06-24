Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96DE8559ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiFXQv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFXQv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:51:56 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008BE52E5D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:51:53 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 15so5479098ybc.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 09:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l0DpinNvZxGmxtaLG/tFhvlNkAzZw8AP8a8IjHb2qFI=;
        b=IdVYjOY89LbKF8YzNNPdn/AhkiGUoWNQGT2nGRWjyMDO8Qd5flOSr+qQGK3O2EpYV8
         ydwM/Guke1O+IotKFfJtMCX0cZvjTittvf5mwfnjzS2hgyhWQXF70d7lP14VDamsVfTQ
         gAbaVCY06cvFgcv2hXVHu8z/E80ArXK+7/6/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l0DpinNvZxGmxtaLG/tFhvlNkAzZw8AP8a8IjHb2qFI=;
        b=2W3d7nVbALTeIh+P7GW9HktfvM3BSzsAVzJDlWYJXfNhFyZiI8XVqXI1fgr1xOhtup
         xC3uNlYfecaYw9xFJwY3AsZA/cqzZdlf5MuOneR09ixuc0/xFqD3SYmIW+CvbQGFWrTH
         oEEFRFsABbORUBLq7u0P818VThaWHoFzJJaxRngz3Ywrv5N9Xr1z3UbI5z0Pd3tYYQqw
         Nfq5wXfF7bWRSbx9g1NECrwe2T9Kj8UZS/YfMdiLjeM4glicbeye+PP9fV6jHkhtinCr
         Ppq9q3GIz07i5eOgtxtoLdVKpY5XDK2rXb8GX06lG/geq09g0kzkINz93gkX4vRVOZBG
         2YrA==
X-Gm-Message-State: AJIora8WPlHiATz/jurJHNYQz/VJZya1dYKiSXVwgmYfvM2XZS7lARsb
        a5EtrdOhMk2S3QWUgGKrJQGT6GORg2LXnRCu2Q1W
X-Google-Smtp-Source: AGRyM1vQi5YWVjwEtdmiqRm2w6lqaKZqE+ChXWxeYo1IUOB+OlXfYGBxdaL1FGw2uU03Jeu4c5f3rOsXz7IOSxs4k2w=
X-Received: by 2002:a25:bcca:0:b0:66c:7e4d:c708 with SMTP id
 l10-20020a25bcca000000b0066c7e4dc708mr103614ybm.228.1656089513226; Fri, 24
 Jun 2022 09:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220624160117.3206-1-nikita.shubin@maquefel.me> <20220624160117.3206-2-nikita.shubin@maquefel.me>
In-Reply-To: <20220624160117.3206-2-nikita.shubin@maquefel.me>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 24 Jun 2022 09:51:40 -0700
Message-ID: <CAOnJCUKpru5s=ktUKj3k5-L1sh8FzTm4t18BcudFXKT4SHaftQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] drivers/perf: riscv_pmu_sbi: perf format
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Anup Patel <anup@brainfault.org>,
        =?UTF-8?B?Sm/Do28gTcOhcmlvIERvbWluZ29z?= 
        <joao.mario@tecnico.ulisboa.pt>, linux <linux@yadro.com>,
        Nikita Shubin <n.shubin@yadro.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
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

On Fri, Jun 24, 2022 at 9:02 AM Nikita Shubin <nikita.shubin@maquefel.me> w=
rote:
>
> From: Nikita Shubin <n.shubin@yadro.com>
>
> Update driver to export formatting and event information to sysfs so it
> can be used by the perf user space tools with the syntaxes:
>
> perf stat -e cpu/event=3D0x05
> perf stat -e cpu/event=3D0x05,firmware=3D0x1/
>
> 63-bit is used to distinguish hardware events from firmware. Firmware
> events are defined by "RISC-V Supervisor Binary Interface
> Specification".
>
> perf stat -e cpu/event=3D0x05,firmware=3D0x1/
>
> is equivalent to
>
> perf stat -e r8000000000000005
>
> Inspired-by: Jo=C3=A3o M=C3=A1rio Domingos <joao.mario@tecnico.ulisboa.pt=
>
> Signed-off-by: Nikita Shubin <n.shubin@yadro.com>
> Link: https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sb=
i.adoc
> ---
>  drivers/perf/riscv_pmu_sbi.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index dca3537a8dcc..2b5861a10d8e 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -21,6 +21,25 @@
>  #include <asm/sbi.h>
>  #include <asm/hwcap.h>
>
> +PMU_FORMAT_ATTR(event, "config:0-62");

This format is used for raw events as well. Raw event data only
encodes 48 bits as per the SBI spec.
The RISCV_PMU_RAW_EVENT_MASK in the sbi.h is incorrect. I will send a fix.

> +PMU_FORMAT_ATTR(firmware, "config:63-63");
> +
> +static struct attribute *riscv_arch_formats_attr[] =3D {
> +       &format_attr_event.attr,
> +       &format_attr_firmware.attr,
> +       NULL,
> +};
> +
> +static struct attribute_group riscv_pmu_format_group =3D {
> +       .name =3D "format",
> +       .attrs =3D riscv_arch_formats_attr,
> +};
> +
> +static const struct attribute_group *riscv_pmu_attr_groups[] =3D {
> +       &riscv_pmu_format_group,
> +       NULL,
> +};
> +
>  union sbi_pmu_ctr_info {
>         unsigned long value;
>         struct {
> @@ -720,6 +739,7 @@ static int pmu_sbi_device_probe(struct platform_devic=
e *pdev)
>                 pmu->pmu.capabilities |=3D PERF_PMU_CAP_NO_INTERRUPT;
>                 pmu->pmu.capabilities |=3D PERF_PMU_CAP_NO_EXCLUDE;
>         }
> +       pmu->pmu.attr_groups =3D riscv_pmu_attr_groups;
>         pmu->num_counters =3D num_counters;
>         pmu->ctr_start =3D pmu_sbi_ctr_start;
>         pmu->ctr_stop =3D pmu_sbi_ctr_stop;
> --
> 2.35.1
>


--=20
Regards,
Atish
