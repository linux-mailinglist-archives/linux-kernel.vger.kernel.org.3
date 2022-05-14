Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30C1526F68
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiENDfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 23:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiENDe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 23:34:58 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EED9941B2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 20:34:57 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso7841563wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 20:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F29OH6asB34VWoRlm7WLSnKtmcCuH6sg3zO/EYEp6Og=;
        b=PnY1JknhQyIvblKgS7FrBkhnOIrw+KP7j+q/299tAR9IJU7WR7v2oKP2ZBIUMWw04H
         6IcYcpQ+IMl8BRMszHkVkewWJDbnJXNWIiLUDGX0FwDQlH8ewYDvgqiNzBANnxUDwBYA
         GKcACdjZVVm8UPiRjzKqp9ML7b6I7Ar2DpCyzhFtKdHga3SEQDloJIEQB2Sd6CH1CaDs
         JfN/Wvwaz9f/tJznk30sllAUnGLXYd95jwJpeiHt21HdsinY5uaru4U8oKM18SCCRmQx
         r75Glqv2ScLPEoI2uLoAhcls5C6haG5rdQxaTg0Nv5+SDh3TBFmzt0bDFRUPDdUTOQBb
         WYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F29OH6asB34VWoRlm7WLSnKtmcCuH6sg3zO/EYEp6Og=;
        b=H8Yel5+F4l0MFhsH57VHPnTu2qDcMC0WYk5lpuyannaj8/v1Kkf5EY7QI4HZKBlvVd
         OLu4hVbh3bdSLKUoOCBJWyIiwsIS7DmDFnQoHgNJdn/h/M+N5Cw+4WV99wLcbKuCybPk
         SFh/PPy0js91hdge8Cj6Pl6MEvpjsQVDM9HwK7hRNLbLdEf2boFOrMRZnPl61aKiAGvX
         uluZuiE/RxzFvQe36F1BCvLgtLdfhmXhNmlOUXg3itzFOXbw9BMNNvMdZ0i8czcPbxdZ
         N1LlfF+h+9g5ndkORZk0YCIDB33uHubx9mtOAkEShMwSRP7lwEYf5i8foD7u0cFEGQ0q
         rF8g==
X-Gm-Message-State: AOAM5315j4HepWGWGRJg+tElTOVgygaPX8VGFwmYPBVmVnsxZHIcs2qW
        kWnE7Z8HNzRgF8xR5yoRKuw=
X-Google-Smtp-Source: ABdhPJwSLfre31yJDnmspUtYnPK3meECsPoudta3nkrbepu5i498WfpC83okFqD0CUbXxea4HxQTSw==
X-Received: by 2002:a05:600c:3b11:b0:394:57eb:c58b with SMTP id m17-20020a05600c3b1100b0039457ebc58bmr17454288wms.3.1652499295767;
        Fri, 13 May 2022 20:34:55 -0700 (PDT)
Received: from octofox.metropolis ([178.134.103.46])
        by smtp.gmail.com with ESMTPSA id h1-20020adfaa81000000b0020c66310845sm3542638wrc.55.2022.05.13.20.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 20:34:55 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 2/3] xtensa: support artificial division by 0 exception
Date:   Fri, 13 May 2022 20:34:36 -0700
Message-Id: <20220514033437.4182899-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220514033437.4182899-1-jcmvbkbc@gmail.com>
References: <20220514033437.4182899-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On xtensa cores wihout hardware division option division support
functions from libgcc react to division by 0 attempt by executing
illegal instruction followed by the characters 'DIV0'. Recognize this
pattern in illegal instruction exception handler and convert it to
division by 0.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:

- split ABI probing improvement from the artificial division by 0
- don't limit artificial division by 0 pattern detection to
  configurations without HW division opcodes, do it always

 arch/xtensa/kernel/traps.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 24d11b44fa57..47445b2d4217 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -293,12 +293,42 @@ static void do_interrupt(struct pt_regs *regs)
 	set_irq_regs(old_regs);
 }
 
+static int check_div0(struct pt_regs *regs)
+{
+	u8 buf[7];
+	void *p;
+	static const u8 pattern1[] = {0, 0, 0, 'D', 'I', 'V', '0'};
+#if defined(__XTENSA_EB__)
+	static const u8 pattern2[] = {0xd6, 0x0f, 'D', 'I', 'V', '0'};
+#elif defined(__XTENSA_EL__)
+	static const u8 pattern2[] = {0x6d, 0xf0, 'D', 'I', 'V', '0'};
+#else
+#error Unsupported Xtensa endianness
+#endif
+
+	if (user_mode(regs)) {
+		if (copy_from_user(buf, (void __user *)regs->pc, 7))
+			return 0;
+		p = buf;
+	} else {
+		p = (void *)regs->pc;
+	}
+
+	return memcmp(p, pattern1, sizeof(pattern1)) == 0 ||
+		memcmp(p, pattern2, sizeof(pattern2)) == 0;
+}
+
 /*
  * Illegal instruction. Fatal if in kernel space.
  */
 
 static void do_illegal_instruction(struct pt_regs *regs)
 {
+	if (check_div0(regs)) {
+		do_div0(regs);
+		return;
+	}
+
 	__die_if_kernel("Illegal instruction in kernel", regs, SIGKILL);
 
 	/* If in user mode, send SIGILL signal to current process. */
-- 
2.30.2

