Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A17450A77B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389612AbiDURyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390965AbiDURyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:54:12 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538D54A904;
        Thu, 21 Apr 2022 10:51:21 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t6so4302252wra.4;
        Thu, 21 Apr 2022 10:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NnKTYAQUZr5DnHBpkPnAbHzcE3MCWYtWF2UJUHFWyxQ=;
        b=VJ7iMjDIwKUDSmu5jtn0bgREE+NeydrVY33vOVfNoLZy8un/T1zfZz41o3dXkH/NM0
         UKl6a9h6BmYy/fxpxGIeDRhF0iXvu7s5bZuXMO2tw+4WodgoNzxjM3xirzzNf2oCBPH/
         3bJoibJywJMJnkjmiRkV/n/V2kWNGSCZ/kr4Y5dunlmk7rhvPBvMkLl9K+S2PNZGpRyP
         wngLpb36rcZ9Va0X9Jjc/QTVH7id5BlxFOCnSASgcL6aNia+P4LQmqDwXoFKWk+YlyQK
         XaIyVUioajIBVspyd4vE+FT7cLqPg7dnpkUNuZ2tgoG3/NvZyn3pkOdWG96EsFn+3j6x
         AGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NnKTYAQUZr5DnHBpkPnAbHzcE3MCWYtWF2UJUHFWyxQ=;
        b=7J40LpOcBhYV0fkc6S/9P4VM2t0OOvD4/p8/4jvsWytGqTsI8DjBalCoyuaPOOmDiq
         Bhkmr6YcP6m7GQrcql12xMCq7w5CnIZWk0rdyl0z+YdddFQeIb8wH8GUMM+jvnlLEkBD
         sTRXM4+YDhWbCZ/YMqDMSHxYqWMO5sHZhqGFoLF3PTZ0+Mbks1eLlr1LTPgAlB+rcUrG
         HqOlazpLVI9gXY69aKeLPdmG3iQDQEPuc6XRQk38kOjf3jbm6NvQRBSFD2zm98IoRKqM
         HmHTugkyAcLM+tY/nWKkE89uTcIPwyqu9EItenCq4bE0OSuVeQtzd8gdeJSOjUmhqrbc
         xPuQ==
X-Gm-Message-State: AOAM531wiSsw94aoAl3BGMIxIB2LAoMR/wmfM11ejv51/40hgqMOnLTR
        KqFVwrUs+5g4J0HgLPn3TmU=
X-Google-Smtp-Source: ABdhPJw1gsL05rPREYUvgnhGe+dtF9jed8GmeBPgrCvm3V2+sxnE5WYK5ecNyTtxNiEdMOdFFXqmFA==
X-Received: by 2002:a05:6000:1e0a:b0:20a:be24:3de7 with SMTP id bj10-20020a0560001e0a00b0020abe243de7mr644866wrb.109.1650563479861;
        Thu, 21 Apr 2022 10:51:19 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id l28-20020a05600c1d1c00b0038ece66f1b0sm2685634wms.8.2022.04.21.10.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:51:19 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.19/uclogic 4/5] HID: uclogic: Support disabling pen usage
Date:   Thu, 21 Apr 2022 19:50:51 +0200
Message-Id: <20220421175052.911446-5-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421175052.911446-1-jose.exposito89@gmail.com>
References: <20220421175052.911446-1-jose.exposito89@gmail.com>
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

From: Nikolai Kondrashov <spbnick@gmail.com>

Restore the ability to disable pen usage in hid-uclogic to support e.g.
keyboard interfaces which also have pen usages for some reason, but
which we don't want to rewrite report descriptors for.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-core.c   | 19 +++++++++++++++++++
 drivers/hid/hid-uclogic-params.h |  7 +++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 627f1d0c52f2..8ef3d1830052 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -81,6 +81,24 @@ static __u8 *uclogic_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	return rdesc;
 }
 
+static int uclogic_input_mapping(struct hid_device *hdev,
+				 struct hid_input *hi,
+				 struct hid_field *field,
+				 struct hid_usage *usage,
+				 unsigned long **bit,
+				 int *max)
+{
+	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
+	struct uclogic_params *params = &drvdata->params;
+
+	/* Discard invalid pen usages */
+	if (params->pen.usage_invalid && (field->application == HID_DG_PEN))
+		return -1;
+
+	/* Let hid-core decide what to do */
+	return 0;
+}
+
 static int uclogic_input_configured(struct hid_device *hdev,
 		struct hid_input *hi)
 {
@@ -515,6 +533,7 @@ static struct hid_driver uclogic_driver = {
 	.remove = uclogic_remove,
 	.report_fixup = uclogic_report_fixup,
 	.raw_event = uclogic_raw_event,
+	.input_mapping = uclogic_input_mapping,
 	.input_configured = uclogic_input_configured,
 #ifdef CONFIG_PM
 	.resume	          = uclogic_resume,
diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
index fa75efba3130..fb2001018c46 100644
--- a/drivers/hid/hid-uclogic-params.h
+++ b/drivers/hid/hid-uclogic-params.h
@@ -61,6 +61,11 @@ struct uclogic_params_pen_subreport {
  * Noop (preserving functionality) when filled with zeroes.
  */
 struct uclogic_params_pen {
+	/*
+	 * True if pen usage is invalid for this interface and should be
+	 * ignored, false otherwise.
+	 */
+	bool usage_invalid;
 	/*
 	 * Pointer to report descriptor part describing the pen inputs.
 	 * Allocated with kmalloc. NULL if the part is not specified.
@@ -214,6 +219,7 @@ extern int uclogic_params_init(struct uclogic_params *params,
 	".desc_ptr = %p\n"                  \
 	".desc_size = %u\n"                 \
 	".pen = {\n"                        \
+	"\t.usage_invalid = %s\n"           \
 	"\t.desc_ptr = %p\n"                \
 	"\t.desc_size = %u\n"               \
 	"\t.id = %u\n"                      \
@@ -270,6 +276,7 @@ extern int uclogic_params_init(struct uclogic_params *params,
 	((_params)->invalid ? "true" : "false"),                    \
 	(_params)->desc_ptr,                                        \
 	(_params)->desc_size,                                       \
+	((_params)->pen.usage_invalid ? "true" : "false"),          \
 	(_params)->pen.desc_ptr,                                    \
 	(_params)->pen.desc_size,                                   \
 	(_params)->pen.id,                                          \
-- 
2.25.1

