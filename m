Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718D64C64AD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 09:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiB1IPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 03:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbiB1IPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 03:15:32 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE9F52E73
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 00:14:35 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id w37so10738332pga.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 00:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=doltg0EIdSmNoZq27I75wxyAPlbzp0xcc8dv/Y7u+Cs=;
        b=YVxznTg/QjH9avE6lNR58bU4o+IWvD7DMsflx4uThJnOdGu3gJJifvXzI0o4OJTMKV
         +jX4LVGqldDimvl1C0XwItBA29LxmVHpQgMdnAZDuDMEut/03b8+Hz2rvfVAsp8oeUIU
         AbMR9Nm5ZzHZVjBuXHlajocZpFo79QwIRz9zg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=doltg0EIdSmNoZq27I75wxyAPlbzp0xcc8dv/Y7u+Cs=;
        b=xxGE+QjVBNwXKs3r2/aTfsgXYsGhhfSbls1h+1l0+zXAg6fhkD5l/FW4A0Mn34qLFS
         sAIo+HtKBJl5Pjyfu1VX9HJWKAg3kU3RhOO+u3XkCMg25FvRWoxMY/LA3JZu7sarsGAw
         V1BgrSDGdScdoNC5yv8d28fCXKFcbg0V1fxk5U1TmqKbQlrrRlLrp4fwpAiCA+BaxlWH
         1p2FnjcFBy6+4yQ5JDHxGV/9Az+yviPkttkMIAxFF9hHdaNAEnIrqcBb9757EJLDCFo3
         fnmAtImuD0WfbVxhDij7wXedZ5fxUeDEabMFKm5TKUWMZ23jC7BEpKcFQzNpmSPWjpGb
         lfQA==
X-Gm-Message-State: AOAM532fsdDnJYmjruxRrAc0cGrQg/uacReSLKitXE0JQRa19XCv3ktG
        NgkHBpmNoi1JfI2QzEbZN2Ktrw==
X-Google-Smtp-Source: ABdhPJyl4BNj7TAs4Wq0y8meXmnSMvgG6Exp0ChLB6bFKf5z2wkAWTaodGZsJTBYA6Oe1U9DGzHZJw==
X-Received: by 2002:a62:3383:0:b0:4f3:c157:8898 with SMTP id z125-20020a623383000000b004f3c1578898mr19008754pfz.14.1646036073887;
        Mon, 28 Feb 2022 00:14:33 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:e717:c093:114f:b510])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004f1111c66afsm12299576pfl.148.2022.02.28.00.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 00:14:33 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Allen Chen <allen.chen@ite.com.tw>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] drm/bridge: it6505: Fix the read buffer array bound
Date:   Mon, 28 Feb 2022 16:14:21 +0800
Message-Id: <20220228081421.1504213-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of read_buf is READ_BUFFER_SIZE (200), so we can't access it
with read_buf + PAGE_SIZE (4096). Extend the READ_BUFFER_SIZE to 400 and
set the end position to read_buf + READ_BUFFER_SIZE.

Fixes: b5c84a9edcd418 ("drm/bridge: add it6505 driver")
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index fb16a176822d81..f2f101220ade94 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -289,7 +289,7 @@
 #define WORD_LENGTH_20BIT 2
 #define WORD_LENGTH_24BIT 3
 #define DEBUGFS_DIR_NAME "it6505-debugfs"
-#define READ_BUFFER_SIZE 200
+#define READ_BUFFER_SIZE 400
 
 /* Vendor option */
 #define HDCP_DESIRED 1
@@ -3074,7 +3074,7 @@ static ssize_t receive_timing_debugfs_show(struct file *file, char __user *buf,
 	struct it6505 *it6505 = file->private_data;
 	struct drm_display_mode *vid = &it6505->video_info;
 	u8 read_buf[READ_BUFFER_SIZE];
-	u8 *str = read_buf, *end = read_buf + PAGE_SIZE;
+	u8 *str = read_buf, *end = read_buf + READ_BUFFER_SIZE;
 	ssize_t ret, count;
 
 	if (!it6505)
-- 
2.35.1.574.g5d30c73bfb-goog

