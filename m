Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5410C54812F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 10:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239282AbiFMH6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 03:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiFMH5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 03:57:50 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BD01141;
        Mon, 13 Jun 2022 00:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655107068; x=1686643068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rE6Hiw9VT2zctLsLe9eZMJ86lbeDuRhRufHrNJ8aH5Q=;
  b=FNx3mn5kmRdrNy3MHOcgWsTMeunZHH2ojR0geRouCiR4Y8AmNy5RZY4R
   wEnFhQk7cPeDNU8YtvkCbfth/hg98OLM5gGRuauQk0N69ItAWi4duZINf
   3WwGXJSUGGwwnspqLo8Z0t+jaK7HDpm0ibDzOzMHFweS0T4eo9V+qZDrQ
   7UpHxnonkjEpxLF468wKHZJkeAMzWxpwtUsW3GIvJhIXlci0RgsG9XTAp
   PsjwD6qNCD/BUTY9lbdAUfD+JgpeoCD+QbUgIK6JExaF+4vM9z+heY5AT
   MV0U/bp3c3V26R7+IHbYSsRvPwjCXLazzbw7cbhw+sqtdsaV8ldy8Fltq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="279252577"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="279252577"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 00:57:48 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="587667386"
Received: from fnechitx-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.40.115])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 00:57:46 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/2] serial: 8250_pericom: Use UART_LCR_DLAB
Date:   Mon, 13 Jun 2022 10:57:36 +0300
Message-Id: <20220613075736.12283-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613075736.12283-1-ilpo.jarvinen@linux.intel.com>
References: <20220613075736.12283-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use UART_LCR_DLAB instead of literal.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_pericom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pericom.c b/drivers/tty/serial/8250/8250_pericom.c
index 95ff10f25d58..b8d5b7714a9d 100644
--- a/drivers/tty/serial/8250/8250_pericom.c
+++ b/drivers/tty/serial/8250/8250_pericom.c
@@ -73,7 +73,7 @@ static void pericom_do_set_divisor(struct uart_port *port, unsigned int baud,
 			struct uart_8250_port *up = up_to_u8250p(port);
 			int lcr = serial_port_in(port, UART_LCR);
 
-			serial_port_out(port, UART_LCR, lcr | 0x80);
+			serial_port_out(port, UART_LCR, lcr | UART_LCR_DLAB);
 			serial_dl_write(up, divisor);
 			serial_port_out(port, 2, 16 - scr);
 			serial_port_out(port, UART_LCR, lcr);
-- 
2.30.2

