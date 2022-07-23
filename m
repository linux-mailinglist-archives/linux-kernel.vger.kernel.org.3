Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1759F57EBAB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 05:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiGWDYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 23:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGWDYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 23:24:40 -0400
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3C9670981;
        Fri, 22 Jul 2022 20:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=JiQL3
        v43ih0CKjiymG4BT5ELIGSeW1i9a3/8dRvOgxk=; b=O/nfmU5AT6QRqxMh3N2/1
        jOKCzS/GFksAtNA9TjaBkL9qcWqBfU8K6MSMNQlfUPOvgA7OCosqruRwXJRjBsLi
        JLK4Xk7VijpoZAOf5tPEA3zXzi2oXUoJ0kIkfIljwtqFbv88tmKzCDLuwxE923Mx
        ZFM2UUA4xqZQfT5f+FFEIQ=
Received: from localhost.localdomain (unknown [123.58.221.99])
        by smtp5 (Coremail) with SMTP id HdxpCgBX2jeyadtiKGBKPw--.22880S2;
        Sat, 23 Jul 2022 11:23:32 +0800 (CST)
From:   williamsukatube@163.com
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     konrad.dybcio@somainline.org,
        William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: [PATCH] slimbus: qcom-ngd-ctrl: Add check for platform_driver_register
Date:   Sat, 23 Jul 2022 11:23:28 +0800
Message-Id: <20220723032328.2951275-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgBX2jeyadtiKGBKPw--.22880S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jr4DCF47Gry3ZFyDur15urg_yoWkGFgEk3
        48uF9Fqrs5CFnrAFnFqFnrZ34IvFn5ursa9r10qFy3t3y8XF4DWrn0vFs8CFWUCrWrt34U
        J3Z0krZ7CrW3GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU51wZ7UUUUU==
X-Originating-IP: [123.58.221.99]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/1tbiURRHg2DEOrvjQwAAsE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Dean <williamsukatube@gmail.com>

As platform_driver_register() could fail, it should be better
to deal with the return value in order to maintain the code
consisitency.

Fixes: 1830dad34c070 ("slimbus: ngd: register ngd driver only once.")
Reported-by: Hacash Robot <hacashRobot@santino.com>
Signed-off-by: William Dean <williamsukatube@gmail.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 0aa8408464ad..a31ec00a37ac 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1585,7 +1585,12 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 		return PTR_ERR(pds);
 	}
 
-	platform_driver_register(&qcom_slim_ngd_driver);
+	ret = platform_driver_register(&qcom_slim_ngd_driver);
+	if (ret) {
+		dev_err(dev, "platform driver register failed: %d\n", ret);
+		return ret;
+	}
+
 	return of_qcom_slim_ngd_register(dev, ctrl);
 }
 
-- 
2.25.1

