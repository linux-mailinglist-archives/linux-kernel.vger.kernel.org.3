Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C159484006
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 11:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiADKma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 05:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiADKm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 05:42:29 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496D4C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 02:42:29 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id g22so32380642pgn.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 02:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hfIMdib9TxYU83Yq6/1+x94iJVj27/gjNxj0nCIUnZQ=;
        b=hseIhjJ7gIgUnuNAlcfeplsNBsP3jjj3fyixO1vf0Iapr7bPCnF6uzf/1WRdgaiEGG
         UXopDWZ5sIeMj4RJmaCwk9AcntbB4IOT31NQwHNsRktPYo7G7ksCNAP3P/jPy2LPhVrr
         vgI5GPSvTdi2CN/qE2jHlB6PFFiij4349sSgss74oLDSTpTnoyQwDCINMakwQO5AGdpR
         Swgt419IBkmrv1lf65+b6cxoreTXdNpJ4pa2swsPJ0+mY0jCPvx8RZrtM3R7kV4RRnDk
         qKnpYBxzUFiLqhW/WeRywq0SLMftjlM1XS0IeqaE73Nt5azt2VYnH1ytD6KQCcmGXMqx
         p0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hfIMdib9TxYU83Yq6/1+x94iJVj27/gjNxj0nCIUnZQ=;
        b=f7679bMNq5knrmUZn2K3Pj2FjC5iKOSRbwphrjEgJPXQQFhIReTTX6OVrf2b1RTW0o
         wS1zKp5S0KVFAyEMqagTx4x3JV4hBa2vOQ0kJ34QjXwKqgnOAjZzTBGkJMJ7pqjOdpnU
         QPpPlr03RmlMcEeNPJWvcvdoIAtkhnEwJWMfmaKFhujqW+ao6E1QkyYhQkmV5u89sWCJ
         vQOg2YRczaBPFiAR3bbLiKG22D2kLE2YcFTBsTVRowFPLC13bRe1p9eGkUgPSGVkjHwi
         Z5RCFYldmrbnWRt8y/jzqNJdpt3+won0y16Qsm5u9UKBuiVSv6iw5gOV/dr+IzWi1HWe
         tiFg==
X-Gm-Message-State: AOAM533s1EMkfW7Yb+DM1deo5Aqz1eW7IxAIN9iPhC5XrMsx6f1XA+bG
        GJPsVvjXXkV9hs0CDDuTATY=
X-Google-Smtp-Source: ABdhPJyekr+/HCc4S1iUD9Wk1bLLzXUYiJQe5k8EP0fzYwfGZKR1m9n7LMoWNzXOV5kPrgFjkSUTYg==
X-Received: by 2002:a63:ff4f:: with SMTP id s15mr43216991pgk.215.1641292948802;
        Tue, 04 Jan 2022 02:42:28 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id o11sm42564988pfu.150.2022.01.04.02.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 02:42:28 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] drivers/regulator: remove redundant ret variable
Date:   Tue,  4 Jan 2022 10:41:39 +0000
Message-Id: <20220104104139.601031-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Return value from regmap_update_bits() directly instead
of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 drivers/regulator/mt6380-regulator.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/mt6380-regulator.c b/drivers/regulator/mt6380-regulator.c
index 9efd8710a6f3..2e6b61d3b0cf 100644
--- a/drivers/regulator/mt6380-regulator.c
+++ b/drivers/regulator/mt6380-regulator.c
@@ -183,7 +183,7 @@ static const unsigned int ldo_volt_table4[] = {
 static int mt6380_regulator_set_mode(struct regulator_dev *rdev,
 				     unsigned int mode)
 {
-	int ret, val = 0;
+	int val = 0;
 	struct mt6380_regulator_info *info = rdev_get_drvdata(rdev);
 
 	switch (mode) {
@@ -199,10 +199,8 @@ static int mt6380_regulator_set_mode(struct regulator_dev *rdev,
 
 	val <<= ffs(info->modeset_mask) - 1;
 
-	ret = regmap_update_bits(rdev->regmap, info->modeset_reg,
+	return regmap_update_bits(rdev->regmap, info->modeset_reg,
 				 info->modeset_mask, val);
-
-	return ret;
 }
 
 static unsigned int mt6380_regulator_get_mode(struct regulator_dev *rdev)
-- 
2.25.1

