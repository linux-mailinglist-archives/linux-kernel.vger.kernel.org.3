Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67EB56B3B0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237504AbiGHHkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237157AbiGHHkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:40:15 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72326B25E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 00:40:14 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a5so14677555wrx.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 00:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dv9JXEgCKOeWMiFcwfCNcrf+mbDPEpHGWcncYHXK47U=;
        b=qy5rUhBJFoOIxr1Dq8+XjF0T6TxcBTUvKvuNwwLAlk1NgLmEBarScoC2L4QaVVCSbC
         mX7201TT4x9ZZvmW2XxYL6QRCwz9xQTZtrkQgAa4xEA4HryXDaxSXdjS6CHVNZkbEOTq
         bExe0Nu2pLcoEbQFqgQwTxjKokapDaCE08FlFK0PloJqo6V8LjwVf0r4DYYtOwzFoDki
         LEZLsqz5kSnDIO3HV1ygNE/mBTAOlpSDxOibXfo+dcEvBkh6aHEuylXaRWltRZuAjMY9
         YbA1Mm0hhfrk1PTSR4IxcCaLaacJFaswvgAmRx7fivizMHswzZpAJcgnzbvVjqusksXO
         ZLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dv9JXEgCKOeWMiFcwfCNcrf+mbDPEpHGWcncYHXK47U=;
        b=dJCnAxAlg3VVwELOcNrQ3ipPgBTSySA9K61+bgB0LqGHh1OMlkfEEGRnBG4jWBLVoX
         fLu8Kaqu3zbpCeKLENQJ/OakzohNEuF8PVrJ4Vp3WzmOKBniVE82C43gMwnp/5rAfTPn
         RHvErZZ4e78OrAzEyhfktu3Yf1mRy7oOgsLJPtwSR0ljsiFWzjUuxf38eh7PWk7BxRDU
         VnnYqae22L879UCdOKwyKru3pp/S5M1CURg/E7JLq8cj6c0AK4VH8gI9gZMGsfrWIbKi
         jUNH4lQ6ajdKr/ZXriqY+aJkdhwO3D0u5MXJcxhLnOXcv4ZM8eAZW5PYuydcdxQoM4/w
         1NWw==
X-Gm-Message-State: AJIora9+pM/wJ3VO6NhxMvZv7VnJg6mXdo9jqwVfGxwVhfvTEV9pk3hM
        u1Lx/wDVz/SLOp083aaqsFObs6oZWOdn3w==
X-Google-Smtp-Source: AGRyM1ukO7Z6bP/0h93+ejhRJzyOWYZdEm5HO9OlTgLawyrlsEN7ERCeQpJ6u3SUymINxS3tor2HTA==
X-Received: by 2002:adf:f20f:0:b0:21d:6de6:6f47 with SMTP id p15-20020adff20f000000b0021d6de66f47mr1960233wro.532.1657266013364;
        Fri, 08 Jul 2022 00:40:13 -0700 (PDT)
Received: from joneslee-l.cable.virginm.net (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id r7-20020a5d4947000000b0021d221daccfsm9922661wrs.78.2022.07.08.00.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 00:40:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 1/1] HID: steam: Prevent NULL pointer dereference in steam_{recv,send}_report
Date:   Fri,  8 Jul 2022 08:40:09 +0100
Message-Id: <20220708074009.621113-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible for a malicious device to forgo submitting a Feature
Report.  The HID Steam driver presently makes no prevision for this
and de-references the 'struct hid_report' pointer obtained from the
HID devices without first checking its validity.  Let's change that.

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Fixes: c164d6abf3841 ("HID: add driver for Valve Steam Controller")
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/hid/hid-steam.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
index a3b151b29bd71..fc616db4231bb 100644
--- a/drivers/hid/hid-steam.c
+++ b/drivers/hid/hid-steam.c
@@ -134,6 +134,11 @@ static int steam_recv_report(struct steam_device *steam,
 	int ret;
 
 	r = steam->hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[0];
+	if (!r) {
+		hid_err(steam->hdev, "No HID_FEATURE_REPORT submitted -  nothing to read\n");
+		return -EINVAL;
+	}
+
 	if (hid_report_len(r) < 64)
 		return -EINVAL;
 
@@ -165,6 +170,11 @@ static int steam_send_report(struct steam_device *steam,
 	int ret;
 
 	r = steam->hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[0];
+	if (!r) {
+		hid_err(steam->hdev, "No HID_FEATURE_REPORT submitted -  nothing to read\n");
+		return -EINVAL;
+	}
+
 	if (hid_report_len(r) < 64)
 		return -EINVAL;
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

