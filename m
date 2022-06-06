Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6B053E86B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbiFFPqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241125AbiFFPqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:46:39 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A4F326D7;
        Mon,  6 Jun 2022 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654530397; x=1686066397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rowern8il6mlvB4ADbpapufGbGqLa/M/1dT71/livmA=;
  b=L5h1Myx5nEMapHy7cLuv2DwuSuUdNohJuD1OSn+TvIGBZedIMy/cveq4
   3O5BH19aP1x2clh28XJ5kC6oqRIA+AKktfv63y3/Tu3+u/Bg7ItkOonD7
   C95lkkdbiYgcBGb2H9Yt4NO+tcNhd/injkNSJ5qUyxfnB4HoFZ2XauDuA
   9/QE6c4iLgIw8Zrihz/sKvFeExGSIwdma/ISWlpEuUdfkMZinUaO+T3y5
   yqEIN33Z6qprMNRmzBGEzoSjdpGWNcJzBJ4J7ixWPVTkY6DAD6huAYrOZ
   5/rp4pF5hgbMWNJ4TiTcNYBRQvXCr5pYijNgfCRWKV5gmISEWxAjQMij+
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="264656681"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="264656681"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 08:37:15 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635653602"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 08:37:11 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gilles Buloz <gilles.buloz@kontron.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v6 2/2] tty: Use flow-control char function on closing path
Date:   Mon,  6 Jun 2022 18:36:52 +0300
Message-Id: <20220606153652.63554-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220606153652.63554-1-ilpo.jarvinen@linux.intel.com>
References: <20220606153652.63554-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use n_tty_receive_char_flow_ctrl also on the closing path. This makes
the code cleaner and consistent.

However, there a small change of regression!

The earlier closing path has a small difference compared with the
normal receive path. If START_CHAR and STOP_CHAR are equal, their
precedence is different depending on which path a character is
processed. I don't know whether this difference was intentional or
not, and if equal START_CHAR and STOP_CHAR is actually used anywhere.
But it feels not so useful corner case.

While this change would logically belong to those earlier changes,
having a separate patch for this is useful. If this regresses, bisect
can pinpoint this change rather than the large patch. Also, this
change is not necessary to minimal fix for the issue addressed in
the previous patch.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/n_tty.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 8d80384df874..3afdd9033a9c 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1434,15 +1434,10 @@ static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c,
 		c = tolower(c);
 
 	if (I_IXON(tty)) {
-		if (c == STOP_CHAR(tty)) {
-			if (!lookahead_done)
-				stop_tty(tty);
-		} else if (c == START_CHAR(tty) && lookahead_done) {
-			return;
-		} else if (c == START_CHAR(tty) ||
-			 (tty->flow.stopped && !tty->flow.tco_stopped && I_IXANY(tty) &&
-			  c != INTR_CHAR(tty) && c != QUIT_CHAR(tty) &&
-			  c != SUSP_CHAR(tty))) {
+		if (!n_tty_receive_char_flow_ctrl(tty, c, lookahead_done) &&
+		    tty->flow.stopped && !tty->flow.tco_stopped && I_IXANY(tty) &&
+		    c != INTR_CHAR(tty) && c != QUIT_CHAR(tty) &&
+		    c != SUSP_CHAR(tty)) {
 			start_tty(tty);
 			process_echoes(tty);
 		}
-- 
2.30.2

