Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA364E1E2A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 23:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbiCTWte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 18:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiCTWtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 18:49:32 -0400
Received: from tmailer.gwdg.de (tmailer.gwdg.de [134.76.10.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFA03E5D4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 15:48:07 -0700 (PDT)
Received: from excmbx-17.um.gwdg.de ([134.76.9.228] helo=email.gwdg.de)
        by mailer.gwdg.de with esmtp (GWDG Mailer)
        (envelope-from <alexander.vorwerk@stud.uni-goettingen.de>)
        id 1nW4LE-000O5C-M0; Sun, 20 Mar 2022 23:48:04 +0100
Received: from notebook.fritz.box (10.250.9.199) by excmbx-17.um.gwdg.de
 (134.76.9.228) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521) id 15.1.2375.24; Sun, 20
 Mar 2022 23:48:04 +0100
From:   Alexander Vorwerk <alexander.vorwerk@stud.uni-goettingen.de>
To:     <zbr@ioremap.net>
CC:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        Alexander Vorwerk <alexander.vorwerk@stud.uni-goettingen.de>
Subject: [PATCH] drivers: w1: remove unused inten variable
Date:   Sun, 20 Mar 2022 23:47:48 +0100
Message-ID: <20220320224748.25752-1-alexander.vorwerk@stud.uni-goettingen.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.250.9.199]
X-ClientProxiedBy: EXCMBX-12.um.gwdg.de (134.76.9.221) To excmbx-17.um.gwdg.de
 (134.76.9.228)
X-Virus-Scanned: (clean) by clamav
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following compilation warning shows up when compiling
with W=1.

drivers/w1/masters/ds1wm.c: In function ‘ds1wm_probe’:
drivers/w1/masters/ds1wm.c:512:5: warning: variable ‘inten’ set but not used [-Wunused-but-set-variable]
  u8 inten;
     ^~~~~

Fixed by removing the variable.

Signed-off-by: Alexander Vorwerk <alexander.vorwerk@stud.uni-goettingen.de>
---
 drivers/w1/masters/ds1wm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/w1/masters/ds1wm.c b/drivers/w1/masters/ds1wm.c
index f661695fb589..f59d92865ecb 100644
--- a/drivers/w1/masters/ds1wm.c
+++ b/drivers/w1/masters/ds1wm.c
@@ -509,7 +509,6 @@ static int ds1wm_probe(struct platform_device *pdev)
 	struct ds1wm_driver_data *plat;
 	struct resource *res;
 	int ret;
-	u8 inten;
 
 	if (!pdev)
 		return -ENODEV;
@@ -564,7 +563,7 @@ static int ds1wm_probe(struct platform_device *pdev)
 	ds1wm_data->reset_recover_delay = plat->reset_recover_delay;
 
 	/* Mask interrupts, set IAS before claiming interrupt */
-	inten = ds1wm_read_register(ds1wm_data, DS1WM_INT_EN);
+	ds1wm_read_register(ds1wm_data, DS1WM_INT_EN);
 	ds1wm_write_register(ds1wm_data,
 		DS1WM_INT_EN, ds1wm_data->int_en_reg_none);
 
-- 
2.17.1

