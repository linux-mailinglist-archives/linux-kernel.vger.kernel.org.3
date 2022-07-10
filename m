Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AB356D099
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 19:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiGJRvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 13:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGJRvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 13:51:12 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF3C10567;
        Sun, 10 Jul 2022 10:51:11 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h17so4436618wrx.0;
        Sun, 10 Jul 2022 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ALxRC4P4NjmMOyYfdVkXxixEevQkN7Xh/olINwZD68=;
        b=V376j2kNH58CH38EMEVxBbtZ3W+ptR9WAF0nSWQzIoZxSQ8p781Ir8d2M+OeoH1ujp
         JMtEj4p+h7HATCtbRup3hOaapIjCzHMHpEvHhjnDDrShhOx6p/rEyPFVBjoAaGXJADgR
         MmcCCnOB3a5jXiuIQSg4rvSPGGS3xWd75q84J/cbBrJBfWBGImUpWa3M50dG3xX1ZTwi
         acCQXs3GB+mdxenHTJxTuAvlQk3C6QZmIxDkEhVZ1Yf/ehbQ3cSKVlIfsio2BgqTM83k
         jKiXxV/bdomxStT1on8di160ghmtnkXZ7pg5kVHD5vuiqx3hI3W6Qp/6faqHX2oaXUUL
         h4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ALxRC4P4NjmMOyYfdVkXxixEevQkN7Xh/olINwZD68=;
        b=Wtr6Zn4VxJJdyF6CVMP9tQN+N9UHn6pcbr75jT0vyzOQq02zESKDe4vpt3xM6V1vQQ
         sw/87ga/ypa2iwO4p7ubEAROkNps38KjueT+XngiKOfkcEGU5v3r4d/LomYTBbogS+dz
         H88AKHJQM+MASVMbmFfjylMp7xPLNoHxV9LUnABuZt84BKIK7AvCLpP3s2qiHEPiS8Hk
         nM7rPMRua1WrSZk4JMUG5JXus7dnf6FD+IEE468nJ0CLtKv/7wp0BIrmhnoW5iIyu/hY
         nhjFwXLlsUEMVqHMVFyIb2rmmhMAdhLsqj/cmU8H+CITxMhywYy+BJIUEpweBUrtPKNM
         Xz0Q==
X-Gm-Message-State: AJIora/bDzzD3hGCaNWF+SItBGdB1WX+Q05x2bIWIQtZdY7DTEYJMQm+
        qJDTLcnnVy9mglF/8/yjUWA=
X-Google-Smtp-Source: AGRyM1uPJUCeTPAnE31czTrBY3k5MdOni4SlVnGfrr/+QUGpnlUMXsqu5YxsKGBkoUYY+nWwggA4rQ==
X-Received: by 2002:a05:6000:100f:b0:21d:779f:fa87 with SMTP id a15-20020a056000100f00b0021d779ffa87mr13857537wrx.291.1657475469990;
        Sun, 10 Jul 2022 10:51:09 -0700 (PDT)
Received: from localhost.localdomain ([94.73.36.185])
        by smtp.gmail.com with ESMTPSA id l23-20020a1ced17000000b003a03ae64f57sm4523495wmh.8.2022.07.10.10.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 10:51:09 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        j.witteveen@gmail.com, stefanberzl@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 3/7] HID: uclogic: Refactor UGEE v2 frame initialization
Date:   Sun, 10 Jul 2022 19:50:39 +0200
Message-Id: <20220710175043.192901-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220710175043.192901-1-jose.exposito89@gmail.com>
References: <20220710175043.192901-1-jose.exposito89@gmail.com>
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

