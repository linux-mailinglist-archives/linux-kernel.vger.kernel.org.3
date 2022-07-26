Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E9458179A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbiGZQjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239485AbiGZQjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:39:35 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B4D1B78A;
        Tue, 26 Jul 2022 09:39:34 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id q18so10520324wrx.8;
        Tue, 26 Jul 2022 09:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ALxRC4P4NjmMOyYfdVkXxixEevQkN7Xh/olINwZD68=;
        b=ox3eNnzkIcobPCp+lAUG9fRpeHFU2y+Op0P71DSKT6xyACrJveg7i2CNKrv5mghAER
         gZx9APcGUnokf1II9qCqJKIVfvEmDahEQK3oDIN+HLKGu26b1welZkbi/npgKxhwo5Ag
         Tvkrbq5IQvqnQ5pFqOKSNPlO1GIBCL4Pk1wfpnHL/9vR5vcFmpMnFH5RLLv82FUrjJTw
         JTvck5cEN76M0aQCsVpG02teRK8u5wqmXvs2+k56TxNTeg2JPnvtXEBAZru/ufvjF8j9
         vVKsaYc8fSn+vcd2AysQH6UrVgcBU2ch8TYlJ2fefjQFBeR2hMg1u1Q843ib+YPj5l8f
         gKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ALxRC4P4NjmMOyYfdVkXxixEevQkN7Xh/olINwZD68=;
        b=pZzFqrNgi5ekoY/T0wtw52O1h74iKCntT2PUQvX5TE9pnyDUU8Uk4QF+oIOcm+J32J
         sB6eDDalH1Pn6laNUX02K6sw7JbefnQoqe2yQum9TeY8o8TN6ljvnkd3RlNZm8mlreEj
         LoX7IuQf16nMbNl6fhXKBjd7VMX82FFopbqtp08XL5TAs/PeM4XbmwJIhC9gm8k41Laf
         lJHnjmPf230fHmBNtraSr8dU+ScQsPhVxIdKTs1ihvIMCzERR3+29mKtrs6spwpa5WoI
         WUQeXwtu1zifguhKcEzEpJ76CUv4BxR8csblAv4zmR7wIoZcG+yphwhLk0fRaBnGA7lI
         Rmqw==
X-Gm-Message-State: AJIora+XVWA+pu3hj4hsXb2pMeCR+15PBA8H+iAGZ6ydeZZJyrOLgLGX
        LonySsGEvcPylsaAxQSbYdm/BNaqXljgUg==
X-Google-Smtp-Source: AGRyM1sw3b4Gf7DUk5VejQpFqixYkNtwHmwhWT8bDio8MDA8ccOD2+kZrg4cVNVGFgwJraPzGrAw4w==
X-Received: by 2002:adf:fd8f:0:b0:21e:bcb4:f731 with SMTP id d15-20020adffd8f000000b0021ebcb4f731mr862204wrr.537.1658853573293;
        Tue, 26 Jul 2022 09:39:33 -0700 (PDT)
Received: from localhost.localdomain ([94.73.33.57])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c058900b0039c54bb28f2sm19514710wmd.36.2022.07.26.09.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 09:39:32 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, stefanberzl@gmail.com, nathan@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 3/7] HID: uclogic: Refactor UGEE v2 frame initialization
Date:   Tue, 26 Jul 2022 18:39:22 +0200
Message-Id: <20220726163926.10549-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220726163926.10549-1-jose.exposito89@gmail.com>
References: <20220726163926.10549-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the moment, the driver only supports UGEE v2 devices that have
buttons in their frames.

In order to support other types of frames in the future, move the code
used to initialize this kind of frames to its own function.

Tested-by: Jouke Witteveen <j.witteveen@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 55 +++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index ab54f0125e05..7b9e1892aa91 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1108,6 +1108,44 @@ static int uclogic_params_parse_ugee_v2_desc(const __u8 *str_desc,
 	return 0;
 }
 
+/**
+ * uclogic_params_ugee_v2_init_frame_buttons() - initialize a UGEE v2 frame with
+ * buttons.
+ * @p:			Parameters to fill in, cannot be NULL.
+ * @desc_params:	Device description params list.
+ * @desc_params_size:	Size of the description params list.
+ *
+ * Returns:
+ *	Zero, if successful. A negative errno code on error.
+ */
+static int uclogic_params_ugee_v2_init_frame_buttons(struct uclogic_params *p,
+						     const s32 *desc_params,
+						     size_t desc_params_size)
+{
+	__u8 *rdesc_frame = NULL;
+	int rc = 0;
+
+	if (!p || desc_params_size != UCLOGIC_RDESC_PH_ID_NUM)
+		return -EINVAL;
+
+	rdesc_frame = uclogic_rdesc_template_apply(
+				uclogic_rdesc_ugee_v2_frame_btn_template_arr,
+				uclogic_rdesc_ugee_v2_frame_btn_template_size,
+				desc_params, UCLOGIC_RDESC_PH_ID_NUM);
+	if (!rdesc_frame)
+		return -ENOMEM;
+
+	rc = uclogic_params_frame_init_with_desc(&p->frame_list[0],
+						 rdesc_frame,
+						 uclogic_rdesc_ugee_v2_frame_btn_template_size,
+						 UCLOGIC_RDESC_V1_FRAME_ID);
+	kfree(rdesc_frame);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
 /**
  * uclogic_params_ugee_v2_init() - initialize a UGEE graphics tablets by
  * discovering their parameters.
@@ -1136,7 +1174,6 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 	const int str_desc_len = 12;
 	__u8 *str_desc = NULL;
 	__u8 *rdesc_pen = NULL;
-	__u8 *rdesc_frame = NULL;
 	s32 desc_params[UCLOGIC_RDESC_PH_ID_NUM];
 	__u8 magic_arr[] = {
 		0x02, 0xb0, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
@@ -1205,20 +1242,8 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 	p.pen.subreport_list[0].id = UCLOGIC_RDESC_V1_FRAME_ID;
 
 	/* Initialize the frame interface */
-	rdesc_frame = uclogic_rdesc_template_apply(
-				uclogic_rdesc_ugee_v2_frame_btn_template_arr,
-				uclogic_rdesc_ugee_v2_frame_btn_template_size,
-				desc_params, ARRAY_SIZE(desc_params));
-	if (!rdesc_frame) {
-		rc = -ENOMEM;
-		goto cleanup;
-	}
-
-	rc = uclogic_params_frame_init_with_desc(&p.frame_list[0],
-						 rdesc_frame,
-						 uclogic_rdesc_ugee_v2_frame_btn_template_size,
-						 UCLOGIC_RDESC_V1_FRAME_ID);
-	kfree(rdesc_frame);
+	rc = uclogic_params_ugee_v2_init_frame_buttons(&p, desc_params,
+						       ARRAY_SIZE(desc_params));
 	if (rc) {
 		uclogic_params_init_invalid(&p);
 		goto output;
-- 
2.25.1

