Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7972D52416E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 02:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349597AbiELAPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 20:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349600AbiELAPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:15:42 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A0213CA0A;
        Wed, 11 May 2022 17:15:37 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id q10so4598533oia.9;
        Wed, 11 May 2022 17:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CwF4OHVvt2/W8/fWhl2zbk3bkx19u2MZi1kJ5541uj8=;
        b=JIOiyWZp/G5JC4MWsBffctuOOWbvvZpQxuBEL1q05eK4/n5arHlfQI0dgpQYFXagFO
         AGxJciNUa3sMLRnzViH+R8Cbq/83+YWxfNczaP+mVf2qpuUtNX4WX1U/l0VX9TnRA74z
         p6iqrXrcBReuwguPUHHmziVPRmDFwLdQhLVLqeFYBct0L4D8NCz/YLWA6H8kFaC/II7c
         XmcQflRpoyrrXQSv1mtDlVFlJiwgsYhzW7VQMu6xCNnNOv5UDqtAx2D96PunTDSfb536
         iep6iTDECao6sxbIxIxVUH7WKP/A0JcK+ArhU/uwGDSF3ade5f113mt4fQ5UxRWlYcvz
         I3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CwF4OHVvt2/W8/fWhl2zbk3bkx19u2MZi1kJ5541uj8=;
        b=VXtdFbr+SjfRfKuQ8PWTQn+QE8Z5fqQxA4sEpnqZF9u/uzpAzNoZztoiUVlCcknOC8
         /zD5DjuBodwlp/HMs2uieka5AJfrtap/L7+9BhEekTZp8CtfHQe56pfYVogUpnk6+7C7
         hfppzDCSRJFom8UbY69H4UiFzqiDu1aJFKHm+/O1TJVU2bLONh+JSk8yiSn1i1SDgdKH
         8iAukM+wYMJkzWJ+uVoLbEYgSNny0WW9NAjcufjjXKfT9gYHQN8LSQsY1pLe2zcrHWra
         hpdl3KD/+BTxAskYKWx8GV5WCHBOxqURsTgbPRA9yXyMypLeCkR/E2Dgp25GmqUs+E8h
         V5Vw==
X-Gm-Message-State: AOAM533biIUiPvZp1718NdDvV4xE5KrdlUcrtjyq1jFMXy8eba00hd/3
        pL5VudMZkUE0V4/dnPemf+I=
X-Google-Smtp-Source: ABdhPJy97TB8m3Ng26yRdFYL14QRXz+1D9b+EYJPwKHn/73E8WX4UKBWyK3qcKt0sHTt91kOb7OC4A==
X-Received: by 2002:aca:a996:0:b0:326:9197:4b41 with SMTP id s144-20020acaa996000000b0032691974b41mr3694555oie.221.1652314537212;
        Wed, 11 May 2022 17:15:37 -0700 (PDT)
Received: from max-lenovo.. (169-231-139-87.wireless.ucsb.edu. [169.231.139.87])
        by smtp.gmail.com with ESMTPSA id z23-20020a9d65d7000000b0060603221235sm1392635oth.5.2022.05.11.17.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 17:15:36 -0700 (PDT)
From:   Max Fletcher <fletcher0max@gmail.com>
To:     djogorchock@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Max Fletcher <fletcher0max@gmail.com>
Subject: [PATCH 1/2] HID: nintendo: fix face button mappings
Date:   Wed, 11 May 2022 17:14:59 -0700
Message-Id: <20220512001500.16739-1-fletcher0max@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, A and B would match the Xbox layout, but X and Y were incorrectly swapped. This corrects it so that X and Y match the Xbox layout.

Signed-off-by: Max Fletcher <fletcher0max@gmail.com>
---
 drivers/hid/hid-nintendo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 2204de889739..7735971ede3f 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -1351,10 +1351,10 @@ static void joycon_parse_report(struct joycon_ctlr *ctlr,
 		input_report_key(dev, BTN_START, btns & JC_BTN_PLUS);
 		input_report_key(dev, BTN_THUMBR, btns & JC_BTN_RSTICK);
 		input_report_key(dev, BTN_MODE, btns & JC_BTN_HOME);
-		input_report_key(dev, BTN_WEST, btns & JC_BTN_Y);
-		input_report_key(dev, BTN_NORTH, btns & JC_BTN_X);
-		input_report_key(dev, BTN_EAST, btns & JC_BTN_A);
-		input_report_key(dev, BTN_SOUTH, btns & JC_BTN_B);
+		input_report_key(dev, BTN_X, btns & JC_BTN_Y);
+		input_report_key(dev, BTN_Y, btns & JC_BTN_X);
+		input_report_key(dev, BTN_B, btns & JC_BTN_A);
+		input_report_key(dev, BTN_A, btns & JC_BTN_B);
 	}
 
 	input_sync(dev);
@@ -1578,7 +1578,7 @@ static const unsigned int joycon_button_inputs_l[] = {
 
 static const unsigned int joycon_button_inputs_r[] = {
 	BTN_START, BTN_MODE, BTN_THUMBR,
-	BTN_SOUTH, BTN_EAST, BTN_NORTH, BTN_WEST,
+	BTN_A, BTN_B, BTN_Y, BTN_X,
 	BTN_TR, BTN_TR2,
 	0 /* 0 signals end of array */
 };
-- 
2.35.3

