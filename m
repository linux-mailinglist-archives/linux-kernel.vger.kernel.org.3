Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36672483474
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 16:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbiACP6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 10:58:46 -0500
Received: from foss.arm.com ([217.140.110.172]:44038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbiACP6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 10:58:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4FCE6D;
        Mon,  3 Jan 2022 07:58:45 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F3B303F774;
        Mon,  3 Jan 2022 07:58:44 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v2] ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype
Date:   Mon,  3 Jan 2022 15:58:38 +0000
Message-Id: <20220103155838.616580-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCC OpRegion provides a mechanism to communicate with the platform
directly from the AML. PCCT provides the list of PCC channel available
in the platform, a subset or all of them can be used in PCC Opregion.

This patch registers the PCC OpRegion handler before ACPI tables are
loaded. This relies on the special context data passed to identify and
set up the PCC channel before the OpRegion handler is executed for the
first time.

Typical PCC Opregion declaration looks like this:

OperationRegion (PFRM, PCC, 2, 0x74)
Field (PFRM, ByteAcc, NoLock, Preserve)
{
    SIGN,   32,
    FLGS,   32,
    LEN,    32,
    CMD,    32,
    DATA,   800
}

It contains four named double words followed by 100 bytes of buffer
names DATA.

ASL can fill out the buffer something like:

    /* Create global or local buffer */
    Name (BUFF, Buffer (0x0C){})
    /* Create double word fields over the buffer */
    CreateDWordField (BUFF, 0x0, WD0)
    CreateDWordField (BUFF, 0x04, WD1)
    CreateDWordField (BUFF, 0x08, WD2)

    /* Fill the named fields */
    WD0 = 0x50434300
    SIGN = BUFF
    WD0 = 1
    FLGS = BUFF
    WD0 = 0x10
    LEN = BUFF

    /* Fill the payload in the DATA buffer */
    WD0 = 0
    WD1 = 0x08
    WD2 = 0
    DATA = BUFF

    /* Write to CMD field to trigger handler */
    WD0 = 0x4404
    CMD = BUFF

This buffer is received by acpi_pcc_opregion_space_handler. This
handler will fetch the complete buffer via internal_pcc_buffer.

The setup handler will receive the special PCC context data which will
contain the PCC channel index which used to set up the channel. The
buffer pointer and length is saved in region context which is then used
in the handler.

Cc: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/Kconfig    |  17 ++++++
 drivers/acpi/Makefile   |   1 +
 drivers/acpi/acpi_pcc.c | 120 ++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/bus.c      |   1 +
 include/linux/acpi.h    |   6 ++
 5 files changed, 145 insertions(+)
 create mode 100644 drivers/acpi/acpi_pcc.c

v1[0]-v2:
	- Addressed all the comments from Rafael[1]

[0] https://lore.kernel.org/r/20211222190919.137550-1-sudeep.holla@arm.com/
[1] https://lore.kernel.org/r/CAJZ5v0jWJVSFS3KTavfCTzxWq-Q361nGDCWf+VLXRu-9Z4MJsQ@mail.gmail.com

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 91f1da16934d..8cdc7860b6e6 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -546,6 +546,23 @@ config ACPI_PPTT
 	bool
 endif

+config ACPI_PCC
+	bool "ACPI PCC Address Space"
+	depends on PCC
+	default y
+	help
+	  The PCC Address Space also referred as PCC Operation Region pertains
+	  to the region of PCC subspace that succeeds the PCC signature.
+
+	  The PCC Operation Region works in conjunction with the PCC Table
+	  (Platform Communications Channel Table). PCC subspaces that are
+	  marked for use as PCC Operation Regions must not be used as PCC
+	  subspaces for the standard ACPI features such as CPPC, RASF, PDTT and
+	  MPST. These standard features must always use the PCC Table instead.
+
+	  Enable this feature if you want to set up and install the PCC Address
+	  Space handler to handle PCC OpRegion in the firmware.
+
 source "drivers/acpi/pmic/Kconfig"

 config ACPI_VIOT
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index d3dc79298ce3..f47032769f69 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -67,6 +67,7 @@ acpi-$(CONFIG_ACPI_LPIT)	+= acpi_lpit.o
 acpi-$(CONFIG_ACPI_GENERIC_GSI) += irq.o
 acpi-$(CONFIG_ACPI_WATCHDOG)	+= acpi_watchdog.o
 acpi-$(CONFIG_ACPI_PRMT)	+= prmt.o
+acpi-$(CONFIG_ACPI_PCC)		+= acpi_pcc.o

 # Address translation
 acpi-$(CONFIG_ACPI_ADXL)	+= acpi_adxl.o
diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
new file mode 100644
index 000000000000..64552fdb7347
--- /dev/null
+++ b/drivers/acpi/acpi_pcc.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Author: Sudeep Holla <sudeep.holla@arm.com>
+ * Copyright 2021 Arm Limited
+ *
+ * The PCC Address Space also referred as PCC Operation Region pertains to the
+ * region of PCC subspace that succeeds the PCC signature. The PCC Operation
+ * Region works in conjunction with the PCC Table(Platform Communications
+ * Channel Table). PCC subspaces that are marked for use as PCC Operation
+ * Regions must not be used as PCC subspaces for the standard ACPI features
+ * such as CPPC, RASF, PDTT and MPST. These standard features must always use
+ * the PCC Table instead.
+ *
+ * This driver sets up the PCC Address Space and installs an handler to enable
+ * handling of PCC OpRegion in the firmware.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/acpi.h>
+#include <linux/completion.h>
+#include <linux/idr.h>
+#include <linux/io.h>
+
+#include <acpi/pcc.h>
+
+struct pcc_data {
+	struct pcc_mbox_chan *pcc_chan;
+	void __iomem *pcc_comm_addr;
+	struct completion done;
+	struct mbox_client cl;
+	struct acpi_pcc_info ctx;
+};
+
+struct acpi_pcc_info pcc_ctx;
+
+static void pcc_rx_callback(struct mbox_client *cl, void *m)
+{
+	struct pcc_data *data = container_of(cl, struct pcc_data, cl);
+
+	complete(&data->done);
+}
+
+static acpi_status
+acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
+			     void *handler_context,  void **region_context)
+{
+	struct pcc_data *data;
+	struct acpi_pcc_info *ctx = handler_context;
+	struct pcc_mbox_chan *pcc_chan;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return_ACPI_STATUS(AE_NO_MEMORY);
+
+	data->cl.rx_callback = pcc_rx_callback;
+	data->cl.knows_txdone = true;
+	data->ctx.length = ctx->length;
+	data->ctx.subspace_id = ctx->subspace_id;
+	data->ctx.internal_buffer = ctx->internal_buffer;
+
+	init_completion(&data->done);
+	data->pcc_chan = pcc_mbox_request_channel(&data->cl, ctx->subspace_id);
+	if (IS_ERR(data->pcc_chan)) {
+		pr_err("Failed to find PCC channel for subspace %d\n",
+		       ctx->subspace_id);
+		return_ACPI_STATUS(AE_NOT_FOUND);
+	}
+
+	pcc_chan = data->pcc_chan;
+	data->pcc_comm_addr = acpi_os_ioremap(pcc_chan->shmem_base_addr,
+					      pcc_chan->shmem_size);
+	if (!data->pcc_comm_addr) {
+		pr_err("Failed to ioremap PCC comm region mem for %d\n",
+		       ctx->subspace_id);
+		return_ACPI_STATUS(AE_NO_MEMORY);
+	}
+
+	*region_context = data;
+	return_ACPI_STATUS(AE_OK);
+}
+
+static acpi_status
+acpi_pcc_address_space_handler(u32 function, acpi_physical_address addr,
+			       u32 bits, acpi_integer *value,
+			       void *handler_context, void *region_context)
+{
+	int ret;
+	struct pcc_data *data = region_context;
+
+	reinit_completion(&data->done);
+
+	/* Write to Shared Memory */
+	memcpy_toio(data->pcc_comm_addr, (void *)value, data->ctx.length);
+
+	ret = mbox_send_message(data->pcc_chan->mchan, NULL);
+	if (ret < 0)
+		return_ACPI_STATUS(AE_ERROR);
+
+	if (data->pcc_chan->mchan->mbox->txdone_irq)
+		wait_for_completion(&data->done);
+
+	mbox_client_txdone(data->pcc_chan->mchan, ret);
+
+	memcpy_fromio(value, data->pcc_comm_addr, data->ctx.length);
+
+	return_ACPI_STATUS(AE_OK);
+}
+
+void __init acpi_init_pcc(void)
+{
+	acpi_status status;
+
+	status = acpi_install_address_space_handler(ACPI_ROOT_OBJECT,
+						    ACPI_ADR_SPACE_PLATFORM_COMM,
+						    &acpi_pcc_address_space_handler,
+						    &acpi_pcc_address_space_setup,
+						    &pcc_ctx);
+	if (ACPI_FAILURE(status))
+		pr_alert("OperationRegion handler could not be installed\n");
+}
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index dd535b4b9a16..75a61626eddd 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1320,6 +1320,7 @@ static int __init acpi_init(void)
 		pr_debug("%s: kset create error\n", __func__);

 	init_prmt();
+	acpi_init_pcc();
 	result = acpi_bus_init();
 	if (result) {
 		kobject_put(acpi_kobj);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6c0798db6bde..eaeb4b9255bc 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1389,6 +1389,12 @@ static inline int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
 }
 #endif

+#ifdef CONFIG_ACPI_PCC
+void acpi_init_pcc(void);
+#else
+static inline void acpi_init_pcc(void) { }
+#endif
+
 #ifdef CONFIG_ACPI
 extern void acpi_device_notify(struct device *dev);
 extern void acpi_device_notify_remove(struct device *dev);
--
2.25.1

