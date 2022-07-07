Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F270B56AE5F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbiGGW1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236573AbiGGW1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:27:12 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0620865D53
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 15:27:11 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 70so6891382pfx.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 15:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HWZjQkLUf6qk+G+fYBQqj9gsWBV3+/ITHeFpM/SM9wo=;
        b=ixoq2AkyRxuboKSJKZx8muAfii9lRyEyzUS7IFt5M7B/IMVJjo9CY9WhHpxlS674W3
         3z+yGgk1ivWbkvzY1w7ar5/W0LICNY6nxFr+x1karg5PUrxrZL18qEI43CHgT4aIhLU4
         LIrSEeiIrXEMfbdNzDD6tuaXHUxvyiznfkyZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HWZjQkLUf6qk+G+fYBQqj9gsWBV3+/ITHeFpM/SM9wo=;
        b=2GuWmJt52cD1+Y/kD7v1RVj5C5iwMPpYzD5jY3JlXM7kEBT+gGYgKpVBV8vHJHM+Qa
         dpHPQgjZKpbyjFipMivNjrIpcvSGyB7ci2I3XvQ5BX1vFMfCzaGkEcB4PBZtsHe/ObE0
         wSgPQopiydvnbYNQDmO0/3B5vWbe3TsXaz+PKXl802j8n/Wru3qfmiM06BYQ6C8l92XR
         erM5Ba88MCDKbmehoEgSgObfshTu63e5lRklv1MmT3j/nbNDzw44uyrgJdOPDz+7bp0B
         iMq48aL82KzgV7t3s3tMROyPVXI01o3L21PcGF8Z+wjwsHh9G1r/eq+HVXX3B2/urXug
         Q8/w==
X-Gm-Message-State: AJIora/d+VxLgpt8RgG5EZ7je+S/ug6vsNgUEP8Cw8uaQCdG2Ms8kg1+
        YuQkvEXNh+W9kt9pjPC96HNaSyq1j01+1A==
X-Google-Smtp-Source: AGRyM1vw7KYRt0Y5e064i6OXHvQrKKt7U3rCYM4QH9TVNn7L62a4a+W9UcU9HuwSNJmdWTrWyRlCSQ==
X-Received: by 2002:a65:5b44:0:b0:412:b6dc:7076 with SMTP id y4-20020a655b44000000b00412b6dc7076mr270918pgr.601.1657232830357;
        Thu, 07 Jul 2022 15:27:10 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 66-20020a620445000000b005289bfcee91sm5545657pfe.59.2022.07.07.15.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 15:27:10 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        chrome-platform@lists.linux.dev
Cc:     bleung@chromium.org, heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v3 8/9] platform/chrome: cros_ec_typec: Cleanup switch handle return paths
Date:   Thu,  7 Jul 2022 22:20:15 +0000
Message-Id: <20220707222045.1415417-9-pmalani@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220707222045.1415417-1-pmalani@chromium.org>
References: <20220707222045.1415417-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the return paths for the cros_typec_get_switch_handles()
aren't necessary. Clean up the return paths to only undo the handle
get's which succeeded.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes since v2:
- No changes.

Changes since v1:
- No changes.

 drivers/platform/chrome/cros_ec_typec.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 7cb2e35c4ded..39e6fd4491a9 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -157,12 +157,10 @@ static int cros_typec_get_switch_handles(struct cros_typec_port *port,
 	return 0;
 
 role_sw_err:
-	usb_role_switch_put(port->role_sw);
-ori_sw_err:
 	typec_switch_put(port->ori_sw);
-mux_err:
+ori_sw_err:
 	typec_mux_put(port->mux);
-
+mux_err:
 	return -ENODEV;
 }
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

