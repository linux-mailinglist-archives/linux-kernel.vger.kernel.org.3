Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C67468840
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 00:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbhLDXfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 18:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhLDXfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 18:35:24 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E9BC061751;
        Sat,  4 Dec 2021 15:31:58 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v11so13882851wrw.10;
        Sat, 04 Dec 2021 15:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TwHuq68BGqmW2Fn/QSPttgnID1EQBPBbIWi17rr9Wt0=;
        b=p3aA+/XK9CZR2UZFRQ+oUvl5Qz4iSfm7XKTtBgNt9sXe20sZXdZDtmOsPk2WTjoIhW
         zxQHi8P9zHfCCKyfyxNjRFIHu0gop+wbNKPkIKPR4oGRkVrLuTz3BOCAohSN8CUxBwHg
         xMxHqyRMT5n9phe4ECe3vf5XPgxd+M8oLDD1NYAnlI/tObDdLuTC+0StpKh2mG19I66b
         sCGpnBUmvi1BeDUVJqdiUe21suYTYc9l6qnfFdFiPBLQc7JX8viCrFW9syg2S346Aerj
         cG2bKUa4udoBTOBLWoaSUP6o6UcGF3lLLEhmT0neCMluPf/zszV//T+1do/9n194d/f0
         LOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TwHuq68BGqmW2Fn/QSPttgnID1EQBPBbIWi17rr9Wt0=;
        b=S+v/VnVIIsq0ICV1V1Aw6dJ08JRtCZsi5dEHUfDGikiXNO2PpscRDoYGdepdcwznUi
         2ynMQP8m6V7d3FrGxoY+Ry7pblKkMvWTOjuxRumZah++Dc1E2KOiKVrQXx5XWFpFNdHV
         453RVCJXA5ReK4Hyu6y+vBUqhSA/gPHJkt8dgCRTAaDh05WJmvvAnOA2CWunKUbwU8Y+
         H9eszQrXa4arL3Fv9R0vVe/GSBh9Viu13hoeKUlHyDfGnE1eNJDKZY4VVF/XsvpKsgVO
         KmIS1pVdGUw4uUu07EeJ2nIx7FZOe7BJpkif1D+yQ56y/a28VizlOrjuGTJGMlAMvqQF
         gYJA==
X-Gm-Message-State: AOAM533LNJsWhqDfUVL5pX9Y20SVBl0I0ii5TV4UmpJd00M89kaDuuJs
        /jVK+mbDHrqO2VsbCRx/y/C7e7YQi4KESw==
X-Google-Smtp-Source: ABdhPJxaehApPnDPynBlXoaSmySz8HBQiG7JsfudAeFDxcAt3kKx61NAAawUPNZyaQWoRIVZP/YMtQ==
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr32679075wrd.362.1638660716448;
        Sat, 04 Dec 2021 15:31:56 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id w4sm6740284wrs.88.2021.12.04.15.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 15:31:56 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (adm1031): Remove redundant assignment to variable range
Date:   Sat,  4 Dec 2021 23:31:55 +0000
Message-Id: <20211204233155.55454-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable range is being initialized with a value that is never read, it
is being re-assigned in the next statement. The assignment is redundant,
remove it and initialize range using the second assigned value. Clean up
the formatting too by adding missing spaces.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/hwmon/adm1031.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index 257ec53ae723..ac841fa3a369 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -242,9 +242,8 @@ static int FAN_TO_REG(int reg, int div)
 static int AUTO_TEMP_MAX_TO_REG(int val, int reg, int pwm)
 {
 	int ret;
-	int range = val - AUTO_TEMP_MIN_FROM_REG(reg);
+	int range = ((val - AUTO_TEMP_MIN_FROM_REG(reg)) * 10) / (16 - pwm);
 
-	range = ((val - AUTO_TEMP_MIN_FROM_REG(reg))*10)/(16 - pwm);
 	ret = ((reg & 0xf8) |
 	       (range < 10000 ? 0 :
 		range < 20000 ? 1 :
-- 
2.33.1

