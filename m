Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC5E592698
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240759AbiHNVWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240458AbiHNVV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:21:56 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69428B7C7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 14:20:59 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660512058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C2n4uHutgtmzVoIjtyB1e31ZEUf1XWHBQLH2DJH4COc=;
        b=oUsCUNLrg75SzozUUtmTz93BjytmJvASLkDZ53VltoxIarYqoczvKeojchgKImZF5/GSeK
        XPJtSDuGfmIxOTuoTAuIeq4/8ZM8t0VzX9cAfFvCp2xWY3Ak8Fl/3/usI7hdgsAfgmtrMw
        BFWBbtCxfAhtPgdQU5L1z5b24/qa+J4=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 21/32] Input/joystick/analog: Convert from seq_buf -> printbuf
Date:   Sun, 14 Aug 2022 17:20:00 -0400
Message-Id: <20220814212011.1727798-22-kent.overstreet@linux.dev>
In-Reply-To: <20220814212011.1727798-1-kent.overstreet@linux.dev>
References: <20220814212011.1727798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

seq_buf is being deprecated, this converts to printbuf.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/analog.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
index 3088c5b829..a8c5f90e82 100644
--- a/drivers/input/joystick/analog.c
+++ b/drivers/input/joystick/analog.c
@@ -19,7 +19,7 @@
 #include <linux/input.h>
 #include <linux/gameport.h>
 #include <linux/jiffies.h>
-#include <linux/seq_buf.h>
+#include <linux/printbuf.h>
 #include <linux/timex.h>
 #include <linux/timekeeping.h>
 
@@ -339,24 +339,21 @@ static void analog_calibrate_timer(struct analog_port *port)
 
 static void analog_name(struct analog *analog)
 {
-	struct seq_buf s;
+	struct printbuf buf = PRINTBUF_EXTERN(analog->name, sizeof(analog->name));
 
-	seq_buf_init(&s, analog->name, sizeof(analog->name));
-	seq_buf_printf(&s, "Analog %d-axis %d-button",
-		 hweight8(analog->mask & ANALOG_AXES_STD),
-		 hweight8(analog->mask & ANALOG_BTNS_STD) + !!(analog->mask & ANALOG_BTNS_CHF) * 2 +
-		 hweight16(analog->mask & ANALOG_BTNS_GAMEPAD) + !!(analog->mask & ANALOG_HBTN_CHF) * 4);
+	prt_printf(&buf, "Analog %d-axis %d-button",
+	       hweight8(analog->mask & ANALOG_AXES_STD),
+	       hweight8(analog->mask & ANALOG_BTNS_STD) + !!(analog->mask & ANALOG_BTNS_CHF) * 2 +
+	       hweight16(analog->mask & ANALOG_BTNS_GAMEPAD) + !!(analog->mask & ANALOG_HBTN_CHF) * 4);
 
 	if (analog->mask & ANALOG_HATS_ALL)
-		seq_buf_printf(&s, " %d-hat",
-			       hweight16(analog->mask & ANALOG_HATS_ALL));
-
+		prt_printf(&buf, " %d-hat", hweight16(analog->mask & ANALOG_HATS_ALL));
 	if (analog->mask & ANALOG_HAT_FCS)
-		seq_buf_printf(&s, " FCS");
+		prt_printf(&buf, " FCS");
 	if (analog->mask & ANALOG_ANY_CHF)
-		seq_buf_printf(&s, (analog->mask & ANALOG_SAITEK) ? " Saitek" : " CHF");
+		prt_printf(&buf, (analog->mask & ANALOG_SAITEK) ? " Saitek" : " CHF");
 
-	seq_buf_printf(&s, (analog->mask & ANALOG_GAMEPAD) ? " gamepad" : " joystick");
+	prt_printf(&buf, (analog->mask & ANALOG_GAMEPAD) ? " gamepad" : " joystick");
 }
 
 /*
-- 
2.36.1

