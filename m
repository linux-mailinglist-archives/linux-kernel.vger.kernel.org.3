Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CBB4938ED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353906AbiASKvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346702AbiASKvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:51:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6D0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 02:51:38 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1nA8Ym-0004NV-S7; Wed, 19 Jan 2022 11:51:24 +0100
Message-ID: <bb71f83d4897ce818348522d9594b091478073ff.camel@pengutronix.de>
Subject: Re: [PATCH] drm/etnaviv: Add missing pm_runtime_put
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Yongzhi Liu <lyz_cs@pku.edu.cn>, linux+etnaviv@armlinux.org.uk,
        christian.gmeiner@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        etnaviv@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Wed, 19 Jan 2022 11:51:20 +0100
In-Reply-To: <1642515391-19329-1-git-send-email-lyz_cs@pku.edu.cn>
References: <1642515391-19329-1-git-send-email-lyz_cs@pku.edu.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, dem 18.01.2022 um 06:16 -0800 schrieb Yongzhi Liu:
> pm_runtime_get_sync() increments the runtime PM usage counter even
> when it returns an error code, thus a matching decrement is needed
> on the error handling path to keep the counter balanced.
> 
Instead of adding more error handling code here, I would prefer to
convert this to pm_runtime_resume_and_get to avoid this issue.

Regards,
Lucas

> Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index 242a5fd..5e81a98 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -1714,6 +1714,9 @@ static int etnaviv_gpu_bind(struct device *dev, struct device *master,
>  	return 0;
>  
>  out_sched:
> +#ifdef CONFIG_PM
> +	pm_runtime_put_autosuspend(gpu->dev);
> +#endif
>  	etnaviv_sched_fini(gpu);
>  
>  out_workqueue:


