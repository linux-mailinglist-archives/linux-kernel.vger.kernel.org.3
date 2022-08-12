Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A75159167C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 22:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiHLU6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 16:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiHLU6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 16:58:09 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6D0B24A2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 13:58:08 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4M4GGl43pczDqPf;
        Fri, 12 Aug 2022 20:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1660337888; bh=lqIb/39ravYbx7WCjgTnGhey78nkmC1/ONugMtjoV2A=;
        h=From:To:Cc:Subject:Date:From;
        b=JH4Vzc7nuj19eou1mabDepZQSeG0TMLH1J7AJvQ9WK9ubuLFgJx7dXAFUtChxqA87
         OhkdOl2vXRFefEhXbtd4rWoBtl0zzriPCouKxRw2ch0Exo5C3F2oxXiHWuW86VAe5Y
         +kSqCZCDHfa6yElyc1vy8p/wUxos/QvMsrAF/iQc=
X-Riseup-User-ID: B98CDF838B390E4E878A3EA4F8DA48AF89E37DB8D26B1A3DCA91AE6A05788F60
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4M4GGb0B9hz5vTk;
        Fri, 12 Aug 2022 20:57:58 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Emma Anholt <emma@anholt.net>,
        Maxime Ripard <mripard@kernel.org>,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/5] Drop of_gpio header
Date:   Fri, 12 Aug 2022 17:57:41 -0300
Message-Id: <20220812205746.609107-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The legacy GPIO header <linux/gpio.h> and the deprecated OF GPIO header
<linux/of_gpio.h> should not be used anymore due to the existance of the
new GPIO header <linux/gpio/consumer.h>. Currently, the DRM still holds
seven OF GPIO header includes. That said, this series drops all the
OF GPIO header includes from the DRM, replacing it, when proper, with
the OF header.

Best Regards,
- Maíra Canal

Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Robert Foss <robert.foss@linaro.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Sean Paul <sean@poorly.run>
Cc: Alain Volmat <alain.volmat@foss.st.com>
Cc: Emma Anholt <emma@anholt.net>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: linux-mediatek@lists.infradead.org

Maíra Canal (5):
  drm/bridge: anx7625: Drop of_gpio header
  drm/mediatek: Drop of_gpio header
  drm/msm: Drop of_gpio header
  drm/sti: Drop of_gpio header
  drm/vc4: Drop of_gpio header

 drivers/gpu/drm/bridge/analogix/anx7625.c | 1 -
 drivers/gpu/drm/mediatek/mtk_dpi.c        | 1 -
 drivers/gpu/drm/mediatek/mtk_hdmi.c       | 1 -
 drivers/gpu/drm/msm/dp/dp_parser.c        | 2 +-
 drivers/gpu/drm/msm/hdmi/hdmi.c           | 1 -
 drivers/gpu/drm/sti/sti_dvo.c             | 2 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c            | 1 -
 7 files changed, 2 insertions(+), 7 deletions(-)

-- 
2.37.1

