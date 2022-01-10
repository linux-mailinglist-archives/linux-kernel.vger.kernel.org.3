Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9475B48A3B5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 00:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345386AbiAJXfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 18:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241114AbiAJXfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 18:35:01 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BC1C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 15:35:01 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id w7so14438510plp.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 15:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=untIlPwKye6Bj6rhidldiVYqKmoKu4ryqg7eSnKyIu8=;
        b=AV+9sVlY+jfGr17KZUGGQK7PqQeflhlorxwlxmtvqLrz+Pggb9fDd1PTk3y+8C1Ix1
         za11MN2QkjEbL+lEDgSmBPwrWjcYcUB6+CbGaAvkG0f4PI793CTIKdV1aHkRpR9InDu0
         dTPpPbYmeCO61bvmKlEF5Oc1/6LP9eC9lWQQUw3hHoL7ceMPWL32xuTQiYa6t1g2ilrb
         lnXofrUoozVFfOaFN7PZr6ueIV3b4hajLMAe/LdUmyDwZSjm4KqtlZbIGahAW8oh6+D+
         2Lesp2RQT9yUO6PS1CwcVtMcbk4AukVh2/GuZNdoOHuTAnMczkGWVHGThdLhKdTwAua1
         95uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=untIlPwKye6Bj6rhidldiVYqKmoKu4ryqg7eSnKyIu8=;
        b=cx6ZlOjlcXzSHPoDoKkEMHpeIsnKq8x+djJfxC7vOGFRCAB7tf4a81nVbXfbXbFioF
         45oo10kBmANrSxsuQuqgWDRxqgIFy1gfSKSzy3ZBFqcl34vgedtVScye1G6Ze3FAnVFY
         OQYkhNAay251KVMUxyutpo7S2eDoTSx55eMLvoXikk5E6+zL+1CfneueTnRYoQboRvvM
         kVgm9zdsnyXWkj6ipUmMmJBqO0Hkx6YwYQlKt+5hEil6hpZiiXAVS7IIlVGoE2gFvH+X
         txb05P1TuXLRlWIa6gZAdgZT9FeVLK2gGxMZBEeiczHCZp0RFF3zfNqhTWlLvNDv1Gyu
         BKYA==
X-Gm-Message-State: AOAM530hJUecbSVFu9ZsRzIFwwwU6GH31YSYplYYVnMZ6vISPtb7zu2Z
        WB3mh/ys6AOzT41+D+Pz7sN+uA==
X-Google-Smtp-Source: ABdhPJwhTjPcZNSiS+Bsm5vKFEVcBbZFlnnv92MQj0X2uwN96nfPk5PErDe8ZpR+u2InJIqB07Y6HA==
X-Received: by 2002:a17:903:2442:b0:14a:54e3:3905 with SMTP id l2-20020a170903244200b0014a54e33905mr268165pls.55.1641857700358;
        Mon, 10 Jan 2022 15:35:00 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id u20sm4432122pfi.220.2022.01.10.15.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 15:34:59 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     linux-mediatek@lists.infradead.org, stonea168@163.com,
        huijuan.xie@mediatek.com, shuijing.li@mediatek.com,
        liangxu.xu@mediatek.com, xinlei.li@mediatek.com,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: Re: [PATCH v3 1/2] drm/panel: panel-boe-tv101wum-nl6: tune the
 power sequence to avoid leakage
In-Reply-To: <20211116094930.11470-2-jitao.shi@mediatek.com>
References: <20211116094930.11470-1-jitao.shi@mediatek.com>
 <20211116094930.11470-2-jitao.shi@mediatek.com>
Date:   Mon, 10 Jan 2022 15:34:59 -0800
Message-ID: <7hee5fupuk.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jitao Shi <jitao.shi@mediatek.com> writes:

> "auo,kd101n80-45na" 2st LCD SPEC update, need to modify the timing
> between IOVCC and mipi data.
> The 2st version of SPEC modifies the timing requirements from IOVCC to
> Mipi Data. IOVCC is now required to take precedence over MIPI DATA,
> otherwise there is a risk of leakage. It is recommended that the time
> for MIPI to enter LP11 be postponed after IOVCC (delay20ms).

Similar to what Daniel said on v2:  You're changing the behavior of
*all* users of this panel driver with this patch, in order to fix a
single user (in the next patch.)

> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> Change-Id: Ic5212e2145a7dbf2efef9e5585904a93e1bc5a28

Please drop gerrit IDs from upstream submissions.

Kevin

> ---
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 88 +++++++++++++++++++-------
>  include/drm/panel_boe_tv101wum_nl6.h           | 28 ++++++++
>  2 files changed, 94 insertions(+), 22 deletions(-)
>  create mode 100644 include/drm/panel_boe_tv101wum_nl6.h
>
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> index db9d0b86d542..02efee06c430 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -49,7 +49,7 @@ struct boe_panel {
>  	struct regulator *avee;
>  	struct regulator *avdd;
>  	struct gpio_desc *enable_gpio;
> -
> +	int powered_refcnt;
>  	bool prepared;
>  };
>  
> @@ -488,19 +488,15 @@ static int boe_panel_enter_sleep_mode(struct boe_panel *boe)
>  	return 0;
>  }
>  
> -static int boe_panel_unprepare(struct drm_panel *panel)
> +static int boe_panel_power_off(struct drm_panel *panel)
>  {
>  	struct boe_panel *boe = to_boe_panel(panel);
> -	int ret;
>  
> -	if (!boe->prepared)
> -		return 0;
> +	if (WARN_ON(boe->powered_refcnt == 0))
> +		return -EINVAL;
>  
> -	ret = boe_panel_enter_sleep_mode(boe);
> -	if (ret < 0) {
> -		dev_err(panel->dev, "failed to set panel off: %d\n", ret);
> -		return ret;
> -	}
> +	if (--boe->powered_refcnt != 0)
> +		return 0;
>  
>  	msleep(150);
>  
> @@ -520,17 +516,45 @@ static int boe_panel_unprepare(struct drm_panel *panel)
>  		regulator_disable(boe->pp1800);
>  	}
>  
> +	return 0;
> +}
> +
> +int panel_unprepare_power(struct drm_panel *panel)
> +{
> +	if (of_device_is_compatible(panel->dev->of_node, "auo,kd101n80-45na"))
> +		return boe_panel_power_off(panel);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(panel_unprepare_power);
> +
> +static int boe_panel_unprepare(struct drm_panel *panel)
> +{
> +	struct boe_panel *boe = to_boe_panel(panel);
> +	int ret;
> +
> +	if (!boe->prepared)
> +		return 0;
> +
> +	ret = boe_panel_enter_sleep_mode(boe);
> +	if (ret < 0) {
> +		dev_err(panel->dev, "failed to set panel off: %d\n", ret);
> +		return ret;
> +	}
> +
> +	boe_panel_power_off(panel);
> +
>  	boe->prepared = false;
>  
>  	return 0;
>  }
>  
> -static int boe_panel_prepare(struct drm_panel *panel)
> +static int boe_panel_power_on(struct drm_panel *panel)
>  {
>  	struct boe_panel *boe = to_boe_panel(panel);
>  	int ret;
>  
> -	if (boe->prepared)
> +	if (++boe->powered_refcnt != 1)
>  		return 0;
>  
>  	gpiod_set_value(boe->enable_gpio, 0);
> @@ -558,18 +582,8 @@ static int boe_panel_prepare(struct drm_panel *panel)
>  	gpiod_set_value(boe->enable_gpio, 1);
>  	usleep_range(6000, 10000);
>  
> -	ret = boe_panel_init_dcs_cmd(boe);
> -	if (ret < 0) {
> -		dev_err(panel->dev, "failed to init panel: %d\n", ret);
> -		goto poweroff;
> -	}
> -
> -	boe->prepared = true;
> -
>  	return 0;
>  
> -poweroff:
> -	regulator_disable(boe->avee);
>  poweroffavdd:
>  	regulator_disable(boe->avdd);
>  poweroff1v8:
> @@ -580,6 +594,36 @@ static int boe_panel_prepare(struct drm_panel *panel)
>  	return ret;
>  }
>  
> +int panel_prepare_power(struct drm_panel *panel)
> +{
> +	if (of_device_is_compatible(panel->dev->of_node, "auo,kd101n80-45na"))
> +		return boe_panel_power_on(panel);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(panel_prepare_power);
> +
> +static int boe_panel_prepare(struct drm_panel *panel)
> +{
> +	struct boe_panel *boe = to_boe_panel(panel);
> +	int ret;
> +
> +	boe_panel_power_on(panel);
> +
> +	if (boe->prepared)
> +		return 0;
> +
> +	ret = boe_panel_init_dcs_cmd(boe);
> +	if (ret < 0) {
> +		dev_err(panel->dev, "failed to init panel: %d\n", ret);
> +		return ret;
> +	}
> +
> +	boe->prepared = true;
> +
> +	return 0;
> +}
> +
>  static int boe_panel_enable(struct drm_panel *panel)
>  {
>  	msleep(130);
> diff --git a/include/drm/panel_boe_tv101wum_nl6.h b/include/drm/panel_boe_tv101wum_nl6.h
> new file mode 100644
> index 000000000000..72abe3eb7840
> --- /dev/null
> +++ b/include/drm/panel_boe_tv101wum_nl6.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Jitao Shi <jitao.shi@mediatek.com>
> + */
> +
> +#ifndef __PANEL_BOE_TV101WUM_NL6_H__
> +#define __PANEL_BOE_TV101WUM_NL6_H__
> +
> +#include <linux/types.h>
> +#include <drm/drm_panel.h>
> +
> +#if defined(CONFIG_DRM_PANEL_BOE_TV101WUM_NL6)
> +int panel_unprepare_power(struct drm_panel *panel);
> +int panel_prepare_power(struct drm_panel *panel);
> +#else
> +int panel_unprepare_power(struct drm_panel *panel)
> +{
> +	return 0;
> +}
> +
> +int panel_prepare_power(struct drm_panel *panel)
> +{
> +	return 0;
> +}
> +#endif
> +#endif /* __PANEL_BOE_TV101WUM_NL6_H__ */
> +
> -- 
> 2.12.5
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
