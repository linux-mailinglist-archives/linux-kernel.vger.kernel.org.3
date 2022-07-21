Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF40F57C66C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiGUIgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbiGUIg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:36:28 -0400
Received: from smtpcmd02101.aruba.it (smtpcmd02101.aruba.it [62.149.158.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 898233A486
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:36:23 -0700 (PDT)
Received: from asem-TANK-H61.asem.intra ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id ERe9oJVIEtk1HEReRojXy2; Thu, 21 Jul 2022 10:35:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1658392522; bh=d3ojLOveqXbmSiZO4Qo5C01LjgUH9rwc4A6+CEo+xVo=;
        h=From:To:Subject:Date:MIME-Version;
        b=FQ/8T24nFLJ7wl2q868J8AckjLWYO0PHwwRxM++IGFwqfsZVNkNfbePCH+lX1MwBG
         urnxGBw6BkH2aYwh5Dp7e0Nq/YgNvB9CcbfN0VbaDDkVXg3dNJC9uLh+YFgp8vgKqc
         bRsjdLm6AD0Xuh1yacCaMG852k/hA0ilqEYFQZ8W2uLAqYLqVwm5nOjnRUtVRYOg4R
         i2Cpf8k7gnhQz28VsJdUTl+8pR3DaTEfZ4GSO9U7OdRX73FODY9P+10j6uEgApxsuP
         0A2v8BnrFL4T7KZaEIRLiseq3Cfw1qrR95Cip3GCQHAdqiEQ1l7pSAUKdEqpSCz3Kr
         pEQQ9w+nWwOVQ==
From:   Luca Ellero <luca.ellero@brickedbrain.com>
To:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: [PATCH v2 3/3] ads7846: don't check penirq immediately for 7845
Date:   Thu, 21 Jul 2022 10:34:58 +0200
Message-Id: <20220721083458.6412-4-luca.ellero@brickedbrain.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721083458.6412-1-luca.ellero@brickedbrain.com>
References: <20220721083458.6412-1-luca.ellero@brickedbrain.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFbdTgu8oX/OZAFfyhgjeweFgExsOWhbkk4p92LNQsdkO1lpmrlOwkJxIz3lfVBUyr7aPxpcaWaAkJ7ExQ0POBk0gtz+oEhGquM92q/1R0/8WWmUQRPU
 7GrCa7XoLa0RaWyuUxfueDzLeracnhE+LwqBcc9ddzbVRalbVP706cBymI2tizvoGpNB84P5IdRMPf+q0ddZ0ZVweKt2BBRBVcHKLOGnJjZH0pInqdabL+TP
 oLr4DcUtirIOJNoOBMCC1IqK8S5Qer850cbxEqZoBKfPMrEtgYe1ZXqrUyg8RBG5e6M1lkrf3MTxXhUd4mOnT9/bO/i0ncrI4unNa2k47Tri4XrxVNP2jHgP
 3ZAJ61TjDMCx+vos8s7g75OiWXJsCZ/rlNJ+my/GkhbGxQQVy3cpLkMxnTZbz/igMbsUammXXcQTFGuvsViD8G2TGw805uydgGwlhm9oIj+dynNc/RXbvk6i
 TGzwyrpdlYxjgyJGQUPwtYcyqFb5fa7iUBrLbFBql/c0hpLm+3Omv2Jl9KFxCkDjjzMSdDCc68yfXnH2Cw9QnfyURXJEnkDH/IAVZgtKwB4iQKFCAKOAbk//
 aXA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ellero <l.ellero@asem.it>

To discard false readings, one should use "ti,penirq-recheck-delay-usecs".
Checking get_pendown_state() at the beginning, most of the time fails
causing malfunctioning.

Signed-off-by: Luca Ellero <l.ellero@asem.it>
---
 drivers/input/touchscreen/ads7846.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 9e15cdf6faa0..122d3a13b7c5 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -843,14 +843,8 @@ static void ads7846_report_state(struct ads7846 *ts)
 	if (x == MAX_12BIT)
 		x = 0;
 
-	if (ts->model == 7843) {
+	if (ts->model == 7843 || ts->model == 7845) {
 		Rt = ts->pressure_max / 2;
-	} else if (ts->model == 7845) {
-		if (get_pendown_state(ts))
-			Rt = ts->pressure_max / 2;
-		else
-			Rt = 0;
-		dev_vdbg(&ts->spi->dev, "x/y: %d/%d, PD %d\n", x, y, Rt);
 	} else if (likely(x && z1)) {
 		/* compute touch pressure resistance using equation #2 */
 		Rt = z2;
-- 
2.25.1

