Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686CB4BCA9E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 21:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243125AbiBSUkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 15:40:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbiBSUkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 15:40:22 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEF9B7E0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 12:40:00 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d27so20198132wrc.6
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 12:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9MVIzOhhFVrqb+O9seRvzRjJKrnabh0ef9RGnj5egx0=;
        b=GqEmVAJN25pVd1XzMJhV+AXrYmOgKc/gT9JjMOR8U87xRVITzDAZMm/jkE+PVc4AFy
         NHaazPZZ49aDlIa/hfdz77GEpza+HYkfgi750vBTMB8Y5Zrk9TquMCWEssg7DNaar2N4
         z8tjPN+4ZlSsvWuc323WvzQxLDc8F/NSjyXhRrJl5N/r7B0QeMqKbXBONLYBhJfx/E73
         xZ96kcF79UVW10YBoQgcXxAMJ/TEQFg1/5awrXa23xxuRDfuNkzP3XVA3i/JsT8PWzy5
         HPrwe8ci6BF8puQADw0bAXLz1t33TsrFtbEMM1ureYtnyaE98N7cIAkZnkqe+sK5TrfN
         +Elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9MVIzOhhFVrqb+O9seRvzRjJKrnabh0ef9RGnj5egx0=;
        b=joatMMPcxQwaUVEQhZph8RzY7pr+akVkPbhZMLRAqrmLeDbm5LoXESRT/busdj2Sb9
         HtOKlpWp3cKgbQr4tkUKrOMW6wFmaGUnGi5E4GkTBSe9/B7TG+r0CoyJ3N66TLmtl0za
         nNELzcayqNm4u0SpPUL3PsEHrwxL+2yNY8Sk+4XZB3SdL57NIgxb+L+1BvHTRaf2UMht
         CZxxvRmeDig9Bw3Bntq1TqVXA2AcJbqBnonaMqtkxej0+6VMybn+3dSMiBHytGuP7mwD
         cnjNayrzcR4UnobfBs9DEux8/4VWLCtd4hd2U+//RNqG06LpeNHqxnX83x3kOQs2EcOY
         y34w==
X-Gm-Message-State: AOAM532iuU5nh1oYyFOtlJAkAHu6FRImn7pPgjo9N2zbbBQxGk0+boAw
        IiySS7ADPd6jupMnfZ6rQ6c=
X-Google-Smtp-Source: ABdhPJzSMe3s3NyVZhHQkDVanj+D9XKNpScFUjHoRtRUXclbZSGHu+lOxsefqQK/rs+O/vTPnNmZag==
X-Received: by 2002:a5d:64c9:0:b0:1e4:a048:8e1d with SMTP id f9-20020a5d64c9000000b001e4a0488e1dmr10323607wri.74.1645303198855;
        Sat, 19 Feb 2022 12:39:58 -0800 (PST)
Received: from localhost.localdomain ([217.61.0.106])
        by smtp.gmail.com with ESMTPSA id b10sm51374279wrd.8.2022.02.19.12.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 12:39:58 -0800 (PST)
From:   Hans Weber <hwe.kernel@gmail.com>
To:     torvalds@evo.osdl.org
Cc:     linux-kernel@vger.kernel.org, Hans Weber <hwe.kernel@gmail.com>
Subject: [PATCH] only call the c function set_bios_mode if the value CONFIG_X86_64 is set.
Date:   Sat, 19 Feb 2022 21:39:50 +0100
Message-Id: <20220219203950.106655-1-hwe.kernel@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Signed-off-by: Hans Weber <hwe.kernel@gmail.com>
---
 arch/x86/boot/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/main.c b/arch/x86/boot/main.c
index e3add857c2c9..e4df8ff1e228 100644
--- a/arch/x86/boot/main.c
+++ b/arch/x86/boot/main.c
@@ -102,14 +102,12 @@ static void query_ist(void)
  */
 static void set_bios_mode(void)
 {
-#ifdef CONFIG_X86_64
 	struct biosregs ireg;
 
 	initregs(&ireg);
 	ireg.ax = 0xec00;
 	ireg.bx = 2;
 	intcall(0x15, &ireg, NULL);
-#endif
 }
 
 static void init_heap(void)
@@ -152,7 +150,9 @@ void main(void)
 	}
 
 	/* Tell the BIOS what CPU mode we intend to run in. */
+#ifdef CONFIG_X86_64
 	set_bios_mode();
+#endif
 
 	/* Detect memory layout */
 	detect_memory();
-- 
2.30.2

