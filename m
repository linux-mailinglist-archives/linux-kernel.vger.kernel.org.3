Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A98D4E5FD0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347679AbiCXIBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240437AbiCXIBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:01:20 -0400
X-Greylist: delayed 920 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Mar 2022 00:59:48 PDT
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D69222B13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 00:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=k0bAzjh+AUgR2IJ351
        C39W3KAJR0vQBnMG0macu+KLY=; b=JYWaoNl5be+C9Eh5neBJnZ6Sf+r6Ra8JsO
        av/zNx06JF18RRL7ek9J3rBWVyWjcD+DKbEVMpwj73SRJW2KlddA7XdtLtaj33Ki
        gG0RUaW+rGhQjncmDkmAKqoOmaxZB5OpoSrTgUmaZDcYG5yOnwqRFvQsDaG3+gmy
        ib/gDJbe8=
Received: from localhost (unknown [159.226.95.33])
        by smtp14 (Coremail) with SMTP id EsCowADXTotHITxi+cJzBg--.47842S2;
        Thu, 24 Mar 2022 15:44:08 +0800 (CST)
From:   QintaoShen <unSimple1993@163.com>
To:     kristo@kernel.org
Cc:     ssantosh@kernel.org, nm@ti.com, linux-kernel@vger.kernel.org,
        QintaoShen <unSimple1993@163.com>
Subject: [PATCH v1] soc: ti: ti_sci_pm_domains: Check for null return of devm_kcalloc
Date:   Thu, 24 Mar 2022 15:44:03 +0800
Message-Id: <1648107843-29077-1-git-send-email-unSimple1993@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: EsCowADXTotHITxi+cJzBg--.47842S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw18WF1rWw4kCr17Cry7trb_yoWftrc_Cw
        4UXrW3Gr45Cr93Kw1qkw43ZryY93Z8ZrnY9w1rt3sxXryUWw1rGF4UZFn3CanxW3yDGFnr
        Jan0vr13ArnxWjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRACzZJUUUUU==
X-Originating-IP: [159.226.95.33]
X-CM-SenderInfo: 5xqvxz5sohimizt6il2tof0z/1tbiNAjNH1aD-Km6YQAAs1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allocation funciton devm_kcalloc may fail and return a null pointer,
which would cause a null-pointer dereference later.
It might be better to check it and directly return -ENOMEM just like the
usage of devm_kcalloc in previous code.

Signed-off-by: QintaoShen <unSimple1993@163.com>
---
 drivers/soc/ti/ti_sci_pm_domains.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/ti/ti_sci_pm_domains.c b/drivers/soc/ti/ti_sci_pm_domains.c
index 8afb3f45..a33ec7e 100644
--- a/drivers/soc/ti/ti_sci_pm_domains.c
+++ b/drivers/soc/ti/ti_sci_pm_domains.c
@@ -183,6 +183,8 @@ static int ti_sci_pm_domain_probe(struct platform_device *pdev)
 		devm_kcalloc(dev, max_id + 1,
 			     sizeof(*pd_provider->data.domains),
 			     GFP_KERNEL);
+	if (!pd_provider->data.domains)
+		return -ENOMEM;
 
 	pd_provider->data.num_domains = max_id + 1;
 	pd_provider->data.xlate = ti_sci_pd_xlate;
-- 
2.7.4

