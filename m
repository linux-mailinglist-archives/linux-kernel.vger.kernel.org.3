Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449F34B0B01
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239894AbiBJKix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:38:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238091AbiBJKiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:38:51 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C36184
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:38:52 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id y18so1446765plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=81HmC6N36AUv3DS+gd84GgUi8DyL6BEk+8tTF7TOR9A=;
        b=klBWVq+VcpD1JwYhqrguON/wgfmRIoeAkScl31urYeBrPusoY43z4JDi85XGNQ/nAi
         HNpnPOrNRyM/rETRpPRxnLjtBJaagIoMTide+qa+TG0/D6Z3ZuGMpG7qqNbcmsdxzBPr
         Cs6gy3oP686jfbbE1xNzeAz2dv27FFO/FDo2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=81HmC6N36AUv3DS+gd84GgUi8DyL6BEk+8tTF7TOR9A=;
        b=IXzfm8kuH858VJQydSSQpWjxnH52a1OV8gkq5el3577bsJvTxfWDCUPYYOaGE5eWVM
         wh89Tx0YmCeOnA51nSU4Cd3EVw7X2LYxj0+XEyOQRkHdZxgchedvkrY4jP3HQcoUJ9JT
         8x4N4KaEkWlWTVHUbCl4z3l1EUU0WMr7fQIJmSvbZ1zFHFobLHRyl8rKnmInd8HFo0lH
         8gBKgcJHMt4HPwdqoxOJkjMGyZuoSOYAf88mM2le9cxkBGq6CdK7qRtzsRrkMu2bmo8Z
         9VqK6EZ7QHzAk+S6KWT4auOS01pZKj5cFXtnOnf7Rv+z4JF8bfnWB+VFbKD6BERJR1Wp
         Hf5Q==
X-Gm-Message-State: AOAM532slaoDG8vkNLRJMP+IxnpiEJsDoBqk/ce5aRPwHcJwKk/v3g0i
        LrdMubKgBDZzO/21E9Xo63FzPA==
X-Google-Smtp-Source: ABdhPJw6jVYVhpS6k6vjV9oF1u9DeF+GSlGVoL2BQ6ahDbbjqdm4ZYNVRMvJVMCT6iAALcoRHBUljQ==
X-Received: by 2002:a17:902:8f92:: with SMTP id z18mr7040383plo.42.1644489532286;
        Thu, 10 Feb 2022 02:38:52 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:b164:4f36:23f1:78c])
        by smtp.gmail.com with ESMTPSA id c4sm10941176pfl.131.2022.02.10.02.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 02:38:51 -0800 (PST)
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
Subject: [PATCH v2] drm/bridge: anx7625: Fix overflow issue on reading EDID
Date:   Thu, 10 Feb 2022 18:38:27 +0800
Message-Id: <20220210103827.402436-1-treapking@chromium.org>
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

Fixes: 8bdfc5dae4e3 ("drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP")
Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---

Changes in v2:
- add "Fixes" tag
- collect review tag

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

