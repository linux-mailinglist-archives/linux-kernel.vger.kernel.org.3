Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2874E6070
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348954AbiCXIhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242408AbiCXIhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:37:37 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD11E9BBA1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=N9N4rpZMnZh4Wu4qa2
        A3A82svr8AanjCcqyvb5y6Oww=; b=GXumAnIfEdDziwGZ7sPFxfS7BYeViCbCg6
        JgcWscvNIKTbi/VLo1Z8LLvb09jpDZdypIJWuHoLoTs/FA4TK+VCMqI/mjgWf1Jo
        +ptkI0seXRUoxjKF018OgMOBNah3uielarRP559ndpJfqDWp77PwkikcRZQdKO8/
        mBT52GepE=
Received: from localhost (unknown [159.226.95.33])
        by smtp8 (Coremail) with SMTP id DMCowADnVYRdLTxiHW_9Bg--.28421S2;
        Thu, 24 Mar 2022 16:35:41 +0800 (CST)
From:   QintaoShen <unSimple1993@163.com>
To:     f.fainelli@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, QintaoShen <unSimple1993@163.com>
Subject: [PATCH v1] soc: bcm: Check for NULL return of devm_kzalloc()
Date:   Thu, 24 Mar 2022 16:35:40 +0800
Message-Id: <1648110940-4684-1-git-send-email-unSimple1993@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DMCowADnVYRdLTxiHW_9Bg--.28421S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF15ZF4ftF43Gw4xZF4DXFb_yoWfGFX_CF
        WkXrZrW39Ygry7tF1ayw4xZ34jgFs8Zr97Za1YqayakryDArZ5Xa48ZrsxJFZrWw4xCFZr
        ZF1qqF4Svr17GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUdWrPUUUUU==
X-Originating-IP: [159.226.95.33]
X-CM-SenderInfo: 5xqvxz5sohimizt6il2tof0z/1tbiXxjNH1153xZR7wABsH
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the potential failuer of allocation, devm_kzalloc() may return NULL.
Then the 'pd->pmb' and the follow lines of code may bring null pointer dereference.

Therefore, it is better to check the return value of devm_kzalloc() to avoid this confusion.

Signed-off-by: QintaoShen <unSimple1993@163.com>
---
 drivers/soc/bcm/bcm63xx/bcm-pmb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/bcm/bcm63xx/bcm-pmb.c b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
index 7bbe46e..55bf389 100644
--- a/drivers/soc/bcm/bcm63xx/bcm-pmb.c
+++ b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
@@ -311,6 +311,8 @@ static int bcm_pmb_probe(struct platform_device *pdev)
 
 	for (e = table; e->name; e++) {
 		struct bcm_pmb_pm_domain *pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
+		if (!pd)
+			return -ENOMEM;
 
 		pd->pmb = pmb;
 		pd->data = e;
-- 
2.7.4

