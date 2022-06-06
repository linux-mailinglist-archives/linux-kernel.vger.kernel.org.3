Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA20E53EB1A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiFFKIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiFFKGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:06:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3261128C2C;
        Mon,  6 Jun 2022 03:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509951; x=1686045951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S3gDlxKOTB6cNszyQehsU3Wkz7UsMQbXrzXb2KIgEfU=;
  b=VN5mTF4UczqR+iuDwFRsQL79FdxOThp9BmshVAmyF16nGr3koUE7Gjqf
   GbC865z7PAEgSIEdKptrsIW4KS0XmEAj+kZtpX7/NGKoqWE+OCwormabm
   gHn/AjtyGn1daVakk2z6EiEtB1FcixPg/gJFgRJH9QyNrQ+p/2OoGAYNH
   U3KMdp0jS+lI1o/QBKiLFKZGEyMVwllHe9naFt6IinQaUIqTanCVn/KWC
   6xwcI60dqkKuWO+TRgxf3rdaMKS5WgnPtLAOMo4L15+0faZj7H3N8UhSu
   587FwYjKQFLdRZu7AZfSwqZHiMGpuXzfRSfjolKoYtf4Zu/zgBXK1D2e3
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987068"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987068"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523780"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:50 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 20/36] serial: sc16is7xx: Fill in rs485_supported
Date:   Mon,  6 Jun 2022 13:04:17 +0300
Message-Id: <20220606100433.13793-21-ilpo.jarvinen@linux.intel.com>
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

This driver does not support delay_rts_after_send but the pre-existing
behavior is to return -EINVAL if delay_rts_after_send is non-zero. In
contrast, other drivers that do not support delay_rts_after_send either
zero delay_rts_after_send or do not care (leave the inaccurate value).
As changing this would cause userspace visible impact, the change is
not attempted here. But perhaps it should be still tried (maybe nobody
finds that kind of API oddity significant)?

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/sc16is7xx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 8472bf70477c..b3162dfe97b1 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1354,6 +1354,12 @@ static int sc16is7xx_gpio_direction_output(struct gpio_chip *chip,
 }
 #endif
 
+static const struct serial_rs485 sc16is7xx_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND,
+	.delay_rts_before_send = 1,
+	.delay_rts_after_send = 1,	/* Not supported but keep returning -EINVAL */
+};
+
 static int sc16is7xx_probe(struct device *dev,
 			   const struct sc16is7xx_devtype *devtype,
 			   struct regmap *regmap, int irq)
@@ -1456,6 +1462,7 @@ static int sc16is7xx_probe(struct device *dev,
 		s->p[i].port.iotype	= UPIO_PORT;
 		s->p[i].port.uartclk	= freq;
 		s->p[i].port.rs485_config = sc16is7xx_config_rs485;
+		s->p[i].port.rs485_supported = &sc16is7xx_rs485_supported;
 		s->p[i].port.ops	= &sc16is7xx_ops;
 		s->p[i].old_mctrl	= 0;
 		s->p[i].port.line	= sc16is7xx_alloc_line();
-- 
2.30.2

