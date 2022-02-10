Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E013D4B15D0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 20:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343700AbiBJTFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 14:05:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343640AbiBJTEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 14:04:55 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48DA10B7;
        Thu, 10 Feb 2022 11:04:55 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so4654278wml.5;
        Thu, 10 Feb 2022 11:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h0dKpXxaUtAsD11niFXfJyE8HvZXdWYUwT2HA9JjgyI=;
        b=VwrPBLS3kvrDNJso5J6IkeGM0czo59+D+dJC6JI5qtcQdximtABtnahFiEWapGe2WX
         aILjfkrLG9+/j+W9lDzBiSRufUZOoq/Hm9P6BMTy/YgkduEER8A+jQR81NMUvGxPk7Tf
         pROQCoKUEXW8WawtTv3GhJt5id/+Kp4b1+mGOeeeBUTUNEv0BAs82ggQmSy0f4oQe62A
         TnUiUK1J0Kq3ZuicPnQDrtJVvVqgPFI9QZytCg8Qbc4OPLPX+YNCQ6H5Ne4l2yk4npg4
         usOJGk2LS6t4DttOe4W5OHy5uChojj7kOU2XQpitI4AGKReW535goe622h3dT9UoJD1Q
         1Spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h0dKpXxaUtAsD11niFXfJyE8HvZXdWYUwT2HA9JjgyI=;
        b=2Z2AsMC16LNjZVuLeLKe2ClZ23HbVJPFxlKI+O2A4VR8brJYvzBtQRB+0EmwHafACs
         0LF6XTAeFw+hS4Qws6IVBXQxaT2etS01nTAEy5CtZt6atvaHzQHdCfXT3BlOAOU6PfUl
         Rn+qDQ3eFArhI8AY/PwVEOl+Ua6qbzOb1oMRS0QVTsF17/q/8UpczmMtZ9JL68SfCtMM
         NG8/F3uNIzu2fO1uvei5kQ9IvWkpll4OVxMkxsm1A9SNuI2wtK7qjr+h+hB3tZ7sayd5
         kCiLIP6ugjSr764iGLvHqXBHTA1b3yQvMtXdwh2n5zZWdsVwAZYI2WoiyUfklvjQcJXN
         xzbQ==
X-Gm-Message-State: AOAM531Ssw/tEELCBtAFNT7cIokFsgyvIY7c7uoxPKb6ooFg3CDXNX8H
        i73AQd/ntsq5x/CYjxPo1XDrK8QCOG9zlA==
X-Google-Smtp-Source: ABdhPJxd7cJISj2v0Z3mMR3BqsrxrGgPS9TkulmWg4EEppHoA6rt9ERKIaIuFGbtQvt7heulhYmORQ==
X-Received: by 2002:a05:600c:35c8:: with SMTP id r8mr3329529wmq.142.1644519894480;
        Thu, 10 Feb 2022 11:04:54 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id o10sm21794816wri.19.2022.02.10.11.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 11:04:54 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 5/7] HID: uclogic: Access pen/frame params directly in raw_event handling
Date:   Thu, 10 Feb 2022 20:04:35 +0100
Message-Id: <20220210190437.50152-6-jose.exposito89@gmail.com>
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

Simplify the raw event handling code by accessing the
uclogic_params_pen/uclogic_params_frame structs directly.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-core.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 9187fd835a46..56b76d9b46af 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -259,13 +259,13 @@ static int uclogic_resume(struct hid_device *hdev)
 static int uclogic_raw_event_pen(struct uclogic_drvdata *drvdata,
 					u8 *data, int size)
 {
-	struct uclogic_params *params = &drvdata->params;
+	struct uclogic_params_pen *pen = &drvdata->params.pen;
 
 	WARN_ON(drvdata == NULL);
 	WARN_ON(data == NULL && size != 0);
 
 	/* If in-range reports are inverted */
-	if (params->pen.inrange ==
+	if (pen->inrange ==
 		UCLOGIC_PARAMS_PEN_INRANGE_INVERTED) {
 		/* Invert the in-range bit */
 		data[1] ^= 0x40;
@@ -274,7 +274,7 @@ static int uclogic_raw_event_pen(struct uclogic_drvdata *drvdata,
 	 * If report contains fragmented high-resolution pen
 	 * coordinates
 	 */
-	if (size >= 10 && params->pen.fragmented_hires) {
+	if (size >= 10 && pen->fragmented_hires) {
 		u8 pressure_low_byte;
 		u8 pressure_high_byte;
 
@@ -296,7 +296,7 @@ static int uclogic_raw_event_pen(struct uclogic_drvdata *drvdata,
 		data[9] = pressure_high_byte;
 	}
 	/* If we need to emulate in-range detection */
-	if (params->pen.inrange == UCLOGIC_PARAMS_PEN_INRANGE_NONE) {
+	if (pen->inrange == UCLOGIC_PARAMS_PEN_INRANGE_NONE) {
 		/* Set in-range bit */
 		data[1] |= 0x40;
 		/* (Re-)start in-range timeout */
@@ -304,7 +304,7 @@ static int uclogic_raw_event_pen(struct uclogic_drvdata *drvdata,
 				jiffies + msecs_to_jiffies(100));
 	}
 	/* If we report tilt and Y direction is flipped */
-	if (size >= 12 && params->pen.tilt_y_flipped)
+	if (size >= 12 && pen->tilt_y_flipped)
 		data[11] = -data[11];
 
 	return 0;
@@ -323,21 +323,19 @@ static int uclogic_raw_event_pen(struct uclogic_drvdata *drvdata,
 static int uclogic_raw_event_frame(struct uclogic_drvdata *drvdata,
 					u8 *data, int size)
 {
-	struct uclogic_params *params = &drvdata->params;
+	struct uclogic_params_frame *frame = &drvdata->params.frame;
 
 	WARN_ON(drvdata == NULL);
 	WARN_ON(data == NULL && size != 0);
 
 	/* If need to, and can, set pad device ID for Wacom drivers */
-	if (params->frame.dev_id_byte > 0 &&
-	    params->frame.dev_id_byte < size) {
-		data[params->frame.dev_id_byte] = 0xf;
+	if (frame->dev_id_byte > 0 && frame->dev_id_byte < size) {
+		data[frame->dev_id_byte] = 0xf;
 	}
 	/* If need to, and can, read rotary encoder state change */
-	if (params->frame.re_lsb > 0 &&
-	    params->frame.re_lsb / 8 < size) {
-		unsigned int byte = params->frame.re_lsb / 8;
-		unsigned int bit = params->frame.re_lsb % 8;
+	if (frame->re_lsb > 0 && frame->re_lsb / 8 < size) {
+		unsigned int byte = frame->re_lsb / 8;
+		unsigned int bit = frame->re_lsb % 8;
 
 		u8 change;
 		u8 prev_state = drvdata->re_state;
-- 
2.25.1

