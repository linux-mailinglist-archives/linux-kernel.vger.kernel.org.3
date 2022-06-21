Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED3555327A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350865AbiFUMug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350812AbiFUMuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:50:22 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955EE2A43D;
        Tue, 21 Jun 2022 05:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655815821; x=1687351821;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MjaLBNVZD6GIe/krItfqqymmS/cXarankYY7kmlJRRQ=;
  b=ksD0ioJ+KUj+l9YH1eGdw8L4jXMrXRJtucUcrLEuSFbM2lZe+o+8eoUJ
   F/tUnIi25TSsifJCdyhhGWigZy4xJlSQQs1Fg2iCSxK/kGvXrv7FXjq9a
   QuEdQDs9BNrDSkGYqBRzeMQBNjrzmSqecEhtGzn0q0XjvcMUnYLy3qJox
   5cjPlpue5OZu23/Tg+oY7Mq6qG1IEv456Kb0gvD7yliKaa5k330tPH9xk
   NwWW2vEjoJJl2f/TLIIaUWJakI7Lfc4O/j+lB0dviz+kftIzOrbsf8N3T
   dYQoGBN2aRQ6B17n6sfB3w+EyYfwHddBKmSIJW/rx3q0bXTunJaX7WwVo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="341792996"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="341792996"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 05:50:21 -0700
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="833561579"
Received: from zjeffery-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.41.211])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 05:50:19 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 3/6] serial: Use bits for UART_LSR_BRK_ERROR_BITS/MSR_ANY_DELTA
Date:   Tue, 21 Jun 2022 15:49:55 +0300
Message-Id: <20220621124958.3342-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220621124958.3342-1-ilpo.jarvinen@linux.intel.com>
References: <20220621124958.3342-1-ilpo.jarvinen@linux.intel.com>
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

