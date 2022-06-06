Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1C253E795
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiFFKHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiFFKFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:05:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CC2117645;
        Mon,  6 Jun 2022 03:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509943; x=1686045943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s53Dk60G9dMXNR1df+TpMHjiob82mIuwJNYs7D/wnls=;
  b=QCA28Xbl2JNHIC/uW60Cy+lEXQgU9ePdPU1z8InqV60WyCGMo7IFFVkW
   DXWwOr5fxtBuwo3iNCWjaUEzhnzrDL45kiS5PxQQv/EEUFc5QXQM/NUXk
   9gDAfTSaGay9Yk7pnqsZIPchJOuYK1LK7yrd4aOx8JscI8lmhRQqBaRFV
   r8Lnu3Ei2NMbA3x8Yo8VwbKa7E9UMe0oaW+DPgL1qRb7sGXEk4e8bb3Bh
   vb3pCH91VPAm1HOj1cxMJlZmELB3RI+U/yRDZ5K6kBPXFEKK3oxeP6qIw
   7RfaTt98sWy2KjbGOGn1+myhfiSxiYi/Rtsstpl1Api1PbYEllwdwG1QU
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987061"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987061"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523745"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:42 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 17/36] serial: max310x: Fill in rs485_supported
Date:   Mon,  6 Jun 2022 13:04:14 +0300
Message-Id: <20220606100433.13793-18-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220606100433.13793-1-ilpo.jarvinen@linux.intel.com>
References: <20220606100433.13793-1-ilpo.jarvinen@linux.intel.com>
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

Add information on supported serial_rs485 features.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/max310x.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index a0b6ea52d133..9837f542a55a 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1249,6 +1249,12 @@ static int max310x_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 }
 #endif
 
+static const struct serial_rs485 max310x_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX,
+	.delay_rts_before_send = 1,
+	.delay_rts_after_send = 1,
+};
+
 static int max310x_probe(struct device *dev, const struct max310x_devtype *devtype,
 			 struct regmap *regmap, int irq)
 {
@@ -1357,6 +1363,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		s->p[i].port.membase	= (void __iomem *)~0;
 		s->p[i].port.uartclk	= uartclk;
 		s->p[i].port.rs485_config = max310x_rs485_config;
+		s->p[i].port.rs485_supported = &max310x_rs485_supported;
 		s->p[i].port.ops	= &max310x_ops;
 		/* Disable all interrupts */
 		max310x_port_write(&s->p[i].port, MAX310X_IRQEN_REG, 0);
-- 
2.30.2

