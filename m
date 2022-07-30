Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A871158595F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiG3JNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiG3JNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:13:10 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F391570B
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 02:13:09 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id mf4so12185313ejc.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 02:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F8fhUxE3x4wOe3m4a14najZDDA734PpdZ0zvY9IBgdA=;
        b=ZG2IrV2r1EWLt75BM97iRoI2Fc0pagt70o4R2poxmBf1kaPFF05otKfuGf7gXtlNu+
         /dCPH7viH0STK8OcySYRw+QBBy73BSHjr+CT0al1b+vpb2imlIe74RmeRrf9pQqUJaH5
         TmBS8LD7rue5YdqAeAFvd+htM27uzgkRJKkN/kfIiTlXZVxmf1bjlsTP2BM0P0T1kNv7
         XoxF9QpD+8/TlHICB89Z2XN/1dNWdNao5r8EoIVdL+YOvRB+TDYnU99NpmticLyjn5B1
         8h1LYPxQE/lZczOWieZs/hZZCk2VgzErcnMC5xg6qLsBux25HfhSNtlgrJRdhFhQT/L2
         aydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F8fhUxE3x4wOe3m4a14najZDDA734PpdZ0zvY9IBgdA=;
        b=oCflHvz0DBF2t6DU6EGjxS37Ibik/VLjPVEIFTUgGcoq/6VR0pEmA1yEIWitsVWKR8
         maPtf2LodTmGdHxvWC/t3tinTl9F2D+Q0Lo4IR6QhhrDZyjSru0m0zRLkNnHKdLeSnXP
         9FvSjHWFTPPU7kDQSIo7BQgNbq583CNcRQnSPLsxGk7+wPYwkFSfPtXDno6BEJxroQlZ
         F8BlnoD5E9iejOeeW4E2jXRwTcmRTMZ0eY0gLVkloUCLSGbSm08AMYFkjxy9stlkwv8x
         psATVnokh3/eV+oDXCEmJ5qLN+qhHLpopcW/l+pA/RTurQIaCEKNAZww6Br+vCkE6JDY
         TwdA==
X-Gm-Message-State: AJIora824iiRskNLFYcso2fO2iFjDwiog/DnS2JYUyvrnumLvHzPHLn6
        QGFVmB1ejtVolUNvv00RRqQ=
X-Google-Smtp-Source: AGRyM1vnGZx3SWdOvFK05YcUTuAQpbJMQBq6meu894/eIUroxXOHiUFMsPL5aHg++vyEFuUAzaEVrw==
X-Received: by 2002:a17:907:948e:b0:72d:3fd2:5da0 with SMTP id dm14-20020a170907948e00b0072d3fd25da0mr5613928ejc.225.1659172387794;
        Sat, 30 Jul 2022 02:13:07 -0700 (PDT)
Received: from jernej-laptop.localnet (194-152-27-124.dynamic.telemach.net. [194.152.27.124])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090623ea00b0072b616ade26sm1344215ejg.216.2022.07.30.02.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 02:13:07 -0700 (PDT)
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
Subject: Re: [PATCH v1 25/35] drm/sun4i: tv: Remove unused mode_valid
Date:   Sat, 30 Jul 2022 11:13:05 +0200
Message-ID: <5587265.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20220728-rpi-analog-tv-properties-v1-25-3d53ae722097@cerno.tech>
References: <20220728-rpi-analog-tv-properties-v1-0-3d53ae722097@cerno.tech> <20220728-rpi-analog-tv-properties-v1-25-3d53ae722097@cerno.tech>
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

Dne petek, 29. julij 2022 ob 18:35:08 CEST je Maxime Ripard napisal(a):
> The mode_valid implementation is pretty much a nop, let's remove it.
> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c
> b/drivers/gpu/drm/sun4i/sun4i_tv.c index 94883abe0dfd..53152d77c392 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
> @@ -497,16 +497,8 @@ static int sun4i_tv_comp_get_modes(struct drm_connector
> *connector) return i;
>  }
> 
> -static int sun4i_tv_comp_mode_valid(struct drm_connector *connector,
> -				    struct drm_display_mode 
*mode)
> -{
> -	/* TODO */
> -	return MODE_OK;
> -}
> -
>  static const struct drm_connector_helper_funcs
> sun4i_tv_comp_connector_helper_funcs = { .get_modes	=
> sun4i_tv_comp_get_modes,
> -	.mode_valid	= sun4i_tv_comp_mode_valid,
>  };
> 
>  static void




