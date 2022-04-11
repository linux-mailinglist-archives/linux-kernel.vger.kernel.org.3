Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07684FB869
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344766AbiDKJw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344742AbiDKJwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:52:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086C94163E;
        Mon, 11 Apr 2022 02:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649670555; x=1681206555;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M2u3w05j5GdTWGTEsQrglvb3wWx15hV0ceGBCXQnBrU=;
  b=ZKgXu1aLiJ5sh9t92LtaV2MXslOXXoU4ZqkGa91e0unwW2dacLmJMN4d
   ucxbG1+tS7gehjZKBfFWlMhGmOluwCQyQ1vVCxo3P0bWuou7COainmp8/
   H829+82gDMi1A6g7hALZlimmZv3CXtNWlNRj099NtnCJtJusYcbqHXBXB
   5sehsF7jVwElK9+3GYKWsKEQcnV5woQ5ZQ5Wg/la37YAlU8+T236nvFnh
   NNj2M/DEMnZIOC1YP8IPXbfU8K14gwQyfUJMQEYzHlBm6nSCC3oPIQdLQ
   2YoILNUnxgf5kTEUO8S/QnTJS/HqqTSwMVTdNdD+wJhUnt9edQumQvYle
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="242014200"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="242014200"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 02:49:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="572053776"
Received: from azahoner-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.232])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 02:49:12 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 1/5] tty: Add function for handling flow control chars
Date:   Mon, 11 Apr 2022 12:48:55 +0300
Message-Id: <20220411094859.10894-2-ilpo.jarvinen@linux.intel.com>
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

Move receive path flow control character handling to own function.

No functional changes.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/n_tty.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index efc72104c840..c7edfc001fd0 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1220,21 +1220,28 @@ n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
 		process_echoes(tty);
 }
 
+/* Returns true if c is consumed as flow-control character */
+static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
+{
+	if (c == START_CHAR(tty)) {
+		start_tty(tty);
+		process_echoes(tty);
+		return true;
+	}
+	if (c == STOP_CHAR(tty)) {
+		stop_tty(tty);
+		return true;
+	}
+
+	return false;
+}
+
 static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
-	if (I_IXON(tty)) {
-		if (c == START_CHAR(tty)) {
-			start_tty(tty);
-			process_echoes(tty);
-			return;
-		}
-		if (c == STOP_CHAR(tty)) {
-			stop_tty(tty);
-			return;
-		}
-	}
+	if (I_IXON(tty) && n_tty_receive_char_flow_ctrl(tty, c))
+		return;
 
 	if (L_ISIG(tty)) {
 		if (c == INTR_CHAR(tty)) {
-- 
2.30.2

