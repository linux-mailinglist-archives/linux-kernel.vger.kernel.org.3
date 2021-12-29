Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F274814B5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 16:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240797AbhL2Ppm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 10:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240632AbhL2Po6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 10:44:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87165C06175D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 07:44:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8H-0006qX-8d; Wed, 29 Dec 2021 16:44:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8G-007KHT-Lh; Wed, 29 Dec 2021 16:44:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8F-00015A-Ls; Wed, 29 Dec 2021 16:44:51 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH v3 17/23] counter: intel-qep: Convert to new counter registration
Date:   Wed, 29 Dec 2021 16:44:35 +0100
Message-Id: <20211229154441.38045-18-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2585; h=from:subject; bh=mzTA/0SVSt6Zg5a8YAIzLvS/FUvKzhlK/TyLmD2WeP8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzIJM/e4/TFKfAT0n53Xuj6xEs/f60hAC0BztFLCd e0evtYOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYcyCTAAKCRDB/BR4rcrsCQNmCA CIAfdB8EWPt1sa0ZIAhRgiIU6DvDdPAHCdn7HgAGiAgBk2GPwQL+EdudTCFLZObS3VivLEwQ6u9wFm zRIqwnvH5zYXbhxN7EM1aYftSskhgDVSsQz5MT5spWKRZp5H+FWxx9WNgFT3fismz1v4Su5XIn/Q6F rIyWqNEgmeMzz058SlUc7aXO0zs/oly0EPhKUGCc7Aq+kuJn/AYrnHaruY2PPWHbLoPMPxIb0f45d2 uzlEEZTM0f+kIMfhKZz+IWbF1Qj+XyG+mLR+WHk09K4DV4xBkBzKH0q21c/3DNSkmxnZDY3vdmAU4c Cg7ecShnEIwUD4yu69eH9tfqmtM0HX
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes device lifetime issues where it was possible to free a live
struct device.

Fixes: b711f687a1c1 ("counter: Add support for Intel Quadrature Encoder Peripheral")
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/intel-qep.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/counter/intel-qep.c b/drivers/counter/intel-qep.c
index 8f84a48508ac..47a6a9dfc9e8 100644
--- a/drivers/counter/intel-qep.c
+++ b/drivers/counter/intel-qep.c
@@ -63,7 +63,6 @@
 #define INTEL_QEP_CLK_PERIOD_NS		10
 
 struct intel_qep {
-	struct counter_device counter;
 	struct mutex lock;
 	struct device *dev;
 	void __iomem *regs;
@@ -392,14 +391,16 @@ static struct counter_count intel_qep_counter_count[] = {
 
 static int intel_qep_probe(struct pci_dev *pci, const struct pci_device_id *id)
 {
+	struct counter_device *counter;
 	struct intel_qep *qep;
 	struct device *dev = &pci->dev;
 	void __iomem *regs;
 	int ret;
 
-	qep = devm_kzalloc(dev, sizeof(*qep), GFP_KERNEL);
-	if (!qep)
+	counter = devm_counter_alloc(dev, sizeof(*qep));
+	if (!counter)
 		return -ENOMEM;
+	qep = counter_priv(counter);
 
 	ret = pcim_enable_device(pci);
 	if (ret)
@@ -422,20 +423,23 @@ static int intel_qep_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	intel_qep_init(qep);
 	pci_set_drvdata(pci, qep);
 
-	qep->counter.name = pci_name(pci);
-	qep->counter.parent = dev;
-	qep->counter.ops = &intel_qep_counter_ops;
-	qep->counter.counts = intel_qep_counter_count;
-	qep->counter.num_counts = ARRAY_SIZE(intel_qep_counter_count);
-	qep->counter.signals = intel_qep_signals;
-	qep->counter.num_signals = ARRAY_SIZE(intel_qep_signals);
-	qep->counter.priv = qep;
+	counter->name = pci_name(pci);
+	counter->parent = dev;
+	counter->ops = &intel_qep_counter_ops;
+	counter->counts = intel_qep_counter_count;
+	counter->num_counts = ARRAY_SIZE(intel_qep_counter_count);
+	counter->signals = intel_qep_signals;
+	counter->num_signals = ARRAY_SIZE(intel_qep_signals);
 	qep->enabled = false;
 
 	pm_runtime_put(dev);
 	pm_runtime_allow(dev);
 
-	return devm_counter_register(&pci->dev, &qep->counter);
+	ret = devm_counter_add(&pci->dev, counter);
+	if (ret < 0)
+		return dev_err_probe(&pci->dev, ret, "Failed to add counter\n");
+
+	return 0;
 }
 
 static void intel_qep_remove(struct pci_dev *pci)
-- 
2.34.1

