Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410D152DFD1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 00:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiESWLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 18:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbiESWKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 18:10:53 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7351C167EF
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:10:51 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id k126so3626156wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/n44xoOryKJcZFu6Xfz+g9au5anLK+Qkeyz0hF8MUqQ=;
        b=fD1Xe3QOcC77JIQ4XEiPrZV7qvuj/XH9ZU2qRIHm2qhzGiWqEKHGGCcsCCWD9tuHYz
         QM93C9UfPRjghx5TWIy4P2Ilflw3T0WbnFjc4fR3IElPXcl/mfdz+NW3Pjr7RaYidGki
         ZjbHQ1oBtQuu30a5QFfEYGZIo7sxg5CHwcP8pbOmgqfUpPsEGSwSdfZhU/B5lAuVUi8/
         jscws8SFfVHxt57FprB27STK0PQx5pX5ZdZc8mtl2HRN3PYbjEKggoChWM6dg1Lsb4Nn
         p+hL2fbnpZ8MEXfaGb2pfllAFhB/2OISypxiFuHnbOB1vK3bPneKXdoK3gRCKL8UBSYg
         0kBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/n44xoOryKJcZFu6Xfz+g9au5anLK+Qkeyz0hF8MUqQ=;
        b=wWyk2sKLzO0enclFys1c2pu6kM08G09FSFoHsDTPPvq6d9vjhzVb7rnJTR80TfJxMz
         sUaPVVVWHDWLIa2jHAhtb2DgZZeErPRFpXtRfLMeM1awMurgXt/mFO5nZ/6IfsePqUWT
         1rcjgxtxplnnTfJn6RI6ID2WEf7VJC6Po8gq4vj/Nu6LDm8ZBGDqBxk0xJxezI6sZbRe
         bOJK95yEuViO0jXYsSHWl2sbNDZnO0t22kT9ZXICd4z46SqaeElMT93M89iDf7GyYDOx
         dTUriMil3qh5KOfMx6bxYcqLkrZ0zQeMy4XdASgX5P+2q7LpnAw/yrWskPlvDcD8I12G
         IugQ==
X-Gm-Message-State: AOAM531DL+EE0PIggJUwLHgio//0bsuVxhOEDPgt0zv5FQIm99Zj0/8Z
        Ytki67aCdfoNtsLpCm1UYodrTf/fQTOwrQ==
X-Google-Smtp-Source: ABdhPJz5dwcT7stTJgvKv7Y840VPbkPGBn/8LgqGfy4q+DcHY3VCniFZcEfg4YxYByynz2WSweWAcQ==
X-Received: by 2002:a1c:acc4:0:b0:392:9dd4:fbcc with SMTP id v187-20020a1cacc4000000b003929dd4fbccmr5617404wme.78.1652998250000;
        Thu, 19 May 2022 15:10:50 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id u16-20020a05600c035000b00396fbf6f524sm637407wmd.1.2022.05.19.15.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 15:10:49 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     straube.linux@gmail.com, martin@kaiser.cx,
        saurav.girepunje@gmail.com, abdun.nihaal@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH] staging: r8188eu: remove include/rtw_debug.h
Date:   Thu, 19 May 2022 23:10:47 +0100
Message-Id: <20220519221047.6940-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove include/rtw_debug.h, as all it now has are:

(1) A load of unused preprocessor definitions that expand to BIT(x)
    variants.
(2) A preprocessor definition that expands to the name of the driver
    and is only used in one place inside a pr_info_once call in
    core/rtw_fw.c.

It is now surplus to requirements after fixing up the few places that
include the file.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_fw.c        |  4 +-
 drivers/staging/r8188eu/include/drv_types.h  |  1 -
 drivers/staging/r8188eu/include/rtw_debug.h  | 45 --------------------
 drivers/staging/r8188eu/os_dep/ioctl_linux.c |  1 -
 4 files changed, 2 insertions(+), 49 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/rtw_debug.h

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index bf077876ed3d..0451e5177644 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -259,8 +259,8 @@ int rtl8188e_firmware_download(struct adapter *padapter)
 	fwhdr = (struct rt_firmware_hdr *)dvobj->firmware.data;
 
 	if (IS_FW_HEADER_EXIST(fwhdr)) {
-		pr_info_once("%sFirmware Version %d, SubVersion %d, Signature 0x%x\n",
-			     DRIVER_PREFIX, le16_to_cpu(fwhdr->version), fwhdr->subversion,
+		pr_info_once("R8188EU: Firmware Version %d, SubVersion %d, Signature 0x%x\n",
+			     le16_to_cpu(fwhdr->version), fwhdr->subversion,
 			     le16_to_cpu(fwhdr->signature));
 
 		fw_data = fw_data + sizeof(struct rt_firmware_hdr);
diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index ffab2ee0848a..bba88a0ede61 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -26,7 +26,6 @@
 #include "rtw_eeprom.h"
 #include "sta_info.h"
 #include "rtw_mlme.h"
-#include "rtw_debug.h"
 #include "rtw_rf.h"
 #include "rtw_event.h"
 #include "rtw_led.h"
diff --git a/drivers/staging/r8188eu/include/rtw_debug.h b/drivers/staging/r8188eu/include/rtw_debug.h
deleted file mode 100644
index 84ec068596e7..000000000000
--- a/drivers/staging/r8188eu/include/rtw_debug.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright(c) 2007 - 2011 Realtek Corporation. */
-
-#ifndef __RTW_DEBUG_H__
-#define __RTW_DEBUG_H__
-
-#include "osdep_service.h"
-#include "drv_types.h"
-
-#define _module_rtl871x_xmit_c_		BIT(0)
-#define _module_xmit_osdep_c_		BIT(1)
-#define _module_rtl871x_recv_c_		BIT(2)
-#define _module_recv_osdep_c_		BIT(3)
-#define _module_rtl871x_mlme_c_		BIT(4)
-#define _module_mlme_osdep_c_		BIT(5)
-#define _module_rtl871x_sta_mgt_c_	BIT(6)
-#define _module_rtl871x_cmd_c_		BIT(7)
-#define _module_cmd_osdep_c_		BIT(8)
-#define _module_rtl871x_io_c_		BIT(9)
-#define _module_io_osdep_c_		BIT(10)
-#define _module_os_intfs_c_		BIT(11)
-#define _module_rtl871x_security_c_	BIT(12)
-#define _module_rtl871x_eeprom_c_	BIT(13)
-#define _module_hal_init_c_		BIT(14)
-#define _module_hci_hal_init_c_		BIT(15)
-#define _module_rtl871x_ioctl_c_	BIT(16)
-#define _module_rtl871x_ioctl_set_c_	BIT(17)
-#define _module_rtl871x_ioctl_query_c_	BIT(18)
-#define _module_rtl871x_pwrctrl_c_	BIT(19)
-#define _module_hci_intfs_c_		BIT(20)
-#define _module_hci_ops_c_		BIT(21)
-#define _module_osdep_service_c_	BIT(22)
-#define _module_mp_			BIT(23)
-#define _module_hci_ops_os_c_		BIT(24)
-#define _module_rtl871x_ioctl_os_c	BIT(25)
-#define _module_rtl8712_cmd_c_		BIT(26)
-#define	_module_rtl8192c_xmit_c_	BIT(27)
-#define _module_hal_xmit_c_		BIT(28)
-#define _module_efuse_			BIT(29)
-#define _module_rtl8712_recv_c_		BIT(30)
-#define _module_rtl8712_led_c_		BIT(31)
-
-#define DRIVER_PREFIX	"R8188EU: "
-
-#endif	/* __RTW_DEBUG_H__ */
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 9c1f576e067a..1b09462ca908 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -4,7 +4,6 @@
 #include "../include/osdep_service.h"
 #include "../include/drv_types.h"
 #include "../include/wlan_bssdef.h"
-#include "../include/rtw_debug.h"
 #include "../include/wifi.h"
 #include "../include/rtw_mlme.h"
 #include "../include/rtw_mlme_ext.h"
-- 
2.35.3

