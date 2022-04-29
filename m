Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A0E515277
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 19:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379760AbiD2Ro7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 13:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379753AbiD2Rov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:44:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6965BA27D9;
        Fri, 29 Apr 2022 10:41:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so6817658wmj.1;
        Fri, 29 Apr 2022 10:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZbduflGai2BniQyEKChWvgw5Vbl22wyDBPYLOeD9fFE=;
        b=bSYN+B3h2mAeBcH3seOMQdUjesImu5IKiQxaWNE41w9Ju3YhzkXQnQhmcJhGN5Hf6V
         /gNkzLUOFK9RypYZA9N4rXeDdNDk4FD27/N2hepvIpMEh8JD0q8KorkElnFGPGq8P5eg
         vj4azpAnhkloekBwwrZExm4ggXkxmYOv3mfY4LWNP0QQc8YcWd1PrGsF9B0/mY44PBN2
         TpY9XaI9R8Nd8CrabcnLEZrZxBshWhODKsHNHbWRQqPtPX0Pcmv7f5T9eXEJ3Jk2f7dV
         k8UTOx55qRFyb2ECcDiqvbomkf8UMPCU8UJMxOFa6Me58BbJIQOBPMGeajZfkIZ+8guA
         SnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZbduflGai2BniQyEKChWvgw5Vbl22wyDBPYLOeD9fFE=;
        b=ueKVN23/cDM5OQy5UuJeZUhV70Avj0I7ffTORc26rqrjDEk97q78fHJfdM74T60uUD
         oopKQ3MFQBaWH0ZnfZ45mh6hotW2KUjH/QJrJrHgtZNFnx2Q7a0hodGzd6x0GjKen+pV
         bLg/R9GRIyV7HR2RYPQkuT0dQDErRj3KYyYuB5Qg4EDgpPFeCe9h3ixwje9gZdGufysG
         Ofmz8uRvfxJf8g6nBlF0Rb35wXMvhCwCASfU0b7DFCNJhMqyzJqvdypsmlmObhESkJTZ
         /zSjpyLLVtEjK5bwDRMMJPwa955utgCwMrB1bEkFeIikiRHSsnwYVgRnS6EdTLbE9Pyw
         C4PA==
X-Gm-Message-State: AOAM5328hJ4YWln4R+C2P52v6LXnMrjkqUjlP2RO0YI+9jVjynj3rmrf
        ESvRZN78PMNduRhBJUvRh/M=
X-Google-Smtp-Source: ABdhPJxKKYWRWQ5S5qJEUM3jnZxQocd2utbbzGJklRN0c6SAjPtGyPeIE/Q1l5iPcDmbp5WvkMqSUQ==
X-Received: by 2002:a05:600c:348c:b0:392:990b:cf98 with SMTP id a12-20020a05600c348c00b00392990bcf98mr4225842wmq.194.1651254090842;
        Fri, 29 Apr 2022 10:41:30 -0700 (PDT)
Received: from xws.localdomain (pd9e5acba.dip0.t-ipconnect.de. [217.229.172.186])
        by smtp.gmail.com with ESMTPSA id k28-20020a05600c1c9c00b0039424a07762sm1239921wms.35.2022.04.29.10.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 10:41:29 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: battery: Add "Not Charging" quirk for Microsoft Surface devices
Date:   Fri, 29 Apr 2022 19:41:14 +0200
Message-Id: <20220429174114.1277799-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
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

Microsoft Surface devices have a limiter that sets a fixed maximum
charge capacity for the battery. When that maximum capacity has been
reached, charging stops. In that case, _BST returns a battery state
field with both "charging" and "discharging" bits cleared. The battery
driver, however, returns "unknown" as status.

This seems to be the same behavior as observed on the ThinkPads, so
let's use the same quirk to handle that.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

For what it's worth, I don't think the ACPI spec explicitly states that
any of the status bits need to be set, or that there are only the
"charging" and "discharging" states. As far as I can tell, ACPI only
states:

    Notice that the Charging bit and the Discharging bit are mutually
    exclusive and must not both be set at the same time. Even in
    critical state, hardware should report the corresponding
    charging/discharging state.

But that does not exclude the case that no bit is set. So, strictly
going by spec, I don't think it's necessary to put all of this behind a
quirk.

---
 drivers/acpi/battery.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index dc208f5f5a1f..1c88504aae5b 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1152,6 +1152,19 @@ static const struct dmi_system_id bat_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad"),
 		},
 	},
+	{
+		/*
+		 * Microsoft Surface devices have an optional "battery
+		 * limiter". Due to this, there is a "Not Charging" state
+		 * similar to the one on the Lenovo ThinkPads, described above.
+		 */
+		.callback = battery_quirk_not_charging,
+		.ident = "Microsoft Surface",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Surface"),
+		},
+	},
 	{
 		/* Microsoft Surface Go 3 */
 		.callback = battery_notification_delay_quirk,
-- 
2.36.0

