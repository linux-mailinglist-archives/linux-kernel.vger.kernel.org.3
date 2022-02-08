Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D945C4AE162
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385481AbiBHSsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385472AbiBHSs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:48:29 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F95DC0612C2
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:48:28 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id y17so121347plg.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 10:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3nJw75yUn0Ak2LbjP8FDSUKGk9cBjMNSHZr8K3rv/n8=;
        b=Kcc50LqTHuQIYf273mHplhXaUKkVZo5PUBRoSWfRcf58iiGQ2BqdIdG45EwyPs1uXs
         CAAbXNkEd2gr6pK4HN7DiQh4qUIHHNlorxb+wH1BXIOdeK6oQxUKyLl5QTwejhLKNtmR
         CteLOdhUCS5CWbC0mzNmxIdXJAHtmnBxfT90k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3nJw75yUn0Ak2LbjP8FDSUKGk9cBjMNSHZr8K3rv/n8=;
        b=vo8E//jxoAnG+SOHjuTzR/ka2ICwpmXEmvCTE5P9GXxlSV4e8ldlbDhF9qa5M3Nzg1
         F5WrVxeId0TbupCKC38E0xv6WKZnUw9XImPiOJx7w+Xh136kq4JpA8AXDDWE/BKVglPg
         2Kuo1KgUZq8u374Q7jEStxbr5ybTjtpni+etGqn/fdAh4nn7qx+GDEv2CKuREiGSBK23
         WgyalZI2ZeD/FsJtZvZFZ8FZwCdlsZ7cQ7hyxrIAltJwJ4eUWPM7+LcLjM4jwy+4n5Du
         89sXVIYA2VHLXvpiDDqYk2VYvR4GE+BRfZUrJdFAlEj7XL2ydc7gbVZWUjMYciXZxKNV
         b2QA==
X-Gm-Message-State: AOAM532ngBi9hOgsUbedftC8B28vNt8JoxNihjJxRl3oqZOggVHam5jR
        WML7zhcUINRnVhPSZ0vB23h/0LgDMfqG4Q==
X-Google-Smtp-Source: ABdhPJzUwlOAtGq+Y2cBB0fnuRDAYTc8P/abuAm1YmIdSlVd7T3zol+qZiMELS+dYrh3y9do6LWUBA==
X-Received: by 2002:a17:90b:4c91:: with SMTP id my17mr2870441pjb.121.1644346107948;
        Tue, 08 Feb 2022 10:48:27 -0800 (PST)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id gk15sm3594453pjb.3.2022.02.08.10.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:48:27 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev (open list:CHROMEOS EC USB TYPE-C
        DRIVER)
Subject: [PATCH v2 4/4] platform/chrome: cros_ec_typec: Update mux flags during partner removal
Date:   Tue,  8 Feb 2022 18:47:24 +0000
Message-Id: <20220208184721.1697194-5-pmalani@chromium.org>
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

In cros_typec_remove_partner(), we call
cros_typec_usb_disconnect_state() which sets the switches/muxes to be in
a disconnected state. This also happens in cros_typec_configure_mux().
However, unlike there, here the mux_flags variable hasn't been updated
to reflect that a disconnection has occurred. Update the flag here
accordingly.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- No changes.

 drivers/platform/chrome/cros_ec_typec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 3019e29f200d..4bd2752c0823 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -228,6 +228,7 @@ static void cros_typec_remove_partner(struct cros_typec_data *typec,
 	cros_typec_unregister_altmodes(typec, port_num, true);
 
 	cros_typec_usb_disconnect_state(port);
+	port->mux_flags = USB_PD_MUX_NONE;
 
 	typec_unregister_partner(port->partner);
 	port->partner = NULL;
-- 
2.35.0.263.gb82422642f-goog

