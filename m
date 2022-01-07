Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BB748791E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347802AbiAGOgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239407AbiAGOge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:36:34 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A452C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 06:36:34 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id q25so14220629edb.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 06:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7zGG2BUcPxjJcB8VS30UzBpKUquZsLnhUOw3ylHv7e0=;
        b=K8QE3cM86jKxSxqgLfoSgtFm5i+vt8KIjfU5tWxP4r6/EbVXov9ZAIhKvmhKUnpEUd
         I25w+8MgmaEYi2FH5IKy2xnw5kUwrw+arMHgR2Jv7I/hMh30DGRQv9aAfTYpp52lKWCA
         F9C9jgcKrWAkGwX/TiZg3MyWDVwe4YaWxiZCPxgOwOVNYASAvingdfND8bA5kKiK9MIb
         fvQf4yXFpL1rdMn0pIBgqFer3b/cCqOLDiQKBl9QZD98DlawBiAmMxQrKOAx7daXUihh
         f7Sl/045HwLujIAwWqvRtl19jh24KAWDEyILizw/s5X54ooyas+9fZrPt0E9dE8XyaMm
         RGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7zGG2BUcPxjJcB8VS30UzBpKUquZsLnhUOw3ylHv7e0=;
        b=s7sLLVh4YPAtPwoOMQXq/rFeaoNLh35QI7U9VNLDrAzJxwjro1jDDPrpdqSC7EHDNM
         6dXjqrb8eoERYFJXzoNV8QNGOBGjpoFPMslRq9bor8njnALkGmKSO9XVTMwlBHZCAQKu
         m4lECj9Yict0nwz3bzwAl57nANlyRJ/MhIWgeAZTcjRGAz+rqpCQ4hIa9N29pkOTim7A
         lIzishPQGWrq80nXu3C0TgeMpDl70KNm7Qb8PfrO+FHw8ZJgcLMhgU4tuFJsma24Azxy
         BSF4ay0C5qL0APIYa7rt9Nz5OpyVG22PJ44/ZzGubO5Z9WrQBAJasKWiKZQuHLBExG14
         R6Tw==
X-Gm-Message-State: AOAM533paoc1YttJvITax6QphnDQYf4W6PiGmSoPkzRk3VhaRnBxBk8H
        t/TJs9jSoHZ981XzZlEb2FU=
X-Google-Smtp-Source: ABdhPJx0A/+6PTy+KmnzHzyARPh8lIaDRmL2pl1aAmCtdboxQ9u3IFK1cYEW6VpZELPQF+sfP+z2zA==
X-Received: by 2002:a50:fd9a:: with SMTP id o26mr23502393edt.199.1641566193140;
        Fri, 07 Jan 2022 06:36:33 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id b4sm1445181ejl.206.2022.01.07.06.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 06:36:32 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: r8188eu: move firmware related macros to rtw_fw.h
Date:   Fri,  7 Jan 2022 15:36:17 +0100
Message-Id: <20220107143617.2214-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107143617.2214-1-straube.linux@gmail.com>
References: <20220107143617.2214-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move firmware related macros from rtl8188e_hal.h to rtw_fw.h.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/rtl8188e_hal.h | 11 -----------
 drivers/staging/r8188eu/include/rtw_fw.h       | 10 +++++++++-
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index dad2aa473a1c..d9e944a83940 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -34,17 +34,6 @@
 #define DRVINFO_SZ	4 /*  unit is 8bytes */
 #define PageNum_128(_Len)	(u32)(((_Len)>>7) + ((_Len) & 0x7F ? 1 : 0))
 
-/*  download firmware related data structure */
-#define FW_8188E_START_ADDRESS		0x1000
-
-#define MAX_PAGE_SIZE			4096	/*  @ page : 4k bytes */
-
-#define IS_FW_HEADER_EXIST(_fwhdr)				\
-	((le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x92C0 ||	\
-	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x88C0 ||	\
-	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x2300 ||	\
-	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x88E0)
-
 /*  This structure must be careful with byte-ordering */
 
 struct rt_firmware_hdr {
diff --git a/drivers/staging/r8188eu/include/rtw_fw.h b/drivers/staging/r8188eu/include/rtw_fw.h
index 749157704251..9b7492ef0199 100644
--- a/drivers/staging/r8188eu/include/rtw_fw.h
+++ b/drivers/staging/r8188eu/include/rtw_fw.h
@@ -6,7 +6,15 @@
 
 #include "drv_types.h"
 
-#define MAX_REG_BOLCK_SIZE 196
+#define MAX_REG_BOLCK_SIZE	196
+#define FW_8188E_START_ADDRESS	0x1000
+#define MAX_PAGE_SIZE		4096
+
+#define IS_FW_HEADER_EXIST(_fwhdr)				\
+	((le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x92C0 ||	\
+	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x88C0 ||	\
+	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x2300 ||	\
+	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x88E0)
 
 int rtl8188e_firmware_download(struct adapter *padapter);
 void rtw_reset_8051(struct adapter *padapter);
-- 
2.34.1

