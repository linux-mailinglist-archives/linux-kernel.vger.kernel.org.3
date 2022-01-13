Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B59A48D305
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 08:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiAMHkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 02:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiAMHkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 02:40:21 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3697BC06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 23:40:21 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id k30so8458742wrd.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 23:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=buKjcK+IXnIm9l70+VE2Pd1TwmP+HREbH5mPn//N1/s=;
        b=U6u5ny1x1930C4i86B9mZmmN+OeFxlt4taZmAUPY0nPo+3V5vF2bHuFlVx4IBTI9Hs
         SjbpRYhcn/bfjOa8WXlWPcZTnEfnN6kSKvJ8dxhHFgjymAPYgFkf+9DETw72fBRBeT6e
         uFeMirNLCD/22zFNFgBGJ4xewk3H3A4CJdUasyKpUuzpcn76oAC4DbNzDxeS24In5KXS
         iwk5TCYD+UQu3C/N1lrqeb+2dm7AfeHRM5eaZjzBEZv/uskwbEPLwOpIkrGeMbXRhx9r
         WX/jRQMJW4dofjEITi24/k7S3T9dnanonsSG5TGu4IcmLcdcLQe2QrX8DTn65FR0aoAM
         oP6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=buKjcK+IXnIm9l70+VE2Pd1TwmP+HREbH5mPn//N1/s=;
        b=CYmQfszsvW3ZXAStq8ICqO2+scsPSCraa1aFNFy0rJuF03KGNb2WknqYvpgPf+7+8Z
         Ml1X+22zcegDstBJ3f2cSv5+n+4p23uplNLZ6JHIUkV1AY+t473zTkdpMJrHlqKlF9na
         2ZTNrsPPFjcDqQTIAAfqITFUTEHUaU+BaBOPwDS5Yy7um6iWt39mjJF0Op8LPAA9AGTZ
         svYH0JEU7Q0OYRVSThT1RLDIbkZ5Mgaq5ZJ3eQkGPjIMxtCgvn8ewy9PcuMqAUAZd9OA
         /m07Zz4NtFLg4zXVDXzMtvSBTI8TYhdkSRhJA1+3pFIW85v9cPrXPTEmqKeptEjiYAXQ
         JULQ==
X-Gm-Message-State: AOAM531mxvw4/IomAAQAdVlbUh8KSWKpKdVujdzonvfqixwCXW1cTUbs
        Fy1I6PIS/0sG4VMD+mMVz+VPDjKh1J4=
X-Google-Smtp-Source: ABdhPJw9rRvlw41oWPiG5HPFAMzWLrSluCrJvwTTDo5ClFzc0W1zHtIe5n8UE60FCSlzybYJfUzxWQ==
X-Received: by 2002:adf:f784:: with SMTP id q4mr2909175wrp.655.1642059619533;
        Wed, 12 Jan 2022 23:40:19 -0800 (PST)
Received: from localhost.localdomain.at (62-178-82-229.cable.dynamic.surfer.at. [62.178.82.229])
        by smtp.gmail.com with ESMTPSA id o1sm6303046wmc.38.2022.01.12.23.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 23:40:19 -0800 (PST)
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Christian Gmeiner <christian.gmeiner@gmail.com>,
        Joe Hershberger <joe.hershberger@ni.com>,
        Ramon Fried <rfried.dev@gmail.com>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Heiko Schocher <hs@denx.de>,
        Roman Kovalivskyi <roman.kovalivskyi@globallogic.com>,
        Michal Simek <michal.simek@xilinx.com>, u-boot@lists.denx.de
Subject: [PATCH] net: fastboot: make UDP port net: configurable
Date:   Thu, 13 Jan 2022 08:40:06 +0100
Message-Id: <20220113074016.15163-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fastboot protocol uses per default the UDP port 5554. In some cases
it might be needed to change the used port. The fastboot utility provides
a way to specifiy an other port number to use already.

  fastboot -s udp:192.168.1.76:1234 boot fastboot.img

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/fastboot/Kconfig | 7 +++++++
 net/fastboot.c           | 5 +----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index d5e4a02098..b97c67bf60 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -21,6 +21,13 @@ config UDP_FUNCTION_FASTBOOT
 	help
 	  This enables the fastboot protocol over UDP.
 
+config UDP_FUNCTION_FASTBOOT_PORT
+	depends on UDP_FUNCTION_FASTBOOT
+	int "Define FASTBOOT UDP port"
+	default 5554
+	help
+	  The fastboot protocol requires a UDP port number.
+
 if FASTBOOT
 
 config FASTBOOT_BUF_ADDR
diff --git a/net/fastboot.c b/net/fastboot.c
index 7e7a601b9f..139233b86c 100644
--- a/net/fastboot.c
+++ b/net/fastboot.c
@@ -9,9 +9,6 @@
 #include <net.h>
 #include <net/fastboot.h>
 
-/* Fastboot port # defined in spec */
-#define WELL_KNOWN_PORT 5554
-
 enum {
 	FASTBOOT_ERROR = 0,
 	FASTBOOT_QUERY = 1,
@@ -310,7 +307,7 @@ void fastboot_start_server(void)
 	printf("Using %s device\n", eth_get_name());
 	printf("Listening for fastboot command on %pI4\n", &net_ip);
 
-	fastboot_our_port = WELL_KNOWN_PORT;
+	fastboot_our_port = CONFIG_UDP_FUNCTION_FASTBOOT_PORT;
 
 #if CONFIG_IS_ENABLED(FASTBOOT_FLASH)
 	fastboot_set_progress_callback(fastboot_timed_send_info);
-- 
2.34.1

