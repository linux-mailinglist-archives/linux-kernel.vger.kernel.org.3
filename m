Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0C646F7FC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 01:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhLJA02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 19:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhLJA01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 19:26:27 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CD3C061746;
        Thu,  9 Dec 2021 16:22:52 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u1so12393417wru.13;
        Thu, 09 Dec 2021 16:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cdBf1B+Hmwd5PFbci4WK17kIT5lJDcYDTMQv5xnAW20=;
        b=XGl4tq5LgiZbSqKAOn+ysQaWs9Ud00eLcjg8LQL63s1N9VJpwojM+ii3ZCj9jrbTFf
         7/xZS/XN+38lmzQKcoxF37REFWCB/xJFeCn6QAoXXDpwNuayPb9vI4V7BSrh5DrGUBTx
         FVQFtGeOftnqB0okfbnHchQW6tVLkc+nYKhYbqskQlXhyRfb1UhY6jF4/t3dvL/u7xy6
         Hc/3foigwLLY5w05CkCJC6ZBzbKdQRA4mzVfUSk1rqAwdaC361dMs9PmP0tVz6DVfmn2
         TCaWg2UPbFltGB4oKG8bNwHXUe2C2crA467AGOmk4gcDZ0GZOyfZiq4FquHW9tFp+Ias
         ha0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cdBf1B+Hmwd5PFbci4WK17kIT5lJDcYDTMQv5xnAW20=;
        b=yqsTpl2KH3izHFQZP6hPH2IGc5KkyuxVpVT3TszX+deEmckZyQGyb4yLCR5DllT9rA
         qyCD++plc+p1hfIeO3no5T5j46PjIKGEV7I4eRJsjTkACMQBhdnH9p9fAKqd+rpPmYfT
         NyfsoO4e/hgz3dQq/2xDuPvrVt9IZT0LTX8XALGOamJDn5ewskdGsmI5NGYyonVrFVAR
         mScDLrmWLh3qxmFpRnBTiMJj/BSKCzcUQmBK3jWo+9adfL4DnGKFEkKiGZSzBX07uViM
         dy28+3cMGaaMmafU/KFXFD5yq9HYMcAEO12A0UVMXGA1/j/Cm+ka6iZo9hcPHlFB9Pr6
         1DPA==
X-Gm-Message-State: AOAM530awORe89UsjSjj3wi//jeqIUN3HKbMbT6puc/TW7y8ckyMGcao
        hnH06PEpJNLsQNWNOZaTP84=
X-Google-Smtp-Source: ABdhPJzWzdcnndKgHrrbfchtD2CenirzjjQWpiV0qB3iXOCkjaAAb2cyvHup07E4RiiJpmpypLoPdw==
X-Received: by 2002:adf:cd06:: with SMTP id w6mr10503491wrm.431.1639095771325;
        Thu, 09 Dec 2021 16:22:51 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g13sm1525012wrd.57.2021.12.09.16.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 16:22:51 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: atmel: remove redundant initialization of variable timeout
Date:   Fri, 10 Dec 2021 00:22:50 +0000
Message-Id: <20211210002250.639251-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable timeout is being initialized with a value that is never
read, it is being re-assigned the same value later on. Remove the
redundant initialization and keep the latter assignment because it's
closer to the use of the variable.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/pwm/pwm-atmel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 98b34ea9f38e..8e00a4286145 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -271,7 +271,7 @@ static void atmel_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm,
 			      bool disable_clk)
 {
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
-	unsigned long timeout = jiffies + 2 * HZ;
+	unsigned long timeout;
 
 	atmel_pwm_wait_nonpending(atmel_pwm, pwm->hwpwm);
 
-- 
2.34.1

