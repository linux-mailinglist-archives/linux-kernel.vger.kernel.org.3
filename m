Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2647486A3E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 20:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243114AbiAFTAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 14:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243089AbiAFTAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 14:00:36 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6BBC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 11:00:35 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id r17so6698094wrc.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 11:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GApfuZwSa5gLOrIFUv10Q+jwtcI8XokWaaN8Migozt0=;
        b=dMDoD0wS6wkdT73t6n4lqSz7LXjMF7Q7BT7h93ZCspVO/J4lDUWaVkxIcFoC6OgoAi
         LigYS4Jq37nDgH+w6B2NbBsSIW/LRqSOgz3qzzuUNNFblYlo+kRARb4jMBBU6VsLoH7M
         Xrx0oX0t/8P4UoP8nvMb4Zk9NY0cTouVYAGe3BmCcHf2ybJ3mEjE7jYsIQSmsCGlz4b2
         8/RMbC9xojPbfPWnXb8ILLkhXAJcFy6Z2WmlrJRIlADOrDfEbjZvYaR/DKU+x3DdU6xO
         vmMPZiNxd82uy+v/u5C3BINmzXCV4HBEwmv5mIDEmzIajBbjxdo+2xXDkD84XKvr6f0T
         pBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GApfuZwSa5gLOrIFUv10Q+jwtcI8XokWaaN8Migozt0=;
        b=ISUHGhg1mWAWKP8s/TNaiZwiKGrdFw8w5laofBTNAaMo/FjGhGWW1iSpDywaNUW92I
         YcN+Ly0cjTSq5fH5TfjynAdKI5UUNGTHIbydn5+nUB5G7pNDxyBO4V0ObA/SinxC4fVa
         PdvBQfEsU/ueFixnAzGQ+x4N3SmO36o/OoE++Xu19OGFnUTAA8b+mHBjziUwxB0PvzhG
         cpdiKXhqWFqpHlV/o+PifP08PUgvCZRCaPbvLbsRJlnND1xs4dahFKxfVtWrfz4+q7Z/
         PMZYaXzXuCqQGenyZ/4d3XZ0Rii3PVEQ/BzzzgYzQfa044GDKrU4474sresSjGzAjGSm
         wrKQ==
X-Gm-Message-State: AOAM531ecJHScen9uVYCFYo+BX7tt9ZHxQMT3b4xt4xuA7/6osH6sy/a
        nHmtkekZtpA3hC9xLvhA+eo=
X-Google-Smtp-Source: ABdhPJzRBPgEFjde8rkHAuo7tRsgCjXw/CujtSuspjwJoOEksMbs2rdDHQQmiMDdOjSh4GHnkx1B0Q==
X-Received: by 2002:a5d:4a8e:: with SMTP id o14mr50283333wrq.441.1641495634341;
        Thu, 06 Jan 2022 11:00:34 -0800 (PST)
Received: from localhost.localdomain (37.212.broadband9.iol.cz. [90.176.212.37])
        by smtp.gmail.com with ESMTPSA id n41sm6835638wms.32.2022.01.06.11.00.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jan 2022 11:00:33 -0800 (PST)
From:   Jiri Vanek <jirivanek1@gmail.com>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Vinay Simha B N <simhavcs@gmail.com>,
        Jiri Vanek <jirivanek1@gmail.com>
Subject: [PATCH v2] drm/bridge/tc358775: Fix for dual-link LVDS
Date:   Thu,  6 Jan 2022 20:00:27 +0100
Message-Id: <20220106190027.1498-1-jirivanek1@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20211110220050.2854-1-jirivanek1@gmail.com>
References: <20211110220050.2854-1-jirivanek1@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed wrong register shift for single/dual link LVDS output.

Tested-by: Jiri Vanek <jirivanek1@gmail.com>
Signed-off-by: Jiri Vanek <jirivanek1@gmail.com>

---
v1:
* Initial version

v2:
* Tested-by tag added

---
 drivers/gpu/drm/bridge/tc358775.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 2272adcc5b4a..1d6ec1baeff2 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -241,7 +241,7 @@ static inline u32 TC358775_LVCFG_PCLKDIV(uint32_t val)
 }
 
 #define TC358775_LVCFG_LVDLINK__MASK                         0x00000002
-#define TC358775_LVCFG_LVDLINK__SHIFT                        0
+#define TC358775_LVCFG_LVDLINK__SHIFT                        1
 static inline u32 TC358775_LVCFG_LVDLINK(uint32_t val)
 {
 	return ((val) << TC358775_LVCFG_LVDLINK__SHIFT) &
-- 
2.30.2

