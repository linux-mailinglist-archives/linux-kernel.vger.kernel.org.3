Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994B25776C1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 16:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbiGQOnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 10:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiGQOnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 10:43:42 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1068BEBA;
        Sun, 17 Jul 2022 07:43:41 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 8-20020a05600c024800b003a2fe343db1so5903052wmj.1;
        Sun, 17 Jul 2022 07:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ALxRC4P4NjmMOyYfdVkXxixEevQkN7Xh/olINwZD68=;
        b=VvAAB8QyKYLPQgDMd5r6mttXiX3QiTnQy4kb571ydYGqAaziRchU31Cx4CuP4aCFEK
         QeY8UWTCx/rf/n0UDwG7n+JILgukkIrTLXI3pKP6NZ7B8tJu+XCFjJy2RDX+D1oM+03C
         aZ//LesTCsnpz4JhyuZ7p/BBy0DUS8Yz8fhMRDCtdywDLpxQriQgrBG9/0BW3CRrjd47
         DyXOnRIqE+DIJL9w9lwqEPrYxeLd0wNZkpfMoWFMepfSQ+pFAyELM38AJz11p2BM0y79
         06Po9B/CMJj/7GOFyapDyzQRppN77WUv/BXlrOsbkt//Etz+ZD3SgChMYZBEc+P+RsQd
         TjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ALxRC4P4NjmMOyYfdVkXxixEevQkN7Xh/olINwZD68=;
        b=0QMdlhGfzqG9dx4+EQ8KUScH7bciD+WiRQHBBENe/X2NKlAcXBajvVNeAAPXw879ui
         zrqOHALT3MqGxIiHumluUHpeVux8vEvNUT4PZCZUsrksK3AgZo2QqMkMN1jPOVtxpFlE
         NhA9ySxT+NIl5xKm149hmQMHvxsuO/ZVbjfQaYkZoeYOcePARArBWve97GB7uRlFDpIb
         2BFXxbYlDbJErrgX8kwLJMsLspBOKH7CGpczic4qOqCTeeOkUce7a+z3+xKHH0/BI9mF
         3q5ZKA59erefz/OY9VO9lYQ8GA0M8vF7svZmHkkaGpUTqDSnktwJt0StiXAszhSlK6gH
         q1yA==
X-Gm-Message-State: AJIora+rdGlROsQRHD48fEucyB+oIjo1LA8Khw/krEp6+DvphLAPaiES
        Q2SfzTY+xYAuZmu46t+JLgU=
X-Google-Smtp-Source: AGRyM1ueRgpzktK9Xw4yNDaYjfhXahRrzmtsLspuZy2gw58HpwNS8YEMWpTe6DkntB0N8q5Rzhd13w==
X-Received: by 2002:a05:600c:3ca4:b0:3a0:1825:2e29 with SMTP id bg36-20020a05600c3ca400b003a018252e29mr22397194wmb.11.1658069019625;
        Sun, 17 Jul 2022 07:43:39 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id h8-20020adff4c8000000b0021d887f9468sm8432001wrp.25.2022.07.17.07.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 07:43:39 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, stefanberzl@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 3/7] HID: uclogic: Refactor UGEE v2 frame initialization
Date:   Sun, 17 Jul 2022 16:43:29 +0200
Message-Id: <20220717144333.251190-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220717144333.251190-1-jose.exposito89@gmail.com>
References: <20220717144333.251190-1-jose.exposito89@gmail.com>
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

