Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB94589462
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 00:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238916AbiHCW3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 18:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238884AbiHCW3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 18:29:13 -0400
Received: from mx01.ayax.eu (mx01.ayax.eu [188.137.98.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540E15C94D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 15:29:11 -0700 (PDT)
Received: from [192.168.192.146] (port=40528 helo=nx64de-df6d00)
        by mx01.ayax.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gszymaszek@short.pl>)
        id 1oJMrB-0008T8-Ia; Thu, 04 Aug 2022 00:28:52 +0200
Date:   Thu, 4 Aug 2022 00:28:48 +0200
From:   Grzegorz Szymaszek <gszymaszek@short.pl>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>
Cc:     Grzegorz Szymaszek <gszymaszek@short.pl>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 1/3] staging: r8188eu: set firmware path in a macro
Message-ID: <6c83e05e5dbccff5630ccfed9e40bf84c889b647.1659565180.git.gszymaszek@short.pl>
Mail-Followup-To: Grzegorz Szymaszek <gszymaszek@short.pl>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <YuoQ37PIKzWO1zIY@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
---
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
