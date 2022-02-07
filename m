Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD3F4ACB73
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241421AbiBGVlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbiBGVl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:41:29 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80658C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:41:29 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id i17so15277588pfq.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 13:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tcubl29wxHrfPOdKaU07z1LfBhKF2TahuS0DNugCibg=;
        b=P9mQpQf+5Bnn27EUGTnkmIZKoXhB3KlHr2N64cTo7YYurZP/mLFu40sjirHtATMxvL
         WtTAG0uGmf4tTd4F9ITtPYlxb3I7UFw9xVJdBNpOi9S/XYady/yHlNbLxIDnstkI2dvv
         EwCEFkazZwpdY9ryvKOcPAlgWeCn1S6na8rDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tcubl29wxHrfPOdKaU07z1LfBhKF2TahuS0DNugCibg=;
        b=fLn/+muRfeMv7vYj6L1F1pfzrWxeDdIgUxk8CHw35dEXNEWbexoFNYwbQIbU0k+hb0
         86+vF+KtNi0N/Ac1Sr/piWPzNiYOK8VlXEvOzJU+5XhbOJnDHyWw39qtkM1ITuGRIxU+
         QKI3pHAk3FK+jEGDNjqFPfq9LnvDf0fpN9mqVoK7x3wXwmH16tn+CUDRHjjI7CSH+VR9
         oX6n1pe7LJHimZma0BQUw6rfW0YtuGjAknkc0iLFj/A0ftdguZnUyy67kVXImrceO1vI
         IbQ/JMI3f3IOLAifzpkv/9VkP/r+JFioNt1yhmqHNdWg5Rp160c6OAogueloFtMpOZSB
         nVTQ==
X-Gm-Message-State: AOAM530KjpudpwDiO7MwDGmESOKp7wEXG0nVyzpKV9/TkD5YhLcCpXAY
        u3fzBBUF2w8afx1/DZ8vE0uk7C8+ZWJ5uw==
X-Google-Smtp-Source: ABdhPJwW4HOSPUEVZwDeOrc4ZHIHjzjmHviUCjZFB/LBvAqozD33GakPGcuKE+nM6JHJABWvGkcfKQ==
X-Received: by 2002:a65:550a:: with SMTP id f10mr1118443pgr.204.1644270088935;
        Mon, 07 Feb 2022 13:41:28 -0800 (PST)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s9sm9268010pgm.76.2022.02.07.13.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:41:28 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev (open list:CHROMEOS EC USB TYPE-C
        DRIVER)
Subject: [PATCH 3/4] platform/chrome: cros_ec_typec: Configure muxes at start of port update
Date:   Mon,  7 Feb 2022 21:40:28 +0000
Message-Id: <20220207214026.1526151-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220207214026.1526151-1-pmalani@chromium.org>
References: <20220207214026.1526151-1-pmalani@chromium.org>
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
 drivers/platform/chrome/cros_ec_typec.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 671d3569faf6..164c82f537dd 100644
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
@@ -980,11 +985,6 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 	if (typec->typec_cmd_supported)
 		cros_typec_handle_status(typec, port_num);
 
-	/* Update the switches if they exist, according to requested state */
-	ret = cros_typec_configure_mux(typec, port_num, &resp);
-	if (ret)
-		dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
-
 	return ret;
 }
 
-- 
2.35.0.263.gb82422642f-goog

