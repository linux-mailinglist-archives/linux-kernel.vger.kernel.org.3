Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2C85A11C0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242471AbiHYNSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242433AbiHYNSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:18:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC92201B6;
        Thu, 25 Aug 2022 06:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661433482; x=1692969482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qNYpsD0QAUqamHJ10Nj5m4QpCERSM1jcCkSlZAiHlgU=;
  b=P27U3gyn1BuiY6RrTltUMI8aYZkrF1RYjSr9nCA2eaCWE18PSXfDJzBy
   p60vo+XqKaoKfybh1zIIO1v9kiPMXblg7HHpcOcOwnw8+vzMfGEsSCKlY
   h47lw3/6LpW81dS+/UHSpJoenBUw5YkcsuemHxr2Mv0wLtCnoxqZkH2Uk
   ShHOcKuRblkjhVU1InB8Fhpd6uPeL58Q4vfy9sMs6GB7MViAE/n04RfPl
   Q4CaCEkzRAfQx6trA8UIxNGHT6tfdMWDqIFtnnarqvKIY7FdhY4i/xih9
   S26i/0d1dEmZ36AnrYecV+MKo7g/Ci5VQ6OUv9vzLKqhsv4OfIOZWeUUR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="294234940"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="294234940"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 06:18:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="670974585"
Received: from mblazque-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.101])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 06:18:00 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 2/2] serial: dz: Remove custom DZ_WAKEUP_CHARS
Date:   Thu, 25 Aug 2022 16:17:46 +0300
Message-Id: <20220825131746.21257-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220825131746.21257-1-ilpo.jarvinen@linux.intel.com>
References: <20220825131746.21257-1-ilpo.jarvinen@linux.intel.com>
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

Almost all serial drivers use WAKEUP_CHARS (256) from serial_core.h which
also matches what n_tty_poll() uses for asserting EPOLLOUT.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/dz.c | 2 +-
 drivers/tty/serial/dz.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index 5d2588f3e6a9..5df46f22abaa 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -283,7 +283,7 @@ static inline void dz_transmit_chars(struct dz_mux *mux)
 	dz_out(dport, DZ_TDR, tmp);
 	dport->port.icount.tx++;
 
-	if (uart_circ_chars_pending(xmit) < DZ_WAKEUP_CHARS)
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&dport->port);
 
 	/* Are we are done. */
diff --git a/drivers/tty/serial/dz.h b/drivers/tty/serial/dz.h
index 3b3e31954f24..4b502bfad560 100644
--- a/drivers/tty/serial/dz.h
+++ b/drivers/tty/serial/dz.h
@@ -124,7 +124,4 @@
 
 #define DZ_NB_PORT 4
 
-#define DZ_XMIT_SIZE   4096                 /* buffer size */
-#define DZ_WAKEUP_CHARS   DZ_XMIT_SIZE/4
-
 #endif /* DZ_SERIAL_H */
-- 
2.30.2

