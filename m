Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDC94D92A3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 03:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344478AbiCOCdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 22:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237373AbiCOCdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 22:33:41 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08B647398
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 19:32:30 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id mr24-20020a17090b239800b001bf0a375440so1041163pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 19:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UisOO7Q5sWcTyT6YGXIaBwA+2hXKA5zA0oioUT8I7D0=;
        b=GTEc8J50ZYn6y/baRDpqB9hxBgnQuXZskdpa3JoDVSVvdYYM7wfVnFY6S8hnEPVohx
         joDYJjS8jnXWq6nqY6ttRVmX2LHgIYLaT0HVT6ZyLyovJgWdinXFX9gfM43cLZwU4vl+
         ePUXEltdKnI5iR8jDAR8LU32uFlP5/BDB/O+jyHrv/iFythb3WNV1aFD2r4YbSgeDsYi
         VdioSeQvK9Vw22hcNhyJGyNTzHRMsvgeAfgHRW2/xW+YGq9/j0F7ZGZ/74wGMX6y+7Te
         Equf0m6AuMHCLgK1Xtoutq4yc3JtaOLGRFvo1y69+8pST22viSiCmVy9nUzZUzmXomh6
         eI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UisOO7Q5sWcTyT6YGXIaBwA+2hXKA5zA0oioUT8I7D0=;
        b=v41K0Woml+ttGRxP42GMJjepWOY/Giwsq9/qpZJVN18Xnc5vxSv+FPYKEbbJ8+y8LU
         gwaBWaML0QtyBrRKSKxAFrjAQP4rltWydFFzRs1yUYO17xQVYSwaHIrTVceRphWir+Xn
         y27MKHghb0QkHl+1hRUrS5H99/pSexvxhrjNk8e/XgI8Y6zy6ky0GClVeukfuIoitSqG
         qtr9XQZnz9RdDTkVa1Bj9LgC1kBfGai4ybhE3vTLZfDLWatYolXXcZWHQOKDvKBCf8ln
         K4UwG/H3j+zn+qaCphMDUqBCFg4sVQBgJJ3IV1qcC233FtG+Bb8dmq943WIScRXM/tIm
         /SOQ==
X-Gm-Message-State: AOAM532OAaS1R6uXySXBWOAGjPUv5gQH2kQSkZRAxFmscZJyGcKeyzMv
        qViAYc9wZx6livd8ZxbjdIM=
X-Google-Smtp-Source: ABdhPJzUWiTgcfMjzsN+iQA9b8xgnqGDJdPduixz6F8CAvVouD8nSKSZmWCti0JMDhaZ5GQA5KNzvQ==
X-Received: by 2002:a17:90a:8595:b0:1bf:4592:a819 with SMTP id m21-20020a17090a859500b001bf4592a819mr2084621pjn.183.1647311550493;
        Mon, 14 Mar 2022 19:32:30 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id l188-20020a6225c5000000b004f715e38283sm21291197pfl.63.2022.03.14.19.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 19:32:30 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ASoC: ak4642: Use of_device_get_match_data()
Date:   Tue, 15 Mar 2022 02:32:26 +0000
Message-Id: <20220315023226.2118354-1-chi.minghao@zte.com.cn>
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Use of_device_get_match_data() to simplify the code.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 sound/soc/codecs/ak4613.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/ak4613.c b/sound/soc/codecs/ak4613.c
index 4d2e78101f28..e4c643724dd9 100644
--- a/sound/soc/codecs/ak4613.c
+++ b/sound/soc/codecs/ak4613.c
@@ -653,15 +653,10 @@ static int ak4613_i2c_probe(struct i2c_client *i2c,
 	struct ak4613_priv *priv;
 
 	regmap_cfg = NULL;
-	if (np) {
-		const struct of_device_id *of_id;
-
-		of_id = of_match_device(ak4613_of_match, dev);
-		if (of_id)
-			regmap_cfg = of_id->data;
-	} else {
+	if (np)
+		regmap_cfg = of_device_get_match_data(dev);
+	else
 		regmap_cfg = (const struct regmap_config *)id->driver_data;
-	}
 
 	if (!regmap_cfg)
 		return -EINVAL;
-- 
2.25.1

