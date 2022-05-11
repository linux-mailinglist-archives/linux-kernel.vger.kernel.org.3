Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2576523064
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241233AbiEKKMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241251AbiEKKMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:12:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9588E219C0F;
        Wed, 11 May 2022 03:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652263922; x=1683799922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OajAcCL4GLLOQVS3OgxcTyGgmlGtQZm2wsY2c+GtBpo=;
  b=TmINRHJ0desV1UFvOW4olf21FcRsXMhueMzV7l8GA1v6yxzo2zlaMrjQ
   4+vON9+uvfT87R12B/KvEC2iprFEPmCpgyzLgyM2qNLnTIrrOkU+D5F2y
   xaEZQEIt1aZg2WWd6MNKihDvCuDlwF/CadVUJuaHP+WqGJyWKiTuPCrGr
   tjFVHFbh8vR7uHkAswCay7mhEagUwtHm29nGifxG1TeaQIytBt/4OA5VW
   +dXcsYgahFOKjSE9A5YMd2SW6ZAI+tF50+2ITkMjsroGeCVCxk0rbXe0H
   /3t0uaQI4SB8eCNsEzkjrkVI+j1CnfF8Y16lMrDTkYWZY3ksa8dw2sekh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="250184330"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="250184330"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 03:12:02 -0700
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="594049598"
Received: from meliyahx-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.32.210])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 03:11:57 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/5] tty/termbits: remove #ifdef BOTHER that is always defined
Date:   Wed, 11 May 2022 13:11:36 +0300
Message-Id: <20220511101139.5306-3-ilpo.jarvinen@linux.intel.com>
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

BOTHER is defined by all architectures.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/mxser.c        |  2 --
 drivers/tty/tty_baudrate.c | 20 +++++---------------
 drivers/tty/tty_ioctl.c    |  2 --
 3 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 6ebd3e4ed859..9ea7bd059d0f 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -528,7 +528,6 @@ static int mxser_set_baud(struct tty_struct *tty, speed_t newspd)
 	outb(quot >> 8, info->ioaddr + UART_DLM);	/* MS of divisor */
 	outb(cval, info->ioaddr + UART_LCR);	/* reset DLAB */
 
-#ifdef BOTHER
 	if (C_BAUD(tty) == BOTHER) {
 		quot = MXSER_BAUD_BASE % newspd;
 		quot *= 8;
@@ -540,7 +539,6 @@ static int mxser_set_baud(struct tty_struct *tty, speed_t newspd)
 
 		mxser_set_must_enum_value(info->ioaddr, quot);
 	} else
-#endif
 		mxser_set_must_enum_value(info->ioaddr, 0);
 
 	return 0;
diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index d903e111dbcb..07bbbfee5635 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -61,11 +61,10 @@ speed_t tty_termios_baud_rate(struct ktermios *termios)
 
 	cbaud = termios->c_cflag & CBAUD;
 
-#ifdef BOTHER
 	/* Magic token for arbitrary speed via c_ispeed/c_ospeed */
 	if (cbaud == BOTHER)
 		return termios->c_ospeed;
-#endif
+
 	if (cbaud & CBAUDEX) {
 		cbaud &= ~CBAUDEX;
 
@@ -97,11 +96,11 @@ speed_t tty_termios_input_baud_rate(struct ktermios *termios)
 
 	if (cbaud == B0)
 		return tty_termios_baud_rate(termios);
-#ifdef BOTHER
+
 	/* Magic token for arbitrary speed via c_ispeed*/
 	if (cbaud == BOTHER)
 		return termios->c_ispeed;
-#endif
+
 	if (cbaud & CBAUDEX) {
 		cbaud &= ~CBAUDEX;
 
@@ -157,7 +156,6 @@ void tty_termios_encode_baud_rate(struct ktermios *termios,
 	if (((termios->c_cflag >> IBSHIFT) & CBAUD) != B0)
 		ibinput = 1;	/* An input speed was specified */
 #endif
-#ifdef BOTHER
 	/* If the user asked for a precise weird speed give a precise weird
 	 * answer. If they asked for a Bfoo speed they may have problems
 	 * digesting non-exact replies so fuzz a bit.
@@ -170,7 +168,7 @@ void tty_termios_encode_baud_rate(struct ktermios *termios,
 	}
 	if (((termios->c_cflag >> IBSHIFT) & CBAUD) == BOTHER)
 		iclose = 0;
-#endif
+
 	termios->c_cflag &= ~CBAUD;
 #ifdef IBSHIFT
 	termios->c_cflag &= ~(CBAUD << IBSHIFT);
@@ -205,11 +203,7 @@ void tty_termios_encode_baud_rate(struct ktermios *termios,
 		}
 	} while (++i < n_baud_table);
 
-	/*
-	 *	If we found no match then use BOTHER if provided or warn
-	 *	the user their platform maintainer needs to wake up if not.
-	 */
-#ifdef BOTHER
+	/* If we found no match then use BOTHER. */
 	if (ofound == -1)
 		termios->c_cflag |= BOTHER;
 	/* Set exact input bits only if the input and output differ or the
@@ -217,10 +211,6 @@ void tty_termios_encode_baud_rate(struct ktermios *termios,
 	 */
 	if (ifound == -1 && (ibaud != obaud || ibinput))
 		termios->c_cflag |= (BOTHER << IBSHIFT);
-#else
-	if (ifound == -1 || ofound == -1)
-		pr_warn_once("tty: Unable to return correct speed data as your architecture needs updating.\n");
-#endif
 }
 EXPORT_SYMBOL_GPL(tty_termios_encode_baud_rate);
 
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 63181925ec1a..adae687f654b 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -562,10 +562,8 @@ static int set_sgttyb(struct tty_struct *tty, struct sgttyb __user *sgttyb)
 	termios.c_cc[VKILL] = tmp.sg_kill;
 	set_sgflags(&termios, tmp.sg_flags);
 	/* Try and encode into Bfoo format */
-#ifdef BOTHER
 	tty_termios_encode_baud_rate(&termios, termios.c_ispeed,
 						termios.c_ospeed);
-#endif
 	up_write(&tty->termios_rwsem);
 	tty_set_termios(tty, &termios);
 	return 0;
-- 
2.30.2

