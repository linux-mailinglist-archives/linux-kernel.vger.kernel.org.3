Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A774B7F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 05:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344436AbiBPEhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 23:37:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344419AbiBPEhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:37:23 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E934F1EBB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 20:37:12 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id x1-20020a25a001000000b0061c64ee0196so1874474ybh.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 20:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZVCaTafRnnf5d3inHCDQdPKKWocYJyu5eiZME/8lYHM=;
        b=Lp0pe85DVhHiZL5qfP+SkXpvO95oZbjOtle8vsjMApUQZu9ZrMDoRO2I1jat8A3GSt
         JSgLehb4yIHAaOsjvDi/3eTh10v1ZIPQf3VcR/ny+oli7hkGoio2fvuYcvF1YSTUzv/X
         PWccAqwLhuZ2HAoGJshdp1qFnzAoIHBAaK46WlfCmKj/QlbjIqR6zN/FqaXLuR4eYDKM
         rUcfNpxKQVvUW0bzhxvUQFN7gmk40k1O8ELDrbI7NmnfWWbB4GTGSWfJgC28KYyEBti8
         aujsN3ee+Cq/E4h6enmRBnyJqaXFH1gukgjCDLDb14XslPquNSHnKEalKMkIEuBW5WgM
         PqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZVCaTafRnnf5d3inHCDQdPKKWocYJyu5eiZME/8lYHM=;
        b=vo/7W38pQAhYXGNxrNu4fSTwMdWKwySVi4XnnVr0cI7WVDgaEPy9uTGxz4Rg0LBate
         lWr0YEt3LdP5JJULL+4+7GF0vNemRPoOWqQHVy2VaDUGgDfT2+RF4N+PZ4RJlzZkqBjJ
         lGXb3tQJP0jR7LIiiIYdyvewlHSYalM3bzEN5gmQBtofGneBRKC7tvP+2zC1fY64hvwm
         Vu2xTJF9ufLCU6C7icRRIDfkHAJiN2TtaKH84FD5Vre3MtjnzFwbpodNV3nXV31xLEow
         fp+BEAbqhGpo7KnFUzreaPsL7bjgTvs/hqqtac8ndXAH5GXumIJ1zstpOKHKxmuTNY+x
         16og==
X-Gm-Message-State: AOAM531GFhSGAIQb1wwZ9MEFcKEWzQBJh/JH8rjj2lPZMTij4B/VqEmA
        AqdW1ZSK6f6zEDnzF/Ys+LNo3QhMYASJ
X-Google-Smtp-Source: ABdhPJxkeYjK1cD1AfT1ZUclFMK0x5SOz6XYbqagS0Uf3dXTfmZJWGMDkeXbVnqZ4XYm/AJO4n05WNGK12zi
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:8ce7:5b2:9787:1a0b])
 (user=tzungbi job=sendgmr) by 2002:a25:20c5:0:b0:61d:eeef:cc53 with SMTP id
 g188-20020a2520c5000000b0061deeefcc53mr751041ybg.150.1644986231395; Tue, 15
 Feb 2022 20:37:11 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:36:39 +0800
In-Reply-To: <20220216043639.3839185-1-tzungbi@google.com>
Message-Id: <20220216043639.3839185-6-tzungbi@google.com>
Mime-Version: 1.0
References: <20220216043639.3839185-1-tzungbi@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v4 5/5] platform/chrome: cros_ec: append newline to all logs
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org, groeck@chromium.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@google.com,
        pmalani@chromium.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be consistent, append newline ("\n") to all logs.

Reviewed-by: Guenter Roeck <groeck@google.com>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
Changes from v3:
(https://patchwork.kernel.org/project/chrome-platform/patch/20220209095703.517608-7-tzungbi@google.com/)
- Add R-b tags.

No changes from v2.

Changes from v1:
(https://lore.kernel.org/lkml/20220125101527.1812887-1-tzungbi@google.com/T/#u)
- Use imperative mood in commit message.

 drivers/platform/chrome/cros_ec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index a3921fe5813a..a45bbc589928 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -216,7 +216,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 						"chromeos-ec", ec_dev);
 		if (err) {
-			dev_err(dev, "Failed to request IRQ %d: %d",
+			dev_err(dev, "Failed to request IRQ %d: %d\n",
 				ec_dev->irq, err);
 			return err;
 		}
@@ -267,7 +267,7 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
 	 */
 	err = cros_ec_sleep_event(ec_dev, 0);
 	if (err < 0)
-		dev_dbg(ec_dev->dev, "Error %d clearing sleep event to ec",
+		dev_dbg(ec_dev->dev, "Error %d clearing sleep event to ec\n",
 			err);
 
 	if (ec_dev->mkbp_event_supported) {
@@ -338,7 +338,7 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
 
 	ret = cros_ec_sleep_event(ec_dev, sleep_event);
 	if (ret < 0)
-		dev_dbg(ec_dev->dev, "Error %d sending suspend event to ec",
+		dev_dbg(ec_dev->dev, "Error %d sending suspend event to ec\n",
 			ret);
 
 	if (device_may_wakeup(dev))
@@ -381,7 +381,7 @@ int cros_ec_resume(struct cros_ec_device *ec_dev)
 
 	ret = cros_ec_sleep_event(ec_dev, sleep_event);
 	if (ret < 0)
-		dev_dbg(ec_dev->dev, "Error %d sending resume event to ec",
+		dev_dbg(ec_dev->dev, "Error %d sending resume event to ec\n",
 			ret);
 
 	if (ec_dev->wake_enabled)
-- 
2.35.1.265.g69c8d7142f-goog

