Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6804854FF05
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244943AbiFQUqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 16:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiFQUqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 16:46:50 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54D458E5F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:46:49 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id w21so5128835pfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GXaclX1FL0h8CGb7nidVOvl5KYslHnP1qP5vHuFEg/o=;
        b=lSFDDXp8fJxd3k1/NPPifUGgBLPdaE22CTJKPLAyp43SGjKFomXAGiePTZ42BlIrJh
         odqD9O7PRMXQHJrgctB/Y5S4MWjuJgaJD8WmZ8sebu3eFFWTXjdDxTbzEMVwKQUMkU4q
         U6exfnONG79nydNKJedyEQ72Xcs+9MEgrbF4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GXaclX1FL0h8CGb7nidVOvl5KYslHnP1qP5vHuFEg/o=;
        b=W68mlgHoQC7o+PLg5JEPyHLfjcZROayf51Y/BK559YCOzgxfzoWCo22jkzd0WSa49d
         wDUfslaqg9DqheM61LMBrja//8Zuin8+x2mCKwAIqyu9zD9RgJZAropmWDvIZcGd5jHg
         8pFvLBmC9uX1/FlBDCDOnTDSf8GH3ceDP+9ch4JWa66uHnd2ZSaC3yGBVYhcvtVxvV4J
         BpvfI+luUTCp5tSAQ/YS6mJPmW4FVdwRpFTggjpNVHymk9L0ILIy4RJX3d5L5QrlFHsI
         UPjrAVJW4a0uyoQU34jso60wa6at0wqzYgHSfT0VWo//4cx1Hz2epiOxpNobPmREka0i
         7FXw==
X-Gm-Message-State: AJIora/34uNJnEjCOeqqDsSGa6wlMWul/+5Gx895cE0nwY40ldOIc/KF
        WfeDpJlOJ5FMarwrr0GzSvROsQ==
X-Google-Smtp-Source: AGRyM1tK3U/ZG9n4Mvxa/4Mm4J4wxTavnLkXJYks8NkYt9StAA0o/gzzGm6jYf7ZHj2JUirJCeCBHg==
X-Received: by 2002:a05:6a00:b8c:b0:51c:2d3d:4595 with SMTP id g12-20020a056a000b8c00b0051c2d3d4595mr11829256pfj.80.1655498809321;
        Fri, 17 Jun 2022 13:46:49 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:6844:cedc:a28c:44b2])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090a428700b001e2f383110bsm5904549pjg.11.2022.06.17.13.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 13:46:48 -0700 (PDT)
Date:   Fri, 17 Jun 2022 13:46:46 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Judy Hsiao <judyhsiao@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Chen-Yu Tsai <wenst@chromium.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] ASoC: rockchip: i2s: switch BCLK to GPIO
Message-ID: <YqzoNqd3Mpv3r2tS@google.com>
References: <20220616155836.3401420-1-judyhsiao@chromium.org>
 <20220617044251.4029697-1-judyhsiao@chromium.org>
 <20220617044251.4029697-2-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617044251.4029697-2-judyhsiao@chromium.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 17, 2022 at 04:42:49AM +0000, Judy Hsiao wrote:
> We discovered that the state of BCLK on, LRCLK off and SD_MODE on
> may cause the speaker melting issue. Removing LRCLK while BCLK
> is present can cause unexpected output behavior including a large
> DC output voltage as described in the Max98357a datasheet.
> 
> In order to:
>   1. prevent BCLK from turning on by other component.
>   2. keep BCLK and LRCLK being present at the same time
> 
> This patch switches BCLK to GPIO func before LRCLK output, and
> configures BCLK func back during LRCLK is output.
> 
> Without this fix, BCLK is turned on 11 ms earlier than LRCK by the
> da7219.
> With this fix, BCLK is turned on only 0.4 ms earlier than LRCK by
> the rockchip codec.
> 
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
> ---
>  sound/soc/rockchip/rockchip_i2s.c | 167 ++++++++++++++++++++++--------
>  1 file changed, 121 insertions(+), 46 deletions(-)
> 
> diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
> index 47a3971a9ce1..5e3cb06377a1 100644
> --- a/sound/soc/rockchip/rockchip_i2s.c
> +++ b/sound/soc/rockchip/rockchip_i2s.c

> @@ -92,39 +122,46 @@ static inline struct rk_i2s_dev *to_info(struct snd_soc_dai *dai)
>  	return snd_soc_dai_get_drvdata(dai);
>  }
>  
> -static void rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
> +static int rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
>  {
>  	unsigned int val = 0;
>  	int retry = 10;
> -
> +	int ret = 0;
> +
>  	spin_lock(&i2s->lock);
>  	if (on) {
> -		regmap_update_bits(i2s->regmap, I2S_DMACR,
> -				   I2S_DMACR_TDE_ENABLE, I2S_DMACR_TDE_ENABLE);
> -
> -		regmap_update_bits(i2s->regmap, I2S_XFER,
> -				   I2S_XFER_TXS_START | I2S_XFER_RXS_START,
> -				   I2S_XFER_TXS_START | I2S_XFER_RXS_START);
> -
> +		ret = regmap_update_bits(i2s->regmap, I2S_DMACR,
> +			I2S_DMACR_TDE_ENABLE, I2S_DMACR_TDE_ENABLE);
> +		if (ret < 0)
> +			goto end;
> +		ret = regmap_update_bits(i2s->regmap, I2S_XFER,
> +			I2S_XFER_TXS_START | I2S_XFER_RXS_START,
> +			I2S_XFER_TXS_START | I2S_XFER_RXS_START);

This still isn't how I'd expect the indentation to look, but I think I
will stop complaining about whitespace. Maybe you can either use
'clang-format' (sparingly), or else see what Mark thinks.

> +		if (ret < 0)
> +			goto end;
>  		i2s->tx_start = true;
>  	} else {
>  		i2s->tx_start = false;
>  
...

>  static void rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)

I didn't think I needed to call this out, because you already got build
bots complaining about this, but...
...did you even compile-test this? You should be making this function
return 'int', not 'void', because you're adding return values below.

>  {
>  	unsigned int val = 0;
>  	int retry = 10;
> +	int ret = 0;
>  
...
> +end:
>  	spin_unlock(&i2s->lock);
> +	if (ret < 0)
> +		dev_err(i2s->dev, "lrclk update failed\n");
> +
> +	return ret;

^^ here.

>  }
>  
>  static int rockchip_i2s_set_fmt(struct snd_soc_dai *cpu_dai,

Aside from those, I think this looks OK to the best of my
(not-very-familiar with sounds/soc/) ability:

Reviewed-by: Brian Norris <briannorris@chromium.org>
