Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F41515506
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 21:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380464AbiD2UBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380455AbiD2UBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:01:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEFC286D1;
        Fri, 29 Apr 2022 12:57:58 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id bi24-20020a05600c3d9800b00393ff664705so5316907wmb.4;
        Fri, 29 Apr 2022 12:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ARvkbAgMRVMH7yoCqO4w4jgnA6iB3llwc7XTSb32ZTk=;
        b=C10SkuwQo3GxuX/CMoJUiM2/UQdHqbm4x5l43pCW1MrxnfeHnTx51WZ7O1v7bDJ37B
         IY3ajfotlY22+CIYrMiq6rV/Y20jaQ/Tc1wQnaXIpbSH7z/rrJ/ZpHVsr3v1UjEqIA4v
         CFcG+H1fTOloPbDbey02E8OWeNbzAoqLZPn1/Wvga3QSGhac2TOI2Sl3/0IxdpGLf8k3
         uAdy06uk0sGB1COThB5eadXktEZqRw44hVdI49EL9+cKuY559qmK8soMlVMFuX+fIzgn
         c0lHtOKDgbb7QMqYhyRzB+L1NuPgAY5UcGrSDEfaIRdicmAhmjU1wmN+zv98M9sdztuX
         wJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ARvkbAgMRVMH7yoCqO4w4jgnA6iB3llwc7XTSb32ZTk=;
        b=Z7uxKrZHIjUCW1pX9dHoLzMR2px/WluDL/6UyP1rS4FyebzoaKgCqvlaVVKIboMA9W
         CQXPIDtBipS+9ND497OQjgaWyRLt5h3WFzsp3Mu9deM/L1nBv9LSxUmrr36yfUS/Ldew
         VM1ohVwbpChTFBaMPuVpbs3mWtYXD8ZBa9OX+boHSYR+RcDn/zcyTzz72QXZZi+eG4lB
         m3/84aoKYVtnBGccmJpVfyH484PmI77IoVjrGZL+WZeTI8heK8M3AQKjWL5JkT5husYF
         kMD06pNJu0aKJq25CCdDfV+0IG7FkDH4AyO+EfpSjdZuZescCiy1OSgb84T/5D4zhLI5
         jMug==
X-Gm-Message-State: AOAM533GVnbEN22BopOhpg933fjcZrHOKoAfAh8yrYwXlNLbybwsGSqN
        O6iW8x5B+pkgtfYlxmdkUbI=
X-Google-Smtp-Source: ABdhPJyz4v8SrbAvXMoxUl5IcCPAf9Yr6DflSABwHhRFpGZUKBs5BUW1/VNc602PTUUN58lSBxN7Wg==
X-Received: by 2002:a05:600c:4f95:b0:393:ec32:d85f with SMTP id n21-20020a05600c4f9500b00393ec32d85fmr4598569wmq.149.1651262276779;
        Fri, 29 Apr 2022 12:57:56 -0700 (PDT)
Received: from xws.localdomain ([194.126.177.12])
        by smtp.gmail.com with ESMTPSA id c2-20020adfc042000000b0020c5253d8e5sm105461wrf.49.2022.04.29.12.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 12:57:56 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>
Subject: [PATCH] platform/surface: aggregator: Fix initialization order when compiling as builtin module
Date:   Fri, 29 Apr 2022 21:57:38 +0200
Message-Id: <20220429195738.535751-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building the Surface Aggregator Module (SAM) core, registry, and
other SAM client drivers as builtin modules (=y), proper initialization
order is not guaranteed. Due to this, client driver registration
(triggered by device registration in the registry) races against bus
initialization in the core.

If any attempt is made at registering the device driver before the bus
has been initialized (i.e. if bus initialization fails this race) driver
registration will fail with a message similar to:

    Driver surface_battery was unable to register with bus_type surface_aggregator because the bus was not initialized

Switch from module_init() to subsys_initcall() to resolve this issue.
Note that the serdev subsystem uses postcore_initcall() so we are still
able to safely register the serdev device driver for the core.

Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
Reported-by: Blaž Hrastnik <blaz@mxxn.io>
Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/aggregator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/surface/aggregator/core.c b/drivers/platform/surface/aggregator/core.c
index d384d36098c2..a62c5dfe42d6 100644
--- a/drivers/platform/surface/aggregator/core.c
+++ b/drivers/platform/surface/aggregator/core.c
@@ -817,7 +817,7 @@ static int __init ssam_core_init(void)
 err_bus:
 	return status;
 }
-module_init(ssam_core_init);
+subsys_initcall(ssam_core_init);
 
 static void __exit ssam_core_exit(void)
 {
-- 
2.36.0

