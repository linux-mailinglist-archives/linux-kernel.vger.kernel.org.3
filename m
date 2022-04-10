Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B455C4FB0A3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 00:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243986AbiDJWJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 18:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238297AbiDJWJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 18:09:30 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCF648E75;
        Sun, 10 Apr 2022 15:07:18 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id c1so2067788qke.10;
        Sun, 10 Apr 2022 15:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lLhtRYu7uRpqF6UzH4W4hGNVqeKtsIf+LFdDV1FH9AA=;
        b=Pf9KD80gKq4lpLTlNHSxm0OpmWpVF+lDJVeJDWonIAresYV4KaG2Je1CxJYc0JNcEn
         bh3BdAGvY8MOKdlLjpa70kx6Gvbvv6bjfXka5ENV821QkPzRuROyiaYo92j1y4uzksVN
         TZZP7OzzR/hOZI1sDXEX1MmgW9YU7CLZP3F6Vpjjhc6cFwGsWIyowxwsTQ7KOqDbFqf8
         oYFfAkAvx2ZNP5ovdbpsJyx+HS35Ne1zGxfLyr541S+CMSMU8AT5LN4Qo69qGtkFLcYH
         N0sKb03iMU81yIGNnyWJhs12ip8tQ9+bivtUbyVugwTIAbklNw1GtESqAQ6+VyPxQAo9
         d8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lLhtRYu7uRpqF6UzH4W4hGNVqeKtsIf+LFdDV1FH9AA=;
        b=W6/0vCwII2K9kjysLCmSwCKeemm1RnUEsIVrJ+UZkEh1u2vHNw/Fsy0RGz/GeE6fn5
         9hNXqXFbnjlSvbaIGJc/Vf+zo+iqJww6RduG+vKaIoDIqZGYf9yhGHgDX8P6P0+5yK+R
         VYiwG5/4FlQjFKZMZxMh2hnJuY2GUM/KSab9zLlg/UKsQcbbX9k5N99PP8maZNeunjVD
         R3IynR0/sJyS5P4ekqTtCgIL3OUHZ9DrOQXKk6YwGcihSwqjrwRSj7mmW50UeDhuizvH
         p8eaR4sAtYvsJ2dcsoYgrngFUnQ1KbwFp/C62dHSKFARodeb9wfNeHYuTIaBAZkR+qz5
         37Zg==
X-Gm-Message-State: AOAM532rIwMOxHVJmzS1diESSw8Wp0gRuSelcg/pYxHB3b2ApHad/Iwh
        fmYvqmAMkpb89qITEC/lBC3ukzG3Jn2l
X-Google-Smtp-Source: ABdhPJyOhDTxUv0dBoQrjbd/G4yGRICic04riEunSWDSyVxTqRkuEDZTp8MvJvrv5pVfpzVKwlkhkg==
X-Received: by 2002:a05:620a:214f:b0:69b:f840:f8c3 with SMTP id m15-20020a05620a214f00b0069bf840f8c3mr5388160qkm.600.1649628437348;
        Sun, 10 Apr 2022 15:07:17 -0700 (PDT)
Received: from arch.. ([2607:fb90:966:1288:8e89:a5ff:fe6f:56d3])
        by smtp.gmail.com with ESMTPSA id r17-20020a05620a299100b00680b43004bfsm20916357qkp.45.2022.04.10.15.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 15:07:16 -0700 (PDT)
From:   Daniel Bomar <dbdaniel42@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Bomar <dbdaniel42@gmail.com>
Subject: [PATCH 4/4] input: hid-microsoft: Implement trigger rumble for Xbox One S over bluetooth
Date:   Sun, 10 Apr 2022 17:07:13 -0500
Message-Id: <20220410220713.5303-1-dbdaniel42@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

Signed-off-by: Daniel Bomar <dbdaniel42@gmail.com>
---
 drivers/hid/hid-microsoft.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index 071fd093a5f4..061275626c42 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -32,6 +32,8 @@ struct ms_data {
 	unsigned long quirks;
 	struct hid_device *hdev;
 	struct work_struct ff_worker;
+	__u8 trigger_left;
+	__u8 trigger_right;
 	__u8 strong;
 	__u8 weak;
 	void *output_report_dmabuf;
@@ -40,9 +42,13 @@ struct ms_data {
 #define XB1S_FF_REPORT		3
 #define ENABLE_WEAK		BIT(0)
 #define ENABLE_STRONG		BIT(1)
+#define ENABLE_RIGHT		BIT(2)
+#define ENABLE_LEFT		BIT(3)
 
 enum {
-	MAGNITUDE_STRONG = 2,
+	MAGNITUDE_LEFT,
+	MAGNITUDE_RIGHT,
+	MAGNITUDE_STRONG,
 	MAGNITUDE_WEAK,
 	MAGNITUDE_NUM
 };
@@ -288,7 +294,7 @@ static void ms_ff_worker(struct work_struct *work)
 	memset(r, 0, sizeof(*r));
 
 	r->report_id = XB1S_FF_REPORT;
-	r->enable = ENABLE_WEAK | ENABLE_STRONG;
+	r->enable = ENABLE_WEAK | ENABLE_STRONG | ENABLE_RIGHT | ENABLE_LEFT;
 	/*
 	 * Specifying maximum duration and maximum loop count should
 	 * cover maximum duration of a single effect, which is 65536
@@ -296,6 +302,8 @@ static void ms_ff_worker(struct work_struct *work)
 	 */
 	r->duration_10ms = U8_MAX;
 	r->loop_count = U8_MAX;
+	r->magnitude[MAGNITUDE_LEFT] = ms->trigger_left;
+	r->magnitude[MAGNITUDE_RIGHT] = ms->trigger_right;
 	r->magnitude[MAGNITUDE_STRONG] = ms->strong; /* left actuator */
 	r->magnitude[MAGNITUDE_WEAK] = ms->weak;     /* right actuator */
 
@@ -316,6 +324,8 @@ static int ms_play_effect(struct input_dev *dev, void *data,
 	/*
 	 * Magnitude is 0..100 so scale the 16-bit input here
 	 */
+	ms->trigger_left = ((u32) effect->u.rumble.trigger_left * 100) / U16_MAX;
+	ms->trigger_right = ((u32) effect->u.rumble.trigger_right * 100) / U16_MAX;
 	ms->strong = ((u32) effect->u.rumble.strong_magnitude * 100) / U16_MAX;
 	ms->weak = ((u32) effect->u.rumble.weak_magnitude * 100) / U16_MAX;
 
-- 
2.35.1

