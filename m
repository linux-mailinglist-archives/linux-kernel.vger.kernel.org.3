Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0767D547940
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 10:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbiFLINC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 04:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbiFLIM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 04:12:57 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A628674D5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 01:12:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gl15so5649938ejb.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 01:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jRyy5hKQd+kqHmg467ZxRJ79p2wfYhLJmjkerJiKcTo=;
        b=EZWh2CfzXf2OHYzHXos2/i9pv35MMrNJlIFIh2ELSCd0L5dRJHCe8f5DSrLNHQQeLB
         Ef9g2xV/rKGJqAF4H+hmSk5Zk0nd4yIMF+5BD83utIOiCqYuiOE1nmKMM2Vjxe9GLeGH
         /uBErmAywS983NwgrXId47TdwnUCM2OougHxI/Fi1FHbTKuQBdQNGNXc3Q4cwkddQG/P
         k7VCJMs1Kq57Sp2lK3rFiGmg8VJDqASCDVkEEyCLp7wLYr60bbcjrLzjYHQmsQerRkbZ
         cLp2PvnMgQHEkPqKEWL1bbMWZGjpFq+IZ3vBR+yIbjk0fr9jWXJMLnLQWiDoFJNlAgxh
         UoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jRyy5hKQd+kqHmg467ZxRJ79p2wfYhLJmjkerJiKcTo=;
        b=D/AN2j721uQ6M9aCvF+F5tJ7mUv30dlwlv6CW4Dp1N20YcZb3nmCJ3/1MxXGD+WoIM
         uSgp6DDC9lwA9iE7HtOJk7/2TFI6WWU5OnrPqw7RXq7zToFPc9K3UIdViF5muberunSV
         O9RjKyNs0XUzL653d2NyrhqTiAvz1jGo4RmYNiwD3FcX6kv3bjOPkzqz8CUwtziIBTJD
         PQEZEcxjzUj52dQTyLdkoBLWaGJriXikf8yFn3yMx814/KD2yt/9yXGltvAWdeJXoZWy
         PK82Ey8B0rArCxdISAODKtt/ml0Pv47cC6XYTQwuluI0zAuWJMJZPyhHUU5lLfNDoe92
         JEFg==
X-Gm-Message-State: AOAM533zRKEvwSW11xKR4xWyO/AYWcjtu8YX6vdILl6+Z/vmIp7toC/G
        yeozacr2oXwHw0KgoWPfU7I=
X-Google-Smtp-Source: ABdhPJznElZmUF/q/STbgt+TqSWw58seYQ+n7Bl8UR6K9vjD0KVMJHYbspUN0iGR4mpp+A+xfHfzpw==
X-Received: by 2002:a17:907:97d5:b0:706:76ba:f28f with SMTP id js21-20020a17090797d500b0070676baf28fmr46994279ejc.367.1655021572728;
        Sun, 12 Jun 2022 01:12:52 -0700 (PDT)
Received: from nam-dell.fritz.box ([2a02:8109:afbf:ed88:bcf1:6e8b:57bb:87f1])
        by smtp.gmail.com with ESMTPSA id o18-20020a17090608d200b006ff802baf5dsm2130637eje.54.2022.06.12.01.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 01:12:52 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com, phil@philpotter.co.uk
Subject: [PATCH v2 1/2] staging: r8188eu: replace LE_BITS_TO_1BYTE with clearer codes
Date:   Sun, 12 Jun 2022 10:11:43 +0200
Message-Id: <4cdacd703158029c0b0f706e3cf1eb8daf4121c0.1655019752.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1655019752.git.namcaov@gmail.com>
References: <cover.1655019752.git.namcaov@gmail.com>
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

The statement LE_BITS_TO_1BYTE(__paddr + n, 0, 8) is not obvious on
what it is doing, while in truth it is simply reading one byte.
Replace these with clearer codes.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h b/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
index 20d73ca781e8..79e4210c6b65 100644
--- a/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
+++ b/drivers/staging/r8188eu/include/Hal8188ERateAdaptive.h
@@ -26,15 +26,15 @@
 #define GET_TX_REPORT_TYPE1_RERTY_0(__paddr)			\
 	le16_get_bits(*(__le16 *)__paddr, GENMASK(15, 0))
 #define GET_TX_REPORT_TYPE1_RERTY_1(__paddr)			\
-	LE_BITS_TO_1BYTE(__paddr + 2, 0, 8)
+	((u8 *)__paddr)[2]
 #define GET_TX_REPORT_TYPE1_RERTY_2(__paddr)			\
-	LE_BITS_TO_1BYTE(__paddr + 3, 0, 8)
+	((u8 *)__paddr)[3]
 #define GET_TX_REPORT_TYPE1_RERTY_3(__paddr)			\
-	LE_BITS_TO_1BYTE(__paddr + 4, 0, 8)
+	((u8 *)__paddr)[4]
 #define GET_TX_REPORT_TYPE1_RERTY_4(__paddr)			\
-	LE_BITS_TO_1BYTE(__paddr + 5, 0, 8)
+	((u8 *)__paddr)[5]
 #define GET_TX_REPORT_TYPE1_DROP_0(__paddr)			\
-	LE_BITS_TO_1BYTE(__paddr + 6, 0, 8)
+	((u8 *)__paddr)[6]
 /*  End rate adaptive define */
 
 int ODM_RAInfo_Init_all(struct odm_dm_struct *dm_odm);
-- 
2.25.1

