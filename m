Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F0F4DE908
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 16:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243465AbiCSPcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 11:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243461AbiCSPcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 11:32:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F88762B8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 08:30:49 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id o10so3407768ejd.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 08:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dc08fHOeIpp/zqKHKPZcsQKX+E5+zliKb0EU1qA1Tx0=;
        b=a0XVexLezO0KguYm2Gfx89Md+UTJ5XcGyrHziGo50UtYBe1RMkXoom7mQVaGQ4AnIh
         xmqbMIDW8dukxw9SqzZxiSLnGrHDBluesCZARoLd2EWtdgwfueJtF+hMz/K7topgPAaW
         y2ukizh4bt/CmR39I4daF0gw7R++8CZhrJaXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dc08fHOeIpp/zqKHKPZcsQKX+E5+zliKb0EU1qA1Tx0=;
        b=09cgtuZyAis50GkVS++MT+BFiX4vmFnxyDFbJoiJQ0natItmg9WaTIY9FOTvz4Qyez
         aNqGPsFDl8IFUvuT/zH8CXzQbFvH2QvEXuSvE1RJ62AqTl8zKAMjJXdQhih0DH9/+xcW
         1FKKeV5Yrl8zGSGH4VWrFzyaxI+RF6271AaxX4uxivphUoHGBDesSXVwg1/vA5FGGb/Z
         +iZEcQca7EHUprunrsSDGcw3gUPirBaqqLUMk8is2p/EA3f4wn7PQEnB1nBq7VdifAwT
         2X6gVO1BaKqoU7N3Bw9mYjBbWAHKqoqvblXk7gWpBlYUq8+vedzq4fsjOf3kIYUiHSwX
         3p0w==
X-Gm-Message-State: AOAM533eCtL1gO+uH+1gFRXosoC8t9OHRB6qEJFSRSJlqy6oT0v2IZ++
        rvlRl5YAgs12BR86SUmsflP16A==
X-Google-Smtp-Source: ABdhPJwOOO28ceZ/7wvRQA8Bm1LXeVE0UYFb7TsMzDUTb49VdJSJjlFg29DiZdhnqkwMa/NR6GasSQ==
X-Received: by 2002:a17:907:1690:b0:6db:325:3088 with SMTP id hc16-20020a170907169000b006db03253088mr13776392ejc.718.1647703847743;
        Sat, 19 Mar 2022 08:30:47 -0700 (PDT)
Received: from capella.. (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id f15-20020a50e08f000000b004134a121ed2sm5956000edl.82.2022.03.19.08.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 08:30:47 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     hans.verkuil@cisco.com,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] drm: bridge: adv7511: get edid in hpd_work to update CEC phys address
Date:   Sat, 19 Mar 2022 16:29:32 +0100
Message-Id: <20220319152932.995904-1-alvin@pqrs.dk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

The adv7511 driver is solely responsible for setting the physical
address of its CEC adapter. To do this, it must read the EDID. However,
EDID is only read when either the drm_bridge_funcs :: get_edid or
drm_connector_helper_funcs :: get_modes ops are called. Without loss of
generality, it cannot be assumed that these ops are called when a sink
gets attached. Therefore there exist scenarios in which the CEC physical
address will be invalid (f.f.f.f), rendering the CEC adapter inoperable.

Address this problem by always fetching the EDID in the HPD work when we
detect a connection. The CEC physical address is set in the process.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---

Hi, I'm sending this as an RFC patch because:

- The added prototype is a bit crude, but I want feedback on the idea
  first before moving around a bunch of functions to avoid said
  prototype
- I'm not sure if the rationale stated above is correct. I am not very
  familiar with the drm subsystem so perhaps there is something obvious
  that I am missing. At any rate, this solved the issue of an inoperable
  CEC adapter when the downstream MIPI-DSI was not used.

I'm also wondering if this is robust enough to work when a sink just
pulses HPD to signal that its EDID has changed. Currently the hotplug
notifier is only invoked when the connected state changes (e.g. from
disconnected to connected), and so I only check the EDID in such
scenarios too. But is that always the case? Might we get an HPD
interrupt and the connectivity state remains the same?

Thanks in advance for any feedback.

---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 005bf18682ff..fb4ca277e4be 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -424,6 +424,9 @@ static bool adv7511_hpd(struct adv7511 *adv7511)
 	return false;
 }
 
+static struct edid *adv7511_get_edid(struct adv7511 *adv7511,
+				     struct drm_connector *connector);
+
 static void adv7511_hpd_work(struct work_struct *work)
 {
 	struct adv7511 *adv7511 = container_of(work, struct adv7511, hpd_work);
@@ -457,6 +460,9 @@ static void adv7511_hpd_work(struct work_struct *work)
 		if (adv7511->connector.dev) {
 			if (status == connector_status_disconnected)
 				cec_phys_addr_invalidate(adv7511->cec_adap);
+			else
+				adv7511_get_edid(adv7511, &adv7511->connector);
+
 			drm_kms_helper_hotplug_event(adv7511->connector.dev);
 		} else {
 			drm_bridge_hpd_notify(&adv7511->bridge, status);
-- 
2.35.1

