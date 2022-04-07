Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249564F7FFD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 15:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343561AbiDGNGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 09:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245683AbiDGNFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 09:05:51 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0F925B90B;
        Thu,  7 Apr 2022 06:03:45 -0700 (PDT)
X-UUID: b96f0cdb1cf5450f8ceaa53603bb7167-20220407
X-UUID: b96f0cdb1cf5450f8ceaa53603bb7167-20220407
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 340861976; Thu, 07 Apr 2022 21:03:42 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 7 Apr 2022 21:03:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Apr 2022 21:03:41 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Kevin Hilman <khilman@baylibre.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>, <tzungbi@google.com>,
        Chen-Yu Tsai <wenst@chromium.org>, <cujomalainey@google.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <sound-open-firmware@alsa-project.org>,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Subject: [PATCH v7 1/1] firmware: mediatek: add adsp ipc protocol interface
Date:   Thu, 7 Apr 2022 21:03:38 +0800
Message-ID: <20220407130338.28939-2-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220407130338.28939-1-allen-kh.cheng@mediatek.com>
References: <20220407130338.28939-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>

Some of mediatek processors contain
the Tensilica HiFix DSP for audio processing.

The communication between Host CPU and DSP firmware is
taking place using a shared memory area for message passing.

ADSP IPC protocol offers (send/recv) interfaces using
mediatek-mailbox APIs.

We use two mbox channels to implement a request-reply protocol.

Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Curtis Malainey <cujomalainey@chromium.org>
Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
Reviewed-by: YC Hung <yc.hung@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/firmware/Kconfig                      |   1 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/mediatek/Kconfig             |   9 +
 drivers/firmware/mediatek/Makefile            |   2 +
 drivers/firmware/mediatek/mtk-adsp-ipc.c      | 161 ++++++++++++++++++
 .../linux/firmware/mediatek/mtk-adsp-ipc.h    |  65 +++++++
 6 files changed, 239 insertions(+)
 create mode 100644 drivers/firmware/mediatek/Kconfig
 create mode 100644 drivers/firmware/mediatek/Makefile
 create mode 100644 drivers/firmware/mediatek/mtk-adsp-ipc.c
 create mode 100644 include/linux/firmware/mediatek/mtk-adsp-ipc.h

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index e5cfb01353d8..605ae3f47adc 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -300,6 +300,7 @@ source "drivers/firmware/cirrus/Kconfig"
 source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
 source "drivers/firmware/imx/Kconfig"
+source "drivers/firmware/mediatek/Kconfig"
 source "drivers/firmware/meson/Kconfig"
 source "drivers/firmware/psci/Kconfig"
 source "drivers/firmware/smccc/Kconfig"
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 4e58cb474a68..88fbdc110100 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
 obj-$(CONFIG_EFI)		+= efi/
 obj-$(CONFIG_UEFI_CPER)		+= efi/
 obj-y				+= imx/
+obj-y				+= mediatek/
 obj-y				+= psci/
 obj-y				+= smccc/
 obj-y				+= tegra/
diff --git a/drivers/firmware/mediatek/Kconfig b/drivers/firmware/mediatek/Kconfig
new file mode 100644
index 000000000000..6d1e580b967b
--- /dev/null
+++ b/drivers/firmware/mediatek/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config MTK_ADSP_IPC
+	tristate "MTK ADSP IPC Protocol driver"
+	depends on MTK_ADSP_MBOX
+	help
+	  Say yes here to add support for the MediaTek ADSP IPC
+	  between host AP (Linux) and the firmware running on ADSP.
+	  ADSP exists on some mtk processors.
+	  Client might use shared memory to exchange information with ADSP side.
diff --git a/drivers/firmware/mediatek/Makefile b/drivers/firmware/mediatek/Makefile
new file mode 100644
index 000000000000..4e840b65650d
--- /dev/null
+++ b/drivers/firmware/mediatek/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_MTK_ADSP_IPC)		+= mtk-adsp-ipc.o
diff --git a/drivers/firmware/mediatek/mtk-adsp-ipc.c b/drivers/firmware/mediatek/mtk-adsp-ipc.c
new file mode 100644
index 000000000000..87cee61dbf32
--- /dev/null
+++ b/drivers/firmware/mediatek/mtk-adsp-ipc.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 MediaTek Corporation. All rights reserved.
+ * Author: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
+ */
+
+#include <linux/firmware/mediatek/mtk-adsp-ipc.h>
+#include <linux/kernel.h>
+#include <linux/mailbox_client.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+/*
+ * mtk_adsp_ipc_send - send ipc cmd to MTK ADSP
+ *
+ * @ipc: ADSP IPC handle
+ * @idx: index of the mailbox channel
+ * @msg: IPC cmd (reply or request)
+ *
+ * Returns zero for success from mbox_send_message
+ * negative value for error
+ */
+int mtk_adsp_ipc_send(struct mtk_adsp_ipc *ipc, unsigned int idx, uint32_t msg)
+{
+	struct mtk_adsp_chan *adsp_chan;
+	int ret;
+
+	if (idx >= MTK_ADSP_MBOX_NUM)
+		return -EINVAL;
+
+	adsp_chan = &ipc->chans[idx];
+	ret = mbox_send_message(adsp_chan->ch, &msg);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * mbox_send_message returns non-negative value on success,
+	 * return zero for success
+	 */
+	return 0;
+}
+EXPORT_SYMBOL(mtk_adsp_ipc_send);
+
+/*
+ * mtk_adsp_ipc_recv - recv callback used by MTK ADSP mailbox
+ *
+ * @c: mbox client
+ * @msg: message received
+ *
+ * Users of ADSP IPC will need to privde handle_reply and handle_request
+ * callbacks.
+ */
+static void mtk_adsp_ipc_recv(struct mbox_client *c, void *msg)
+{
+	struct mtk_adsp_chan *chan = container_of(c, struct mtk_adsp_chan, cl);
+	struct device *dev = c->dev;
+
+	switch (chan->idx) {
+	case MTK_ADSP_MBOX_REPLY:
+		chan->ipc->ops->handle_reply(chan->ipc);
+		break;
+	case MTK_ADSP_MBOX_REQUEST:
+		chan->ipc->ops->handle_request(chan->ipc);
+		break;
+	default:
+		dev_err(dev, "wrong mbox chan %d\n", chan->idx);
+		break;
+	}
+}
+
+static int mtk_adsp_ipc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_adsp_ipc *adsp_ipc;
+	struct mtk_adsp_chan *adsp_chan;
+	struct mbox_client *cl;
+	char *chan_name;
+	int ret;
+	int i, j;
+
+	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
+
+	adsp_ipc = devm_kzalloc(dev, sizeof(*adsp_ipc), GFP_KERNEL);
+	if (!adsp_ipc)
+		return -ENOMEM;
+
+	for (i = 0; i < MTK_ADSP_MBOX_NUM; i++) {
+		chan_name = kasprintf(GFP_KERNEL, "mbox%d", i);
+		if (!chan_name) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		adsp_chan = &adsp_ipc->chans[i];
+		cl = &adsp_chan->cl;
+		cl->dev = dev->parent;
+		cl->tx_block = false;
+		cl->knows_txdone = false;
+		cl->tx_prepare = NULL;
+		cl->rx_callback = mtk_adsp_ipc_recv;
+
+		adsp_chan->ipc = adsp_ipc;
+		adsp_chan->idx = i;
+		adsp_chan->ch = mbox_request_channel_byname(cl, chan_name);
+		if (IS_ERR(adsp_chan->ch)) {
+			ret = PTR_ERR(adsp_chan->ch);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "Failed to request mbox chan %d ret %d\n",
+					i, ret);
+			goto out_free;
+		}
+
+		dev_dbg(dev, "request mbox chan %s\n", chan_name);
+		kfree(chan_name);
+	}
+
+	adsp_ipc->dev = dev;
+	dev_set_drvdata(dev, adsp_ipc);
+	dev_dbg(dev, "MTK ADSP IPC initialized\n");
+
+	return 0;
+
+out_free:
+	kfree(chan_name);
+out:
+	for (j = 0; j < i; j++) {
+		adsp_chan = &adsp_ipc->chans[j];
+		mbox_free_channel(adsp_chan->ch);
+	}
+
+	return ret;
+}
+
+static int mtk_adsp_ipc_remove(struct platform_device *pdev)
+{
+	struct mtk_adsp_ipc *adsp_ipc = dev_get_drvdata(&pdev->dev);
+	struct mtk_adsp_chan *adsp_chan;
+	int i;
+
+	for (i = 0; i < MTK_ADSP_MBOX_NUM; i++) {
+		adsp_chan = &adsp_ipc->chans[i];
+		mbox_free_channel(adsp_chan->ch);
+	}
+
+	return 0;
+}
+
+static struct platform_driver mtk_adsp_ipc_driver = {
+	.driver = {
+		.name = "mtk-adsp-ipc",
+	},
+	.probe = mtk_adsp_ipc_probe,
+	.remove = mtk_adsp_ipc_remove,
+};
+builtin_platform_driver(mtk_adsp_ipc_driver);
+
+MODULE_AUTHOR("Allen-KH Cheng <allen-kh.cheng@mediatek.com>");
+MODULE_DESCRIPTION("MTK ADSP IPC Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/firmware/mediatek/mtk-adsp-ipc.h b/include/linux/firmware/mediatek/mtk-adsp-ipc.h
new file mode 100644
index 000000000000..28fd313340b8
--- /dev/null
+++ b/include/linux/firmware/mediatek/mtk-adsp-ipc.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#ifndef MTK_ADSP_IPC_H
+#define MTK_ADSP_IPC_H
+
+#include <linux/device.h>
+#include <linux/types.h>
+#include <linux/mailbox_controller.h>
+#include <linux/mailbox_client.h>
+
+#define MTK_ADSP_IPC_REQ 0
+#define MTK_ADSP_IPC_RSP 1
+#define MTK_ADSP_IPC_OP_REQ 0x1
+#define MTK_ADSP_IPC_OP_RSP 0x2
+
+enum {
+	MTK_ADSP_MBOX_REPLY,
+	MTK_ADSP_MBOX_REQUEST,
+	MTK_ADSP_MBOX_NUM,
+};
+
+struct mtk_adsp_ipc;
+
+struct mtk_adsp_ipc_ops {
+	void (*handle_reply)(struct mtk_adsp_ipc *ipc);
+	void (*handle_request)(struct mtk_adsp_ipc *ipc);
+};
+
+struct mtk_adsp_chan {
+	struct mtk_adsp_ipc *ipc;
+	struct mbox_client cl;
+	struct mbox_chan *ch;
+	char *name;
+	int idx;
+};
+
+struct mtk_adsp_ipc {
+	struct mtk_adsp_chan chans[MTK_ADSP_MBOX_NUM];
+	struct device *dev;
+	struct mtk_adsp_ipc_ops *ops;
+	void *private_data;
+};
+
+static inline void mtk_adsp_ipc_set_data(struct mtk_adsp_ipc *ipc, void *data)
+{
+	if (!ipc)
+		return;
+
+	ipc->private_data = data;
+}
+
+static inline void *mtk_adsp_ipc_get_data(struct mtk_adsp_ipc *ipc)
+{
+	if (!ipc)
+		return NULL;
+
+	return ipc->private_data;
+}
+
+int mtk_adsp_ipc_send(struct mtk_adsp_ipc *ipc, unsigned int idx, uint32_t op);
+
+#endif /* MTK_ADSP_IPC_H */
-- 
2.18.0

