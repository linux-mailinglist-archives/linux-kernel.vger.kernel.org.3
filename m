Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E039501DE5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343613AbiDNWEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244949AbiDNWEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:04:06 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC12A27D4;
        Thu, 14 Apr 2022 15:01:40 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id bg10so12533327ejb.4;
        Thu, 14 Apr 2022 15:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=97fWddKSGmLrVBKXP8D65MNLbFu69dXpLbEp8OeL0JY=;
        b=FUvHvo6j7z/nZmhOKzzWjHUmJ4eCUfA52MLjv0C1a1gYlEgCZRDzdW7Z/sAswcJ8Vw
         pBBixz88dtnyDEuD2J5KG9aVX/FU3TWV3a0nH7GXgyoWqsPulG8AtaU+zkPfQpmsEHg0
         rIv6rhd1AHkghutCniAfuUVgdjxrJGKA/ObPj2tW6mqn9whp500GYi3FyO8196AeUbyy
         58bzkKq/aZBxqFxEmYjE6BOBvtO5YG5UCmzSUEjnBPWnG3nyoNgFNVb9OnPBVcMW4IFd
         vsJqqUcS5Kf1JOc66KBlty8zpG8Bx/9eP/rq6zeafRpubY4stVzQWaoQuRlwumzu1cP1
         U/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=97fWddKSGmLrVBKXP8D65MNLbFu69dXpLbEp8OeL0JY=;
        b=70P0bd5lGzJBqmKn5dBCkApt4/jT1mVYxZ6OUzBsAJEqLsSF6kkK7+SAdxtSijfr13
         Y9quSGx0YdLNypxupNwr4VWROfZSWvGwYv0tFHKjM8/Vae+TCmwtlSx7wHf2b9H8mFYL
         +6RJQaGYfXPy/ZpyeTcE0gEK0iwU1o6j1V5sl29RmnqGdkgfkS04CF9AUCkv4dBRPeQi
         oNXdLQyrwkJ6bb9SlhTRlq29oXWvsneic4eVtql+wRhBMte19sPppM0KTFHBeB6p1dHu
         Qw24Vt/kJ97hQ/dZNu5aSVS2t+dh9llKFR6clwMeVk/wo2p7ua6zf0a9lMv3YaZzeYMA
         qXhg==
X-Gm-Message-State: AOAM532OLhHGexaI1KSLlt8DaqFYI+5Ro/wtwjks7qwRNUh6ZCZhsbI3
        K1GHMQZiKEDqxm18m6b0ydA=
X-Google-Smtp-Source: ABdhPJyRm/v7Vx4UBoSkb0eWxpgcRh2pP8zouhRhRLyiuAmxjdoay1zCFHoFGsfnqU9VaXGCgpTTrg==
X-Received: by 2002:a17:907:7f8d:b0:6da:b3d6:a427 with SMTP id qk13-20020a1709077f8d00b006dab3d6a427mr3898689ejc.509.1649973698847;
        Thu, 14 Apr 2022 15:01:38 -0700 (PDT)
Received: from linux.. (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.gmail.com with ESMTPSA id e15-20020a170906044f00b006e897e110fcsm1060948eja.48.2022.04.14.15.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 15:01:38 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        daejun7.park@samsung.com, powen.kao@mediatek.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] scsi: ufshpb: Remove 0 assignment for enum value
Date:   Fri, 15 Apr 2022 00:01:25 +0200
Message-Id: <20220414220127.587917-3-huobean@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220414220127.587917-1-huobean@gmail.com>
References: <20220414220127.587917-1-huobean@gmail.com>
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

From: Bean Huo <beanhuo@micron.com>

If the first enumerator has no initializer, the value of the corresponding
constant is zero.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/scsi/ufs/ufshpb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ufs/ufshpb.h b/drivers/scsi/ufs/ufshpb.h
index 2825ec69a6a6..b7e2817d4e76 100644
--- a/drivers/scsi/ufs/ufshpb.h
+++ b/drivers/scsi/ufs/ufshpb.h
@@ -59,8 +59,8 @@ enum UFSHPB_MODE {
 };
 
 enum UFSHPB_STATE {
-	HPB_INIT = 0,
-	HPB_PRESENT = 1,
+	HPB_INIT,
+	HPB_PRESENT,
 	HPB_SUSPEND,
 	HPB_FAILED,
 	HPB_RESET,
-- 
2.34.1

