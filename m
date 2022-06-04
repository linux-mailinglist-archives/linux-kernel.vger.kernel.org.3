Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B229253D853
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241146AbiFDTc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240824AbiFDTbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:31:43 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4509550054
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:26 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id u8so7808560qvj.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=twQ/l/SSVqpaC5DgYCH7VSwC9ALcVhz/FUNTup042zw=;
        b=Pq1aVOpBoqOFqZVHk+9X2Ha0pzyJLlZ0SJ56FoTjDlD//Vt+ICDz0Pc7OfLeYV9d+i
         WNDXN+/eGNFSnDey1xe/IV5JnlIlEFAUfbhMSDLdUvYio64ZtgOUEaTdejLNYwbGlJIc
         ihy3R5Kh9Mpb1lpdZfoP069T8mfl7/0p8LlZNmRhDzJQy7VeKb5cHt3VegvSfxfI68cF
         124mPZILgRqzpA4EqRg9yeAdAoxAqZ1K50Oqkdhx5oIvgqDgjd38t7US4e87rTDbkHRJ
         obX1iOirBb0tph2oARKt3XDDZIdJBpXVT2XN7aNVAavRGAnKi5VVxOlv2PhP1mDeEsat
         f29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=twQ/l/SSVqpaC5DgYCH7VSwC9ALcVhz/FUNTup042zw=;
        b=HyBValA0IF8kdwVR3rV5e7Gr0cwzBhGG1ZffdKaG1dJUL8e3+ane1Oemf9N3tf4mQ4
         QY4kW6YSlu265AHY+QF0uj4J2whCSo82UR60kNTqGEhMqpwHhTc4pGU4a6pzd6i7CL2U
         wspk9GpeLWGq3qulwEkDs8iVg9XzF8ZUDr1zyj6cdj1P4vonLXJpo89QwIsBbOt+GZIU
         wmdoPk4DRHaVL2EJ04N6tPKeL1V6JUhgeP+52Q0o2JC8v+4V0yZImaNvyBLNGYzuAo1X
         lRkBcSpHsSH+f5Vj8Xl/t+ycuX4ADU0EL1ME9cTU5QdciMDKsrHnACdXcsDFgswC1Y8X
         7ZxQ==
X-Gm-Message-State: AOAM5331K0OU+BzbDhyXcH9+WVfgaQMCyFoz7mHkB7FT678mNm+QIAvs
        jqE8KZR4472zZUQKMy3/0wuQzKFtxomv
X-Google-Smtp-Source: ABdhPJzfXdmtWyzWeixbaNma8wEgUblOis9qeSNZ6Bqys/lu8X8bd4LkFPW8KHMjxZT5Jv3UwOCTcQ==
X-Received: by 2002:a0c:e790:0:b0:46a:916:32c5 with SMTP id x16-20020a0ce790000000b0046a091632c5mr5533882qvn.129.1654371084778;
        Sat, 04 Jun 2022 12:31:24 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:24 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 23/33] Input/joystick/analog: Convert from seq_buf -> printbuf
Date:   Sat,  4 Jun 2022 15:30:32 -0400
Message-Id: <20220604193042.1674951-24-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220604193042.1674951-1-kent.overstreet@gmail.com>
References: <20220604193042.1674951-1-kent.overstreet@gmail.com>
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

seq_buf is being deprecated, this converts to printbuf.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
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
2.36.0

