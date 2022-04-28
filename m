Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615D1512F15
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344721AbiD1I4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344512AbiD1I4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:56:12 -0400
Received: from out203-205-251-53.mail.qq.com (out203-205-251-53.mail.qq.com [203.205.251.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF482F3BC;
        Thu, 28 Apr 2022 01:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1651135973;
        bh=1YZv1zOYWKRjF1huRVXlo6mKgvTSjTUBeoIV4b4PtvQ=;
        h=From:To:Cc:Subject:Date;
        b=URXeEyQ169qjK2AVCYY0d/XzLz74WxA4OADySh5wJfWFL1b7tsqRJErCRLMGRWa3i
         urZmdiwpEhOhm/SHyR2IqwA6zQXjFBat9JVh2BUT100b1ySEbThnPX8iygzwzkqZkN
         1d9XcPbjR5etSyLzQwk2DSlUoHqXS9/I+4Ntrqkg=
Received: from localhost.localdomain ([59.172.176.242])
        by newxmesmtplogicsvrszb6.qq.com (NewEsmtp) with SMTP
        id D3137827; Thu, 28 Apr 2022 16:52:49 +0800
X-QQ-mid: xmsmtpt1651135969t5qiwrf7v
Message-ID: <tencent_EDB94B1C7E14B4E1974A66FF4D2029CC6D08@qq.com>
X-QQ-XMAILINFO: MQ+wLuVvI2LQULY0Prs9k+SYrCIJ25n+J1FFbPzFDaLOs58lBVFosbs9muNjZO
         UkC5FRYale8I0tJQhZMnD/nNF1Vz++RhAUQPQYY1kxbAC/i3UeS57nhtQHjiGPTEXUIC9sgQ/vj0
         6pFCBZeTgpBCCwyN7nfohxjPOPs2KV5S66KuGJph61XB3D47DQudC+wkfULr7i7INNE1IbcAKsF7
         z5mQdiC1fpWt4ABJnM+UP82qL80FsyftAmZ4GzSIodBKxV0foXSoPbQM8pbdEXNXOj4y/nEUyNAk
         gMXE8OR5f1XLUHxCwUC9fBFx9L94N1ar7g8mycekJj5CMpYwWzHTuWcEFfHw17iXC6+hDfWz/dzn
         dVx/DsqNegIxEh8UznNw1NhxOVfm/tSYfGwpLNvFg24xszvB3N1Q7xVOtw/lsjitmm2Zn14N14x9
         T0ovUmfrXcIKQwKIwjyRpU5lGFJeMu0frDtVaojrqzm1skPkmY14BSyoHwxqwbxT6GpBZZMu9rrc
         1kSs5rUXHTxQvP2yS1cJFFrXpcMDc4Qay6bI3xKaKeVctigZKhyAwM60O5vK5rZiQYDE4yjf0KTo
         dzfYRbMZe1T9N14lsta04Vxpl9f0TrT/Uok5hjGXJ4xhL/AYMJnUkiFyfWREVPx61+pAgwXCznmu
         ySklUpDQultSP6YmOh+BOek5XzN8wG4JDpZCBf0iiP3QkEjOuJ/V8YumjfNpkkPczzZIBDDK+lZz
         TBlxIecqwwT+V0thIWg8ec/eWoFmS4qJAIoBfcOvDKIdLbrYkghw3Mgw+qWt3m2hp7tRcfnq73x4
         A1MjnJcoE2I92Gvp644tKRuTuSPpWZmLqSU3EsV9mbuuV86BnQoTjTi3s6Hh07u0XuqjUXV59qen
         oL8kyD/o20G2Wfyn3GwLAjoH3TG7ROERDv+4RVGjWclqoPXrqlia0oNmgr5+yysKzNm0REgkYUxP
         y0L3KWasBRa46yrBaytg==
From:   xkernel.wang@foxmail.com
To:     agross@kernel.org, bjorn.andersson@linaro.org, joro@8bytes.org,
        will@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH v2] iommu/msm: add a check for the return of kzalloc()
Date:   Thu, 28 Apr 2022 16:52:39 +0800
X-OQ-MSGID: <20220428085239.1287-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kzalloc() is a memory allocation function which can return NULL when
some internal memory errors happen. So it is better to check it to
prevent potential wrong memory access.

Besides, to propagate the error to the caller, the type of
insert_iommu_master() is changed to `int`. Several instructions related
to it are also updated.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
ChangeLog:
v1->v2 propagate the error to the caller.
 drivers/iommu/msm_iommu.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 3a38352..e3d109b 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -588,7 +588,7 @@ static void print_ctx_regs(void __iomem *base, int ctx)
 	       GET_SCTLR(base, ctx), GET_ACTLR(base, ctx));
 }
 
-static void insert_iommu_master(struct device *dev,
+static int insert_iommu_master(struct device *dev,
 				struct msm_iommu_dev **iommu,
 				struct of_phandle_args *spec)
 {
@@ -597,6 +597,10 @@ static void insert_iommu_master(struct device *dev,
 
 	if (list_empty(&(*iommu)->ctx_list)) {
 		master = kzalloc(sizeof(*master), GFP_ATOMIC);
+		if (!master) {
+			dev_err(dev, "Failed to allocate iommu_master\n");
+			return -ENOMEM;
+		}
 		master->of_node = dev->of_node;
 		list_add(&master->list, &(*iommu)->ctx_list);
 		dev_iommu_priv_set(dev, master);
@@ -606,10 +610,11 @@ static void insert_iommu_master(struct device *dev,
 		if (master->mids[sid] == spec->args[0]) {
 			dev_warn(dev, "Stream ID 0x%hx repeated; ignoring\n",
 				 sid);
-			return;
+			return 0;
 		}
 
 	master->mids[master->num_mids++] = spec->args[0];
+	return 0;
 }
 
 static int qcom_iommu_of_xlate(struct device *dev,
@@ -629,7 +634,7 @@ static int qcom_iommu_of_xlate(struct device *dev,
 		goto fail;
 	}
 
-	insert_iommu_master(dev, &iommu, spec);
+	ret = insert_iommu_master(dev, &iommu, spec);
 fail:
 	spin_unlock_irqrestore(&msm_iommu_lock, flags);
 
-- 
