Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8634C1FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244964AbiBWXiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244889AbiBWXi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:38:28 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D501C5A5A5;
        Wed, 23 Feb 2022 15:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645659478; x=1677195478;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2VUkdZNWBUow2l5oaAUbfqT7RLs4Yas3+07dDbQamTk=;
  b=BWguezkOMEDur/3XOhGnVawv8Pgs3XzyzvEmGk2VyEWNOVQQuOXF5+Z9
   6qFI9EXfRnnYaihkPTRr3SbBxn2IY7Mc998Ic/TR/+HtWGH0g8IxYcGAy
   MiLEnZyexJhstT/NrOrMcM9zHquxS3X85II53eeFFHgPHeiIY3nmCMmPi
   0=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Feb 2022 15:37:58 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 15:37:58 -0800
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 23 Feb 2022 15:37:58 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Murali Nalajala <quic_mnalajala@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagiri@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH 09/11] gunyah: rsc_mgr: Add auxiliary devices for console
Date:   Wed, 23 Feb 2022 15:37:27 -0800
Message-ID: <20220223233729.1571114-10-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223233729.1571114-1-quic_eberman@quicinc.com>
References: <20220223233729.1571114-1-quic_eberman@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
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
 drivers/virt/gunyah/rsc_mgr.c | 58 +++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
index c8c4e1617566..9ca63053dd38 100644
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
 	struct gh_msgq_platform_host msgq;
@@ -99,6 +104,13 @@ struct gh_rsc_mgr {
 	struct mutex call_idr_lock;
 
 	struct mutex send_lock;
+
+	struct list_head adevs;
+};
+
+/* List of auxiliary devices which resource manager creates */
+static const char *adev_names[] = {
+	"console",
 };
 
 static struct gh_rsc_mgr *__rsc_mgr;
@@ -499,10 +511,19 @@ int gh_rm_unregister_notifier(struct notifier_block *nb)
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
 static int gh_rm_drv_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct gh_rsc_mgr *rsc_mgr;
+	struct gh_rsc_mgr_adev *rm_adev;
 	struct list_head *l, *n;
 	int ret, i;
 
@@ -514,6 +535,7 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
 	mutex_init(&rsc_mgr->call_idr_lock);
 	idr_init(&rsc_mgr->call_idr);
 	mutex_init(&rsc_mgr->send_lock);
+	INIT_LIST_HEAD(&rsc_mgr->adevs);
 
 	ret = gh_msgq_platform_host_attach(pdev, &rsc_mgr->msgq);
 	if (ret)
@@ -530,10 +552,38 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
 		goto err_msgq;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(adev_names); i++) {
+		rm_adev = kzalloc(sizeof(*rm_adev), GFP_KERNEL);
+
+		rm_adev->adev.dev.parent = dev;
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
 	gh_msgq_platform_host_unattach(&rsc_mgr->msgq);
 	return ret;
@@ -542,6 +592,14 @@ static int gh_rm_drv_probe(struct platform_device *pdev)
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
 
 	gh_msgq_platform_host_unattach(&rsc_mgr->msgq);
 
-- 
2.25.1

