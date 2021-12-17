Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDB04793A8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 19:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240097AbhLQSP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 13:15:59 -0500
Received: from mga12.intel.com ([192.55.52.136]:62370 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236073AbhLQSP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:15:57 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="219822060"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="219822060"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 10:15:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="466593784"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 17 Dec 2021 10:15:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B0728109; Fri, 17 Dec 2021 20:15:51 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v2 1/1] serial: 8520_mtk: Prepare for platform_get_irq_optional() changes
Date:   Fri, 17 Dec 2021 20:15:47 +0200
Message-Id: <20211217181547.48182-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_get_irq_optional() is going to be changed in a way
that the result of it:
   = 0 means no IRQ is provided
   < 0 means the error which needs to be propagated to the upper layers
   > 0 valid vIRQ is allocated

In this case, drop check for 0. Note, the 0 is not valid vIRQ and
platform_get_irq_optional() issues a big WARN() in such case,

It's safe to assume that 0 is not valid IRQ in this case since
the driver is only instantiated via Device Tree and corresponding
OF APIs should never ever return 0 for valid IRQ. Otherwise it is
a regression there.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: explained why it's safe to assume 0 is not valid here (Greg)
 drivers/tty/serial/8250/8250_mtk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index fb65dc601b23..328ab074fd89 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -621,7 +621,7 @@ static int __maybe_unused mtk8250_suspend(struct device *dev)
 	serial8250_suspend_port(data->line);
 
 	pinctrl_pm_select_sleep_state(dev);
-	if (irq >= 0) {
+	if (irq > 0) {
 		err = enable_irq_wake(irq);
 		if (err) {
 			dev_err(dev,
@@ -641,7 +641,7 @@ static int __maybe_unused mtk8250_resume(struct device *dev)
 	struct mtk8250_data *data = dev_get_drvdata(dev);
 	int irq = data->rx_wakeup_irq;
 
-	if (irq >= 0)
+	if (irq > 0)
 		disable_irq_wake(irq);
 	pinctrl_pm_select_default_state(dev);
 
-- 
2.34.1

