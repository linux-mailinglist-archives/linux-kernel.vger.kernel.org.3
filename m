Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B674468153
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 01:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383764AbhLDAiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 19:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354317AbhLDAiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 19:38:10 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C8DC061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 16:34:45 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x6so17941921edr.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 16:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrb4dejM62PcILwc0JnaQtpVY00TzngEYMl62VuFaVQ=;
        b=MNMh/4aPmTZN2oa04S2xiyz3v2sylXYSKmpJiOAXMMxrLDRpjWE2ZTofkA56li/YSe
         uOHADelxjhOsI7OAdi6GaCAhpXhWZjYH3O4ryJrY7Jobh6Q7g7BvyF6yQrYlQoSodOvM
         6fdIM/6S2qT94BF4fNAqInetUccxCkvae8853Fj5MPdfzv6ZIRWii/mRXAyhRT81nRLl
         1ieb5M3lJnPwgaiGriztM3nMLBOeAqxv8cIXlVFnwt/sTenGE2fUpQVVpFWLFM+BZKro
         L+TLSVfGEzHVs8VumBJ3qCGKcp3xKnOLOepvOfKx0TfaNj2Uu+x1gMdxYTRLatijX0iR
         cF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrb4dejM62PcILwc0JnaQtpVY00TzngEYMl62VuFaVQ=;
        b=F79clOrisDqDa2nDZXcH7fHJVe3gO8hUWe5BDe2jK2nUX4sl1G0Tyr3WsA1CxgW53j
         N7dnawWDx36RdYsq5kBf/sBgDbQYeYJvq3vK1U7vDQG6kBAQen50bwSCn+zCcb7M6n4P
         3/U/kb+VIQzYNx+Ynd0Y4pqFvhbNITPQiiOYUz3ia3DQlhCrSsQtgwOjZ0ww47jk9CDc
         p18c1YwcHSNCfAE0RzDzCVrZVPwcuqStMGHmRXuy+1bQYm4ywBOGxJ0uyDnAY5FPUww3
         VQUpLeMecF21qtMkXaLwxwA1xNM0P1rOvjROq/udZWyl1DvcrQxhVIhmVRDd8AFL8Xgs
         jhwg==
X-Gm-Message-State: AOAM53195+j6/0iuSDCZ5uZ+d1BKESLllbtTyCEGmwCa1zbhpas4w4+K
        6oy90lqhLYxj7Okyks4lURY=
X-Google-Smtp-Source: ABdhPJwa/j6G63K81l3abOOuJc9zfYONpyPOwtxabooNBafb63TRxtesHWMAjX6+T6bimsNx5OFNAw==
X-Received: by 2002:a17:906:b01:: with SMTP id u1mr27043991ejg.504.1638578083848;
        Fri, 03 Dec 2021 16:34:43 -0800 (PST)
Received: from bulldog.fritz.box (host-79-17-112-183.retail.telecomitalia.it. [79.17.112.183])
        by smtp.gmail.com with ESMTPSA id hd15sm3058178ejc.69.2021.12.03.16.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 16:34:43 -0800 (PST)
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     alb3rt0.m3rciai@gmail.com
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: refactor byMaxChannel to max_channel
Date:   Sat,  4 Dec 2021 01:34:11 +0100
Message-Id: <20211204003414.3824745-1-alb3rt0.m3rciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace camelcase hungarian notated variable "byMaxChannel"
into linux kernel coding style equivalent variable "max_channel".

Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
---
 drivers/staging/vt6655/device.h      | 2 +-
 drivers/staging/vt6655/device_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 245f992e5a23..6ea4165e4929 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -201,7 +201,7 @@ struct vnt_private {
 	unsigned char byTopCCKBasicRate;
 
 	unsigned char byMinChannel;
-	unsigned char byMaxChannel;
+	unsigned char max_channel;
 
 	unsigned char preamble_type;
 	unsigned char byShortPreamble;
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 37a82550ca82..313f0241d989 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -229,7 +229,7 @@ static void device_init_registers(struct vnt_private *priv)
 
 	/* Get Channel range */
 	priv->byMinChannel = 1;
-	priv->byMaxChannel = CB_MAX_CHANNEL;
+	priv->max_channel = CB_MAX_CHANNEL;
 
 	/* Get Antena */
 	byValue = SROMbyReadEmbedded(priv->port_offset, EEP_OFS_ANTENNA);
-- 
2.25.1

