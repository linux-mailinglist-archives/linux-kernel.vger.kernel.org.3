Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B07525DB7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378261AbiEMI3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378233AbiEMI3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:29:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF242A7C3F;
        Fri, 13 May 2022 01:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652430573; x=1683966573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3AZmPCQXD829z2NVQfnDiZr0z2oQIdav3zQqb/SAWNM=;
  b=Cv9AlMpQsrE4/vEhtgGop8WJETxUvU5ujTHbHSxJltQNas+tiwd7ywqu
   NSxbCanYG16cY4GivMDpxJUKMVZXqtMzt58Ba43fU8r31reSu68LkHe9h
   riKQlUwQTbzSqcMvLDY2jVhF1gUmgxL0qn++DI624z0ycd03l159+ElC6
   MOSgTW74L8l6qmX+bwprocn8LbP+zloveViOk9q4bkkwdIDXaRCz83hBk
   NQJpCLwbs6uOI7ppIxDkHMflLRlPyfWFFtcv5DbONIzzBqprajMOa2Qrr
   I7QrS5rB1boZD4ofXm2p+ojylK3EAscNo906AfOX+9fW8q54LEFewNHSh
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="270385189"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="270385189"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 01:29:32 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="567107492"
Received: from huberth-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.34.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 01:29:29 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 3/5] tty: remove IBSHIFT ifdefs
Date:   Fri, 13 May 2022 11:29:04 +0300
Message-Id: <20220513082906.11096-4-ilpo.jarvinen@linux.intel.com>
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

IBSHIFT is defined by all architectures since commit d0ffb805b729
("arch/alpha, termios: implement BOTHER, IBSHIFT and termios2").

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/tty_baudrate.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index 07bbbfee5635..3cd99ed7c710 100644
--- a/drivers/tty/tty_baudrate.c
+++ b/drivers/tty/tty_baudrate.c
@@ -91,7 +91,6 @@ EXPORT_SYMBOL(tty_termios_baud_rate);
 
 speed_t tty_termios_input_baud_rate(struct ktermios *termios)
 {
-#ifdef IBSHIFT
 	unsigned int cbaud = (termios->c_cflag >> IBSHIFT) & CBAUD;
 
 	if (cbaud == B0)
@@ -110,9 +109,6 @@ speed_t tty_termios_input_baud_rate(struct ktermios *termios)
 			cbaud += 15;
 	}
 	return cbaud >= n_baud_table ? 0 : baud_table[cbaud];
-#else	/* IBSHIFT */
-	return tty_termios_baud_rate(termios);
-#endif	/* IBSHIFT */
 }
 EXPORT_SYMBOL(tty_termios_input_baud_rate);
 
@@ -152,10 +148,9 @@ void tty_termios_encode_baud_rate(struct ktermios *termios,
 	termios->c_ispeed = ibaud;
 	termios->c_ospeed = obaud;
 
-#ifdef IBSHIFT
 	if (((termios->c_cflag >> IBSHIFT) & CBAUD) != B0)
 		ibinput = 1;	/* An input speed was specified */
-#endif
+
 	/* If the user asked for a precise weird speed give a precise weird
 	 * answer. If they asked for a Bfoo speed they may have problems
 	 * digesting non-exact replies so fuzz a bit.
@@ -170,9 +165,7 @@ void tty_termios_encode_baud_rate(struct ktermios *termios,
 		iclose = 0;
 
 	termios->c_cflag &= ~CBAUD;
-#ifdef IBSHIFT
 	termios->c_cflag &= ~(CBAUD << IBSHIFT);
-#endif
 
 	/*
 	 *	Our goal is to find a close match to the standard baud rate
@@ -192,14 +185,12 @@ void tty_termios_encode_baud_rate(struct ktermios *termios,
 			/* For the case input == output don't set IBAUD bits
 			 * if the user didn't do so.
 			 */
-			if (ofound == i && !ibinput)
+			if (ofound == i && !ibinput) {
 				ifound  = i;
-#ifdef IBSHIFT
-			else {
+			} else {
 				ifound = i;
 				termios->c_cflag |= (baud_bits[i] << IBSHIFT);
 			}
-#endif
 		}
 	} while (++i < n_baud_table);
 
-- 
2.30.2

