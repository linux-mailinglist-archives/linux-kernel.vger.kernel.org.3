Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F434A8FBE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354699AbiBCVXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiBCVXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:23:18 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED33C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 13:23:18 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s18so7511459wrv.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 13:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i1R30ilVEicJtysARGPLDhNbvvQjDKcL01YwzZ4J60k=;
        b=a/UOw38GEiIQi5NLt42s0d4GjG0JTuKhrmGsPTlRg/QiQNCuK3Dq9wPBYw5twksuGp
         1k+3zEdx/ZDx2L7B0XWralxWmoReZhSi+Qow1FOUoA/gcGSBoyFORWCWZigx+CA5IAbX
         T6E2lCZ+BZMJS4TcklFcqKLCSapejn6gjd/VXRvSVfP0pWtUTpdEVj8lAME1uH6C98cw
         6h0b1IdKcyF4gBIcqDOij1T/R/zgoPde6U2R06DrhehGTrMVfxcJq1Q6fyfLSO38qvPw
         CbgyPZpcqPH+CiLYS4RVeVUlFave21aVoqNRr347pNf2DnQM77+ZWVz2SpS0WUFbg+kS
         MLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i1R30ilVEicJtysARGPLDhNbvvQjDKcL01YwzZ4J60k=;
        b=oH9uldhVzolcFa4KqOMi6rGYmdwGeKMEWh7iVcBOlU2gZu3/Gq8KKLoBCZqSsYYFVQ
         FAgTAolupCRnOqtNId1q9of6fcqYp2ZgZq6B4C2KpWGtVFha5cJuESChU8aKXwCxkjaP
         vexVOpC/Ynewzc2CLNnmp5kBNz8PnF1EurjeTiD01BUa353srGZewPtPbyLHuBsl1xsD
         zWy+2s6Yrs/rpQ8a3JH51ofOMH1LL7Sy2g9pf/wVseQ+i4ktksU9lg3ZHL/id1HYs//o
         ghcQbNGXmylUV1Htat1NxsBNxVNblUan8AacIeu4WAl/WjjXQk3cCCWjgvaWRX1zPUqO
         pfWQ==
X-Gm-Message-State: AOAM533sNAixDMTNgpN5Nw/Yoa60TPr7hRel8My6hEouj468bgtvgRsl
        /D04FYBbtXDjUC6O9vPQZ1EuzF6ElSUppQ==
X-Google-Smtp-Source: ABdhPJzT/mYLDXsGbH6e4OfwlmlkdwTVUgmytYv/5rkjfh7w5UEwIJauCSDbN0R5cmi35LI/thqsgQ==
X-Received: by 2002:adf:d087:: with SMTP id y7mr30009202wrh.274.1643923397096;
        Thu, 03 Feb 2022 13:23:17 -0800 (PST)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id x7sm2652030wrt.77.2022.02.03.13.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 13:23:16 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     sakari.ailus@linux.intel.com, paul.kocialkowski@bootlin.com,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Subject: [PATCH] media: i2c: Fix pixel array positions in ov8865
Date:   Thu,  3 Feb 2022 21:23:03 +0000
Message-Id: <20220203212303.633399-1-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ov8865's datasheet gives the pixel array as 3296x2528, and the
active portion as the centre 3264x2448. This makes for a top offset
of 40 and a left offset of 16, not 32 and 80.

Fixes: acd25e220921 ("media: i2c: Add .get_selection() support to ov8865")

Reported-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
 drivers/media/i2c/ov8865.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov8865.c b/drivers/media/i2c/ov8865.c
index d9d016cfa9ac..53e21ae8e886 100644
--- a/drivers/media/i2c/ov8865.c
+++ b/drivers/media/i2c/ov8865.c
@@ -457,8 +457,8 @@
 
 #define OV8865_NATIVE_WIDTH			3296
 #define OV8865_NATIVE_HEIGHT			2528
-#define OV8865_ACTIVE_START_TOP			32
-#define OV8865_ACTIVE_START_LEFT		80
+#define OV8865_ACTIVE_START_TOP			40
+#define OV8865_ACTIVE_START_LEFT		16
 #define OV8865_ACTIVE_WIDTH			3264
 #define OV8865_ACTIVE_HEIGHT			2448
 
-- 
2.25.1

