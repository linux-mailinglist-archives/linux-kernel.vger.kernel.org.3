Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434D64B15CE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343708AbiBJTFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:05:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343639AbiBJTE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:04:56 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C6F101C;
        Thu, 10 Feb 2022 11:04:57 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d27so11285454wrc.6;
        Thu, 10 Feb 2022 11:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/bUjkAoGmX2Zqi1ukJ2KlNTT2xXfzfE5qe09S4uZ1wY=;
        b=Cl5lcgI0Zg832TiBScaF9MHoC5PnobHknIGbMhcY4SqKqOxhJ47rMOA3BGAeploEge
         3RubnvdFsSTc1JxAfbt5/HNnnzCzHaIIj91OeMkFgoSkURS2dNpbb4H9CR4Zb7k62dzp
         EQfryhLeFMPm6KM7nABOeSXWCTfeA9rR/hcfjj/+hUajqIDVZKBEuWt/8WFF67LaMyxy
         raW/n8eskUbGC23BQ+E+oqPbNUte16S1xgIkDFtgrAk5HJmK0crQimg5GN+tmRsVCdZ5
         GeH6bNnOfAO5n2YvWyhhKJVeUx2RlIOxu9JJNVaMkTDVVxhR5dp8TXTeijQu/fciSBcu
         TGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/bUjkAoGmX2Zqi1ukJ2KlNTT2xXfzfE5qe09S4uZ1wY=;
        b=bbyKeTAG4uZ8NBRzGFUs+SbFOBcQ5cQfyAFMWDwu9COU1Ge3s5kPp1dNYY34t9sitL
         oPPt17rPIOR+Ek84dH9mNAD3Ws0wPPEPCIJmtGHL5tqULY4A4LjjJaMGX4Y1r8kMLXSd
         mSN4AtXvBvGqw53Gj5BUcpM7yWfGHXlVyaCQEn6RAB9oJU913lfPF7LONvIE0WrjDAIC
         4I6NEHNyYzVQWJ+hPWruXDm9Eki2Y5ghFN9cN/qxBJuWJHcSyYXA3nMqJZ0UVmmY0ChT
         mFeYApzDu8i67tFw+xn3CvHngAaruMIvcfx7XY9YaFLgiQu5ce0DmNEQcSsyLON8I4pK
         89/g==
X-Gm-Message-State: AOAM5300QgdhKqSj/gchTIiffylGTnMkcsQAbB8R+JDIqewBrC+X0Weu
        KX/72p37IS2xC1/n2AC/qzE=
X-Google-Smtp-Source: ABdhPJx2S3NdfZg3QtmUIU9xyhIwzINEcHfnOGC7ZXhHAP5460Iqj1yI+Lxx0rFTj0zGp0BxW9pEZQ==
X-Received: by 2002:a5d:54d0:: with SMTP id x16mr5862417wrv.280.1644519896011;
        Thu, 10 Feb 2022 11:04:56 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id o10sm21794816wri.19.2022.02.10.11.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:04:55 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 7/7] HID: uclogic: Handle virtual frame reports
Date:   Thu, 10 Feb 2022 20:04:37 +0100
Message-Id: <20220210190437.50152-8-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220210190437.50152-1-jose.exposito89@gmail.com>
References: <20220210190437.50152-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolai Kondrashov <spbnick@gmail.com>

Explicitly change report ID to virtual ID and handle virtual frame
reports as real for consistency.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 8aac3f7a9cda..73d79d149869 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -365,6 +365,7 @@ static int uclogic_raw_event(struct hid_device *hdev,
 				struct hid_report *report,
 				u8 *data, int size)
 {
+	unsigned int report_id = report->id;
 	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
 	struct uclogic_params *params = &drvdata->params;
 
@@ -374,20 +375,20 @@ static int uclogic_raw_event(struct hid_device *hdev,
 
 	/* Tweak pen reports, if necessary */
 	if (!params->pen_unused &&
-	    (report->id == params->pen.id) &&
+	    (report_id == params->pen.id) &&
 	    (size >= 2)) {
 		/* If it's the "virtual" frame controls report */
 		if (params->frame.id != 0 &&
 		    data[1] & params->pen_frame_flag) {
 			/* Change to virtual frame controls report ID */
-			data[0] = params->frame.id;
-			return 0;
+			report_id = data[0] = params->frame.id;
+		} else {
+			return uclogic_raw_event_pen(drvdata, data, size);
 		}
-		return uclogic_raw_event_pen(drvdata, data, size);
 	}
 
 	/* Tweak frame control reports, if necessary */
-	if (report->id == params->frame.id)
+	if (report_id == params->frame.id)
 		return uclogic_raw_event_frame(drvdata, data, size);
 
 	return 0;
-- 
2.25.1

