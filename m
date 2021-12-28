Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9ECC480929
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 13:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhL1MnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 07:43:06 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:34854 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhL1MnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 07:43:05 -0500
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JNZ1l5kpWzccFv;
        Tue, 28 Dec 2021 20:42:35 +0800 (CST)
Received: from localhost.localdomain (10.175.102.38) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 20:43:03 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Roese <sr@denx.de>, Ming Lei <ming.lei@canonical.com>,
        Grant Likely <grant.likely@secretlab.ca>,
        <linux-kernel@vger.kernel.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] misc: lattice-ecp3-config: Fix task hung when firmware load failed
Date:   Tue, 28 Dec 2021 12:55:22 +0000
Message-ID: <20211228125522.3122284-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.102.38]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When firmware load failed, kernel report task hung as follows:

INFO: task xrun:5191 blocked for more than 147 seconds.
      Tainted: G        W         5.16.0-rc5-next-20211220+ #11
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:xrun            state:D stack:    0 pid: 5191 ppid:   270 flags:0x00000004
Call Trace:
 __schedule+0xc12/0x4b50 kernel/sched/core.c:4986
 schedule+0xd7/0x260 kernel/sched/core.c:6369 (discriminator 1)
 schedule_timeout+0x7aa/0xa80 kernel/time/timer.c:1857
 wait_for_completion+0x181/0x290 kernel/sched/completion.c:85
 lattice_ecp3_remove+0x32/0x40 drivers/misc/lattice-ecp3-config.c:221
 spi_remove+0x72/0xb0 drivers/spi/spi.c:409

lattice_ecp3_remove() wait for signals from firmware loading, but when
load failed, firmware_load() does not send this signal. This cause
device remove hung. Fix it by sending signal even if load failed.

Fixes: 781551df57c7 ("misc: Add Lattice ECP3 FPGA configuration via SPI")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

diff --git a/drivers/misc/lattice-ecp3-config.c b/drivers/misc/lattice-ecp3-config.c
index 0f54730c7ed5..98828030b5a4 100644
--- a/drivers/misc/lattice-ecp3-config.c
+++ b/drivers/misc/lattice-ecp3-config.c
@@ -76,12 +76,12 @@ static void firmware_load(const struct firmware *fw, void *context)
 
 	if (fw == NULL) {
 		dev_err(&spi->dev, "Cannot load firmware, aborting\n");
-		return;
+		goto out;
 	}
 
 	if (fw->size == 0) {
 		dev_err(&spi->dev, "Error: Firmware size is 0!\n");
-		return;
+		goto out;
 	}
 
 	/* Fill dummy data (24 stuffing bits for commands) */
@@ -103,7 +103,7 @@ static void firmware_load(const struct firmware *fw, void *context)
 		dev_err(&spi->dev,
 			"Error: No supported FPGA detected (JEDEC_ID=%08x)!\n",
 			jedec_id);
-		return;
+		goto out;
 	}
 
 	dev_info(&spi->dev, "FPGA %s detected\n", ecp3_dev[i].name);
@@ -116,7 +116,7 @@ static void firmware_load(const struct firmware *fw, void *context)
 	buffer = kzalloc(fw->size + 8, GFP_KERNEL);
 	if (!buffer) {
 		dev_err(&spi->dev, "Error: Can't allocate memory!\n");
-		return;
+		goto out;
 	}
 
 	/*
@@ -155,7 +155,7 @@ static void firmware_load(const struct firmware *fw, void *context)
 			"Error: Timeout waiting for FPGA to clear (status=%08x)!\n",
 			status);
 		kfree(buffer);
-		return;
+		goto out;
 	}
 
 	dev_info(&spi->dev, "Configuring the FPGA...\n");
@@ -181,7 +181,7 @@ static void firmware_load(const struct firmware *fw, void *context)
 	release_firmware(fw);
 
 	kfree(buffer);
-
+out:
 	complete(&data->fw_loaded);
 }
 
-- 
2.25.1

