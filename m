Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612745A0C12
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237975AbiHYI6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237255AbiHYI6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:58:37 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2DEA8CD2;
        Thu, 25 Aug 2022 01:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661417913; x=1692953913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YcSvNB23AhSi5EswqOVHYUWtaN9VoCvzviSsnzaVGZo=;
  b=Vz3tdMAVMZJYa4sCxqp/mHg1yX+4SBT1g5I52dNaEtHuwa4K4p2/00sz
   CqLjnPHQfjhJmmvQ0/HN2DXBLu3432y+wlHv1ZvasrcJR6ED8V8Q7oiYF
   FZczXvN5Zz1s3LM98+VtcOJWezoEVJ6QUEQH5eTkxtv2SiIhUHce2Ccyz
   9ehUqtTjSuTBTOuoB3AG78xVfHyXOESSLnViv0XKJsFIcwyHWsBweEdDk
   0lTio3BoJ3fPiBnNKuIP+4TpQnkXLik9qZUPZ3/IpL2YitITQSM9rfjuy
   msj2v98/qeC1jTVH4QCPo1p6WHMbgZ8fX72QQbxspzpIt2rNxyAkrMBNL
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="273941431"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="273941431"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 01:58:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="670893942"
Received: from mblazque-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.101])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 01:58:31 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 4/5] serial: sunsab: Remove frame size calculation dead-code
Date:   Thu, 25 Aug 2022 11:58:09 +0300
Message-Id: <20220825085810.7290-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220825085810.7290-1-ilpo.jarvinen@linux.intel.com>
References: <20220825085810.7290-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver features a custom frame length calculation but the result is
never used. Remove it.

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

