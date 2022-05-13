Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE18525D78
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378249AbiEMI3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378228AbiEMI3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:29:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916A62A7C3C;
        Fri, 13 May 2022 01:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652430568; x=1683966568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZaGFZlPpCXiOg96Y9zRYreA0FK3dK9EZzaBA06o/Ag0=;
  b=bOGPbM8qf5Va+N5Rt/YTzs0ZUZM3nUmgDW9MDRI7HzopLkNABjc0nVMy
   3eLeTqDhNy5hCTSWzhxbA7gmuLeXmibBcrJp+iRL6yx4V537wY/7iNhx7
   mJux9OzONPt+1piLhg7GI/iK538cYBMPuSn5IItKKDtKI5d6L9Yrv2I34
   EeE6fLfXcG7afcQhsf3XAgHe6cqOqmCZhejJDfs2CYaP8xhqNOeDFoW3q
   zs6AICf6r8oQxxQ25y1G7j1Fi3BCByLsULCm7luA0Il9uvWC3WIYvDujc
   0LHI6kxvJBOORF3Q9MLiuSlnkOqJ1mhf8k+za9SttvBS1BCYTalkORBwe
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="270385188"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="270385188"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 01:29:28 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="567107480"
Received: from huberth-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.34.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 01:29:25 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 2/5] tty: remove BOTHER ifdefs
Date:   Fri, 13 May 2022 11:29:03 +0300
Message-Id: <20220513082906.11096-3-ilpo.jarvinen@linux.intel.com>
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

BOTHER is defined by all architectures since commit d0ffb805b729
("arch/alpha, termios: implement BOTHER, IBSHIFT and termios2").

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/mxser.c        |  5 ++---
 drivers/tty/tty_baudrate.c | 20 +++++---------------
 drivers/tty/tty_ioctl.c    |  2 --
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index 6ebd3e4ed859..70b982b2c6b2 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -528,7 +528,6 @@ static int mxser_set_baud(struct tty_struct *tty, speed_t newspd)
 	outb(quot >> 8, info->ioaddr + UART_DLM);	/* MS of divisor */
 	outb(cval, info->ioaddr + UART_LCR);	/* reset DLAB */
 
-#ifdef BOTHER
 	if (C_BAUD(tty) == BOTHER) {
 		quot = MXSER_BAUD_BASE % newspd;
 		quot *= 8;
@@ -539,9 +538,9 @@ static int mxser_set_baud(struct tty_struct *tty, speed_t newspd)
 			quot /= newspd;
 
 		mxser_set_must_enum_value(info->ioaddr, quot);
-	} else
-#endif
+	} else {
 		mxser_set_must_enum_value(info->ioaddr, 0);
+	}
 
 	return 0;
 }
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

