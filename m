Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C057E4850B5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbiAEKHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:07:21 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4339 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiAEKHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:07:20 -0500
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JTQ815dxmz67bMk;
        Wed,  5 Jan 2022 18:04:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 5 Jan 2022 11:07:18 +0100
Received: from localhost (10.47.83.118) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 5 Jan
 2022 10:07:16 +0000
Date:   Wed, 5 Jan 2022 10:07:23 +0000
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
Subject: Re: [PATCH 5/8] PM: runtime: Add EXPORT[_GPL]_RUNTIME_DEV_PM_OPS
 macros
Message-ID: <20220105100723.00001958@Huawei.com>
In-Reply-To: <20220104214214.198843-6-paul@crapouillou.net>
References: <20220104214214.198843-1-paul@crapouillou.net>
        <20220104214214.198843-6-paul@crapouillou.net>
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

On Tue, 4 Jan 2022 21:42:11 +0000
Paul Cercueil <paul@crapouillou.net> wrote:

> Similar to EXPORT[_GPL]_SIMPLE_DEV_PM_OPS, but for users with runtime-PM
> suspend/resume callbacks.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Follow up earlier comment.  I think you want pm_ptr() around all the
entries for RUNTIME_PM_OPS

Jonathan

> ---
>  include/linux/pm_runtime.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 4af454d29281..a7f862a26c03 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -36,6 +36,13 @@
>  			   pm_runtime_force_resume, suspend_fn, \
>  			   resume_fn, idle_fn)
>  
> +#define EXPORT_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
> +	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
> +			   suspend_fn, resume_fn, idle_fn, "")
> +#define EXPORT_GPL_RUNTIME_DEV_PM_OPS(name, suspend_fn, resume_fn, idle_fn) \
> +	_EXPORT_DEV_PM_OPS(name, pm_runtime_force_suspend, pm_runtime_force_resume, \
> +			   suspend_fn, resume_fn, idle_fn, "_gpl")
> +
>  #ifdef CONFIG_PM
>  extern struct workqueue_struct *pm_wq;
>  

