Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3C357493A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238335AbiGNJjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238127AbiGNJj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:39:29 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B3C286E8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:39:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so8048363pjl.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 02:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=035aCrOz5ERcq1QdmAwfHzCWjFJoscBLHwbpgcL7qwM=;
        b=IPcwiRAPfXZGdabealGssIj3UFwxYY+gjXA8gU2bN98caeRupARqxJi5HvEaCHj8LU
         l369ixh3UstTtFS1BnorG0XXEhuP5h0hAgJ+FtMmjNUfmrUgC24cb61vTCAsdX+wL7HZ
         5NBJwOaPmwCW3P9eKO3GGTpFex7BdN5odvivw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=035aCrOz5ERcq1QdmAwfHzCWjFJoscBLHwbpgcL7qwM=;
        b=bt5gsj876nLZi1kedK4JJmCYcA+INw4Zu5vgIIH9+uPmdnpGdZ+i3apBfmVC4nHLqA
         fosyTeXg3VVYy7ZYQcJGmF9ZbWQt+n2zjbNH9EPj2AJw5cJ6+WLpAGe8SaWge4hRZmsx
         hJG3s7KRiGguW9NwUJdQMyYrMTBXcXsvO4tMImDk4/JB2wyiyghpUT3o/zCpVOz0fYAC
         to1/H6ivjJtdH1ys3vvjJHJCXR3cT/SmtozcODA1aAztTHX2o5T6zX5iizi6v35mIV1z
         3vtYEMvoCUyOBq2/tXA+ODukFN/bPBY92h7pzUgFoXtgY+C7AwZa4PSIbU9Q/47UPUMd
         G0Fw==
X-Gm-Message-State: AJIora/7vnvQMKtI5JCPfgwlbyZ+J3pxiek7/A1yFxlABQyTVXSkiOYF
        wH0UGz+TA/joqg0iSFRvHkvYM0vmxBEKyQ==
X-Google-Smtp-Source: AGRyM1uHl6xzZtJP+2RbMoBawnwUDbMd+wrFhj4n0h0m6qDMV3KEhp79mOW1zYnnkrHA80MGqTCS2w==
X-Received: by 2002:a17:90b:1643:b0:1f0:2094:57db with SMTP id il3-20020a17090b164300b001f0209457dbmr8738186pjb.140.1657791568146;
        Thu, 14 Jul 2022 02:39:28 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:e954:82dc:af20:e6e1])
        by smtp.gmail.com with ESMTPSA id n19-20020a056a00213300b00528c34f514dsm1180743pfj.121.2022.07.14.02.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 02:39:27 -0700 (PDT)
From:   Pin-Yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Allen Chen <allen.chen@ite.com.tw>,
        Pin-Yen Lin <treapking@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/bridge: it6505: Power on downstream device in .atomic_enable
Date:   Thu, 14 Jul 2022 17:39:20 +0800
Message-Id: <20220714173715.v2.1.I85af54e9ceda74ec69f661852825845f983fc343@changeid>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Send DPCD DP_SET_POWER_D0 command to the monitor in .atomic_enable
callback. Without this command, some monitors won't show up again after
changing the resolution.

Fixes: 46ca7da7f1e8 ("drm/bridge: it6505: Send DPCD SET_POWER to downstream")

Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
---

Changes in v2:
- Update the typo in the summary (power on --> power off)
- Re-write the commit message to make it clearer.

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
2.37.0.144.g8ac04bfd2-goog

