Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585C34FB841
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344827AbiDKJwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344744AbiDKJwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:52:01 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25274160B;
        Mon, 11 Apr 2022 02:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649670559; x=1681206559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tLQnkkpIQ4X3yEMlGxAP4IEwUxyB9+6gl5gfqvuRap8=;
  b=ANF+1/wQGT3vU5NcyP8UNQY5OVz6IKw3ceID3fMnLDYhLWpgZkfrAr9/
   bx4MDn9kVlt7UIXDX90NNRFl6D5g44py1AbQf8JxjTxGrgS3JgC1vleyE
   ddpNxcLuud5lVqSgJSa+N5a51Gu0tXSyc/Y6fDjU4AMBO9ex+lBo8UZks
   +IgK/D1rkvW7q+iWpOTjHKjq0+oarWdEaFU8AQp+6Yz6YF3Z1tik4r0H2
   1iaDU5OqGEpwFuctFn9XE//atIRyD/dX5jjJb+8qlUZNyrWfGiRHkJmEY
   NlP64cPsXOapZhImLyiPWaR8ypUNF7iYAwcPVhQf8mSOA3KqLoRR7KXq8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="242014210"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="242014210"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 02:49:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="572053806"
Received: from azahoner-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.232])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 02:49:15 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 2/5] tty: Simplify receive flow control char logic
Date:   Mon, 11 Apr 2022 12:48:56 +0300
Message-Id: <20220411094859.10894-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411094859.10894-1-ilpo.jarvinen@linux.intel.com>
References: <20220411094859.10894-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper to check if the character is a flow control one.
Reorder return places, add else for the case where START_CHAR
and STOP_CHAR are the same, w/o else both would match.

This seems cleanest approach once skipping due to lookahead
is added by the next patch. Its downside is the duplicated
START_CHAR and STOP_CHAR checks.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/n_tty.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index c7edfc001fd0..90b3e06cbeb1 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1220,20 +1220,25 @@ n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
 		process_echoes(tty);
 }
 
+static bool n_tty_is_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
+{
+	return c == START_CHAR(tty) || c == STOP_CHAR(tty);
+}
+
 /* Returns true if c is consumed as flow-control character */
 static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
 {
+	if (!n_tty_is_char_flow_ctrl(tty, c))
+		return false;
+
 	if (c == START_CHAR(tty)) {
 		start_tty(tty);
 		process_echoes(tty);
-		return true;
-	}
-	if (c == STOP_CHAR(tty)) {
+	} else if (c == STOP_CHAR(tty)) {
 		stop_tty(tty);
-		return true;
 	}
 
-	return false;
+	return true;
 }
 
 static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
-- 
2.30.2

