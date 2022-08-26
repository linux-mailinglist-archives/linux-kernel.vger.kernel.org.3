Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FC95A295C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 16:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344108AbiHZO0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 10:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344059AbiHZO0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 10:26:01 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E213335E;
        Fri, 26 Aug 2022 07:25:52 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MDhsg5hlgzGpZ2;
        Fri, 26 Aug 2022 22:24:07 +0800 (CST)
Received: from CHINA (10.175.102.38) by canpemm500009.china.huawei.com
 (7.192.105.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 26 Aug
 2022 22:25:49 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Mark Brown <broonie@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH -next 1/4] spi: mockup: Add SPI controller testing driver
Date:   Fri, 26 Aug 2022 14:43:38 +0000
Message-ID: <20220826144341.532265-2-weiyongjun1@huawei.com>
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

This enables SPI controller Testing driver, which provides a way
to test SPI drivers.

This is accomplished by executing the following command:

$ echo adcxx1s 0 > /sys/class/spi_master/spi0/new_device

The name of the target driver and its chip select were used to
instantiate the device.

$ ls /sys/bus/spi/devices/spi0.0/hwmon/hwmon0/ -l
 total 0
 lrwxrwxrwx 1 root root    0 Aug 10 08:58 device -> ../../../spi0.0
 drwxr-xr-x 2 root root    0 Aug 10 08:58 power
 lrwxrwxrwx 1 root root    0 Aug 10 08:58 subsystem -> ../../../../../../../../class/hwmon
 -rw-r--r-- 1 root root 4096 Aug 10 08:58 uevent

Remove target device by executing the following command:
$ echo 0 > /sys/class/spi_master/spi0/delete_device

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/spi/Kconfig      |  12 +++
 drivers/spi/Makefile     |   1 +
 drivers/spi/spi-mockup.c | 221 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 234 insertions(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d1bb62f7368b..b58a1bd7999d 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1158,6 +1158,18 @@ config SPI_TLE62X0
 	  sysfs interface, with each line presented as a kind of GPIO
 	  exposing both switch control and diagnostic feedback.
 
+config SPI_MOCKUP
+	tristate "SPI controller Testing Driver"
+	depends on OF
+	help
+	  This enables SPI controller testing driver, which provides a way to
+	  test SPI subsystem.
+
+	  If you do build this module, be sure to read the notes and warnings
+	  in <file:Documentation/spi/spi-mockup.rst>.
+
+	  If you don't know what to do here, definitely say N.
+
 #
 # Add new SPI protocol masters in alphabetical order above this line
 #
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 4b34e855c841..be87f49098b6 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_SPI_MEM)			+= spi-mem.o
 obj-$(CONFIG_SPI_MUX)			+= spi-mux.o
 obj-$(CONFIG_SPI_SPIDEV)		+= spidev.o
 obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
+obj-$(CONFIG_SPI_MOCKUP)		+= spi-mockup.o
 
 # SPI master controller drivers (bus)
 obj-$(CONFIG_SPI_ALTERA)		+= spi-altera-platform.o
diff --git a/drivers/spi/spi-mockup.c b/drivers/spi/spi-mockup.c
new file mode 100644
index 000000000000..06cf9d122d64
--- /dev/null
+++ b/drivers/spi/spi-mockup.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * SPI controller Testing Driver
+ *
+ * Copyright(c) 2022 Huawei Technologies Co., Ltd.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+
+#define MOCKUP_CHIPSELECT_MAX		8
+
+struct mockup_spi {
+	struct mutex lock;
+	struct spi_device *devs[MOCKUP_CHIPSELECT_MAX];
+};
+
+static struct spi_master *to_spi_master(struct device *dev)
+{
+	return container_of(dev, struct spi_master, dev);
+}
+
+static ssize_t
+new_device_store(struct device *dev, struct device_attribute *attr,
+		 const char *buf, size_t count)
+{
+	struct spi_master *master = to_spi_master(dev);
+	struct spi_board_info info;
+	struct spi_device *slave;
+	struct mockup_spi *mock;
+	char *blank, end;
+	int status;
+
+	memset(&info, 0, sizeof(struct spi_board_info));
+
+	blank = strchr(buf, ' ');
+	if (!blank) {
+		dev_err(dev, "%s: Extra parameters\n", "new_device");
+		return -EINVAL;
+	}
+
+	if (blank - buf > SPI_NAME_SIZE - 1) {
+		dev_err(dev, "%s: Invalid device name\n", "new_device");
+		return -EINVAL;
+	}
+
+	memcpy(info.modalias, buf, blank - buf);
+
+	status = sscanf(++blank, "%hi%c", &info.chip_select, &end);
+	if (status < 1) {
+		dev_err(dev, "%s: Can't parse SPI chipselect\n", "new_device");
+		return -EINVAL;
+	}
+
+	if (status > 1 && end != '\n') {
+		dev_err(dev, "%s: Extra parameters\n", "new_device");
+		return -EINVAL;
+	}
+
+	if (info.chip_select >= master->num_chipselect) {
+		dev_err(dev, "%s: Invalid chip_select\n", "new_device");
+		return -EINVAL;
+	}
+
+	mock = spi_master_get_devdata(master);
+	mutex_lock(&mock->lock);
+
+	if (mock->devs[info.chip_select]) {
+		dev_err(dev, "%s: Chipselect %d already in use\n",
+			"new_device", info.chip_select);
+		mutex_unlock(&mock->lock);
+		return -EINVAL;
+	}
+
+	slave = spi_new_device(master, &info);
+	if (!slave) {
+		mutex_unlock(&mock->lock);
+		return -ENOMEM;
+	}
+	mock->devs[info.chip_select] = slave;
+
+	mutex_unlock(&mock->lock);
+
+	dev_info(dev, "%s: Instantiated device %s at 0x%02x\n", "new_device",
+		 info.modalias, info.chip_select);
+
+	return count;
+}
+static DEVICE_ATTR_WO(new_device);
+
+static ssize_t
+delete_device_store(struct device *dev, struct device_attribute *attr,
+		    const char *buf, size_t count)
+{
+	struct spi_master *master = to_spi_master(dev);
+	struct spi_device *slave;
+	struct mockup_spi *mock;
+	unsigned short chip;
+	char end;
+	int res;
+
+	/* Parse parameters, reject extra parameters */
+	res = sscanf(buf, "%hi%c", &chip, &end);
+	if (res < 1) {
+		dev_err(dev, "%s: Can't parse SPI address\n", "delete_device");
+		return -EINVAL;
+	}
+	if (res > 1  && end != '\n') {
+		dev_err(dev, "%s: Extra parameters\n", "delete_device");
+		return -EINVAL;
+	}
+
+	if (chip >= master->num_chipselect) {
+		dev_err(dev, "%s: Invalid chip_select\n", "delete_device");
+		return -EINVAL;
+	}
+
+	mock = spi_master_get_devdata(master);
+	mutex_lock(&mock->lock);
+
+	slave = mock->devs[chip];
+	if (!slave) {
+		mutex_unlock(&mock->lock);
+		dev_err(dev, "%s: Invalid chip_select\n", "delete_device");
+		return -ENOENT;
+	}
+
+	dev_info(dev, "%s: Deleting device %s at 0x%02hx\n", "delete_device",
+		 dev_name(&slave->dev), chip);
+
+	spi_unregister_device(slave);
+	mock->devs[chip] = NULL;
+
+	mutex_unlock(&mock->lock);
+
+	return count;
+}
+static DEVICE_ATTR_WO(delete_device);
+
+static struct attribute *spi_mockup_attrs[] = {
+	&dev_attr_new_device.attr,
+	&dev_attr_delete_device.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(spi_mockup);
+
+static int spi_mockup_transfer(struct spi_master *master,
+			       struct spi_message *msg)
+{
+	msg->status = 0;
+	spi_finalize_current_message(master);
+
+	return 0;
+}
+
+static int spi_mockup_probe(struct platform_device *pdev)
+{
+	struct spi_master *master;
+	struct mockup_spi *mock;
+	int ret;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(struct mockup_spi));
+	if (!master) {
+		pr_err("failed to alloc spi master\n");
+		return -ENOMEM;
+	}
+
+	platform_set_drvdata(pdev, master);
+
+	master->dev.of_node = pdev->dev.of_node;
+	master->dev.groups = spi_mockup_groups;
+	master->num_chipselect = MOCKUP_CHIPSELECT_MAX;
+	master->mode_bits = SPI_MODE_USER_MASK;
+	master->bus_num = 0;
+	master->transfer_one_message = spi_mockup_transfer;
+
+	mock = spi_master_get_devdata(master);
+	mutex_init(&mock->lock);
+
+	ret = spi_register_master(master);
+	if (ret) {
+		spi_master_put(master);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int spi_mockup_remove(struct platform_device *pdev)
+{
+	struct spi_master *master = platform_get_drvdata(pdev);
+
+	spi_unregister_master(master);
+
+	return 0;
+}
+
+static const struct of_device_id spi_mockup_match[] = {
+	{ .compatible = "spi-mockup", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, spi_mockup_match);
+
+static struct platform_driver spi_mockup_driver = {
+	.probe = spi_mockup_probe,
+	.remove = spi_mockup_remove,
+	.driver = {
+		.name = "spi-mockup",
+		.of_match_table = spi_mockup_match,
+	},
+};
+module_platform_driver(spi_mockup_driver);
+
+MODULE_AUTHOR("Wei Yongjun <weiyongjun1@huawei.com>");
+MODULE_DESCRIPTION("SPI controller Testing Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

