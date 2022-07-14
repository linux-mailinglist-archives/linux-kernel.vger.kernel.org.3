Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF53575706
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiGNVak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240624AbiGNVaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:30:11 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA8B6EE90;
        Thu, 14 Jul 2022 14:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657834210; x=1689370210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yzAyPrU/qCIlo6Cf2CdARPBaTkg8+aYwmjRonAsM36o=;
  b=pu/oaRpVlv5L2FR9aP3FS/FU0tNsgd36qkiuXFTc8bbof2P9I67mQ2lJ
   xYe2oT1ZuFYtRx6IBLLNauFyyBbLFxM3CC7/xNJmjTTihUQ7gyG9OtTxZ
   QwtQu6iQfZzGf6rditJugi2aergawVEyg17wvcVqY3GgrP5EMDW1ZvoQF
   I=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Jul 2022 14:30:09 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 14:30:09 -0700
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Jul 2022 14:30:08 -0700
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Murali Nalajala <quic_mnalajala@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagiri@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Marc Zyngier" <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v2 09/11] gunyah: rsc_mgr: Add auxiliary devices for console
Date:   Thu, 14 Jul 2022 14:29:38 -0700
Message-ID: <20220714212940.2988436-10-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220714212940.2988436-1-quic_eberman@quicinc.com>
References: <20220223233729.1571114-1-quic_eberman@quicinc.com>
 <20220714212940.2988436-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gunyah resource manager exposes a concrete functionalities which
complicate a single resource manager driver. Use auxiliary bus
to help split high level functions for the resource manager and keep the
primary resource manager driver focused on the RPC with RM itself.
Delegate Resource Manager's console functionality to the auxiliary bus.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/rsc_mgr.c | 61 ++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
index b8268ee02fab..44b22cef7d44 100644
--- a/drivers/virt/gunyah/rsc_mgr.c
+++ b/drivers/virt/gunyah/rsc_mgr.c
@@ -91,6 +91,11 @@ struct gh_rm_notif_complete {
 	struct work_struct work;
 };
 
+struct gh_rsc_mgr_adev {
+	struct auxiliary_device adev;
+	struct list_head list;
+};
+
 struct gh_rsc_mgr {
 	struct task_struct *recv_task;
 	struct gunyah_device *msgq_tx, *msgq_rx;
@@ -99,6 +104,13 @@ struct gh_rsc_mgr {
 	struct mutex call_idr_lock;
 
 	struct mutex send_lock;
+
+	struct list_head adevs;
+};
+
+/* List of auxiliary devices which resource manager creates */
+static const char * const adev_names[] = {
+	"console",
 };
 
 static struct gh_rsc_mgr *__rsc_mgr;
@@ -516,6 +528,14 @@ int gh_rm_unregister_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(gh_rm_unregister_notifier);
 
+static void gh_rm_adev_release(struct device *dev)
+{
+	struct gh_rsc_mgr_adev *rm_adev = container_of(dev, struct gh_rsc_mgr_adev, adev.dev);
+
+	list_del(&rm_adev->list);
+	kfree(rm_adev);
+}
+
 static struct gunyah_device *gh_msgq_platform_probe_direction(struct platform_device *pdev,
 				u8 gh_type, int idx)
 {
@@ -550,7 +570,9 @@ static struct gunyah_device *gh_msgq_platform_probe_direction(struct platform_de
 static int gh_rm_drv_probe(struct platform_device *pdev)
 {
 	struct gh_rsc_mgr *rsc_mgr;
-	int ret;
+	struct gh_rsc_mgr_adev *rm_adev;
+	struct list_head *l, *n;
+	int ret, i;
 
 	rsc_mgr = devm_kzalloc(&pdev->dev, sizeof(*rsc_mgr), GFP_KERNEL);
 	if (!rsc_mgr)
@@ -560,6 +582,7 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
 	mutex_init(&rsc_mgr->call_idr_lock);
 	idr_init(&rsc_mgr->call_idr);
 	mutex_init(&rsc_mgr->send_lock);
+	INIT_LIST_HEAD(&rsc_mgr->adevs);
 
 	rsc_mgr->msgq_tx = gh_msgq_platform_probe_direction(pdev, GUNYAH_DEVICE_TYPE_MSGQ_TX, 0);
 	if (IS_ERR(rsc_mgr->msgq_tx))
@@ -576,10 +599,38 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
 		goto err_msgq;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(adev_names); i++) {
+		rm_adev = kzalloc(sizeof(*rm_adev), GFP_KERNEL);
+
+		rm_adev->adev.dev.parent = &pdev->dev;
+		rm_adev->adev.dev.release = gh_rm_adev_release;
+		rm_adev->adev.name = adev_names[i];
+		ret = auxiliary_device_init(&rm_adev->adev);
+		if (ret) {
+			kfree(rm_adev);
+			goto err_adevs;
+		}
+
+		list_add(&rm_adev->list, &rsc_mgr->adevs);
+
+		ret = auxiliary_device_add(&rm_adev->adev);
+		if (ret) {
+			auxiliary_device_uninit(&rm_adev->adev);
+			goto err_adevs;
+		}
+	}
+
 	__rsc_mgr = rsc_mgr;
 
 	return 0;
 
+err_adevs:
+	list_for_each_safe(l, n, &rsc_mgr->adevs) {
+		rm_adev = container_of(l, struct gh_rsc_mgr_adev, list);
+		auxiliary_device_delete(&rm_adev->adev);
+		auxiliary_device_uninit(&rm_adev->adev);
+	}
+
 err_msgq:
 	gunyah_device_remove(rsc_mgr->msgq_rx);
 err_msgq_tx:
@@ -590,6 +641,14 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
 static int gh_rm_drv_remove(struct platform_device *pdev)
 {
 	struct gh_rsc_mgr *rsc_mgr = platform_get_drvdata(pdev);
+	struct gh_rsc_mgr_adev *rm_adev;
+	struct list_head *l, *n;
+
+	list_for_each_safe(l, n, &rsc_mgr->adevs) {
+		rm_adev = container_of(l, struct gh_rsc_mgr_adev, list);
+		auxiliary_device_delete(&rm_adev->adev);
+		auxiliary_device_uninit(&rm_adev->adev);
+	}
 
 	gunyah_device_remove(rsc_mgr->msgq_tx);
 	gunyah_device_remove(rsc_mgr->msgq_rx);
-- 
2.25.1

