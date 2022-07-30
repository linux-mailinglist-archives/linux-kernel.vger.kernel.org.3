Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABA6585AE9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 17:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234741AbiG3PG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 11:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233963AbiG3PGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 11:06:52 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0942B13EA3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 08:06:51 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l23so13100507ejr.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 08:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=klIhpgpjVI+SL00xN+scPIDSahlHX34rp+bVRaPV3b8=;
        b=CImo7Ge9GNj9OLsEe8qGn42+9MH6TCglH9q7p+eghkxYYrtl0/+3t48xOkQk5xKpRX
         Pm34gtM5O47/qrQu2H0Q/9YBFe5w+iDUNUsotEN7mnn0LBWLvgiVgSRa236Q/yWMzWsQ
         KUByLKYHJm4liZGWUr74fgehTQdDceeAjDRLf1VGQTK13TWwbX6BkFFp+zdO7RSWqUID
         vGmIZPjPqDKVGg+9Rcd04JnQzDML4KakJichjhD06VD+KX5o3LY6AIz3i3191rfGeJtN
         xHgKxLDN2048yPzaHGsdHDhSydOKrAi6kFc47zwAXxlZR32ixMIl4++K7r809ChgGhwU
         jtug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=klIhpgpjVI+SL00xN+scPIDSahlHX34rp+bVRaPV3b8=;
        b=Bs/CBqHskutYGlJyEblt5wz2Bhqm+bwLd/2noJr5D1n7hEa/tYT3nQy2KinVFBxAlb
         DBmerkjxBVBv00PHLfZIpBnst3J0WrMXA5cfgb3xb6mx345SrV7LGAxfBY+wRU2exZEk
         dYMb+DXC044KlF70+AspEl4AZyt3Tr12o6MRccDxy+c4MRdiCpBqnCcvY0Nrtg1Ci+be
         DfkBtcnvMtuBep4DGjA6L9XtZkcJ6QfqzdXS1WBlWCZG1rNpvjoL6y/vZpQbHQY3A9jA
         7mr+5ac2lSsP+js8QSoO7/l/zED1K6di1Oa/ayN0fS4N/lNHIsmo0n5kL7oVyQnXiJZZ
         p+dA==
X-Gm-Message-State: AJIora+hnE7IAT7fiDc63pKykUAiSFd1DJBVM/7eBDAeY0zgsBpD98lr
        uc+jXKv5aoV+riEGdxDjyS0=
X-Google-Smtp-Source: AGRyM1vn8eQbJYS5loOfNWHHA/pv7ss1SrVio12c0I4iRvZLtuQbfQMxjWlUTDJlDB24X4Z67FW/oA==
X-Received: by 2002:a17:907:3e08:b0:72b:5af1:5f31 with SMTP id hp8-20020a1709073e0800b0072b5af15f31mr6655337ejc.277.1659193609518;
        Sat, 30 Jul 2022 08:06:49 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb9e.dynamic.kabel-deutschland.de. [95.90.187.158])
        by smtp.gmail.com with ESMTPSA id sy13-20020a1709076f0d00b00722d5b26ecesm3013989ejc.205.2022.07.30.08.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 08:06:49 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 2/2] staging: r8188eu: refactor dump_chip_info()
Date:   Sat, 30 Jul 2022 17:06:37 +0200
Message-Id: <20220730150637.3550-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220730150637.3550-1-straube.linux@gmail.com>
References: <20220730150637.3550-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the function dump_chip_info() to make the code cleaner and
reduce the driver object file size. Instead of using sprintf() to
print all the information to a buffer use a char pointer for the cut
version string and print the other strings directly by netdev_dbg().
For the unknown cut string we can use a smaller buffer and print to
that buffer with snprintf() to be safe.

These changes avoid the possible buffer overflow that the original
code had and reduces the driver object file size by 1029 bytes.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 32 ++++++++-----------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 012828a05e6c..1fc4ba45bf31 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -529,41 +529,35 @@ void rtl8188e_ReadEFuse(struct adapter *Adapter, u16 _size_byte, u8 *pbuf)
 static void dump_chip_info(struct adapter *adapter, struct HAL_VERSION chip_vers)
 {
 	struct net_device *netdev = adapter->pnetdev;
-	uint cnt = 0;
-	char buf[128];
-
-	cnt += sprintf((buf + cnt), "Chip Version Info: CHIP_8188E_");
-	cnt += sprintf((buf + cnt), "%s_", IS_NORMAL_CHIP(chip_vers) ?
-		       "Normal_Chip" : "Test_Chip");
-	cnt += sprintf((buf + cnt), "%s_", IS_CHIP_VENDOR_TSMC(chip_vers) ?
-		       "TSMC" : "UMC");
+	char *cut = NULL;
+	char buf[25];
 
 	switch (chip_vers.CUTVersion) {
 	case A_CUT_VERSION:
-		cnt += sprintf((buf + cnt), "A_CUT_");
+		cut = "A_CUT";
 		break;
 	case B_CUT_VERSION:
-		cnt += sprintf((buf + cnt), "B_CUT_");
+		cut = "B_CUT";
 		break;
 	case C_CUT_VERSION:
-		cnt += sprintf((buf + cnt), "C_CUT_");
+		cut = "C_CUT";
 		break;
 	case D_CUT_VERSION:
-		cnt += sprintf((buf + cnt), "D_CUT_");
+		cut = "D_CUT";
 		break;
 	case E_CUT_VERSION:
-		cnt += sprintf((buf + cnt), "E_CUT_");
+		cut = "E_CUT";
 		break;
 	default:
-		cnt += sprintf((buf + cnt), "UNKNOWN_CUT(%d)_", chip_vers.CUTVersion);
+		snprintf(buf, sizeof(buf), "UNKNOWN_CUT(%d)", chip_vers.CUTVersion);
+		cut = buf;
 		break;
 	}
 
-	cnt += sprintf((buf + cnt), "1T1R_");
-
-	cnt += sprintf((buf + cnt), "RomVer(%d)", 0);
-
-	netdev_dbg(netdev, "%s\n", buf);
+	netdev_dbg(netdev, "Chip Version Info: CHIP_8188E_%s_%s_%s_1T1R_RomVer(%d)\n",
+		   IS_NORMAL_CHIP(chip_vers) ? "Normal_Chip" : "Test_Chip",
+		   IS_CHIP_VENDOR_TSMC(chip_vers) ? "TSMC" : "UMC",
+		   cut, 0);
 }
 
 void rtl8188e_read_chip_version(struct adapter *padapter)
-- 
2.37.1

