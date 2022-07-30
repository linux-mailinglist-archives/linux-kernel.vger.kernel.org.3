Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88F458596A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbiG3JQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiG3JQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:16:27 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA4A3F33E
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 02:16:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i13so8272100edj.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 02:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ikzYAjzqfaF+a4GkobxDatu0soZrTXVKMloqR9b6tU=;
        b=ODVq1f1/LK9nGxTfjwXO4ssEzwk81G34edDpsOIHpHTuvnSmZevpPG/84UYDkXBv8U
         CLgbMgUZM8dS1bS1AyLYl9eEjgXp3UpwCxBos92t40mUCmBL3QUrK5RfTtU0vwM/AzDe
         gmM98LP8su2vSEdNxfnnqf5nFNmj1zOGilWCgwL/9zXisxjzzlMldbxrv42qo7OKN4nN
         27y9j7VR8dYZ9tQS/gG1Z4hMSlz1BdNwI7wotbL/IkpHLM3nNYdF72nwzeGiuQZSM/0c
         J5AvjWooDFx+mBcmo+4oeRfdmWr2nWcGaUn/UAI5dUv0Ma/OVWJCC+ckBWsKfufFtS+7
         xQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ikzYAjzqfaF+a4GkobxDatu0soZrTXVKMloqR9b6tU=;
        b=7e6xWZ+0uktcZvJ8rDokJtJP772gt6rYm1oGKGTyr0g7NV2EUgp5vQ/4ovIPBx5iJj
         eyZpBU8ICr5TEQSMvThnioGEM/kTQfkfz6j3w8Nev7LAzMeo8YmOAT1dkECIGjZaaHCy
         7WFAY2NFSvm8grrZeWMeUF5Y28ISTbnaz/YdWYyqL65d35PRa+UNjcvyX9VNmm9ZSDhM
         pOvhoUAk6tgQh8sIaTz1H6Oexp2nTqGjDh7Dl0VuroHcGTAF9JpnuEpAdO8aKcdxtSaA
         yICeORgaB8Pve3p36tY6bXol0Tnuzs2LQxNu7szHxokHzq61qWfGIvJaAhmnw1rOJd5v
         uuVQ==
X-Gm-Message-State: AJIora83+wTBzoOHBz06dnyUrTmS2F7SfzsqjfoCMxsxZw390b2ji6Zr
        f/BcYzvQ5iGK4Gaz/gbyV5I=
X-Google-Smtp-Source: AGRyM1vwibvRhtEPZaZcnZE0I3sovCWh/d2MGizGNAj8LqkgAI7GjPSEvzFNhCBH1UWn2jszQI2xYA==
X-Received: by 2002:a05:6402:40d2:b0:43c:5a4d:c3b4 with SMTP id z18-20020a05640240d200b0043c5a4dc3b4mr7329019edb.95.1659172585551;
        Sat, 30 Jul 2022 02:16:25 -0700 (PDT)
Received: from jernej-laptop.localnet (194-152-27-124.dynamic.telemach.net. [194.152.27.124])
        by smtp.gmail.com with ESMTPSA id p24-20020a17090653d800b0073045f26d41sm676395ejo.72.2022.07.30.02.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 02:16:25 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Noralf =?ISO-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <mripard@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        Dom Cobley <dom@raspberrypi.com>
Subject: Re: [PATCH v1 31/35] drm/sun4i: tv: Add missing reset assertion
Date:   Sat, 30 Jul 2022 11:16:23 +0200
Message-ID: <1822091.tdWV9SEqCh@jernej-laptop>
In-Reply-To: <20220728-rpi-analog-tv-properties-v1-31-3d53ae722097@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech> <20220728-rpi-analog-tv-properties-v1-31-3d53ae722097@cerno.tech>
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

Dne petek, 29. julij 2022 ob 18:35:14 CEST je Maxime Ripard napisal(a):
> The reset line is deasserted at bind, and asserted if we ever encounter an
> error there. However, it's never deasserted in unbind which will lead to a

s/deasserted/asserted/

Once fixed:
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> resource unbalance.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c
> b/drivers/gpu/drm/sun4i/sun4i_tv.c index ad6a3739bfa9..74ff5ad6a8b9 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
> @@ -605,6 +605,7 @@ static void sun4i_tv_unbind(struct device *dev, struct
> device *master, drm_connector_cleanup(&tv->connector);
>  	drm_encoder_cleanup(&tv->encoder);
>  	clk_disable_unprepare(tv->clk);
> +	reset_control_assert(tv->reset);
>  }
> 
>  static const struct component_ops sun4i_tv_ops = {




