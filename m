Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6378590DA0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 10:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbiHLIos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 04:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237549AbiHLIoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 04:44:39 -0400
Received: from smtpcmd01-sp1.aruba.it (smtpcmd01-sp1.aruba.it [62.149.158.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63FD2A8CE2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 01:44:37 -0700 (PDT)
Received: from asem-TANK-H61.asem.intra ([151.1.184.193])
        by Aruba Outgoing Smtp  with ESMTPSA
        id MQG1oHcRkr8wyMQGWoLazj; Fri, 12 Aug 2022 10:43:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1660293817; bh=loRkK3v18v6DijDl9IFXyx+yOfz6h4JPvTbCHffpCLU=;
        h=From:To:Subject:Date:MIME-Version;
        b=WobmAw1fnOg+SbDE2bUSQsNKxPNI0zaosINEtS+grYIYQ+KllVsaLLEgImngMMoQB
         xv9uytHWq9C4ZYoiJ77tcs63++sFODYhPDeuo4BCIMUEfDvk6krPhxxLnuH40PYjh0
         JcHdEQyVfHHxqvJgQlnnKQot7nruzQ0bYd4K+0K1UO/wN3qlQMBX1Bqwg3C6qe1xjL
         yTJY3034HU2Fd5yC1HPul9UBfaaK/TZqgIFSEcDBrCJauamSBNluFakZ5ixTme6eXw
         hZ9UN7ZKQ16cu1FYmHkjpFqPqEfgrNSJW03WFbgg+A33OEIo5X5y7W/Y2siJcnpBWm
         Bq9Tt1xeb0JiQ==
From:   Luca Ellero <l.ellero@asem.it>
To:     dmitry.torokhov@gmail.com, daniel@zonque.org,
        m.felsch@pengutronix.de, andriy.shevchenko@linux.intel.com,
        u.kleine-koenig@pengutronix.de, mkl@pengutronix.de,
        miquel.raynal@bootlin.com, imre.deak@nokia.com,
        luca.ellero@brickedbrain.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Ellero <l.ellero@asem.it>
Subject: [PATCH v3 3/3] ads7846: don't check penirq immediately for 7845
Date:   Fri, 12 Aug 2022 10:42:48 +0200
Message-Id: <20220812084248.9270-4-l.ellero@asem.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812084248.9270-1-l.ellero@asem.it>
References: <20220812084248.9270-1-l.ellero@asem.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfC7WR5gbThm59nUe8T/2yuvMo1KDOesTazhyZc+l4NYiOYv4WvQMXO2I05kZkcmK4PxZ0DErVpqXlaTvPfz4koRr4GLpFNsWLfCarFv1W/06+4axpHn+
 q690VV1ZacV1nITpZMtm8R+0AMA67/F7JChWrdEJx5BSThcDzMDqSGVMefJamy3tn8D85eryqgOBf6GEsRu+HDl2y2qcVNti8fuzVR1opJijTE2mesaNgmAP
 TU74i69wYe0TtFn7zrV4SLTRJi2SWhiXuU7dfL4/UTEbI4dcBpKB3X/8Nst+6jCM03d9axP9g1elObodC3TF10mT4P+GOR/Fmcik8tbNHg/hoIRNohBQ6Oen
 +4mUb7sjBGtLxXOiHj1UNN+ndNjNt/rjG3+FNCJWsL5rVObNjxpc7cJTt6fAHUjpshxVxSvIlJMJ2OdBSXzW5RhepewVoWb6ND4YDKEUwqpjUoWuTsEk4qeG
 yKznpqgkhBCpW7Nlzb2G1CsuNJ1C6P07jFpgtHwxrCXQu9RCErl5GY8WIGn7CX67gdpv9u6wFtjBqZsYV0+b/nbXVWa0aoMDCvEpo8r2pI/DwrlM5+0owZ+J
 FJjQFbB0zso1SwCjkuOXgrtg
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

