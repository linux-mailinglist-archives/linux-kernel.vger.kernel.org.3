Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC91B5AB190
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 15:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbiIBNgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 09:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbiIBNgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:36:15 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE38686059
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:15:28 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j26so1253571wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 06:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=GsvQueQuCTUrKAHOrPXoQPRv2C01zYCjLMtVZuJnKZk=;
        b=PCk9KUCqb/mq9dLj7ZTKK3yD9RQLUT3BM/3S0+OKecwlv8d8Jx2Fh7MSUCA4LvN13S
         Lzu4UCX9NaAOnjnUrHpZqX79A+uhnVTA4cQiXQIcZrVpW2rx5yCrQdbksA2cIqfaJJMH
         q78+lkxPOYJUgwVWeinqlJgYeWunDBPSLbiciT0wMMKYuBbRP9/ebV+TgGIffXwRMp/k
         DZibjJHbKI81hF7STFHVjTxFwlOT0+edHalYGoTWz+Li++4qxMqXQ+50JlygJ+o5Uv4L
         /HHVQWOBwIOuGSu2KsFvOHMWSTqNrX48Qd/Gu7ymNflipM7tVLpW+dmY4TvRNyYLkJ43
         HAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GsvQueQuCTUrKAHOrPXoQPRv2C01zYCjLMtVZuJnKZk=;
        b=LGU1dVq5n0oekq8ywx6EKxWjmPMsJ63P01HI8JzIyxrkc1BM+olOqkA7ikfpi7HJoD
         ANvPxsA1ZEPjyCqvRd4XbRYDrZ4O+AOx11lVw+XnrbccmSh8J/0EQIjiHmbTQTgY16+q
         YcVY1Yy/n5fNU6twcuVHeSc28D+djxKaYFAIaGjoLZLTO1L4qX6149vThK2jm1Ll3W/l
         ZjoihEGY+J4oe2Xn7MtYT5enTM1tKb0rNeiZl2awSINzL/pW4nhRc1/xqGn+3RW/Cnae
         dqpljjf2gKImRuUwDgazeCRZRCeU28IixrpXIoapIe4G55zfu5qH6ZuQPcOU2ynLOWYz
         3Wbg==
X-Gm-Message-State: ACgBeo2AClmHLiaVmG+t1SBRvTlV3BrGkstBq4xpLDC7FjzXjFUKUoT5
        cB9luB8pLG3Vu6BFiFqB0y4e9g==
X-Google-Smtp-Source: AA6agR7ctgyVF+7Fp5xZ/ldtg0xNTR57lgO0mN4bcjBdcgcRGSGK8/aPmh8jDH664AV8gtaFa6q4Rg==
X-Received: by 2002:a05:600c:3ac9:b0:3a5:f114:1f8 with SMTP id d9-20020a05600c3ac900b003a5f11401f8mr2755993wms.204.1662124461131;
        Fri, 02 Sep 2022 06:14:21 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v14-20020a5d43ce000000b002253fd19a6asm1766253wrr.18.2022.09.02.06.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 06:14:20 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorande@qti.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ola Jeppsson <ola@snap.com>
Subject: [PATCH 01/14] misc: fastrpc: Fix use-after-free and race in fastrpc_map_find
Date:   Fri,  2 Sep 2022 16:13:31 +0300
Message-Id: <20220902131344.3029826-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902131344.3029826-1-abel.vesa@linaro.org>
References: <20220902131344.3029826-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there is a race window between the point when the mutex is
unlocked in fastrpc_map_lookup and the reference count increasing
(fastrpc_map_get) in fastrpc_map_find, which can also lead to
use-after-free.

So lets merge fastrpc_map_find into fastrpc_map_lookup which allows us
to both protect the maps list by also taking the &fl->lock spinlock and
the reference count, since the spinlock will be released only after.
Add take_ref argument to make this suitable for all callers.

Co-developed-by: Ola Jeppsson <ola@snap.com>
Signed-off-by: Ola Jeppsson <ola@snap.com>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/misc/fastrpc.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 93ebd174d848..0c816a11eeec 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -333,30 +333,31 @@ static void fastrpc_map_get(struct fastrpc_map *map)
 
 
 static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
-			    struct fastrpc_map **ppmap)
+			    struct fastrpc_map **ppmap, bool take_ref)
 {
+	struct fastrpc_session_ctx *sess = fl->sctx;
 	struct fastrpc_map *map = NULL;
+	int ret = -ENOENT;
 
-	mutex_lock(&fl->mutex);
+	spin_lock(&fl->lock);
 	list_for_each_entry(map, &fl->maps, node) {
-		if (map->fd == fd) {
-			*ppmap = map;
-			mutex_unlock(&fl->mutex);
-			return 0;
-		}
-	}
-	mutex_unlock(&fl->mutex);
-
-	return -ENOENT;
-}
+		if (map->fd != fd)
+			continue;
 
-static int fastrpc_map_find(struct fastrpc_user *fl, int fd,
-			    struct fastrpc_map **ppmap)
-{
-	int ret = fastrpc_map_lookup(fl, fd, ppmap);
+		if (take_ref) {
+			ret = fastrpc_map_get(map);
+			if (ret) {
+				dev_dbg(sess->dev, "%s: Failed to get map fd=%d ret=%d\n",
+					__func__, fd, ret);
+				break;
+			}
+		}
 
-	if (!ret)
-		fastrpc_map_get(*ppmap);
+		*ppmap = map;
+		ret = 0;
+		break;
+	}
+	spin_unlock(&fl->lock);
 
 	return ret;
 }
@@ -703,7 +704,7 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 	struct fastrpc_map *map = NULL;
 	int err = 0;
 
-	if (!fastrpc_map_find(fl, fd, ppmap))
+	if (!fastrpc_map_lookup(fl, fd, ppmap, true))
 		return 0;
 
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
@@ -1026,7 +1027,7 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 	for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
 		if (!fdlist[i])
 			break;
-		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap))
+		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap, false))
 			fastrpc_map_put(mmap);
 	}
 
-- 
2.34.1

