Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C4646E27E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 07:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhLIGda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 01:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbhLIGd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 01:33:29 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E3CC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 22:29:57 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id x10so5435516ioj.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 22:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q8iVKmula6kup2FggoACJYgOZKL5qkbL208e7B7YSZ0=;
        b=lIsVrGsHT/UrtLfGXyU57lgKV3+kffBBbS8DOnD4PJqXXM+TcoGFb8Aa7vvsW3mFj7
         GcILKQXBND1a2zNPqau8LY8JYlD9v1p/XyNrCvwquWQKTgZge72zMANLefatUAVOCUqS
         ShKC5y65hWZ2c6w6o5LRBc2TX71bQ8XZHklFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q8iVKmula6kup2FggoACJYgOZKL5qkbL208e7B7YSZ0=;
        b=tR+ItQA962lZFGTraamGWWHne8RkudnhIqbe+kdShS7Mjwl0HPXFeYTERPY/yvykbb
         C216nVm3HPlU1gK7iWqNkPBj7M/tAPNuhh2AdeEa7xMgsO6EWrWJCfeEXgAQnnPwZ+a+
         IuFJHvAqgcQVUtj3e7lRFDMI9CU8HCs6fU4zZAVfe3+q8z6dl2Sc7T+lLM8pk1OvL3g9
         tJdTkQRFSctmToBpXIle7u7CefeVN5SDJygxvYwwzIs9nc3RUr4sIFDwXU/lctLAqsY0
         JYu7mwg09HC7EuKIdBw7HJ3sBL2SnKUF2PPxvPQXnRF8QsY/ZkHwWqDLcembK60+elLd
         qHcA==
X-Gm-Message-State: AOAM5331TjN14zj308xaOJbMZVhSfGEE91QiHOwb2U5EMNfnlfQszRAQ
        T8VXB6oFYddV8xEsuOG19e6eNrgagO7klCMYibergA==
X-Google-Smtp-Source: ABdhPJz1ziC9jdN583VzYZiyMCss/621HPuZKoxSvszO++lZ7FQD6vUcUIB1z0a0HEZnAytrVVflJqwOW8m4dTCGqDg=
X-Received: by 2002:a6b:2bc3:: with SMTP id r186mr12772991ior.167.1639031396270;
 Wed, 08 Dec 2021 22:29:56 -0800 (PST)
MIME-Version: 1.0
References: <20211110130623.20553-1-granquet@baylibre.com> <20211110130623.20553-8-granquet@baylibre.com>
In-Reply-To: <20211110130623.20553-8-granquet@baylibre.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 9 Dec 2021 14:29:30 +0800
Message-ID: <CAJMQK-gGE78qZoR92d8OH6_vTzBR5ry04nKGS22Dw48vAo7+AA@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] drm/mediatek: Add mt8195 DisplayPort driver
To:     Guillaume Ranquet <granquet@baylibre.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 9:08 PM Guillaume Ranquet <granquet@baylibre.com> wrote:
>
> From: Markus Schneider-Pargmann <msp@baylibre.com>
>
> This patch adds a DisplayPort driver for the Mediatek mt8195 SoC and a
> according phy driver mediatek-dp-phy.
>
> It supports both functional units on the mt8195, the embedded
> DisplayPort as well as the external DisplayPort units. It offers
> hot-plug-detection, audio up to 8 channels, and DisplayPort 1.4 with up
> to 4 lanes.
>
> The driver creates a child device for the phy. The child device will
> never exist without the parent being active. As they are sharing a
> register range, the parent passes a regmap pointer to the child so that
> both can work with the same register range. The phy driver sets device
> data that is read by the parent to get the phy device that can be used
> to control the phy properties.
>
> This driver is based on an initial version by
> Jason-JH.Lin <jason-jh.lin@mediatek.com>.
>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---


<snip>

> +static int mtk_dp_probe(struct platform_device *pdev)
> +{
> +       struct mtk_dp *mtk_dp;
> +       struct device *dev = &pdev->dev;
> +       int ret;
> +       int irq_num = 0;
> +       struct drm_panel *panel = NULL;
> +
> +       mtk_dp = devm_kzalloc(dev, sizeof(*mtk_dp), GFP_KERNEL);
> +       if (!mtk_dp)
> +               return -ENOMEM;
> +
> +       mtk_dp->dev = dev;
> +
> +       irq_num = platform_get_irq(pdev, 0);
> +       if (irq_num < 0) {
> +               dev_err(dev, "failed to request dp irq resource\n");
> +               return -EPROBE_DEFER;
> +       }
> +
> +       ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0, &panel,
> +                                         &mtk_dp->next_bridge);
> +       if (ret == -ENODEV) {
> +               dev_info(
> +                       dev,
> +                       "No panel connected in devicetree, continuing as external DP\n");
> +               mtk_dp->next_bridge = NULL;
> +       } else if (ret) {
> +               dev_err(dev, "Failed to find panel or bridge: %d\n", ret);

Hi,

We're seeing
[    0.424599] mediatek-drm-dp 1c500000.edp_tx: Failed to find panel
or bridge: -517

It's probably better to use dev_err_probe here.

Thanks

> +               return ret;
> +       }
> +
> +       if (panel) {
> +               mtk_dp->next_bridge = devm_drm_panel_bridge_add(dev, panel);
> +               if (IS_ERR(mtk_dp->next_bridge)) {
> +                       ret = PTR_ERR(mtk_dp->next_bridge);
> +                       dev_err(dev, "Failed to create bridge: %d\n", ret);
> +                       return -EPROBE_DEFER;
> +               }
> +       }


<snip>

> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
