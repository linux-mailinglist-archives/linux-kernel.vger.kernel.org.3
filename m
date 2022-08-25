Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322B95A0C66
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239039AbiHYJTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbiHYJT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:19:29 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F9AA8306;
        Thu, 25 Aug 2022 02:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661419168; x=1692955168;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wKEARAay3oXZ7c7KadwA88gOhMIFG8jHd1g7GlPDyR8=;
  b=ecVOLPv5TbJ6N0rZXeJ1vFDDJRoFdP81KF+JK7dpBb33XjvKNwbZBSw6
   a87H84Lz6aYAU2XjQ8FX6UUjekaGj8/56zgUs4r51CILt+m90/h0v++xt
   5GKoBY9h4mazf0Xw6WYRwB581awoeArPOt8y4l+tiujDRCAEiFijxQjzK
   6GIhhPZVXoz+3TjKcnJ0PORxefRC033dr9jcuDnxFrvN8B+FmKmtqFBzF
   26IMhL+s72KzeCEeaWW1d8Zmn6c+qnMlAPrUfVYhTYuID4siW7Var7qkJ
   9EaMJZ22Gn0TpHR19roVlBNkFCTvq2JuOgzCQAnSmgo31cB2EDo9vbDbU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="291762027"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="291762027"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 02:19:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="670902171"
Received: from mblazque-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.101])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 02:19:26 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] serial: dz: Replace DZ_XMIT_SIZE with UART_XMIT_SIZE
Date:   Thu, 25 Aug 2022 12:19:18 +0300
Message-Id: <20220825091918.8398-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the normal UART_XMIT_SIZE directly.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/dz.c | 2 +-
 drivers/tty/serial/dz.h | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index 2e21acf39720..5d2588f3e6a9 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -279,7 +279,7 @@ static inline void dz_transmit_chars(struct dz_mux *mux)
 	 * so we go one char at a time) :-<
 	 */
 	tmp = xmit->buf[xmit->tail];
-	xmit->tail = (xmit->tail + 1) & (DZ_XMIT_SIZE - 1);
+	xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 	dz_out(dport, DZ_TDR, tmp);
 	dport->port.icount.tx++;
 
diff --git a/drivers/tty/serial/dz.h b/drivers/tty/serial/dz.h
index 3b3e31954f24..59120ad2bda0 100644
--- a/drivers/tty/serial/dz.h
+++ b/drivers/tty/serial/dz.h
@@ -12,6 +12,8 @@
 #ifndef DZ_SERIAL_H
 #define DZ_SERIAL_H
 
+#include <linux/serial_core.h>
+
 /*
  * Definitions for the Control and Status Register.
  */
@@ -124,7 +126,6 @@
 
 #define DZ_NB_PORT 4
 
-#define DZ_XMIT_SIZE   4096                 /* buffer size */
-#define DZ_WAKEUP_CHARS   DZ_XMIT_SIZE/4
+#define DZ_WAKEUP_CHARS   (UART_XMIT_SIZE / 4)
 
 #endif /* DZ_SERIAL_H */
-- 
2.30.2

