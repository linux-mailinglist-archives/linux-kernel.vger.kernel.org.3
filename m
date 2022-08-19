Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A6759A624
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351143AbiHSTIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351066AbiHSTIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:08:25 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F56C2A412
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:08:23 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id j1so240694pjg.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=tlVqcJR2RWJzIVx+j8QXqXkEF4w+7JdP2qYqCLd2xU4=;
        b=MTI4vdwl4gqRh60KksQSrtWRv3xKQhL4y0uyrbG6EjptfSnhYcS/a2IpoCAADgnsj3
         /UA8bAe96gCub5qyGe1JCpglsSCvv8stYJ71yjXiPbOm1hQq8V5KlyMXspDtHeEdtetG
         6C3hMAN05XCtZ7qvcPGFYqj4O39JqGpaHzHEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=tlVqcJR2RWJzIVx+j8QXqXkEF4w+7JdP2qYqCLd2xU4=;
        b=NHNyQ8IrZrKxwcfP2NOSgK6pxkcR2iFj5u/9pC1em8boAcUBSnJjteQCw1NXUwpFAL
         8pe9g7YSOiQ9mNKGueVRaibfP7HsJrEdpSewaJQZlbiEaGT91FcH3lc7cC5rQ9hWXVXF
         PzW1n9j0OXAJeqydz19zagM3ewGKsrQw+bQt9xKiIu1cj+VKwaX/1EZMrEbitZ4dq33a
         VJKdtwxDSfO6ObHeS9XqJbmUGHSWxev4X5lFsHaaWHQ6N0KlciWuY99DbFTSAkJWhgeS
         1rYqv/pfr21x7KikUufT7B2ZtunLxQ2kQlAEALrbTFIVxLq5i02kMHxiTAU6cPrcMQmk
         ZTYA==
X-Gm-Message-State: ACgBeo090mBrBBs9revmQK3V3iq7a4exRELkXKpU8Egm9tJsb+vVFlgX
        upB+Kjrb8cTLbcTsqVBFp8qBRYAJPXI3cg==
X-Google-Smtp-Source: AA6agR7nsL+lGm9wkhClhGQEYjdyYIzCzzJ7BrY20bzxN4eaO+k5+HpggVpEqvpCtXksK6OiKfxxig==
X-Received: by 2002:a17:902:b483:b0:170:a89f:32b3 with SMTP id y3-20020a170902b48300b00170a89f32b3mr8695426plr.149.1660936102550;
        Fri, 19 Aug 2022 12:08:22 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id b14-20020a170903228e00b00172a567d910sm3499775plh.289.2022.08.19.12.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:08:22 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 1/4] platform/chrome: cros_ec_typec: Add bit offset for DP VDO
Date:   Fri, 19 Aug 2022 19:08:02 +0000
Message-Id: <20220819190807.1275937-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220819190807.1275937-1-pmalani@chromium.org>
References: <20220819190807.1275937-1-pmalani@chromium.org>
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

Use the right macro while constructing the DP_PORT_VDO to ensure the Pin
Assignment offsets are correct.

Fixes: 1ff5d97f070c ("platform/chrome: cros_ec_typec: Register port altmodes")
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index de6ee0f926a6..4d81d8d45b73 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -25,7 +25,8 @@
 
 #define DRV_NAME "cros-ec-typec"
 
-#define DP_PORT_VDO	(BIT(DP_PIN_ASSIGN_C) | BIT(DP_PIN_ASSIGN_D) | DP_CAP_DFP_D)
+#define DP_PORT_VDO	(DP_CONF_SET_PIN_ASSIGN(BIT(DP_PIN_ASSIGN_C) | BIT(DP_PIN_ASSIGN_D)) | \
+				DP_CAP_DFP_D)
 
 /* Supported alt modes. */
 enum {
-- 
2.37.1.595.g718a3a8f04-goog

