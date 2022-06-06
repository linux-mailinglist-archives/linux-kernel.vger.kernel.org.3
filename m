Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AE853E354
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiFFHY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 03:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiFFHYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 03:24:25 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31B31A800
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 00:24:24 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q12-20020a17090a304c00b001e2d4fb0eb4so17133017pjl.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 00:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pMfut4LPsHaQl9oSY0zIbRD7TwaINdF2fCPCCoRTmzk=;
        b=Jl/v7UQ2V39aHQrh/Am7iP+T7NGe3QacYFlH0Ig4qdL5AiB+Dp+T229S4wFwZMPQ6a
         xzAAgpFGOeVLZ775zebxoG+K4mBQu7CS7y83DrBE9t+waNPQ60EwDUxoWJ83nlU6/5t+
         T3zL8AGrm6DrgAEMGw4ekxZLj1CTAdOkoGi6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pMfut4LPsHaQl9oSY0zIbRD7TwaINdF2fCPCCoRTmzk=;
        b=WlzusR873e+D3yMtE89vwTj09ov4NSS1OpNfvTjKqXv2X+Zd/PLp7ajuhLln8hKk35
         m6bD/ZX3Cm5vUPZj31VGk7w0yD/ViPNQL21RyuixDibuhG4uPvFtd2rCXZnKBM5X9bUI
         saAiB+20oDTBl6siA0KdQJnjxk99o9B3Jmj1Pz+g1DjQiZDNmvoyLGz8ufss+SIh5cAY
         golcQw3nUSMz+HBV/RgFVJcQ2O/ChyElaaJeS6kNwEfCaVFM5aewoENE6A1Z0hMoD0oP
         mw1DWkCp4kiNeN8iUS23PUnp4j3AHLXAs0fwHpPPQzTxThcfPqBDe2X3E2RvoCob+/0N
         SMmA==
X-Gm-Message-State: AOAM531WtiTS2sAtzH949k6c5PWZzotwwpK5Fy57aw8CZZfrmBARvahO
        D3A/9wZ1D+LYzSrBI6gSrv8JvQ==
X-Google-Smtp-Source: ABdhPJwIbAPZl7VVoUAdeTLq7nntvE3YRj01MWcFW6M6bKPiVfbIr2+NrNIRF094+iw89O8FMIWWZg==
X-Received: by 2002:a17:902:7202:b0:167:6548:3f3e with SMTP id ba2-20020a170902720200b0016765483f3emr10255212plb.98.1654500264178;
        Mon, 06 Jun 2022 00:24:24 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:e921:a124:f7a6:a292])
        by smtp.gmail.com with ESMTPSA id o20-20020a635d54000000b003fae8a7e3e5sm9802731pgm.91.2022.06.06.00.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 00:24:23 -0700 (PDT)
From:   Pin-Yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Allen Chen <allen.chen@ite.com.tw>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Pin-Yen Lin <treapking@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: it6505: Power off downstream device in .atomic_enable
Date:   Mon,  6 Jun 2022 15:24:17 +0800
Message-Id: <20220606072417.328354-1-treapking@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Power off the downstream device in .atomic_enable callback, so the
external display shows up again after changing resolution.

Fixes: 46ca7da7f1e8 ("drm/bridge: it6505: Send DPCD SET_POWER to downstream")

Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
---

 drivers/gpu/drm/bridge/ite-it6505.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 4b673c4792d7..e5626035f311 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -2945,6 +2945,9 @@ static void it6505_bridge_atomic_enable(struct drm_bridge *bridge,
 	if (ret)
 		dev_err(dev, "Failed to setup AVI infoframe: %d", ret);
 
+	it6505_drm_dp_link_set_power(&it6505->aux, &it6505->link,
+				     DP_SET_POWER_D0);
+
 	it6505_update_video_parameter(it6505, mode);
 
 	ret = it6505_send_video_infoframe(it6505, &frame);
-- 
2.36.1.255.ge46751e96f-goog

