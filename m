Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8280347FB4B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhL0JZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhL0JZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:25:29 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D229C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:25:29 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 196so13224833pfw.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=thF8QMh/Z+UXM664Ky8cQ4mDytOil9avA8P/Uj9RuDE=;
        b=ge4l4vgY7b/2iiTfqKZNts4FrBLc50KW2L+rUl2gqV3gDDriCB42uISLRCQt5qFEwF
         8bH1yEywWOxxslnMdhSbd4uuYkvMNqRKCaevnjH0LoC1pJDJPFvF/uDvk+Q43THtbvYf
         +0oDWDd+YyrhcQ2xehTrQN0hb+Yrgxp591pKRvP8FULq+GmZYary7XWvYpvT/u6vn9J0
         q9fuwOnXVobd70zaoQD8CjbjgX3bjuy3Yj+gIPO/OwaJjd7zDtffunfE2xfDtOgZlJgJ
         ZL7cVQ0+Gx4RbiKRKnGLXTfHVyDjtHmEKsMLV8XzLKUa6uQb2ZXJzwcrWy9pkjZIuS5x
         oJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=thF8QMh/Z+UXM664Ky8cQ4mDytOil9avA8P/Uj9RuDE=;
        b=eW77gCwkL2jl+qd1WplLOMRavQooZm4ZpYd5qH9D7FHt5jol47iEjUwOOZXuO8IsDl
         t0nhFWryPLbVOMEpxO5uGi8SPPAE7ypzf4I+enmBODDrnEvZrkIA47BCYTW0jWTcqCpi
         E294PV63hRzHVp87mmXtWHAOoFHbiIPJ5DrWoYogOtYgg5xYZA4ldwxqWVD73vB9uilQ
         ym0tJ8X6y4+aHMfXuT8HdBJFPowtxduiauqrM0KSSS90N3a9SHEyqdvSsGIF+PeU7Mgh
         h5te8Pv3TmUAkml72w8Zv8JmGqHtgQFfZPxAHtVk+meBOkQWE88qfiaOzYilJGg+C9CN
         aXTw==
X-Gm-Message-State: AOAM530uggY1L1gxNpNcnnizVntmFTXuUBOflJDzOkzbg1yEGCnk5kud
        fOKK9zZFKKa7mpLuUTxAHRg=
X-Google-Smtp-Source: ABdhPJwI1HoauXj+E2aeOuXDXBjj/BZXYOy71+hi4sM9eZ4FkcW7N9l1ePob84nwkbZK4FawxOto9w==
X-Received: by 2002:a63:1f5b:: with SMTP id q27mr14881459pgm.608.1640597128893;
        Mon, 27 Dec 2021 01:25:28 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id 12sm16178442pfm.84.2021.12.27.01.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 01:25:28 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maciej Purski <m.purski@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: Fix free wrong object in sii8620_init_rcp_input_dev
Date:   Mon, 27 Dec 2021 09:25:22 +0000
Message-Id: <20211227092522.21755-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rc_dev is allocated by rc_allocate_device(), and doesn't assigned to
ctx->rc_dev before calling  rc_free_device(ctx->rc_dev).
So it should call rc_free_device(rc_dev);

Fixes: e25f1f7 ("drm/bridge/sii8620: add remote control support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/bridge/sil-sii8620.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index 843265d7f1b1..ec7745c31da0 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -2120,7 +2120,7 @@ static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
 	if (ret) {
 		dev_err(ctx->dev, "Failed to register RC device\n");
 		ctx->error = ret;
-		rc_free_device(ctx->rc_dev);
+		rc_free_device(rc_dev);
 		return;
 	}
 	ctx->rc_dev = rc_dev;
-- 
2.17.1

