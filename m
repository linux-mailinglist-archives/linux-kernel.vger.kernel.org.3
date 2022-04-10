Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3CF84FAD26
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbiDJKQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiDJKQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:16:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B96673DD
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 03:14:20 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id m30so18962642wrb.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 03:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pAKQLRfHBIi8gVpWsIm4XJUTgKXNjZKuay5CjFRlndQ=;
        b=VCf5YefLkMAEwD1FEbA3M/9+95V60y1Xqx6EBj4uQJjMbDDAd+MDQOfLPgvqHeoKhJ
         i40q+rYXlnsSQYx3F5AhrNnG2AsjHJ5VeHLrYys9LfEX7WymHQknubY1Jm8Et/vNOTzl
         BuIUagPUdVCsov9XGd6zT8NJgyZEcCON0Ez+v7PEvcGT0r3E9tCebYAEWz55IHR2IP/L
         hCzFHLZOKqmVpUcyZ+iGyIL7JN3oSkfp/MpVQ7Zgua+LE7kZ35agu10UX4wZ8S6tPPWt
         gUaaWeuXspLmXjM22aITSbX7FU1gzbcwN4/EN/zwNOABUJjXaX++a3pXYOkT5UukwN4r
         bF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pAKQLRfHBIi8gVpWsIm4XJUTgKXNjZKuay5CjFRlndQ=;
        b=tVMWtWvlotq+GAMGZuY6Ag5qmcCQU2NtVUJWTbVqkgqX4+UgcwRYEIbfIBtDKekYFY
         Pw5Vus4+5n7c1fXtA4LGiXaRxLJs0OKu/t0SfynK4Up54M5XIp6wJ4IZ/0hH/xwU9uw3
         HS8YZlOo4Q15GakzKJ/1Kr9OM/YyqcuR3hqyxMmTlCKv9hkBuIRWNipAXv0Y1e4ajV9d
         fpYI3IDfW4qMIks5rS+lPdRD2UzK9ToCqYW9TpxyOD4NMKIxGqMGZQTOjKSOgD/pI1DU
         eJH45ZEC9ISMUjvIY77tPWzO+ixbCQMou2k47VtaJSjZ93irfIUnM7Lj6o5RIMZi7ZnT
         qWIA==
X-Gm-Message-State: AOAM530T45Z/zydozyazoxvxJqwnpUoU3q9usxPjyap5xVJtsSiyN7r8
        cRv4AVd+7qUhaRQD8h7EXJM=
X-Google-Smtp-Source: ABdhPJxletA1b6QlOrf9vLg3Ffaz3R05kgZSgfITv/n69SnaIoSn9nssUQfbsGVcrhE4jzWuW9059g==
X-Received: by 2002:a5d:47a8:0:b0:204:72:7051 with SMTP id 8-20020a5d47a8000000b0020400727051mr21325747wrb.451.1649585658641;
        Sun, 10 Apr 2022 03:14:18 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id n37-20020a05600c3ba500b0038cc9d6ff5bsm14748150wms.4.2022.04.10.03.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 03:14:18 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Sandor Yu <Sandor.yu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, andrzej.hajda@intel.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, hverkuil-cisco@xs4all.nl,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     shengjiu.wang@nxp.com, cai.huoqing@linux.dev, maxime@cerno.tech,
        harry.wentland@amd.com
Subject: Re: [PATCH v2 4/5] drm: bridge: dw_hdmi: add reset function for PHY GEN1
Date:   Sun, 10 Apr 2022 12:14:17 +0200
Message-ID: <8917523.CDJkKcVGEf@jernej-laptop>
In-Reply-To: <ddf6d1b2-9fa4-4384-6eda-7cd8b1119f89@baylibre.com>
References: <cover.1649412256.git.Sandor.yu@nxp.com> <ab85938ee3f3b4a9482b4e2414165041d6a4c62e.1649412256.git.Sandor.yu@nxp.com> <ddf6d1b2-9fa4-4384-6eda-7cd8b1119f89@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 08. april 2022 ob 14:22:52 CEST je Neil Armstrong napisal(a):
> On 08/04/2022 12:32, Sandor Yu wrote:
> > PHY reset register(MC_PHYRSTZ) active high reset control for PHY GEN2,
> > and active low reset control for PHY GEN1.
> > 
> > Rename function dw_hdmi_phy_reset to dw_hdmi_phy_gen2_reset.
> > Add dw_hdmi_phy_gen1_reset function for PHY GEN1.
> > 
> > Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
> > ---
> > 
> >   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 14 +++++++++++---
> >   drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c    |  2 +-
> >   include/drm/bridge/dw_hdmi.h              |  4 +++-
> >   3 files changed, 15 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> > 5a7ec066e37a..13270d96e5be 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -1369,13 +1369,21 @@ static void
> > dw_hdmi_phy_sel_interface_control(struct dw_hdmi *hdmi, u8 enable)> 
> >   			 HDMI_PHY_CONF0_SELDIPIF_MASK);
> >   
> >   }
> > 
> > -void dw_hdmi_phy_reset(struct dw_hdmi *hdmi)
> > +void dw_hdmi_phy_gen1_reset(struct dw_hdmi *hdmi)
> > +{
> > +	/* PHY reset. The reset signal is active low on Gen1 PHYs. */
> > +	hdmi_writeb(hdmi, 0, HDMI_MC_PHYRSTZ);
> > +	hdmi_writeb(hdmi, HDMI_MC_PHYRSTZ_PHYRSTZ, HDMI_MC_PHYRSTZ);
> > +}
> > +EXPORT_SYMBOL_GPL(dw_hdmi_phy_gen1_reset);
> > +
> > +void dw_hdmi_phy_gen2_reset(struct dw_hdmi *hdmi)
> > 
> >   {
> >   
> >   	/* PHY reset. The reset signal is active high on Gen2 PHYs. */
> >   	hdmi_writeb(hdmi, HDMI_MC_PHYRSTZ_PHYRSTZ, HDMI_MC_PHYRSTZ);
> >   	hdmi_writeb(hdmi, 0, HDMI_MC_PHYRSTZ);
> >   
> >   }
> > 
> > -EXPORT_SYMBOL_GPL(dw_hdmi_phy_reset);
> > +EXPORT_SYMBOL_GPL(dw_hdmi_phy_gen2_reset);
> > 
> >   void dw_hdmi_phy_i2c_set_addr(struct dw_hdmi *hdmi, u8 address)
> >   {
> > 
> > @@ -1529,7 +1537,7 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi,
> > 
> >   	if (phy->has_svsret)
> >   	
> >   		dw_hdmi_phy_enable_svsret(hdmi, 1);
> > 
> > -	dw_hdmi_phy_reset(hdmi);
> > +	dw_hdmi_phy_gen2_reset(hdmi);
> > 
> >   	hdmi_writeb(hdmi, HDMI_MC_HEACPHY_RST_ASSERT, 
HDMI_MC_HEACPHY_RST);
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> > b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c index 5e2b0175df36..2860e6bff8b7
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> > @@ -135,7 +135,7 @@ static int sun8i_hdmi_phy_config_a83t(struct dw_hdmi
> > *hdmi,> 
> >   	dw_hdmi_phy_gen2_txpwron(hdmi, 0);
> >   	dw_hdmi_phy_gen2_pddq(hdmi, 1);
> > 
> > -	dw_hdmi_phy_reset(hdmi);
> > +	dw_hdmi_phy_gen2_reset(hdmi);
> > 
> >   	dw_hdmi_phy_gen2_pddq(hdmi, 0);
> > 
> > diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> > index 2a1f85f9a8a3..70082f80a8c8 100644
> > --- a/include/drm/bridge/dw_hdmi.h
> > +++ b/include/drm/bridge/dw_hdmi.h
> > @@ -187,9 +187,11 @@ void dw_hdmi_phy_i2c_set_addr(struct dw_hdmi *hdmi,
> > u8 address);> 
> >   void dw_hdmi_phy_i2c_write(struct dw_hdmi *hdmi, unsigned short data,
> >   
> >   			   unsigned char addr);
> > 
> > +void dw_hdmi_phy_gen1_reset(struct dw_hdmi *hdmi);
> > +
> > 
> >   void dw_hdmi_phy_gen2_pddq(struct dw_hdmi *hdmi, u8 enable);
> >   void dw_hdmi_phy_gen2_txpwron(struct dw_hdmi *hdmi, u8 enable);
> > 
> > -void dw_hdmi_phy_reset(struct dw_hdmi *hdmi);
> > +void dw_hdmi_phy_gen2_reset(struct dw_hdmi *hdmi);
> > 
> >   enum drm_connector_status dw_hdmi_phy_read_hpd(struct dw_hdmi *hdmi,
> >   
> >   					       void *data);
> 
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> 
> If a sun4i drm maintainer can ack, then it would be all good to apply.
> 
> Neil




