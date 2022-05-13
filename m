Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33BC525DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378221AbiEMI31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiEMI3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:29:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09393291CF5;
        Fri, 13 May 2022 01:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652430564; x=1683966564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R3lDYtnHrNPVHv2um+g488BAuAfzyGmmPeOLDwrFMDk=;
  b=NCv6jc9LDNSRY/w6LCgp3MAUHlaQSfyEAisz9kykzQhXyEQOdAZEygi8
   OoXCn2OI+1xxJ418SzcgjwDS7KuI6rVDqAb9vGMiifM8YC9/I+3luSwl9
   /kixXX7IOAZmgn628dpTp3HEb8I7BEkm+iLGCm0/GNVQgHokYDN1YwTf+
   0DZEnK23DM+KUkmBLEPcr2GCHuVQqejS7sBDMnCN4Zh7Cw9ct8KWyv+4k
   Ee5ira948eFQw34BT8ZowuoAogEdJlUr5x6WjxEejkJ8fzpxuwQVkep46
   FOzhv1JTGSzK4xxtlIVClyEGZE3HwmsKpXid5Utl7DwsS7HN/IfH41BiF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="270385178"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="270385178"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 01:29:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="567107469"
Received: from huberth-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.34.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 01:29:20 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 1/5] tty: remove CMSPAR ifdefs
Date:   Fri, 13 May 2022 11:29:02 +0300
Message-Id: <20220513082906.11096-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220513082906.11096-1-ilpo.jarvinen@linux.intel.com>
References: <20220513082906.11096-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMSPAR is defined by all architectures since commit 6bf08cb246b5
("[PATCH] Add CMSPAR to termbits.h for powerpc and alpha").

Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/char/pcmcia/synclink_cs.c   | 2 --
 drivers/tty/amiserial.c             | 2 --
 drivers/tty/serial/8250/8250_port.c | 2 --
 drivers/tty/serial/jsm/jsm_cls.c    | 6 ------
 drivers/tty/serial/jsm/jsm_neo.c    | 6 ------
 drivers/tty/serial/sunsu.c          | 2 --
 drivers/usb/class/cdc-acm.h         | 8 --------
 drivers/usb/serial/ark3116.c        | 3 +--
 drivers/usb/serial/whiteheat.c      | 4 ----
 9 files changed, 1 insertion(+), 34 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 78baba55a8b5..c20f2cb784e8 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -1432,10 +1432,8 @@ static void mgslpc_change_params(MGSLPC_INFO *info, struct tty_struct *tty)
 			info->params.parity = ASYNC_PARITY_ODD;
 		else
 			info->params.parity = ASYNC_PARITY_EVEN;
-#ifdef CMSPAR
 		if (cflag & CMSPAR)
 			info->params.parity = ASYNC_PARITY_SPACE;
-#endif
 	}
 
 	/* calculate number of jiffies to transmit a full
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 533d02b38e02..afb2d373dd47 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -588,10 +588,8 @@ static void change_speed(struct tty_struct *tty, struct serial_state *info,
 	}
 	if (!(cflag & PARODD))
 		cval |= UART_LCR_EPAR;
-#ifdef CMSPAR
 	if (cflag & CMSPAR)
 		cval |= UART_LCR_SPAR;
-#endif
 
 	/* Determine divisor based on baud rate */
 	baud = tty_get_baud_rate(tty);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 5591f18f2ea9..78b6dedc43e6 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2620,10 +2620,8 @@ static unsigned char serial8250_compute_lcr(struct uart_8250_port *up,
 	}
 	if (!(c_cflag & PARODD))
 		cval |= UART_LCR_EPAR;
-#ifdef CMSPAR
 	if (c_cflag & CMSPAR)
 		cval |= UART_LCR_SPAR;
-#endif
 
 	return cval;
 }
diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
index 444f233ebd1f..046b624e5f71 100644
--- a/drivers/tty/serial/jsm/jsm_cls.c
+++ b/drivers/tty/serial/jsm/jsm_cls.c
@@ -723,14 +723,8 @@ static void cls_param(struct jsm_channel *ch)
 	if (!(ch->ch_c_cflag & PARODD))
 		lcr |= UART_LCR_EPAR;
 
-	/*
-	 * Not all platforms support mark/space parity,
-	 * so this will hide behind an ifdef.
-	 */
-#ifdef CMSPAR
 	if (ch->ch_c_cflag & CMSPAR)
 		lcr |= UART_LCR_SPAR;
-#endif
 
 	if (ch->ch_c_cflag & CSTOPB)
 		lcr |= UART_LCR_STOP;
diff --git a/drivers/tty/serial/jsm/jsm_neo.c b/drivers/tty/serial/jsm/jsm_neo.c
index 110696cdaa1d..0cf586c10688 100644
--- a/drivers/tty/serial/jsm/jsm_neo.c
+++ b/drivers/tty/serial/jsm/jsm_neo.c
@@ -997,14 +997,8 @@ static void neo_param(struct jsm_channel *ch)
 	if (!(ch->ch_c_cflag & PARODD))
 		lcr |= UART_LCR_EPAR;
 
-	/*
-	 * Not all platforms support mark/space parity,
-	 * so this will hide behind an ifdef.
-	 */
-#ifdef CMSPAR
 	if (ch->ch_c_cflag & CMSPAR)
 		lcr |= UART_LCR_SPAR;
-#endif
 
 	if (ch->ch_c_cflag & CSTOPB)
 		lcr |= UART_LCR_STOP;
diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index c31389114b86..fff50b5b82eb 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -798,10 +798,8 @@ sunsu_change_speed(struct uart_port *port, unsigned int cflag,
 		cval |= UART_LCR_PARITY;
 	if (!(cflag & PARODD))
 		cval |= UART_LCR_EPAR;
-#ifdef CMSPAR
 	if (cflag & CMSPAR)
 		cval |= UART_LCR_SPAR;
-#endif
 
 	/*
 	 * Work around a bug in the Oxford Semiconductor 952 rev B
diff --git a/drivers/usb/class/cdc-acm.h b/drivers/usb/class/cdc-acm.h
index 3aa7f0a3ad71..d26ecd15be60 100644
--- a/drivers/usb/class/cdc-acm.h
+++ b/drivers/usb/class/cdc-acm.h
@@ -7,14 +7,6 @@
  *
  */
 
-/*
- * CMSPAR, some architectures can't have space and mark parity.
- */
-
-#ifndef CMSPAR
-#define CMSPAR			0
-#endif
-
 /*
  * Major and minor numbers.
  */
diff --git a/drivers/usb/serial/ark3116.c b/drivers/usb/serial/ark3116.c
index c0e4df87ff22..39eaa7b97c40 100644
--- a/drivers/usb/serial/ark3116.c
+++ b/drivers/usb/serial/ark3116.c
@@ -208,10 +208,9 @@ static void ark3116_set_termios(struct tty_struct *tty,
 		lcr |= UART_LCR_PARITY;
 	if (!(cflag & PARODD))
 		lcr |= UART_LCR_EPAR;
-#ifdef CMSPAR
 	if (cflag & CMSPAR)
 		lcr |= UART_LCR_SPAR;
-#endif
+
 	/* handshake control */
 	hcr = (cflag & CRTSCTS) ? 0x03 : 0x00;
 
diff --git a/drivers/usb/serial/whiteheat.c b/drivers/usb/serial/whiteheat.c
index 06aad0d727dd..332fb92ae575 100644
--- a/drivers/usb/serial/whiteheat.c
+++ b/drivers/usb/serial/whiteheat.c
@@ -30,10 +30,6 @@
 #include <linux/usb/ezusb.h>
 #include "whiteheat.h"			/* WhiteHEAT specific commands */
 
-#ifndef CMSPAR
-#define CMSPAR 0
-#endif
-
 /*
  * Version Information
  */
-- 
2.30.2

