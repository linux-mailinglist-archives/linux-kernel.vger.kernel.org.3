Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E322E5A9A9D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbiIAOkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbiIAOjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:39:52 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E145266D;
        Thu,  1 Sep 2022 07:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662043189; x=1693579189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WNwFYsnxejnsb3PAJO0FgVsTN5fGGjYc+Bh4CgV230I=;
  b=XJhOR5DT38D0jb/z6qjrV6WOxbJi8dpuIERH2wLNqS0G4ysjbADNSW+C
   Qv5GqHBZVWrFltE9hrm8Rkyc1Uqavoun1SphEM0R1EgM17kbSKLKX2jow
   TGeI66/PCh/Th+TEBTN56HaETGtX1Bs6gSgQcGZsgLN8X7RB5Hzr0FQMy
   Vxzc1sWedjPviUMop8IZ6BXTB16/MqfC9bH47ohIuGinwejM7qzfuECD+
   IRpBF37LZAoaONiUQVWbKRvJYhnVcdDTjfisMi9zW3omLr9KuugNs1keQ
   Yad1eelG2gknckpN5sjNBDoOP1dkMiCuPkq5UEOfsT9DWs1efQlkWQaKz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="321880096"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="321880096"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 07:39:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="642356651"
Received: from rmalliu-mobl.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.65])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 07:39:46 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 RESEND 1/3] serial: Create uart_xmit_advance()
Date:   Thu,  1 Sep 2022 17:39:32 +0300
Message-Id: <20220901143934.8850-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220901143934.8850-1-ilpo.jarvinen@linux.intel.com>
References: <20220901143934.8850-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A very common pattern in the drivers is to advance xmit tail
index and do bookkeeping of Tx'ed characters. Create
uart_xmit_advance() to handle it.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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

