Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637485515F6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbiFTKeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240233AbiFTKeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:34:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56641408B;
        Mon, 20 Jun 2022 03:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655721269; x=1687257269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MjaLBNVZD6GIe/krItfqqymmS/cXarankYY7kmlJRRQ=;
  b=XU49rJxV4HZhq1K2uJFnplHDV6C/s1M01twH3y8WCocxf/7IeMZ0bgf3
   Zme9GrFOoA3EYDNZNrfdwyIhibCktDG7dvUdgIQJ0g/vpwmelO4uxn7aI
   y1rxf4ZGSMxfjwOstcdnf6egrf4Y1yb2q6zDwEreDAgjXza1NIhQdCELF
   gRnCcD0VpqT5tq7pxDWLQCbjPoH78D65rXJXkIN391aqCpnViX382QqYM
   lIkmQImfkfcX88aZS4m17gURXRwlv7XD7MmmW4gc7zFJijb+mvefyXHxp
   1f7ZUucNcY7P7ULeXTF26hXEZzKsYo2qJFQ0A+gj+VPCsyYgQvZju+tDm
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="341543288"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="341543288"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:34:29 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="643055501"
Received: from lspinell-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.215.169])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 03:34:27 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/6] serial: Use bits for UART_LSR_BRK_ERROR_BITS/MSR_ANY_DELTA
Date:   Mon, 20 Jun 2022 13:34:05 +0300
Message-Id: <20220620103408.37454-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220620103408.37454-1-ilpo.jarvinen@linux.intel.com>
References: <20220620103408.37454-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of listing the bits for UART_LSR_BRK_ERROR_BITS and
UART_MSR_ANY_DELTA in comment, use them to define instead.

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

