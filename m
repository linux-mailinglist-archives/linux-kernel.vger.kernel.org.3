Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628EE5A5E99
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiH3Iun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiH3IuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:50:15 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5656713DE7;
        Tue, 30 Aug 2022 01:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661849403; x=1693385403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Za5+X7kMFfgQipPzg09qI4UY1X9yueHmr3J4bzHEXuw=;
  b=kPGKT8YlbsxgYDFJSxMj8DKYLbfOYb1WNzr2vOuxa9rE2tXeCLaxfeMT
   lN2N4AXQjVhdWqPJ6QwvMdvatj04sv9Jx5pKN4Inpfh6MfHsKlIuMbe27
   HyVr0DFpzKovanLdKZnz0IuEgW3+fZQQYaUqWZ5QpyOMX7z51JgYjakDS
   w2gPmAymjLhNtRVBMERX8QDXeBObkrEfhPFlMPxdLexj1w8etJ2KlQ5Il
   3Z9lZ2GwjMq67f1BxBXenpwaz72KjYGXcnXXWr80ayJGbesTq8vlXNE6D
   EZ5ccUNKRnQiEF5F7JJWHPZj2NqIszS1r6UowtjvNdtRENTmsGUWpiex2
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="293866338"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="293866338"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 01:49:59 -0700
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="672761892"
Received: from arnesgom-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.54.235])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 01:49:56 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 4/5] serial: sunsab: Remove frame size calculation dead-code
Date:   Tue, 30 Aug 2022 11:49:24 +0300
Message-Id: <20220830084925.5608-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220830084925.5608-1-ilpo.jarvinen@linux.intel.com>
References: <20220830084925.5608-1-ilpo.jarvinen@linux.intel.com>
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

The driver features a custom frame length calculation but the result is
never used. Remove it.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/sunsab.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index 6ea52293d9f3..f7968f73753d 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -681,27 +681,23 @@ static void sunsab_convert_to_sab(struct uart_sunsab_port *up, unsigned int cfla
 				  unsigned int quot)
 {
 	unsigned char dafo;
-	int bits, n, m;
+	int n, m;
 
 	/* Byte size and parity */
 	switch (cflag & CSIZE) {
-	      case CS5: dafo = SAB82532_DAFO_CHL5; bits = 7; break;
-	      case CS6: dafo = SAB82532_DAFO_CHL6; bits = 8; break;
-	      case CS7: dafo = SAB82532_DAFO_CHL7; bits = 9; break;
-	      case CS8: dafo = SAB82532_DAFO_CHL8; bits = 10; break;
+	      case CS5: dafo = SAB82532_DAFO_CHL5; break;
+	      case CS6: dafo = SAB82532_DAFO_CHL6; break;
+	      case CS7: dafo = SAB82532_DAFO_CHL7; break;
+	      case CS8: dafo = SAB82532_DAFO_CHL8; break;
 	      /* Never happens, but GCC is too dumb to figure it out */
-	      default:  dafo = SAB82532_DAFO_CHL5; bits = 7; break;
+	      default:  dafo = SAB82532_DAFO_CHL5; break;
 	}
 
-	if (cflag & CSTOPB) {
+	if (cflag & CSTOPB)
 		dafo |= SAB82532_DAFO_STOP;
-		bits++;
-	}
 
-	if (cflag & PARENB) {
+	if (cflag & PARENB)
 		dafo |= SAB82532_DAFO_PARE;
-		bits++;
-	}
 
 	if (cflag & PARODD) {
 		dafo |= SAB82532_DAFO_PAR_ODD;
-- 
2.30.2

