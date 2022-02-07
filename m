Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB474ACB74
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241438AbiBGVlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241431AbiBGVlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:41:42 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AF6C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:41:42 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v13-20020a17090ac90d00b001b87bc106bdso327658pjt.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 13:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s/hl0O9rqFd7bKBt/Qe/w/3MyowDWns3Oab/XTzbE6A=;
        b=OWIX7hGJb7sr/BycqGl/565lOe5WzmuzxWaEf+NxhZTIsTw/cUwFyXL5+5oz6CBGbc
         aX95wrOMhy++t4NUbmWC4EkVBiqP3BebTj5kmifMoxuwB9x+WJIwDNpf6SGPrxAmOWO/
         JQDwMJWZJbyXLgQJCdl62alITB9Ft0WuWh2LY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s/hl0O9rqFd7bKBt/Qe/w/3MyowDWns3Oab/XTzbE6A=;
        b=cPfOUV57mBHg20Zgb+D3JhHJTRJvdcK/6cYXuKJRbQWrabkWX0AP4kHd7rvYNLBgUW
         5WqSRa08sLs6Nm8bq3uG+BnYfMYQ3v/xb89OfOKcwMxCJKyZBC0sPHXlEGc0e8I3/4dx
         ziZtAALOqNnFij8VfJDuQLzW+XU2RX/jT+V3fPWZ7a9dzGy1Pa6iiotjqavv3zCqCBrP
         yvPUBhrkkv9A4ALQyjj3uI3np2YWc01I4xrNuEvPaPCvMGZiQ+o2tR0aEmA/ReGmGq6M
         e8D5ERuD7tifqkriazmB4cOTw3eDRA8kgD4DE0g0YIw6nNZfpQmg3pJ7LrJu3w/NsJGF
         wxvQ==
X-Gm-Message-State: AOAM530y2xq8gWydmDrZ7pGtS0oVSV9sPJ0QsySEqRSDBO/KvgIVNTYU
        sUctYfqMT7UdY+AjbcSEjCTYF07we/m47Q==
X-Google-Smtp-Source: ABdhPJyeEBlPmpFICFq2NN4b0ydlmQv/nNFJsYMLBjte8XvejLtZ8GQK+u74wDQefVudR8Zv6j1KGw==
X-Received: by 2002:a17:902:8f8e:: with SMTP id z14mr1601969plo.28.1644270101643;
        Mon, 07 Feb 2022 13:41:41 -0800 (PST)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s9sm9268010pgm.76.2022.02.07.13.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:41:41 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev (open list:CHROMEOS EC USB TYPE-C
        DRIVER)
Subject: [PATCH 4/4] platform/chrome: cros_ec_typec: Update mux flags during partner removal
Date:   Mon,  7 Feb 2022 21:40:30 +0000
Message-Id: <20220207214026.1526151-5-pmalani@chromium.org>
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

In cros_typec_remove_partner(), we call
cros_typec_usb_disconnect_state() which sets the switches/muxes to be in
a disconnected state. This also happens in cros_typec_configure_mux().
However, unlike there, here the mux_flags variable hasn't been updated
to reflect that a disconnection has occurred. Update the flag here
accordingly.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 164c82f537dd..ce37b6abe69f 100644
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

