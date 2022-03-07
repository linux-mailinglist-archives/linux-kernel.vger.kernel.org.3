Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6854CFC79
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbiCGLRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237782AbiCGLQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:16:29 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573D6F1AE6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 02:40:51 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id c16-20020a17090aa61000b001befad2bfaaso13262454pjq.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 02:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tj40XYMDSxRzg5Kwr8ssoi0XnDNRl1GeIuCP/LftewQ=;
        b=aHG9njILayDTqPDYEUN5V47CUvqOdPseFucrY3DKj8TFaNYxx+mpuVBymjWt10SVpk
         IOQ7UxNvOaCaY9s7TDe9rIT9KiGNYtcdrbYHt+NSrkthNCzj9AHcxFVT0GGOKwO0SoI9
         LmKfkYOby2kzznBrpJL7e+bp68IzVmMTXvIHA0WYc7yGr/WvdF03wrVmHhJMcl+aK7Mf
         8BbKauJzxaIlKaHOeRv1shTXndDYUB9WUXfMbphM2RcZbwvzro3D/hSPzXAlXoA0DwSh
         qzI0lAnanm6iy4ZJDIAQbMdrTtnM9AxDV9R0MxjslqUo2II9/a3doiPhXdDRvEasYLrV
         tXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tj40XYMDSxRzg5Kwr8ssoi0XnDNRl1GeIuCP/LftewQ=;
        b=NpzM6VI7132mqDEoGWOo6KD15y+K+GqCNsRdNCJC2PGlllPgEwPCKJXk19OEe+g/eB
         mHbjY378ltCRaYOkWVxN/Qkh8hqAhmSJo/6BuaD34RLWfSPsgUXBFT+B1pMmSEEtsCRr
         QLuReYNmVYXjecmX1hpy3UhJ0CdYmS/4LuKNy2FXtbvrtJrmJRXDpRpM3TJgnB6enhJS
         2jMRd1Pjomnbfqo0TYmJtC3nHhv8PnqDX/h2qBc9eEhFaBzmzTCYbuOveFAh9C6L/UFN
         0cMr0FRsNqcfIdnCC/Ah6TAjS72+7ZNymr1in3XtJORmR5ImPKGOLBYrLXMzfioJJsGW
         mDKw==
X-Gm-Message-State: AOAM532aIxP+Q79SOKcCsIpAqnmOUo13T4PBQk3VqyOz8SVqyJeGVc9F
        6x4Mcy+l6cFVCBoOkp6QY2SggusNgtcG8wNFfCXGk08DhHqz3w==
X-Google-Smtp-Source: ABdhPJwhpazXJR+prNmjY/U0nxuITRUBvqpLGnhFcMxJGJqm9ZMlMRjtN17lwr1DTqUE8Nz0pcNhpV+d1Hgf3h47/Zo=
X-Received: by 2002:a17:902:d482:b0:151:ef7f:f5aa with SMTP id
 c2-20020a170902d48200b00151ef7ff5aamr2732294plg.58.1646649649786; Mon, 07 Mar
 2022 02:40:49 -0800 (PST)
MIME-Version: 1.0
References: <20220307094042.48446-1-clement.leger@bootlin.com>
In-Reply-To: <20220307094042.48446-1-clement.leger@bootlin.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 7 Mar 2022 11:40:38 +0100
Message-ID: <CAHUa44FJEsd1wc=E0p+4pHU1=31z7JTgNDyz9Vxx77N11B8RKg@mail.gmail.com>
Subject: Re: [PATCH v2] rtc: optee: add RTC driver for OP-TEE RTC PTA
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
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

On Mon, Mar 7, 2022 at 10:42 AM Cl=C3=A9ment L=C3=A9ger <clement.leger@boot=
lin.com> wrote:
>
> This drivers allows to communicate with a RTC PTA handled by OP-TEE [1].
> This PTA allows to query RTC information, set/get time and set/get
> offset depending on the supported features.
>
> [1] https://github.com/OP-TEE/optee_os/pull/5179
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> ---
>
> Changes in v2:

Hmm, this seems to be a second v2.

>  - Rebased over tee-shm-for-v5.18
>  - Switch to tee_shm_alloc_kernel_buf()
>  - Use export_uuid() to copy uuid
>  - Fix warnings reported by checkpatch
>  - Free SHM in error exit path
>  - Fix error messages to include ret value and fix wrong IOCTL names
>  - Use 100 columns char limit

From bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning"):
    Yes, staying withing 80 columns is certainly still _preferred_.  But
    it's not the hard limit that the checkpatch warnings imply, and other
    concerns can most certainly dominate.

    Increase the default limit to 100 characters.  Not because 100
    characters is some hard limit either, but that's certainly a "what are
    you doing" kind of value and less likely to be about the occasional
    slightly longer lines.



>
>  MAINTAINERS             |   6 +
>  drivers/rtc/Kconfig     |  10 ++
>  drivers/rtc/Makefile    |   1 +
>  drivers/rtc/rtc-optee.c | 386 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 403 insertions(+)
>  create mode 100644 drivers/rtc/rtc-optee.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f41088418aae..b21375ad73d2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14361,6 +14361,12 @@ L:     op-tee@lists.trustedfirmware.org
>  S:     Maintained
>  F:     drivers/char/hw_random/optee-rng.c
>
> +OP-TEE RTC DRIVER
> +M:     Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> +L:     linux-rtc@vger.kernel.org
> +S:     Maintained
> +F:     drivers/rtc/rtc-optee.c
> +
>  OPA-VNIC DRIVER
>  M:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
>  M:     Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index d85a3c31347c..cba5427f79b3 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1293,6 +1293,16 @@ config RTC_DRV_OPAL
>           This driver can also be built as a module. If so, the module
>           will be called rtc-opal.
>
> +config RTC_DRV_OPTEE
> +       tristate "OP-TEE based RTC driver"
> +       depends on OPTEE
> +       help
> +         Select this to get support for OP-TEE based RTC control on SoCs=
 where
> +         RTC are not accessible to the normal world (Linux).
> +
> +         This driver can also be built as a module. If so, the module
> +         will be called rtc-optee.
> +
>  config RTC_DRV_ZYNQMP
>         tristate "Xilinx Zynq Ultrascale+ MPSoC RTC"
>         depends on OF && HAS_IOMEM
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index e92f3e943245..2d827d8261d5 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -115,6 +115,7 @@ obj-$(CONFIG_RTC_DRV_GAMECUBE)      +=3D rtc-gamecube=
.o
>  obj-$(CONFIG_RTC_DRV_NTXEC)    +=3D rtc-ntxec.o
>  obj-$(CONFIG_RTC_DRV_OMAP)     +=3D rtc-omap.o
>  obj-$(CONFIG_RTC_DRV_OPAL)     +=3D rtc-opal.o
> +obj-$(CONFIG_RTC_DRV_OPTEE)    +=3D rtc-optee.o
>  obj-$(CONFIG_RTC_DRV_PALMAS)   +=3D rtc-palmas.o
>  obj-$(CONFIG_RTC_DRV_PCAP)     +=3D rtc-pcap.o
>  obj-$(CONFIG_RTC_DRV_PCF2123)  +=3D rtc-pcf2123.o
> diff --git a/drivers/rtc/rtc-optee.c b/drivers/rtc/rtc-optee.c
> new file mode 100644
> index 000000000000..a2865ed17cfc
> --- /dev/null
> +++ b/drivers/rtc/rtc-optee.c
> @@ -0,0 +1,386 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Microchip.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/rtc.h>
> +#include <linux/tee_drv.h>
> +
> +#define RTC_INFO_VERSION       0x1
> +
> +#define TA_CMD_RTC_GET_INFO            0x0
> +#define TA_CMD_RTC_GET_TIME            0x1
> +#define TA_CMD_RTC_SET_TIME            0x2
> +#define TA_CMD_RTC_GET_OFFSET          0x3
> +#define TA_CMD_RTC_SET_OFFSET          0x4
> +
> +#define TA_RTC_FEATURE_CORRECTION      BIT(0)
> +
> +struct optee_rtc_time {
> +       u32 tm_sec;
> +       u32 tm_min;
> +       u32 tm_hour;
> +       u32 tm_mday;
> +       u32 tm_mon;
> +       u32 tm_year;
> +       u32 tm_wday;
> +};
> +
> +struct optee_rtc_info {
> +       u64 version;
> +       u64 features;
> +       struct optee_rtc_time range_min;
> +       struct optee_rtc_time range_max;
> +};
> +
> +/**
> + * struct optee_rtc - OP-TEE RTC private data
> + * @dev:               OP-TEE based RTC device.
> + * @ctx:               OP-TEE context handler.
> + * @session_id:                RTC TA session identifier.
> + * @shm:               Memory pool shared with RTC device.
> + * @features:          Bitfield of RTC features
> + */
> +struct optee_rtc {
> +       struct device *dev;
> +       struct tee_context *ctx;
> +       u32 session_id;
> +       struct tee_shm *shm;
> +       u64 features;
> +};
> +
> +static int optee_rtc_readtime(struct device *dev, struct rtc_time *tm)
> +{
> +       struct optee_rtc *priv =3D dev_get_drvdata(dev);
> +       struct tee_ioctl_invoke_arg inv_arg =3D {0};
> +       struct optee_rtc_time *optee_tm;
> +       struct tee_param param[4] =3D {0};
> +       int ret;
> +
> +       inv_arg.func =3D TA_CMD_RTC_GET_TIME;
> +       inv_arg.session =3D priv->session_id;
> +       inv_arg.num_params =3D 4;
> +
> +       /* Fill invoke cmd params */
> +       param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> +       param[0].u.memref.shm =3D priv->shm;
> +       param[0].u.memref.size =3D sizeof(struct optee_rtc_time);
> +
> +       ret =3D tee_client_invoke_func(priv->ctx, &inv_arg, param);
> +       if (ret < 0 || inv_arg.ret !=3D 0) {
> +               dev_err(dev, "TA_CMD_RTC_GET_TIME invoke ret: %d, tee ret=
: %x\n", ret, inv_arg.ret);
> +               return ret ? ret : -EPROTO;
> +       }
> +
> +       optee_tm =3D tee_shm_get_va(priv->shm, 0);
> +       if (IS_ERR(optee_tm)) {
> +               dev_err(dev, "tee_shm_get_va failed\n");
> +               return PTR_ERR(optee_tm);
> +       }
> +
> +       if (param[0].u.memref.size !=3D sizeof(*optee_tm)) {
> +               dev_err(dev, "Invalid read size from OPTEE\n");
> +               return -EPROTO;
> +       }

The dev_err() prints above are basically covering "can't happen"
cases. Robust code should certainly do the checks, but I'm not so sure
about how useful the prints are.

> +
> +       tm->tm_sec =3D optee_tm->tm_sec;
> +       tm->tm_min =3D optee_tm->tm_min;
> +       tm->tm_hour =3D optee_tm->tm_hour;
> +       tm->tm_mday =3D optee_tm->tm_mday;
> +       tm->tm_mon =3D optee_tm->tm_mon;
> +       tm->tm_year =3D optee_tm->tm_year - 1900;
> +       tm->tm_wday =3D optee_tm->tm_wday;
> +       tm->tm_yday =3D rtc_year_days(tm->tm_mday, tm->tm_mon, tm->tm_yea=
r);
> +
> +       return 0;
> +}
> +
> +static int optee_rtc_settime(struct device *dev, struct rtc_time *tm)
> +{
> +       struct optee_rtc *priv =3D dev_get_drvdata(dev);
> +       struct tee_ioctl_invoke_arg inv_arg =3D {0};
> +       struct tee_param param[4] =3D {0};
> +       struct optee_rtc_time optee_tm;
> +       void *rtc_data;
> +       int ret;
> +
> +       optee_tm.tm_sec =3D tm->tm_sec;
> +       optee_tm.tm_min =3D tm->tm_min;
> +       optee_tm.tm_hour =3D tm->tm_hour;
> +       optee_tm.tm_mday =3D tm->tm_mday;
> +       optee_tm.tm_mon =3D tm->tm_mon;
> +       optee_tm.tm_year =3D tm->tm_year + 1900;
> +       optee_tm.tm_wday =3D tm->tm_wday;
> +
> +       inv_arg.func =3D TA_CMD_RTC_SET_TIME;
> +       inv_arg.session =3D priv->session_id;
> +       inv_arg.num_params =3D 4;
> +
> +       param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT;
> +       param[0].u.memref.shm =3D priv->shm;
> +       param[0].u.memref.size =3D sizeof(struct optee_rtc_time);
> +
> +       rtc_data =3D tee_shm_get_va(priv->shm, 0);
> +       if (IS_ERR(rtc_data)) {
> +               dev_err(dev, "tee_shm_get_va failed\n");
> +               return PTR_ERR(rtc_data);
> +       }
> +
> +       memcpy(rtc_data, &optee_tm, sizeof(struct optee_rtc_time));
> +
> +       ret =3D tee_client_invoke_func(priv->ctx, &inv_arg, param);
> +       if (ret < 0 || inv_arg.ret !=3D 0) {
> +               dev_err(dev, "TA_CMD_RTC_SET_TIME invoke ret: %d, tee ret=
: %x\n", ret, inv_arg.ret);
> +               return ret ? ret : -EPROTO;
> +       }
> +
> +       return 0;
> +}
> +
> +static int optee_rtc_readoffset(struct device *dev, long *offset)
> +{
> +       struct optee_rtc *priv =3D dev_get_drvdata(dev);
> +       struct tee_ioctl_invoke_arg inv_arg =3D {0};
> +       struct tee_param param[4] =3D {0};
> +       int ret;
> +
> +       if (!(priv->features & TA_RTC_FEATURE_CORRECTION))
> +               return -EOPNOTSUPP;
> +
> +       inv_arg.func =3D TA_CMD_RTC_GET_OFFSET;
> +       inv_arg.session =3D priv->session_id;
> +       inv_arg.num_params =3D 4;
> +
> +       param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
> +
> +       ret =3D tee_client_invoke_func(priv->ctx, &inv_arg, param);
> +       if (ret < 0 || inv_arg.ret !=3D 0) {
> +               dev_err(dev, "TA_CMD_RTC_GET_OFFSET invoke ret: %d, tee r=
et: %x\n", ret,
> +                       inv_arg.ret);
> +               return ret ? ret : -EPROTO;
> +       }
> +
> +       *offset =3D param[0].u.value.a;
> +
> +       return 0;
> +}
> +
> +static int optee_rtc_setoffset(struct device *dev, long offset)
> +{
> +       struct optee_rtc *priv =3D dev_get_drvdata(dev);
> +       struct tee_ioctl_invoke_arg inv_arg =3D {0};
> +       struct tee_param param[4] =3D {0};
> +       int ret;
> +
> +       if (!(priv->features & TA_RTC_FEATURE_CORRECTION))
> +               return -EOPNOTSUPP;
> +
> +       inv_arg.func =3D TA_CMD_RTC_SET_OFFSET;
> +       inv_arg.session =3D priv->session_id;
> +       inv_arg.num_params =3D 4;
> +
> +       param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INPUT;
> +       param[0].u.value.a =3D offset;
> +
> +       ret =3D tee_client_invoke_func(priv->ctx, &inv_arg, param);
> +       if (ret < 0 || inv_arg.ret !=3D 0) {
> +               dev_err(dev, "TA_CMD_RTC_SET_OFFSET invoke ret: %d, tee r=
et: %x\n", ret,
> +                       inv_arg.ret);
> +               return ret ? ret : -EPROTO;
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct rtc_class_ops optee_rtc_ops =3D {
> +       .read_time      =3D optee_rtc_readtime,
> +       .set_time       =3D optee_rtc_settime,
> +       .set_offset     =3D optee_rtc_setoffset,
> +       .read_offset    =3D optee_rtc_readoffset,
> +};
> +
> +static int optee_rtc_read_info(struct device *dev, struct rtc_device *rt=
c,
> +                              u64 *features)
> +{
> +       struct optee_rtc *priv =3D dev_get_drvdata(dev);
> +       struct tee_ioctl_invoke_arg inv_arg =3D {0};
> +       struct tee_param param[4] =3D {0};
> +       struct optee_rtc_info *info;
> +       struct optee_rtc_time *tm;
> +       int ret;
> +
> +       inv_arg.func =3D TA_CMD_RTC_GET_INFO;
> +       inv_arg.session =3D priv->session_id;
> +       inv_arg.num_params =3D 4;
> +
> +       param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> +       param[0].u.memref.shm =3D priv->shm;
> +       param[0].u.memref.size =3D sizeof(*info);
> +
> +       ret =3D tee_client_invoke_func(priv->ctx, &inv_arg, param);
> +       if (ret < 0 || inv_arg.ret !=3D 0) {
> +               dev_err(dev, "TA_CMD_RTC_GET_INFO invoke ret: %d, tee ret=
: %x\n", ret, inv_arg.ret);
> +               return -EINVAL;
> +       }
> +
> +       info =3D tee_shm_get_va(priv->shm, 0);
> +       if (IS_ERR(info)) {
> +               dev_err(dev, "tee_shm_get_va failed\n");
> +               return PTR_ERR(info);
> +       }
> +
> +       if (param[0].u.memref.size !=3D sizeof(*info)) {
> +               dev_err(dev, "Invalid read size from OPTEE\n");
> +               return -EPROTO;
> +       }
> +
> +       if (info->version !=3D RTC_INFO_VERSION) {
> +               dev_err(dev, "Unsupported information version %llu\n", in=
fo->version);
> +               return -EPROTO;
> +       }
> +
> +       *features =3D info->features;
> +
> +       tm =3D &info->range_min;
> +       rtc->range_min =3D mktime64(tm->tm_year, tm->tm_mon, tm->tm_mday,=
 tm->tm_hour, tm->tm_min,
> +                                 tm->tm_sec);
> +       tm =3D &info->range_max;
> +       rtc->range_max =3D mktime64(tm->tm_year, tm->tm_mon, tm->tm_mday,=
 tm->tm_hour, tm->tm_min,
> +                                 tm->tm_sec);
> +
> +       return 0;
> +}
> +
> +static int optee_ctx_match(struct tee_ioctl_version_data *ver, const voi=
d *data)
> +{
> +       if (ver->impl_id =3D=3D TEE_IMPL_ID_OPTEE)
> +               return 1;
> +       else
> +               return 0;
> +}
> +
> +static int optee_rtc_probe(struct device *dev)
> +{
> +       struct tee_client_device *rtc_device =3D to_tee_client_device(dev=
);
> +       struct tee_ioctl_open_session_arg sess_arg;
> +       struct optee_rtc *priv;
> +       struct rtc_device *rtc;
> +       struct tee_shm *shm;
> +       int ret, err;
> +
> +       memset(&sess_arg, 0, sizeof(sess_arg));
> +
> +       priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       rtc =3D devm_rtc_allocate_device(dev);
> +       if (IS_ERR(rtc))
> +               return PTR_ERR(rtc);
> +
> +       /* Open context with TEE driver */
> +       priv->ctx =3D tee_client_open_context(NULL, optee_ctx_match, NULL=
, NULL);
> +       if (IS_ERR(priv->ctx))
> +               return -ENODEV;
> +
> +       /* Open session with rtc Trusted App */
> +       export_uuid(sess_arg.uuid, &rtc_device->id.uuid);
> +       sess_arg.clnt_login =3D TEE_IOCTL_LOGIN_REE_KERNEL;
> +
> +       ret =3D tee_client_open_session(priv->ctx, &sess_arg, NULL);
> +       if (ret < 0 || sess_arg.ret !=3D 0) {
> +               dev_err(dev, "tee_client_open_session failed, err: %x\n",=
 sess_arg.ret);

This print is the most useful print in the driver. This is typically
reached if the PTA doesn't exist.

> +               err =3D -EINVAL;
> +               goto out_ctx;
> +       }
> +       priv->session_id =3D sess_arg.session;
> +
> +       shm =3D tee_shm_alloc_kernel_buf(priv->ctx, sizeof(struct optee_r=
tc_info));
> +       if (IS_ERR(shm)) {
> +               dev_err(priv->dev, "tee_shm_alloc_kernel_buf failed\n");
> +               err =3D PTR_ERR(shm);
> +               goto out_sess;
> +       }
> +
> +       priv->shm =3D shm;
> +       priv->dev =3D dev;
> +       dev_set_drvdata(dev, priv);
> +
> +       rtc->ops =3D &optee_rtc_ops;
> +
> +       err =3D optee_rtc_read_info(dev, rtc, &priv->features);
> +       if (err) {
> +               dev_err(dev, "Failed to get RTC features from OP-TEE\n");

This print could also be worth keeping, but the rest are in my opinion
of limited interest.

It's a tradeoff with the prints, no big deal if you'd like to keep more.

Cheers,
Jens

> +               goto out_shm;
> +       }
> +
> +       err =3D devm_rtc_register_device(rtc);
> +       if (err)
> +               goto out_shm;
> +
> +       /*
> +        * We must clear this bit after registering because rtc_register_=
device
> +        * will set it if it sees that .set_offset is provided.
> +        */
> +       if (!(priv->features & TA_RTC_FEATURE_CORRECTION))
> +               clear_bit(RTC_FEATURE_CORRECTION, rtc->features);
> +
> +       return 0;
> +
> +out_shm:
> +       tee_shm_free(priv->shm);
> +out_sess:
> +       tee_client_close_session(priv->ctx, priv->session_id);
> +out_ctx:
> +       tee_client_close_context(priv->ctx);
> +
> +       return err;
> +}
> +
> +static int optee_rtc_remove(struct device *dev)
> +{
> +       struct optee_rtc *priv =3D dev_get_drvdata(dev);
> +
> +       tee_client_close_session(priv->ctx, priv->session_id);
> +       tee_client_close_context(priv->ctx);
> +
> +       return 0;
> +}
> +
> +static const struct tee_client_device_id optee_rtc_id_table[] =3D {
> +       {UUID_INIT(0xf389f8c8, 0x845f, 0x496c,
> +                  0x8b, 0xbe, 0xd6, 0x4b, 0xd2, 0x4c, 0x92, 0xfd)},
> +       {}
> +};
> +
> +MODULE_DEVICE_TABLE(tee, optee_rtc_id_table);
> +
> +static struct tee_client_driver optee_rtc_driver =3D {
> +       .id_table       =3D optee_rtc_id_table,
> +       .driver         =3D {
> +               .name           =3D "optee_rtc",
> +               .bus            =3D &tee_bus_type,
> +               .probe          =3D optee_rtc_probe,
> +               .remove         =3D optee_rtc_remove,
> +       },
> +};
> +
> +static int __init optee_rtc_mod_init(void)
> +{
> +       return driver_register(&optee_rtc_driver.driver);
> +}
> +
> +static void __exit optee_rtc_mod_exit(void)
> +{
> +       driver_unregister(&optee_rtc_driver.driver);
> +}
> +
> +module_init(optee_rtc_mod_init);
> +module_exit(optee_rtc_mod_exit);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>");
> +MODULE_DESCRIPTION("OP-TEE based RTC driver");
> --
> 2.34.1
>
