Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001F55A295A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344331AbiHZO0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343985AbiHZOZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:25:56 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29263342C;
        Fri, 26 Aug 2022 07:25:53 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MDhsh4WStzGplp;
        Fri, 26 Aug 2022 22:24:08 +0800 (CST)
Received: from CHINA (10.175.102.38) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 22:25:50 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Mark Brown <broonie@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH -next 3/4] spi: mockup: Add runtime device tree overlay interface
Date:   Fri, 26 Aug 2022 14:43:40 +0000
Message-ID: <20220826144341.532265-4-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220826144341.532265-1-weiyongjun1@huawei.com>
References: <20220826144341.532265-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a runtime device tree overlay interface for device need dts file.
With it its possible to use device tree overlays without having to use
a per-platform overlay manager.

Add a new device by command:
$ cat test.dtbo > /sys/class/spi_master/spi0/overlay_fdto

Remove the device by command:
$ echo remove > /sys/class/spi_master/spi0/overlay_fdto

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/spi/Kconfig      |  2 ++
 drivers/spi/spi-mockup.c | 48 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index e0f0fa2746ad..4b7c84ddb367 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1161,6 +1161,8 @@ config SPI_TLE62X0
 config SPI_MOCKUP
 	tristate "SPI controller Testing Driver"
 	depends on OF
+	select OF_EARLY_FLATTREE
+	select OF_RESOLVE
 	select BPF_EVENTS
 	help
 	  This enables SPI controller testing driver, which provides a way to
diff --git a/drivers/spi/spi-mockup.c b/drivers/spi/spi-mockup.c
index 7a93b194ee53..404ad821bf6a 100644
--- a/drivers/spi/spi-mockup.c
+++ b/drivers/spi/spi-mockup.c
@@ -21,6 +21,9 @@
 struct mockup_spi {
 	struct mutex lock;
 	struct spi_device *devs[MOCKUP_CHIPSELECT_MAX];
+
+	void *fdto;
+	int ovcs_id;
 };
 
 static struct spi_master *to_spi_master(struct device *dev)
@@ -145,9 +148,53 @@ delete_device_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_WO(delete_device);
 
+static ssize_t
+overlay_fdto_store(struct device *dev, struct device_attribute *attr,
+		   const char *buf, size_t count)
+{
+	struct spi_master *master = to_spi_master(dev);
+	struct mockup_spi *mock = spi_master_get_devdata(master);
+	int ret;
+
+	mutex_lock(&mock->lock);
+
+	if (strncmp(buf, "remove\n", count) == 0) {
+		if (mock->ovcs_id < 0) {
+			ret = -ENOENT;
+			goto out_unlock;
+		}
+		of_overlay_remove(&mock->ovcs_id);
+		kfree(mock->fdto);
+		mock->ovcs_id = -1;
+		mock->fdto = NULL;
+	} else {
+		if (mock->ovcs_id >= 0) {
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+		mock->fdto = kmemdup(buf, count, GFP_KERNEL);
+		if (!mock->fdto) {
+			ret = -ENOMEM;
+			goto out_unlock;
+		}
+		ret = of_overlay_fdt_apply(mock->fdto, count, &mock->ovcs_id);
+		if (ret < 0)
+			goto out_unlock;
+	}
+
+	mutex_unlock(&mock->lock);
+	return count;
+
+out_unlock:
+	mutex_unlock(&mock->lock);
+	return ret;
+}
+static DEVICE_ATTR_WO(overlay_fdto);
+
 static struct attribute *spi_mockup_attrs[] = {
 	&dev_attr_new_device.attr,
 	&dev_attr_delete_device.attr,
+	&dev_attr_overlay_fdto.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(spi_mockup);
@@ -227,6 +274,7 @@ static int spi_mockup_probe(struct platform_device *pdev)
 
 	mock = spi_master_get_devdata(master);
 	mutex_init(&mock->lock);
+	mock->ovcs_id = -1;
 
 	ret = spi_register_master(master);
 	if (ret) {
-- 
2.34.1

