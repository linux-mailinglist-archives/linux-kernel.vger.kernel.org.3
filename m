Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63394ADE5F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383397AbiBHQbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbiBHQb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:31:29 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52CBC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 08:31:28 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso2581052pjg.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 08:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dgz5khiwyLdS6+hjZUJgBxws08aqv4yfmHnCSdJvkvQ=;
        b=G3SGuHezN5ArPoi6RvHDWF2qR0hSKYI7qtxWgcWz2xFd8qemKrzCCRJgR2o2wgVh8E
         fRG5RIBxuAJhd901Yru9BoXuHUhMFTdzwChZPLMEk6nTCmuqEX8wdZY4+3YPILEDuLae
         37lHBn5wEDjqef29cNmXklOEwuTCGfSqfrEByd/8AgI/z4A8098G7ThHdUZR692x/WCJ
         o8Ncksrss3NVDE6XrLidPyhh2KdHgGTp8YQdl5sDXZLOmQRPFnjWdO1LIsjlhI7MdwPR
         yMpOiHmv61ABf7xyne3jLEjmFIYv3W4plcHRHgb9ve62cX3dgGJac1PllJIUVF8O9eV5
         qgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dgz5khiwyLdS6+hjZUJgBxws08aqv4yfmHnCSdJvkvQ=;
        b=OZIKeWSjhtXSXdQTalHzB0xn1UTRTci5PwXspeEGDtQLZ39t2JCmSzEdZeb7/Kc0Tu
         p9mg2X5WVUIyF7rB8ng6iilwqD31FkwSwlTsg6PfvymiowcwcAHU5ixT6ovKt22nfxO8
         ttnk+e5Xnbv8OVRzQVZYMFaVaRQAvixOIYQCEopQEvensJab/6r1775QzeFMkbCMLhmb
         IeHe6/XTOlTP8StwNLEd+rDta0REPcoqTDZuMkW4UPeqtsb7xrZ3natNRnXDPB+2jbxH
         hSVB3FPmoD3DzhGjHZgkvqj9m5+Li7QLDiOSifYqnD/uWZ5qbsA3aJYqHtvm8Ttic11k
         XL1w==
X-Gm-Message-State: AOAM532dgWhBKkstt1ZQq+9cyWd7MrXYXngxyR+S4vx4VJhjsHaA+lJA
        5KvxnvRjdE8c1EkggiyFgKGmjWiMT/62
X-Google-Smtp-Source: ABdhPJyqTaqnc5u1gUqTyxCxkBzQR+eyijzcWxWyWXJFi/v2Q0QM5jVVocS0vVbF3+23BnM+S2dOkA==
X-Received: by 2002:a17:902:a608:: with SMTP id u8mr5214219plq.119.1644337887933;
        Tue, 08 Feb 2022 08:31:27 -0800 (PST)
Received: from localhost.localdomain ([121.165.123.189])
        by smtp.gmail.com with ESMTPSA id k9sm15340982pfi.134.2022.02.08.08.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 08:31:27 -0800 (PST)
From:   JaeSang Yoo <js.yoo.5b@gmail.com>
X-Google-Original-From: JaeSang Yoo <jsyoo5b@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        JaeSang Yoo <jsyoo5b@gmail.com>
Subject: [PATCH v2] trace: param: fix tp_printk option related with tp_printk_stop_on_boot
Date:   Wed,  9 Feb 2022 01:30:33 +0900
Message-Id: <20220208163031.885332-1-jsyoo5b@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Kernel param "tp_printk_stop_on_boot" starts with "tp_printk" which is
the exact as the other kernel param "tp_printk".
In compile & build process, It may not guaranteed that
"tp_printk_stop_on_boot" always checked before "tp_printk".
(By swapping its __setup() macro order, it may not work as expected.)
Some kernel params which starts with other kernel params consider this
problem. See commit 745a600cf1a6 ("um: console: Ignore console= option")
or init/do_mounts.c:45 (setup function of "ro" kernel param)

Kernel param "tp_printk" can be handled with its value(0 or off) or
it can be handled without its value. (maybe it won't effect anything)
Fix setup function to ignore when the "tp_printk" becomes prefix of
other kernel param.

Signed-off-by: JaeSang Yoo <jsyoo5b@gmail.com>
---
 kernel/trace/trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c860f582b078..5c8a28d74cf8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -252,6 +252,8 @@ __setup("trace_clock=", set_trace_boot_clock);
 
 static int __init set_tracepoint_printk(char *str)
 {
+	if (*str == '_')
+		return 0
 	if ((strcmp(str, "=0") != 0 && strcmp(str, "=off") != 0))
 		tracepoint_printk = 1;
 	return 1;
-- 
2.25.1

