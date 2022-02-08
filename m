Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D174AE15F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385435AbiBHSsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238272AbiBHSsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:48:02 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C8EC0613CC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:47:59 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id on2so12077pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 10:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jLio1a1l75mHbmNEuBlAUNzao55kTSeKszQYcAQRX+I=;
        b=MsjVta7IYbQNKqHe58RtLXBHcrrrukRhSUHG22zWAasQ99i8xGDjf6fjdG686TlnIa
         nybAKSUI943yDMYt1V4L4HPXRb7QQjwNcAdgkBEA7mkKq7rvOzgkYGUwhNrja80IyCzj
         TubUKDuwMDz9gZ1PzfVVVhqUkOhBd0PGbly6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jLio1a1l75mHbmNEuBlAUNzao55kTSeKszQYcAQRX+I=;
        b=yR8OfIgywEkpHzTanDV1iAzmnN33WOiQdcEKwXUFdfZpWuxsNUJurdwbXp1UnuGG3m
         irEOkIClwrfC4OoRZKHjMuLIDdvk5x90eQkfxcvr9eSVqkobsaXB9+UlLXWgF0314YK/
         DsCBoejthoRKtt+W+QX/oC3WOeLcVq0b5klvqnoBsh+WzgflnCkyuNJDU/xIJygHytOf
         K3DZiBwlNcUxeqUVG91wOZLRKZmijhiGYRFuj9PwBVguei0PANI02ca+GQ4zfmpxUUqi
         gXnmq+2qCD63lRDxjv0yPKtVnKXPUEsm0a8ewKHocUflhkzEGyeqFLOUBHOFINrL76yQ
         mPrA==
X-Gm-Message-State: AOAM5335vHQOYU9qPwERHn4bO0ws6huXBtF3bt6mwND16IRd3d1Oh0c5
        QBKlXujBtooxk+7trnpWmrxNueRviGfLlA==
X-Google-Smtp-Source: ABdhPJzA8ECq/26nKv0NhBy5xwK2bu7d8aQaB1wRho9op9ZuMhWeJ0H4ktflQM6NMxY0ajIdDbI8/g==
X-Received: by 2002:a17:902:da88:: with SMTP id j8mr5904035plx.105.1644346078477;
        Tue, 08 Feb 2022 10:47:58 -0800 (PST)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id gk15sm3594453pjb.3.2022.02.08.10.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:47:58 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev (open list:CHROMEOS EC USB TYPE-C
        DRIVER)
Subject: [PATCH v2 3/4] platform/chrome: cros_ec_typec: Configure muxes at start of port update
Date:   Tue,  8 Feb 2022 18:47:22 +0000
Message-Id: <20220208184721.1697194-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208184721.1697194-1-pmalani@chromium.org>
References: <20220208184721.1697194-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are situations where the mux state reported by the Embedded
Controller (EC), might lag the partner "connected" state. So, the mux
state might still suggest that a partner is connected, while the PD
"connected" state, being in Try.SNK (for example) suggests that the
partner is disconnected.

In such a scenario, we will end up sending a disconnect command to the
mux driver, followed by a connect command, since the mux is configured
later. Avoid this by configuring the mux before
registering/disconnecting a partner.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Change return at end of port_update() to just return 0.

 drivers/platform/chrome/cros_ec_typec.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 3d34ece7f790..3019e29f200d 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -965,6 +965,11 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 	if (ret < 0)
 		return ret;
 
+	/* Update the switches if they exist, according to requested state */
+	ret = cros_typec_configure_mux(typec, port_num, &resp);
+	if (ret)
+		dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
+
 	dev_dbg(typec->dev, "Enabled %d: 0x%hhx\n", port_num, resp.enabled);
 	dev_dbg(typec->dev, "Role %d: 0x%hhx\n", port_num, resp.role);
 	dev_dbg(typec->dev, "Polarity %d: 0x%hhx\n", port_num, resp.polarity);
@@ -980,12 +985,7 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 	if (typec->typec_cmd_supported)
 		cros_typec_handle_status(typec, port_num);
 
-	/* Update the switches if they exist, according to requested state */
-	ret = cros_typec_configure_mux(typec, port_num, &resp);
-	if (ret)
-		dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
-
-	return ret;
+	return 0;
 }
 
 static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
-- 
2.35.0.263.gb82422642f-goog

