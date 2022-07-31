Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD66585E99
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 13:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbiGaLTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 07:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiGaLTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 07:19:30 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD5ECE00
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 04:19:29 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id I6ykoVjnl0UP7I6ykoOcxz; Sun, 31 Jul 2022 13:19:27 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 31 Jul 2022 13:19:27 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Shobhit Kumar <shobhit.kumar@intel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] mfd: intel_soc_pmic: Fix an error handling path in intel_soc_pmic_i2c_probe()
Date:   Sun, 31 Jul 2022 13:19:24 +0200
Message-Id: <7c3918d7cce9643414697cef02ef636f05efb003.1659266359.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit in Fixes: has added a pwm_add_table() call in the probe() and
a pwm_remove_table() call in the remove(), but forget to update the error
handling path of the probe.

Add the missing pwm_remove_table() call.

Fixes: a3aa9a93df9f ("mfd: intel_soc_pmic_core: ADD PWM lookup table for CRC PMIC based PWM")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The order of pwm_remove_table() and regmap_del_irq_chip() is not the same
as the one in the remove function.
The one in this patch looks more logical to me because things are done in
the reverse order of allocations...

... but in regmap_del_irq_chip() there is irq, and in such a case releasing
resource is sometime tricky.

Review with care.
---
 drivers/mfd/intel_soc_pmic_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/intel_soc_pmic_core.c b/drivers/mfd/intel_soc_pmic_core.c
index 5e8c94e008ed..85d070bce0e2 100644
--- a/drivers/mfd/intel_soc_pmic_core.c
+++ b/drivers/mfd/intel_soc_pmic_core.c
@@ -77,6 +77,7 @@ static int intel_soc_pmic_i2c_probe(struct i2c_client *i2c,
 	return 0;
 
 err_del_irq_chip:
+	pwm_remove_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
 	regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
 	return ret;
 }
-- 
2.34.1

