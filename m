Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5B553EBBB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiFFKHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiFFKFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:05:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DBC8FD51;
        Mon,  6 Jun 2022 03:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509934; x=1686045934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gopuiUjawsIQJXpUDy/dJyIooGKGJ4go2NXCzVHTfHA=;
  b=aOvs0MvObGjSQ4I9794yc+RpmQl4yl5Do4BcR0YGmmqcMI9y1wifOiUd
   GURijDOcR2+zUu0IPCCwt0B/5788zoE3gksNc5eNtL/qAhe5YxaTNFr53
   sK97PSNzCBj5Rl+8mjaCDY6y5wyxK/+5vb3uVMjOjk6dmiVOpdW/RD76T
   vLzN6EWzMuEucI1ep8QGPun1ppzhA39/fKooVr+hEutPhFb5Ti2CDCsX9
   Xb/xH93veY65xPOuLPibzcEJc1iqx00lMpRJbvmHQvubpvF+XYrDXKbaA
   xlWNsJDnqaF/ws05eG7zox9N8Hefw6vdgJz0tBE4mPpFZmuDVWE6zWncP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987050"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987050"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:24 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523653"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:22 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 11/36] serial: 8250_pci: Fill in rs485_supported for pci_fintek
Date:   Mon,  6 Jun 2022 13:04:08 +0300
Message-Id: <20220606100433.13793-12-ilpo.jarvinen@linux.intel.com>
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
 drivers/tty/serial/8250/8250_pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index fb0a49e39072..a76254031bc2 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -1597,6 +1597,11 @@ static int pci_fintek_rs485_config(struct uart_port *port,
 	return 0;
 }
 
+static const struct serial_rs485 pci_fintek_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
+	/* F81504/508/512 does not support RTS delay before or after send */
+};
+
 static int pci_fintek_setup(struct serial_private *priv,
 			    const struct pciserial_board *board,
 			    struct uart_8250_port *port, int idx)
@@ -1616,6 +1621,7 @@ static int pci_fintek_setup(struct serial_private *priv,
 	port->port.iotype = UPIO_PORT;
 	port->port.iobase = iobase;
 	port->port.rs485_config = pci_fintek_rs485_config;
+	port->port.rs485_supported = &pci_fintek_rs485_supported;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(u8), GFP_KERNEL);
 	if (!data)
-- 
2.30.2

