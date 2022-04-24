Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78A850D4F8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 22:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239496AbiDXUEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 16:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiDXUET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 16:04:19 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF671E3E0;
        Sun, 24 Apr 2022 13:01:17 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z99so16196002ede.5;
        Sun, 24 Apr 2022 13:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sf7MisxX3LNkimFSGyyrRktC622uWreucLzzkMFjVxE=;
        b=ZCIOZskE2WztPBVoBucejcl7KLi6eC4H3SnAqCPc8CvXVbhaKCFqwAOkouOeE3XIw4
         Xy2c+vTyka6xFaVskcbnlsDda6uY8l17JywdD5/voUCg6WN8WfLqOfGDW68e9t+zTrEt
         0EHyLLmWu+HgvGreor3M+2VVypMDBiYfpZCtdFON1ARa2E2BpkOlpCgpPhP2fFI1EA+5
         ObzvHgO+fm64AsNH8zzoWadVcDd/LHj4R65koel07f0BbMnNw0Gw4WNP2zXSvvs9gpKM
         tU7yAiznylfXsOKwsrA50rAMWixxISSD1TGwBbMsRoIYHTLavXJU2TUKruLGGZJBkdTh
         YiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sf7MisxX3LNkimFSGyyrRktC622uWreucLzzkMFjVxE=;
        b=F3/+iGbQsde0wgKPqCncdJOSe2RsUmk0TS0P/Y9lk/q/PzcGJP0RlOloBMH/eJ4/i1
         tuWdUSE6rHBP2tztyXYW2EX+sVVZi529WXwWV2ov5kYp8WG2BaB9vy8sNDeU6ZFV27Rc
         iC62RLvHRHarF0KSYkHbvg17WohsFXOxnI6dY7oGsMXjtGKsmcjW+UA43/qsyw9Lg+fo
         o/6mFjMRVZ6OMtve18FjJYcWIq8XWxa98GaYIA8a0jE9ezA6Lv6XNlyQTpHrZ9FWZxsu
         Xk0fCOYsQ5k3a0TmkOGavbNu0lAWOkeH3IkZHkRNv+4qyLLjxQdmOUcCRtI3qUQlAwf/
         JEqw==
X-Gm-Message-State: AOAM532z+weySoEqEpwiL126xY48IXwkO/VKZxrPww5eH4HUPTl4jKbC
        ZEsUJRVcT2mlJrar+VMwM2Axm8YblFSBoA==
X-Google-Smtp-Source: ABdhPJw9EYpgPzBF7aomsbu5Pu2r+fJI1zxuI2gBwhN5+KDIqR1ckuUKzGAma1SNoXggt53pH+Sczw==
X-Received: by 2002:a50:ed11:0:b0:425:c3d1:4547 with SMTP id j17-20020a50ed11000000b00425c3d14547mr12150359eds.410.1650830476615;
        Sun, 24 Apr 2022 13:01:16 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id x17-20020a170906297100b006e49a9535f3sm2893176ejd.114.2022.04.24.13.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 13:01:16 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 09/14] drm/sun4i: Allow VI layers to be primary planes
Date:   Sun, 24 Apr 2022 22:01:15 +0200
Message-ID: <2236113.ElGaqSPkdT@kista>
In-Reply-To: <20220424162633.12369-10-samuel@sholland.org>
References: <20220424162633.12369-1-samuel@sholland.org> <20220424162633.12369-10-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne nedelja, 24. april 2022 ob 18:26:27 CEST je Samuel Holland napisal(a):
> D1's mixer 1 has no UI layers, only a single VI layer. That means the
> mixer can only be used if the primary plane comes from this VI layer.
> Add the code to handle this case.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej Skrabec

> ---
> 
> (no changes since v2)
> 
> Changes in v2:
>  - Use Jernej's patches for mixer mode setting.
> 
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/
sun8i_vi_layer.c
> index bb7c43036dfa..f7d0b082d634 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -542,6 +542,7 @@ struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct 
drm_device *drm,
>  					       struct 
sun8i_mixer *mixer,
>  					       int index)
>  {
> +	enum drm_plane_type type = DRM_PLANE_TYPE_OVERLAY;
>  	u32 supported_encodings, supported_ranges;
>  	unsigned int plane_cnt, format_count;
>  	struct sun8i_vi_layer *layer;
> @@ -560,12 +561,15 @@ struct sun8i_vi_layer *sun8i_vi_layer_init_one(struct 
drm_device *drm,
>  		format_count = ARRAY_SIZE(sun8i_vi_layer_formats);
>  	}
>  
> +	if (!mixer->cfg->ui_num && index == 0)
> +		type = DRM_PLANE_TYPE_PRIMARY;
> +
>  	/* possible crtcs are set later */
>  	ret = drm_universal_plane_init(drm, &layer->plane, 0,
>  				       &sun8i_vi_layer_funcs,
>  				       formats, format_count,
>  				       sun8i_layer_modifiers,
> -				       DRM_PLANE_TYPE_OVERLAY, 
NULL);
> +				       type, NULL);
>  	if (ret) {
>  		dev_err(drm->dev, "Couldn't initialize layer\n");
>  		return ERR_PTR(ret);
> -- 
> 2.35.1
> 
> 


