Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2853650D4F4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbiDXUCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 16:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232795AbiDXUCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 16:02:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCC214AF73;
        Sun, 24 Apr 2022 12:59:47 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id k23so25972785ejd.3;
        Sun, 24 Apr 2022 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bV7abALvJSLkm1kXyFRmPXQZ2gIon9h1Q/8YJtaLQt4=;
        b=lcAdQ6A+UaHD3xIrVIAm0/cpdlS52ljmY/RnUwRNx33hyNO15ij8+ZKeJ2lQ7pWkiy
         WDv1tK/A+g45C0CQaHsQvsYH8wBVOJ1k3Y7H/TSR/QyGyRXxKUPM5Tz0XuWUkHWunE5Y
         lBrOLHdwkS+hWXMRCmbZtV0woML4a7TscSAY0bS53ftl6TNrHE5qQvITz+a6uc7o5xnf
         C6O/kY1mU1P1UzIf9ev5uMDpE7GV2hUhpqiwpc+vovpuQ8ALgvweJRrF9W9/D7QzM33w
         nKILE+YGn8kTLiu8t+VdRp/35f9xuzkIdZ7evu4/5yJ0rs99yigb2Q4SzMy2bdTxwOj8
         sraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bV7abALvJSLkm1kXyFRmPXQZ2gIon9h1Q/8YJtaLQt4=;
        b=P5ObgUysZWUVM5l5IdWVX2rjG8HRY+Hz0csGN3/smg1KAtqQjNFjCOfVnGyKyD2wyD
         I9UO1/94J7mlXhe3qPfyfBiUoiAW4xWcscZ/cmMOlCd1NgTvvuzaZk3h13lpf/ey/3C1
         YUZ2oeQdgEV7DRYkmo0Bsd7TvE8N0tsOmT5s/I9hkIYfMJG4gW7niBxmrmuRaMQSoziY
         xxNIMywjLzAuTsrqxxopcLc/hqNZHqb2jVESlodzI7ClkntEuoO7ZIikkwNjq9UZKiS+
         ySXMA407c5qEG17ZdKyBnWTmAO/f14vcFfZJ2JI+TmMbeWLnEK/GDLrs6qZS3XB71g6K
         oNhA==
X-Gm-Message-State: AOAM533NVoRMtFG+NGJmgyFMukFGmGaxnETmBgKsztUBAJLbJLWBA4w2
        S8hpXYtF/nwu022uaBhKAmhv8zGhfHE=
X-Google-Smtp-Source: ABdhPJy+WUlHCxfjVulhRV24z4zq5PYWrKRNgfG26I/7xRNckO6yB1RPxAIu2B7iY6TbPQGLZ9u00A==
X-Received: by 2002:a17:907:7f28:b0:6f0:29eb:85ba with SMTP id qf40-20020a1709077f2800b006f029eb85bamr13971555ejc.15.1650830386246;
        Sun, 24 Apr 2022 12:59:46 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id m5-20020a17090607c500b006f1bf5f545asm2837299ejc.26.2022.04.24.12.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 12:59:45 -0700 (PDT)
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
        linux-sunxi@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 04/14] drm/sun4i: hdmi: Use more portable I/O helpers
Date:   Sun, 24 Apr 2022 21:59:44 +0200
Message-ID: <4732416.31r3eYUQgx@kista>
In-Reply-To: <20220424162633.12369-5-samuel@sholland.org>
References: <20220424162633.12369-1-samuel@sholland.org> <20220424162633.12369-5-samuel@sholland.org>
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

Dne nedelja, 24. april 2022 ob 18:26:22 CEST je Samuel Holland napisal(a):
> readsb/writesb are unavailable on some architectures. In preparation for
> removing the Kconfig architecture dependency, switch to the equivalent
> but more portable ioread/write8_rep helpers.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej Skrabec

> ---
> 
> (no changes since v2)
> 
> Changes in v2:
>  - New patch: I/O helper portability
> 
>  drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c b/drivers/gpu/drm/sun4i/
sun4i_hdmi_i2c.c
> index b66fa27fe6ea..c7d7e9fff91c 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_i2c.c
> @@ -56,9 +56,9 @@ static int fifo_transfer(struct sun4i_hdmi *hdmi, u8 *buf, 
int len, bool read)
>  		return -EIO;
>  
>  	if (read)
> -		readsb(hdmi->base + hdmi->variant->ddc_fifo_reg, buf, 
len);
> +		ioread8_rep(hdmi->base + hdmi->variant->ddc_fifo_reg, 
buf, len);
>  	else
> -		writesb(hdmi->base + hdmi->variant->ddc_fifo_reg, buf, 
len);
> +		iowrite8_rep(hdmi->base + hdmi->variant->ddc_fifo_reg, 
buf, len);
>  
>  	/* Clear FIFO request bit by forcing a write to that bit */
>  	regmap_field_force_write(hdmi->field_ddc_int_status,
> -- 
> 2.35.1
> 
> 


