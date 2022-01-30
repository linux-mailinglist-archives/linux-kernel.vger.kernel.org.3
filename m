Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282A44A37FD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 19:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355784AbiA3SHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 13:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243299AbiA3SHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 13:07:18 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2724C061714;
        Sun, 30 Jan 2022 10:07:17 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c2so8652541wml.1;
        Sun, 30 Jan 2022 10:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QuhtuGWtqIk7rFnp0JAyXMvF1/BzUfzQB0/yKMGNWhU=;
        b=H44+E6DLUlSXxnne6fTew+ED8tf8JeoXswRpxaQo2mIb4qg1HPMkG25VrmdId5clAT
         t6fadfWxdozwXMN7ScLoCrUUSChhzQqouUZAdv0F3YMEmCsfkTL1mA7F9bYe2Khnll2p
         vXp2IPv4Q2Ji91eLTuimcaQOmgZy62aY/xqDt21kXwTb7XGM23i8OenmsxPoLbm0suj3
         HPexJcU8lutm6ZOy4JtlwdUehPPps4A+QALgkno3l8QcsjVJ60sJjYAu0nLOH+R+Y9/J
         5T8evT876rbtJogNzGK7L9S2FBD9CpUx57rCMAFllMZ8/9Ui2GrNfd0WmnYGaObPVJoZ
         iNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QuhtuGWtqIk7rFnp0JAyXMvF1/BzUfzQB0/yKMGNWhU=;
        b=E+zz2WuRbfp+gPEbGX050GrsoWWCxJ4O2CKDk0+VUGY3DET57ZCYK257Gp9zpQpJxK
         tAtGAM8SoG8VmF8320lhbsq3a3oGjx8pwLZrE/t97UepYVIfNlFQ/79eNUHiUNNbwSFc
         PRva9+1bqjUtSCANtbMgh26bHReYbFzgZ92dBsri14/uoc0crV+ty9IDQK9vIwP3fsbj
         1M/8ql2pdvyLIn2uumCr3AhewLd7Ebwu8TFA8Nu43kKhWG4/m3hmK8hvc0AdRffg9dyU
         0j1bszbOcB2E9AqDcKLfCe2eLf5sq5MKcVsKivN7jB0o5rBM9DHLfjiZcVMI8hGnPLxL
         SotQ==
X-Gm-Message-State: AOAM531hn/dIJABGbmeAIXYc46UYDs2SFT+qtD4uKVth3JJbHWoLsB3c
        5V9ICVRiCeFVfY4YUwETaX0=
X-Google-Smtp-Source: ABdhPJyoIrktI7hay8Z95KMpRlbFlH6OVc0cybuoJpf3G3HiD4uK6M7ocvXNU9rSApO5v7h7ca8xjQ==
X-Received: by 2002:a05:600c:19c9:: with SMTP id u9mr5123967wmq.28.1643566036130;
        Sun, 30 Jan 2022 10:07:16 -0800 (PST)
Received: from localhost.localdomain ([141.72.243.13])
        by smtp.gmail.com with ESMTPSA id n14sm10019456wri.80.2022.01.30.10.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 10:07:15 -0800 (PST)
From:   Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
To:     andriy.shevchenko@linux.intel.com
Cc:     gregkh@linuxfoundation.org, kitakar@gmail.com,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        mchehab@kernel.org, mosescb.dev@gmail.com,
        sakari.ailus@linux.intel.com, tomi.valkeinen@ideasonboard.com,
        joe@perches.com
Subject: [PATCH v2] staging: media: atomisp: Use BIT macro instead of left shifting
Date:   Sun, 30 Jan 2022 19:06:55 +0100
Message-Id: <20220130180655.22970-1-mosescb.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <YfVstOJ38OTtd43n@smile.fi.intel.com>
References: <YfVstOJ38OTtd43n@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a BIT(nr) macro available in Linux Kernel,
which does the same thing.
Example: BIT(7) = (1UL << 7)

Also use GENMASK for masking
Example: GENMASK(3, 0) = 0b00001111 (same as (1 << 4) - 1)

Signed-off-by: Moses Christopher Bollavarapu <mosescb.dev@gmail.com>
---
 V1 -> V2: - Use GENMASK where-ever applicable
           - Add linux/bits.h header to modified files

 .../media/atomisp/pci/atomisp_compat_css20.c  |  7 +-
 .../staging/media/atomisp/pci/atomisp_v4l2.c  | 21 ++---
 .../media/atomisp/pci/ia_css_acc_types.h      |  7 +-
 .../staging/media/atomisp/pci/ia_css_env.h    |  9 ++-
 .../media/atomisp/pci/ia_css_event_public.h   | 33 ++++----
 .../staging/media/atomisp/pci/ia_css_irq.h    | 77 ++++++++++---------
 .../runtime/debug/interface/ia_css_debug.h    | 31 ++++----
 7 files changed, 96 insertions(+), 89 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
index 1173be0e72b0..a345fa1d7de9 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
@@ -40,6 +40,7 @@
 
 #include <linux/io.h>
 #include <linux/pm_runtime.h>
+#include <linux/bits.h>
 
 /* Assume max number of ACC stages */
 #define MAX_ACC_STAGES	20
@@ -1913,11 +1914,11 @@ void atomisp_css_input_set_mode(struct atomisp_sub_device *asd,
 			    &asd->stream_env[ATOMISP_INPUT_STREAM_GENERAL].stream_config;
 		s_config->mode = IA_CSS_INPUT_MODE_TPG;
 		s_config->source.tpg.mode = IA_CSS_TPG_MODE_CHECKERBOARD;
-		s_config->source.tpg.x_mask = (1 << 4) - 1;
+		s_config->source.tpg.x_mask = GENMASK(3, 0);
 		s_config->source.tpg.x_delta = -2;
-		s_config->source.tpg.y_mask = (1 << 4) - 1;
+		s_config->source.tpg.y_mask = GENMASK(3, 0);
 		s_config->source.tpg.y_delta = 3;
-		s_config->source.tpg.xy_mask = (1 << 8) - 1;
+		s_config->source.tpg.xy_mask = GENMASK(7, 0);
 		return;
 	}
 
diff --git a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
index 1b240891a6e2..803ed63daef8 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_v4l2.c
@@ -25,6 +25,7 @@
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/interrupt.h>
+#include <linux/bits.h>
 
 #include <asm/iosf_mbi.h>
 
@@ -626,11 +627,11 @@ static int atomisp_mrfld_pre_power_down(struct atomisp_device *isp)
 	 * IRQ, if so, waiting for it to be served
 	 */
 	pci_read_config_dword(pdev, PCI_INTERRUPT_CTRL, &irq);
-	irq = irq & 1 << INTR_IIR;
+	irq &= BIT(INTR_IIR);
 	pci_write_config_dword(pdev, PCI_INTERRUPT_CTRL, irq);
 
 	pci_read_config_dword(pdev, PCI_INTERRUPT_CTRL, &irq);
-	if (!(irq & (1 << INTR_IIR)))
+	if (!(irq & BIT(INTR_IIR)))
 		goto done;
 
 	atomisp_css2_hw_store_32(MRFLD_INTR_CLEAR_REG, 0xFFFFFFFF);
@@ -643,11 +644,11 @@ static int atomisp_mrfld_pre_power_down(struct atomisp_device *isp)
 		return -EAGAIN;
 	} else {
 		pci_read_config_dword(pdev, PCI_INTERRUPT_CTRL, &irq);
-		irq = irq & 1 << INTR_IIR;
+		irq &= BIT(INTR_IIR);
 		pci_write_config_dword(pdev, PCI_INTERRUPT_CTRL, irq);
 
 		pci_read_config_dword(pdev, PCI_INTERRUPT_CTRL, &irq);
-		if (!(irq & (1 << INTR_IIR))) {
+		if (!(irq & BIT(INTR_IIR))) {
 			atomisp_css2_hw_store_32(MRFLD_INTR_ENABLE_REG, 0x0);
 			goto done;
 		}
@@ -666,7 +667,7 @@ static int atomisp_mrfld_pre_power_down(struct atomisp_device *isp)
 	* HW sighting:4568410.
 	*/
 	pci_read_config_dword(pdev, PCI_INTERRUPT_CTRL, &irq);
-	irq &= ~(1 << INTR_IER);
+	irq &= ~BIT(INTR_IER);
 	pci_write_config_dword(pdev, PCI_INTERRUPT_CTRL, irq);
 
 	atomisp_msi_irq_uninit(isp);
@@ -682,7 +683,7 @@ static int atomisp_mrfld_pre_power_down(struct atomisp_device *isp)
 */
 static void punit_ddr_dvfs_enable(bool enable)
 {
-	int door_bell = 1 << 8;
+	int door_bell = BIT(8);
 	int max_wait = 30;
 	int reg;
 
@@ -1549,7 +1550,7 @@ static int atomisp_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	start = pci_resource_start(pdev, ATOM_ISP_PCI_BAR);
 	dev_dbg(&pdev->dev, "start: 0x%x\n", start);
 
-	err = pcim_iomap_regions(pdev, 1 << ATOM_ISP_PCI_BAR, pci_name(pdev));
+	err = pcim_iomap_regions(pdev, BIT(ATOM_ISP_PCI_BAR), pci_name(pdev));
 	if (err) {
 		dev_err(&pdev->dev, "Failed to I/O memory remapping (%d)\n", err);
 		goto ioremap_fail;
@@ -1838,11 +1839,11 @@ static int atomisp_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 	 */
 
 	pci_read_config_dword(pdev, PCI_INTERRUPT_CTRL, &irq);
-	irq = irq & 1 << INTR_IIR;
+	irq &= BIT(INTR_IIR);
 	pci_write_config_dword(pdev, PCI_INTERRUPT_CTRL, irq);
 
 	pci_read_config_dword(pdev, PCI_INTERRUPT_CTRL, &irq);
-	irq &= ~(1 << INTR_IER);
+	irq &= ~BIT(INTR_IER);
 	pci_write_config_dword(pdev, PCI_INTERRUPT_CTRL, irq);
 
 	atomisp_msi_irq_uninit(isp);
@@ -1854,7 +1855,7 @@ static int atomisp_pci_probe(struct pci_dev *pdev, const struct pci_device_id *i
 		dev_err(&pdev->dev, "Failed to switch off ISP\n");
 
 atomisp_dev_alloc_fail:
-	pcim_iounmap_regions(pdev, 1 << ATOM_ISP_PCI_BAR);
+	pcim_iounmap_regions(pdev, BIT(ATOM_ISP_PCI_BAR));
 
 ioremap_fail:
 	return err;
diff --git a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
index d0ce2f8ba653..14628da924e3 100644
--- a/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
+++ b/drivers/staging/media/atomisp/pci/ia_css_acc_types.h
@@ -24,6 +24,7 @@
 #include <type_support.h>
 #include <platform_support.h>
 #include <debug_global.h>
+#include <linux/bits.h>
 
 #include "ia_css_types.h"
 #include "ia_css_frame_format.h"
@@ -65,7 +66,7 @@ enum ia_css_fw_type {
 	ia_css_sp_firmware,		/** Firmware for the SP */
 	ia_css_isp_firmware,		/** Firmware for the ISP */
 	ia_css_bootloader_firmware,	/** Firmware for the BootLoader */
-	ia_css_acc_firmware		/** Firmware for accelrations */
+	ia_css_acc_firmware,		/** Firmware for accelrations */
 };
 
 struct ia_css_blob_descr;
@@ -466,7 +467,7 @@ struct ia_css_acc_fw {
 
 enum ia_css_sp_sleep_mode {
 	SP_DISABLE_SLEEP_MODE = 0,
-	SP_SLEEP_AFTER_FRAME = 1 << 0,
-	SP_SLEEP_AFTER_IRQ = 1 << 1
+	SP_SLEEP_AFTER_FRAME  = BIT(0),
+	SP_SLEEP_AFTER_IRQ    = BIT(1),
 };
 #endif /* _IA_CSS_ACC_TYPES_H */
diff --git a/drivers/staging/media/atomisp/pci/ia_css_env.h b/drivers/staging/media/atomisp/pci/ia_css_env.h
index 3b89bbd837a0..b9ebc14441a1 100644
--- a/drivers/staging/media/atomisp/pci/ia_css_env.h
+++ b/drivers/staging/media/atomisp/pci/ia_css_env.h
@@ -18,6 +18,7 @@
 
 #include <type_support.h>
 #include <linux/stdarg.h> /* va_list */
+#include <linux/bits.h> /* BIT(nr) */
 #include "ia_css_types.h"
 #include "ia_css_acc_types.h"
 
@@ -28,10 +29,10 @@
 
 /* Memory allocation attributes, for use in ia_css_css_mem_env. */
 enum ia_css_mem_attr {
-	IA_CSS_MEM_ATTR_CACHED = 1 << 0,
-	IA_CSS_MEM_ATTR_ZEROED = 1 << 1,
-	IA_CSS_MEM_ATTR_PAGEALIGN = 1 << 2,
-	IA_CSS_MEM_ATTR_CONTIGUOUS = 1 << 3,
+	IA_CSS_MEM_ATTR_CACHED     = BIT(0),
+	IA_CSS_MEM_ATTR_ZEROED     = BIT(1),
+	IA_CSS_MEM_ATTR_PAGEALIGN  = BIT(2),
+	IA_CSS_MEM_ATTR_CONTIGUOUS = BIT(3),
 };
 
 /* Environment with function pointers for local IA memory allocation.
diff --git a/drivers/staging/media/atomisp/pci/ia_css_event_public.h b/drivers/staging/media/atomisp/pci/ia_css_event_public.h
index 76219d741d2e..1f1d735a7034 100644
--- a/drivers/staging/media/atomisp/pci/ia_css_event_public.h
+++ b/drivers/staging/media/atomisp/pci/ia_css_event_public.h
@@ -24,6 +24,7 @@
 #include <ia_css_err.h>		/* ia_css_err */
 #include <ia_css_types.h>	/* ia_css_pipe */
 #include <ia_css_timer.h>	/* ia_css_timer */
+#include <linux/bits.h>	/* BIT(nr) */
 
 /* The event type, distinguishes the kind of events that
  * can are generated by the CSS system.
@@ -35,38 +36,38 @@
  * 4) "enum ia_css_event_type convert_event_sp_to_host_domain"	(sh_css.c)
  */
 enum ia_css_event_type {
-	IA_CSS_EVENT_TYPE_OUTPUT_FRAME_DONE		= 1 << 0,
+	IA_CSS_EVENT_TYPE_OUTPUT_FRAME_DONE		= BIT(0),
 	/** Output frame ready. */
-	IA_CSS_EVENT_TYPE_SECOND_OUTPUT_FRAME_DONE	= 1 << 1,
+	IA_CSS_EVENT_TYPE_SECOND_OUTPUT_FRAME_DONE	= BIT(1),
 	/** Second output frame ready. */
-	IA_CSS_EVENT_TYPE_VF_OUTPUT_FRAME_DONE		= 1 << 2,
+	IA_CSS_EVENT_TYPE_VF_OUTPUT_FRAME_DONE		= BIT(2),
 	/** Viewfinder Output frame ready. */
-	IA_CSS_EVENT_TYPE_SECOND_VF_OUTPUT_FRAME_DONE	= 1 << 3,
+	IA_CSS_EVENT_TYPE_SECOND_VF_OUTPUT_FRAME_DONE	= BIT(3),
 	/** Second viewfinder Output frame ready. */
-	IA_CSS_EVENT_TYPE_3A_STATISTICS_DONE		= 1 << 4,
+	IA_CSS_EVENT_TYPE_3A_STATISTICS_DONE		= BIT(4),
 	/** Indication that 3A statistics are available. */
-	IA_CSS_EVENT_TYPE_DIS_STATISTICS_DONE		= 1 << 5,
+	IA_CSS_EVENT_TYPE_DIS_STATISTICS_DONE		= BIT(5),
 	/** Indication that DIS statistics are available. */
-	IA_CSS_EVENT_TYPE_PIPELINE_DONE			= 1 << 6,
+	IA_CSS_EVENT_TYPE_PIPELINE_DONE			= BIT(6),
 	/** Pipeline Done event, sent after last pipeline stage. */
-	IA_CSS_EVENT_TYPE_FRAME_TAGGED			= 1 << 7,
+	IA_CSS_EVENT_TYPE_FRAME_TAGGED			= BIT(7),
 	/** Frame tagged. */
-	IA_CSS_EVENT_TYPE_INPUT_FRAME_DONE		= 1 << 8,
+	IA_CSS_EVENT_TYPE_INPUT_FRAME_DONE		= BIT(8),
 	/** Input frame ready. */
-	IA_CSS_EVENT_TYPE_METADATA_DONE			= 1 << 9,
+	IA_CSS_EVENT_TYPE_METADATA_DONE			= BIT(9),
 	/** Metadata ready. */
-	IA_CSS_EVENT_TYPE_LACE_STATISTICS_DONE		= 1 << 10,
+	IA_CSS_EVENT_TYPE_LACE_STATISTICS_DONE		= BIT(10),
 	/** Indication that LACE statistics are available. */
-	IA_CSS_EVENT_TYPE_ACC_STAGE_COMPLETE		= 1 << 11,
+	IA_CSS_EVENT_TYPE_ACC_STAGE_COMPLETE		= BIT(11),
 	/** Extension stage complete. */
-	IA_CSS_EVENT_TYPE_TIMER				= 1 << 12,
+	IA_CSS_EVENT_TYPE_TIMER				= BIT(12),
 	/** Timer event for measuring the SP side latencies. It contains the
 	     32-bit timer value from the SP */
-	IA_CSS_EVENT_TYPE_PORT_EOF			= 1 << 13,
+	IA_CSS_EVENT_TYPE_PORT_EOF			= BIT(13),
 	/** End Of Frame event, sent when in buffered sensor mode. */
-	IA_CSS_EVENT_TYPE_FW_WARNING			= 1 << 14,
+	IA_CSS_EVENT_TYPE_FW_WARNING			= BIT(14),
 	/** Performance warning encounter by FW */
-	IA_CSS_EVENT_TYPE_FW_ASSERT			= 1 << 15,
+	IA_CSS_EVENT_TYPE_FW_ASSERT			= BIT(15),
 	/** Assertion hit by FW */
 };
 
diff --git a/drivers/staging/media/atomisp/pci/ia_css_irq.h b/drivers/staging/media/atomisp/pci/ia_css_irq.h
index 3b81a39cfe97..50a7939898ea 100644
--- a/drivers/staging/media/atomisp/pci/ia_css_irq.h
+++ b/drivers/staging/media/atomisp/pci/ia_css_irq.h
@@ -23,6 +23,7 @@
 #include "ia_css_err.h"
 #include "ia_css_pipe_public.h"
 #include "ia_css_input_port.h"
+#include <linux/bits.h>
 
 /* Interrupt types, these enumerate all supported interrupt types.
  */
@@ -46,49 +47,49 @@ enum ia_css_irq_type {
  * (SW) interrupts
  */
 enum ia_css_irq_info {
-	IA_CSS_IRQ_INFO_CSS_RECEIVER_ERROR            = 1 << 0,
+	IA_CSS_IRQ_INFO_CSS_RECEIVER_ERROR            = BIT(0),
 	/** the css receiver has encountered an error */
-	IA_CSS_IRQ_INFO_CSS_RECEIVER_FIFO_OVERFLOW    = 1 << 1,
+	IA_CSS_IRQ_INFO_CSS_RECEIVER_FIFO_OVERFLOW    = BIT(1),
 	/** the FIFO in the csi receiver has overflown */
-	IA_CSS_IRQ_INFO_CSS_RECEIVER_SOF              = 1 << 2,
+	IA_CSS_IRQ_INFO_CSS_RECEIVER_SOF              = BIT(2),
 	/** the css receiver received the start of frame */
-	IA_CSS_IRQ_INFO_CSS_RECEIVER_EOF              = 1 << 3,
+	IA_CSS_IRQ_INFO_CSS_RECEIVER_EOF              = BIT(3),
 	/** the css receiver received the end of frame */
-	IA_CSS_IRQ_INFO_CSS_RECEIVER_SOL              = 1 << 4,
+	IA_CSS_IRQ_INFO_CSS_RECEIVER_SOL              = BIT(4),
 	/** the css receiver received the start of line */
-	IA_CSS_IRQ_INFO_EVENTS_READY                  = 1 << 5,
+	IA_CSS_IRQ_INFO_EVENTS_READY                  = BIT(5),
 	/** One or more events are available in the PSYS event queue */
-	IA_CSS_IRQ_INFO_CSS_RECEIVER_EOL              = 1 << 6,
+	IA_CSS_IRQ_INFO_CSS_RECEIVER_EOL              = BIT(6),
 	/** the css receiver received the end of line */
-	IA_CSS_IRQ_INFO_CSS_RECEIVER_SIDEBAND_CHANGED = 1 << 7,
+	IA_CSS_IRQ_INFO_CSS_RECEIVER_SIDEBAND_CHANGED = BIT(7),
 	/** the css receiver received a change in side band signals */
-	IA_CSS_IRQ_INFO_CSS_RECEIVER_GEN_SHORT_0      = 1 << 8,
+	IA_CSS_IRQ_INFO_CSS_RECEIVER_GEN_SHORT_0      = BIT(8),
 	/** generic short packets (0) */
-	IA_CSS_IRQ_INFO_CSS_RECEIVER_GEN_SHORT_1      = 1 << 9,
+	IA_CSS_IRQ_INFO_CSS_RECEIVER_GEN_SHORT_1      = BIT(9),
 	/** generic short packets (1) */
-	IA_CSS_IRQ_INFO_IF_PRIM_ERROR                 = 1 << 10,
+	IA_CSS_IRQ_INFO_IF_PRIM_ERROR                 = BIT(10),
 	/** the primary input formatter (A) has encountered an error */
-	IA_CSS_IRQ_INFO_IF_PRIM_B_ERROR               = 1 << 11,
+	IA_CSS_IRQ_INFO_IF_PRIM_B_ERROR               = BIT(11),
 	/** the primary input formatter (B) has encountered an error */
-	IA_CSS_IRQ_INFO_IF_SEC_ERROR                  = 1 << 12,
+	IA_CSS_IRQ_INFO_IF_SEC_ERROR                  = BIT(12),
 	/** the secondary input formatter has encountered an error */
-	IA_CSS_IRQ_INFO_STREAM_TO_MEM_ERROR           = 1 << 13,
+	IA_CSS_IRQ_INFO_STREAM_TO_MEM_ERROR           = BIT(13),
 	/** the stream-to-memory device has encountered an error */
-	IA_CSS_IRQ_INFO_SW_0                          = 1 << 14,
+	IA_CSS_IRQ_INFO_SW_0                          = BIT(14),
 	/** software interrupt 0 */
-	IA_CSS_IRQ_INFO_SW_1                          = 1 << 15,
+	IA_CSS_IRQ_INFO_SW_1                          = BIT(15),
 	/** software interrupt 1 */
-	IA_CSS_IRQ_INFO_SW_2                          = 1 << 16,
+	IA_CSS_IRQ_INFO_SW_2                          = BIT(16),
 	/** software interrupt 2 */
-	IA_CSS_IRQ_INFO_ISP_BINARY_STATISTICS_READY   = 1 << 17,
+	IA_CSS_IRQ_INFO_ISP_BINARY_STATISTICS_READY   = BIT(17),
 	/** ISP binary statistics are ready */
-	IA_CSS_IRQ_INFO_INPUT_SYSTEM_ERROR            = 1 << 18,
+	IA_CSS_IRQ_INFO_INPUT_SYSTEM_ERROR            = BIT(18),
 	/** the input system in in error */
-	IA_CSS_IRQ_INFO_IF_ERROR                      = 1 << 19,
+	IA_CSS_IRQ_INFO_IF_ERROR                      = BIT(19),
 	/** the input formatter in in error */
-	IA_CSS_IRQ_INFO_DMA_ERROR                     = 1 << 20,
+	IA_CSS_IRQ_INFO_DMA_ERROR                     = BIT(20),
 	/** the dma in in error */
-	IA_CSS_IRQ_INFO_ISYS_EVENTS_READY             = 1 << 21,
+	IA_CSS_IRQ_INFO_ISYS_EVENTS_READY             = BIT(21),
 	/** end-of-frame events are ready in the isys_event queue */
 };
 
@@ -103,23 +104,23 @@ enum ia_css_irq_info {
  * different receiver types, or possibly none in case of tests systems.
  */
 enum ia_css_rx_irq_info {
-	IA_CSS_RX_IRQ_INFO_BUFFER_OVERRUN   = 1U << 0, /** buffer overrun */
-	IA_CSS_RX_IRQ_INFO_ENTER_SLEEP_MODE = 1U << 1, /** entering sleep mode */
-	IA_CSS_RX_IRQ_INFO_EXIT_SLEEP_MODE  = 1U << 2, /** exited sleep mode */
-	IA_CSS_RX_IRQ_INFO_ECC_CORRECTED    = 1U << 3, /** ECC corrected */
-	IA_CSS_RX_IRQ_INFO_ERR_SOT          = 1U << 4,
+	IA_CSS_RX_IRQ_INFO_BUFFER_OVERRUN   = BIT(0), /** buffer overrun */
+	IA_CSS_RX_IRQ_INFO_ENTER_SLEEP_MODE = BIT(1), /** entering sleep mode */
+	IA_CSS_RX_IRQ_INFO_EXIT_SLEEP_MODE  = BIT(2), /** exited sleep mode */
+	IA_CSS_RX_IRQ_INFO_ECC_CORRECTED    = BIT(3), /** ECC corrected */
+	IA_CSS_RX_IRQ_INFO_ERR_SOT          = BIT(4),
 	/** Start of transmission */
-	IA_CSS_RX_IRQ_INFO_ERR_SOT_SYNC     = 1U << 5, /** SOT sync (??) */
-	IA_CSS_RX_IRQ_INFO_ERR_CONTROL      = 1U << 6, /** Control (??) */
-	IA_CSS_RX_IRQ_INFO_ERR_ECC_DOUBLE   = 1U << 7, /** Double ECC */
-	IA_CSS_RX_IRQ_INFO_ERR_CRC          = 1U << 8, /** CRC error */
-	IA_CSS_RX_IRQ_INFO_ERR_UNKNOWN_ID   = 1U << 9, /** Unknown ID */
-	IA_CSS_RX_IRQ_INFO_ERR_FRAME_SYNC   = 1U << 10,/** Frame sync error */
-	IA_CSS_RX_IRQ_INFO_ERR_FRAME_DATA   = 1U << 11,/** Frame data error */
-	IA_CSS_RX_IRQ_INFO_ERR_DATA_TIMEOUT = 1U << 12,/** Timeout occurred */
-	IA_CSS_RX_IRQ_INFO_ERR_UNKNOWN_ESC  = 1U << 13,/** Unknown escape seq. */
-	IA_CSS_RX_IRQ_INFO_ERR_LINE_SYNC    = 1U << 14,/** Line Sync error */
-	IA_CSS_RX_IRQ_INFO_INIT_TIMEOUT     = 1U << 15,
+	IA_CSS_RX_IRQ_INFO_ERR_SOT_SYNC     = BIT(5), /** SOT sync (??) */
+	IA_CSS_RX_IRQ_INFO_ERR_CONTROL      = BIT(6), /** Control (??) */
+	IA_CSS_RX_IRQ_INFO_ERR_ECC_DOUBLE   = BIT(7), /** Double ECC */
+	IA_CSS_RX_IRQ_INFO_ERR_CRC          = BIT(8), /** CRC error */
+	IA_CSS_RX_IRQ_INFO_ERR_UNKNOWN_ID   = BIT(9), /** Unknown ID */
+	IA_CSS_RX_IRQ_INFO_ERR_FRAME_SYNC   = BIT(10),/** Frame sync error */
+	IA_CSS_RX_IRQ_INFO_ERR_FRAME_DATA   = BIT(11),/** Frame data error */
+	IA_CSS_RX_IRQ_INFO_ERR_DATA_TIMEOUT = BIT(12),/** Timeout occurred */
+	IA_CSS_RX_IRQ_INFO_ERR_UNKNOWN_ESC  = BIT(13),/** Unknown escape seq. */
+	IA_CSS_RX_IRQ_INFO_ERR_LINE_SYNC    = BIT(14),/** Line Sync error */
+	IA_CSS_RX_IRQ_INFO_INIT_TIMEOUT     = BIT(15),
 };
 
 /* Interrupt info structure. This structure contains information about an
diff --git a/drivers/staging/media/atomisp/pci/runtime/debug/interface/ia_css_debug.h b/drivers/staging/media/atomisp/pci/runtime/debug/interface/ia_css_debug.h
index e37ef4232c55..fff89e9b4b01 100644
--- a/drivers/staging/media/atomisp/pci/runtime/debug/interface/ia_css_debug.h
+++ b/drivers/staging/media/atomisp/pci/runtime/debug/interface/ia_css_debug.h
@@ -20,6 +20,7 @@
 
 #include <type_support.h>
 #include <linux/stdarg.h>
+#include <linux/bits.h>
 #include "ia_css_types.h"
 #include "ia_css_binary.h"
 #include "ia_css_frame_public.h"
@@ -53,21 +54,21 @@ extern int dbg_level;
  *  Values can be combined to dump a combination of sets.
  */
 enum ia_css_debug_enable_param_dump {
-	IA_CSS_DEBUG_DUMP_FPN = 1 << 0, /** FPN table */
-	IA_CSS_DEBUG_DUMP_OB = 1 << 1,  /** OB table */
-	IA_CSS_DEBUG_DUMP_SC = 1 << 2,  /** Shading table */
-	IA_CSS_DEBUG_DUMP_WB = 1 << 3,  /** White balance */
-	IA_CSS_DEBUG_DUMP_DP = 1 << 4,  /** Defect Pixel */
-	IA_CSS_DEBUG_DUMP_BNR = 1 << 5,  /** Bayer Noise Reductions */
-	IA_CSS_DEBUG_DUMP_S3A = 1 << 6,  /** 3A Statistics */
-	IA_CSS_DEBUG_DUMP_DE = 1 << 7,  /** De Mosaicing */
-	IA_CSS_DEBUG_DUMP_YNR = 1 << 8,  /** Luma Noise Reduction */
-	IA_CSS_DEBUG_DUMP_CSC = 1 << 9,  /** Color Space Conversion */
-	IA_CSS_DEBUG_DUMP_GC = 1 << 10,  /** Gamma Correction */
-	IA_CSS_DEBUG_DUMP_TNR = 1 << 11,  /** Temporal Noise Reduction */
-	IA_CSS_DEBUG_DUMP_ANR = 1 << 12,  /** Advanced Noise Reduction */
-	IA_CSS_DEBUG_DUMP_CE = 1 << 13,  /** Chroma Enhancement */
-	IA_CSS_DEBUG_DUMP_ALL = 1 << 14  /** Dump all device parameters */
+	IA_CSS_DEBUG_DUMP_FPN = BIT(0),  /** FPN table */
+	IA_CSS_DEBUG_DUMP_OB  = BIT(1),  /** OB table */
+	IA_CSS_DEBUG_DUMP_SC  = BIT(2),  /** Shading table */
+	IA_CSS_DEBUG_DUMP_WB  = BIT(3),  /** White balance */
+	IA_CSS_DEBUG_DUMP_DP  = BIT(4),  /** Defect Pixel */
+	IA_CSS_DEBUG_DUMP_BNR = BIT(5),  /** Bayer Noise Reductions */
+	IA_CSS_DEBUG_DUMP_S3A = BIT(6),  /** 3A Statistics */
+	IA_CSS_DEBUG_DUMP_DE  = BIT(7),  /** De Mosaicing */
+	IA_CSS_DEBUG_DUMP_YNR = BIT(8),  /** Luma Noise Reduction */
+	IA_CSS_DEBUG_DUMP_CSC = BIT(9),  /** Color Space Conversion */
+	IA_CSS_DEBUG_DUMP_GC  = BIT(10), /** Gamma Correction */
+	IA_CSS_DEBUG_DUMP_TNR = BIT(11), /** Temporal Noise Reduction */
+	IA_CSS_DEBUG_DUMP_ANR = BIT(12), /** Advanced Noise Reduction */
+	IA_CSS_DEBUG_DUMP_CE  = BIT(13), /** Chroma Enhancement */
+	IA_CSS_DEBUG_DUMP_ALL = BIT(14), /** Dump all device parameters */
 };
 
 #define IA_CSS_ERROR(fmt, ...) \
-- 
2.30.2

