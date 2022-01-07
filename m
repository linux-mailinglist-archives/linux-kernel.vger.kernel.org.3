Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48F3487CFF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 20:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiAGT1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 14:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiAGT1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:27:08 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB286C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 11:27:07 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso7699322otf.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 11:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7NkUgJRGyv/mGOJjcDFlQgMnvKEd2905SAIiMK/+wtE=;
        b=diH74T6M28+vlK6mRBohtBievIcLoYDNhMQVJQtqXb+BQhjwBBgE9hnxvnCqEe+mjX
         /I+FLpA0O1vUce24LeiofkQWsLGWOE7ROTLL5BznzuyIqOMjBJoy98WIkTPWrdQmLORk
         NyUa+oYBYwcr8qa6rjXNlyv3oytgrYJ2nQRZU5Ea6iuATUbNJ+EwEP3nsUG/QLDWyeTT
         J/rSDvmtQ2TuOBt5ylcNqKi24SQiUxZ8/4Q57iFAvYzeKQ8o2/EZI0Z0IbuEl/KlGWmP
         C/wVpqcEv74u4/20GTMZUSr4VOzA4mElSt4qA6VexPyNVk2iSPuEJAi6FudZaoN00sSO
         LyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7NkUgJRGyv/mGOJjcDFlQgMnvKEd2905SAIiMK/+wtE=;
        b=qlgU6ARoEJ4iVHif/uhqFiNqb19y5rmExO0DlnWzc7RtfNFY5QOVtQa19fa51O/Gzj
         X4WdBiXsIMEP5C4jQzc2ENnGxVfmr3RvzbZvmxr5yh+Fr4wiDJ/lZhOD6Nqazx4el0QK
         8QNJrn1q6EkDeL+G0XIstEL7G7tyrWPGAuHpOB22W0AWo4UZfUo58qFaXxzXYrQRfkOe
         bt3FtzXURL5MG/ji/VXMAsRP8f9hjRxffoy+6ZgKux5S7iUhRgQsY4FpikVxuHMnjoQp
         1DAie7A9RdL9UrlWiGZCz3G8ABdqJO6CkQKgDBJG8tqhEx/63nY2hIYEph4xRqrWT8Zr
         qBuw==
X-Gm-Message-State: AOAM532QbZxO+ABSl2U5wu9Yx3zPJoVuRk2u6SxAhVq9yxT7BDjNUF1K
        pHYnJPQ6lsSMvVcQhw46GOXPPg==
X-Google-Smtp-Source: ABdhPJwzflM4/ZC276UeLQsqnYjgLT3b8PYW7TqWlC7GqsDuQtLFWDALbglEfGsUu1xN50Cdhej/Fw==
X-Received: by 2002:a05:6830:1d5c:: with SMTP id p28mr49666970oth.10.1641583627216;
        Fri, 07 Jan 2022 11:27:07 -0800 (PST)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l3sm1067724oic.37.2022.01.07.11.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 11:27:06 -0800 (PST)
Date:   Fri, 7 Jan 2022 11:27:54 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, lukasz.luba@arm.com, robh@kernel.org,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        Andy Gross <agross@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v5 6/6] qcom/soc/drivers: Add DTPM description for sdm845
Message-ID: <YdiUOh8FtPRktlUM@ripper>
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
 <20211218130014.4037640-7-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211218130014.4037640-7-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 18 Dec 05:00 PST 2021, Daniel Lezcano wrote:

> The DTPM framework does support now the hierarchy description.
> 
> The platform specific code can call the hierarchy creation function
> with an array of struct dtpm_node pointing to their parents.
> 
> This patch provides a description of the big and Little CPUs and the
> GPU and tie them together under a virtual package name. Only sdm845 is
> described.
> 
> The description could be extended in the future with the memory
> controller with devfreq if it has the energy information.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/soc/qcom/Kconfig  |  9 ++++++
>  drivers/soc/qcom/Makefile |  1 +
>  drivers/soc/qcom/dtpm.c   | 65 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 75 insertions(+)
>  create mode 100644 drivers/soc/qcom/dtpm.c
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index e718b8735444..f21c1df2f2f9 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -228,4 +228,13 @@ config QCOM_APR
>  	  application processor and QDSP6. APR is
>  	  used by audio driver to configure QDSP6
>  	  ASM, ADM and AFE modules.
> +
> +config QCOM_DTPM
> +	tristate "Qualcomm DTPM hierarchy"
> +	depends on DTPM
> +	help
> +	 Describe the hierarchy for the Dynamic Thermal Power
> +	 Management tree on this platform. That will create all the
> +	 power capping capable devices.
> +
>  endmenu
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index 70d5de69fd7b..cf38496c3f61 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -28,3 +28,4 @@ obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
>  obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
>  obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
>  obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
> +obj-$(CONFIG_QCOM_DTPM) += dtpm.o
> diff --git a/drivers/soc/qcom/dtpm.c b/drivers/soc/qcom/dtpm.c
> new file mode 100644
> index 000000000000..c15283f59494
> --- /dev/null
> +++ b/drivers/soc/qcom/dtpm.c
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2021 Linaro Limited
> + *
> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
> + *
> + * DTPM hierarchy description
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/dtpm.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +static struct dtpm_node __initdata sdm845_hierarchy[] = {
> +	[0]{ .name = "sdm845" },

Why is the index signifiant here?
Doesn't this imply risk that we forget one element, which will be
thereby implicitly be left initialized as {} and hence denote
termination of the list?

> +	[1]{ .name = "package",
> +	     .parent = &sdm845_hierarchy[0] },
> +	[2]{ .name = "/cpus/cpu@0",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &sdm845_hierarchy[1] },
> +	[3]{ .name = "/cpus/cpu@100",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &sdm845_hierarchy[1] },
> +	[4]{ .name = "/cpus/cpu@200",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &sdm845_hierarchy[1] },
> +	[5]{ .name = "/cpus/cpu@300",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &sdm845_hierarchy[1] },
> +	[6]{ .name = "/cpus/cpu@400",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &sdm845_hierarchy[1] },
> +	[7]{ .name = "/cpus/cpu@500",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &sdm845_hierarchy[1] },
> +	[8]{ .name = "/cpus/cpu@600",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &sdm845_hierarchy[1] },
> +	[9]{ .name = "/cpus/cpu@700",
> +	     .type = DTPM_NODE_DT,
> +	     .parent = &sdm845_hierarchy[1] },
> +	[10]{ .name = "/soc@0/gpu@5000000",

It worries me that we encode the textual structure of the dts in the
kernel. E.g. for quite a while this was "/soc/gpu@5000000", so if this
landed a year ago this driver would have prevented us from correcting
the dts.

Another concern is that not all busses in the system are capable of
36-bit wide addresses, so it's plausible that we might one day have to
create a more accurate representation of the address space. Maybe not on
SDM845, but this would force us to be inconsistent.

Regards,
Bjorn

> +	     .type = DTPM_NODE_DT,
> +	     .parent = &sdm845_hierarchy[1] },
> +	[11]{ },
> +};
> +
> +static struct of_device_id __initdata sdm845_dtpm_match_table[] = {
> +        { .compatible = "qcom,sdm845", .data = sdm845_hierarchy },
> +        {},
> +};
> +
> +static int __init sdm845_dtpm_init(void)
> +{
> +	return dtpm_create_hierarchy(sdm845_dtpm_match_table);
> +}
> +late_initcall(sdm845_dtpm_init);
> +
> +MODULE_DESCRIPTION("Qualcomm DTPM driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:dtpm");
> +MODULE_AUTHOR("Daniel Lezcano <daniel.lezcano@kernel.org");
> +
> -- 
> 2.25.1
> 
