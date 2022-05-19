Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569FD52CA4D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 05:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiESDZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 23:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiESDY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 23:24:57 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C9D31211
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 20:24:56 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id p26so5382292eds.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 20:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S2HqOHyCOH+aXecOw9Zv3ZMvUKUSfSNo8l4zI5iNzrk=;
        b=LiQobTU3TNZL9SkrZb+rYBVaCidXLtBkzOdKK7CSr24zY71YZLV0YNxq3dwIJ5wTaf
         8pCQSw/rWZHX0FxmQa5erNJ59dr7+y63GelWm2bR9bgn6vk5w7JO7k4faAr3F7pmbZdt
         zf+qN1kgIQ7EP6Xm0UkF1JR2NWlNl/uVUFR3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S2HqOHyCOH+aXecOw9Zv3ZMvUKUSfSNo8l4zI5iNzrk=;
        b=hgnCeBYTiycaTTP834maJTCfLV123i0o4RNq5CIr3pi8QeaexRv4EsXsYQTXAiUozr
         90RAidM+y4Lj3u75odYIiUAQ3lttfeE5BunJluHGzKv1aV4mgB26LuUYEgAVDldZCcDZ
         B3yyutTwVOUYKp3kyI494iN9+hZaMUHw4y+RWq9Ys4hhJWm+voPwKX1J4/envo6f+Ix3
         VT3sEmRMe0CskMyFbkCLBgO93VKmIlkVcFOH2LwXX01rin2nHba3JjkX4eFWq7q8+HhM
         m/Ziqp8TC0arm8/+2jTic9f28jumd19YjIYTdEng2qsZKgt4kI4cGUsloyNWXMf5Lzfj
         +3Vg==
X-Gm-Message-State: AOAM533nvwgrol4EK277ALiPpNZmFI+d9Dh7exEYnGbz8RDpyN3Kyb5R
        /58t/F12QZ81mdKAHlwRA4MyQAgQCrIBfp2/zDws6w==
X-Google-Smtp-Source: ABdhPJycC/kcMRqj9Yp+21KxOPFPUKt1x2Mn3Ucbk4t8W/c6rs7YDemtgJmq33uTNBuI33Ko9RYP2l459pqKQI6OybU=
X-Received: by 2002:a05:6402:290e:b0:42a:e401:6a07 with SMTP id
 ee14-20020a056402290e00b0042ae4016a07mr2977441edb.99.1652930694760; Wed, 18
 May 2022 20:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220513032832.17645-1-johnson.wang@mediatek.com>
 <20220513032832.17645-3-johnson.wang@mediatek.com> <CAGXv+5Em2eq8g8phC7MVcEP-sCsSsKa9FQjOra2UN3pib_psLA@mail.gmail.com>
 <7eec74e32bb482ba6984c6789f598ee9965f49b3.camel@mediatek.com>
In-Reply-To: <7eec74e32bb482ba6984c6789f598ee9965f49b3.camel@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 19 May 2022 11:24:43 +0800
Message-ID: <CAGXv+5G-88zWSnic-AY2ANF9BYWCsZk29CeLxp+VuFKE_LH5Ug@mail.gmail.com>
Subject: Re: [RESEND v4 2/2] PM / devfreq: mediatek: Introduce MediaTek CCI
 devfreq driver
To:     Johnson Wang <johnson.wang@mediatek.com>
Cc:     cw00.choi@samsung.com, krzk+dt@kernel.org, robh+dt@kernel.org,
        kyungmin.park@samsung.com, djakov@kernel.org, khilman@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jia-wei.chang@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 8:19 PM Johnson Wang <johnson.wang@mediatek.com> wrote:
>
> Hi Chen-Yu,
>
> On Fri, 2022-05-13 at 11:54 +0800, Chen-Yu Tsai wrote:
> > On Fri, May 13, 2022 at 11:31 AM Johnson Wang <
> > johnson.wang@mediatek.com> wrote:
> > >
> > > We introduce a devfreq driver for the MediaTek Cache Coherent
> > > Interconnect
> > > (CCI) used by some MediaTek SoCs.
> > >
> > > In this driver, we use the passive devfreq driver to get target
> > > frequencies
> > > and adjust voltages accordingly. In MT8183 and MT8186, the MediaTek
> > > CCI
> > > is supplied by the same regulators with the little core CPUs.
> > >
> > > Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> > > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> > > Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> > > ---
> > > This patch depends on "devfreq-testing"[1].
> > > [1]
> > > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git/log/?h=devfreq-testing__;!!CTRNKA9wMg0ARbw!zzOSoso9udvDV3h6kYlmizFtbn3ACA5aS2jCAjKyvtu4z0fobv1mD5uF9YbPSme8l_NnR05unTxkZfDdzohu8asWZQ$
> > >
> > > ---
> > >  drivers/devfreq/Kconfig           |  10 +
> > >  drivers/devfreq/Makefile          |   1 +
> > >  drivers/devfreq/mtk-cci-devfreq.c | 474
> > > ++++++++++++++++++++++++++++++
> > >  3 files changed, 485 insertions(+)
> > >  create mode 100644 drivers/devfreq/mtk-cci-devfreq.c
> > >
> > > diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> > > index 87eb2b837e68..9754d8b31621 100644
> > > --- a/drivers/devfreq/Kconfig
> > > +++ b/drivers/devfreq/Kconfig
> > > @@ -120,6 +120,16 @@ config ARM_TEGRA_DEVFREQ
> > >           It reads ACTMON counters of memory controllers and
> > > adjusts the
> > >           operating frequencies and voltages with OPP support.
> > >
> > > +config ARM_MEDIATEK_CCI_DEVFREQ
> > > +       tristate "MEDIATEK CCI DEVFREQ Driver"
> > > +       depends on ARM_MEDIATEK_CPUFREQ || COMPILE_TEST
> > > +       select DEVFREQ_GOV_PASSIVE
> > > +       help
> > > +         This adds a devfreq driver for MediaTek Cache Coherent
> > > Interconnect
> > > +         which is shared the same regulators with the cpu cluster.
> > > It can track
> > > +         buck voltages and update a proper CCI frequency. Use the
> > > notification
> > > +         to get the regulator status.
> > > +
> > >  config ARM_RK3399_DMC_DEVFREQ
> > >         tristate "ARM RK3399 DMC DEVFREQ Driver"
> > >         depends on (ARCH_ROCKCHIP && HAVE_ARM_SMCCC) || \
> > > diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> > > index 0b6be92a25d9..bf40d04928d0 100644
> > > --- a/drivers/devfreq/Makefile
> > > +++ b/drivers/devfreq/Makefile
> > > @@ -11,6 +11,7 @@ obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)     +=
> > > governor_passive.o
> > >  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)   += exynos-bus.o
> > >  obj-$(CONFIG_ARM_IMX_BUS_DEVFREQ)      += imx-bus.o
> > >  obj-$(CONFIG_ARM_IMX8M_DDRC_DEVFREQ)   += imx8m-ddrc.o
> > > +obj-$(CONFIG_ARM_MEDIATEK_CCI_DEVFREQ) += mtk-cci-devfreq.o
> > >  obj-$(CONFIG_ARM_RK3399_DMC_DEVFREQ)   += rk3399_dmc.o
> > >  obj-$(CONFIG_ARM_SUN8I_A33_MBUS_DEVFREQ)       += sun8i-a33-mbus.o
> > >  obj-$(CONFIG_ARM_TEGRA_DEVFREQ)                += tegra30-
> > > devfreq.o
> > > diff --git a/drivers/devfreq/mtk-cci-devfreq.c
> > > b/drivers/devfreq/mtk-cci-devfreq.c
> > > new file mode 100644
> > > index 000000000000..aa8c37eb4a06
> > > --- /dev/null
> > > +++ b/drivers/devfreq/mtk-cci-devfreq.c
> > > @@ -0,0 +1,474 @@

[...]

> > > +       if (IS_ERR(drv->sram_reg))
> > > +               drv->sram_reg = NULL;
> > > +       else {
> > > +               ret = regulator_enable(drv->sram_reg);
> > > +               if (ret) {
> > > +                       dev_err(dev, "failed to enable sram
> > > regulator\n");
> > > +                       goto out_free_resources;
> > > +               }
> > > +       }
> > > +
> > > +       /*
> > > +        * We assume min voltage is 0 and tracking target voltage
> > > using
> > > +        * min_volt_shift for each iteration.
> > > +        * The retry_max is 3 times of expeted iteration count.
> >
> > expected?
> >
> Maybe "the maximum" will be more appropriate?


I was merely pointing out a typo in "expeted".

Looking at it again, I'm not sure why retry attempts are tied to the voltage.


ChenYu
