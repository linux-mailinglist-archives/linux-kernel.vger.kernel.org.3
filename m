Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1AD4850CF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbiAEKMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:12:42 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4342 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239267AbiAEKMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:12:37 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JTQCK6yfQz67MtS;
        Wed,  5 Jan 2022 18:07:41 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 11:12:34 +0100
Received: from localhost (10.47.83.118) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 5 Jan
 2022 10:12:33 +0000
Date:   Wed, 5 Jan 2022 10:12:39 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Paul Cercueil <paul@crapouillou.net>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Arnd Bergmann" <arnd@arndb.de>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, <list@opendingux.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mips@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 7/8] mmc: jz4740: Make dev_pm_ops struct static
Message-ID: <20220105101239.00004f04@Huawei.com>
In-Reply-To: <20220104214214.198843-8-paul@crapouillou.net>
References: <20220104214214.198843-1-paul@crapouillou.net>
        <20220104214214.198843-8-paul@crapouillou.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.118]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2022 21:42:13 +0000
Paul Cercueil <paul@crapouillou.net> wrote:

> The new DEFINE_SIMPLE_DEV_PM_OPS() macro does not set the "static"
> qualifier anymore, so we can add it here, as the underlying dev_pm_ops
> struct is only used in this file.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/mmc/host/jz4740_mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 7693236c946f..7ab1b38a7be5 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -1128,8 +1128,8 @@ static int jz4740_mmc_resume(struct device *dev)
>  	return pinctrl_select_default_state(dev);
>  }
>  
> -DEFINE_SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
> -	jz4740_mmc_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
> +				jz4740_mmc_resume);
>  
>  static struct platform_driver jz4740_mmc_driver = {
>  	.probe = jz4740_mmc_probe,

