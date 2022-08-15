Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D4C5930C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbiHOOaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243062AbiHOOaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:30:08 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE3223BF1;
        Mon, 15 Aug 2022 07:30:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n4so9242933wrp.10;
        Mon, 15 Aug 2022 07:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vQYUEj4RA75eO79mG5fQuMt5VepEBA+QRmCJhUes6lI=;
        b=Y2r80NvARtlOgnB1PQvTTQMnT3Zc+ZIBmBIU8/4vzDfa+7kQW0pT2OQr9mvnuCcyEL
         IWYiIxUk7Prw2cjT+7FlMKSRWAHf8wsdU4vHVa/qlN7VANjwKl/MW1Dzud0TPQ0hOA/p
         sN55uivGXepsf/XCuHH1JUNWdagXEQE5LqzwwRM/YdE0JXZQjFjY/ed30FVzsemb+t4q
         WNNK9JRBif7oFeYzdJfX0PpPGk969o+/vw+DzaFzgZB99sK9LU5KSgQ0nEL4AY88hepn
         qWRato8U53tGLsr3UyRqzjZn0XC+4Q+WvzR7d0blYcYh4nWwX1KMucSicJfUXXpkuN9h
         nZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vQYUEj4RA75eO79mG5fQuMt5VepEBA+QRmCJhUes6lI=;
        b=ThLV2wrTaAWeDlfL4qYFIkbCeUPVxqQXm9bBTQTOhColt2keOKpWriZzXxKeWcET8v
         Epljixji4P9DpLAt1uVqWsZqfdK/cUrmgCxkDPh3VnHbifaUrrbYw8xJwyB4Rzmz/Qx4
         p8L9u61xoxEHkqlc6Q2AV0zd0u1k7zX+pUufLHmErrbdXJRz6408KEG8oqrgfn+DEQm1
         wtNlUCUqUwIPzAlImj3SU0xUjjQYvWeQenBi80EtiCN0K4223vnQFMlaKu15J9ZF67vS
         eSa6SJa799DTB+O82m3e7zYNoT8kIMieGpe4o//4fEgr1FTeA8BjfdpE+xJxgG0HL/lq
         bBTw==
X-Gm-Message-State: ACgBeo3vgjPGYEqkABnoH7JsWmWWCkzyGtQXuhhfZ/ocTSx/8i3TdHAK
        iZuAbQRDwNPxYRTPJknvD1FSc0YVWIp7fQ==
X-Google-Smtp-Source: AA6agR4VZTJ+ZlNviJS9syq1nz0S9z+KDe5K3bkEJQo8zgeVGGjRh3waFgb+irFgUMDLVvHeTgwaaw==
X-Received: by 2002:a5d:4e52:0:b0:21f:15aa:1174 with SMTP id r18-20020a5d4e52000000b0021f15aa1174mr8816403wrt.106.1660573805731;
        Mon, 15 Aug 2022 07:30:05 -0700 (PDT)
Received: from localhost.localdomain ([94.73.32.249])
        by smtp.gmail.com with ESMTPSA id m7-20020a056000008700b00224f895d620sm5456894wrx.48.2022.08.15.07.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 07:30:05 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, nathan@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v4 3/8] HID: uclogic: Refactor UGEE v2 frame initialization
Date:   Mon, 15 Aug 2022 16:29:51 +0200
Message-Id: <20220815142956.19180-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220815142956.19180-1-jose.exposito89@gmail.com>
References: <20220815142956.19180-1-jose.exposito89@gmail.com>
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

At the moment, the driver only supports UGEE v2 devices that have
buttons in their frames.

In order to support other types of frames in the future, move the code
used to initialize this kind of frames to its own function.

Tested-by: Jouke Witteveen <j.witteveen@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.c | 56 ++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 07c5a21112ce..182e6f8f027a 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -1112,6 +1112,41 @@ static int uclogic_params_parse_ugee_v2_desc(const __u8 *str_desc,
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
+	return rc;
+}
+
 /**
  * uclogic_params_ugee_v2_init() - initialize a UGEE graphics tablets by
  * discovering their parameters.
@@ -1140,7 +1175,6 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 	const int str_desc_len = 12;
 	__u8 *str_desc = NULL;
 	__u8 *rdesc_pen = NULL;
-	__u8 *rdesc_frame = NULL;
 	s32 desc_params[UCLOGIC_RDESC_PH_ID_NUM];
 	__u8 magic_arr[] = {
 		0x02, 0xb0, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
@@ -1209,24 +1243,10 @@ static int uclogic_params_ugee_v2_init(struct uclogic_params *params,
 	p.pen.subreport_list[0].id = UCLOGIC_RDESC_V1_FRAME_ID;
 
 	/* Initialize the frame interface */
-	rdesc_frame = uclogic_rdesc_template_apply(
-				uclogic_rdesc_ugee_v2_frame_btn_template_arr,
-				uclogic_rdesc_ugee_v2_frame_btn_template_size,
-				desc_params, ARRAY_SIZE(desc_params));
-	if (!rdesc_frame) {
-		rc = -ENOMEM;
+	rc = uclogic_params_ugee_v2_init_frame_buttons(&p, desc_params,
+						       ARRAY_SIZE(desc_params));
+	if (rc)
 		goto cleanup;
-	}
-
-	rc = uclogic_params_frame_init_with_desc(&p.frame_list[0],
-						 rdesc_frame,
-						 uclogic_rdesc_ugee_v2_frame_btn_template_size,
-						 UCLOGIC_RDESC_V1_FRAME_ID);
-	kfree(rdesc_frame);
-	if (rc) {
-		uclogic_params_init_invalid(&p);
-		goto output;
-	}
 
 output:
 	/* Output parameters */
-- 
2.25.1

