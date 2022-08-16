Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC23A595B4F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbiHPMIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbiHPMHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:07:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F688D77;
        Tue, 16 Aug 2022 04:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660651075; x=1692187075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZdhDcPEQO9N7iMBRBYrkWL0Jpl5hwBrBwkkMZmGHxgc=;
  b=MzdrNB8z3cHIno655baQhEeTRl8H15/SHK2nxVSQ5YLGwmkKVfKxXNma
   +iGLt5Ba2uKE44boRktUxk/CJ/52HSjEEIQ6lZm58FeyCJpM7rMQn1mPj
   OAU6yZSt8e8slShGpoi2Ve9VfMcusw5XR1C0TvS7xSKSek7QiHVDG6AeB
   Gh85MgdVFj6jgU+UAjo2YUtuS5TZzhic11n/PltKcCrtKSoi14ZAP/qhX
   v2UbjN0TsajqLcIYJAv8GuGToMwyLgn0HyTBe6EalpNpTPY4wHZLbQAP9
   Gq9MplnMosiQ6kE3AN4jjFWVI6cSBfCqe1tL8Z0jmtgw4G15AUtwcRiOY
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="356199305"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="356199305"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 04:57:54 -0700
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="667080780"
Received: from tturcu-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.51.153])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 04:57:51 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/8] tty: Remove baudrate dead code & make ktermios params const
Date:   Tue, 16 Aug 2022 14:57:32 +0300
Message-Id: <20220816115739.10928-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220816115739.10928-1-ilpo.jarvinen@linux.intel.com>
References: <20220816115739.10928-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the architectures currently in-tree, either:
  1) CBAUDEX is zero
  2) The earlier BOTHER if check covers cbaud < 1 case
  3) All CBAUD bits are covered by the baud_table

Thus, the check for cbaud being out-of-range for CBAUDEX case cannot
ever be true.

The ktermios parameters can now be made const.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/tty.h          |  2 +-
 drivers/tty/tty_baudrate.c | 24 ++++++++----------------
 include/linux/tty.h        |  2 +-
 3 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/tty.h b/drivers/tty/tty.h
index f310a8274df1..1c08c9b67b16 100644
--- a/drivers/tty/tty.h
+++ b/drivers/tty/tty.h
@@ -73,7 +73,7 @@ void tty_buffer_set_lock_subclass(struct tty_port *port);
 bool tty_buffer_restart_work(struct tty_port *port);
 bool tty_buffer_cancel_work(struct tty_port *port);
 void tty_buffer_flush_work(struct tty_port *port);
-speed_t tty_termios_input_baud_rate(struct ktermios *termios);
+speed_t tty_termios_input_baud_rate(const struct ktermios *termios);
 void tty_ldisc_hangup(struct tty_struct *tty, bool reset);
 int tty_ldisc_reinit(struct tty_struct *tty, int disc);
 long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index 3cd99ed7c710..4e3fd756dfc7 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -49,13 +49,13 @@ static int n_baud_table = ARRAY_SIZE(baud_table);
  *
  *	Convert termios baud rate data into a speed. This should be called
  *	with the termios lock held if this termios is a terminal termios
- *	structure. May change the termios data. Device drivers can call this
- *	function but should use ->c_[io]speed directly as they are updated.
+ *	structure. Device drivers can call this function but should use
+ *	->c_[io]speed directly as they are updated.
  *
  *	Locking: none
  */
 
-speed_t tty_termios_baud_rate(struct ktermios *termios)
+speed_t tty_termios_baud_rate(const struct ktermios *termios)
 {
 	unsigned int cbaud;
 
@@ -67,11 +67,7 @@ speed_t tty_termios_baud_rate(struct ktermios *termios)
 
 	if (cbaud & CBAUDEX) {
 		cbaud &= ~CBAUDEX;
-
-		if (cbaud < 1 || cbaud + 15 > n_baud_table)
-			termios->c_cflag &= ~CBAUDEX;
-		else
-			cbaud += 15;
+		cbaud += 15;
 	}
 	return cbaud >= n_baud_table ? 0 : baud_table[cbaud];
 }
@@ -83,13 +79,13 @@ EXPORT_SYMBOL(tty_termios_baud_rate);
  *
  *	Convert termios baud rate data into a speed. This should be called
  *	with the termios lock held if this termios is a terminal termios
- *	structure. May change the termios data. Device drivers can call this
- *	function but should use ->c_[io]speed directly as they are updated.
+ *	structure. Device drivers can call this function but should use
+ *	->c_[io]speed directly as they are updated.
  *
  *	Locking: none
  */
 
-speed_t tty_termios_input_baud_rate(struct ktermios *termios)
+speed_t tty_termios_input_baud_rate(const struct ktermios *termios)
 {
 	unsigned int cbaud = (termios->c_cflag >> IBSHIFT) & CBAUD;
 
@@ -102,11 +98,7 @@ speed_t tty_termios_input_baud_rate(struct ktermios *termios)
 
 	if (cbaud & CBAUDEX) {
 		cbaud &= ~CBAUDEX;
-
-		if (cbaud < 1 || cbaud + 15 > n_baud_table)
-			termios->c_cflag &= ~(CBAUDEX << IBSHIFT);
-		else
-			cbaud += 15;
+		cbaud += 15;
 	}
 	return cbaud >= n_baud_table ? 0 : baud_table[cbaud];
 }
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 7b0a5d478ef6..cf5ab26de73d 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -434,7 +434,7 @@ int tty_hung_up_p(struct file *filp);
 void do_SAK(struct tty_struct *tty);
 void __do_SAK(struct tty_struct *tty);
 void no_tty(void);
-speed_t tty_termios_baud_rate(struct ktermios *termios);
+speed_t tty_termios_baud_rate(const struct ktermios *termios);
 void tty_termios_encode_baud_rate(struct ktermios *termios, speed_t ibaud,
 		speed_t obaud);
 void tty_encode_baud_rate(struct tty_struct *tty, speed_t ibaud,
-- 
2.30.2

