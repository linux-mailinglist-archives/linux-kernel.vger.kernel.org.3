Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DE752DB38
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242813AbiESR1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242742AbiESRZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:25:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62372A5033;
        Thu, 19 May 2022 10:25:26 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o13-20020a17090a9f8d00b001df3fc52ea7so9353278pjp.3;
        Thu, 19 May 2022 10:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HkgeacWNM0o6tNfidYESYHohydRW3WSO9rnNuCMWeRg=;
        b=U7k0OV5r4mJ0TuwkYHZY7iFwh3ViIBrZQI87oOkTjIb5fl9vYBG/SpTFZB3TzoImJ+
         a7IdlgB0bT6Yv3HhL2eZu1nV7ybD5CJr3I5a/I5oVIamgGKoZhyqdJAJZmRzvKu7lEKi
         tm59BqvVMbB+85NN5tXyyH47NJIKBL9WPZ0D2MwdyABOF32IUfvGXMCTlCMagNXwM0mq
         qhVpIpiE7wTQzu5cDelhviCRfBo5G66ATArxWzkbJVG1isd+rssuOqZ35K58lJojO8o0
         QaXFup5GzXrj40bwRYl/K+HTvNSCVED1yj5cvrMr3jzXTYH/lTAM5cEqnmfOjTyhsRUA
         T84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HkgeacWNM0o6tNfidYESYHohydRW3WSO9rnNuCMWeRg=;
        b=n8trNINN7IcqntQd6G7dyDk5xF76EvFzF1LmsriNo+TorsORdAzoSpZ5uN4qVMitFq
         KRgdgj2XQ4k62Hv3i36upT2HVy37iCD1hQsDhpJXKq3WrX0h6c2+9gp2RNU+1YrmuLMG
         1D8QjK9DspcivSLZXd4PHw9NxLstR80D+8B8emTl7eVtALLADd3ZsqDTZmLDJuuiiZU+
         BIelQX+29G0oF5nXly7HlONcqsvWMM1nbtBzzAv3YbVcOsICmBfeMbiiyzjMOcMSCN3h
         20ISj5/KRiA3H6D7NnTfBkt8ctoLEST2YDj3h1NRJW5iLmv4SjL4kNp3AbPirrzbZFsf
         efgg==
X-Gm-Message-State: AOAM5334Tlg2U0TSllhnlNBGdQRS+Fkx2eiErll7sisdL0BkUgWUJpoU
        zGK0sgs9cQwB/XiAi4/P0wIdHnKLm92+
X-Google-Smtp-Source: ABdhPJw1xLSKQfSuo/sCNUUiDwCl90STmqlc/fYFr6w1tWKMlYw+Oncip0utICQcTOjERRdTjUtA1g==
X-Received: by 2002:a17:90a:2809:b0:1df:35ca:2e6a with SMTP id e9-20020a17090a280900b001df35ca2e6amr6208779pjd.8.1652981125365;
        Thu, 19 May 2022 10:25:25 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:25:24 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 22/28] Input/joystick/analog: Convert from seq_buf -> printbuf
Date:   Thu, 19 May 2022 13:24:15 -0400
Message-Id: <20220519172421.162394-23-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220519172421.162394-1-kent.overstreet@gmail.com>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
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

seq_buf is being deprecated, this converts to printbuf which is similar
but heap allocates the string buffer.

This means we have to consider memory allocation context & failure: Here
we're in device initialization so GFP_KERNEL should be fine, and also as
we're in device initialization returning -ENOMEM is fine.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 drivers/input/joystick/analog.c | 37 ++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/input/joystick/analog.c b/drivers/input/joystick/analog.c
index 3088c5b829..72e1e30d19 100644
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
 
@@ -337,26 +337,32 @@ static void analog_calibrate_timer(struct analog_port *port)
  * analog_name() constructs a name for an analog joystick.
  */
 
-static void analog_name(struct analog *analog)
+static int analog_name(struct analog *analog)
 {
-	struct seq_buf s;
+	struct printbuf buf = PRINTBUF;
+	int ret = 0;
 
-	seq_buf_init(&s, analog->name, sizeof(analog->name));
-	seq_buf_printf(&s, "Analog %d-axis %d-button",
-		 hweight8(analog->mask & ANALOG_AXES_STD),
-		 hweight8(analog->mask & ANALOG_BTNS_STD) + !!(analog->mask & ANALOG_BTNS_CHF) * 2 +
-		 hweight16(analog->mask & ANALOG_BTNS_GAMEPAD) + !!(analog->mask & ANALOG_HBTN_CHF) * 4);
+	pr_buf(&buf, "Analog %d-axis %d-button",
+	       hweight8(analog->mask & ANALOG_AXES_STD),
+	       hweight8(analog->mask & ANALOG_BTNS_STD) + !!(analog->mask & ANALOG_BTNS_CHF) * 2 +
+	       hweight16(analog->mask & ANALOG_BTNS_GAMEPAD) + !!(analog->mask & ANALOG_HBTN_CHF) * 4);
 
 	if (analog->mask & ANALOG_HATS_ALL)
-		seq_buf_printf(&s, " %d-hat",
-			       hweight16(analog->mask & ANALOG_HATS_ALL));
+		pr_buf(&buf, " %d-hat",
+		       hweight16(analog->mask & ANALOG_HATS_ALL));
 
 	if (analog->mask & ANALOG_HAT_FCS)
-		seq_buf_printf(&s, " FCS");
+		pr_buf(&buf, " FCS");
 	if (analog->mask & ANALOG_ANY_CHF)
-		seq_buf_printf(&s, (analog->mask & ANALOG_SAITEK) ? " Saitek" : " CHF");
+		pr_buf(&buf, (analog->mask & ANALOG_SAITEK) ? " Saitek" : " CHF");
 
-	seq_buf_printf(&s, (analog->mask & ANALOG_GAMEPAD) ? " gamepad" : " joystick");
+	pr_buf(&buf, (analog->mask & ANALOG_GAMEPAD) ? " gamepad" : " joystick");
+
+	ret = buf.allocation_failure ? -ENOMEM : 0;
+	if (!ret)
+		strlcpy(analog->name, buf.buf, sizeof(analog->name));
+	printbuf_exit(&buf);
+	return ret;
 }
 
 /*
@@ -369,7 +375,10 @@ static int analog_init_device(struct analog_port *port, struct analog *analog, i
 	int i, j, t, v, w, x, y, z;
 	int error;
 
-	analog_name(analog);
+	error = analog_name(analog);
+	if (error)
+		return error;
+
 	snprintf(analog->phys, sizeof(analog->phys),
 		 "%s/input%d", port->gameport->phys, index);
 	analog->buttons = (analog->mask & ANALOG_GAMEPAD) ? analog_pad_btn : analog_joy_btn;
-- 
2.36.0

