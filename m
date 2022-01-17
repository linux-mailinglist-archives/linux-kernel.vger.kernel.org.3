Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7522C4911DA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 23:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243643AbiAQWns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 17:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbiAQWnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 17:43:46 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91381C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 14:43:46 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id t4-20020a05683022e400b00591aaf48277so21775193otc.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 14:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5+E4PSnXMRT02TmZcKnGMPVWqaFVYJ6Z2tvBmRV+d5Q=;
        b=t3pn50gIW/BLODEIGKxX+/HYRFZ2do7KWL+MipSCuuPPhMd2/oIBrQ7vkfxgSeXPcl
         h/O/zYj3vEojFPgdmfgFUYrFnCvKBFJ72q61KBC+GJtmJM9hcQUkj5Kfbd0ucg/rBGmQ
         o5g5MMi1va5MWn2Dx62Dd40tvrDX2TM/M6+7vaM6iWZa1K43GYSjgkjbY13au3QqGXo4
         6tuzIwfdwGNkh6BGqQF5aPkX8G2oo0W4vNqF4Q0qUEdNaYtaC6Gy+lGLQJF+VPYAYudn
         VxDnImhIK8VW2qcHKpLB3xfvJMf7V8ZoFf7qysY5STehzwDZCDla0CWFp9LXbW1Q6TmE
         95og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5+E4PSnXMRT02TmZcKnGMPVWqaFVYJ6Z2tvBmRV+d5Q=;
        b=Dosq+jBk14f1QcXFuXlBiSSGxhapTVggaNRcpRjlhFH8Ab+N94wg7Tg5rgBq84a91p
         YLxD8UT9ygMQWRP+/Zt3xgxSbyH6N97Rk3LypRMc/NhVTa+e0cAfveyDXcFdzTQfcsnL
         pUnOQ0WznuS5cTsiEw7gUPy6LA2N1lAJRLzasrZqFj14zaAG8osOYlrVk8PwWCzxwOkW
         KlmmdOKLlv6Rs4AKWHYZG4vB8w5SjzYXh87kTEJj67EMIuaiVIiGFdKiGXM2vP/YRof/
         60toVoWgoG9O2gMk4OgwS7EciO3ZO/ic4FaNIl1zdyrRK1Xy2pCC0B1sOAFbI+GTQ1Xk
         eALg==
X-Gm-Message-State: AOAM530iMP5WrzOrD6yAVkEfX5qrQMm5kulxOVe9emVHdnN2NhX+WCiE
        XqhOWCK5dslKYcjoCnGqZH8RVQ==
X-Google-Smtp-Source: ABdhPJwpan1hHIn3UngpvQmmwyO8P1iik8MOHOqSlTskwtmmmCcRQec+wDqLPuV1g4FmOHc+t+bbjw==
X-Received: by 2002:a05:6830:1512:: with SMTP id k18mr5351958otp.134.1642459425886;
        Mon, 17 Jan 2022 14:43:45 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id bg17sm7662177oib.25.2022.01.17.14.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 14:43:45 -0800 (PST)
Date:   Mon, 17 Jan 2022 16:43:40 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] remoteproc: qcom: q6v5: fix service routines build errors
Message-ID: <YeXxHE31J6CafxIz@builder.lan>
References: <20220115011338.2973-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220115011338.2973-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14 Jan 19:13 CST 2022, Randy Dunlap wrote:

> When CONFIG_QCOM_AOSS_QMP=m and CONFIG_QCOM_Q6V5_MSS=y, the builtin
> driver cannot call into the loadable module's low-level service
> functions. Trying to build with that config combo causes linker errors.
> 
> There are two problems here. First, drivers/remoteproc/qcom_q6v5.c
> should #include <linux/soc/qcom/qcom_aoss.h> for the definitions of
> the service functions, depending on whether CONFIG_QCOM_AOSS_QMP is
> set/enabled or not. Second, the qcom remoteproc drivers should depend
> on QCOM_AOSS_QMP iff it is enabled (=y or =m) so that the qcom
> remoteproc drivers can be built properly.
> 
> This prevents these build errors:
> 
> aarch64-linux-ld: drivers/remoteproc/qcom_q6v5.o: in function `q6v5_load_state_toggle':
> qcom_q6v5.c:(.text+0xc4): undefined reference to `qmp_send'
> aarch64-linux-ld: drivers/remoteproc/qcom_q6v5.o: in function `qcom_q6v5_deinit':
> (.text+0x2e4): undefined reference to `qmp_put'
> aarch64-linux-ld: drivers/remoteproc/qcom_q6v5.o: in function `qcom_q6v5_init':
> (.text+0x778): undefined reference to `qmp_get'
> aarch64-linux-ld: (.text+0x7d8): undefined reference to `qmp_put'
> 
> Fixes: c1fe10d238c0 ("remoteproc: qcom: q6v5: Use qmp_send to update co-processor load state")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: linux-remoteproc@vger.kernel.org
> Cc: Sibi Sankar <sibis@codeaurora.org>
> Cc: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/remoteproc/Kconfig     |    4 ++++
>  drivers/remoteproc/qcom_q6v5.c |    1 +
>  2 files changed, 5 insertions(+)
> 
> --- linux-next-20220114.orig/drivers/remoteproc/qcom_q6v5.c
> +++ linux-next-20220114/drivers/remoteproc/qcom_q6v5.c
> @@ -10,6 +10,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/soc/qcom/qcom_aoss.h>
>  #include <linux/soc/qcom/smem.h>
>  #include <linux/soc/qcom/smem_state.h>
>  #include <linux/remoteproc.h>
> --- linux-next-20220114.orig/drivers/remoteproc/Kconfig
> +++ linux-next-20220114/drivers/remoteproc/Kconfig
> @@ -180,6 +180,7 @@ config QCOM_Q6V5_ADSP
>  	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
>  	depends on QCOM_SYSMON || QCOM_SYSMON=n
>  	depends on RPMSG_QCOM_GLINK || RPMSG_QCOM_GLINK=n
> +	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
>  	select MFD_SYSCON
>  	select QCOM_PIL_INFO
>  	select QCOM_MDT_LOADER
> @@ -199,6 +200,7 @@ config QCOM_Q6V5_MSS
>  	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
>  	depends on QCOM_SYSMON || QCOM_SYSMON=n
>  	depends on RPMSG_QCOM_GLINK || RPMSG_QCOM_GLINK=n
> +	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
>  	select MFD_SYSCON
>  	select QCOM_MDT_LOADER
>  	select QCOM_PIL_INFO
> @@ -218,6 +220,7 @@ config QCOM_Q6V5_PAS
>  	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
>  	depends on QCOM_SYSMON || QCOM_SYSMON=n
>  	depends on RPMSG_QCOM_GLINK || RPMSG_QCOM_GLINK=n
> +	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
>  	select MFD_SYSCON
>  	select QCOM_PIL_INFO
>  	select QCOM_MDT_LOADER
> @@ -239,6 +242,7 @@ config QCOM_Q6V5_WCSS
>  	depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
>  	depends on QCOM_SYSMON || QCOM_SYSMON=n
>  	depends on RPMSG_QCOM_GLINK || RPMSG_QCOM_GLINK=n
> +	depends on QCOM_AOSS_QMP || QCOM_AOSS_QMP=n
>  	select MFD_SYSCON
>  	select QCOM_MDT_LOADER
>  	select QCOM_PIL_INFO
