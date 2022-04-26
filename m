Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AC75100EC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351744AbiDZOxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351723AbiDZOxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:53:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487E840E41;
        Tue, 26 Apr 2022 07:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650984597; x=1682520597;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+cv5qN1igNw1Zx5NSV2OW8gEhkMunXxsP88oD3ZR3ck=;
  b=kR88/utOkfTzfasYLxAKmUEKYAAwWSAPJeC6y4IB4W1H6vViE+y1R5Gm
   vV/OiWUxowq1glBYxXKMMhpCNs6XttxzfESQdC6D84QCEyp0JpCmUMgA3
   tkiASAjHZx3B7QmWXJvS8dGQRrQH9lbU/8sYrPPYNTLyQUVTNrmfBw3g9
   I5dySo2kSo6FXl2gml9gcMhMtyI4E0iFVJKwUrX9UKkWB7imRBFjbERNo
   JPins1ZmLjFjv5GNazNKUgIEjwjr5F5cmrflYshAJpQpHrb9U92CguS84
   L/T2Um7iZ+1jMBQroMwwYC+kV+LFeWdyoycYclGAwy6O9ceXMlBHvrvaS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="352040437"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="352040437"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 07:49:57 -0700
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="579933023"
Received: from mmilkovx-mobl.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.47.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 07:49:54 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 3/3] tty: Use flow-control char function on closing path
Date:   Tue, 26 Apr 2022 17:49:35 +0300
Message-Id: <20220426144935.54893-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220426144935.54893-1-ilpo.jarvinen@linux.intel.com>
References: <20220426144935.54893-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 917b5970b2e0..ea4dc316eafb 100644
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

