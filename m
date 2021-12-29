Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8441A4814BC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 16:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbhL2PqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 10:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240666AbhL2PpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 10:45:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D047C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 07:45:01 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8J-0006qR-U0; Wed, 29 Dec 2021 16:44:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8E-007KH8-Sq; Wed, 29 Dec 2021 16:44:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2b8D-00013i-U1; Wed, 29 Dec 2021 16:44:49 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, David Lechner <david@lechnology.com>
Subject: [PATCH v3 10/23] counter: ti-eqep: Convert to counter_priv() wrapper
Date:   Wed, 29 Dec 2021 16:44:28 +0100
Message-Id: <20211229154441.38045-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=722; h=from:subject; bh=UH/1V9o9IsEhvPOBCAdcab4TG315ms1cIGl6e2AcYsU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzIIx3PbpyxDVpf4se5t5cLwiZFWobaV9D5VZuTEi ZPez8RyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYcyCMQAKCRDB/BR4rcrsCSZmB/ sHwyyqIMwjXnAr5m/XLSsip8eGKguB+u4QI+LlJeS1UqkTvXwjbwTol8fmi5KOYP0cxmxoOpfnjBWV x/1XPl9nMrdvZhA7CDyJpqRqGzMGANB0d17KbtMvnxQBinK/9TT2/mGR0JXc4HY7p3DvUmy2aeQ73U JlWVkhUT+uPq+wob/QIv1+aRv/gpNENvBOsvBZ2eTk8yEeGURNaEivb0N78ix85f93sDqC4XjjX0jX /ISYdV3FOrzvtp4QrV35g9vU4OaFrvNH0G4xdd9ZwyMh0cJQa8UEJOWxm0gpcDBJvIBFTuR9/ZYZZi pr32E6V/lBv/s/VMpnrmkhUJ2CsC/d
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a straight forward conversion to the new counter_priv() wrapper.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/ti-eqep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 9e0e46bca4c2..2c70b900a6cf 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -89,7 +89,7 @@ struct ti_eqep_cnt {
 
 static struct ti_eqep_cnt *ti_eqep_count_from_counter(struct counter_device *counter)
 {
-	return container_of(counter, struct ti_eqep_cnt, counter);
+	return counter_priv(counter);
 }
 
 static int ti_eqep_count_read(struct counter_device *counter,
-- 
2.34.1

