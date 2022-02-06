Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6BD4AB09E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 17:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245251AbiBFQSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 11:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244634AbiBFQS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 11:18:26 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AF3C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 08:18:26 -0800 (PST)
Received: from ipservice-092-217-075-184.092.217.pools.vodafone-ip.de ([92.217.75.184] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1nGkF4-0001bS-12; Sun, 06 Feb 2022 17:18:22 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 06/14] staging: r8188eu: move local definitions into rtw_fw.h
Date:   Sun,  6 Feb 2022 17:18:01 +0100
Message-Id: <20220206161809.423031-7-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220206161809.423031-1-martin@kaiser.cx>
References: <20220206161809.423031-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move some defines and the definition of struct rt_firmware_hdr
from rtw_fw.h to rtw_fw.c. These definitions are used only by
the fw layer.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/core/rtw_fw.c    | 45 ++++++++++++++++++++++++
 drivers/staging/r8188eu/include/rtw_fw.h | 45 ------------------------
 2 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index fa29d47bf165..f591b091b8af 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -4,6 +4,51 @@
 #include <linux/firmware.h>
 #include "../include/rtw_fw.h"
 
+#define MAX_REG_BOLCK_SIZE	196
+#define FW_8188E_START_ADDRESS	0x1000
+#define MAX_PAGE_SIZE		4096
+
+#define IS_FW_HEADER_EXIST(_fwhdr)				\
+	((le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x92C0 ||	\
+	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x88C0 ||	\
+	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x2300 ||	\
+	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x88E0)
+
+/*  This structure must be careful with byte-ordering */
+
+struct rt_firmware_hdr {
+	/*  8-byte alinment required */
+	/*  LONG WORD 0 ---- */
+	__le16		Signature;	/* 92C0: test chip; 92C,
+					 * 88C0: test chip; 88C1: MP A-cut;
+					 * 92C1: MP A-cut */
+	u8		Category;	/*  AP/NIC and USB/PCI */
+	u8		Function;	/*  Reserved for different FW function
+					 *  indcation, for further use when
+					 *  driver needs to download different
+					 *  FW for different conditions */
+	__le16		Version;	/*  FW Version */
+	u8		Subversion;	/*  FW Subversion, default 0x00 */
+	u16		Rsvd1;
+
+	/*  LONG WORD 1 ---- */
+	u8		Month;	/*  Release time Month field */
+	u8		Date;	/*  Release time Date field */
+	u8		Hour;	/*  Release time Hour field */
+	u8		Minute;	/*  Release time Minute field */
+	__le16		RamCodeSize;	/*  The size of RAM code */
+	u8		Foundry;
+	u8		Rsvd2;
+
+	/*  LONG WORD 2 ---- */
+	__le32		SvnIdx;	/*  The SVN entry index */
+	u32		Rsvd3;
+
+	/*  LONG WORD 3 ---- */
+	u32		Rsvd4;
+	u32		Rsvd5;
+};
+
 static void fw_download_enable(struct adapter *padapter, bool enable)
 {
 	u8 tmp;
diff --git a/drivers/staging/r8188eu/include/rtw_fw.h b/drivers/staging/r8188eu/include/rtw_fw.h
index 2ee9ae70a468..c4b1a8370b4a 100644
--- a/drivers/staging/r8188eu/include/rtw_fw.h
+++ b/drivers/staging/r8188eu/include/rtw_fw.h
@@ -6,51 +6,6 @@
 
 #include "drv_types.h"
 
-#define MAX_REG_BOLCK_SIZE	196
-#define FW_8188E_START_ADDRESS	0x1000
-#define MAX_PAGE_SIZE		4096
-
-#define IS_FW_HEADER_EXIST(_fwhdr)				\
-	((le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x92C0 ||	\
-	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x88C0 ||	\
-	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x2300 ||	\
-	(le16_to_cpu(_fwhdr->Signature) & 0xFFF0) == 0x88E0)
-
-/*  This structure must be careful with byte-ordering */
-
-struct rt_firmware_hdr {
-	/*  8-byte alinment required */
-	/*  LONG WORD 0 ---- */
-	__le16		Signature;	/* 92C0: test chip; 92C,
-					 * 88C0: test chip; 88C1: MP A-cut;
-					 * 92C1: MP A-cut */
-	u8		Category;	/*  AP/NIC and USB/PCI */
-	u8		Function;	/*  Reserved for different FW function
-					 *  indcation, for further use when
-					 *  driver needs to download different
-					 *  FW for different conditions */
-	__le16		Version;	/*  FW Version */
-	u8		Subversion;	/*  FW Subversion, default 0x00 */
-	u16		Rsvd1;
-
-	/*  LONG WORD 1 ---- */
-	u8		Month;	/*  Release time Month field */
-	u8		Date;	/*  Release time Date field */
-	u8		Hour;	/*  Release time Hour field */
-	u8		Minute;	/*  Release time Minute field */
-	__le16		RamCodeSize;	/*  The size of RAM code */
-	u8		Foundry;
-	u8		Rsvd2;
-
-	/*  LONG WORD 2 ---- */
-	__le32		SvnIdx;	/*  The SVN entry index */
-	u32		Rsvd3;
-
-	/*  LONG WORD 3 ---- */
-	u32		Rsvd4;
-	u32		Rsvd5;
-};
-
 int rtl8188e_firmware_download(struct adapter *padapter);
 void rtw_reset_8051(struct adapter *padapter);
 
-- 
2.30.2

