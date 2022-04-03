Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AD14F08A1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 12:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346223AbiDCKBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 06:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbiDCKBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 06:01:14 -0400
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr [80.12.242.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E612AAE44
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 02:59:19 -0700 (PDT)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id ax0vnFTWQRGzQax0vnw6b6; Sun, 03 Apr 2022 11:59:18 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 03 Apr 2022 11:59:18 +0200
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH] usb: misc: eud: Fix an error handling path in eud_probe()
Date:   Sun,  3 Apr 2022 11:59:15 +0200
Message-Id: <362908699275ecec078381b42d87c817c6965fc6.1648979948.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is odd to call devm_add_action_or_reset() before calling the function
that should be undone.

Either, the "_or_reset" part should be omitted, or the action should be
recorded after the resources have been allocated.

Switch the order of devm_add_action_or_reset() and usb_role_switch_get().

Fixes: 9a1bf58ccd44 ("usb: misc: eud: Add driver support for Embedded USB Debugger(EUD)")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/usb/misc/qcom_eud.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
index f929bffdc5d1..b7f13df00764 100644
--- a/drivers/usb/misc/qcom_eud.c
+++ b/drivers/usb/misc/qcom_eud.c
@@ -186,16 +186,16 @@ static int eud_probe(struct platform_device *pdev)
 
 	chip->dev = &pdev->dev;
 
-	ret = devm_add_action_or_reset(chip->dev, eud_role_switch_release, chip);
-	if (ret)
-		return dev_err_probe(chip->dev, ret,
-				"failed to add role switch release action\n");
-
 	chip->role_sw = usb_role_switch_get(&pdev->dev);
 	if (IS_ERR(chip->role_sw))
 		return dev_err_probe(chip->dev, PTR_ERR(chip->role_sw),
 					"failed to get role switch\n");
 
+	ret = devm_add_action_or_reset(chip->dev, eud_role_switch_release, chip);
+	if (ret)
+		return dev_err_probe(chip->dev, ret,
+				"failed to add role switch release action\n");
+
 	chip->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(chip->base))
 		return PTR_ERR(chip->base);
-- 
2.32.0

