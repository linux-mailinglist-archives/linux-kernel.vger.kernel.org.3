Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D61653E7CC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbiFFKGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiFFKFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:05:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC4864722;
        Mon,  6 Jun 2022 03:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654509928; x=1686045928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7X5MPO2HXoQHC4qsFsROjNvsfaX0x10tatJ5YNAZRDs=;
  b=AYAuQAyWMqL1ZH3i1upJZGOWALb3bFR4oRzJ9N0E1sNuEuBNER4QLqDi
   WSiyYhVY9KpFPHE31I8DI6G8GYIoyv3D74D+rk7+0o2IwPV95w2Ka6Ydz
   xcHsLd7sXIObNlbriSFHTyWKhhZL1MISzAliktRQFk4+E2eXSDooXVkwm
   ARgvGCBLvYqcoIX2kb6k7Mw7HZ4MZebJq/NLwzWhA/VOUq+KXwV79hh23
   ZCC86MyCHMQ9gd0qMw5Frmfzfa5OdDNLEg15sqDwZCuy8G9MDooa6j6H+
   4GiQqCO2FTbTiv4pDVBLK4Cj04TytLXXDpSX8/c+jdwniEjEpnI0OHnaM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="362987037"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="362987037"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="635523506"
Received: from amkossek-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.57.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 03:05:04 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 05/36] serial: 8250_bcm2835aux: Use serial8250_em485_supported
Date:   Mon,  6 Jun 2022 13:04:02 +0300
Message-Id: <20220606100433.13793-6-ilpo.jarvinen@linux.intel.com>
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

bcm2835aux uses em485, fill in rs485_supported accordingly.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_bcm2835aux.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index 2a1226a78a0c..d9f1e618cfbd 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -108,6 +108,7 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	up.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT | UPF_FIXED_TYPE |
 			UPF_SKIP_TEST | UPF_IOREMAP;
 	up.port.rs485_config = serial8250_em485_config;
+	up.port.rs485_supported = &serial8250_em485_supported;
 	up.rs485_start_tx = bcm2835aux_rs485_start_tx;
 	up.rs485_stop_tx = bcm2835aux_rs485_stop_tx;
 
-- 
2.30.2

