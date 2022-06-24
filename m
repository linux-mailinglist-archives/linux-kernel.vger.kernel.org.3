Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C7C55A311
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 22:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbiFXUyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 16:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiFXUyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 16:54:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7BC828BB;
        Fri, 24 Jun 2022 13:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656104092; x=1687640092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mw1xWYvDJeQcXuK+ybShkvh0NRNvcsPV/txknrV1pAI=;
  b=h4BSSqveI65NsdYuj/jNPMtS+mF0OPiNVQQZffWqhjzpN0RqKcSaI+Tf
   tDSTGIYzXWT7XfC07fXHpNuHESD03Ae3lt5lE5/UFiUs9hOTaVQLwngvA
   2fmJrvRrhiJccYXDPubhiuwZA5A3R/qKTRRQAm67k+IHh84AMCy1SFrRY
   kLw2mKNoP0Mp/tdKmRYTUdWqq0jxnXnDZDh4Szskkk1Ph5AwRWXjpYHgi
   5/zFtgGP+wafjrETkpP3aY9gJArouwNhBJ+FkFnIcI7jAV7yB14DNMd3d
   UEeSlvq0mO716K5Nq7mR3ONCsn6k2LpqfeQ+Mq4shciwag4zCeeDAOnmj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10388"; a="281824573"
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="281824573"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 13:54:50 -0700
X-IronPort-AV: E=Sophos;i="5.92,220,1650956400"; 
   d="scan'208";a="593384265"
Received: from vhavel-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.216.91])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 13:54:48 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 3/6] serial: Use bits for UART_LSR_BRK_ERROR_BITS/MSR_ANY_DELTA
Date:   Fri, 24 Jun 2022 23:54:21 +0300
Message-Id: <20220624205424.12686-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220624205424.12686-1-ilpo.jarvinen@linux.intel.com>
References: <20220624205424.12686-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of listing the bits for UART_LSR_BRK_ERROR_BITS and
UART_MSR_ANY_DELTA in comment, use them to define instead.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/uapi/linux/serial_reg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
index f51bc8f36813..bab3b39266cc 100644
--- a/include/uapi/linux/serial_reg.h
+++ b/include/uapi/linux/serial_reg.h
@@ -139,7 +139,7 @@
 #define UART_LSR_PE		0x04 /* Parity error indicator */
 #define UART_LSR_OE		0x02 /* Overrun error indicator */
 #define UART_LSR_DR		0x01 /* Receiver data ready */
-#define UART_LSR_BRK_ERROR_BITS	0x1E /* BI, FE, PE, OE bits */
+#define UART_LSR_BRK_ERROR_BITS	(UART_LSR_BI|UART_LSR_FE|UART_LSR_PE|UART_LSR_OE)
 
 #define UART_MSR	6	/* In:  Modem Status Register */
 #define UART_MSR_DCD		0x80 /* Data Carrier Detect */
@@ -150,7 +150,7 @@
 #define UART_MSR_TERI		0x04 /* Trailing edge ring indicator */
 #define UART_MSR_DDSR		0x02 /* Delta DSR */
 #define UART_MSR_DCTS		0x01 /* Delta CTS */
-#define UART_MSR_ANY_DELTA	0x0F /* Any of the delta bits! */
+#define UART_MSR_ANY_DELTA	(UART_MSR_DDCD|UART_MSR_TERI|UART_MSR_DDSR|UART_MSR_DCTS)
 
 #define UART_SCR	7	/* I/O: Scratch Register */
 
-- 
2.30.2

