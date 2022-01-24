Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F69497D27
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbiAXK2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:28:03 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46346 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231280AbiAXK2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:28:01 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20O8b40M017029;
        Mon, 24 Jan 2022 11:27:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=pOQvb7TljMbN/QHUp0xRGqe5Q0334fIGbULFTY7jihU=;
 b=t6Y5C3qCLP5MUA9ODFOnt/ivtABwGyhN6K3+HqEkMkJqvgL08fpCO1ka/OUeCiy/ckOT
 XVVOa9f70NqXqvGUe/Zet/6TVpeKBp4oavx4PcDjpFWucGiuvrJVMSknwsQOlvYMj5XW
 58G48Eqv5ImWrd8QTsDkChao4tP6UtXpa5nZ05mryGaKMzoJviqQvpYEP/QAK5XF2+O7
 KIPEReoFOGzJIdvxb7hHkRALFj/WAwM5lkHMkfaiTAIs1srPpjI2G7H/zSXfsKNyEwCs
 MENLaV9eDjZwC5QGUTYN5mz1NnMcvBYlp3s06QJryt0N4bgIkwEEdF+M7ayWmwwNf8zl Kw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dsrru0mmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jan 2022 11:27:59 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9BCD410002A;
        Mon, 24 Jan 2022 11:27:58 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9365A2128C2;
        Mon, 24 Jan 2022 11:27:58 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 24 Jan 2022 11:27:58
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <julien.massot@iot.bzh>, <arnaud.pouliquen@foss.st.com>
Subject: [PATCH v9 10/11] rpmsg: char: Introduce the "rpmsg-raw" channel
Date:   Mon, 24 Jan 2022 11:25:23 +0100
Message-ID: <20220124102524.295783-11-arnaud.pouliquen@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124102524.295783-1-arnaud.pouliquen@foss.st.com>
References: <20220124102524.295783-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_06,2022-01-24_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the rpmsg virtio backend, the current implementation of the rpmsg char
only allows to instantiate static(i.e. prefixed source and destination
addresses) end points, and only on the Linux user space initiative.

This patch defines the "rpmsg-raw" channel and registers it to the rpmsg bus.
This registration allows:
- To create the channel at the initiative of the remote processor
  relying on the name service announcement mechanism. In other words the
  /dev/rpmsgX interface is instantiate by the remote processor.
- To use the channel object instead of the endpoint, thus preventing the
  user space from having the knowledge of the remote processor's
  endpoint addresses.
- To rely on udev to be inform when a /dev/rpmsgX is created on remote
  processor request, indicating that the remote processor is ready to
  communicate.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
---
Update vs previous revision:
- rework commit message,
- remove the use of the rpmsg_create_default_ept function.
---
 drivers/rpmsg/rpmsg_char.c | 60 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 97843838d960..6c1d9774b7b1 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -428,6 +428,54 @@ int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent
 }
 EXPORT_SYMBOL(rpmsg_chrdev_eptdev_create);
 
+static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
+{
+	struct rpmsg_channel_info chinfo;
+	struct rpmsg_eptdev *eptdev;
+	struct device *dev = &rpdev->dev;
+
+	memcpy(chinfo.name, rpdev->id.name, RPMSG_NAME_SIZE);
+	chinfo.src = rpdev->src;
+	chinfo.dst = rpdev->dst;
+
+	eptdev = rpmsg_chrdev_eptdev_alloc(rpdev, dev);
+	if (IS_ERR(eptdev))
+		return PTR_ERR(eptdev);
+
+	/* Set the default_ept to the rpmsg device endpoint */
+	eptdev->default_ept = rpdev->ept;
+
+	/*
+	 * The rpmsg_ept_cb uses *priv parameter to get its rpmsg_eptdev context.
+	 * Storedit in default_ept *priv field.
+	 */
+	eptdev->default_ept->priv = eptdev;
+
+	return rpmsg_chrdev_eptdev_add(eptdev, chinfo);
+}
+
+static void rpmsg_chrdev_remove(struct rpmsg_device *rpdev)
+{
+	int ret;
+
+	ret = device_for_each_child(&rpdev->dev, NULL, rpmsg_chrdev_eptdev_destroy);
+	if (ret)
+		dev_warn(&rpdev->dev, "failed to destroy endpoints: %d\n", ret);
+}
+
+static struct rpmsg_device_id rpmsg_chrdev_id_table[] = {
+	{ .name	= "rpmsg-raw" },
+	{ },
+};
+
+static struct rpmsg_driver rpmsg_chrdev_driver = {
+	.probe = rpmsg_chrdev_probe,
+	.remove = rpmsg_chrdev_remove,
+	.callback = rpmsg_ept_cb,
+	.id_table = rpmsg_chrdev_id_table,
+	.drv.name = "rpmsg_chrdev",
+};
+
 static int rpmsg_chrdev_init(void)
 {
 	int ret;
@@ -438,12 +486,24 @@ static int rpmsg_chrdev_init(void)
 		return ret;
 	}
 
+	ret = register_rpmsg_driver(&rpmsg_chrdev_driver);
+	if (ret < 0) {
+		pr_err("rpmsg: failed to register rpmsg raw driver\n");
+		goto free_region;
+	}
+
 	return 0;
+
+free_region:
+	unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
+
+	return ret;
 }
 postcore_initcall(rpmsg_chrdev_init);
 
 static void rpmsg_chrdev_exit(void)
 {
+	unregister_rpmsg_driver(&rpmsg_chrdev_driver);
 	unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
 }
 module_exit(rpmsg_chrdev_exit);
-- 
2.25.1

