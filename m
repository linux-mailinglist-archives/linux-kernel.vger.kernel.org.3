Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA634461507
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 13:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242857AbhK2MaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 07:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348345AbhK2M2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 07:28:12 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0A0C0A8898
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 03:13:29 -0800 (PST)
Received: from [192.168.1.111] (91-156-85-209.elisa-laajakaista.fi [91.156.85.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id BB2542A5;
        Mon, 29 Nov 2021 12:13:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638184406;
        bh=Vqb1oHTQtyBRFwbOpBRC7xMjgT/agFiiWNLHyTSNiW4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DitiWpoqutdhGqNOLXyNpxyNHGKwhsscj/LbEe5rGbIIy86rFXA7fwgeCjRGBYYtI
         +sHjBnxSz5SS9Neff+Eza0Y9Gnon8bWQ496hEr/FaRXp+nDt/eZcMXmqaCOdSQxq6j
         PzPX0KJOnJxegeRnfC1e+4I+/+vreBvQSmj1xloM=
Subject: Re: [PATCH] drm/tidss: Fix warning: unused variable 'tidss_pm_ops'
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Jyri Sarha <jyri.sarha@iki.fi>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20211129063347.404-1-caihuoqing@baidu.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Message-ID: <bc1a7d47-2afc-9385-d465-4d7fc1c59b21@ideasonboard.com>
Date:   Mon, 29 Nov 2021 13:13:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129063347.404-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2021 08:33, Cai Huoqing wrote:
> Mark 'tidss_pm_ops' as __maybe_unused to avoid
> the warning: unused variable 'tidss_pm_ops'
> 
> Fixes: 6e120594631f ("drm/tidss: Make use of the helper macro SET_RUNTIME_PM_OPS()")
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>   drivers/gpu/drm/tidss/tidss_drv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
> index 4366b5c798e0..7c784e90e40e 100644
> --- a/drivers/gpu/drm/tidss/tidss_drv.c
> +++ b/drivers/gpu/drm/tidss/tidss_drv.c
> @@ -88,7 +88,7 @@ static int __maybe_unused tidss_resume(struct device *dev)
>   	return drm_mode_config_helper_resume(&tidss->ddev);
>   }
>   
> -static const struct dev_pm_ops tidss_pm_ops = {
> +static __maybe_unused const struct dev_pm_ops tidss_pm_ops = {
>   	SET_SYSTEM_SLEEP_PM_OPS(tidss_suspend, tidss_resume)
>   	SET_RUNTIME_PM_OPS(tidss_pm_runtime_suspend, tidss_pm_runtime_resume, NULL)
>   };

Thanks, I'll push to drm-misc-next.

  Tomi
