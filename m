Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084ED58AE1F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237902AbiHEQ2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiHEQ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:28:06 -0400
Received: from mx01.ayax.eu (mx01.ayax.eu [188.137.98.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AE61137
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 09:28:04 -0700 (PDT)
Received: from [192.168.192.146] (port=52112 helo=nx64de-df6d00)
        by mx01.ayax.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gszymaszek@short.pl>)
        id 1oK0Ao-0007pU-My; Fri, 05 Aug 2022 18:27:46 +0200
Date:   Fri, 5 Aug 2022 18:27:41 +0200
From:   Grzegorz Szymaszek <gszymaszek@short.pl>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        Grzegorz Szymaszek <gszymaszek@short.pl>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2 1/4] staging: r8188eu: set firmware path in a macro
Message-ID: <60dc57fc73e8e6e8e3aaae68784f4be932547bf5.1659715931.git.gszymaszek@short.pl>
Mail-Followup-To: Grzegorz Szymaszek <gszymaszek@short.pl>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <cover.1659715931.git.gszymaszek@short.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1659715931.git.gszymaszek@short.pl>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The r8188eu driver requires a firmware file, the path of which was
hardcoded as constant strings in two places:
(1) in core/rtw_fw.c, in function load_firmware(),
(2) in os_dep/os_intfs.c, in the MODULE_FIRMWARE() call.

Declare the path using a macro, FW_RTL8188EU, and replace the above
constant strings with the macro. That's the way it is done in many other
drivers. The new macro is defined in include/drv_types.h, because that
file is already included by both of the above files (or at least their
headers) and because it already contains other driver constants, like
its name and version.

Link: https://lore.kernel.org/lkml/YuoQ37PIKzWO1zIY@kroah.com/
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Grzegorz Szymaszek <gszymaszek@short.pl>
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
---
V1->V2: Added Philipp Hortmann's Tested-by

 drivers/staging/r8188eu/core/rtw_fw.c       | 2 +-
 drivers/staging/r8188eu/include/drv_types.h | 1 +
 drivers/staging/r8188eu/os_dep/os_intfs.c   | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_fw.c b/drivers/staging/r8188eu/core/rtw_fw.c
index 0451e5177644..0fe6d4944694 100644
--- a/drivers/staging/r8188eu/core/rtw_fw.c
+++ b/drivers/staging/r8188eu/core/rtw_fw.c
@@ -209,7 +209,7 @@ static int load_firmware(struct rt_firmware *rtfw, struct device *device)
 {
 	int ret = _SUCCESS;
 	const struct firmware *fw;
-	const char *fw_name = "rtlwifi/rtl8188eufw.bin";
+	const char *fw_name = FW_RTL8188EU;
 	int err = request_firmware(&fw, fw_name, device);
 
 	if (err) {
diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index bba88a0ede61..f51b83515953 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -37,6 +37,7 @@
 #include "rtw_fw.h"
 
 #define DRIVERVERSION	"v4.1.4_6773.20130222"
+#define FW_RTL8188EU	"rtlwifi/rtl8188eufw.bin"
 
 struct registry_priv {
 	u8	chip_version;
diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
index 5bd3022e4b40..5985054da935 100644
--- a/drivers/staging/r8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
@@ -18,7 +18,7 @@ MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Realtek Wireless Lan Driver");
 MODULE_AUTHOR("Realtek Semiconductor Corp.");
 MODULE_VERSION(DRIVERVERSION);
-MODULE_FIRMWARE("rtlwifi/rtl8188eufw.bin");
+MODULE_FIRMWARE(FW_RTL8188EU);
 
 #define CONFIG_BR_EXT_BRNAME "br0"
 #define RTW_NOTCH_FILTER 0 /* 0:Disable, 1:Enable, */
-- 
2.35.1
