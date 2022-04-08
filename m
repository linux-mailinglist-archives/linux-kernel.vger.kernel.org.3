Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0155E4F9286
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbiDHKGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbiDHKG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:06:27 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118C3ABF54
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:04:12 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id t9so3077687qvd.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 03:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uDYIyqRKa4ljv3bdWbjMFdUVSWTyxOVGEtnHDdVjPis=;
        b=Kv7OjmJfTmHInHTCBgArEwZ05WO0BHqMZbTJ16WdCcgLTs8sNa71jRfD3FNs5gf84f
         IjU9LT7x3tsnc1sRz9WpGb7WrZtGHXEePmkxNnbK/zAIohoeTWZVN0dBH5zohot6CCde
         jTy3asZu1tIavz9LbzJxMjfB1gGqYoU9TDaKWFtSHD+Ox/sM6iL0cGU6aDHVcTGFKTr4
         /gciXK589BI6L2cajYsDEHSBhsiGf1tIqGVkoJRRxxnrnTP+QTYK+zm4jN0ASnocq9kP
         62V/7didh05neKxyyfxiFiWTVcOVqTrYvzw+huWvWGa/MQTETHxAJ0xCc+dVRhOrp7C1
         xBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uDYIyqRKa4ljv3bdWbjMFdUVSWTyxOVGEtnHDdVjPis=;
        b=KGSYPLiHgGVQGyMhv73gAPfWnL26IJyMFatRy2KY94JrI5ZLfCOZ1aYxCmYkTeNqCx
         kAqdKrpt7bspgynLK+iGirTbCSaAfNL9eIMIcWxFGk1q8+FhHgWWzV1eCYWF1PsQSHz3
         yIDcCgqUTP4dSdjZ0cbFAlTAFHHhAewer/Tt3huPU+2Er9N+PwRJKSw77Gtu7zdivn9f
         2yXLuzq/Mi6gIZAwaNi9sJa9g4t3qRCvdsTeYrEXu0qiRwGHx9tB+2vbzcrV9zUdQLul
         unXBpfY4svewIKO0EvdVw+Yl4uyv/JyKqRJgJerzoNV1CqbCqy/j9Nao+AmVinaC6u6i
         HH1A==
X-Gm-Message-State: AOAM531nNnHZ9GK+AZee0cKcjZwEgjQ5YZb6jw97rPB5ZyhoRTshRA3u
        7yQk80QJPJQalJ/TTJHD+gg=
X-Google-Smtp-Source: ABdhPJypq+E+nDV6hH6cRkMj7BSxYRwSwDfj38mgPVU5agSVzunZiQfgbqQYq/YmTbKwuKiQD3NkAg==
X-Received: by 2002:a05:6214:d41:b0:442:19b7:62e6 with SMTP id 1-20020a0562140d4100b0044219b762e6mr14990676qvr.17.1649412250156;
        Fri, 08 Apr 2022 03:04:10 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d3-20020a05622a15c300b002eb9af4c945sm19621632qty.3.2022.04.08.03.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 03:04:09 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        xji@analogixsemi.com, hsinyi@chromium.org, sam@ravnborg.org,
        tzungbi@google.com, pihsun@chromium.org, maxime@cerno.tech,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/bridge: anx7625: remove unnecessary flush_workqueue()
Date:   Fri,  8 Apr 2022 10:04:00 +0000
Message-Id: <20220408100401.2495529-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

All work currently pending will be done by calling destroy_workqueue,
so there is unnecessary to flush it explicitly.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 6516f9570b86..65632f584179 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2744,7 +2744,6 @@ static int anx7625_i2c_remove(struct i2c_client *client)
 
 	if (platform->hdcp_workqueue) {
 		cancel_delayed_work(&platform->hdcp_work);
-		flush_workqueue(platform->hdcp_workqueue);
 		destroy_workqueue(platform->hdcp_workqueue);
 	}
 
-- 
2.25.1

