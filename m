Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAF750D431
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 20:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbiDXSiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 14:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiDXSiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 14:38:20 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8FFDFA5;
        Sun, 24 Apr 2022 11:35:15 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d5so2748723wrb.6;
        Sun, 24 Apr 2022 11:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=349XFvM6t5JIYAzx/9jOMxcyDaGjEC8LJK6aTpUuIMg=;
        b=RximP2STPGTwfaqjRxZ9EaaaNjMB9VPGv+TMWWc1/rmkTluj14SIJeUnLigW7BRhQr
         rQ14jBCh4dcxCWQ6LqpUPREv+cZcMEaAXPK/hUnSQsZc80brfS7dEmf3YifOui/TYODB
         g3Hp0CvlGf8WOeRe74ibnhSu3ltQ/0c3Wg0/hbHCpRX/4rDdnef3b585uAUWHRatJGN1
         aGnQaOJb6XxO+nhaKYETvz3XXDtWmzu/vLfeXFI2IzhiPKLEYmiF88e+UQAKqpfNQzjT
         iFWKUcRFQDyjOLxJUo8HOz1XDUQxohHfqWj9KxVDr1CXx+JkFKtIXIZehGa9r/w3DtBk
         N4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=349XFvM6t5JIYAzx/9jOMxcyDaGjEC8LJK6aTpUuIMg=;
        b=WZqpldrelKiqdcKkaIx3AhDjbBGxCkQ9bD6ZIt2PibrnYaAZ3GPBoI7N4l9EnT1zI/
         l9JWC8lUHsFIyHOi4x1Coq4Ya9fbeq9fJrFZOJPqLsIHTkb+tLDex1yifW6E/jUbyBuU
         g5eLEVBUphFaKx8LCiBZ9BqkDnyyZPgtKyJQjgO66SmPwOKt8JlTJLFIaaHfJr2ey38Y
         KeYWo1ekPGMd1Gc0M7HxHLG0GBQDcJRfLZXx4d1G0685dJFtSq0HPnO7xrYzL+wZTWRW
         2Yc80Vpy7VzmqyOe3uXwdxVbxSiwq2OJA2tLUUO65SFYt/cZY+ej07vPJeUTKbT5by2q
         po7Q==
X-Gm-Message-State: AOAM5334u/awFpKQTsxbj+c3pYY1eaFHsPD6LmBrzzrYoD5KbgamtZkb
        9mghT1wL9Pfim0nHsqJGhXItrgR6mNh2Ig==
X-Google-Smtp-Source: ABdhPJxhKw8Ct/ffWL61Xq54wzGLON3haioc9TF0zqvEjFjtlU0qST5fxv3vVDHYSfiWPgNc6TwUCA==
X-Received: by 2002:a05:6000:1789:b0:20a:9f94:1620 with SMTP id e9-20020a056000178900b0020a9f941620mr11858147wrg.640.1650825314073;
        Sun, 24 Apr 2022 11:35:14 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d2-20020a056000186200b0020a7be3f1d2sm8442792wri.53.2022.04.24.11.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 11:35:13 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Melissa Wen <mwen@igalia.com>,
        "Juan A . Suarez Romero" <jasuarez@igalia.com>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/v3d: Fix null pointer dereference of pointer perfmon
Date:   Sun, 24 Apr 2022 19:35:12 +0100
Message-Id: <20220424183512.1365683-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the unlikely event that pointer perfmon is null the WARN_ON return path
occurs after the pointer has already been deferenced. Fix this by only
dereferencing perfmon after it has been null checked.

Fixes: 26a4dc29b74a ("drm/v3d: Expose performance counters to userspace")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/v3d/v3d_perfmon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
index 0288ef063513..f6a88abccc7d 100644
--- a/drivers/gpu/drm/v3d/v3d_perfmon.c
+++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
@@ -25,11 +25,12 @@ void v3d_perfmon_start(struct v3d_dev *v3d, struct v3d_perfmon *perfmon)
 {
 	unsigned int i;
 	u32 mask;
-	u8 ncounters = perfmon->ncounters;
+	u8 ncounters;
 
 	if (WARN_ON_ONCE(!perfmon || v3d->active_perfmon))
 		return;
 
+	ncounters = perfmon->ncounters;
 	mask = GENMASK(ncounters - 1, 0);
 
 	for (i = 0; i < ncounters; i++) {
-- 
2.35.1

