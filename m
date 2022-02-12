Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BC24B33A1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 08:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiBLHmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 02:42:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiBLHmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 02:42:50 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0756526AEA;
        Fri, 11 Feb 2022 23:42:46 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id y22so15185766eju.9;
        Fri, 11 Feb 2022 23:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EkWXkKewPoFhmQKCPIXY6OJ14gKmezWp3+CXE5li4HY=;
        b=J57KOpvuDcRiVi6fAKqtJNgiUyt+KnQ5OMPQqtLdEIlei46C6IQUi83n5m38nQc+Vi
         VpPe/5ClLJdFX0x6EZiNfd2W0a2vlvf26YHyNPcfHVH2CteBHl9BSkelXeH21NUZkmN/
         Ce3AtGY+y3wZxFztDmdLnSl/Ncvcm5z1M/6p8ijl5GE3G38CMRGCQJiW0NZQEzgUjbSM
         oQJmiwGBa/4mUdbhkz+nW8BOFyh+fUa91ww3RC56FgxcfZ7zJNhzWb/Rxaj1HoE9+66c
         NK/Fnu0JZuL5nBBNZ0Rfsg4DIQJOomjYjiIWW789YwUwoUZOHEpLCvztvdPbVuCq4lA1
         Gmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EkWXkKewPoFhmQKCPIXY6OJ14gKmezWp3+CXE5li4HY=;
        b=6agn9W2zGuoOm8Nv/RVRgYadh2zGCvkBEV+A+K9DrLx5t0CjoQO7ZwUwXK4EQ7M7Nk
         4QQF6uMzRz0jPYi9WO5M3KWvFnzIhULfih2o3cVBxju27mz1byKB6xhaUuaqdvXPnoEG
         +L2rpSAzD3L/XRBKcjrGxTwWD+Jd1FOMQYuGQAlS9nUospNnq0VbGxu88ocGWAXGwx8q
         xixsUNLevw44oTyqlOjHLPgasZretyH9zpVxq/9Nlfs1Odfjq8QFaLG0p6Oq1EDfYgXq
         TKEMaZ2fa7+c1HTdSvSaAI6WOdyfG6mljstAskHb4gDYutElKfwrwbA1aG1TuPUDVOdh
         NC4Q==
X-Gm-Message-State: AOAM532shI3VHg5yH0sXIhIJai99FamAzl+I2liVxbhETsSDR9K1W7fF
        lwCUFEJF/YTgdQedqMhEjhhv9+7Zmn17Zw==
X-Google-Smtp-Source: ABdhPJySJr/9z9/AK53BzSB0SjeMcNIW1fPYpoxDyi0pm3Rzd+rri0GsDsaXSbzRyZh/X9GaTr17RQ==
X-Received: by 2002:a17:907:94cb:: with SMTP id dn11mr3974252ejc.81.1644651765489;
        Fri, 11 Feb 2022 23:42:45 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id w20sm1383205edd.79.2022.02.11.23.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 23:42:45 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com
Cc:     mchehab@kernel.or, wens@csie.org, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] media: cedrus: H265: Fix neighbour info buffer size
Date:   Sat, 12 Feb 2022 08:42:41 +0100
Message-Id: <20220212074241.43184-1-jernej.skrabec@gmail.com>
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

Neighbour info buffer size needs to be 794 kiB in H6. This is actually
already indirectly mentioned in the comment, but smaller size is used
nevertheless.

Increase buffer size to cover H6 needs. Since increase is not that big
in absolute numbers, it doesn't make sense to complicate logic for older
generations.

Bug was discovered using iommu, which reported access error when trying
to play H265 video.

Fixes: 86caab29da78 ("media: cedrus: Add HEVC/H.265 decoding support")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus_h265.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index 8ab2d9c6f048..44f385be9f6c 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -23,7 +23,7 @@
  * Subsequent BSP implementations seem to double the neighbor info buffer size
  * for the H6 SoC, which may be related to 10 bit H265 support.
  */
-#define CEDRUS_H265_NEIGHBOR_INFO_BUF_SIZE	(397 * SZ_1K)
+#define CEDRUS_H265_NEIGHBOR_INFO_BUF_SIZE	(794 * SZ_1K)
 #define CEDRUS_H265_ENTRY_POINTS_BUF_SIZE	(4 * SZ_1K)
 #define CEDRUS_H265_MV_COL_BUF_UNIT_CTB_SIZE	160
 
-- 
2.35.1

