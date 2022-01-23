Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78660497632
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 23:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240430AbiAWW4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 17:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiAWW4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 17:56:30 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06F1C06173B;
        Sun, 23 Jan 2022 14:56:29 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id az25so10326027wrb.6;
        Sun, 23 Jan 2022 14:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LDOgKOdiEB+jtoqW0SZVX4i2KQZlPUMvAIY5OW70vOE=;
        b=GaU1WlTJe8o4xvL7KaNa715aC1jENyV5f+5wz3fLlfQP/bKSWF0rQH3MLY58A7RVMd
         84SdZqq2J87kDfYtoW1Xw482TTgeYHIYfMEnIQ+UIod42YPfcTU6KlLYybimt3aqGcXw
         g56Q2fZ0zV4Y0QJFyeZUwquuuk2V5cy+csi6fLvswhRIktVfxcr0T+MaTLl4fYCatax8
         IAms0GLoX5t74hzZ66cleFYe63pFsoAt3UIvtXZwnO4zembngTUBwI3NGnpwy7qZ/NEV
         ORdJ3/K1MYpEmJLljitmVAhr2yqoOOGXlCLjLXYL24NbynSiGfq7WeQIdAvGx9ilhho7
         /W8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LDOgKOdiEB+jtoqW0SZVX4i2KQZlPUMvAIY5OW70vOE=;
        b=EEomTt/SZI5e+cVqWLrDqlgf9e7GTmbZsbtL3qyNxakTd1wgn85TisTlKsB4r5ABhz
         R9Z+hgTF+Jxf+MORpOLbSoOpTPZSeSUB10K+nLhwhfjaQa3otuyPECI7ljFyu/Omc4RC
         4H70n3baVuWjXfhHXW1TDMsoJFFBTcvcI8InSM1nEC4LnXzQ5KwyZxrrFYwKriEoPVDr
         n9HiCR/USUGjrk+bgjNy+9oMSqTz+SJhiEtJMqlGoASun4gmjAUE1+MqL/HsFwSicFAe
         Uyc9VcDZigtB+VXp7ZPNN/yBRBxHEBlA1KRstM3nfhdxbnFY6C7bbdXm56/ry1vCJL2z
         n0zg==
X-Gm-Message-State: AOAM5333ZuLeUwVzCuFUoDvG/L2fyF4ZkHfDbaWC3VErOZknhU5a3cXq
        Fv3mtGdgljl09YmrhRklABw=
X-Google-Smtp-Source: ABdhPJykPmUw6Hcp8JUji25zgfPKpMJitakam089ohuqzq92vISrZMGuwyJ5udRSCZ5DFt5y95llMw==
X-Received: by 2002:a5d:624f:: with SMTP id m15mr11589740wrv.13.1642978588436;
        Sun, 23 Jan 2022 14:56:28 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g30sm13504108wrb.29.2022.01.23.14.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 14:56:28 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: dib7000p: make static read-only arrays notch and sine const
Date:   Sun, 23 Jan 2022 22:56:27 +0000
Message-Id: <20220123225627.7218-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static arrays notch and sine are read-only so it make sense
to make them const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/media/dvb-frontends/dib7000p.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-frontends/dib7000p.c b/drivers/media/dvb-frontends/dib7000p.c
index 55bee50aa871..a90d2f51868f 100644
--- a/drivers/media/dvb-frontends/dib7000p.c
+++ b/drivers/media/dvb-frontends/dib7000p.c
@@ -1188,8 +1188,8 @@ static int dib7000p_autosearch_is_irq(struct dvb_frontend *demod)
 
 static void dib7000p_spur_protect(struct dib7000p_state *state, u32 rf_khz, u32 bw)
 {
-	static s16 notch[] = { 16143, 14402, 12238, 9713, 6902, 3888, 759, -2392 };
-	static u8 sine[] = { 0, 2, 3, 5, 6, 8, 9, 11, 13, 14, 16, 17, 19, 20, 22,
+	static const s16 notch[] = { 16143, 14402, 12238, 9713, 6902, 3888, 759, -2392 };
+	static const u8 sine[] = { 0, 2, 3, 5, 6, 8, 9, 11, 13, 14, 16, 17, 19, 20, 22,
 		24, 25, 27, 28, 30, 31, 33, 34, 36, 38, 39, 41, 42, 44, 45, 47, 48, 50, 51,
 		53, 55, 56, 58, 59, 61, 62, 64, 65, 67, 68, 70, 71, 73, 74, 76, 77, 79, 80,
 		82, 83, 85, 86, 88, 89, 91, 92, 94, 95, 97, 98, 99, 101, 102, 104, 105,
-- 
2.33.1

