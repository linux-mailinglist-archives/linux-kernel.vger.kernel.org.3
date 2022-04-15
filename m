Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7673501FAC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348073AbiDOAfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348048AbiDOAfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:35:25 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279D4B0A67
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:32:59 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id bg24so6510085pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u5uNblHgSOrswPeO9jURL3NSLbtduvbh6ZJ+Qdg6lQI=;
        b=FL9PZa7rqg/FQc24DKxyR99Opmvgy6c3zIdZDaBfP4n8HTZ/yB2BYuvSBSFQXOcAZd
         uEHYiNbQmPVoRnkfuIxaz3XeEJ8J6ZPZ3z2WRzpYo7g5KAzE2lyNiu7Fr89hF9l8lZTG
         /4B9a+qm1khvB+hDLkK+xXPYs9ZguwZPEysNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u5uNblHgSOrswPeO9jURL3NSLbtduvbh6ZJ+Qdg6lQI=;
        b=3Qz58RactdaRM2QcO5BHZrAEc/NUqfNq2Q41Rt8JcuNOQ3PioAKUxax5sJI5eAJX3f
         8jj0lNn7E2u9PPadcbBoCJpTdJG97o9NfOBlN6y+Hl3Q/JpRb/Ku4BJxk5Z/MKEn7cX5
         SdsuLQGyT9wc+pc9q9EHSKM55FbrdwwaIjb1QDWirE9kGbwnGgj5tTydkL87wH7Z0bSe
         3MY9uX4VkiUdC8s36Z48SYNQzV61Xa8ZiAxAMPHS0v9IuTQkMxm5r6wGOUqyW5CmoLU0
         gz9JNwme1riSOiXnJ0VfMuq5groa4I5RTMfD4zWW7p4HJ8nfLkx/6eZ5XYHYzik0KTDS
         CPag==
X-Gm-Message-State: AOAM531gvpKEF+gnCFeQ2VDJ4EN0RX46M3NZK+PbW48o+r+pz30ORWvQ
        /ocimSh5Lax2J+ry+5b0BxLFIg==
X-Google-Smtp-Source: ABdhPJy092wIOMpHMCaiCRG/f784cDQMvZyv6Zy3Qf2VuKU9u3jvUIyk6bF/0bpYWpLFKq3UGLiVqA==
X-Received: by 2002:a17:902:b941:b0:14d:af72:3f23 with SMTP id h1-20020a170902b94100b0014daf723f23mr50652474pls.6.1649982778661;
        Thu, 14 Apr 2022 17:32:58 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:e3e0:734:f81a:d2c1])
        by smtp.gmail.com with ESMTPSA id p12-20020a63ab0c000000b00381f7577a5csm2830187pgf.17.2022.04.14.17.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 17:32:58 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Lee Jones <lee.jones@linaro.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: [PATCH 3/3] power: supply: PCHG: Use cros_ec_pchg_port_count()
Date:   Thu, 14 Apr 2022 17:32:53 -0700
Message-Id: <20220415003253.1973106-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220415003253.1973106-1-swboyd@chromium.org>
References: <20220415003253.1973106-1-swboyd@chromium.org>
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

Use the common function cros_ec_pchg_port_count() now that we only
register this device when there are a non-zero number of peripheral
charger ports.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daisuke Nojiri <dnojiri@chromium.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: <chrome-platform@lists.linux.dev>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 .../power/supply/cros_peripheral_charger.c    | 29 +------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers/power/supply/cros_peripheral_charger.c
index 9fe6d826148d..98cae6580eed 100644
--- a/drivers/power/supply/cros_peripheral_charger.c
+++ b/drivers/power/supply/cros_peripheral_charger.c
@@ -104,22 +104,6 @@ static bool cros_pchg_cmd_ver_check(const struct charger_data *charger)
 	return !!(rsp.version_mask & BIT(pchg_cmd_version));
 }
 
-static int cros_pchg_port_count(const struct charger_data *charger)
-{
-	struct ec_response_pchg_count rsp;
-	int ret;
-
-	ret = cros_pchg_ec_command(charger, 0, EC_CMD_PCHG_COUNT,
-				   NULL, 0, &rsp, sizeof(rsp));
-	if (ret < 0) {
-		dev_warn(charger->dev,
-			 "Unable to get number or ports (err:%d)\n", ret);
-		return ret;
-	}
-
-	return rsp.port_count;
-}
-
 static int cros_pchg_get_status(struct port_data *port)
 {
 	struct charger_data *charger = port->charger;
@@ -281,24 +265,13 @@ static int cros_pchg_probe(struct platform_device *pdev)
 	charger->ec_dev = ec_dev;
 	charger->ec_device = ec_device;
 
-	ret = cros_pchg_port_count(charger);
-	if (ret <= 0) {
-		/*
-		 * This feature is enabled by the EC and the kernel driver is
-		 * included by default for CrOS devices. Don't need to be loud
-		 * since this error can be normal.
-		 */
-		dev_info(dev, "No peripheral charge ports (err:%d)\n", ret);
-		return -ENODEV;
-	}
-
 	if (!cros_pchg_cmd_ver_check(charger)) {
 		dev_err(dev, "EC_CMD_PCHG version %d isn't available.\n",
 			pchg_cmd_version);
 		return -EOPNOTSUPP;
 	}
 
-	num_ports = ret;
+	num_ports = cros_ec_pchg_port_count(ec_dev);
 	if (num_ports > EC_PCHG_MAX_PORTS) {
 		dev_err(dev, "Too many peripheral charge ports (%d)\n",
 			num_ports);
-- 
https://chromeos.dev

