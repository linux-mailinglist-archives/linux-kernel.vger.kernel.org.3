Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2504E4A8729
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 16:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351586AbiBCPAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 10:00:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:53916 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236285AbiBCPAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 10:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643900416; x=1675436416;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/wqGST5cVZHtdkOvgNEKxHP5ekD0HZLCqxuIjRXXfUE=;
  b=Ikr6TeJvnQElb7rTRF+w6ascxX74O1eum/CuK/LJrAIA69PDDzhHLtiR
   /dLsDLjvu4gQ1fQvuvTcwYvgqEUlgrXgKseRMRV0iRRf3f9zLYSxsRa4g
   C74ziBAcScHert/uyygjM4dYLaStwXmIlyPRcTmZ59MII8CN0cJxrnYI5
   SMApOo/fPnnobA4Hd3mwSNPFDv0zaTeoUSj1zzdDG6bSLsG0TJnutU9Uj
   wasSLYC93S0Q3hf9oP/MHwMdfCrEXQFKDN07ZMS4GtjFMvQ1IbFdANfCc
   Rf5GulX07LHe+M39SHkkN6/LnFSE4mpqi9vFQvazxV3mWd8ZtfokABrAD
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="248110077"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="248110077"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 07:00:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="583810293"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 03 Feb 2022 07:00:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0FD9630A; Thu,  3 Feb 2022 17:00:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v1 1/1] serial: 8250_pericom: Revert "Re-enable higher baud rates"
Date:   Thu,  3 Feb 2022 17:00:26 +0200
Message-Id: <20220203150026.19087-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UPF_MAGIC_MULTIPLIER is userspace available bit and can be changed
at any time. There is no sense to rely on it to be always present.

This reverts commit b4ccaf5aa2d795ee7f47a6eeb209f3de981e1929.

Note, that code was not reliably worked before, hence it implies
no functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/8250/8250_pericom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pericom.c b/drivers/tty/serial/8250/8250_pericom.c
index 025b055363c3..95ff10f25d58 100644
--- a/drivers/tty/serial/8250/8250_pericom.c
+++ b/drivers/tty/serial/8250/8250_pericom.c
@@ -117,7 +117,7 @@ static int pericom8250_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	uart.port.private_data = pericom;
 	uart.port.iotype = UPIO_PORT;
 	uart.port.uartclk = 921600 * 16;
-	uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ | UPF_MAGIC_MULTIPLIER;
+	uart.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
 	uart.port.set_divisor = pericom_do_set_divisor;
 	for (i = 0; i < nr && i < maxnr; i++) {
 		unsigned int offset = (i == 3 && nr == 4) ? 0x38 : i * 0x8;
-- 
2.34.1

