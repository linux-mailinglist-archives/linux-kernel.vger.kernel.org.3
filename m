Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED904D6F9B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 15:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiCLOyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 09:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiCLOyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 09:54:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 193EC5BD1C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 06:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647096819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=idEHkhQAaOBliwENS0wsp/XJ+A6XVFB7baxao15C+mw=;
        b=UbBFl/vXPIqBnVs0oLDaHY5nCVFWOejUfWSJtUuPBj2KSMepMu7uTgTkTzo9DMvmepL8lK
        KqyEyHwPjCBF1tAn1wgj+3u6MrHdvht1qOhlxgOuk10bBNhUAW+ThgUp/m5sO8oN/Xgmf0
        gcG5f9ZAv4uA4zQ/0CSCzy3A2FZ+7nk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-39-jLsQsa08PvSmtdN7_u5PrQ-1; Sat, 12 Mar 2022 09:53:38 -0500
X-MC-Unique: jLsQsa08PvSmtdN7_u5PrQ-1
Received: by mail-qv1-f72.google.com with SMTP id j6-20020a056214032600b004358f15c51bso10146977qvu.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 06:53:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=idEHkhQAaOBliwENS0wsp/XJ+A6XVFB7baxao15C+mw=;
        b=opeHZLBzBp1m+looA8wqgd4/v+60ECHqjr2Z0uar5c/LkmuA81ercNj+cwgxeFVzae
         YoRMf45W4xXRYcMl9pprx0SiZRR/kxoMu+bRoF85YIKCcc/cfpckpAXiUtR9Mh2/Awgb
         e3X9l/2ibq04MgJ2Ax7t+cPaqn5j8g5QAmnW4hWFxM3V93xKANqD7oxt5HT/Nt+uYx1t
         puh2/Gd3XBZn1dhd31joFptdp1350bYxhnuSO3f0p7JrFDxFWX0stLFaHTsEFX+UsNyk
         Jwcr8GqdOr8hwuyX8LKhoo66E8/lDnpny5wOakiXYVYYo2pmsrvtQ7IQI0A/lGdzLiG0
         cnAw==
X-Gm-Message-State: AOAM5313aXlzdA5LyjIg6IC9FQfscrjjtmXwg2vN6HArkVAApd9QrdHp
        nLMmWQ1cXC7vcrjuhRZ2MuPVOfypD/HfbpI9maJffKmGj1pDGnF7dQkdk/t5FrSnCBKSXrU8qjo
        iH+fRVRd1YPQsOztXzbr79wSL
X-Received: by 2002:a05:622a:1a12:b0:2e1:a631:aecc with SMTP id f18-20020a05622a1a1200b002e1a631aeccmr12502467qtb.383.1647096817446;
        Sat, 12 Mar 2022 06:53:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyedg6i9wIc8nITyii9SK3A7/ikxZR+w6n+U2G2GpCA5FFJbmerz+UION3dSN4kxgzqvNDuqA==
X-Received: by 2002:a05:622a:1a12:b0:2e1:a631:aecc with SMTP id f18-20020a05622a1a1200b002e1a631aeccmr12502459qtb.383.1647096817232;
        Sat, 12 Mar 2022 06:53:37 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id h62-20020a37b741000000b0067da4164f8fsm669640qkf.126.2022.03.12.06.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 06:53:36 -0800 (PST)
From:   trix@redhat.com
To:     hmh@hmh.eng.br, hdegoede@redhat.com, markgross@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] platform/x86: thinkpad_acpi: consistently check fan_get_status return.
Date:   Sat, 12 Mar 2022 06:53:27 -0800
Message-Id: <20220312145327.1398510-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis returns this false positive
thinkpad_acpi.c:8926:19: warning: The left operand
  of '!=' is a garbage value
  (status != 0) ? "enabled" : "disabled", status);
   ~~~~~~ ^

The return of fan_get_status* is checked inconsistenly.
Sometime ret < 0 is an error, sometimes !ret.
Both fan_get_status() and fan_get_status_safe() return
0 on success and return negative otherwise.  Change
the checks for error, ret < 0, into checks for
not success, !ret.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 708743ec9ae79..c568fae56db29 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -8285,7 +8285,7 @@ static int fan_set_enable(void)
 	case TPACPI_FAN_WR_ACPI_FANS:
 	case TPACPI_FAN_WR_TPEC:
 		rc = fan_get_status(&s);
-		if (rc < 0)
+		if (rc)
 			break;
 
 		/* Don't go out of emergency fan mode */
@@ -8304,7 +8304,7 @@ static int fan_set_enable(void)
 
 	case TPACPI_FAN_WR_ACPI_SFAN:
 		rc = fan_get_status(&s);
-		if (rc < 0)
+		if (rc)
 			break;
 
 		s &= 0x07;
@@ -8843,7 +8843,7 @@ static void fan_suspend(void)
 	/* Store fan status in cache */
 	fan_control_resume_level = 0;
 	rc = fan_get_status_safe(&fan_control_resume_level);
-	if (rc < 0)
+	if (rc)
 		pr_notice("failed to read fan level for later restore during resume: %d\n",
 			  rc);
 
@@ -8864,7 +8864,7 @@ static void fan_resume(void)
 
 	if (!fan_control_allowed ||
 	    !fan_control_resume_level ||
-	    (fan_get_status_safe(&current_level) < 0))
+	    fan_get_status_safe(&current_level))
 		return;
 
 	switch (fan_control_access_mode) {
@@ -8918,7 +8918,7 @@ static int fan_read(struct seq_file *m)
 	case TPACPI_FAN_RD_ACPI_GFAN:
 		/* 570, 600e/x, 770e, 770x */
 		rc = fan_get_status_safe(&status);
-		if (rc < 0)
+		if (rc)
 			return rc;
 
 		seq_printf(m, "status:\t\t%s\n"
@@ -8929,7 +8929,7 @@ static int fan_read(struct seq_file *m)
 	case TPACPI_FAN_RD_TPEC:
 		/* all except 570, 600e/x, 770e, 770x */
 		rc = fan_get_status_safe(&status);
-		if (rc < 0)
+		if (rc)
 			return rc;
 
 		seq_printf(m, "status:\t\t%s\n",
-- 
2.26.3

