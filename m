Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48BB523063
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbiEKKMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241058AbiEKKL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:11:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36DD219351;
        Wed, 11 May 2022 03:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652263917; x=1683799917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qT65tmCMfEijFl2TpJ4TUU4guEKfSaXmRy66uEBzzr4=;
  b=gNbXcXavBUiUaKwMxkj3cq9N0J2CTPbttXn9nM/Ing3Y3ujIVjRJ0zsU
   HSX2tSJq/0eiT5XW/wUkUV0faQgP9c+oSsfhOWbYsI0NSn92h8VfUWG0s
   3gNfv7Pjn11Ix5KAiK35gZ/KosDUf1MVTetxjCsGX3/ZqUtvOnuMbNbAD
   zD7qdsuPS2+jyl4z8dNuPK6sbj93xhD4k8P4k8mwXoVu/tp2eA6AS1cTT
   Cl/yWZmrY9gQ1CjIfbrhhouNOcDzlX3xSnTFM0XsRsKvzaOQmNotwxJpn
   8Wf4V5WtQo8jSMlkow+IuA8KUUif/jp14pQl3ADcWp+oTpsIg4Wo6XI88
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="269590606"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="269590606"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 03:11:56 -0700
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="594049570"
Received: from meliyahx-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.32.210])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 03:11:52 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Oliver Neukum <oneukum@suse.com>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/5] tty/termbits: remove #ifdef CMSPAR that is always defined
Date:   Wed, 11 May 2022 13:11:35 +0300
Message-Id: <20220511101139.5306-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511101139.5306-1-ilpo.jarvinen@linux.intel.com>
References: <20220511101139.5306-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMSPAR is defined by all architectures.

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

