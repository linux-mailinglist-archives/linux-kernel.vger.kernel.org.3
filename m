Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B6852306F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 12:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241332AbiEKKMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 06:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241252AbiEKKMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:12:12 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACB0219F4A;
        Wed, 11 May 2022 03:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652263925; x=1683799925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+zu/bQxVabGiEvqKrbpKyisyrq3lc1lCDi+u4VJE9D8=;
  b=BYJVheBMeFkc/21gTu3P1NUtGpPRvpCR5wh2hTAicENyDdpCZGSdL+xH
   +SXaV/1tj07IM2iI7/Evhfr92KMLVBVuRgd3KrPncIDI8P6OlG9Gwt2v0
   SOdSXMgqqcHsa0wImnyNfm7pfuzuSonWppz3zS+GoqPp68HyShWjsBFOE
   smnlhW6SF6U8IVgDIjjvMClc1PQEccPBUS3GegvvVHMRC2L8QFOKND06R
   mG5KIkFDuXD+sMUx7p5tWSK7YJGmPbxzhD1sghsYeUzBszdSvpjpZ9O7/
   FunrbLAK6sDjg9ygmZdWdnZFXBxw97YA4iAYQizx7CEk0a+x+GBoC6wNq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="250184335"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="250184335"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 03:12:05 -0700
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="594049627"
Received: from meliyahx-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.32.210])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 03:12:03 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/5] tty/termbits: remove #ifdef IBSHIFT that is always defined
Date:   Wed, 11 May 2022 13:11:37 +0300
Message-Id: <20220511101139.5306-4-ilpo.jarvinen@linux.intel.com>
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

IBSHIFT is defined by all architectures.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/tty_baudrate.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
index 07bbbfee5635..d10318956c97 100644
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
@@ -194,12 +187,10 @@ void tty_termios_encode_baud_rate(struct ktermios *termios,
 			 */
 			if (ofound == i && !ibinput)
 				ifound  = i;
-#ifdef IBSHIFT
 			else {
 				ifound = i;
 				termios->c_cflag |= (baud_bits[i] << IBSHIFT);
 			}
-#endif
 		}
 	} while (++i < n_baud_table);
 
-- 
2.30.2

