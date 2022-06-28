Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CC755E761
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346831AbiF1NnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346822AbiF1Nmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:42:52 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF5827CFE;
        Tue, 28 Jun 2022 06:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656423771; x=1687959771;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=/YGgMPxrsMSQlXCWrjRM6rpDxigDXo+yUsU1t73bO+c=;
  b=caKpNtdkSG5a8jfXIozvwCLS1LkXxee/3vBEui9KSx6yssL5lkqiDzic
   JoC8GnzWeIlt2jOonDtVN9wjFdWBXcFYNS58oTA0GopNzBH7LkqpigOen
   eDuKX7ptArrRlqlN3far0U4S1gFD4ZVRh2hj0GPKRW/KY/n3CPqoovH0O
   XrpLD8wg2uo5+wDo4WgGOjGAzvuzGXJIBkvMCxZOdvxzbCFL2IdTjYH10
   rrv+EBjEQUq5mthLdbW6iIX2F1O7cKUQufSB0tCatjvXDatJ+ldLPxEf2
   KCNfZgo3bsiXAblyOpU8LNVqjrqvCQpOBeDsy/Aj2EpU0nKEKchpmc8Oe
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="281780641"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="281780641"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 06:42:51 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646918023"
Received: from iannetti-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.216.215])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 06:42:49 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] serial: 8250_dw: Rename offset to reg_offset
Date:   Tue, 28 Jun 2022 16:42:32 +0300
Message-Id: <20220628134234.53771-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220628134234.53771-1-ilpo.jarvinen@linux.intel.com>
References: <20220628134234.53771-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get 'offset' variable out of the way of parameter named 'offset',
rename it to 'reg_offset'. This is very short lived change as
reg_offset is going to be soon removed.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 41bf063396e4..f18975b4d2c7 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -89,7 +89,7 @@ static void dw8250_force_idle(struct uart_port *p)
 
 static void dw8250_check_lcr(struct uart_port *p, int value)
 {
-	void __iomem *offset = p->membase + (UART_LCR << p->regshift);
+	void __iomem *reg_offset = p->membase + (UART_LCR << p->regshift);
 	int tries = 1000;
 
 	/* Make sure LCR write wasn't ignored */
@@ -103,15 +103,15 @@ static void dw8250_check_lcr(struct uart_port *p, int value)
 
 #ifdef CONFIG_64BIT
 		if (p->type == PORT_OCTEON)
-			__raw_writeq(value & 0xff, offset);
+			__raw_writeq(value & 0xff, reg_offset);
 		else
 #endif
 		if (p->iotype == UPIO_MEM32)
-			writel(value, offset);
+			writel(value, reg_offset);
 		else if (p->iotype == UPIO_MEM32BE)
-			iowrite32be(value, offset);
+			iowrite32be(value, reg_offset);
 		else
-			writeb(value, offset);
+			writeb(value, reg_offset);
 	}
 	/*
 	 * FIXME: this deadlocks if port->lock is already held
-- 
2.30.2

