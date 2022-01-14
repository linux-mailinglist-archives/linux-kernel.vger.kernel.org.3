Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BFF48E44F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 07:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239385AbiANGlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 01:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbiANGlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 01:41:12 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54239C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 22:41:12 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id a18so1239295ilq.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 22:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NBbp5E1JmkcFNQqkFa6J2rIzcIhIU713VnGqiU+cJwU=;
        b=kcCBDlhpfZ51Gk+7ATdD2Wj6Si5ielRmWhElK8o8weZ/GtFLsJkx1JXGsBBLmBtj8l
         8XGrDC7U6VfQLckPzqPAA80eMThA1YQFl1hVCEsIjg96yhBq8MS9x/whN97YfRlNc38y
         vNsA41hFMm9Jqu4b4e8PWF3T9DhSg9r3ovSZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NBbp5E1JmkcFNQqkFa6J2rIzcIhIU713VnGqiU+cJwU=;
        b=Tg47rrFysLqtyEv+1C8d64ANr8JHCaiRE1JObsL/1WFpa3gJo6FqlGKgQPrMX6g+Wo
         OXCe0DFcBQxrOYGrf7K7XuNVQeAKGcFfDC4lqivhAVKfFm5Y2UPEREqygx/D0WxdcCYS
         +/ds7+7x4ujTD4f7L5Q+9PsvsGX6i9CVmasbj75cNTZWws4t3xVeOs/kIBUkLC68I8KZ
         H2WhrfqIXgMFPvQ7EU4k9bOFQ2lQEdtdN01sxGSQvQuZ4FlwHXFTfOWF8/yolBZPy+wy
         OqCu0xGqdYWAcoEWZQlZL2Rpcq0IypXpAZp1rmHOIMTAFspoeWkBcmSAiEEAWvhdvXyE
         bfag==
X-Gm-Message-State: AOAM530EkzjtkwMQHMQpctb3uck+tU5/LsuDGmLqYfzDTRjAX2JTjaY1
        cEaollbtYJ6y2Xf2bQdnEBXorQ==
X-Google-Smtp-Source: ABdhPJy+XPW6NhU5hhsaMSGMqhh4ww3gLJxhJwOwVy9kTNEvfWnZGUUeMB3uX/26KDaNqR3lfHhGHg==
X-Received: by 2002:a05:6e02:1c88:: with SMTP id w8mr4224902ill.95.1642142471225;
        Thu, 13 Jan 2022 22:41:11 -0800 (PST)
Received: from ddavenport4.bld.corp.google.com ([2620:15c:183:200:666f:a9f8:5c99:aa9e])
        by smtp.gmail.com with ESMTPSA id r10sm3667497ila.32.2022.01.13.22.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 22:41:10 -0800 (PST)
From:   Drew Davenport <ddavenport@chromium.org>
To:     ple@baylibre.com, narmstrong@baylibre.com
Cc:     a.hajda@samsung.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Drew Davenport <ddavenport@chromium.org>
Subject: [PATCH] drm: bridge: it66121: Remove redundant check
Date:   Thu, 13 Jan 2022 23:40:12 -0700
Message-Id: <20220114064012.1670612-1-ddavenport@chromium.org>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ctx->next_bridge is checked for NULL twice in a row. The second
conditional is redundant, so remove it.

Signed-off-by: Drew Davenport <ddavenport@chromium.org>
---
 drivers/gpu/drm/bridge/ite-it66121.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index 06b59b422c69..69288cf894b9 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -936,9 +936,6 @@ static int it66121_probe(struct i2c_client *client,
 		return -EPROBE_DEFER;
 	}
 
-	if (!ctx->next_bridge)
-		return -EPROBE_DEFER;
-
 	i2c_set_clientdata(client, ctx);
 	mutex_init(&ctx->lock);
 
-- 
2.34.1.703.g22d0c6ccf7-goog

