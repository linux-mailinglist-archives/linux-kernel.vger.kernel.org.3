Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E5D4FB879
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344765AbiDKJyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344845AbiDKJwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:52:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDD9765A;
        Mon, 11 Apr 2022 02:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649670575; x=1681206575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XHrZ5n/PusdyZVaVYkVFfiaOwDhbhrmj4imqIjlC8YE=;
  b=UJXFGf6LfLldpu+ku32ZMA3ba9w195PJEPm+07bqMIS1Bbe2UtEub3Xr
   Ec7yp/IFjn68uPh+eGkFqEaKsRi2shdiS8/oC8CEJWecD6cPYnMLPHVd3
   guVXRikBhRWR4X8gRjSOViaotAOFg3aMg7h5bESErBVMrM/qkyMSSPCCs
   wE5/hqyX6/DASBydlOFzIMyURZ2YgsKfPpPV4jq8duChpozQJ6tnfr/7u
   /AZ913Q0VnjgeSrHNG6ivDeHJoM+u4zfNPj3vF7NlRbjY4tzU+zuTx6l4
   ydpbObMwdfLekJgVLHoEhdY4jC7J+mBEZg3ZzqUidEZka+Y2l5qhY6GOB
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="242014241"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="242014241"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 02:49:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="572053845"
Received: from azahoner-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.232])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 02:49:26 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 5/5] tty: Use flow-control char function on closing path
Date:   Mon, 11 Apr 2022 12:48:59 +0300
Message-Id: <20220411094859.10894-6-ilpo.jarvinen@linux.intel.com>
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

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/n_tty.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index fede29ed8daf..e6f47858f98f 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1414,15 +1414,10 @@ static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c,
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

