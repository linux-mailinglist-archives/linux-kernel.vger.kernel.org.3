Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B755A0C58
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239158AbiHYJR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238975AbiHYJRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:17:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0174A062B;
        Thu, 25 Aug 2022 02:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661419042; x=1692955042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9+lx1HzG04e5k5sEzXWpzZOt+GQWi0Mg6hvnqiGQuF4=;
  b=LhFFtXb9Z4Lu57ZLnEKuh7t71zBt9Wr3RSxIQI+GsrSdrFxPLtf4DW04
   U+Mik9gnCZEA5SN61MTqwNUA96nkpR8kkhpQS/4TrQsPB6uoCQa7AdGa+
   EbgTc7nT+GoPj2tPTkm/TVXgd6kRNf3SnjyJA5YV4RQ+03rozAs11Yuvm
   lzSIZk+aT7hIbPlrHeR7EikaEg82vWfPp1PBV1NHW36dT3O/C9j3xyLnA
   NQ0/FJ8NPyObx1u3GI1kj8ci6FqSf/coYCIhQta0Ce/EXS8EOi6RVdKit
   gvQYtRmnofr1ZiGTMh0oe3KcCg6paZeQ0oAw0+BJCHe2Zv0XCe3sE290i
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="355917168"
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="355917168"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 02:17:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,262,1654585200"; 
   d="scan'208";a="938254127"
Received: from mblazque-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.101])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 02:17:18 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, Stephen Warren <swarren@nvidia.com>,
        Alan Cox <alan@linux.intel.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/3] serial: Create uart_xmit_advance()
Date:   Thu, 25 Aug 2022 12:17:05 +0300
Message-Id: <20220825091707.8112-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220825091707.8112-1-ilpo.jarvinen@linux.intel.com>
References: <20220825091707.8112-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A very common pattern in the drivers is to advance xmit tail
index and do bookkeeping of Tx'ed characters. Create
uart_xmit_advance() to handle it.

Fixes: e9ea096dd225 ("serial: tegra: add serial driver")
Fixes: 2d908b38d409 ("serial: Add Tegra Combined UART driver")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/linux/serial_core.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index aef3145f2032..ffc7b8cb7a7f 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -616,6 +616,23 @@ struct uart_state {
 /* number of characters left in xmit buffer before we ask for more */
 #define WAKEUP_CHARS		256
 
+/**
+ * uart_xmit_advance - Advance xmit buffer and account Tx'ed chars
+ * @up: uart_port structure describing the port
+ * @chars: number of characters sent
+ *
+ * This function advances the tail of circular xmit buffer by the number of
+ * @chars transmitted and handles accounting of transmitted bytes (into
+ * @up's icount.tx).
+ */
+static inline void uart_xmit_advance(struct uart_port *up, unsigned int chars)
+{
+	struct circ_buf *xmit = &up->state->xmit;
+
+	xmit->tail = (xmit->tail + chars) & (UART_XMIT_SIZE - 1);
+	up->icount.tx += chars;
+}
+
 struct module;
 struct tty_driver;
 
-- 
2.30.2

