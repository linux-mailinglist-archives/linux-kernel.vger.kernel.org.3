Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C6B4AE999
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbiBIFyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:54:53 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiBIFyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 00:54:12 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274CBC001F73
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 21:54:13 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id qe15so1219666pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 21:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TyQEiK/jIvd5OoMVeisTCeZTNY4WZ5OI9la4y5vybB4=;
        b=kIKnzrW3esyMqAnXxLx+P3P572h0h2/39Gk52zsDSvXPDw6nanCos/JLS4Go0v0iVZ
         YnzYFZDxWu0lZztIqBlXNL8orJ5l8yUEwAGcFm07wVNelFB1eE2PAO55vJ3GDEo9GnzI
         LMiXTlzeD8MuzzcDSMELZ/3VcsRSGz3o/8zdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TyQEiK/jIvd5OoMVeisTCeZTNY4WZ5OI9la4y5vybB4=;
        b=vL63h9rirxDufjuHR3pO0uF/EDxDdwyahAuyfpiY4nXUIUUNb11yih45fnVL5eFwsZ
         gFK0HCQPjJFyhSpVOFtaLT1+fKyljuHAdDBURh04IIr+a2yWopaGNhnSOPZ3dOGAjv+k
         OgfAJ+wqc1Jpw1crrLWmiTBgfZOfXPDnHaiKusocjdsqp0BX5RBYbAi2lEdGCN1tehGm
         OUGRsW0YsgR2PGO0IektpN8Iq+qJpu6hk1r0FGX58FYb2UCL7vGHeEeYOoGB/WVhrQOL
         f94T+EtA0o8v9WrMm26oZ8t3Mz+EADGQKrnL8YxfnThgz9aQtXCbrmxrCXW3Dsi+ARJx
         Kvhw==
X-Gm-Message-State: AOAM533oK8R2MdP0PBgTk68n+z2I6cVqpyjDzllUQwP4adS8UuHoE+rt
        5lEfl8xij56jz4mc6qymDyZgnL+eEMq/or8a
X-Google-Smtp-Source: ABdhPJzO1OwnN24Pt7Ry9JWcmRAqqmF8SQtbycKRuOJ8qavPimTxdapkJj1wzR2cTz5upESGCzY7Dg==
X-Received: by 2002:a17:902:74c6:: with SMTP id f6mr913673plt.30.1644386052685;
        Tue, 08 Feb 2022 21:54:12 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:f66e:fb24:b0e7:d6ba])
        by smtp.gmail.com with ESMTPSA id l22sm18416304pfc.191.2022.02.08.21.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 21:54:12 -0800 (PST)
From:   Pin-Yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Pin-Yen Lin <treapking@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: anx7625: Fix overflow issue on reading EDID
Date:   Wed,  9 Feb 2022 13:53:27 +0800
Message-Id: <20220209055327.2472561-1-treapking@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The length of EDID block can be longer than 256 bytes, so we should use
`int` instead of `u8` for the `edid_pos` variable.

Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
---

 drivers/gpu/drm/bridge/analogix/anx7625.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 2346dbcc505f..e596cacce9e3 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -846,7 +846,8 @@ static int segments_edid_read(struct anx7625_data *ctx,
 static int sp_tx_edid_read(struct anx7625_data *ctx,
 			   u8 *pedid_blocks_buf)
 {
-	u8 offset, edid_pos;
+	u8 offset;
+	int edid_pos;
 	int count, blocks_num;
 	u8 pblock_buf[MAX_DPCD_BUFFER_SIZE];
 	u8 i, j;
-- 
2.35.0.263.gb82422642f-goog

