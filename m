Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9330547FB9D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbhL0Jqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235860AbhL0Jps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:45:48 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE802C061394
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:45:44 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZV-0006Yl-CW; Mon, 27 Dec 2021 10:45:37 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZU-006u9T-TG; Mon, 27 Dec 2021 10:45:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZT-0005Ws-M5; Mon, 27 Dec 2021 10:45:35 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        "Felipe Balbi (Intel)" <balbi@kernel.org>,
        Raymond Tan <raymond.tan@intel.com>
Subject: [PATCH v2 17/23] counter: intel-qep: Convert to new counter registration
Date:   Mon, 27 Dec 2021 10:45:20 +0100
Message-Id: <20211227094526.698714-18-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=xxaNj3Lr4F2nUU3L5jyLeMsoD9IgL3Fywde/z31RhRA=; m=3R8rN/LzNzQo1FXHZXjRMSNmOPiOoCX+fEd8aOKojqA=; p=PZNhgfrkhFxeqmpbLIe6pog2VoENjnSIHj4tDDoSTLs=; g=470d5595051e38ec00ec649e099aa79724b1deb2
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHJirUACgkQwfwUeK3K7An8hwgAhZS BfMRnFVO0wBcTvDK6ly4/mjQCw1xchYKsazGcdLDaOm+EuDV6XymNRx09JU5E/zbJ/Kh4Z9/Dr+Ia Z08m12vVdnFvwj6fIfSg1XwVmK5kZ6covcgwTRVhz5GK/khQUxJ10rpHxyuDlPzMZ9AxblQAkdCw/ nXColmwxIQqiCxBzpn4YH9dSUQqKV1gnHvMy04cIhzZQeUdSY1lQTbWNuI3ChdPxbtRlEuRIizZwe pOk6dB0O/5KciXhivuFf1FgnWZNZJIXl91ElOWENtAdnnyxGLyVTIt6+8YQSasvMosg6wy90G2kWf k7MmPG+DFx9g8XZHTD0q+lcZyc2w/hg==
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
2.33.0

