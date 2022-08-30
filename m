Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDBB5A718E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbiH3XRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiH3XQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:16:46 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286C66B8C6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:19 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z72so10575137iof.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=A3xTTsKZx/5fCLbOqrazlesBJJTiVoLwUz/jQe2gDwc=;
        b=enSBMG0ikj2KVRid8ICGNrBLNn4mDnrczn9UDKjUzxD0GnYzzrVpmDo/yOottmAKUw
         XdEytm0iTECUDxcQ0+a1t9pT8bZ6J1CZu3ZbUx2DQN0kMjOfgMXHg7iAQIHXcXHVo8No
         x6/2xXo1E8a9bvUwMSSh9HPbQmCHsO5YiLHWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=A3xTTsKZx/5fCLbOqrazlesBJJTiVoLwUz/jQe2gDwc=;
        b=fV8pdaH5ib3HdewnA6ddIN8KZlc5XMqio8P6LtQEhaxyfTrXtQJoWkcm2U4HXrcWPD
         k0kezsQ3F+Y24E4QqMeVX2u+nlgB9k3EknKgDppFGhvpHO9VjM7VLuMicZ1GMxLGOK7p
         RXgh/08I/0jTauNUiPApblHm1YcRd0S6b/DH5jawzzZQw9URwsJ1QR5o6Ve7i85gimBq
         B5nV/kvXPizOIafi3i6AF6CdEPOq5rTrtE3xL51IoGiH+fOCNO5PzmGawi0tWzx9mZED
         FPkBU1pxbP4dTChO76GdbTany9eiuEmPa3I8Ob9fWtHjmgImjhxXvPsHfXOoQuoP480Z
         eRKw==
X-Gm-Message-State: ACgBeo0A6FNU+nG9D4DJCsam1HFBs8kqvEG9kIYwIsbXLUWuierdCe8D
        Zx6zzMY82hmGd7cDG/q3a9g9ew==
X-Google-Smtp-Source: AA6agR6sWZgtFPbmAA1vaJWYl2qtrzuw360jdq0jUvuVKES+v1H37eSeKRiCfPEp7nZSSmyKKOGZYA==
X-Received: by 2002:a05:6638:130c:b0:343:5bc5:7a45 with SMTP id r12-20020a056638130c00b003435bc57a45mr14017254jad.250.1661901378747;
        Tue, 30 Aug 2022 16:16:18 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id z30-20020a056602081e00b0068b1858c81asm6165821iow.13.2022.08.30.16.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 16:16:18 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     hdegoede@redhat.com, mario.limonciello@amd.com, timvp@google.com,
        rafael@kernel.org, Raul E Rangel <rrangel@chromium.org>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] ACPI: PM: Take wake IRQ into consideration when entering suspend-to-idle
Date:   Tue, 30 Aug 2022 17:15:41 -0600
Message-Id: <20220830171332.8.I7d9202463f08373feccd6e8fd87482c4f40ece5d@changeid>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
In-Reply-To: <20220830231541.1135813-1-rrangel@chromium.org>
References: <20220830231541.1135813-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds support for ACPI devices that use ExclusiveAndWake or
SharedAndWake in their _CRS GpioInt definition (instead of using _PRW),
and also provide power resources. Previously the ACPI subsystem had no
idea if the device had a wake capable interrupt armed. This resulted
in the ACPI device PM system placing the device into D3Cold, and thus
cutting power to the device. With this change we will now query the
_S0W method to figure out the appropriate wake capable D-state.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/acpi/device_pm.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 9dce1245689ca2..6bc81f525d5160 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -681,8 +681,23 @@ static int acpi_dev_pm_get_state(struct device *dev, struct acpi_device *adev,
 		d_min = ret;
 		wakeup = device_may_wakeup(dev) && adev->wakeup.flags.valid
 			&& adev->wakeup.sleep_state >= target_state;
-	} else {
-		wakeup = adev->wakeup.flags.valid;
+	} else if (acpi_device_can_wakeup(adev)) {
+		/* ACPI GPE from specified by _PRW. */
+		wakeup = true;
+	} else if (device_may_wakeup(dev) && dev->power.wakeirq) {
+		/*
+		 * The ACPI subsystem doesn't manage the wake bit for IRQs
+		 * defined with ExclusiveAndWake and SharedAndWake. Instead we
+		 * expect them to be managed via the PM subsystem. Drivers
+		 * should call dev_pm_set_wake_irq to register an IRQ as a wake
+		 * source.
+		 *
+		 * If a device has a wake IRQ attached we need to check the
+		 * _S0W method to get the correct wake D-state. Otherwise we
+		 * end up putting the device into D3Cold which will more than
+		 * likely disable wake functionality.
+		 */
+		wakeup = true;
 	}
 
 	/*
-- 
2.37.2.672.g94769d06f0-goog

