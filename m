Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C3C4CEDE3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 22:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiCFVJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 16:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiCFVJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 16:09:54 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1534563AF
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 13:09:01 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id r13so28024806ejd.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 13:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4l0W080xZIf3QYk6V9WCDPB76oV01j5YGaFdzyBHplo=;
        b=d5X6gJ102/jtxYdX1CKHlPcybjirVbJboxpe+uqmCNnZg4QfqKeAfuFYcmHj94zBJ5
         XST6OKiQzj1elcoyiX6Rr3S8ME+VdkUxTGtaaKMPmU2kqtj3TOIzQS3HrGbs4bkT4bXJ
         81zPNRxfC5n7y8PKytNooWebhyP0bVMcjQ7SCO5m7DaY0991LHdlH3fe1nW99EPqtRIU
         KKITfHnwMdNoWbUo7Uajd1ijWvflOJc5kCKByEnG9iJ8lowgwT5Nk7bmtitwSHpbO56D
         irA1wqxgZjo/xG9TjyXEyxniR564rudoE/uh3ZHg7n5Ma0fGObYPgqzUlI7QUBBCXKNz
         BSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4l0W080xZIf3QYk6V9WCDPB76oV01j5YGaFdzyBHplo=;
        b=WDRGYllQxDJAr+CsWG2jNqaCtk0LevsFh3JadxtNIHQO6fWab9weNVHtJJUPhnE7Bd
         RQv35/1YC4n8h3Io3TO963KC0IhtOdkWo/jEd4XCahYNWLs3ZxudmcXX4ucrsZJwbPIP
         hDNDpyK9guJKobzC6vy9x3syjiLyWY+3UEX0kBdcU2iRgJlpw2MNkA9Er2XOOkm+lmTQ
         sosTlYNka0RNNvMaC32+L9jNr+lC/r583SAZqxUu+sck0R9S3S/II6zHOE8Wju3qS5Rq
         +8rhFf0PwtNI8gn1v/syDyT3ZH1NLuB6snBqxzttW3swtlcFP5XXN/syYd198yiBw+T7
         Vzpw==
X-Gm-Message-State: AOAM530+5dPCC1kz3bYDwPIySbVx78aS8O2uoc8S3/TzC2hPZXj4WAlL
        +HV8nGSF/S9SQssY+EdA8ShxHYJ9CoBhSKM4h2xBrQ==
X-Google-Smtp-Source: ABdhPJz9aWmDOT4+zrT9jiJS74EaIx2/tFg7TOauHRqg02FaVr075Qg5hzEdUT6nmJiJRWlspmsZmG41iH5eaNgj6fo=
X-Received: by 2002:a17:906:7fc9:b0:6cf:d288:c9ef with SMTP id
 r9-20020a1709067fc900b006cfd288c9efmr6777163ejs.751.1646600939436; Sun, 06
 Mar 2022 13:08:59 -0800 (PST)
MIME-Version: 1.0
References: <20220302150717.11193-1-clement.leger@bootlin.com>
In-Reply-To: <20220302150717.11193-1-clement.leger@bootlin.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Sun, 6 Mar 2022 22:08:48 +0100
Message-ID: <CAN5uoS9J7P-74Zi-AuiXfTMesFOPEmFSmT2GcO8QmR6ebCXGAw@mail.gmail.com>
Subject: Re: [PATCH] rtc: optee: add RTC driver for OP-TEE RTC PTA
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
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

Hello Clement,

In the code, rtc-optee driver opens a session with optee and allocates
shared memory from probe to remove time.
This uses resources in the TEE but RTC is not accessed often by Linux I gue=
ss.
Would it be interesting if a session is opened and shared memory
allocated only when a RPC command is to be invoked?

Minor comments below.

Br,
etienne



On Wed, 2 Mar 2022 at 16:08, Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin=
.com> wrote:
>
> This drivers allows to communicate with a RTC PTA handled by OP-TEE [1].
> This PTA allows to query RTC information, set/get time and set/get
> offset depending on the supported features.
>
> [1] https://github.com/OP-TEE/optee_os/pull/5179
>
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> ---
>  MAINTAINERS             |   6 +
>  drivers/rtc/Kconfig     |  10 +
>  drivers/rtc/Makefile    |   1 +
>  drivers/rtc/rtc-optee.c | 395 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 412 insertions(+)
>  create mode 100644 drivers/rtc/rtc-optee.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4383949ff654..4449d5ca2e11 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14381,6 +14381,12 @@ L:     op-tee@lists.trustedfirmware.org
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
> index d85a3c31347c..b10d88db8e9c 100644
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
> +         Select this to get support for OP-TEE based RTC control on ARM =
SoCs

I would remove the Arm SoCs reference. OP-TEE may be available on
other architectures in the future.

> +         where RTC are not accessible to the normal world (Linux).
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
> index 000000000000..f265056bf19e
> --- /dev/null
> +++ b/drivers/rtc/rtc-optee.c
> @@ -0,0 +1,395 @@
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
> + * @entropy_shm_pool:  Memory pool shared with RTC device.
> + * @features:          Bitfield of RTC features
> + */
> +struct optee_rtc {
> +       struct device *dev;
> +       struct tee_context *ctx;
> +       u32 session_id;
> +       struct tee_shm *entropy_shm_pool;
> +       u64 features;
> +};
> +
> +static int optee_rtc_readtime(struct device *dev, struct rtc_time *tm)
> +{
> +       struct optee_rtc *priv =3D dev_get_drvdata(dev);
> +       struct tee_ioctl_invoke_arg inv_arg =3D {0};
> +       struct optee_rtc_time *optee_tm;
> +       struct tee_param param[4] =3D {0};
> +       int ret =3D 0;
> +
> +       inv_arg.func =3D TA_CMD_RTC_GET_TIME;
> +       inv_arg.session =3D priv->session_id;
> +       inv_arg.num_params =3D 4;
> +
> +       /* Fill invoke cmd params */
> +       param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> +       param[0].u.memref.shm =3D priv->entropy_shm_pool;
> +       param[0].u.memref.size =3D sizeof(struct optee_rtc_time);
> +       param[0].u.memref.shm_offs =3D 0;

can remove this line

> +
> +       ret =3D tee_client_invoke_func(priv->ctx, &inv_arg, param);
> +       if ((ret < 0) || (inv_arg.ret !=3D 0)) {
> +               dev_err(dev, "TA_CMD_RTC_GET_TIME invoke err: %x\n",
> +                       inv_arg.ret);

print also 'ret' in case error is reported by its value?

> +               return ret;

Be careful here to return an errno when ret=3D=3D0 and inv_arg.ret!=3D0.
suggestion: return ret ? ret : -EPROTO;

> +       }
> +
> +       optee_tm =3D tee_shm_get_va(priv->entropy_shm_pool, 0);
> +       if (IS_ERR(optee_tm)) {
> +               dev_err(dev, "tee_shm_get_va failed\n");
> +               return PTR_ERR(optee_tm);
> +       }
> +
> +       if (param[0].u.memref.size !=3D sizeof(*optee_tm)) {
> +               dev_err(dev, "Invalid read size from OPTEE\n");
> +               return -EINVAL;

-EINVAL or -EPROTO.


> +       }
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
> +       struct optee_rtc_time optee_tm;
> +       struct tee_param param[4] =3D {0};
> +       void *rtc_data;
> +       int ret =3D 0;
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
> +       param[0].u.memref.shm =3D priv->entropy_shm_pool;
> +       param[0].u.memref.size =3D sizeof(struct optee_rtc_time);
> +       param[0].u.memref.shm_offs =3D 0;
> +
> +       rtc_data =3D tee_shm_get_va(priv->entropy_shm_pool, 0);
> +       if (IS_ERR(rtc_data)) {
> +               dev_err(dev, "tee_shm_get_va failed\n");
> +               return PTR_ERR(rtc_data);
> +       }
> +
> +       memcpy(rtc_data, &optee_tm, sizeof(struct optee_rtc_time));
> +
> +       ret =3D tee_client_invoke_func(priv->ctx, &inv_arg, param);
> +       if ((ret < 0) || (inv_arg.ret !=3D 0)) {
> +               dev_err(dev, "TA_CMD_RTC_GET_TIME invoke err: %x\n",
> +                       inv_arg.ret);
> +               return ret;

Ditto: 'return ret ? ret : -EPROTO;'

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
> +       int ret =3D 0;
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
> +       if ((ret < 0) || (inv_arg.ret !=3D 0)) {
> +               dev_err(dev, "TA_CMD_RTC_GET_RNG_INFO invoke err: %x\n",
> +                       inv_arg.ret);
> +               return -EINVAL;
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
> +       int ret =3D 0;
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
> +       if ((ret < 0) || (inv_arg.ret !=3D 0)) {
> +               dev_err(dev, "TA_CMD_RTC_GET_RNG_INFO invoke err: %x\n",
> +                       inv_arg.ret);
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
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
> +       int ret =3D 0;
> +
> +       inv_arg.func =3D TA_CMD_RTC_GET_INFO;
> +       inv_arg.session =3D priv->session_id;
> +       inv_arg.num_params =3D 4;
> +
> +       param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT;
> +       param[0].u.memref.shm =3D priv->entropy_shm_pool;
> +       param[0].u.memref.size =3D sizeof(*info);
> +       param[0].u.memref.shm_offs =3D 0;
> +
> +       ret =3D tee_client_invoke_func(priv->ctx, &inv_arg, param);
> +       if ((ret < 0) || (inv_arg.ret !=3D 0)) {
> +               dev_err(dev, "TA_CMD_RTC_GET_RNG_INFO invoke err: %x\n",
> +                       inv_arg.ret);
> +               return -EINVAL;
> +       }
> +
> +       info =3D tee_shm_get_va(priv->entropy_shm_pool, 0);
> +       if (IS_ERR(info)) {
> +               dev_err(dev, "tee_shm_get_va failed\n");
> +               return PTR_ERR(info);
> +       }
> +
> +       if (param[0].u.memref.size < sizeof(*info)) {
> +               dev_err(dev, "Invalid read size from OPTEE\n");
> +               return -EINVAL;

This is also a protocol error. Prefer -EPROTO.

> +       }
> +
> +       if (info->version !=3D RTC_INFO_VERSION) {
> +               dev_err(dev, "Unsupported information version %llu\n",
> +                             info->version);
> +               return -EINVAL;
> +       }
> +
> +       *features =3D info->features;
> +
> +       tm =3D &info->range_min;
> +       rtc->range_min =3D mktime64(tm->tm_year, tm->tm_mon, tm->tm_mday,
> +                                 tm->tm_hour, tm->tm_min, tm->tm_sec);
> +       tm =3D &info->range_max;
> +       rtc->range_max =3D mktime64(tm->tm_year, tm->tm_mon, tm->tm_mday,
> +                                 tm->tm_hour, tm->tm_min, tm->tm_sec);
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
> +       struct tee_shm *entropy_shm_pool =3D NULL;
> +       int ret =3D 0, err =3D -ENODEV;
> +       struct optee_rtc *priv;
> +       struct rtc_device *rtc;
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
,
> +                                              NULL);

Fits in 100 chars. You could get rid of few line breaks in this change.

> +       if (IS_ERR(priv->ctx))
> +               return -ENODEV;
> +
> +       /* Open session with rtc Trusted App */
> +       memcpy(sess_arg.uuid, rtc_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
> +       sess_arg.clnt_login =3D TEE_IOCTL_LOGIN_REE_KERNEL;
> +       sess_arg.num_params =3D 0;

not needed.

> +
> +       ret =3D tee_client_open_session(priv->ctx, &sess_arg, NULL);
> +       if ((ret < 0) || (sess_arg.ret !=3D 0)) {
> +               dev_err(dev, "tee_client_open_session failed, err: %x\n",
> +                       sess_arg.ret);
> +               err =3D -EINVAL;
> +               goto out_ctx;
> +       }
> +       priv->session_id =3D sess_arg.session;
> +
> +       entropy_shm_pool =3D tee_shm_alloc(priv->ctx,
> +                                        sizeof(struct optee_rtc_info),
> +                                        TEE_SHM_MAPPED | TEE_SHM_DMA_BUF=
);
> +       if (IS_ERR(entropy_shm_pool)) {
> +               dev_err(priv->dev, "tee_shm_alloc failed\n");
> +               err =3D PTR_ERR(entropy_shm_pool);
> +               goto out_sess;
> +       }
> +
> +       priv->entropy_shm_pool =3D entropy_shm_pool;
> +       priv->dev =3D dev;
> +       dev_set_drvdata(dev, priv);
> +
> +       rtc->ops =3D &optee_rtc_ops;
> +
> +       err =3D optee_rtc_read_info(dev, rtc, &priv->features);
> +       if (err) {
> +               dev_err(dev, "Failed to get RTC features from OP-TEE\n");
> +               goto out_sess;

Should release the allocated shared memory on exit.

> +       }
> +
> +       err =3D devm_rtc_register_device(rtc);
> +       if (err)
> +               goto out_sess;

Ditto.

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
