Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C96599CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349381AbiHSN3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349377AbiHSN26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:28:58 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E0C61D8F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:28:57 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id o22so5658088edc.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=EcVjTGn7kbtsskUzpli5enhaWEJ97X0D7MTunymKgDA=;
        b=EFINGNzLMYGWNtRBOvem2NfAjEGK5CsDlouqgDIseNqvAWaE/67j8+xZEQr5fzwv50
         50O6DLABl/kbDSCNvLyErR7bNIUV7/S6PM5SuRZMqq8otAu0mRiY7BDFSa/U5ZLJ5eOP
         UgNDmX4snUTIH3fPqVyJdhA0C4d1pM2cfBFr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=EcVjTGn7kbtsskUzpli5enhaWEJ97X0D7MTunymKgDA=;
        b=LSDqFyqezETbO1em317BAHBIt9+QAfn2zNZx/Q6GLf418imnADSYk5MBzaXzd0IWCs
         p3fwLmmXF7qRUyO78/8/bwciGu2aqAm/zV9DT+6xS+NCVwB5yh65KocDBeUBRClYYjTb
         Mg2J1gKTU5+H6LeoDfBYfbLk9YMF5H/ayw4kUrqXm4R0SqB5G35EpyaXbHk7cqX47DcL
         yczQ40UAg+iz0E1aIfryA9Zw59FCVGqKln5hlgnN2ybSdtlLO0XLvjk7wMedavod5z/K
         HkwaGtwwYLSJUB7fvC5TLSJ6oZ305VQ6pUjAko9RvyfKvD+j+OeMXa4CO2tTzZ/jOFid
         ofDA==
X-Gm-Message-State: ACgBeo3Y4F6d5+0cF3r9jdVdGKKjpGC5tMw+EolHiwLxLdPmx72GzFEh
        EWqV+sibK3+RmwnfRRcCLmHPM6GDet+5x/hkYok03g==
X-Google-Smtp-Source: AA6agR6NNo/OKhYHbs8DSbr0gfcQjweYTiRfMZ2zqaMVE6pXULEaWlXjNBLUMXZGbGHalj/+4CUprSImapqjpNaobAo=
X-Received: by 2002:a05:6402:4029:b0:443:a5f5:5324 with SMTP id
 d41-20020a056402402900b00443a5f55324mr6289038eda.51.1660915735800; Fri, 19
 Aug 2022 06:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220721172727.14624-1-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220721172727.14624-1-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 19 Aug 2022 21:28:44 +0800
Message-ID: <CAGXv+5H+BQcT=JTD3Y1necym=6uLHD8HgWpjjpyTLSin9D1KNA@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: dsi: Add atomic {destroy, duplicate}_state,
 reset callbacks
To:     chunkuang.hu@kernel.org
Cc:     jitao.shi@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        rex-bc.chen@mediatek.com, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        xinlei.lee@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022 at 1:27 AM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add callbacks for atomic_destroy_state, atomic_duplicate_state and
> atomic_reset to restore functionality of the DSI driver: this solves
> vblank timeouts when another bridge is present in the chain.
>
> Tested bridge chain: DSI <=> ANX7625 => aux-bus panel
>
> Fixes: 7f6335c6a258 ("drm/mediatek: Modify dsi funcs to atomic operations")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

This patch is now needed on top of v6.0-rc1, otherwise booting will
stall for a while waiting for display vblank, which never happens
because the DSI pipeline is not configured correctly.

ChenYu

> ---
>
> Note: The commit that has been mentioned in the Fixes tag should
>       *not* have my Reviewed-by tag, as the author changed it but
>       erroneously retained the tag that I had released for an
>       earlier version of that commit (which was fine, but the new
>       version broke mtk_dsi!).
>
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 9cc406e1eee1..5b624e0f5b0a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -808,10 +808,13 @@ static void mtk_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,
>
>  static const struct drm_bridge_funcs mtk_dsi_bridge_funcs = {
>         .attach = mtk_dsi_bridge_attach,
> +       .atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
>         .atomic_disable = mtk_dsi_bridge_atomic_disable,
> +       .atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
>         .atomic_enable = mtk_dsi_bridge_atomic_enable,
>         .atomic_pre_enable = mtk_dsi_bridge_atomic_pre_enable,
>         .atomic_post_disable = mtk_dsi_bridge_atomic_post_disable,
> +       .atomic_reset = drm_atomic_helper_bridge_reset,
>         .mode_set = mtk_dsi_bridge_mode_set,
>  };
>
> --
> 2.35.1
>
