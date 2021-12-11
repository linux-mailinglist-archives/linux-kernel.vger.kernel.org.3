Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B128E47153F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 19:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhLKSBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 13:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbhLKSA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 13:00:57 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37946C0617A1;
        Sat, 11 Dec 2021 10:00:57 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id u1so20067378wru.13;
        Sat, 11 Dec 2021 10:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NTqJE9O5IKUSo/m88Ab/X8Fm1HEOexFRkRE81c4V/Mg=;
        b=LfuiKKGmEbpKqw430aASUTABt3NnFt6A7kO84jFi0HbZqcIRYjovGFxIdzgoPgz6vV
         nwauJ6arBYI+7/rqV6Z4Z8YeVKdCDEbNxPtrJyTinw3el7zvfIktrz3AQRUx0DptNe7t
         dL/H3v3BxG48WfD4AhqivG5mnbZ5g2eceXMXvUzlgJiNG2lSpaJ5w0ruNik0K4OhG0OY
         7NTkF00HlJmRA9CPSWcDo5pgOfuzW3y1Cv1qxsX56lvkUoV4wRPvxnag+HGBpBBbXWDS
         GkYCJ0BStnJhUsEK8utPdqurQad7JftGG9pRH0Y2R5VxxmFi+LDQdu3uuv5hX3OtsAKk
         96tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NTqJE9O5IKUSo/m88Ab/X8Fm1HEOexFRkRE81c4V/Mg=;
        b=lZ8X+mnwvIehwinp4QZjDU2A873YJrWkNpFVdVGQAzzbrQEmQy7Tl3AJOWWiOamvDP
         BofxPDVY2TyJ4SCzFx+7S16Oivu8V3Az5tytc90oM1WV8mts7v8pa2UFQTnY8iNxxqdi
         KMxO84eIxSJhutjHoDyl0dd2ePVRvKeDiWEEUzcs1byP0oh8Qb9KURVvE5D037hpzgTU
         cXRR2wWEkwj2uxAmm0YM9jxuquFgTvtwG7Lqt7EvCNARgWIyb05sfyWHVHSY/khO9RL/
         SdThCXriVXJ9EQ9ExxgJnpUdKQgAeGcjDFTz5awsD1cKMIau4UsQ02kRFJUKSrs+MOlR
         nBUA==
X-Gm-Message-State: AOAM530uuSF+FnTGz1WUzW2PuoKZmaFIxoNekJ4RNy9bQYxJtuo52GYM
        YyMW4UoDEvLLR/kvJsHgt2u0JxoscDJYEMBM
X-Google-Smtp-Source: ABdhPJxUAVBviSw0OvKnZaywdMXUJn7Ur6vlRTPj4c6JyDiOu3sUOnpqJgWSgh8vZYgMdzgksGZ31w==
X-Received: by 2002:adf:f3d0:: with SMTP id g16mr6478226wrp.699.1639245655258;
        Sat, 11 Dec 2021 10:00:55 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id z7sm1994792wmi.33.2021.12.11.10.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 10:00:54 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: rockchip-inno-usb2: remove redundant assignment to variable delay
Date:   Sat, 11 Dec 2021 18:00:54 +0000
Message-Id: <20211211180054.525368-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable delay is being assigned to zero and the code falls through to
the next case in a switch statement that returns out of the function.
The variable is never read in this scenario and so the assignment is
redundant and can be removed.

Cleans up scan-build static analysis warning:
drivers/phy/rockchip/phy-rockchip-inno-usb2.c:753:3: warning: Value
stored to 'delay' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 1938365abbb3..9f95b587e2c0 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -750,7 +750,6 @@ static void rockchip_chg_detect_work(struct work_struct *work)
 		fallthrough;
 	case USB_CHG_STATE_SECONDARY_DONE:
 		rphy->chg_state = USB_CHG_STATE_DETECTED;
-		delay = 0;
 		fallthrough;
 	case USB_CHG_STATE_DETECTED:
 		/* put the controller in normal mode */
-- 
2.34.1

