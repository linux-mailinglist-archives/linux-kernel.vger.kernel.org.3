Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18CF4C77CC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240561AbiB1ScG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240518AbiB1Sbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:31:53 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A59EF0A5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:14:54 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d3so16828708wrf.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 10:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=laSnQJpbry/7HDfeFASKUPW4HYc9KBwUxVn9S4td0qc=;
        b=c0WRI4mazSMxTdg2exnk+Q3pEXI74oiHYivOcAxyKozC7Y4/wrofRWWnCvtaPZhGxR
         IhujeWQfFo00DEXYokFGtCEV1Nn/dkAzptGSD5IEwXwkYfvy1qfoB3e94L+04fLU12+3
         pcpQ7uF/jzshj84kJryjM8O1p3msTMRKDo8oU509HnrI67clNXOfUUBLIc4+upY8iJaR
         lijHIn+cImvx6w0OH/8X7tgsuHtgADaACEwj7KzCQe1+ShF5wzUkQf1V0VpMSUNCbwen
         iJRaVoijltE0Hg7tQ28uZOYG9wwLUfhgUw87xdeEs/IH4v0p+SOczJhRr0p1Uu2joV3V
         27AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=laSnQJpbry/7HDfeFASKUPW4HYc9KBwUxVn9S4td0qc=;
        b=dH09xsLsraabQLlVRTgsHiqR1IEke8MUpBlI0KcbjwBFNYwtZm1gJHNGTko+TNGFsq
         4Y/uyjJ1iPDQcKyFeViC5DjGQE7gqc4tOzE8WL9iBTSg5ehsGFRfABkun/mwLHwB7Omx
         UAK0zywc9EVyqJJVZSa7zlPObb2ykDYJVZ7UD3Vhztr9bR3j/mT464IAvcG6BOTAx/1x
         EJw0x3e6HUuC1Y/OYEIRsg/jJVaLOaZBauOkF3VKP53b13/IAFRuyOOgYI3m7/wNx5jK
         BFt1CYXqqJ/08kYQferYI5q5MdpGzIweQW2WQlCfmRAheyGynVlINJQsKTgWkn5wyG5p
         NJ8A==
X-Gm-Message-State: AOAM5332u0i+jhFxAhlt7Mo57DerfDT9EHQhe2qGSnYuteOP8qo7Iksf
        UncR+ecAGXnQZlhCPgsRy2o=
X-Google-Smtp-Source: ABdhPJyhltbPdhysi/wISTmoSAx5kNxmU7sMGyLPJmQFUN5FgbPAW2+eU+jUkbBOfunmlYPPW6hcbw==
X-Received: by 2002:a5d:648f:0:b0:1e9:5445:4b13 with SMTP id o15-20020a5d648f000000b001e954454b13mr16540343wri.127.1646072082307;
        Mon, 28 Feb 2022 10:14:42 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id z2-20020a056000110200b001e7140ddb44sm10780677wrw.49.2022.02.28.10.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 10:14:41 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     samuel@sholland.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] drm/sun4i: mixer: Fix P010 and P210 format numbers
Date:   Mon, 28 Feb 2022 19:14:36 +0100
Message-Id: <20220228181436.1424550-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.35.1
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

It turns out that DE3 manual has inverted YUV and YVU format numbers for
P010 and P210. Invert them.

This was tested by playing video decoded to P010 and additionally
confirmed by looking at BSP driver source.

Fixes: 169ca4b38932 ("drm/sun4i: Add separate DE3 VI layer formats")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h b/drivers/gpu/drm/sun4i/sun8i_mixer.h
index 145833a9d82d..5b3fbee18671 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -111,10 +111,10 @@
 /* format 13 is semi-planar YUV411 VUVU */
 #define SUN8I_MIXER_FBFMT_YUV411	14
 /* format 15 doesn't exist */
-/* format 16 is P010 YVU */
-#define SUN8I_MIXER_FBFMT_P010_YUV	17
-/* format 18 is P210 YVU */
-#define SUN8I_MIXER_FBFMT_P210_YUV	19
+#define SUN8I_MIXER_FBFMT_P010_YUV	16
+/* format 17 is P010 YVU */
+#define SUN8I_MIXER_FBFMT_P210_YUV	18
+/* format 19 is P210 YVU */
 /* format 20 is packed YVU444 10-bit */
 /* format 21 is packed YUV444 10-bit */
 
-- 
2.35.1

