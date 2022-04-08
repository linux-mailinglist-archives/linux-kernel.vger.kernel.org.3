Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6E74F9595
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiDHMZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235558AbiDHMY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:24:59 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F27265CA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 05:22:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m67-20020a1ca346000000b0038e6a1b218aso5441138wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 05:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=gtTftlQzlflLQzzKEoG76sKlqDpy0xKEo3XRwr3sgJs=;
        b=xSMyHrkkJ3LsZUuXmvCWNnhyZI4dboegG4Cpa1jwO4GPcTIIZBLT7kwA6lD/dX5gt8
         jOmwOYgbaZ0ETJmkPF6d3+dqg2PtJBSdsVoyI8k4DgT3uQ1ANxc2CE/Gex2hSzHN8ZDZ
         T3i3Azsp0P+26go+ZsKPlSVBGGxJ6VtQQ4jnlWyRcKTW4GhumBAGTzNxBiJFwSxeerjg
         fXGkphtKJ/E3F/I2hyjiqVTq4zquNHqh4tzE4tiFH/LZSyevhFG5m9481ouUzjTVsQpW
         TZsQsGuRCKm5llKzGaCcVzrLx7FfgmAmFWO0ovIh5hiBWWuZfy1Q5PvP/n0ZYzOvknpB
         9Fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=gtTftlQzlflLQzzKEoG76sKlqDpy0xKEo3XRwr3sgJs=;
        b=LsOpnpJ1XSXzUFpnbn8SuDoE9NpkiavglFb6/wEajHINxePSanoJ3Z9UzABlSJjmat
         RzJ9JCkEWANQrShSd/bDh+OO2qnhz9bHBMOhmfEOuSbzJmWughUkP7g+Jkkg0kdhTTGb
         Mr6w8zrZXl3V4jap/Vty5+ntRzU+deiSykA2EH9TklPh4c6Rw9yPMj0P+FukkOsdDCBH
         iesAl/CnuUnyT5cl8qDBSjlWNxG4lFsnN/frrl5EF5udTK+xf+zLhXb1/oToxb4Fl3Wu
         aMrnmqskjE72rIqbnMVe7zZ79DF9AQsuBrAk4eKwAWIHsST0tQhKFLe9MHGd/5n/yp2q
         a4yw==
X-Gm-Message-State: AOAM531gxrNxqpHJyklZQmvBVs4ufU3YHqXrgmii8sHBmTmFkBLUEmRD
        3hpug0kzZWLMUNcV8X/dS+DMVg==
X-Google-Smtp-Source: ABdhPJx2hFRVIqw4iw6u3Z4qCynzf2kAvxBtYcdMh9joKkhRISNecGlpu95SByRopHrlMAn/FRYAZg==
X-Received: by 2002:a05:600c:3b26:b0:38c:8358:4b84 with SMTP id m38-20020a05600c3b2600b0038c83584b84mr16879351wms.185.1649420574715;
        Fri, 08 Apr 2022 05:22:54 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:eacd:ce6:e294:acd1? ([2001:861:44c0:66c0:eacd:ce6:e294:acd1])
        by smtp.gmail.com with ESMTPSA id v8-20020a1cf708000000b0034d7b5f2da0sm10266598wmh.33.2022.04.08.05.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 05:22:54 -0700 (PDT)
Message-ID: <ddf6d1b2-9fa4-4384-6eda-7cd8b1119f89@baylibre.com>
Date:   Fri, 8 Apr 2022 14:22:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/5] drm: bridge: dw_hdmi: add reset function for PHY
 GEN1
Content-Language: en-US
To:     Sandor Yu <Sandor.yu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, andrzej.hajda@intel.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, hverkuil-cisco@xs4all.nl
Cc:     shengjiu.wang@nxp.com, cai.huoqing@linux.dev, maxime@cerno.tech,
        harry.wentland@amd.com
References: <cover.1649412256.git.Sandor.yu@nxp.com>
 <ab85938ee3f3b4a9482b4e2414165041d6a4c62e.1649412256.git.Sandor.yu@nxp.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <ab85938ee3f3b4a9482b4e2414165041d6a4c62e.1649412256.git.Sandor.yu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2022 12:32, Sandor Yu wrote:
> PHY reset register(MC_PHYRSTZ) active high reset control for PHY GEN2,
> and active low reset control for PHY GEN1.
> 
> Rename function dw_hdmi_phy_reset to dw_hdmi_phy_gen2_reset.
> Add dw_hdmi_phy_gen1_reset function for PHY GEN1.
> 
> Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 14 +++++++++++---
>   drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c    |  2 +-
>   include/drm/bridge/dw_hdmi.h              |  4 +++-
>   3 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index 5a7ec066e37a..13270d96e5be 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1369,13 +1369,21 @@ static void dw_hdmi_phy_sel_interface_control(struct dw_hdmi *hdmi, u8 enable)
>   			 HDMI_PHY_CONF0_SELDIPIF_MASK);
>   }
>   
> -void dw_hdmi_phy_reset(struct dw_hdmi *hdmi)
> +void dw_hdmi_phy_gen1_reset(struct dw_hdmi *hdmi)
> +{
> +	/* PHY reset. The reset signal is active low on Gen1 PHYs. */
> +	hdmi_writeb(hdmi, 0, HDMI_MC_PHYRSTZ);
> +	hdmi_writeb(hdmi, HDMI_MC_PHYRSTZ_PHYRSTZ, HDMI_MC_PHYRSTZ);
> +}
> +EXPORT_SYMBOL_GPL(dw_hdmi_phy_gen1_reset);
> +
> +void dw_hdmi_phy_gen2_reset(struct dw_hdmi *hdmi)
>   {
>   	/* PHY reset. The reset signal is active high on Gen2 PHYs. */
>   	hdmi_writeb(hdmi, HDMI_MC_PHYRSTZ_PHYRSTZ, HDMI_MC_PHYRSTZ);
>   	hdmi_writeb(hdmi, 0, HDMI_MC_PHYRSTZ);
>   }
> -EXPORT_SYMBOL_GPL(dw_hdmi_phy_reset);
> +EXPORT_SYMBOL_GPL(dw_hdmi_phy_gen2_reset);
>   
>   void dw_hdmi_phy_i2c_set_addr(struct dw_hdmi *hdmi, u8 address)
>   {
> @@ -1529,7 +1537,7 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi,
>   	if (phy->has_svsret)
>   		dw_hdmi_phy_enable_svsret(hdmi, 1);
>   
> -	dw_hdmi_phy_reset(hdmi);
> +	dw_hdmi_phy_gen2_reset(hdmi);
>   
>   	hdmi_writeb(hdmi, HDMI_MC_HEACPHY_RST_ASSERT, HDMI_MC_HEACPHY_RST);
>   
> diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> index 5e2b0175df36..2860e6bff8b7 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> @@ -135,7 +135,7 @@ static int sun8i_hdmi_phy_config_a83t(struct dw_hdmi *hdmi,
>   	dw_hdmi_phy_gen2_txpwron(hdmi, 0);
>   	dw_hdmi_phy_gen2_pddq(hdmi, 1);
>   
> -	dw_hdmi_phy_reset(hdmi);
> +	dw_hdmi_phy_gen2_reset(hdmi);
>   
>   	dw_hdmi_phy_gen2_pddq(hdmi, 0);
>   
> diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> index 2a1f85f9a8a3..70082f80a8c8 100644
> --- a/include/drm/bridge/dw_hdmi.h
> +++ b/include/drm/bridge/dw_hdmi.h
> @@ -187,9 +187,11 @@ void dw_hdmi_phy_i2c_set_addr(struct dw_hdmi *hdmi, u8 address);
>   void dw_hdmi_phy_i2c_write(struct dw_hdmi *hdmi, unsigned short data,
>   			   unsigned char addr);
>   
> +void dw_hdmi_phy_gen1_reset(struct dw_hdmi *hdmi);
> +
>   void dw_hdmi_phy_gen2_pddq(struct dw_hdmi *hdmi, u8 enable);
>   void dw_hdmi_phy_gen2_txpwron(struct dw_hdmi *hdmi, u8 enable);
> -void dw_hdmi_phy_reset(struct dw_hdmi *hdmi);
> +void dw_hdmi_phy_gen2_reset(struct dw_hdmi *hdmi);
>   
>   enum drm_connector_status dw_hdmi_phy_read_hpd(struct dw_hdmi *hdmi,
>   					       void *data);

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

If a sun4i drm maintainer can ack, then it would be all good to apply.

Neil
