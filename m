Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCF049EAF1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245491AbiA0TRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245486AbiA0TRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:17:13 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2282C06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 11:17:13 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id t32so3080802pgm.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 11:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mH3nYcd9zv+BTIzE/gVRRbxueZQ6/1T3MPJYS4VSIUg=;
        b=E6PrxJoS/Mlbc9HMCJh+xJmsvQvF3DlKHUNWPsIj7lTN+r+Z4RrrCmMLUBnzdxw+MO
         QapUbKXC2cYBkhdTB4Qo2Loz4uY6s6iOH7oRbaNnSt5/JAy6IbLc/Xx1ORb9XvRQMJ5x
         3YcQPxaRjhVaZf3nrSQvVm9K2xWH/nJ6QPMRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mH3nYcd9zv+BTIzE/gVRRbxueZQ6/1T3MPJYS4VSIUg=;
        b=cUnCAZ4ctHuZTUbe0I98WQbDQsK9DhaGU60j8XdQN8KujQhOSSIgeWBJU/NFHvvGVl
         M+9RRNWouo66khugMtnjIF7noCEpR/7CpZFR3JfIyZv+E9MRI7ElnB58Lhk+DHE+9zWL
         zK57D/IMfglbI13xM68t7iMxVH5mJ46Sb2IxhLoHxx498ykwYEM61jQp1eE8J+vlV/yR
         7t3QuWUrejUPcSL1+JT8XBVVZmf+O67AfMCoErxldZFqUsd38X/QqJQS+DbGtYImuNlg
         CNfXp+aQnUB9Tn9VqHN1VPXx1K2WDKVMc3rw8/Nt1ti2k4/Ip3YxUDxnOkrfOXrl6Q20
         zcqg==
X-Gm-Message-State: AOAM53051HwO6nAc7Giiv4p9uiHvXGxamwCOJ1cF5XMsUFlF1D5X/Gyv
        aKfQfh9shuAKrLNCKdLhxcfasWNlGQYWTA==
X-Google-Smtp-Source: ABdhPJxWs1POLe9XntCkGcT4PCfpNjWtYL2TykZSG9BUvhctT3zTIiTfEHqOTthLmqOCbiWXT0UUcg==
X-Received: by 2002:a63:243:: with SMTP id 64mr3811160pgc.117.1643311033189;
        Thu, 27 Jan 2022 11:17:13 -0800 (PST)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id lb3sm99570pjb.47.2022.01.27.11.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 11:17:12 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        chrome-platform@lists.linux.dev (open list:CHROMEOS EC USB TYPE-C
        DRIVER), Guenter Roeck <groeck@chromium.org>
Subject: [PATCH] platform/chrome: cros_ec_typec: Make try power role optional
Date:   Thu, 27 Jan 2022 19:16:59 +0000
Message-Id: <20220127191659.3560810-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some boards prefer not to specify a try-power-role. Update the port
property parsing logic to not error out in case a try-power-role is not
specified.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 5de0bfb0bc4d..ee12658009e5 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -115,17 +115,18 @@ static int cros_typec_parse_port_props(struct typec_capability *cap,
 		return ret;
 	cap->data = ret;
 
+	/* Try-power-role is optional. */
 	ret = fwnode_property_read_string(fwnode, "try-power-role", &buf);
 	if (ret) {
-		dev_err(dev, "try-power-role not found: %d\n", ret);
-		return ret;
+		dev_warn(dev, "try-power-role not found: %d\n", ret);
+		cap->prefer_role = TYPEC_NO_PREFERRED_ROLE;
+	} else {
+		ret = typec_find_power_role(buf);
+		if (ret < 0)
+			return ret;
+		cap->prefer_role = ret;
 	}
 
-	ret = typec_find_power_role(buf);
-	if (ret < 0)
-		return ret;
-	cap->prefer_role = ret;
-
 	cap->fwnode = fwnode;
 
 	return 0;
-- 
2.35.0.rc0.227.g00780c9af4-goog

