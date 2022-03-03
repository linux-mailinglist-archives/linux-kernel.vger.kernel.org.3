Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D554CB81A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiCCHso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiCCHs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:48:29 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EB635242;
        Wed,  2 Mar 2022 23:47:43 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id y5so2627952wmi.0;
        Wed, 02 Mar 2022 23:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DLwnShhOGzDJRPDrMuARp5HnoES190FJM3KiBVtCeYQ=;
        b=T57L1WWKK6HHcKrxCPQ4A8dcb7lCYMWZpDF3b6MnTpgrmh0kjsUX7gzAf8305XPtxh
         Us1D88TL1n5kg3vpMvIaPLXMN54Wcr7CPlDeDGe5azqIWH92KgvA3LPqjc4utwiKkk4Y
         AYLXkPlX5CXMv9RVehK+W2yBBMJmwKTG1ZXtXL/Q0QjkAv5iWaa2US07B1s0W99JMnhN
         WSnpWw+TgFMjialPcshbIHo5hcsga8qHaRoE+eWqxEaCrzeBYs2Kr7ef2H21AZ1XfgUy
         5ieGxSuKt+K4NLTubPMPADiSaqb0E1PjwL9UN+cOJQvilmxHR310kN9GvHGIOBvsVHZ9
         nnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DLwnShhOGzDJRPDrMuARp5HnoES190FJM3KiBVtCeYQ=;
        b=aDGAowGyQ1a6NOwrmeZR8iZoYJ1wu2Ie7qZv6DIzzrdkLPePs+qUGKHQECYoC5D8ON
         I2vvBnOcMUaehVtbIt/mKtykE2v6GxuPcA41UW5iMaesTj1DKQNiNv2AK0fFONwqJXer
         hYyFU4+QU3X/Q7zil+YIi2SFMhyXR6YWtFTpNgQCg/Iqh+pi71pTedtPAMjJhz88StKl
         BVKzTzMQMsqimHI54zo2ukAGwi4wk4NLle0+GxTUBrfB8J47MZkSuoj2JcVuuwBNkEBw
         wfXFGOf3ehhOA2vAt7+IVfcJG9fmUKs+YwRASD6R8FoMmyJlVwszg93og/gmUvOqleeC
         BEcw==
X-Gm-Message-State: AOAM533A2xVoC+ViDDB4yiG63vY/z19wdUNKijchBfF4U33rp2r9z8qL
        f5JwLttidqDh9qckCpjwxXs=
X-Google-Smtp-Source: ABdhPJwobsLcgHBkl7FS/U3xZDGFU2ScOH6+8J9oX0ut67KX7hy9C/groYAsqnbga+Vr9jZxn3+EJg==
X-Received: by 2002:a05:600c:4f83:b0:37c:d057:3efe with SMTP id n3-20020a05600c4f8300b0037cd0573efemr2685205wmq.143.1646293661633;
        Wed, 02 Mar 2022 23:47:41 -0800 (PST)
Received: from localhost.localdomain ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id d3-20020a05600c34c300b003884e826642sm841169wmq.12.2022.03.02.23.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 23:47:41 -0800 (PST)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH for-5.18/uclogic 3/4] HID: uclogic: Allow three frame parameter sets
Date:   Thu,  3 Mar 2022 08:47:33 +0100
Message-Id: <20220303074734.7235-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220303074734.7235-1-jose.exposito89@gmail.com>
References: <20220303074734.7235-1-jose.exposito89@gmail.com>
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

Allow three frame parameter sets per each UC-Logic tablet interface.
Bump the number of supported subreports to three as well to accommodate
ID routing. This allows supporting the dial on Huion Q620M.

Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/hid/hid-uclogic-params.h | 52 +++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.h b/drivers/hid/hid-uclogic-params.h
index 8042820e78b1..f2649e8f959d 100644
--- a/drivers/hid/hid-uclogic-params.h
+++ b/drivers/hid/hid-uclogic-params.h
@@ -73,8 +73,8 @@ struct uclogic_params_pen {
 	unsigned int desc_size;
 	/* Report ID, if reports should be tweaked, zero if not */
 	unsigned int id;
-	/* The list of subreports */
-	struct uclogic_params_pen_subreport subreport_list[1];
+	/* The list of subreports, only valid if "id" is not zero */
+	struct uclogic_params_pen_subreport subreport_list[3];
 	/* Type of in-range reporting, only valid if "id" is not zero */
 	enum uclogic_params_pen_inrange inrange;
 	/*
@@ -194,7 +194,7 @@ struct uclogic_params {
 	 * The list of frame control parameters and optional report descriptor
 	 * parts. Only valid, if "invalid" is false.
 	 */
-	struct uclogic_params_frame frame_list[1];
+	struct uclogic_params_frame frame_list[3];
 };
 
 /* Initialize a tablet interface and discover its parameters */
@@ -210,6 +210,8 @@ extern int uclogic_params_init(struct uclogic_params *params,
 		".pen.desc_size = %u\n"                         \
 		".pen.id = %u\n"                                \
 		".pen.subreport_list[0] = {0x%02hhx, %hhu}\n"   \
+		".pen.subreport_list[1] = {0x%02hhx, %hhu}\n"   \
+		".pen.subreport_list[2] = {0x%02hhx, %hhu}\n"   \
 		".pen.inrange = %s\n"                           \
 		".pen.fragmented_hires = %s\n"                  \
 		".pen.tilt_y_flipped = %s\n"                    \
@@ -221,7 +223,25 @@ extern int uclogic_params_init(struct uclogic_params *params,
 		".frame_list[0].dev_id_byte = %u\n"             \
 		".frame_list[0].touch_ring_byte = %u\n"         \
 		".frame_list[0].touch_ring_max = %hhd\n"        \
-		".frame_list[0].touch_ring_flip_at = %hhd\n"
+		".frame_list[0].touch_ring_flip_at = %hhd\n"    \
+		".frame_list[1].desc_ptr = %p\n"                \
+		".frame_list[1].desc_size = %u\n"               \
+		".frame_list[1].id = %u\n"                      \
+		".frame_list[1].suffix = %s\n"                  \
+		".frame_list[1].re_lsb = %u\n"                  \
+		".frame_list[1].dev_id_byte = %u\n"             \
+		".frame_list[1].touch_ring_byte = %u\n"         \
+		".frame_list[1].touch_ring_max = %hhd\n"        \
+		".frame_list[1].touch_ring_flip_at = %hhd\n"    \
+		".frame_list[2].desc_ptr = %p\n"                \
+		".frame_list[2].desc_size = %u\n"               \
+		".frame_list[2].id = %u\n"                      \
+		".frame_list[2].suffix = %s\n"                  \
+		".frame_list[2].re_lsb = %u\n"                  \
+		".frame_list[2].dev_id_byte = %u\n"             \
+		".frame_list[2].touch_ring_byte = %u\n"         \
+		".frame_list[2].touch_ring_max = %hhd\n"        \
+		".frame_list[2].touch_ring_flip_at = %hhd\n"
 
 /* Tablet interface parameters *printf format arguments */
 #define UCLOGIC_PARAMS_FMT_ARGS(_params) \
@@ -233,6 +253,10 @@ extern int uclogic_params_init(struct uclogic_params *params,
 		(_params)->pen.id,                                          \
 		(_params)->pen.subreport_list[0].value,                     \
 		(_params)->pen.subreport_list[0].id,                        \
+		(_params)->pen.subreport_list[1].value,                     \
+		(_params)->pen.subreport_list[1].id,                        \
+		(_params)->pen.subreport_list[2].value,                     \
+		(_params)->pen.subreport_list[2].id,                        \
 		uclogic_params_pen_inrange_to_str((_params)->pen.inrange),  \
 		((_params)->pen.fragmented_hires ? "true" : "false"),       \
 		((_params)->pen.tilt_y_flipped ? "true" : "false"),         \
@@ -244,7 +268,25 @@ extern int uclogic_params_init(struct uclogic_params *params,
 		(_params)->frame_list[0].dev_id_byte,                       \
 		(_params)->frame_list[0].touch_ring_byte,                   \
 		(_params)->frame_list[0].touch_ring_max,                    \
-		(_params)->frame_list[0].touch_ring_flip_at
+		(_params)->frame_list[0].touch_ring_flip_at,                \
+		(_params)->frame_list[1].desc_ptr,                          \
+		(_params)->frame_list[1].desc_size,                         \
+		(_params)->frame_list[1].id,                                \
+		(_params)->frame_list[1].suffix,                            \
+		(_params)->frame_list[1].re_lsb,                            \
+		(_params)->frame_list[1].dev_id_byte,                       \
+		(_params)->frame_list[1].touch_ring_byte,                   \
+		(_params)->frame_list[1].touch_ring_max,                    \
+		(_params)->frame_list[1].touch_ring_flip_at,                \
+		(_params)->frame_list[2].desc_ptr,                          \
+		(_params)->frame_list[2].desc_size,                         \
+		(_params)->frame_list[2].id,                                \
+		(_params)->frame_list[2].suffix,                            \
+		(_params)->frame_list[2].re_lsb,                            \
+		(_params)->frame_list[2].dev_id_byte,                       \
+		(_params)->frame_list[2].touch_ring_byte,                   \
+		(_params)->frame_list[2].touch_ring_max,                    \
+		(_params)->frame_list[2].touch_ring_flip_at
 
 /* Get a replacement report descriptor for a tablet's interface. */
 extern int uclogic_params_get_desc(const struct uclogic_params *params,
-- 
2.25.1

