Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8C14F6B5A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 22:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbiDFUZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 16:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbiDFUVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:21:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C973F8B2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 10:22:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r13so5708731ejd.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 10:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dNWDQ+SBeedDH3/uGrxlIj4RJhbApNvdMlPMyXTlGHg=;
        b=JUeZRMgVMrv8s/512RhsUdmWSugjm2gqZ+/GcQ8VMTZMTPAtIBcYOnHkoNxAPrngnk
         fLSSUpldGFWpovIlXY7nfIQTbYpRmiv8QC0UqqT7Kd01C2JfH0F6ZlEbRiBbLWk09K21
         3gkcYq6n/NBmZr+I0dSNqrNNd1FKVrDARugerNuyyDK3DxV0iCdaCi0RmnkS3I4Ij1ov
         BXabaQFYpbZCiuTPSaiqNMfbSLGQ2NbCCWnfOe49mLdFd49D4vMeBltb0nhJ3IeJaBrU
         DBUMFeK0816mEg1aUntfdkjM3A9+Kk4B1ysz5+n84pfuZDqYwlnavUPe3S8QK54SzwMk
         wgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dNWDQ+SBeedDH3/uGrxlIj4RJhbApNvdMlPMyXTlGHg=;
        b=pghMu7NP1C46NC5UTm4V48XwgBW+JLEQzvUWT7vwnFuWwvDmEyjWLYkz5RaU0exIV+
         WwnGRwmRd+/g4jAneXM0Qlw/CfILVcU+eFV1/LTKtL8fp7xu2U3uMw8CxsDrI3WXNccU
         DIj3BxMWPX1SSEHY4dD0QGXZmUahxGdv8uzfGwlMzQC5Pxd28u6cZcCN7Wo5tk5bB/Ay
         wLO4nA1tdZuchq2M2B6Qq4V1+tM3s6gaDoS1151u/41KzrmF+lX6BGP4p7iWeU0hdsaU
         7SkNlhmnSVLKfuFkLY5/J6YbYyBAIVLMk9CMOmsI19KB67Y2GfyMW/xRonJXyvF7/ie5
         KEUQ==
X-Gm-Message-State: AOAM531PxKDWeS3G7mlW1GXgEj/0KaqxpCB/BLUyYK60rYH0xq63rqyf
        5BVzG0dgM5tylcKTsL/5bnI=
X-Google-Smtp-Source: ABdhPJzNy7M9OZCFmM+qTuEWZIRwC6GxeKgxZQr0qIK3EkVZLFnCHkHBagTMSj4B69FNafpb7Fa6PQ==
X-Received: by 2002:a17:907:728e:b0:6e7:edf7:f0a4 with SMTP id dt14-20020a170907728e00b006e7edf7f0a4mr9489345ejc.497.1649265758418;
        Wed, 06 Apr 2022 10:22:38 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id da19-20020a056402177300b00413583e0996sm7912730edb.14.2022.04.06.10.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 10:22:38 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 4/5] staging: r8188eu: use round_up() instead of _RND128()
Date:   Wed,  6 Apr 2022 19:22:18 +0200
Message-Id: <20220406172219.15565-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406172219.15565-1-straube.linux@gmail.com>
References: <20220406172219.15565-1-straube.linux@gmail.com>
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

Use in-kernel round_up() instead of custom _RND128().

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2: no changes

 drivers/staging/r8188eu/hal/usb_ops_linux.c     | 2 +-
 drivers/staging/r8188eu/include/osdep_service.h | 8 --------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 6a65dcf57112..d5e674542a78 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -287,7 +287,7 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
 
 		recvframe_put(precvframe, skb_len);
 
-		pkt_offset = (u16)_RND128(pkt_offset);
+		pkt_offset = (u16)round_up(pkt_offset, 128);
 
 		if (pattrib->pkt_rpt_type == NORMAL_RX) { /* Normal rx packet */
 			if (pattrib->physt)
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index ff44c4a37b9d..f6c55f6c9e1a 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -96,14 +96,6 @@ static inline void flush_signals_thread(void)
 
 #define _RND(sz, r) ((((sz)+((r)-1))/(r))*(r))
 
-static inline u32 _RND128(u32 sz)
-{
-	u32	val;
-
-	val = ((sz >> 7) + ((sz & 127) ? 1: 0)) << 7;
-	return val;
-}
-
 static inline u32 _RND256(u32 sz)
 {
 	u32	val;
-- 
2.35.1

