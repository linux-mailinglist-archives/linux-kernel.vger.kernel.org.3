Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51615B2E1D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 07:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiIIFbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 01:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiIIFbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 01:31:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9219811FC84
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 22:31:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id m1so877639edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 22:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=rFLYto3K2CmPKXSaAwZZF63wiwFYIhCIDikeGhcUnes=;
        b=Vh+mhSWgZgTLphVA7O4Bl/hkzzn+QFBX+c6TpP67Jvhxve+3ZvMEsnRGarb9hn4QnI
         gR3sKN1N+9CcKQsENky2g3dZmQPaNajPmTLnUmxo0DQMMv7EGIxLlymkU33pn+UlsXBI
         eneOP25O/x24rccf9CwVkHaTE/axO56ileDjfRlC1dk5sU4OWUipKuxvbg2vSLEwjm6K
         JM7CIiZNbqusM3B6IZZF0njS6sndC+VpI4F23c6BvXP/w7/ymQOtnfLn7Cz9UOylkpLp
         5uFuS3PppUMN3Bf8pC72ptvsULZOPHRtkQWiaoeJnwxTG0f5wGTA9fS4Bpwg9Yhjt/8b
         7DJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=rFLYto3K2CmPKXSaAwZZF63wiwFYIhCIDikeGhcUnes=;
        b=DRTUhuk7d92l+vGFxCroXORgU6rPjKRSOsz4WN+hNG0lqsR/DGm2h+K9UgN5bc50lA
         1h8gZKqYnU3NTVX8kX19vVRJnAtwbfC/VDV5WnjzEpM4EABizJokbB7DsmdDjYPuOo/9
         8tAN5QpAj7Habl7kD85HEB3aYQCNz3YvNFeLhAcXezTH9sPQdlcF9uLG8MKvBYT60q/B
         +xyT3EpbSii7Y7uztxY3r1hApD/i50onetPLlTlFMi+T33kg3lrLP0yX5w7IVdGmpDqE
         x9cTzimLM/yUFzFWxcZMXHF4uKTnk26x8GUMEF2mWU5mVEKvup2UVmuq9kMKLvG+pb9j
         v0ag==
X-Gm-Message-State: ACgBeo0L+8XjKbHw9jiA00WkXdUi2/rsQcZm2LRZF+S2QBa0zfATIaX8
        LgwEGcFK5HF3EmSLR209h7c=
X-Google-Smtp-Source: AA6agR5iOqgAL3CEJpA6vw7nmX1vYQnQX4bL/IqLhmfPnASR2l8FZA7WUpKLDWc48uWUwD9jd0kWdg==
X-Received: by 2002:a05:6402:35c5:b0:450:4b7d:9c49 with SMTP id z5-20020a05640235c500b004504b7d9c49mr5636435edc.149.1662701468058;
        Thu, 08 Sep 2022 22:31:08 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-83.ip.prioritytelecom.net. [217.105.46.83])
        by smtp.gmail.com with ESMTPSA id d16-20020a50fb10000000b0044ee91129f9sm369370edq.70.2022.09.08.22.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 22:31:07 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     namcaov@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH] staging: vt6655: fix potential memory conruption bug
Date:   Fri,  9 Sep 2022 07:30:39 +0200
Message-Id: <20220909053038.33188-1-namcaov@gmail.com>
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

A line of code is attempting to set the entire struct vnt_rdes0 to
zero by treating it as unsigned int. However, this only works if
sizeof(unsigned int) is equal to sizeof(struct vnt_rdes0) (4 bytes),
which is not guaranteed. This may cause memory conruption if
sizeof(unsigned int) is 8 bytes for example. Fix the problem by using
memset instead.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/vt6655/device_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 8e2a976aaaad..a38657769c20 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -867,7 +867,7 @@ static bool device_alloc_rx_buf(struct vnt_private *priv,
 		return false;
 	}
 
-	*((unsigned int *)&rd->rd0) = 0; /* FIX cast */
+	memset((void *)&rd->rd0, 0, sizeof(rd->rd0));
 
 	rd->rd0.res_count = cpu_to_le16(priv->rx_buf_sz);
 	rd->rd0.owner = OWNED_BY_NIC;
-- 
2.25.1

