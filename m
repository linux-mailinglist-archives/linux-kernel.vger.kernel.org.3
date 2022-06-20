Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476AF550E0C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238384AbiFTAop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238351AbiFTAnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:46 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DC6B7D8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:30 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c144so6864144qkg.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oHZ6nQT/N9bLil/etCt1wSEx4xhnhUtuxCNLNmvznXY=;
        b=S9XptWh8DqC+66cgLZqvqnxt6sGYteRfU4WLgKm4FNZ10hcJXl3XfADdQTOVFiFzSz
         g2sKvhZHX5aF0c6SSfjPkhOt3+ZQmjDPvT6/7sEIBw7MBAy0F1W+LYUZXPDTAL+E6//y
         N47O9ZxAj/+D0i5xhCQeW9QoS9wbJmSXkIk4TedVlQepn6nf4x7bG/IaN6GWv+v+5Ot2
         jTSYwCujqxHC4+Ln4Uyecczl4f/4FsdrMtsZAiv/Mfp0wTEH2BkwUpT904cAi2PMzd4+
         j5RHs9XmNNnMrGU/lRUtAkx/NPoQdv7d9u63cb33KjqgG7qqkvQFaGNkqs/98/s04ZUs
         ZEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oHZ6nQT/N9bLil/etCt1wSEx4xhnhUtuxCNLNmvznXY=;
        b=XHpzahXDCXEPyNiRGc8dfwdsYnkEqI4oEE9hYKI1xJfYTkC3v3Tf+c20QUT3U0bSzy
         x2abRT+mbbJN7dm0lSEDRxwBed/aQldCcRd+i4eQiEWWMYrMeFhAIDaDSKTPv04wCkcT
         xygYAxeHpVFW++Qm1ESUeAROr1t9PsufXleZb3VD7oJQTGFnJqZUwRqSMCdpgtg3p7v5
         AnDVTmn4z2eigHoqkcHObs6bX41/wxTt1/3vhK8bHrhblBk00RQJ0Zbk56uWcVRaECEg
         YYvDdTcL3u+cBNPLdxb19JFeQ0wz6lLARgq+PcSFTKvn2Rx68t7GPKfbGheZ8YWSUwXe
         Hw4g==
X-Gm-Message-State: AJIora94MeWDsYkTd7x0BVpkIMRFLDThm0iOQQAqNMhZMbjKK9+xnnqx
        g5oQ7+ZxJpPcKH2pHHJ9jjpoSyoot+yoXa4=
X-Google-Smtp-Source: AGRyM1skuA5LbWzNEHZ7Lk4CN7aJYyltI0ZJ+LVvNJE8kd9aywds6JcebeSrNRYxQ5JcxvYG8liLvw==
X-Received: by 2002:a05:620a:130d:b0:6a6:bb03:d8ab with SMTP id o13-20020a05620a130d00b006a6bb03d8abmr14522452qkj.133.1655685808583;
        Sun, 19 Jun 2022 17:43:28 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id l27-20020ac84cdb000000b003051ea4e7f6sm9828308qtv.48.2022.06.19.17.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:43:27 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 23/34] Input/joystick/analog: Convert from seq_buf -> printbuf
Date:   Sun, 19 Jun 2022 20:42:22 -0400
Message-Id: <20220620004233.3805-24-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620004233.3805-1-kent.overstreet@gmail.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
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
2.36.1

