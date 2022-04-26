Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027E55100E8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351727AbiDZOxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiDZOw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:52:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E31440A38;
        Tue, 26 Apr 2022 07:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650984590; x=1682520590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1pKNQ/jYfZZYbMBsWQ6uNeoADUxZXdWMQXBuv7J6lhE=;
  b=L6fwYOW4P+j9qiy9J0m6JV9EVRiTFDnoIp91ZmZYAMu5Wbg5NBfEhxBN
   xCgGeJ5qlQCRs/KTr0Lbl8jTwkQyicJ6XIb4+NAvCTHNvMQOCOc62CUjM
   6ytF3f+uoeeRSOK2WJcsAYNRMFd50SGjJkMHRYiPhS3gr5+QdCgw8jILT
   xJBKLs/Ks/FyvwNSCPoLU+AiEhkBmNdxKVeHYHgguU0u6enqxCqUwpb/N
   3BxyrHUU44BqR6j01892Tw+2nv+KWZNdqqLPBvbQp324KK9ElAFBTnTWI
   2zaG7Qfjs9T4kj4QkN33aZVl9W6aPt9uJfEgnHYSaD6pv1VC0t+B7PPd7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="352040413"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="352040413"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 07:49:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="579932957"
Received: from mmilkovx-mobl.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.47.245])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 07:49:47 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 1/3] tty: Rework receive flow control char logic
Date:   Tue, 26 Apr 2022 17:49:33 +0300
Message-Id: <20220426144935.54893-2-ilpo.jarvinen@linux.intel.com>
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

Add a helper to check if the character is a flow control one. This
rework prepares for adding lookahead done check cleanly to
n_tty_receive_char_flow_ctrl() between n_tty_is_char_flow_ctrl() and
the actions taken on the flow control characters.

No functional changes intended.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/n_tty.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 88af1cdd2fd1..640c9e871044 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1220,20 +1220,26 @@ n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
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
 		return true;
 	}
-	if (c == STOP_CHAR(tty)) {
-		stop_tty(tty);
-		return true;
-	}
 
-	return false;
+	/* STOP_CHAR */
+	stop_tty(tty);
+	return true;
 }
 
 static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
-- 
2.30.2

