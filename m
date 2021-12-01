Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410B2465459
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhLASAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243996AbhLAR7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:59:49 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51196C061748;
        Wed,  1 Dec 2021 09:56:28 -0800 (PST)
Received: from localhost.localdomain (unknown [IPv6:2a00:c281:1409:4a00:c103:6980:2c3:d021])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B16471F45E46;
        Wed,  1 Dec 2021 17:56:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638381387; bh=L1bus+qTte9RAXpz1G49iePTHzEjFT4J7YFXgGoUrII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AGeiprfpFbT1hNSshqkiD3Cvvzr7gXBaLZv3hBG/E/mc/Oii7psLRQmqQidJfHR+x
         q2duZxFhCpzKvGAnyufQnMHz8xSusPTzV9oW+lXkxUnRhDlHfZJg8Atbs2IoDfki+J
         KZgl8xVQewh7Bpk0KzGtEcShUmyJ6Lau1nfYgT/VPiLkvIoCzVIHkRlvnBn1R2ExZZ
         5N5FbFrM9byxHcl+hWPX7ierOO1tC4a6bUuA7w9LZpCUmpDtQ8YSjrF4xSYukIQEZv
         xiRr1iCOx3h8PdEvu2iA6V3Vg6zqMdCPqRqSz92ttIiPygZ3qslq4KT0tjLizO1j2b
         Qof14PHw8WgNA==
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list),
        laurent.pinchart@ideasonboard.com, hverkuil@xs4all.nl,
        kernel@collabora.com, dafna3@gmail.com,
        kiril.bicevski@collabora.com,
        Nas Chung <nas.chung@chipsnmedia.com>,
        lafley.kim@chipsnmedia.com, scott.woo@chipsnmedia.com,
        olivier.crete@collabora.com, dan.carpenter@oracle.com,
        rdunlap@infradead.org, daniel@0x0f.com
Subject: [PATCH v4 1/6] staging: media: wave5: Add vpuapi layer
Date:   Wed,  1 Dec 2021 19:56:08 +0200
Message-Id: <20211201175613.13710-2-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201175613.13710-1-dafna.hirschfeld@collabora.com>
References: <20211201175613.13710-1-dafna.hirschfeld@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the vpuapi layer of the wave5 codec driver.
This layer is used to configure the hardware according
to the parameters.

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/staging/media/wave5/wave5-hw.c        | 3452 +++++++++++++++++
 drivers/staging/media/wave5/wave5-regdefine.h |  650 ++++
 drivers/staging/media/wave5/wave5-vpuapi.c    | 1053 +++++
 drivers/staging/media/wave5/wave5-vpuapi.h    | 1142 ++++++
 drivers/staging/media/wave5/wave5-vpuconfig.h |   85 +
 drivers/staging/media/wave5/wave5-vpuerror.h  |  455 +++
 drivers/staging/media/wave5/wave5.h           |   82 +
 7 files changed, 6919 insertions(+)
 create mode 100644 drivers/staging/media/wave5/wave5-hw.c
 create mode 100644 drivers/staging/media/wave5/wave5-regdefine.h
 create mode 100644 drivers/staging/media/wave5/wave5-vpuapi.c
 create mode 100644 drivers/staging/media/wave5/wave5-vpuapi.h
 create mode 100644 drivers/staging/media/wave5/wave5-vpuconfig.h
 create mode 100644 drivers/staging/media/wave5/wave5-vpuerror.h
 create mode 100644 drivers/staging/media/wave5/wave5.h

diff --git a/drivers/staging/media/wave5/wave5-hw.c b/drivers/staging/media/wave5/wave5-hw.c
new file mode 100644
index 000000000000..5ebe70e469f4
--- /dev/null
+++ b/drivers/staging/media/wave5/wave5-hw.c
@@ -0,0 +1,3452 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Wave5 series multi-standard codec IP - wave5 backend logic
+ *
+ * Copyright (C) 2021 CHIPS&MEDIA INC
+ */
+
+#include <linux/iopoll.h>
+#include "wave5-vpu.h"
+#include "wave5.h"
+#include "wave5-regdefine.h"
+
+#define FIO_TIMEOUT 10000000
+#define FIO_CTRL_READY		BIT(31)
+#define FIO_CTRL_WRITE		BIT(16)
+
+static void wave5_print_reg_err(struct vpu_device *vpu_dev, u32 reg_fail_reason)
+{
+	char *caller = __builtin_return_address(0);
+	struct device *dev = vpu_dev->dev;
+	u32 reg_val;
+
+	switch (reg_fail_reason) {
+	case WAVE5_SYSERR_QUEUEING_FAIL:
+		reg_val = vpu_read_reg(vpu_dev, W5_RET_QUEUE_FAIL_REASON);
+		dev_dbg(dev, "%s: queueing failure 0x%x\n", caller, reg_val);
+		break;
+	case WAVE5_SYSERR_RESULT_NOT_READY:
+		dev_err(dev, "%s: result not ready 0x%x\n", caller, reg_fail_reason);
+		break;
+	case WAVE5_SYSERR_ACCESS_VIOLATION_HW:
+		dev_err(dev, "%s: access violation 0x%x\n", caller, reg_fail_reason);
+		break;
+	case WAVE5_SYSERR_WATCHDOG_TIMEOUT:
+		dev_err(dev, "%s: watchdog timeout 0x%x\n", caller, reg_fail_reason);
+		break;
+	case WAVE5_SYSERR_BUS_ERROR:
+		dev_err(dev, "%s: bus error 0x%x\n", caller, reg_fail_reason);
+		break;
+	case WAVE5_SYSERR_DOUBLE_FAULT:
+		dev_err(dev, "%s: double fault 0x%x\n", caller, reg_fail_reason);
+		break;
+	case WAVE5_SYSERR_VPU_STILL_RUNNING:
+		dev_err(dev, "%s: still running 0x%x\n", caller, reg_fail_reason);
+		break;
+	case WAVE5_SYSERR_VLC_BUF_FULL:
+		dev_err(dev, "%s: vlc buf full 0x%x\n", caller, reg_fail_reason);
+		break;
+	default:
+		dev_err(dev, "%s: failure: 0x%x\n", caller, reg_fail_reason);
+		break;
+	}
+}
+
+static unsigned int wave5_read_register(struct vpu_device *vpu_dev, unsigned int addr)
+{
+	u32 ctrl;
+	int ret;
+
+	ctrl = addr & 0xffff;
+	wave5_vdi_write_register(vpu_dev, W5_VPU_FIO_CTRL_ADDR, ctrl);
+	ret = read_poll_timeout(wave5_vdi_read_register, ctrl, ctrl & FIO_CTRL_READY,
+				0, FIO_TIMEOUT, false, vpu_dev, W5_VPU_FIO_CTRL_ADDR);
+	if (ret)
+		return 0xffffffff;
+	return wave5_vdi_read_register(vpu_dev, W5_VPU_FIO_DATA);
+}
+
+static void wave5_write_register(struct vpu_device *vpu_dev, unsigned int addr, unsigned int data)
+{
+	unsigned int ctrl;
+
+	wave5_vdi_write_register(vpu_dev, W5_VPU_FIO_DATA, data);
+	ctrl = FIO_CTRL_WRITE | (addr & 0xffff);
+	wave5_vdi_write_register(vpu_dev, W5_VPU_FIO_CTRL_ADDR, ctrl);
+	read_poll_timeout(wave5_vdi_read_register, ctrl, ctrl & FIO_CTRL_READY,
+			  0, FIO_TIMEOUT, false, vpu_dev, W5_VPU_FIO_CTRL_ADDR);
+}
+
+static int wave5_wait_bus_busy(struct vpu_device *vpu_dev, int timeout, unsigned int addr)
+{
+	u32 gdi_status_check_value = 0x3f;
+	u32 data;
+
+	if (vpu_dev->product_code == WAVE521C_CODE ||
+	    vpu_dev->product_code == WAVE521_CODE ||
+	 vpu_dev->product_code == WAVE521E1_CODE)
+		gdi_status_check_value = 0x00ff1f3f;
+
+	return read_poll_timeout(wave5_vdi_read_register, data, data == gdi_status_check_value,
+				 0, timeout * 1000, false, vpu_dev, addr);
+}
+
+static int wave5_wait_vpu_busy(struct vpu_device *vpu_dev, int timeout, unsigned int addr)
+{
+	u32 data;
+
+	return read_poll_timeout(wave5_vdi_read_register, data, data == 0,
+				 0, timeout * 1000, false, vpu_dev, addr);
+}
+
+static int wave5_wait_vcpu_bus_busy(struct vpu_device *vpu_dev, int timeout, unsigned int addr)
+{
+	u32 data;
+
+	return read_poll_timeout(wave5_read_register, data, data == 0,
+				 0, timeout * 1000, false, vpu_dev, addr);
+}
+
+bool wave5_vpu_is_init(struct vpu_device *vpu_dev)
+{
+	return vpu_read_reg(vpu_dev, W5_VCPU_CUR_PC) != 0;
+}
+
+static struct dma_vpu_buf *get_sram_memory(struct vpu_device *vpu_dev)
+{
+	u32 sram_size = 0;
+	u32 val = vpu_read_reg(vpu_dev, W5_PRODUCT_NUMBER);
+
+	if (vpu_dev->sram_buf.size)
+		return &vpu_dev->sram_buf;
+
+	switch (val) {
+	case WAVE511_CODE:
+		/* 10bit profile : 8_kx8_k -> 129024, 4_kx2_k -> 64512 */
+		sram_size = 0x1F800;
+		break;
+	case WAVE517_CODE:
+		/* 10bit profile : 8_kx8_k -> 272384, 4_kx2_k -> 104448 */
+		sram_size = 0x42800;
+		break;
+	case WAVE537_CODE:
+		/* 10bit profile : 8_kx8_k -> 272384, 4_kx2_k -> 104448 */
+		sram_size = 0x42800;
+		break;
+	case WAVE521_CODE:
+		/* 10bit profile : 8_kx8_k -> 126976, 4_kx2_k -> 63488 */
+		sram_size = 0x1F000;
+		break;
+	case WAVE521E1_CODE:
+		/* 10bit profile : 8_kx8_k -> 126976, 4_kx2_k -> 63488 */
+		sram_size = 0x1F000;
+		break;
+	case WAVE521C_CODE:
+		/* 10bit profile : 8_kx8_k -> 129024, 4_kx2_k -> 64512 */
+		sram_size = 0x1F800;
+		break;
+	case WAVE521C_DUAL_CODE:
+		/* 10bit profile : 8_kx8_k -> 129024, 4_kx2_k -> 64512 */
+		sram_size = 0x1F800;
+		break;
+	default:
+		dev_err(vpu_dev->dev, "invalid check product_code(%x)\n", val);
+		break;
+	}
+
+	// if we can know the sram address directly in vdi layer, we use it first for sdram address
+	vpu_dev->sram_buf.daddr = 0;
+	vpu_dev->sram_buf.size = sram_size;
+
+	return &vpu_dev->sram_buf;
+}
+
+int32_t wave_vpu_get_product_id(struct vpu_device *vpu_dev)
+{
+	u32 product_id = PRODUCT_ID_NONE;
+	u32 val;
+
+	val = vpu_read_reg(vpu_dev, W5_PRODUCT_NUMBER);
+
+	switch (val) {
+	case WAVE521_CODE:
+		product_id = PRODUCT_ID_521; break;
+	case WAVE521C_CODE:
+		product_id = PRODUCT_ID_521; break;
+	case WAVE511_CODE:
+		product_id = PRODUCT_ID_511; break;
+	case WAVE521C_DUAL_CODE:
+		product_id = PRODUCT_ID_521; break;
+	case WAVE517_CODE:
+		product_id = PRODUCT_ID_517; break;
+	case WAVE537_CODE:
+		product_id = PRODUCT_ID_517; break;
+	case WAVE521E1_CODE:
+		product_id = PRODUCT_ID_521; break;
+	default:
+		dev_err(vpu_dev->dev, "check product_id(%x)\n", val);
+		break;
+	}
+	return product_id;
+}
+
+void wave5_bit_issue_command(struct vpu_instance *vpu_inst, uint32_t cmd)
+{
+	u32 instance_index = vpu_inst->id;
+	u32 codec_mode = vpu_inst->std;
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_INSTANCE_INFO, (codec_mode << 16) |
+			(instance_index & 0xffff));
+	vpu_write_reg(vpu_inst->dev, W5_VPU_BUSY_STATUS, 1);
+	vpu_write_reg(vpu_inst->dev, W5_COMMAND, cmd);
+
+	dev_dbg(vpu_inst->dev->dev, "cmd=0x%x\n", cmd);
+
+	vpu_write_reg(vpu_inst->dev, W5_VPU_HOST_INT_REQ, 1);
+}
+
+static int wave5_send_query(struct vpu_instance *vpu_inst, enum QUERY_OPT query_opt)
+{
+	int ret;
+
+	vpu_write_reg(vpu_inst->dev, W5_QUERY_OPTION, query_opt);
+	vpu_write_reg(vpu_inst->dev, W5_VPU_BUSY_STATUS, 1);
+	wave5_bit_issue_command(vpu_inst, W5_QUERY);
+
+	ret = wave5_wait_vpu_busy(vpu_inst->dev, VPU_BUSY_CHECK_TIMEOUT, W5_VPU_BUSY_STATUS);
+	if (ret) {
+		dev_warn(vpu_inst->dev->dev, "query timed out. opt=0x%x\n", query_opt);
+		return ret;
+	}
+
+	if (!vpu_read_reg(vpu_inst->dev, W5_RET_SUCCESS))
+		return -EIO;
+
+	return 0;
+}
+
+static int setup_wave5_properties(struct device *dev)
+{
+	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
+	struct vpu_attr *p_attr = &vpu_dev->attr;
+	u32 reg_val;
+	u8 *str;
+	int ret;
+	u32 hw_config_def0, hw_config_def1, hw_config_feature, hw_config_rev;
+
+	vpu_write_reg(vpu_dev, W5_QUERY_OPTION, GET_VPU_INFO);
+	vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
+	vpu_write_reg(vpu_dev, W5_COMMAND, W5_QUERY);
+	vpu_write_reg(vpu_dev, W5_VPU_HOST_INT_REQ, 1);
+	ret = wave5_wait_vpu_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT, W5_VPU_BUSY_STATUS);
+	if (ret)
+		return ret;
+
+	if (!vpu_read_reg(vpu_dev, W5_RET_SUCCESS))
+		return -EIO;
+
+	reg_val = vpu_read_reg(vpu_dev, W5_RET_PRODUCT_NAME);
+	str = (u8 *)&reg_val;
+	p_attr->product_name[0] = str[3];
+	p_attr->product_name[1] = str[2];
+	p_attr->product_name[2] = str[1];
+	p_attr->product_name[3] = str[0];
+	p_attr->product_name[4] = 0;
+
+	p_attr->product_id = wave_vpu_get_product_id(vpu_dev);
+	p_attr->product_version = vpu_read_reg(vpu_dev, W5_RET_PRODUCT_VERSION);
+	p_attr->fw_version = vpu_read_reg(vpu_dev, W5_RET_FW_VERSION);
+	p_attr->customer_id = vpu_read_reg(vpu_dev, W5_RET_CUSTOMER_ID);
+	hw_config_def0 = vpu_read_reg(vpu_dev, W5_RET_STD_DEF0);
+	hw_config_def1 = vpu_read_reg(vpu_dev, W5_RET_STD_DEF1);
+	hw_config_feature = vpu_read_reg(vpu_dev, W5_RET_CONF_FEATURE);
+	hw_config_rev = vpu_read_reg(vpu_dev, W5_RET_CONF_REVISION);
+
+	p_attr->support_hevc10bit_enc = (hw_config_feature >> 3) & 1;
+	if (hw_config_rev > 167455) //20190321
+		p_attr->support_avc10bit_enc = (hw_config_feature >> 11) & 1;
+	else
+		p_attr->support_avc10bit_enc = p_attr->support_hevc10bit_enc;
+
+	p_attr->support_decoders = 0;
+	p_attr->support_encoders = 0;
+	if (p_attr->product_id == PRODUCT_ID_521) {
+		p_attr->support_dual_core = ((hw_config_def1 >> 26) & 0x01);
+		if (p_attr->support_dual_core || hw_config_rev < 206116) {
+			p_attr->support_decoders = BIT(STD_AVC);
+			p_attr->support_decoders |= BIT(STD_HEVC);
+			p_attr->support_encoders = BIT(STD_AVC);
+			p_attr->support_encoders |= BIT(STD_HEVC);
+		} else {
+			p_attr->support_decoders |= (((hw_config_def1 >> 3) & 0x01) << STD_AVC);
+			p_attr->support_decoders |= (((hw_config_def1 >> 2) & 0x01) << STD_HEVC);
+			p_attr->support_encoders = (((hw_config_def1 >> 1) & 0x01) << STD_AVC);
+			p_attr->support_encoders |= (((hw_config_def1 >> 0) & 0x01) << STD_HEVC);
+		}
+	} else if (p_attr->product_id == PRODUCT_ID_511) {
+		p_attr->support_decoders = BIT(STD_HEVC);
+		p_attr->support_decoders |= BIT(STD_AVC);
+	} else if (p_attr->product_id == PRODUCT_ID_517) {
+		p_attr->support_decoders = (((hw_config_def1 >> 4) & 0x01) << STD_AV1);
+		p_attr->support_decoders |= (((hw_config_def1 >> 3) & 0x01) << STD_AVS2);
+		p_attr->support_decoders |= (((hw_config_def1 >> 2) & 0x01) << STD_AVC);
+		p_attr->support_decoders |= (((hw_config_def1 >> 1) & 0x01) << STD_VP9);
+		p_attr->support_decoders |= (((hw_config_def1 >> 0) & 0x01) << STD_HEVC);
+	}
+
+	p_attr->support_backbone = (hw_config_def0 >> 16) & 0x01;
+	p_attr->support_vcpu_backbone = (hw_config_def0 >> 28) & 0x01;
+	p_attr->support_vcore_backbone = (hw_config_def0 >> 22) & 0x01;
+	p_attr->support_dual_core = (hw_config_def1 >> 26) & 0x01;
+	p_attr->support_endian_mask = BIT(VDI_LITTLE_ENDIAN) |
+				      BIT(VDI_BIG_ENDIAN) |
+				      BIT(VDI_32BIT_LITTLE_ENDIAN) |
+				      BIT(VDI_32BIT_BIG_ENDIAN) |
+				      (0xffffUL << 16);
+	p_attr->support_bitstream_mode = BIT(BS_MODE_INTERRUPT) |
+		BIT(BS_MODE_PIC_END);
+
+	return 0;
+}
+
+int wave5_vpu_get_version(struct vpu_device *vpu_dev, uint32_t *version_info,
+			  uint32_t *revision)
+{
+	u32 reg_val;
+	int ret;
+
+	vpu_write_reg(vpu_dev, W5_QUERY_OPTION, GET_VPU_INFO);
+	vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
+	vpu_write_reg(vpu_dev, W5_COMMAND, W5_QUERY);
+	vpu_write_reg(vpu_dev, W5_VPU_HOST_INT_REQ, 1);
+	ret = wave5_wait_vpu_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT, W5_VPU_BUSY_STATUS);
+	if (ret) {
+		dev_err(vpu_dev->dev, "%s: timeout\n", __func__);
+		return ret;
+	}
+
+	if (!vpu_read_reg(vpu_dev, W5_RET_SUCCESS)) {
+		dev_err(vpu_dev->dev, "%s: failed\n", __func__);
+		return -EIO;
+	}
+
+	reg_val = vpu_read_reg(vpu_dev, W5_RET_FW_VERSION);
+	if (version_info)
+		*version_info = 0;
+	if (revision)
+		*revision = reg_val;
+
+	return 0;
+}
+
+int wave5_vpu_init(struct device *dev, u8 *firmware, uint32_t size)
+{
+	struct vpu_buf *common_vb;
+	struct dma_vpu_buf *sram_vb;
+	dma_addr_t code_base, temp_base;
+	u32 code_size, temp_size;
+	u32 i, reg_val, remap_size;
+	int ret;
+	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
+
+	common_vb = &vpu_dev->common_mem;
+
+	code_base = common_vb->daddr;
+	/* ALIGN TO 4KB */
+	code_size = (WAVE5_MAX_CODE_BUF_SIZE & ~0xfff);
+	if (code_size < size * 2)
+		return -EINVAL;
+
+	temp_base = common_vb->daddr + WAVE5_TEMPBUF_OFFSET;
+	temp_size = WAVE5_TEMPBUF_SIZE;
+
+	wave5_vdi_write_memory(vpu_dev, common_vb, 0, firmware, size, VDI_128BIT_LITTLE_ENDIAN);
+
+	vpu_write_reg(vpu_dev, W5_PO_CONF, 0);
+
+	/* clear registers */
+
+	for (i = W5_CMD_REG_BASE; i < W5_CMD_REG_END; i += 4)
+		vpu_write_reg(vpu_dev, i, 0x00);
+
+	/* remap page size 0*/
+	remap_size = (W5_REMAP_MAX_SIZE >> 12) & 0x1ff;
+	reg_val = 0x80000000 | (WAVE5_UPPER_PROC_AXI_ID << 20) | (0 << 16)
+		| (W5_REMAP_INDEX0 << 12) | BIT(11) | remap_size;
+	vpu_write_reg(vpu_dev, W5_VPU_REMAP_CTRL, reg_val);
+	vpu_write_reg(vpu_dev, W5_VPU_REMAP_VADDR, W5_REMAP_INDEX0 * W5_REMAP_MAX_SIZE);
+	vpu_write_reg(vpu_dev, W5_VPU_REMAP_PADDR, code_base + W5_REMAP_INDEX0 * W5_REMAP_MAX_SIZE);
+
+	/* remap page size 1*/
+	remap_size = (W5_REMAP_MAX_SIZE >> 12) & 0x1ff;
+	reg_val = 0x80000000 | (WAVE5_UPPER_PROC_AXI_ID << 20) | (0 << 16)
+		| (W5_REMAP_INDEX1 << 12) | BIT(11) | remap_size;
+	vpu_write_reg(vpu_dev, W5_VPU_REMAP_CTRL, reg_val);
+	vpu_write_reg(vpu_dev, W5_VPU_REMAP_VADDR, W5_REMAP_INDEX1 * W5_REMAP_MAX_SIZE);
+	vpu_write_reg(vpu_dev, W5_VPU_REMAP_PADDR, code_base + W5_REMAP_INDEX1 * W5_REMAP_MAX_SIZE);
+
+	vpu_write_reg(vpu_dev, W5_ADDR_CODE_BASE, code_base);
+	vpu_write_reg(vpu_dev, W5_CODE_SIZE, code_size);
+	vpu_write_reg(vpu_dev, W5_CODE_PARAM, (WAVE5_UPPER_PROC_AXI_ID << 4) | 0);
+	vpu_write_reg(vpu_dev, W5_ADDR_TEMP_BASE, temp_base);
+	vpu_write_reg(vpu_dev, W5_TEMP_SIZE, temp_size);
+
+	vpu_write_reg(vpu_dev, W5_HW_OPTION, 0);
+
+	/* interrupt */
+	// encoder
+	reg_val = BIT(INT_WAVE5_ENC_SET_PARAM);
+	reg_val |= BIT(INT_WAVE5_ENC_PIC);
+	reg_val |= BIT(INT_WAVE5_BSBUF_FULL);
+	// decoder
+	reg_val |= BIT(INT_WAVE5_INIT_SEQ);
+	reg_val |= BIT(INT_WAVE5_DEC_PIC);
+	reg_val |= BIT(INT_WAVE5_BSBUF_EMPTY);
+	vpu_write_reg(vpu_dev, W5_VPU_VINT_ENABLE, reg_val);
+
+	reg_val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
+	if ((reg_val >> 16) & 1) {
+		reg_val = ((WAVE5_PROC_AXI_ID << 28) |
+			   (WAVE5_PRP_AXI_ID << 24) |
+			   (WAVE5_FBD_Y_AXI_ID << 20) |
+			   (WAVE5_FBC_Y_AXI_ID << 16) |
+			   (WAVE5_FBD_C_AXI_ID << 12) |
+			   (WAVE5_FBC_C_AXI_ID << 8) |
+			   (WAVE5_PRI_AXI_ID << 4) |
+			   (WAVE5_SEC_AXI_ID << 0));
+		wave5_write_register(vpu_dev, W5_BACKBONE_PROG_AXI_ID, reg_val);
+	}
+
+	sram_vb = get_sram_memory(vpu_dev);
+
+	vpu_write_reg(vpu_dev, W5_ADDR_SEC_AXI, sram_vb->daddr);
+	vpu_write_reg(vpu_dev, W5_SEC_AXI_SIZE, sram_vb->size);
+	vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
+	vpu_write_reg(vpu_dev, W5_COMMAND, W5_INIT_VPU);
+	vpu_write_reg(vpu_dev, W5_VPU_REMAP_CORE_START, 1);
+	ret = wave5_wait_vpu_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT, W5_VPU_BUSY_STATUS);
+	if (ret) {
+		dev_err(vpu_dev->dev, "VPU init(W5_VPU_REMAP_CORE_START) timeout\n");
+		return ret;
+	}
+
+	reg_val = vpu_read_reg(vpu_dev, W5_RET_SUCCESS);
+	if (!reg_val) {
+		u32 reason_code = vpu_read_reg(vpu_dev, W5_RET_FAIL_REASON);
+
+		wave5_print_reg_err(vpu_dev, reason_code);
+		return -EIO;
+	}
+
+	return setup_wave5_properties(dev);
+}
+
+int wave5_vpu_build_up_dec_param(struct vpu_instance *vpu_inst,
+				 struct dec_open_param *param)
+{
+	int ret;
+	struct dec_info *p_dec_info = &vpu_inst->codec_info->dec_info;
+	u32 bs_endian;
+	struct dma_vpu_buf *sram_vb;
+	struct vpu_device *vpu_dev = vpu_inst->dev;
+
+	switch (vpu_inst->std) {
+	case W_HEVC_DEC:
+		p_dec_info->seq_change_mask = SEQ_CHANGE_ENABLE_ALL_HEVC;
+		break;
+	case W_VP9_DEC:
+		p_dec_info->seq_change_mask = SEQ_CHANGE_ENABLE_ALL_VP9;
+		break;
+	case W_AVS2_DEC:
+		p_dec_info->seq_change_mask = SEQ_CHANGE_ENABLE_ALL_AVS2;
+		break;
+	case W_AVC_DEC:
+		p_dec_info->seq_change_mask = SEQ_CHANGE_ENABLE_ALL_AVC;
+		break;
+	case W_AV1_DEC:
+		p_dec_info->seq_change_mask = SEQ_CHANGE_ENABLE_ALL_AV1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (vpu_dev->product == PRODUCT_ID_517)
+		p_dec_info->vb_work.size = WAVE517_WORKBUF_SIZE;
+	else if (vpu_dev->product == PRODUCT_ID_521)
+		p_dec_info->vb_work.size = WAVE521DEC_WORKBUF_SIZE;
+	else if (vpu_dev->product == PRODUCT_ID_511)
+		p_dec_info->vb_work.size = WAVE521DEC_WORKBUF_SIZE;
+
+	ret = wave5_vdi_allocate_dma_memory(vpu_inst->dev, &p_dec_info->vb_work);
+	if (ret)
+		return ret;
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_DEC_VCORE_INFO, 1);
+
+	sram_vb = get_sram_memory(vpu_inst->dev);
+	p_dec_info->sec_axi_info.buf_base = sram_vb->daddr;
+	p_dec_info->sec_axi_info.buf_size = sram_vb->size;
+
+	wave5_vdi_clear_memory(vpu_inst->dev, &p_dec_info->vb_work);
+
+	vpu_write_reg(vpu_inst->dev, W5_ADDR_WORK_BASE, p_dec_info->vb_work.daddr);
+	vpu_write_reg(vpu_inst->dev, W5_WORK_SIZE, p_dec_info->vb_work.size);
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_DEC_BS_START_ADDR, p_dec_info->stream_buf_start_addr);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_DEC_BS_SIZE, p_dec_info->stream_buf_size);
+
+	/* NOTE: when endian mode is 0, SDMA reads MSB first */
+	bs_endian = wave5_vdi_convert_endian(vpu_inst->dev, param->stream_endian);
+	bs_endian = (~bs_endian & VDI_128BIT_ENDIAN_MASK);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_BS_PARAM, bs_endian);
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_NUM_CQ_DEPTH_M1, (COMMAND_QUEUE_DEPTH - 1));
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ERR_CONCEAL, (param->error_conceal_unit << 2) |
+			(param->error_conceal_mode));
+
+	wave5_bit_issue_command(vpu_inst, W5_CREATE_INSTANCE);
+	// check QUEUE_DONE
+	ret = wave5_wait_vpu_busy(vpu_inst->dev, VPU_BUSY_CHECK_TIMEOUT, W5_VPU_BUSY_STATUS);
+	if (ret) {
+		dev_warn(vpu_inst->dev->dev, "create instance timed out\n");
+		goto free_vb_work;
+	}
+
+	if (!vpu_read_reg(vpu_inst->dev, W5_RET_SUCCESS)) { // failed adding into VCPU QUEUE
+		ret = -EIO;
+		goto free_vb_work;
+	}
+
+	p_dec_info->product_code = vpu_read_reg(vpu_inst->dev, W5_PRODUCT_NUMBER);
+
+	return 0;
+free_vb_work:
+	wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_work);
+	return ret;
+}
+
+int wave5_vpu_dec_init_seq(struct vpu_instance *vpu_inst)
+{
+	struct dec_info *p_dec_info = &vpu_inst->codec_info->dec_info;
+	u32 cmd_option = INIT_SEQ_NORMAL, bs_option;
+	u32 reg_val;
+	int ret;
+
+	if (!vpu_inst->codec_info)
+		return -EINVAL;
+
+	if (p_dec_info->thumbnail_mode)
+		cmd_option = INIT_SEQ_W_THUMBNAIL;
+
+	/* set attributes of bitstream buffer controller */
+	bs_option = 0;
+	switch (p_dec_info->open_param.bitstream_mode) {
+	case BS_MODE_INTERRUPT:
+		if (p_dec_info->seq_init_escape)
+			bs_option = BSOPTION_ENABLE_EXPLICIT_END;
+		break;
+	case BS_MODE_PIC_END:
+		bs_option = BSOPTION_ENABLE_EXPLICIT_END;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	vpu_write_reg(vpu_inst->dev, W5_BS_RD_PTR, p_dec_info->stream_rd_ptr);
+	vpu_write_reg(vpu_inst->dev, W5_BS_WR_PTR, p_dec_info->stream_wr_ptr);
+
+	if (p_dec_info->stream_endflag == 1)
+		bs_option = 3;
+	if (vpu_inst->std == W_AV1_DEC)
+		bs_option |= ((p_dec_info->open_param.av1_format) << 2);
+	vpu_write_reg(vpu_inst->dev, W5_BS_OPTION, BIT(31) | bs_option);
+
+	vpu_write_reg(vpu_inst->dev, W5_COMMAND_OPTION, cmd_option);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_DEC_USER_MASK, p_dec_info->user_data_enable);
+
+	wave5_bit_issue_command(vpu_inst, W5_INIT_SEQ);
+
+	// check QUEUE_DONE
+	ret = wave5_wait_vpu_busy(vpu_inst->dev, VPU_BUSY_CHECK_TIMEOUT, W5_VPU_BUSY_STATUS);
+	if (ret) {
+		dev_warn(vpu_inst->dev->dev, "init seq timed out\n");
+		return ret;
+	}
+
+	reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_QUEUE_STATUS);
+
+	p_dec_info->instance_queue_count = (reg_val >> 16) & 0xff;
+	p_dec_info->report_queue_count = (reg_val & 0xffff);
+
+	// FAILED for adding a command into VCPU QUEUE
+	if (!vpu_read_reg(vpu_inst->dev, W5_RET_SUCCESS)) {
+		reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_FAIL_REASON);
+		wave5_print_reg_err(vpu_inst->dev, reg_val);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void wave5_get_dec_seq_result(struct vpu_instance *vpu_inst, struct dec_initial_info *info)
+{
+	u32 reg_val, sub_layer_info;
+	u32 profile_compatibility_flag;
+	u32 left, right, top, bottom;
+	u32 output_bit_depth_minus8;
+	struct dec_info *p_dec_info = &vpu_inst->codec_info->dec_info;
+
+	p_dec_info->stream_rd_ptr = wave5_vpu_dec_get_rd_ptr(vpu_inst);
+	info->rd_ptr = p_dec_info->stream_rd_ptr;
+
+	p_dec_info->frame_display_flag = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_DISP_IDC);
+
+	reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_PIC_SIZE);
+	info->pic_width = ((reg_val >> 16) & 0xffff);
+	info->pic_height = (reg_val & 0xffff);
+	info->min_frame_buffer_count = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_NUM_REQUIRED_FB);
+	info->frame_buf_delay = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_NUM_REORDER_DELAY);
+
+	reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_CROP_LEFT_RIGHT);
+	left = (reg_val >> 16) & 0xffff;
+	right = reg_val & 0xffff;
+	reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_CROP_TOP_BOTTOM);
+	top = (reg_val >> 16) & 0xffff;
+	bottom = reg_val & 0xffff;
+
+	info->pic_crop_rect.left = left;
+	info->pic_crop_rect.right = info->pic_width - right;
+	info->pic_crop_rect.top = top;
+	info->pic_crop_rect.bottom = info->pic_height - bottom;
+
+	info->f_rate_numerator = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_FRAME_RATE_NR);
+	info->f_rate_denominator = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_FRAME_RATE_DR);
+
+	reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_COLOR_SAMPLE_INFO);
+	info->luma_bitdepth = (reg_val >> 0) & 0x0f;
+	info->chroma_bitdepth = (reg_val >> 4) & 0x0f;
+	info->chroma_format_idc = (reg_val >> 8) & 0x0f;
+	info->aspect_rate_info = (reg_val >> 16) & 0xff;
+	info->is_ext_sar = (info->aspect_rate_info == 255 ? true : false);
+	/* [0:15] - vertical size, [16:31] - horizontal size */
+	if (info->is_ext_sar)
+		info->aspect_rate_info = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_ASPECT_RATIO);
+	info->bit_rate = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_BIT_RATE);
+
+	sub_layer_info = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_SUB_LAYER_INFO);
+	info->max_temporal_layers = (sub_layer_info >> 8) & 0x7;
+
+	reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_SEQ_PARAM);
+	info->level = reg_val & 0xff;
+	profile_compatibility_flag = (reg_val >> 12) & 0xff;
+	info->profile = (reg_val >> 24) & 0x1f;
+	info->tier = (reg_val >> 29) & 0x01;
+	output_bit_depth_minus8 = (reg_val >> 30) & 0x03;
+
+	if (vpu_inst->std == W_HEVC_DEC) {
+		/* guessing profile */
+		if (!info->profile) {
+			if ((profile_compatibility_flag & 0x06) == 0x06)
+				info->profile = HEVC_PROFILE_MAIN; /* main profile */
+			else if ((profile_compatibility_flag & 0x04) == 0x04)
+				info->profile = HEVC_PROFILE_MAIN10; /* main10 profile */
+			else if ((profile_compatibility_flag & 0x08) == 0x08)
+				/* main still picture profile */
+				info->profile = HEVC_PROFILE_STILLPICTURE;
+			else
+				info->profile = HEVC_PROFILE_MAIN; /* for old version HM */
+		}
+
+	} else if (vpu_inst->std == W_AVS2_DEC) {
+		if (info->luma_bitdepth == 10 && output_bit_depth_minus8 == 2)
+			info->output_bit_depth = 10;
+		else
+			info->output_bit_depth = 8;
+
+	} else if (vpu_inst->std == W_AVC_DEC) {
+		info->profile = (reg_val >> 24) & 0x7f;
+	} else if (vpu_inst->std == W_AV1_DEC) {
+		info->max_spatial_layers = (sub_layer_info >> 24) & 0x3;
+	}
+
+	info->vlc_buf_size = vpu_read_reg(vpu_inst->dev, W5_RET_VLC_BUF_SIZE);
+	info->param_buf_size = vpu_read_reg(vpu_inst->dev, W5_RET_PARAM_BUF_SIZE);
+	p_dec_info->vlc_buf_size = info->vlc_buf_size;
+	p_dec_info->param_buf_size = info->param_buf_size;
+}
+
+int wave5_vpu_dec_get_seq_info(struct vpu_instance *vpu_inst, struct dec_initial_info *info)
+{
+	int ret;
+	u32 reg_val;
+	struct dec_info *p_dec_info = &vpu_inst->codec_info->dec_info;
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_DEC_ADDR_REPORT_BASE, p_dec_info->user_data_buf_addr);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_DEC_REPORT_SIZE, p_dec_info->user_data_buf_size);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_DEC_REPORT_PARAM,
+		      VPU_USER_DATA_ENDIAN & VDI_128BIT_ENDIAN_MASK);
+
+	// send QUERY cmd
+	ret = wave5_send_query(vpu_inst, GET_RESULT);
+	if (ret) {
+		if (ret == -EIO) {
+			reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_FAIL_REASON);
+			wave5_print_reg_err(vpu_inst->dev, reg_val);
+		}
+		return ret;
+	}
+
+	dev_dbg(vpu_inst->dev->dev, "init seq complete\n");
+
+	reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_QUEUE_STATUS);
+
+	p_dec_info->instance_queue_count = (reg_val >> 16) & 0xff;
+	p_dec_info->report_queue_count = (reg_val & 0xffff);
+
+	/* this is not a fatal error, set ret to -EIO but don't return immediately */
+	if (vpu_read_reg(vpu_inst->dev, W5_RET_DEC_DECODING_SUCCESS) != 1) {
+		info->seq_init_err_reason = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_ERR_INFO);
+		ret = -EIO;
+	} else {
+		info->warn_info = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_WARN_INFO);
+	}
+
+	// get sequence info
+	info->user_data_size = 0;
+	info->user_data_buf_full = false;
+	info->user_data_header = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_USERDATA_IDC);
+	if (info->user_data_header) {
+		if (info->user_data_header & BIT(USERDATA_FLAG_BUFF_FULL))
+			info->user_data_buf_full = true;
+		info->user_data_size = p_dec_info->user_data_buf_size;
+	}
+
+	wave5_get_dec_seq_result(vpu_inst, info);
+
+	return ret;
+}
+
+int wave5_vpu_dec_register_framebuffer(struct vpu_instance *vpu_inst, struct frame_buffer *fb_arr,
+				       enum tiled_map_type map_type, uint32_t count)
+{
+	int ret;
+	struct dec_info *p_dec_info = &vpu_inst->codec_info->dec_info;
+	size_t remain, idx, j, i, cnt_8_chunk;
+	u32 start_no, end_no;
+	u32 reg_val, cbcr_interleave, nv21, pic_size;
+	u32 endian, yuv_format;
+	u32 addr_y, addr_cb, addr_cr;
+	u32 mv_col_size, fbc_y_tbl_size, fbc_c_tbl_size;
+	struct vpu_buf vb_buf;
+	u32 color_format = 0;
+	u32 init_pic_width = 0, init_pic_height = 0;
+	u32 pixel_order = 1;
+	u32 bwb_flag = (map_type == LINEAR_FRAME_MAP) ? 1 : 0;
+
+	cbcr_interleave = p_dec_info->open_param.cbcr_interleave;
+	nv21 = p_dec_info->open_param.nv21;
+	mv_col_size = 0;
+	fbc_y_tbl_size = 0;
+	fbc_c_tbl_size = 0;
+
+	init_pic_width = p_dec_info->initial_info.pic_width;
+	init_pic_height = p_dec_info->initial_info.pic_height;
+
+	if (map_type >= COMPRESSED_FRAME_MAP) {
+		cbcr_interleave = 0;
+		nv21 = 0;
+
+		switch (vpu_inst->std) {
+		case W_HEVC_DEC:
+			mv_col_size = WAVE5_DEC_HEVC_BUF_SIZE(init_pic_width, init_pic_height);
+			break;
+		case W_VP9_DEC:
+			mv_col_size = WAVE5_DEC_VP9_BUF_SIZE(init_pic_width, init_pic_height);
+			break;
+		case W_AVS2_DEC:
+			mv_col_size = WAVE5_DEC_AVS2_BUF_SIZE(init_pic_width, init_pic_height);
+			break;
+		case W_AVC_DEC:
+			mv_col_size = WAVE5_DEC_AVC_BUF_SIZE(init_pic_width, init_pic_height);
+			break;
+		case W_AV1_DEC:
+			mv_col_size = WAVE5_DEC_AV1_BUF_SZ_1(init_pic_width, init_pic_height) +
+				WAVE5_DEC_AV1_BUF_SZ_2(init_pic_width, init_pic_width,
+						       init_pic_height);
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		mv_col_size = ALIGN(mv_col_size, 16);
+		vb_buf.daddr = 0;
+		if (vpu_inst->std == W_HEVC_DEC || vpu_inst->std == W_AVS2_DEC || vpu_inst->std ==
+				W_VP9_DEC || vpu_inst->std == W_AVC_DEC || vpu_inst->std ==
+				W_AV1_DEC) {
+			/* 4096 is a margin */
+			vb_buf.size = ALIGN(mv_col_size, 4096) + 4096;
+
+			for (i = 0 ; i < count ; i++) {
+				if (p_dec_info->vb_mv[i].size == 0) {
+					ret = wave5_vdi_allocate_dma_memory(vpu_inst->dev, &vb_buf);
+					if (ret)
+						return ret;
+					p_dec_info->vb_mv[i] = vb_buf;
+				}
+			}
+		}
+
+		if (p_dec_info->product_code == WAVE521C_DUAL_CODE) {
+			u32 bgs_width = (p_dec_info->initial_info.luma_bitdepth > 8 ? 256 :
+					512);
+			u32 ot_bg_width = 1024;
+			u32 frm_width = ALIGN(init_pic_width, 16);
+			u32 frm_height = ALIGN(init_pic_height, 16);
+			// valid_width = align(width, 16),
+			// comp_frm_width = align(valid_width+pad_x, 16)
+			u32 comp_frm_width = ALIGN(ALIGN(frm_width, 16) + 16, 16);
+			// 1024 = offset table BG width
+			u32 ot_frm_width = ALIGN(comp_frm_width, ot_bg_width);
+
+			// sizeof_offset_table()
+			u32 ot_bg_height = 32;
+			u32 bgs_height = BIT(14) / bgs_width /
+				(p_dec_info->initial_info.luma_bitdepth > 8 ? 2 : 1);
+			u32 comp_frm_height = ALIGN(ALIGN(frm_height, 4) + 4, bgs_height);
+			u32 ot_frm_height = ALIGN(comp_frm_height, ot_bg_height);
+
+			fbc_y_tbl_size = (ot_frm_width / 16) * (ot_frm_height / 4) * 2;
+		} else {
+			switch (vpu_inst->std) {
+			case W_HEVC_DEC:
+				fbc_y_tbl_size = WAVE5_FBC_LUMA_TABLE_SIZE(init_pic_width,
+									   init_pic_height);
+				break;
+			case W_VP9_DEC:
+				fbc_y_tbl_size =
+					WAVE5_FBC_LUMA_TABLE_SIZE(ALIGN(init_pic_width, 64),
+								  ALIGN(init_pic_height, 64));
+				break;
+			case W_AVS2_DEC:
+				fbc_y_tbl_size = WAVE5_FBC_LUMA_TABLE_SIZE(init_pic_width,
+									   init_pic_height);
+				break;
+			case W_AVC_DEC:
+				fbc_y_tbl_size = WAVE5_FBC_LUMA_TABLE_SIZE(init_pic_width,
+									   init_pic_height);
+				break;
+			case W_AV1_DEC:
+				fbc_y_tbl_size =
+					WAVE5_FBC_LUMA_TABLE_SIZE(ALIGN(init_pic_width, 16),
+								  ALIGN(init_pic_height, 8));
+				break;
+			default:
+				return -EINVAL;
+			}
+			fbc_y_tbl_size = ALIGN(fbc_y_tbl_size, 16);
+		}
+
+		vb_buf.daddr = 0;
+		vb_buf.size = ALIGN(fbc_y_tbl_size, 4096) + 4096;
+		for (i = 0 ; i < count ; i++) {
+			if (p_dec_info->vb_fbc_y_tbl[i].size == 0) {
+				ret = wave5_vdi_allocate_dma_memory(vpu_inst->dev, &vb_buf);
+				if (ret)
+					return ret;
+				p_dec_info->vb_fbc_y_tbl[i] = vb_buf;
+			}
+		}
+
+		if (p_dec_info->product_code == WAVE521C_DUAL_CODE) {
+			u32 bgs_width = (p_dec_info->initial_info.chroma_bitdepth > 8 ? 256 : 512);
+			u32 ot_bg_width = 1024;
+			u32 frm_width = ALIGN(init_pic_width, 16);
+			u32 frm_height = ALIGN(init_pic_height, 16);
+			u32 comp_frm_width = ALIGN(ALIGN(frm_width / 2, 16) + 16, 16);
+			// valid_width = align(width, 16),
+			// comp_frm_width = align(valid_width+pad_x, 16)
+			// 1024 = offset table BG width
+			u32 ot_frm_width = ALIGN(comp_frm_width, ot_bg_width);
+
+			// sizeof_offset_table()
+			u32 ot_bg_height = 32;
+			u32 bgs_height = BIT(14) / bgs_width /
+				(p_dec_info->initial_info.chroma_bitdepth > 8 ? 2 : 1);
+			u32 comp_frm_height = ALIGN(ALIGN(frm_height, 4) + 4, bgs_height);
+			u32 ot_frm_height = ALIGN(comp_frm_height, ot_bg_height);
+
+			fbc_c_tbl_size = (ot_frm_width / 16) * (ot_frm_height / 4) * 2;
+		} else {
+			switch (vpu_inst->std) {
+			case W_HEVC_DEC:
+				fbc_c_tbl_size = WAVE5_FBC_CHROMA_TABLE_SIZE(init_pic_width,
+									     init_pic_height);
+				break;
+			case W_VP9_DEC:
+				fbc_c_tbl_size =
+					WAVE5_FBC_CHROMA_TABLE_SIZE(ALIGN(init_pic_width, 64),
+								    ALIGN(init_pic_height, 64));
+				break;
+			case W_AVS2_DEC:
+				fbc_c_tbl_size = WAVE5_FBC_CHROMA_TABLE_SIZE(init_pic_width,
+									     init_pic_height);
+				break;
+			case W_AVC_DEC:
+				fbc_c_tbl_size = WAVE5_FBC_CHROMA_TABLE_SIZE(init_pic_width,
+									     init_pic_height);
+				break;
+			case W_AV1_DEC:
+				fbc_c_tbl_size =
+					WAVE5_FBC_CHROMA_TABLE_SIZE(ALIGN(init_pic_width, 16),
+								    ALIGN(init_pic_height, 8));
+				break;
+			default:
+				return -EINVAL;
+			}
+			fbc_c_tbl_size = ALIGN(fbc_c_tbl_size, 16);
+		}
+
+		vb_buf.daddr = 0;
+		vb_buf.size = ALIGN(fbc_c_tbl_size, 4096) + 4096;
+		for (i = 0 ; i < count ; i++) {
+			if (p_dec_info->vb_fbc_c_tbl[i].size == 0) {
+				ret = wave5_vdi_allocate_dma_memory(vpu_inst->dev, &vb_buf);
+				if (ret)
+					return ret;
+				p_dec_info->vb_fbc_c_tbl[i] = vb_buf;
+			}
+		}
+		pic_size = (init_pic_width << 16) | (init_pic_height);
+
+		// allocate task_buffer
+		vb_buf.size = (p_dec_info->vlc_buf_size * VLC_BUF_NUM) +
+				(p_dec_info->param_buf_size * COMMAND_QUEUE_DEPTH);
+		vb_buf.daddr = 0;
+		ret = wave5_vdi_allocate_dma_memory(vpu_inst->dev, &vb_buf);
+		if (ret)
+			return ret;
+
+		p_dec_info->vb_task = vb_buf;
+
+		vpu_write_reg(vpu_inst->dev, W5_CMD_SET_FB_ADDR_TASK_BUF,
+			      p_dec_info->vb_task.daddr);
+		vpu_write_reg(vpu_inst->dev, W5_CMD_SET_FB_TASK_BUF_SIZE, vb_buf.size);
+	} else {
+		pic_size = (init_pic_width << 16) | (init_pic_height);
+	}
+	endian = wave5_vdi_convert_endian(vpu_inst->dev, fb_arr[0].endian);
+	vpu_write_reg(vpu_inst->dev, W5_PIC_SIZE, pic_size);
+
+	yuv_format = 0;
+	color_format = 0;
+
+	reg_val =
+		(bwb_flag << 28) |
+		(pixel_order << 23) | /* PIXEL ORDER in 128bit. first pixel in low address */
+		(yuv_format << 20) |
+		(color_format << 19) |
+		(nv21 << 17) |
+		(cbcr_interleave << 16) |
+		(fb_arr[0].stride);
+	vpu_write_reg(vpu_inst->dev, W5_COMMON_PIC_INFO, reg_val); //// 0x008012c0
+
+	remain = count;
+	cnt_8_chunk = (count + 7) / 8;
+	idx = 0;
+	for (j = 0; j < cnt_8_chunk; j++) {
+		reg_val = (endian << 16) | (j == cnt_8_chunk - 1) << 4 | ((j == 0) << 3);
+		reg_val |= (p_dec_info->open_param.enable_non_ref_fbc_write << 26);
+		vpu_write_reg(vpu_inst->dev, W5_SFB_OPTION, reg_val);
+		start_no = j * 8;
+		end_no = start_no + (remain >= 8 ? 8 : remain) - 1;
+
+		vpu_write_reg(vpu_inst->dev, W5_SET_FB_NUM, (start_no << 8) | end_no);
+
+		for (i = 0; i < 8 && i < remain; i++) {
+			if (map_type == LINEAR_FRAME_MAP && p_dec_info->open_param.cbcr_order ==
+					CBCR_ORDER_REVERSED) {
+				addr_y = fb_arr[i + start_no].buf_y;
+				addr_cb = fb_arr[i + start_no].buf_cr;
+				addr_cr = fb_arr[i + start_no].buf_cb;
+			} else {
+				addr_y = fb_arr[i + start_no].buf_y;
+				addr_cb = fb_arr[i + start_no].buf_cb;
+				addr_cr = fb_arr[i + start_no].buf_cr;
+			}
+			vpu_write_reg(vpu_inst->dev, W5_ADDR_LUMA_BASE0 + (i << 4), addr_y);
+			vpu_write_reg(vpu_inst->dev, W5_ADDR_CB_BASE0 + (i << 4), addr_cb);
+			if (map_type >= COMPRESSED_FRAME_MAP) {
+				/* luma FBC offset table */
+				vpu_write_reg(vpu_inst->dev, W5_ADDR_FBC_Y_OFFSET0 + (i << 4),
+					      p_dec_info->vb_fbc_y_tbl[idx].daddr);
+				/* chroma FBC offset table */
+				vpu_write_reg(vpu_inst->dev, W5_ADDR_FBC_C_OFFSET0 + (i << 4),
+					      p_dec_info->vb_fbc_c_tbl[idx].daddr);
+				vpu_write_reg(vpu_inst->dev, W5_ADDR_MV_COL0 + (i << 2),
+					      p_dec_info->vb_mv[idx].daddr);
+			} else {
+				vpu_write_reg(vpu_inst->dev, W5_ADDR_CR_BASE0 + (i << 4), addr_cr);
+				vpu_write_reg(vpu_inst->dev, W5_ADDR_FBC_C_OFFSET0 + (i << 4), 0);
+				vpu_write_reg(vpu_inst->dev, W5_ADDR_MV_COL0 + (i << 2), 0);
+			}
+			idx++;
+		}
+		remain -= i;
+
+		wave5_bit_issue_command(vpu_inst, W5_SET_FB);
+		ret = wave5_wait_vpu_busy(vpu_inst->dev, VPU_BUSY_CHECK_TIMEOUT,
+					  W5_VPU_BUSY_STATUS);
+		if (ret)
+			return ret;
+	}
+
+	reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_SUCCESS);
+	if (!reg_val)
+		return -EIO;
+
+	return 0;
+}
+
+int wave5_vpu_decode(struct vpu_instance *vpu_inst, struct dec_param *option, u32 *fail_res)
+{
+	u32 mode_option = DEC_PIC_NORMAL, bs_option, reg_val;
+	u32 force_latency = 0;
+	struct dec_info *p_dec_info = &vpu_inst->codec_info->dec_info;
+	struct dec_open_param *p_open_param = &p_dec_info->open_param;
+	int ret;
+
+	if (p_dec_info->thumbnail_mode) {
+		mode_option = DEC_PIC_W_THUMBNAIL;
+	} else if (option->skipframe_mode) {
+		switch (option->skipframe_mode) {
+		case WAVE_SKIPMODE_NON_IRAP:
+			mode_option = SKIP_NON_IRAP;
+			force_latency = 1;
+			break;
+		case WAVE_SKIPMODE_NON_REF:
+			mode_option = SKIP_NON_REF_PIC;
+			break;
+		default:
+			// skip off
+			break;
+		}
+	}
+
+	// set disable reorder
+	if (!p_dec_info->reorder_enable)
+		force_latency = 1;
+
+	/* set attributes of bitstream buffer controller */
+	bs_option = 0;
+	switch (p_open_param->bitstream_mode) {
+	case BS_MODE_INTERRUPT:
+		break;
+	case BS_MODE_PIC_END:
+		bs_option = BSOPTION_ENABLE_EXPLICIT_END;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	vpu_write_reg(vpu_inst->dev, W5_BS_RD_PTR, p_dec_info->stream_rd_ptr);
+	vpu_write_reg(vpu_inst->dev, W5_BS_WR_PTR, p_dec_info->stream_wr_ptr);
+	if (p_dec_info->stream_endflag == 1)
+		bs_option = 3; // (stream_end_flag<<1) | EXPLICIT_END
+	if (p_open_param->bitstream_mode == BS_MODE_PIC_END)
+		bs_option |= BIT(31);
+	if (vpu_inst->std == W_AV1_DEC)
+		bs_option |= ((p_open_param->av1_format) << 2);
+	vpu_write_reg(vpu_inst->dev, W5_BS_OPTION, bs_option);
+
+	/* secondary AXI */
+	reg_val = (p_dec_info->sec_axi_info.wave.use_bit_enable << 0) |
+		(p_dec_info->sec_axi_info.wave.use_ip_enable << 9) |
+		(p_dec_info->sec_axi_info.wave.use_lf_row_enable << 15);
+	vpu_write_reg(vpu_inst->dev, W5_USE_SEC_AXI, reg_val);
+
+	/* set attributes of user buffer */
+	vpu_write_reg(vpu_inst->dev, W5_CMD_DEC_USER_MASK, p_dec_info->user_data_enable);
+
+	vpu_write_reg(vpu_inst->dev, W5_COMMAND_OPTION,
+		      ((option->disable_film_grain << 6) | (option->cra_as_bla_flag << 5) |
+		      mode_option));
+	vpu_write_reg(vpu_inst->dev, W5_CMD_DEC_TEMPORAL_ID_PLUS1,
+		      (p_dec_info->target_spatial_id << 9) |
+		      (p_dec_info->temp_id_select_mode << 8) | p_dec_info->target_temp_id);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_SEQ_CHANGE_ENABLE_FLAG, p_dec_info->seq_change_mask);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_DEC_FORCE_FB_LATENCY_PLUS1, force_latency);
+
+	wave5_bit_issue_command(vpu_inst, W5_DEC_PIC);
+	// check QUEUE_DONE
+	ret = wave5_wait_vpu_busy(vpu_inst->dev, VPU_BUSY_CHECK_TIMEOUT, W5_VPU_BUSY_STATUS);
+	if (ret) {
+		dev_warn(vpu_inst->dev->dev, "dec pic timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_QUEUE_STATUS);
+
+	p_dec_info->instance_queue_count = (reg_val >> 16) & 0xff;
+	p_dec_info->report_queue_count = (reg_val & 0xffff);
+	// FAILED for adding a command into VCPU QUEUE
+	if (!vpu_read_reg(vpu_inst->dev, W5_RET_SUCCESS)) {
+		*fail_res = vpu_read_reg(vpu_inst->dev, W5_RET_FAIL_REASON);
+		wave5_print_reg_err(vpu_inst->dev, *fail_res);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int wave5_vpu_dec_get_result(struct vpu_instance *vpu_inst, struct dec_output_info *result)
+{
+	int ret;
+	u32 reg_val, sub_layer_info, index, nal_unit_type;
+	struct dec_info *p_dec_info = &vpu_inst->codec_info->dec_info;
+	struct vpu_device *vpu_dev = vpu_inst->dev;
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_DEC_ADDR_REPORT_BASE, p_dec_info->user_data_buf_addr);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_DEC_REPORT_SIZE, p_dec_info->user_data_buf_size);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_DEC_REPORT_PARAM,
+		      VPU_USER_DATA_ENDIAN & VDI_128BIT_ENDIAN_MASK);
+
+	// send QUERY cmd
+	ret = wave5_send_query(vpu_inst, GET_RESULT);
+	if (ret) {
+		if (ret == -EIO) {
+			reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_FAIL_REASON);
+			wave5_print_reg_err(vpu_inst->dev, reg_val);
+		}
+
+		return ret;
+	}
+
+	dev_dbg(vpu_inst->dev->dev, "dec pic complete\n");
+
+	reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_QUEUE_STATUS);
+
+	p_dec_info->instance_queue_count = (reg_val >> 16) & 0xff;
+	p_dec_info->report_queue_count = (reg_val & 0xffff);
+
+	result->decoding_success = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_DECODING_SUCCESS);
+	if (!result->decoding_success)
+		result->error_reason = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_ERR_INFO);
+	else
+		result->warn_info = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_WARN_INFO);
+
+	result->dec_output_ext_data.user_data_size = 0;
+	result->dec_output_ext_data.user_data_buf_full = false;
+	result->dec_output_ext_data.user_data_header = vpu_read_reg(vpu_inst->dev,
+								    W5_RET_DEC_USERDATA_IDC);
+	if (result->dec_output_ext_data.user_data_header) {
+		reg_val = result->dec_output_ext_data.user_data_header;
+		if (reg_val & BIT(USERDATA_FLAG_BUFF_FULL))
+			result->dec_output_ext_data.user_data_buf_full = true;
+		result->dec_output_ext_data.user_data_size = p_dec_info->user_data_buf_size;
+	}
+
+	reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_PIC_TYPE);
+
+	nal_unit_type = (reg_val & 0x3f0) >> 4;
+	result->nal_type = nal_unit_type;
+
+	if (vpu_inst->std == W_VP9_DEC) {
+		if (reg_val & 0x01)
+			result->pic_type = PIC_TYPE_I;
+		else if (reg_val & 0x02)
+			result->pic_type = PIC_TYPE_P;
+		else if (reg_val & 0x04)
+			result->pic_type = PIC_TYPE_REPEAT;
+		else
+			result->pic_type = PIC_TYPE_MAX;
+	} else if (vpu_inst->std == W_HEVC_DEC) {
+		if (reg_val & 0x04)
+			result->pic_type = PIC_TYPE_B;
+		else if (reg_val & 0x02)
+			result->pic_type = PIC_TYPE_P;
+		else if (reg_val & 0x01)
+			result->pic_type = PIC_TYPE_I;
+		else
+			result->pic_type = PIC_TYPE_MAX;
+		if ((nal_unit_type == 19 || nal_unit_type == 20) && result->pic_type == PIC_TYPE_I)
+			/* IDR_W_RADL, IDR_N_LP */
+			result->pic_type = PIC_TYPE_IDR;
+	} else if (vpu_inst->std == W_AVC_DEC) {
+		if (reg_val & 0x04)
+			result->pic_type = PIC_TYPE_B;
+		else if (reg_val & 0x02)
+			result->pic_type = PIC_TYPE_P;
+		else if (reg_val & 0x01)
+			result->pic_type = PIC_TYPE_I;
+		else
+			result->pic_type = PIC_TYPE_MAX;
+		if (nal_unit_type == 5 && result->pic_type == PIC_TYPE_I)
+			result->pic_type = PIC_TYPE_IDR;
+	} else if (vpu_inst->std == W_AV1_DEC) {
+		switch (reg_val & 0x07) {
+		case 0:
+			result->pic_type = PIC_TYPE_KEY; break;
+		case 1:
+			result->pic_type = PIC_TYPE_INTER; break;
+		case 2:
+			result->pic_type = PIC_TYPE_AV1_INTRA; break;
+		case 3:
+			result->pic_type = PIC_TYPE_AV1_SWITCH; break;
+		default:
+			result->pic_type = PIC_TYPE_MAX; break;
+		}
+	} else { // AVS2
+		switch (reg_val & 0x07) {
+		case 0:
+			result->pic_type = PIC_TYPE_I; break;
+		case 1:
+			result->pic_type = PIC_TYPE_P; break;
+		case 2:
+			result->pic_type = PIC_TYPE_B; break;
+		case 3:
+			result->pic_type = PIC_TYPE_AVS2_F; break;
+		case 4:
+			result->pic_type = PIC_TYPE_AVS2_S; break;
+		case 5:
+			result->pic_type = PIC_TYPE_AVS2_G; break;
+		case 6:
+			result->pic_type = PIC_TYPE_AVS2_GB; break;
+		default:
+			result->pic_type = PIC_TYPE_MAX; break;
+		}
+	}
+	result->output_flag = (reg_val >> 31) & 0x1;
+	result->ctu_size = 16 << ((reg_val >> 10) & 0x3);
+	index = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_DISPLAY_INDEX);
+	result->index_frame_display = index;
+	result->index_frame_display_for_tiled = index;
+	index = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_DECODED_INDEX);
+	result->index_frame_decoded = index;
+	result->index_frame_decoded_for_tiled = index;
+
+	sub_layer_info = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_SUB_LAYER_INFO);
+	result->temporal_id = sub_layer_info & 0x7;
+
+	if (vpu_inst->std == W_HEVC_DEC) {
+		result->decoded_poc = -1;
+		result->display_poc = -1;
+		if (result->index_frame_decoded >= 0 ||
+		    result->index_frame_decoded == DECODED_IDX_FLAG_SKIP)
+			result->decoded_poc = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_PIC_POC);
+	} else if (vpu_inst->std == W_AVS2_DEC) {
+		result->avs2_info.decoded_poi = -1;
+		result->avs2_info.display_poi = -1;
+		if (result->index_frame_decoded >= 0)
+			result->avs2_info.decoded_poi =
+				vpu_read_reg(vpu_inst->dev, W5_RET_DEC_PIC_POC);
+	} else if (vpu_inst->std == W_AVC_DEC) {
+		result->decoded_poc = -1;
+		result->display_poc = -1;
+		if (result->index_frame_decoded >= 0 ||
+		    result->index_frame_decoded == DECODED_IDX_FLAG_SKIP)
+			result->decoded_poc = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_PIC_POC);
+	} else if (vpu_inst->std == W_AV1_DEC) {
+		result->decoded_poc = -1;
+		result->display_poc = -1;
+		if (result->index_frame_decoded >= 0 ||
+		    result->index_frame_decoded == DECODED_IDX_FLAG_SKIP)
+			result->decoded_poc = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_PIC_POC);
+
+		result->av1_info.spatial_id = (sub_layer_info >> 19) & 0x3;
+		reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_PIC_PARAM);
+		result->av1_info.allow_intra_bc = (reg_val >> 0) & 0x1;
+		result->av1_info.allow_screen_content_tools = (reg_val >> 1) & 0x1;
+	}
+
+	result->sequence_changed = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_NOTIFICATION);
+	if (result->sequence_changed & SEQ_CHANGE_INTER_RES_CHANGE)
+		result->index_inter_frame_decoded = vpu_read_reg(vpu_inst->dev,
+								 W5_RET_DEC_REALLOC_INDEX);
+
+	reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_PIC_SIZE);
+	result->dec_pic_width = reg_val >> 16;
+	result->dec_pic_height = reg_val & 0xffff;
+
+	if (result->sequence_changed) {
+		memcpy((void *)&p_dec_info->new_seq_info, (void *)&p_dec_info->initial_info,
+		       sizeof(struct dec_initial_info));
+		wave5_get_dec_seq_result(vpu_inst, &p_dec_info->new_seq_info);
+	}
+
+	result->num_of_err_m_bs = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_ERR_CTB_NUM) >> 16;
+	result->num_of_tot_m_bs = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_ERR_CTB_NUM) & 0xffff;
+	result->byte_pos_frame_start = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_AU_START_POS);
+	result->byte_pos_frame_end = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_AU_END_POS);
+
+	reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_RECOVERY_POINT);
+	result->h265_rp_sei.recovery_poc_cnt = reg_val & 0xFFFF; // [15:0]
+	result->h265_rp_sei.exact_match_flag = (reg_val >> 16) & 0x01; // [16]
+	result->h265_rp_sei.broken_link_flag = (reg_val >> 17) & 0x01; // [17]
+	result->h265_rp_sei.exist = (reg_val >> 18) & 0x01; // [18]
+	if (!result->h265_rp_sei.exist) {
+		result->h265_rp_sei.recovery_poc_cnt = 0;
+		result->h265_rp_sei.exact_match_flag = 0;
+		result->h265_rp_sei.broken_link_flag = 0;
+	}
+
+	result->dec_host_cmd_tick = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_HOST_CMD_TICK);
+	result->dec_seek_start_tick = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_SEEK_START_TICK);
+	result->dec_seek_end_tick = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_SEEK_END_TICK);
+	result->dec_parse_start_tick = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_PARSING_START_TICK);
+	result->dec_parse_end_tick = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_PARSING_END_TICK);
+	result->dec_decode_start_tick = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_DECODING_START_TICK);
+	result->dec_decode_end_tick = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_DECODING_ENC_TICK);
+
+	if (!p_dec_info->first_cycle_check) {
+		result->frame_cycle =
+			(result->dec_decode_end_tick - result->dec_host_cmd_tick) *
+			p_dec_info->cycle_per_tick;
+		vpu_dev->last_performance_cycles = result->dec_decode_end_tick;
+		p_dec_info->first_cycle_check = true;
+	} else if (result->index_frame_decoded_for_tiled != -1) {
+		result->frame_cycle =
+			(result->dec_decode_end_tick - vpu_dev->last_performance_cycles) *
+			p_dec_info->cycle_per_tick;
+		vpu_dev->last_performance_cycles = result->dec_decode_end_tick;
+		if (vpu_dev->last_performance_cycles < result->dec_host_cmd_tick)
+			result->frame_cycle =
+				(result->dec_decode_end_tick - result->dec_host_cmd_tick);
+	}
+	result->seek_cycle =
+		(result->dec_seek_end_tick - result->dec_seek_start_tick) *
+		p_dec_info->cycle_per_tick;
+	result->parse_cycle =
+		(result->dec_parse_end_tick - result->dec_parse_start_tick) *
+		p_dec_info->cycle_per_tick;
+	result->decoded_cycle =
+		(result->dec_decode_end_tick - result->dec_decode_start_tick) *
+		p_dec_info->cycle_per_tick;
+
+	// no remaining command. reset frame cycle.
+	if (p_dec_info->instance_queue_count == 0 && p_dec_info->report_queue_count == 0)
+		p_dec_info->first_cycle_check = false;
+
+	return 0;
+}
+
+int wave5_vpu_re_init(struct device *dev, u8 *fw, uint32_t size)
+{
+	struct dma_vpu_buf *sram_vb;
+	struct vpu_buf *common_vb;
+	dma_addr_t code_base, temp_base;
+	dma_addr_t old_code_base, temp_size;
+	u32 code_size;
+	u32 reg_val, remap_size;
+	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
+	int ret;
+
+	common_vb = &vpu_dev->common_mem;
+
+	code_base = common_vb->daddr;
+	/* ALIGN TO 4KB */
+	code_size = (WAVE5_MAX_CODE_BUF_SIZE & ~0xfff);
+	if (code_size < size * 2)
+		return -EINVAL;
+	temp_base = common_vb->daddr + WAVE5_TEMPBUF_OFFSET;
+	temp_size = WAVE5_TEMPBUF_SIZE;
+
+	old_code_base = vpu_read_reg(vpu_dev, W5_VPU_REMAP_PADDR);
+
+	if (old_code_base != code_base + W5_REMAP_INDEX1 * W5_REMAP_MAX_SIZE) {
+		wave5_vdi_write_memory(vpu_dev, common_vb, 0, fw, size, VDI_128BIT_LITTLE_ENDIAN);
+
+		vpu_write_reg(vpu_dev, W5_PO_CONF, 0);
+
+		wave5_vpu_reset(dev, SW_RESET_ON_BOOT);
+
+		/* remap page size 0*/
+		remap_size = (W5_REMAP_MAX_SIZE >> 12) & 0x1ff;
+		reg_val = 0x80000000 | (WAVE5_UPPER_PROC_AXI_ID << 20) | (0 << 16)
+			| (W5_REMAP_INDEX0 << 12) | BIT(11) | remap_size;
+		vpu_write_reg(vpu_dev, W5_VPU_REMAP_CTRL, reg_val);
+		vpu_write_reg(vpu_dev, W5_VPU_REMAP_VADDR, W5_REMAP_INDEX0 * W5_REMAP_MAX_SIZE);
+		vpu_write_reg(vpu_dev, W5_VPU_REMAP_PADDR,
+			      code_base + W5_REMAP_INDEX0 * W5_REMAP_MAX_SIZE);
+
+		/* remap page size 1*/
+		remap_size = (W5_REMAP_MAX_SIZE >> 12) & 0x1ff;
+		reg_val = 0x80000000 | (WAVE5_UPPER_PROC_AXI_ID << 20) | (0 << 16)
+			| (W5_REMAP_INDEX1 << 12) | BIT(11) | remap_size;
+		vpu_write_reg(vpu_dev, W5_VPU_REMAP_CTRL, reg_val);
+		vpu_write_reg(vpu_dev, W5_VPU_REMAP_VADDR, W5_REMAP_INDEX1 * W5_REMAP_MAX_SIZE);
+		vpu_write_reg(vpu_dev, W5_VPU_REMAP_PADDR,
+			      code_base + W5_REMAP_INDEX1 * W5_REMAP_MAX_SIZE);
+
+		vpu_write_reg(vpu_dev, W5_ADDR_CODE_BASE, code_base);
+		vpu_write_reg(vpu_dev, W5_CODE_SIZE, code_size);
+		vpu_write_reg(vpu_dev, W5_CODE_PARAM, (WAVE5_UPPER_PROC_AXI_ID << 4) | 0);
+		vpu_write_reg(vpu_dev, W5_ADDR_TEMP_BASE, temp_base);
+		vpu_write_reg(vpu_dev, W5_TEMP_SIZE, temp_size);
+
+		vpu_write_reg(vpu_dev, W5_HW_OPTION, 0);
+
+		/* interrupt */
+		// encoder
+		reg_val = BIT(INT_WAVE5_ENC_SET_PARAM);
+		reg_val |= BIT(INT_WAVE5_ENC_PIC);
+		reg_val |= BIT(INT_WAVE5_BSBUF_FULL);
+		// decoder
+		reg_val |= BIT(INT_WAVE5_INIT_SEQ);
+		reg_val |= BIT(INT_WAVE5_DEC_PIC);
+		reg_val |= BIT(INT_WAVE5_BSBUF_EMPTY);
+		vpu_write_reg(vpu_dev, W5_VPU_VINT_ENABLE, reg_val);
+
+		reg_val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
+		if ((reg_val >> 16) & 1) {
+			reg_val = ((WAVE5_PROC_AXI_ID << 28) |
+					(WAVE5_PRP_AXI_ID << 24) |
+					(WAVE5_FBD_Y_AXI_ID << 20) |
+					(WAVE5_FBC_Y_AXI_ID << 16) |
+					(WAVE5_FBD_C_AXI_ID << 12) |
+					(WAVE5_FBC_C_AXI_ID << 8) |
+					(WAVE5_PRI_AXI_ID << 4) |
+					(WAVE5_SEC_AXI_ID << 0));
+			wave5_write_register(vpu_dev, W5_BACKBONE_PROG_AXI_ID, reg_val);
+		}
+
+		sram_vb = get_sram_memory(vpu_dev);
+
+		vpu_write_reg(vpu_dev, W5_ADDR_SEC_AXI, sram_vb->daddr);
+		vpu_write_reg(vpu_dev, W5_SEC_AXI_SIZE, sram_vb->size);
+		vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
+		vpu_write_reg(vpu_dev, W5_COMMAND, W5_INIT_VPU);
+		vpu_write_reg(vpu_dev, W5_VPU_REMAP_CORE_START, 1);
+
+		ret = wave5_wait_vpu_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT, W5_VPU_BUSY_STATUS);
+		if (ret) {
+			dev_err(vpu_dev->dev, "VPU reinit(W5_VPU_REMAP_CORE_START) timeout\n");
+			return ret;
+		}
+
+		reg_val = vpu_read_reg(vpu_dev, W5_RET_SUCCESS);
+		if (!reg_val) {
+			u32 reason_code = vpu_read_reg(vpu_dev, W5_RET_FAIL_REASON);
+
+			wave5_print_reg_err(vpu_dev, reason_code);
+			return -EIO;
+		}
+	}
+
+	setup_wave5_properties(dev);
+	return 0;
+}
+
+static int wave5_vpu_sleep_wake(struct device *dev, int i_sleep_wake, const uint16_t *code,
+				uint32_t size)
+{
+	u32 reg_val;
+	struct vpu_buf *common_vb;
+	dma_addr_t code_base;
+	u32 code_size;
+	u32 remap_size;
+	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
+	int ret;
+
+	if (i_sleep_wake == 1) {
+		ret = wave5_wait_vpu_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT, W5_VPU_BUSY_STATUS);
+		if (ret)
+			return ret;
+
+		vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
+		vpu_write_reg(vpu_dev, W5_COMMAND, W5_SLEEP_VPU);
+		vpu_write_reg(vpu_dev, W5_VPU_HOST_INT_REQ, 1);
+
+		ret = wave5_wait_vpu_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT, W5_VPU_BUSY_STATUS);
+		if (ret)
+			return ret;
+
+		if (!vpu_read_reg(vpu_dev, W5_RET_SUCCESS)) {
+			u32 reason = vpu_read_reg(vpu_dev, W5_RET_FAIL_REASON);
+
+			wave5_print_reg_err(vpu_dev, reason);
+			return -EIO;
+		}
+	} else { /* restore */
+		common_vb = &vpu_dev->common_mem;
+
+		code_base = common_vb->daddr;
+		/* ALIGN TO 4KB */
+		code_size = (WAVE5_MAX_CODE_BUF_SIZE & ~0xfff);
+		if (code_size < size * 2) {
+			dev_err(dev, "size too small\n");
+			return -EINVAL;
+		}
+
+		vpu_write_reg(vpu_dev, W5_PO_CONF, 0);
+
+		/* remap page size 0*/
+		remap_size = (W5_REMAP_MAX_SIZE >> 12) & 0x1ff;
+		reg_val = 0x80000000 | (WAVE5_UPPER_PROC_AXI_ID << 20) | (0 << 16)
+			| (W5_REMAP_INDEX0 << 12) | BIT(11) | remap_size;
+		vpu_write_reg(vpu_dev, W5_VPU_REMAP_CTRL, reg_val);
+		vpu_write_reg(vpu_dev, W5_VPU_REMAP_VADDR, W5_REMAP_INDEX0 * W5_REMAP_MAX_SIZE);
+		vpu_write_reg(vpu_dev, W5_VPU_REMAP_PADDR,
+			      code_base + W5_REMAP_INDEX0 * W5_REMAP_MAX_SIZE);
+
+		/* remap page size 1*/
+		remap_size = (W5_REMAP_MAX_SIZE >> 12) & 0x1ff;
+		reg_val = 0x80000000 | (WAVE5_UPPER_PROC_AXI_ID << 20) | (0 << 16)
+			| (W5_REMAP_INDEX1 << 12) | BIT(11) | remap_size;
+		vpu_write_reg(vpu_dev, W5_VPU_REMAP_CTRL, reg_val);
+		vpu_write_reg(vpu_dev, W5_VPU_REMAP_VADDR, W5_REMAP_INDEX1 * W5_REMAP_MAX_SIZE);
+		vpu_write_reg(vpu_dev, W5_VPU_REMAP_PADDR,
+			      code_base + W5_REMAP_INDEX1 * W5_REMAP_MAX_SIZE);
+
+		vpu_write_reg(vpu_dev, W5_ADDR_CODE_BASE, code_base);
+		vpu_write_reg(vpu_dev, W5_CODE_SIZE, code_size);
+		vpu_write_reg(vpu_dev, W5_CODE_PARAM, (WAVE5_UPPER_PROC_AXI_ID << 4) | 0);
+
+		vpu_write_reg(vpu_dev, W5_HW_OPTION, 0);
+
+		/* interrupt */
+		// encoder
+		reg_val = BIT(INT_WAVE5_ENC_SET_PARAM);
+		reg_val |= BIT(INT_WAVE5_ENC_PIC);
+		reg_val |= BIT(INT_WAVE5_BSBUF_FULL);
+		// decoder
+		reg_val |= BIT(INT_WAVE5_INIT_SEQ);
+		reg_val |= BIT(INT_WAVE5_DEC_PIC);
+		reg_val |= BIT(INT_WAVE5_BSBUF_EMPTY);
+		vpu_write_reg(vpu_dev, W5_VPU_VINT_ENABLE, reg_val);
+
+		reg_val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
+		if ((reg_val >> 16) & 1) {
+			reg_val = ((WAVE5_PROC_AXI_ID << 28) |
+					(WAVE5_PRP_AXI_ID << 24) |
+					(WAVE5_FBD_Y_AXI_ID << 20) |
+					(WAVE5_FBC_Y_AXI_ID << 16) |
+					(WAVE5_FBD_C_AXI_ID << 12) |
+					(WAVE5_FBC_C_AXI_ID << 8) |
+					(WAVE5_PRI_AXI_ID << 4) |
+					(WAVE5_SEC_AXI_ID << 0));
+			wave5_write_register(vpu_dev, W5_BACKBONE_PROG_AXI_ID, reg_val);
+		}
+
+		vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 1);
+		vpu_write_reg(vpu_dev, W5_COMMAND, W5_WAKEUP_VPU);
+		vpu_write_reg(vpu_dev, W5_VPU_REMAP_CORE_START, 1);
+
+		ret = wave5_wait_vpu_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT, W5_VPU_BUSY_STATUS);
+		if (ret) {
+			dev_err(vpu_dev->dev, "VPU wakeup(W5_VPU_REMAP_CORE_START) timeout\n");
+			return ret;
+		}
+
+		reg_val = vpu_read_reg(vpu_dev, W5_RET_SUCCESS);
+		if (!reg_val) {
+			u32 reason_code = vpu_read_reg(vpu_dev, W5_RET_FAIL_REASON);
+
+			wave5_print_reg_err(vpu_dev, reason_code);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+int wave5_vpu_reset(struct device *dev, enum sw_reset_mode reset_mode)
+{
+	u32 val = 0;
+	int ret = 0;
+	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
+	struct vpu_attr *p_attr = &vpu_dev->attr;
+	// VPU doesn't send response. force to set BUSY flag to 0.
+	vpu_write_reg(vpu_dev, W5_VPU_BUSY_STATUS, 0);
+
+	if (reset_mode == SW_RESET_SAFETY) {
+		ret = wave5_vpu_sleep_wake(dev, true, NULL, 0);
+		if (ret)
+			return ret;
+	}
+
+	val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
+	if ((val >> 16) & 0x1)
+		p_attr->support_backbone = true;
+	if ((val >> 22) & 0x1)
+		p_attr->support_vcore_backbone = true;
+	if ((val >> 28) & 0x1)
+		p_attr->support_vcpu_backbone = true;
+
+	val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG1);
+	if ((val >> 26) & 0x1)
+		p_attr->support_dual_core = true;
+
+	// waiting for completion of bus transaction
+	if (p_attr->support_backbone) {
+		if (p_attr->support_dual_core) {
+			// check CORE0
+			wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE0, 0x7);
+
+			ret = wave5_wait_bus_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT,
+						  W5_BACKBONE_BUS_STATUS_VCORE0);
+			if (ret) {
+				wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE0, 0x00);
+				return ret;
+			}
+
+			// check CORE1
+			wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE1, 0x7);
+
+			ret = wave5_wait_bus_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT,
+						  W5_BACKBONE_BUS_STATUS_VCORE1);
+			if (ret) {
+				wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE1, 0x00);
+				return ret;
+			}
+
+		} else if (p_attr->support_vcore_backbone) {
+			if (p_attr->support_vcpu_backbone) {
+				// step1 : disable request
+				wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCPU,
+						     0xFF);
+
+				// step2 : waiting for completion of bus transaction
+				ret = wave5_wait_vcpu_bus_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT,
+							       W5_BACKBONE_BUS_STATUS_VCPU);
+				if (ret) {
+					wave5_write_register(vpu_dev,
+							     W5_BACKBONE_BUS_CTRL_VCPU, 0x00);
+					return ret;
+				}
+			}
+			// step1 : disable request
+			wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE0, 0x7);
+
+			// step2 : waiting for completion of bus transaction
+			if (wave5_wait_bus_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT,
+						W5_BACKBONE_BUS_STATUS_VCORE0) == -1) {
+				wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE0, 0x00);
+				return -EBUSY;
+			}
+		} else {
+			// step1 : disable request
+			wave5_write_register(vpu_dev, W5_COMBINED_BACKBONE_BUS_CTRL, 0x7);
+
+			// step2 : waiting for completion of bus transaction
+			if (wave5_wait_bus_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT,
+						W5_COMBINED_BACKBONE_BUS_STATUS) == -1) {
+				wave5_write_register(vpu_dev, W5_COMBINED_BACKBONE_BUS_CTRL, 0x00);
+				return -EBUSY;
+			}
+		}
+	} else {
+		// step1 : disable request
+		wave5_write_register(vpu_dev, W5_GDI_BUS_CTRL, 0x100);
+
+		// step2 : waiting for completion of bus transaction
+		ret = wave5_wait_bus_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT, W5_GDI_BUS_STATUS);
+		if (ret) {
+			wave5_write_register(vpu_dev, W5_GDI_BUS_CTRL, 0x00);
+			return ret;
+		}
+	}
+
+	switch (reset_mode) {
+	case SW_RESET_ON_BOOT:
+	case SW_RESET_FORCE:
+	case SW_RESET_SAFETY:
+		val = W5_RST_BLOCK_ALL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (val) {
+		vpu_write_reg(vpu_dev, W5_VPU_RESET_REQ, val);
+
+		ret = wave5_wait_vpu_busy(vpu_dev, VPU_BUSY_CHECK_TIMEOUT, W5_VPU_RESET_STATUS);
+		if (ret) {
+			vpu_write_reg(vpu_dev, W5_VPU_RESET_REQ, 0);
+			return ret;
+		}
+		vpu_write_reg(vpu_dev, W5_VPU_RESET_REQ, 0);
+	}
+	// step3 : must clear GDI_BUS_CTRL after done SW_RESET
+	if (p_attr->support_backbone) {
+		if (p_attr->support_dual_core) {
+			wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE0, 0x00);
+			wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE1, 0x00);
+		} else if (p_attr->support_vcore_backbone) {
+			if (p_attr->support_vcpu_backbone)
+				wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCPU, 0x00);
+			wave5_write_register(vpu_dev, W5_BACKBONE_BUS_CTRL_VCORE0, 0x00);
+		} else {
+			wave5_write_register(vpu_dev, W5_COMBINED_BACKBONE_BUS_CTRL, 0x00);
+		}
+	} else {
+		wave5_write_register(vpu_dev, W5_GDI_BUS_CTRL, 0x00);
+	}
+	if (reset_mode == SW_RESET_SAFETY || reset_mode == SW_RESET_FORCE)
+		ret = wave5_vpu_sleep_wake(dev, false, NULL, 0);
+
+	return ret;
+}
+
+int wave5_vpu_dec_fini_seq(struct vpu_instance *vpu_inst, u32 *fail_res)
+{
+	int ret;
+
+	wave5_bit_issue_command(vpu_inst, W5_DESTROY_INSTANCE);
+	ret = wave5_wait_vpu_busy(vpu_inst->dev, VPU_BUSY_CHECK_TIMEOUT, W5_VPU_BUSY_STATUS);
+	if (ret)
+		return -ETIMEDOUT;
+
+	if (!vpu_read_reg(vpu_inst->dev, W5_RET_SUCCESS)) {
+		*fail_res = vpu_read_reg(vpu_inst->dev, W5_RET_FAIL_REASON);
+		wave5_print_reg_err(vpu_inst->dev, *fail_res);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int wave5_vpu_dec_set_bitstream_flag(struct vpu_instance *vpu_inst, bool eos)
+{
+	struct dec_info *p_dec_info = &vpu_inst->codec_info->dec_info;
+	enum bit_stream_mode bs_mode = (enum bit_stream_mode)p_dec_info->open_param.bitstream_mode;
+	int ret;
+
+	p_dec_info->stream_endflag = eos ? 1 : 0;
+
+	if (bs_mode == BS_MODE_INTERRUPT) {
+		vpu_write_reg(vpu_inst->dev, W5_BS_OPTION, (p_dec_info->stream_endflag << 1));
+		vpu_write_reg(vpu_inst->dev, W5_BS_WR_PTR, p_dec_info->stream_wr_ptr);
+
+		wave5_bit_issue_command(vpu_inst, W5_UPDATE_BS);
+		ret = wave5_wait_vpu_busy(vpu_inst->dev, VPU_BUSY_CHECK_TIMEOUT,
+					  W5_VPU_BUSY_STATUS);
+		if (ret)
+			return ret;
+
+		if (!vpu_read_reg(vpu_inst->dev, W5_RET_SUCCESS))
+			return -EIO;
+	}
+
+	return 0;
+}
+
+int wave5_dec_clr_disp_flag(struct vpu_instance *vpu_inst, uint32_t index)
+{
+	struct dec_info *p_dec_info = &vpu_inst->codec_info->dec_info;
+	int ret;
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_DEC_CLR_DISP_IDC, BIT(index));
+	vpu_write_reg(vpu_inst->dev, W5_CMD_DEC_SET_DISP_IDC, 0);
+	ret = wave5_send_query(vpu_inst, UPDATE_DISP_FLAG);
+
+	if (ret) {
+		if (ret == -EIO) {
+			u32 reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_FAIL_REASON);
+
+			wave5_print_reg_err(vpu_inst->dev, reg_val);
+		}
+		return ret;
+	}
+
+	p_dec_info->frame_display_flag = vpu_read_reg(vpu_inst->dev, W5_RET_DEC_DISP_IDC);
+
+	return 0;
+}
+
+int wave5_vpu_clear_interrupt(struct vpu_instance *vpu_inst, uint32_t flags)
+{
+	u32 interrupt_reason;
+
+	interrupt_reason = vpu_read_reg(vpu_inst->dev, W5_VPU_VINT_REASON_USR);
+	interrupt_reason &= ~flags;
+	vpu_write_reg(vpu_inst->dev, W5_VPU_VINT_REASON_USR, interrupt_reason);
+
+	return 0;
+}
+
+dma_addr_t wave5_vpu_dec_get_rd_ptr(struct vpu_instance *vpu_inst)
+{
+	int ret;
+
+	ret = wave5_send_query(vpu_inst, GET_BS_RD_PTR);
+
+	if (ret)
+		return vpu_inst->codec_info->dec_info.stream_rd_ptr;
+
+	return vpu_read_reg(vpu_inst->dev, W5_RET_QUERY_DEC_BS_RD_PTR);
+}
+
+/************************************************************************/
+/* ENCODER functions */
+/************************************************************************/
+
+int wave5_vpu_build_up_enc_param(struct device *dev, struct vpu_instance *vpu_inst,
+				 struct enc_open_param *param)
+{
+	int ret;
+	struct enc_info *p_enc_info = &vpu_inst->codec_info->enc_info;
+	u32 reg_val;
+	struct dma_vpu_buf *sram_vb;
+	u32 bs_endian;
+	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
+
+	sram_vb = get_sram_memory(vpu_dev);
+	p_enc_info->sec_axi_info.buf_base = sram_vb->daddr;
+	p_enc_info->sec_axi_info.buf_size = sram_vb->size;
+
+	if (vpu_dev->product == PRODUCT_ID_521)
+		p_enc_info->vb_work.size = WAVE521ENC_WORKBUF_SIZE;
+
+	ret = wave5_vdi_allocate_dma_memory(vpu_dev, &p_enc_info->vb_work);
+	if (ret) {
+		memset(&p_enc_info->vb_work, 0, sizeof(p_enc_info->vb_work));
+		return ret;
+	}
+
+	wave5_vdi_clear_memory(vpu_dev, &p_enc_info->vb_work);
+
+	vpu_write_reg(vpu_inst->dev, W5_ADDR_WORK_BASE, p_enc_info->vb_work.daddr);
+	vpu_write_reg(vpu_inst->dev, W5_WORK_SIZE, p_enc_info->vb_work.size);
+
+	reg_val = wave5_vdi_convert_endian(vpu_dev, param->stream_endian);
+	bs_endian = (~reg_val & VDI_128BIT_ENDIAN_MASK);
+
+	reg_val = (param->line_buf_int_en << 6) | bs_endian;
+	vpu_write_reg(vpu_inst->dev, W5_CMD_BS_PARAM, reg_val);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_NUM_CQ_DEPTH_M1, (COMMAND_QUEUE_DEPTH - 1));
+
+	reg_val = 0;
+	if (vpu_dev->product == PRODUCT_ID_521)
+		reg_val |= (param->sub_frame_sync_enable | param->sub_frame_sync_mode << 1);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SRC_OPTIONS, reg_val);
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_VCORE_INFO, 1);
+
+	wave5_bit_issue_command(vpu_inst, W5_CREATE_INSTANCE);
+	// check QUEUE_DONE
+	ret = wave5_wait_vpu_busy(vpu_inst->dev, VPU_BUSY_CHECK_TIMEOUT, W5_VPU_BUSY_STATUS);
+	if (ret) {
+		dev_warn(vpu_inst->dev->dev, "create instance timed out\n");
+		wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_work);
+		return ret;
+	}
+
+	// FAILED for adding into VCPU QUEUE
+	if (!vpu_read_reg(vpu_inst->dev, W5_RET_SUCCESS)) {
+		wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_work);
+		reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_FAIL_REASON);
+		wave5_print_reg_err(vpu_inst->dev, reg_val);
+		return -EIO;
+	}
+
+	p_enc_info->sub_frame_sync_config.sub_frame_sync_mode = param->sub_frame_sync_mode;
+	p_enc_info->sub_frame_sync_config.sub_frame_sync_on = param->sub_frame_sync_enable;
+	p_enc_info->stream_rd_ptr = param->bitstream_buffer;
+	p_enc_info->stream_wr_ptr = param->bitstream_buffer;
+	p_enc_info->line_buf_int_en = param->line_buf_int_en;
+	p_enc_info->stream_buf_start_addr = param->bitstream_buffer;
+	p_enc_info->stream_buf_size = param->bitstream_buffer_size;
+	p_enc_info->stream_buf_end_addr = param->bitstream_buffer + param->bitstream_buffer_size;
+	p_enc_info->stride = 0;
+	p_enc_info->initial_info_obtained = false;
+	p_enc_info->product_code = vpu_read_reg(vpu_inst->dev, W5_PRODUCT_NUMBER);
+
+	return 0;
+}
+
+static int wave5_set_enc_crop_info(u32 codec, struct enc_wave_param *param, int rot_mode,
+				   int src_width, int src_height)
+{
+	int aligned_width = (codec == W_HEVC_ENC) ? ALIGN(src_width, 32) : ALIGN(src_width, 16);
+	int aligned_height = (codec == W_HEVC_ENC) ? ALIGN(src_height, 32) : ALIGN(src_height, 16);
+	int pad_right, pad_bot;
+	int crop_right, crop_left, crop_top, crop_bot;
+	int prp_mode = rot_mode >> 1; // remove prp_enable bit
+
+	if (codec == W_HEVC_ENC &&
+	    (!rot_mode || prp_mode == 14)) // prp_mode 14 : hor_mir && ver_mir && rot_180
+		return 0;
+
+	pad_right = aligned_width - src_width;
+	pad_bot = aligned_height - src_height;
+
+	if (param->conf_win_right > 0)
+		crop_right = param->conf_win_right + pad_right;
+	else
+		crop_right = pad_right;
+
+	if (param->conf_win_bot > 0)
+		crop_bot = param->conf_win_bot + pad_bot;
+	else
+		crop_bot = pad_bot;
+
+	crop_top = param->conf_win_top;
+	crop_left = param->conf_win_left;
+
+	param->conf_win_top = crop_top;
+	param->conf_win_left = crop_left;
+	param->conf_win_bot = crop_bot;
+	param->conf_win_right = crop_right;
+
+	if (prp_mode == 1 || prp_mode == 15) {
+		param->conf_win_top = crop_right;
+		param->conf_win_left = crop_top;
+		param->conf_win_bot = crop_left;
+		param->conf_win_right = crop_bot;
+	} else if (prp_mode == 2 || prp_mode == 12) {
+		param->conf_win_top = crop_bot;
+		param->conf_win_left = crop_right;
+		param->conf_win_bot = crop_top;
+		param->conf_win_right = crop_left;
+	} else if (prp_mode == 3 || prp_mode == 13) {
+		param->conf_win_top = crop_left;
+		param->conf_win_left = crop_bot;
+		param->conf_win_bot = crop_right;
+		param->conf_win_right = crop_top;
+	} else if (prp_mode == 4 || prp_mode == 10) {
+		param->conf_win_top = crop_bot;
+		param->conf_win_bot = crop_top;
+	} else if (prp_mode == 8 || prp_mode == 6) {
+		param->conf_win_left = crop_right;
+		param->conf_win_right = crop_left;
+	} else if (prp_mode == 5 || prp_mode == 11) {
+		param->conf_win_top = crop_left;
+		param->conf_win_left = crop_top;
+		param->conf_win_bot = crop_right;
+		param->conf_win_right = crop_bot;
+	} else if (prp_mode == 7 || prp_mode == 9) {
+		param->conf_win_top = crop_right;
+		param->conf_win_left = crop_bot;
+		param->conf_win_bot = crop_left;
+		param->conf_win_right = crop_top;
+	}
+
+	return 0;
+}
+
+int wave5_vpu_enc_init_seq(struct vpu_instance *vpu_inst)
+{
+	u32 reg_val = 0, rot_mir_mode, fixed_cu_size_mode = 0x7;
+	struct enc_info *p_enc_info = &vpu_inst->codec_info->enc_info;
+	struct enc_open_param *p_open_param = &p_enc_info->open_param;
+	struct enc_wave_param *p_param = &p_open_param->wave_param;
+	int ret;
+
+	if (vpu_inst->dev->product != PRODUCT_ID_521)
+		return -EINVAL;
+
+	/*==============================================*/
+	/* OPT_CUSTOM_GOP */
+	/*==============================================*/
+	/*
+	 * SET_PARAM + CUSTOM_GOP
+	 * only when gop_preset_idx == custom_gop, custom_gop related registers should be set
+	 */
+	if (p_param->gop_preset_idx == PRESET_IDX_CUSTOM_GOP) {
+		int i = 0, j = 0;
+
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_CUSTOM_GOP_PARAM,
+			      p_param->gop_param.custom_gop_size);
+		for (i = 0; i < p_param->gop_param.custom_gop_size; i++) {
+			vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_0 + (i * 4),
+				      (p_param->gop_param.pic_param[i].pic_type << 0) |
+				      (p_param->gop_param.pic_param[i].poc_offset << 2) |
+				      (p_param->gop_param.pic_param[i].pic_qp << 6) |
+				      (p_param->gop_param.pic_param[i].use_multi_ref_p << 13) |
+				      ((p_param->gop_param.pic_param[i].ref_poc_l0 & 0x1F) << 14) |
+				      ((p_param->gop_param.pic_param[i].ref_poc_l1 & 0x1F) << 19) |
+				      (p_param->gop_param.pic_param[i].temporal_id << 24));
+		}
+
+		for (j = i; j < MAX_GOP_NUM; j++)
+			vpu_write_reg(vpu_inst->dev,
+				      W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_0 + (j * 4), 0);
+
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_SET_PARAM_OPTION, OPT_CUSTOM_GOP);
+		wave5_bit_issue_command(vpu_inst, W5_ENC_SET_PARAM);
+
+		ret = wave5_wait_vpu_busy(vpu_inst->dev, VPU_BUSY_CHECK_TIMEOUT,
+					  W5_VPU_BUSY_STATUS);
+		if (ret) {
+			dev_warn(vpu_inst->dev->dev, "enc set param timeout op=0x%x\n",
+				 OPT_CUSTOM_GOP);
+			return ret;
+		}
+	}
+
+	/*======================================================================*/
+	/* OPT_COMMON */
+	/* :								*/
+	/*	the last SET_PARAM command should be called with OPT_COMMON */
+	/*======================================================================*/
+	rot_mir_mode = 0;
+	if (p_enc_info->rotation_enable) {
+		switch (p_enc_info->rotation_angle) {
+		case 0:
+			rot_mir_mode |= 0x0; break;
+		case 90:
+			rot_mir_mode |= 0x3; break;
+		case 180:
+			rot_mir_mode |= 0x5; break;
+		case 270:
+			rot_mir_mode |= 0x7; break;
+		}
+	}
+
+	if (p_enc_info->mirror_enable) {
+		switch (p_enc_info->mirror_direction) {
+		case MIRDIR_NONE:
+			rot_mir_mode |= 0x0; break;
+		case MIRDIR_VER:
+			rot_mir_mode |= 0x9; break;
+		case MIRDIR_HOR:
+			rot_mir_mode |= 0x11; break;
+		case MIRDIR_HOR_VER:
+			rot_mir_mode |= 0x19; break;
+		}
+	}
+
+	wave5_set_enc_crop_info(vpu_inst->std, p_param, rot_mir_mode, p_open_param->pic_width,
+				p_open_param->pic_height);
+
+	/* SET_PARAM + COMMON */
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_SET_PARAM_OPTION, OPT_COMMON);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_SRC_SIZE, p_open_param->pic_height << 16
+			| p_open_param->pic_width);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_CUSTOM_MAP_ENDIAN, VDI_LITTLE_ENDIAN);
+
+	if (vpu_inst->std == W_AVC_ENC) {
+		reg_val = (p_param->profile << 0) |
+			(p_param->level << 3) |
+			(p_param->internal_bit_depth << 14) |
+			(p_param->use_long_term << 21);
+		if (p_param->scaling_list_enable == 2) {
+			reg_val |= BIT(22) | BIT(23); // [23]=USE_DEFAULT_SCALING_LIST
+		} else { // 0 or 1
+			reg_val |= (p_param->scaling_list_enable << 22);
+		}
+	} else { // HEVC enc
+		reg_val = (p_param->profile << 0) |
+			(p_param->level << 3) |
+			(p_param->tier << 12) |
+			(p_param->internal_bit_depth << 14) |
+			(p_param->use_long_term << 21) |
+			(p_param->tmvp_enable << 23) |
+			(p_param->sao_enable << 24) |
+			(p_param->skip_intra_trans << 25) |
+			(p_param->strong_intra_smooth_enable << 27) |
+			(p_param->en_still_picture << 30);
+		if (p_param->scaling_list_enable == 2)
+			reg_val |= BIT(22) | BIT(31); // [31]=USE_DEFAULT_SCALING_LIST
+		else
+			reg_val |= (p_param->scaling_list_enable << 22);
+	}
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_SPS_PARAM, reg_val);
+
+	reg_val = (p_param->lossless_enable) |
+		(p_param->const_intra_pred_flag << 1) |
+		(p_param->lf_cross_slice_boundary_enable << 2) |
+		(p_param->weight_pred_enable << 3) |
+		(p_param->wpp_enable << 4) |
+		(p_param->disable_deblk << 5) |
+		((p_param->beta_offset_div2 & 0xF) << 6) |
+		((p_param->tc_offset_div2 & 0xF) << 10) |
+		((p_param->chroma_cb_qp_offset & 0x1F) << 14) |
+		((p_param->chroma_cr_qp_offset & 0x1F) << 19) |
+		(p_param->transform8x8_enable << 29) |
+		(p_param->entropy_coding_mode << 30);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_PPS_PARAM, reg_val);
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_GOP_PARAM, p_param->gop_preset_idx);
+
+	if (vpu_inst->std == W_AVC_ENC)
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_INTRA_PARAM, (p_param->intra_qp << 0) |
+				((p_param->intra_period & 0x7ff) << 6) |
+				((p_param->avc_idr_period & 0x7ff) << 17) |
+				((p_param->forced_idr_header_enable & 3) << 28));
+	else
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_INTRA_PARAM,
+			      (p_param->decoding_refresh_type << 0) | (p_param->intra_qp << 3) |
+				(p_param->forced_idr_header_enable << 9) |
+				(p_param->intra_period << 16));
+
+	reg_val = (p_param->use_recommend_enc_param) |
+		(p_param->rdo_skip << 2) |
+		(p_param->lambda_scaling_enable << 3) |
+		(p_param->coef_clear_disable << 4) |
+		(fixed_cu_size_mode << 5) |
+		(p_param->intra_nx_n_enable << 8) |
+		(p_param->max_num_merge << 18) |
+		(p_param->custom_md_enable << 20) |
+		(p_param->custom_lambda_enable << 21) |
+		(p_param->monochrome_enable << 22);
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_RDO_PARAM, reg_val);
+
+	if (vpu_inst->std == W_AVC_ENC)
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_INTRA_REFRESH,
+			      p_param->intra_mb_refresh_arg << 16 | p_param->intra_mb_refresh_mode);
+	else
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_INTRA_REFRESH,
+			      p_param->intra_refresh_arg << 16 | p_param->intra_refresh_mode);
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_RC_FRAME_RATE, p_open_param->frame_rate_info);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_RC_TARGET_RATE, p_open_param->bit_rate);
+
+	if (vpu_inst->std == W_AVC_ENC)
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_RC_PARAM,
+			      (p_open_param->rc_enable << 0) |
+				(p_param->mb_level_rc_enable << 1) |
+				(p_param->hvs_qp_enable << 2) |
+				(p_param->hvs_qp_scale << 4) |
+				(p_param->bit_alloc_mode << 8) |
+				(p_param->roi_enable << 13) |
+				((p_param->initial_rc_qp & 0x3F) << 14) |
+				(p_open_param->vbv_buffer_size << 20));
+	else
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_RC_PARAM,
+			      (p_open_param->rc_enable << 0) |
+				(p_param->cu_level_rc_enable << 1) |
+				(p_param->hvs_qp_enable << 2) |
+				(p_param->hvs_qp_scale << 4) |
+				(p_param->bit_alloc_mode << 8) |
+				(p_param->roi_enable << 13) |
+				((p_param->initial_rc_qp & 0x3F) << 14) |
+				(p_open_param->vbv_buffer_size << 20));
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_RC_WEIGHT_PARAM,
+		      p_param->rc_weight_buf << 8 | p_param->rc_weight_param);
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_RC_MIN_MAX_QP, (p_param->min_qp_i << 0) |
+			(p_param->max_qp_i << 6) |
+			(p_param->hvs_max_delta_qp << 12));
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_RC_INTER_MIN_MAX_QP, (p_param->min_qp_p << 0) |
+			(p_param->max_qp_p << 6) |
+			(p_param->min_qp_b << 12) |
+			(p_param->max_qp_b << 18));
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_RC_BIT_RATIO_LAYER_0_3,
+		      ((uint32_t)p_param->fixed_bit_ratio[0] << 0) |
+			((uint32_t)p_param->fixed_bit_ratio[1] << 8) |
+			((uint32_t)p_param->fixed_bit_ratio[2] << 16) |
+			((uint32_t)p_param->fixed_bit_ratio[3] << 24));
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_RC_BIT_RATIO_LAYER_4_7,
+		      ((uint32_t)p_param->fixed_bit_ratio[4] << 0) |
+			((uint32_t)p_param->fixed_bit_ratio[5] << 8) |
+			((uint32_t)p_param->fixed_bit_ratio[6] << 16) |
+			((uint32_t)p_param->fixed_bit_ratio[7] << 24));
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_ROT_PARAM, rot_mir_mode);
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_BG_PARAM, (p_param->bg_detect_enable) |
+			(p_param->bg_thr_diff << 1) |
+			(p_param->bg_thr_mean_diff << 10) |
+			(p_param->bg_lambda_qp << 18) |
+			((p_param->bg_delta_qp & 0x1F) << 24) |
+			(vpu_inst->std == W_AVC_ENC ? p_param->s2fme_disable << 29 : 0));
+
+	if (vpu_inst->std == W_HEVC_ENC || vpu_inst->std == W_AVC_ENC) {
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_CUSTOM_LAMBDA_ADDR,
+			      p_param->custom_lambda_addr);
+
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_CONF_WIN_TOP_BOT,
+			      p_param->conf_win_bot << 16 | p_param->conf_win_top);
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_CONF_WIN_LEFT_RIGHT,
+			      p_param->conf_win_right << 16 | p_param->conf_win_left);
+
+		if (vpu_inst->std == W_AVC_ENC)
+			vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_INDEPENDENT_SLICE,
+				      p_param->avc_slice_arg << 16 | p_param->avc_slice_mode);
+		else
+			vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_INDEPENDENT_SLICE,
+				      p_param->independ_slice_mode_arg << 16 |
+				 p_param->independ_slice_mode);
+
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_USER_SCALING_LIST_ADDR,
+			      p_param->user_scaling_list_addr);
+
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_NUM_UNITS_IN_TICK,
+			      p_param->num_units_in_tick);
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_TIME_SCALE, p_param->time_scale);
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_NUM_TICKS_POC_DIFF_ONE,
+			      p_param->num_ticks_poc_diff_one);
+	}
+
+	if (vpu_inst->std == W_HEVC_ENC) {
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_CUSTOM_MD_PU04,
+			      (p_param->pu04_delta_rate & 0xFF) |
+				((p_param->pu04_intra_planar_delta_rate & 0xFF) << 8) |
+				((p_param->pu04_intra_dc_delta_rate & 0xFF) << 16) |
+				((p_param->pu04_intra_angle_delta_rate & 0xFF) << 24));
+
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_CUSTOM_MD_PU08,
+			      (p_param->pu08_delta_rate & 0xFF) |
+				((p_param->pu08_intra_planar_delta_rate & 0xFF) << 8) |
+				((p_param->pu08_intra_dc_delta_rate & 0xFF) << 16) |
+				((p_param->pu08_intra_angle_delta_rate & 0xFF) << 24));
+
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_CUSTOM_MD_PU16,
+			      (p_param->pu16_delta_rate & 0xFF) |
+				((p_param->pu16_intra_planar_delta_rate & 0xFF) << 8) |
+				((p_param->pu16_intra_dc_delta_rate & 0xFF) << 16) |
+				((p_param->pu16_intra_angle_delta_rate & 0xFF) << 24));
+
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_CUSTOM_MD_PU32,
+			      (p_param->pu32_delta_rate & 0xFF) |
+				((p_param->pu32_intra_planar_delta_rate & 0xFF) << 8) |
+				((p_param->pu32_intra_dc_delta_rate & 0xFF) << 16) |
+				((p_param->pu32_intra_angle_delta_rate & 0xFF) << 24));
+
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_CUSTOM_MD_CU08,
+			      (p_param->cu08_intra_delta_rate & 0xFF) |
+				((p_param->cu08_inter_delta_rate & 0xFF) << 8) |
+				((p_param->cu08_merge_delta_rate & 0xFF) << 16));
+
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_CUSTOM_MD_CU16,
+			      (p_param->cu16_intra_delta_rate & 0xFF) |
+				((p_param->cu16_inter_delta_rate & 0xFF) << 8) |
+				((p_param->cu16_merge_delta_rate & 0xFF) << 16));
+
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_CUSTOM_MD_CU32,
+			      (p_param->cu32_intra_delta_rate & 0xFF) |
+				((p_param->cu32_inter_delta_rate & 0xFF) << 8) |
+				((p_param->cu32_merge_delta_rate & 0xFF) << 16));
+
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_DEPENDENT_SLICE,
+			      p_param->depend_slice_mode_arg << 16 | p_param->depend_slice_mode);
+
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_NR_PARAM, (p_param->nr_y_enable << 0) |
+				(p_param->nr_cb_enable << 1) |
+				(p_param->nr_cr_enable << 2) |
+				(p_param->nr_noise_est_enable << 3) |
+				(p_param->nr_noise_sigma_y << 4) |
+				(p_param->nr_noise_sigma_cb << 12) |
+				(p_param->nr_noise_sigma_cr << 20));
+
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_NR_WEIGHT,
+			      (p_param->nr_intra_weight_y << 0) |
+				(p_param->nr_intra_weight_cb << 5) |
+				(p_param->nr_intra_weight_cr << 10) |
+				(p_param->nr_inter_weight_y << 15) |
+				(p_param->nr_inter_weight_cb << 20) |
+				(p_param->nr_inter_weight_cr << 25));
+	}
+	if (p_enc_info->open_param.encode_vui_rbsp || p_enc_info->open_param.enc_hrd_rbsp_in_vps) {
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_VUI_HRD_PARAM,
+			      (p_enc_info->open_param.hrd_rbsp_data_size << 18) |
+				(p_enc_info->open_param.vui_rbsp_data_size << 4) |
+				(p_enc_info->open_param.enc_hrd_rbsp_in_vps << 2) |
+				(p_enc_info->open_param.encode_vui_rbsp));
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_VUI_RBSP_ADDR,
+			      p_enc_info->open_param.vui_rbsp_data_addr);
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_HRD_RBSP_ADDR,
+			      p_enc_info->open_param.hrd_rbsp_data_addr);
+	} else {
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_SEQ_VUI_HRD_PARAM, 0);
+	}
+
+	wave5_bit_issue_command(vpu_inst, W5_ENC_SET_PARAM);
+
+	ret = wave5_wait_vpu_busy(vpu_inst->dev, VPU_BUSY_CHECK_TIMEOUT, W5_VPU_BUSY_STATUS);
+	if (ret) {
+		dev_warn(vpu_inst->dev->dev, "enc set param timed out\n");
+		return ret;
+	}
+
+	if (!vpu_read_reg(vpu_inst->dev, W5_RET_SUCCESS)) {
+		reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_FAIL_REASON);
+		wave5_print_reg_err(vpu_inst->dev, reg_val);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int wave5_vpu_enc_get_seq_info(struct vpu_instance *vpu_inst, struct enc_initial_info *info)
+{
+	int ret;
+	u32 reg_val;
+	struct enc_info *p_enc_info = &vpu_inst->codec_info->enc_info;
+
+	if (vpu_inst->dev->product != PRODUCT_ID_521)
+		return -EINVAL;
+
+	// send QUERY cmd
+	ret = wave5_send_query(vpu_inst, GET_RESULT);
+	if (ret) {
+		if (ret == -EIO) {
+			reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_FAIL_REASON);
+			wave5_print_reg_err(vpu_inst->dev, reg_val);
+		}
+		return ret;
+	}
+
+	dev_dbg(vpu_inst->dev->dev, "init seq\n");
+
+	reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_QUEUE_STATUS);
+
+	p_enc_info->instance_queue_count = (reg_val >> 16) & 0xff;
+	p_enc_info->report_queue_count = (reg_val & 0xffff);
+
+	if (vpu_read_reg(vpu_inst->dev, W5_RET_ENC_ENCODING_SUCCESS) != 1) {
+		info->seq_init_err_reason = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_ERR_INFO);
+		ret = -EIO;
+	} else {
+		info->warn_info = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_WARN_INFO);
+	}
+
+	info->min_frame_buffer_count = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_NUM_REQUIRED_FB);
+	info->min_src_frame_count = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_MIN_SRC_BUF_NUM);
+	info->max_latency_pictures = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_PIC_MAX_LATENCY_PICS);
+	info->vlc_buf_size = vpu_read_reg(vpu_inst->dev, W5_RET_VLC_BUF_SIZE);
+	info->param_buf_size = vpu_read_reg(vpu_inst->dev, W5_RET_PARAM_BUF_SIZE);
+	p_enc_info->vlc_buf_size = info->vlc_buf_size;
+	p_enc_info->param_buf_size = info->param_buf_size;
+
+	return ret;
+}
+
+int wave5_vpu_enc_register_framebuffer(struct device *dev, struct vpu_instance *vpu_inst,
+				       struct frame_buffer *fb_arr, enum tiled_map_type map_type,
+				       uint32_t count)
+{
+	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
+	int ret = 0;
+	u32 stride;
+	u32 start_no, end_no;
+	size_t remain, idx, j, i, cnt_8_chunk;
+	u32 reg_val = 0, pic_size = 0, mv_col_size, fbc_y_tbl_size, fbc_c_tbl_size;
+	u32	sub_sampled_size = 0;
+	u32 endian, nv21 = 0, cbcr_interleave = 0, luma_stride, chroma_stride;
+	u32	buf_height = 0, buf_width = 0;
+	struct vpu_buf vb_mv = {0,};
+	struct vpu_buf vb_fbc_y_tbl = {0,};
+	struct vpu_buf vb_fbc_c_tbl = {0,};
+	struct vpu_buf vb_sub_sam_buf = {0,};
+	struct vpu_buf vb_task = {0,};
+	struct enc_open_param *p_open_param;
+	struct enc_info *p_enc_info = &vpu_inst->codec_info->enc_info;
+
+	p_open_param = &p_enc_info->open_param;
+	mv_col_size = 0;
+	fbc_y_tbl_size = 0;
+	fbc_c_tbl_size = 0;
+	stride = p_enc_info->stride;
+
+	if (vpu_inst->std == W_AVC_ENC) {
+		buf_width = ALIGN(p_open_param->pic_width, 16);
+		buf_height = ALIGN(p_open_param->pic_height, 16);
+
+		if ((p_enc_info->rotation_angle || p_enc_info->mirror_direction) &&
+		    !(p_enc_info->rotation_angle == 180 &&
+					p_enc_info->mirror_direction == MIRDIR_HOR_VER)) {
+			buf_width = ALIGN(p_open_param->pic_width, 16);
+			buf_height = ALIGN(p_open_param->pic_height, 16);
+		}
+
+		if (p_enc_info->rotation_angle == 90 || p_enc_info->rotation_angle == 270) {
+			buf_width = ALIGN(p_open_param->pic_height, 16);
+			buf_height = ALIGN(p_open_param->pic_width, 16);
+		}
+	} else {
+		buf_width = ALIGN(p_open_param->pic_width, 8);
+		buf_height = ALIGN(p_open_param->pic_height, 8);
+
+		if ((p_enc_info->rotation_angle || p_enc_info->mirror_direction) &&
+		    !(p_enc_info->rotation_angle == 180 &&
+					p_enc_info->mirror_direction == MIRDIR_HOR_VER)) {
+			buf_width = ALIGN(p_open_param->pic_width, 32);
+			buf_height = ALIGN(p_open_param->pic_height, 32);
+		}
+
+		if (p_enc_info->rotation_angle == 90 || p_enc_info->rotation_angle == 270) {
+			buf_width = ALIGN(p_open_param->pic_height, 32);
+			buf_height = ALIGN(p_open_param->pic_width, 32);
+		}
+	}
+
+	pic_size = (buf_width << 16) | buf_height;
+
+	if (vpu_inst->std == W_HEVC_ENC) {
+		mv_col_size = WAVE5_ENC_HEVC_BUF_SIZE(buf_width, buf_height);
+		mv_col_size = ALIGN(mv_col_size, 16);
+		vb_mv.daddr = 0;
+		/* 4096 is a margin */
+		vb_mv.size = ALIGN(mv_col_size * count, 4096) + 4096;
+	} else if (vpu_inst->std == W_AVC_ENC) {
+		mv_col_size = WAVE5_ENC_AVC_BUF_SIZE(buf_width, buf_height);
+		vb_mv.daddr = 0;
+		/* 4096 is a margin */
+		vb_mv.size = ALIGN(mv_col_size * count, 4096) + 4096;
+	}
+
+	ret = wave5_vdi_allocate_dma_memory(vpu_dev, &vb_mv);
+	if (ret)
+		return ret;
+
+	p_enc_info->vb_mv = vb_mv;
+
+	if (p_enc_info->product_code == WAVE521C_DUAL_CODE) {
+		u32 bgs_width, ot_bg_width, comp_frm_width, ot_frm_width, ot_bg_height,
+		 bgs_height, comp_frm_height, ot_frm_height;
+		u32 frm_width, frm_height;
+		u32 dual_width = buf_width;
+		u32 dual_height = buf_height;
+
+		bgs_width = (p_open_param->wave_param.internal_bit_depth > 8 ? 256 : 512);
+
+		if (vpu_inst->std == W_AVC_ENC)
+			ot_bg_width = 1024;
+		else // if (vpu_inst->std == W_HEVC_ENC)
+			ot_bg_width = 512;
+
+		frm_width = ALIGN(dual_width, 16);
+		frm_height = ALIGN(dual_height, 16);
+		// valid_width = align(width, 16), comp_frm_width = align(valid_width+pad_x, 16)
+		comp_frm_width = ALIGN(ALIGN(frm_width, 16) + 16, 16);
+		// 1024 = offset table BG width
+		ot_frm_width = ALIGN(comp_frm_width, ot_bg_width);
+
+		// sizeof_offset_table()
+		ot_bg_height = 32;
+		bgs_height = BIT(14) / bgs_width;
+		if (p_open_param->wave_param.internal_bit_depth > 8)
+			bgs_height /= 2;
+		comp_frm_height = ALIGN(ALIGN(frm_height, 4) + 4, bgs_height);
+		ot_frm_height = ALIGN(comp_frm_height, ot_bg_height);
+		fbc_y_tbl_size = (ot_frm_width / 16) * (ot_frm_height / 4) * 2;
+	} else {
+		fbc_y_tbl_size = WAVE5_FBC_LUMA_TABLE_SIZE(buf_width, buf_height);
+		fbc_y_tbl_size = ALIGN(fbc_y_tbl_size, 16);
+	}
+
+	vb_fbc_y_tbl.daddr = 0;
+	vb_fbc_y_tbl.size = ALIGN(fbc_y_tbl_size * count, 4096) + 4096;
+	ret = wave5_vdi_allocate_dma_memory(vpu_dev, &vb_fbc_y_tbl);
+	if (ret)
+		return ret;
+
+	p_enc_info->vb_fbc_y_tbl = vb_fbc_y_tbl;
+
+	if (p_enc_info->product_code == WAVE521C_DUAL_CODE) {
+		u32 bgs_width, ot_bg_width, comp_frm_width, ot_frm_width, ot_bg_height,
+		 bgs_height, comp_frm_height, ot_frm_height;
+		u32 frm_width, frm_height;
+		u32 dual_width = buf_width;
+		u32 dual_height = buf_height;
+
+		bgs_width = (p_open_param->wave_param.internal_bit_depth > 8 ? 256 : 512);
+
+		if (vpu_inst->std == W_AVC_ENC)
+			ot_bg_width = 1024;
+		else // if (vpu_inst->std == W_HEVC_ENC)
+			ot_bg_width = 512;
+
+		frm_width = ALIGN(dual_width, 16);
+		frm_height = ALIGN(dual_height, 16);
+		// valid_width = align(width, 16), comp_frm_width = align(valid_width+pad_x, 16)
+		comp_frm_width = ALIGN(ALIGN(frm_width / 2, 16) + 16, 16);
+		// 1024 = offset table BG width
+		ot_frm_width = ALIGN(comp_frm_width, ot_bg_width);
+
+		// sizeof_offset_table()
+		ot_bg_height = 32;
+		bgs_height = BIT(14) / bgs_width;
+		if (p_open_param->wave_param.internal_bit_depth > 8)
+			bgs_height /= 2;
+
+		comp_frm_height = ALIGN(ALIGN(frm_height, 4) + 4, bgs_height);
+		ot_frm_height = ALIGN(comp_frm_height, ot_bg_height);
+		fbc_c_tbl_size = (ot_frm_width / 16) * (ot_frm_height / 4) * 2;
+	} else {
+		fbc_c_tbl_size = WAVE5_FBC_CHROMA_TABLE_SIZE(buf_width, buf_height);
+		fbc_c_tbl_size = ALIGN(fbc_c_tbl_size, 16);
+	}
+
+	vb_fbc_c_tbl.daddr = 0;
+	vb_fbc_c_tbl.size = ALIGN(fbc_c_tbl_size * count, 4096) + 4096;
+	ret = wave5_vdi_allocate_dma_memory(vpu_dev, &vb_fbc_c_tbl);
+	if (ret)
+		return ret;
+
+	p_enc_info->vb_fbc_c_tbl = vb_fbc_c_tbl;
+
+	if (vpu_inst->std == W_AVC_ENC)
+		sub_sampled_size = WAVE5_SUBSAMPLED_ONE_SIZE_AVC(buf_width, buf_height);
+	else
+		sub_sampled_size = WAVE5_SUBSAMPLED_ONE_SIZE(buf_width, buf_height);
+	vb_sub_sam_buf.size = ALIGN(sub_sampled_size * count, 4096) + 4096;
+	vb_sub_sam_buf.daddr = 0;
+	ret = wave5_vdi_allocate_dma_memory(vpu_dev, &vb_sub_sam_buf);
+	if (ret)
+		return ret;
+
+	p_enc_info->vb_sub_sam_buf = vb_sub_sam_buf;
+
+	vb_task.size = (p_enc_info->vlc_buf_size * VLC_BUF_NUM) +
+			(p_enc_info->param_buf_size * COMMAND_QUEUE_DEPTH);
+	vb_task.daddr = 0;
+	if (p_enc_info->vb_task.size == 0) {
+		ret = wave5_vdi_allocate_dma_memory(vpu_dev, &vb_task);
+		if (ret)
+			return ret;
+
+		p_enc_info->vb_task = vb_task;
+
+		vpu_write_reg(vpu_inst->dev, W5_CMD_SET_FB_ADDR_TASK_BUF,
+			      p_enc_info->vb_task.daddr);
+		vpu_write_reg(vpu_inst->dev, W5_CMD_SET_FB_TASK_BUF_SIZE, vb_task.size);
+	}
+
+	// set sub-sampled buffer base addr
+	vpu_write_reg(vpu_inst->dev, W5_ADDR_SUB_SAMPLED_FB_BASE, vb_sub_sam_buf.daddr);
+	// set sub-sampled buffer size for one frame
+	vpu_write_reg(vpu_inst->dev, W5_SUB_SAMPLED_ONE_FB_SIZE, sub_sampled_size);
+
+	endian = wave5_vdi_convert_endian(vpu_dev, fb_arr[0].endian);
+
+	vpu_write_reg(vpu_inst->dev, W5_PIC_SIZE, pic_size);
+
+	// set stride of luma/chroma for compressed buffer
+	if ((p_enc_info->rotation_angle || p_enc_info->mirror_direction) &&
+	    !(p_enc_info->rotation_angle == 180 &&
+				p_enc_info->mirror_direction == MIRDIR_HOR_VER)) {
+		luma_stride = ALIGN(buf_width, 16) *
+			(p_open_param->wave_param.internal_bit_depth > 8 ? 5 : 4);
+		luma_stride = ALIGN(luma_stride, 32);
+		chroma_stride = ALIGN(buf_width / 2, 16) *
+			(p_open_param->wave_param.internal_bit_depth > 8 ? 5 : 4);
+		chroma_stride = ALIGN(chroma_stride, 32);
+	} else {
+		luma_stride = ALIGN(p_open_param->pic_width, 16) *
+			(p_open_param->wave_param.internal_bit_depth > 8 ? 5 : 4);
+		luma_stride = ALIGN(luma_stride, 32);
+		chroma_stride = ALIGN(p_open_param->pic_width / 2, 16) *
+			(p_open_param->wave_param.internal_bit_depth > 8 ? 5 : 4);
+		chroma_stride = ALIGN(chroma_stride, 32);
+	}
+
+	vpu_write_reg(vpu_inst->dev, W5_FBC_STRIDE, luma_stride << 16 | chroma_stride);
+
+	cbcr_interleave = p_open_param->cbcr_interleave;
+	reg_val = (nv21 << 29) |
+		(cbcr_interleave << 16) |
+		(stride);
+
+	vpu_write_reg(vpu_inst->dev, W5_COMMON_PIC_INFO, reg_val);
+
+	remain = count;
+	cnt_8_chunk = (count + 7) / 8;
+	idx = 0;
+	for (j = 0; j < cnt_8_chunk; j++) {
+		reg_val = (endian << 16) | (j == cnt_8_chunk - 1) << 4 | ((j == 0) << 3);
+		reg_val |= (p_open_param->enable_non_ref_fbc_write << 26);
+		vpu_write_reg(vpu_inst->dev, W5_SFB_OPTION, reg_val);
+		start_no = j * 8;
+		end_no = start_no + (remain >= 8 ? 8 : remain) - 1;
+
+		vpu_write_reg(vpu_inst->dev, W5_SET_FB_NUM, (start_no << 8) | end_no);
+
+		for (i = 0; i < 8 && i < remain; i++) {
+			vpu_write_reg(vpu_inst->dev, W5_ADDR_LUMA_BASE0 + (i << 4), fb_arr[i +
+					start_no].buf_y);
+			vpu_write_reg(vpu_inst->dev, W5_ADDR_CB_BASE0 + (i << 4),
+				      fb_arr[i + start_no].buf_cb);
+			/* luma FBC offset table */
+			vpu_write_reg(vpu_inst->dev, W5_ADDR_FBC_Y_OFFSET0 + (i << 4),
+				      vb_fbc_y_tbl.daddr + idx * fbc_y_tbl_size);
+			/* chroma FBC offset table */
+			vpu_write_reg(vpu_inst->dev, W5_ADDR_FBC_C_OFFSET0 + (i << 4),
+				      vb_fbc_c_tbl.daddr + idx * fbc_c_tbl_size);
+
+			vpu_write_reg(vpu_inst->dev, W5_ADDR_MV_COL0 + (i << 2),
+				      vb_mv.daddr + idx * mv_col_size);
+			idx++;
+		}
+		remain -= i;
+
+		wave5_bit_issue_command(vpu_inst, W5_SET_FB);
+		ret = wave5_wait_vpu_busy(vpu_inst->dev, VPU_BUSY_CHECK_TIMEOUT,
+					  W5_VPU_BUSY_STATUS);
+		if (ret)
+			return ret;
+	}
+
+	reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_SUCCESS);
+	if (!reg_val)
+		return -EIO;
+
+	return ret;
+}
+
+int wave5_vpu_encode(struct vpu_instance *vpu_inst, struct enc_param *option, u32 *fail_res)
+{
+	s32 src_frame_format;
+	u32 reg_val = 0, bs_endian;
+	u32 src_stride_c = 0;
+	struct enc_info *p_enc_info = &vpu_inst->codec_info->enc_info;
+	struct frame_buffer *p_src_frame = option->source_frame;
+	struct enc_open_param *p_open_param = &p_enc_info->open_param;
+	bool justified = WTL_RIGHT_JUSTIFIED;
+	u32 format_no = WTL_PIXEL_8BIT;
+	int ret;
+
+	if (vpu_inst->dev->product != PRODUCT_ID_521)
+		return -EINVAL;
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_BS_START_ADDR, option->pic_stream_buffer_addr);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_BS_SIZE, option->pic_stream_buffer_size);
+	p_enc_info->stream_buf_start_addr = option->pic_stream_buffer_addr;
+	p_enc_info->stream_buf_size = option->pic_stream_buffer_size;
+	p_enc_info->stream_buf_end_addr =
+		option->pic_stream_buffer_addr + option->pic_stream_buffer_size;
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_SRC_AXI_SEL, DEFAULT_SRC_AXI);
+	/* secondary AXI */
+	reg_val = (p_enc_info->sec_axi_info.wave.use_enc_rdo_enable << 11) |
+		(p_enc_info->sec_axi_info.wave.use_enc_lf_enable << 15);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_USE_SEC_AXI, reg_val);
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_REPORT_PARAM, 0);
+
+	/*
+	 * CODEOPT_ENC_VCL is used to implicitly encode a header(headers) for
+	 * generating bitstream. (to encode a header
+	 * only, use ENC_PUT_VIDEO_HEADER for
+	 * give_command)
+	 */
+
+	if (option->code_option.implicit_header_encode == 1)
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_CODE_OPTION,
+			      CODEOPT_ENC_HEADER_IMPLICIT | CODEOPT_ENC_VCL |
+			      (option->code_option.encode_aud << 5) |
+			      (option->code_option.encode_eos << 6) |
+			      (option->code_option.encode_eob << 7));
+	else
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_CODE_OPTION,
+			      (option->code_option.implicit_header_encode << 0) |
+				(option->code_option.encode_vcl << 1) |
+				(option->code_option.encode_vps << 2) |
+				(option->code_option.encode_sps << 3) |
+				(option->code_option.encode_pps << 4) |
+				(option->code_option.encode_aud << 5) |
+				(option->code_option.encode_eos << 6) |
+				(option->code_option.encode_eob << 7));
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_PIC_PARAM, (option->skip_picture << 0) |
+			(option->force_pic_qp_enable << 1) |
+			(option->force_pic_qp_i << 2) |
+			(option->force_pic_qp_p << 8) |
+			(option->force_pic_qp_b << 14) |
+			(option->force_pic_type_enable << 20) |
+			(option->force_pic_type << 21) |
+			(option->force_all_ctu_coef_drop_enable << 24));
+
+	if (option->src_end_flag == 1)
+		// no more source image.
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_SRC_PIC_IDX, 0xFFFFFFFF);
+	else
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_SRC_PIC_IDX, option->src_idx);
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_SRC_ADDR_Y, p_src_frame->buf_y);
+	if (p_open_param->cbcr_order == CBCR_ORDER_NORMAL) {
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_SRC_ADDR_U, p_src_frame->buf_cb);
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_SRC_ADDR_V, p_src_frame->buf_cr);
+	} else {
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_SRC_ADDR_U, p_src_frame->buf_cr);
+		vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_SRC_ADDR_V, p_src_frame->buf_cb);
+	}
+
+	switch (p_open_param->src_format) {
+	case FORMAT_420:
+	case FORMAT_422:
+	case FORMAT_YUYV:
+	case FORMAT_YVYU:
+	case FORMAT_UYVY:
+	case FORMAT_VYUY:
+		justified = WTL_LEFT_JUSTIFIED;
+		format_no = WTL_PIXEL_8BIT;
+		src_stride_c = (p_src_frame->cbcr_interleave == 1) ? p_src_frame->stride :
+			(p_src_frame->stride / 2);
+		src_stride_c = (p_open_param->src_format == FORMAT_422) ? src_stride_c * 2 :
+			src_stride_c;
+		break;
+	case FORMAT_420_P10_16BIT_MSB:
+	case FORMAT_422_P10_16BIT_MSB:
+	case FORMAT_YUYV_P10_16BIT_MSB:
+	case FORMAT_YVYU_P10_16BIT_MSB:
+	case FORMAT_UYVY_P10_16BIT_MSB:
+	case FORMAT_VYUY_P10_16BIT_MSB:
+		justified = WTL_RIGHT_JUSTIFIED;
+		format_no = WTL_PIXEL_16BIT;
+		src_stride_c = (p_src_frame->cbcr_interleave == 1) ? p_src_frame->stride :
+			(p_src_frame->stride / 2);
+		src_stride_c = (p_open_param->src_format ==
+				FORMAT_422_P10_16BIT_MSB) ? src_stride_c * 2 : src_stride_c;
+		break;
+	case FORMAT_420_P10_16BIT_LSB:
+	case FORMAT_422_P10_16BIT_LSB:
+	case FORMAT_YUYV_P10_16BIT_LSB:
+	case FORMAT_YVYU_P10_16BIT_LSB:
+	case FORMAT_UYVY_P10_16BIT_LSB:
+	case FORMAT_VYUY_P10_16BIT_LSB:
+		justified = WTL_LEFT_JUSTIFIED;
+		format_no = WTL_PIXEL_16BIT;
+		src_stride_c = (p_src_frame->cbcr_interleave == 1) ? p_src_frame->stride :
+			(p_src_frame->stride / 2);
+		src_stride_c = (p_open_param->src_format ==
+				FORMAT_422_P10_16BIT_LSB) ? src_stride_c * 2 : src_stride_c;
+		break;
+	case FORMAT_420_P10_32BIT_MSB:
+	case FORMAT_422_P10_32BIT_MSB:
+	case FORMAT_YUYV_P10_32BIT_MSB:
+	case FORMAT_YVYU_P10_32BIT_MSB:
+	case FORMAT_UYVY_P10_32BIT_MSB:
+	case FORMAT_VYUY_P10_32BIT_MSB:
+		justified = WTL_RIGHT_JUSTIFIED;
+		format_no = WTL_PIXEL_32BIT;
+		src_stride_c = (p_src_frame->cbcr_interleave == 1) ? p_src_frame->stride :
+			ALIGN(p_src_frame->stride / 2, 16) * BIT(p_src_frame->cbcr_interleave);
+		src_stride_c = (p_open_param->src_format ==
+				FORMAT_422_P10_32BIT_MSB) ? src_stride_c * 2 : src_stride_c;
+		break;
+	case FORMAT_420_P10_32BIT_LSB:
+	case FORMAT_422_P10_32BIT_LSB:
+	case FORMAT_YUYV_P10_32BIT_LSB:
+	case FORMAT_YVYU_P10_32BIT_LSB:
+	case FORMAT_UYVY_P10_32BIT_LSB:
+	case FORMAT_VYUY_P10_32BIT_LSB:
+		justified = WTL_LEFT_JUSTIFIED;
+		format_no = WTL_PIXEL_32BIT;
+		src_stride_c = (p_src_frame->cbcr_interleave == 1) ? p_src_frame->stride :
+			ALIGN(p_src_frame->stride / 2, 16) * BIT(p_src_frame->cbcr_interleave);
+		src_stride_c = (p_open_param->src_format ==
+				FORMAT_422_P10_32BIT_LSB) ? src_stride_c * 2 : src_stride_c;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	src_frame_format = (p_open_param->cbcr_interleave << 1) | (p_open_param->nv21);
+	switch (p_open_param->packed_format) {
+	case PACKED_YUYV:
+		src_frame_format = 4; break;
+	case PACKED_YVYU:
+		src_frame_format = 5; break;
+	case PACKED_UYVY:
+		src_frame_format = 6; break;
+	case PACKED_VYUY:
+		src_frame_format = 7; break;
+	default:
+		break;
+	}
+
+	reg_val = wave5_vdi_convert_endian(vpu_inst->dev, p_open_param->source_endian);
+	bs_endian = (~reg_val & VDI_128BIT_ENDIAN_MASK);
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_SRC_STRIDE,
+		      (p_src_frame->stride << 16) | src_stride_c);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_SRC_FORMAT, (src_frame_format << 0) |
+			(format_no << 3) |
+			(justified << 5) |
+			(bs_endian << 6));
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_CUSTOM_MAP_OPTION_ADDR,
+		      option->custom_map_opt.addr_custom_map);
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_CUSTOM_MAP_OPTION_PARAM,
+		      (option->custom_map_opt.custom_roi_map_enable << 0) |
+			(option->custom_map_opt.roi_avg_qp << 1) |
+			(option->custom_map_opt.custom_lambda_map_enable << 8) |
+			(option->custom_map_opt.custom_mode_map_enable << 9) |
+			(option->custom_map_opt.custom_coef_drop_enable << 10));
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_LONGTERM_PIC,
+		      (option->use_cur_src_as_longterm_pic << 0) | (option->use_longterm_ref << 1));
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_WP_PIXEL_SIGMA_Y, option->wp_pix_sigma_y);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_WP_PIXEL_SIGMA_C,
+		      (option->wp_pix_sigma_cr << 16) | option->wp_pix_sigma_cb);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_WP_PIXEL_MEAN_Y, option->wp_pix_mean_y);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_WP_PIXEL_MEAN_C,
+		      (option->wp_pix_mean_cr << 16) | (option->wp_pix_mean_cb));
+
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_PREFIX_SEI_INFO, 0);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_PREFIX_SEI_NAL_ADDR, 0);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_SUFFIX_SEI_INFO, 0);
+	vpu_write_reg(vpu_inst->dev, W5_CMD_ENC_PIC_SUFFIX_SEI_NAL_ADDR, 0);
+
+	wave5_bit_issue_command(vpu_inst, W5_ENC_PIC);
+
+	// check QUEUE_DONE
+	ret = wave5_wait_vpu_busy(vpu_inst->dev, VPU_BUSY_CHECK_TIMEOUT, W5_VPU_BUSY_STATUS);
+	if (ret) {
+		dev_warn(vpu_inst->dev->dev, "enc pic timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_QUEUE_STATUS);
+
+	p_enc_info->instance_queue_count = (reg_val >> 16) & 0xff;
+	p_enc_info->report_queue_count = (reg_val & 0xffff);
+
+	// FAILED for adding a command into VCPU QUEUE
+	if (!vpu_read_reg(vpu_inst->dev, W5_RET_SUCCESS)) {
+		*fail_res = vpu_read_reg(vpu_inst->dev, W5_RET_FAIL_REASON);
+		wave5_print_reg_err(vpu_inst->dev, *fail_res);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int wave5_vpu_enc_get_result(struct vpu_instance *vpu_inst, struct enc_output_info *result)
+{
+	int ret;
+	u32 encoding_success;
+	u32 reg_val;
+	struct enc_info *p_enc_info = &vpu_inst->codec_info->enc_info;
+	struct vpu_device *vpu_dev = vpu_inst->dev;
+
+	if (vpu_dev->product != PRODUCT_ID_521)
+		return -EINVAL;
+
+	ret = wave5_send_query(vpu_inst, GET_RESULT);
+	if (ret) {
+		if (ret == -EIO) {
+			reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_FAIL_REASON);
+			wave5_print_reg_err(vpu_inst->dev, reg_val);
+		}
+		return ret;
+	}
+	dev_dbg(vpu_inst->dev->dev, "enc pic complete\n");
+
+	reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_QUEUE_STATUS);
+
+	p_enc_info->instance_queue_count = (reg_val >> 16) & 0xff;
+	p_enc_info->report_queue_count = (reg_val & 0xffff);
+
+	encoding_success = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_ENCODING_SUCCESS);
+	if (!encoding_success) {
+		result->error_reason = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_ERR_INFO);
+		return -EIO;
+	}
+
+	result->warn_info = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_WARN_INFO);
+
+	result->enc_pic_cnt = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_PIC_NUM);
+	reg_val = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_PIC_TYPE);
+	result->pic_type = reg_val & 0xFFFF;
+
+	result->enc_vcl_nut = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_VCL_NUT);
+	result->recon_frame_index = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_PIC_IDX);
+
+	if (result->recon_frame_index >= 0)
+		result->recon_frame = vpu_inst->frame_buf[result->recon_frame_index];
+
+	result->num_of_slices = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_PIC_SLICE_NUM);
+	result->pic_skipped = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_PIC_SKIP);
+	result->num_of_intra = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_PIC_NUM_INTRA);
+	result->num_of_merge = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_PIC_NUM_MERGE);
+	result->num_of_skip_block = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_PIC_NUM_SKIP);
+	result->bitstream_wrap_around = 0; // only support line-buffer mode.
+
+	result->avg_ctu_qp = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_PIC_AVG_CTU_QP);
+	result->enc_pic_byte = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_PIC_BYTE);
+
+	result->enc_gop_pic_idx = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_GOP_PIC_IDX);
+	result->enc_pic_poc = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_PIC_POC);
+	result->enc_src_idx = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_USED_SRC_IDX);
+	result->release_src_flag = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_SRC_BUF_FLAG);
+	p_enc_info->stream_wr_ptr = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_WR_PTR);
+	p_enc_info->stream_rd_ptr = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_RD_PTR);
+
+	result->pic_distortion_low = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_PIC_DIST_LOW);
+	result->pic_distortion_high = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_PIC_DIST_HIGH);
+
+	result->bitstream_buffer = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_RD_PTR);
+	result->rd_ptr = p_enc_info->stream_rd_ptr;
+	result->wr_ptr = p_enc_info->stream_wr_ptr;
+
+	//result for header only(no vcl) encoding
+	if (result->recon_frame_index == RECON_IDX_FLAG_HEADER_ONLY)
+		result->bitstream_size = result->enc_pic_byte;
+	else if (result->recon_frame_index < 0)
+		result->bitstream_size = 0;
+	else
+		result->bitstream_size = result->enc_pic_byte;
+
+	result->enc_host_cmd_tick = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_HOST_CMD_TICK);
+	result->enc_prepare_start_tick = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_PREPARE_START_TICK);
+	result->enc_prepare_end_tick = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_PREPARE_END_TICK);
+	result->enc_processing_start_tick = vpu_read_reg(vpu_inst->dev,
+							 W5_RET_ENC_PROCESSING_START_TICK);
+	result->enc_processing_end_tick = vpu_read_reg(vpu_inst->dev,
+						       W5_RET_ENC_PROCESSING_END_TICK);
+	result->enc_encode_start_tick = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_ENCODING_START_TICK);
+	result->enc_encode_end_tick = vpu_read_reg(vpu_inst->dev, W5_RET_ENC_ENCODING_END_TICK);
+
+	if (!p_enc_info->first_cycle_check) {
+		result->frame_cycle = (result->enc_encode_end_tick - result->enc_host_cmd_tick) *
+			p_enc_info->cycle_per_tick;
+		p_enc_info->first_cycle_check = true;
+	} else {
+		result->frame_cycle =
+			(result->enc_encode_end_tick - vpu_dev->last_performance_cycles) *
+			p_enc_info->cycle_per_tick;
+		if (vpu_dev->last_performance_cycles < result->enc_host_cmd_tick)
+			result->frame_cycle = (result->enc_encode_end_tick -
+					result->enc_host_cmd_tick) * p_enc_info->cycle_per_tick;
+	}
+	vpu_dev->last_performance_cycles = result->enc_encode_end_tick;
+	result->prepare_cycle = (result->enc_prepare_end_tick -
+			result->enc_prepare_start_tick) * p_enc_info->cycle_per_tick;
+	result->processing = (result->enc_processing_end_tick -
+			result->enc_processing_start_tick) * p_enc_info->cycle_per_tick;
+	result->encoded_cycle = (result->enc_encode_end_tick -
+			result->enc_encode_start_tick) * p_enc_info->cycle_per_tick;
+
+	return 0;
+}
+
+int wave5_vpu_enc_fini_seq(struct vpu_instance *vpu_inst, u32 *fail_res)
+{
+	int ret;
+
+	if (vpu_inst->dev->product != PRODUCT_ID_521)
+		return -EINVAL;
+
+	wave5_bit_issue_command(vpu_inst, W5_DESTROY_INSTANCE);
+	ret = wave5_wait_vpu_busy(vpu_inst->dev, VPU_BUSY_CHECK_TIMEOUT, W5_VPU_BUSY_STATUS);
+	if (ret)
+		return -ETIMEDOUT;
+
+	if (!vpu_read_reg(vpu_inst->dev, W5_RET_SUCCESS)) {
+		*fail_res = vpu_read_reg(vpu_inst->dev, W5_RET_FAIL_REASON);
+		wave5_print_reg_err(vpu_inst->dev, *fail_res);
+		return -EIO;
+	}
+	return 0;
+}
+
+static int wave5_vpu_enc_check_common_param_valid(struct vpu_instance *vpu_inst,
+						  struct enc_open_param *pop)
+{
+	int i = 0;
+	bool low_delay = true;
+	struct enc_wave_param *param = &pop->wave_param;
+	struct vpu_device *vpu_dev = vpu_inst->dev;
+	struct device *dev = vpu_dev->dev;
+	s32 num_ctu_row = (pop->pic_height + 64 - 1) / 64;
+	s32 num_ctu_col = (pop->pic_width + 64 - 1) / 64;
+	s32 ctu_sz = num_ctu_col * num_ctu_row;
+
+	// check low-delay gop structure
+	if (param->gop_preset_idx == PRESET_IDX_CUSTOM_GOP) { /* common gop */
+		if (param->gop_param.custom_gop_size > 1) {
+			s32 min_val = param->gop_param.pic_param[0].poc_offset;
+
+			for (i = 1; i < param->gop_param.custom_gop_size; i++) {
+				if (min_val > param->gop_param.pic_param[i].poc_offset) {
+					low_delay = false;
+					break;
+				}
+				min_val = param->gop_param.pic_param[i].poc_offset;
+			}
+		}
+	} else if (param->gop_preset_idx == PRESET_IDX_ALL_I ||
+			param->gop_preset_idx == PRESET_IDX_IPP ||
+			param->gop_preset_idx == PRESET_IDX_IBBB ||
+			param->gop_preset_idx == PRESET_IDX_IPPPP ||
+			param->gop_preset_idx == PRESET_IDX_IBBBB ||
+			// low-delay case (IPPP, IBBB)
+			param->gop_preset_idx == PRESET_IDX_IPP_SINGLE) {
+	}
+
+	if (vpu_inst->std == W_HEVC_ENC && low_delay && param->decoding_refresh_type == 1) {
+		dev_warn(dev, "WARN : dec_refresh_type (CRA) is supported if low delay GOP.\n");
+		dev_warn(dev, "RECOMMEND CONFIG PARAMETER : decoding refresh type = IDR\n");
+		param->decoding_refresh_type = 2;
+	}
+
+	if (param->gop_preset_idx == PRESET_IDX_CUSTOM_GOP) {
+		for (i = 0; i < param->gop_param.custom_gop_size; i++) {
+			if (param->gop_param.pic_param[i].temporal_id >= MAX_NUM_TEMPORAL_LAYER) {
+				dev_err(dev, "temporal_id %d exceeds MAX_NUM_TEMPORAL_LAYER\n",
+					param->gop_param.pic_param[i].temporal_id);
+				return -EINVAL;
+			}
+
+			if (param->gop_param.pic_param[i].temporal_id < 0) {
+				dev_err(dev, "must be %d-th temporal_id >= 0\n",
+					param->gop_param.pic_param[i].temporal_id);
+				return -EINVAL;
+			}
+		}
+	}
+
+	if (param->wpp_enable && param->independ_slice_mode) {
+		int num_ctb_in_width = ALIGN(pop->pic_width, 64) >> 6;
+
+		if (param->independ_slice_mode_arg % num_ctb_in_width) {
+			dev_err(dev, "inde_slice_arg not multiple of num_ctb_in_width\n");
+			return -EINVAL;
+		}
+	}
+
+	// multi-slice & wpp
+	if (param->wpp_enable && param->depend_slice_mode) {
+		dev_err(dev, "param->wpp_enable == 1 && param->depend_slice_mode\n");
+		return -EINVAL;
+	}
+
+	if (!param->independ_slice_mode && param->depend_slice_mode) {
+		dev_err(dev, "independ_slice_mode && param->depend_slice_mode\n");
+		return -EINVAL;
+	} else if (param->independ_slice_mode && param->depend_slice_mode == 1 &&
+		   param->independ_slice_mode_arg < param->depend_slice_mode_arg) {
+		dev_err(dev, "independ_slice_mode_arg < depend_slice_mode_arg\n");
+		return -EINVAL;
+	}
+
+	if (param->independ_slice_mode && param->independ_slice_mode_arg > 65535) {
+		dev_err(dev, "param->independ_slice_mode_arg > 65535\n");
+		return -EINVAL;
+	}
+
+	if (param->depend_slice_mode && param->depend_slice_mode_arg > 65535) {
+		dev_err(dev, "param->depend_slice_mode_arg > 65535\n");
+		return -EINVAL;
+	}
+
+	if (param->conf_win_top % 2) {
+		dev_err(dev, "conf_win_top: %d not multiple of 2.\n", param->conf_win_top);
+		return -EINVAL;
+	}
+
+	if (param->conf_win_bot % 2) {
+		dev_err(dev, "conf_win_bot: %d not multiple of 2.\n", param->conf_win_bot);
+		return -EINVAL;
+	}
+
+	if (param->conf_win_left % 2) {
+		dev_err(dev, "conf_win_left: %d not multiple of 2.\n", param->conf_win_left);
+		return -EINVAL;
+	}
+
+	if (param->conf_win_right % 2) {
+		dev_err(dev, "conf_win_right : %d. not multiple of 2.\n", param->conf_win_right);
+		return -EINVAL;
+	}
+
+	if (param->lossless_enable && (param->nr_y_enable || param->nr_cb_enable ||
+				       param->nr_cr_enable)) {
+		dev_err(dev, "CFG FAIL : lossless_coding and noise_reduction");
+		dev_err(dev, "(en_nr_y, en_nr_cb, and en_nr_cr) cannot be used simultaneously.\n");
+		return -EINVAL;
+	}
+
+	if (param->lossless_enable && param->bg_detect_enable) {
+		dev_err(dev, "lossless_coding and bg_detect cannot be used simultaneously.\n");
+		return -EINVAL;
+	}
+
+	if (param->lossless_enable && pop->rc_enable) {
+		dev_err(dev, "ossless_coding and rate_control cannot be used simultaneously.\n");
+		return -EINVAL;
+	}
+
+	if (param->lossless_enable && param->roi_enable) {
+		dev_err(dev, "CFG FAIL : lossless_coding and roi cannot be used simultaneously.\n");
+		return -EINVAL;
+	}
+
+	if (param->lossless_enable && !param->skip_intra_trans) {
+		dev_err(dev, "intra_trans_skip must be enabled when lossless_coding is enabled.\n");
+		return -EINVAL;
+	}
+
+	// intra refresh
+	if (param->intra_refresh_mode && param->intra_refresh_arg <= 0) {
+		dev_err(dev, "mode %d, refresh %d wxh = %dx%d\n", param->intra_refresh_mode,
+			param->intra_refresh_arg, num_ctu_row, num_ctu_col);
+		return -EINVAL;
+	}
+	if (param->intra_refresh_mode == 1 && param->intra_refresh_arg > num_ctu_row) {
+		dev_err(dev, "mode %d, refresh %d wxh = %dx%d\n", param->intra_refresh_mode,
+			param->intra_refresh_arg, num_ctu_row, num_ctu_col);
+		return -EINVAL;
+	}
+	if (param->intra_refresh_mode == 2 && param->intra_refresh_arg > num_ctu_col) {
+		dev_err(dev, "mode %d, refresh %d wxh = %dx%d\n", param->intra_refresh_mode,
+			param->intra_refresh_arg, num_ctu_row, num_ctu_col);
+		return -EINVAL;
+	}
+	if (param->intra_refresh_mode == 3 && param->intra_refresh_arg > ctu_sz) {
+		dev_err(dev, "mode %d, refresh %d wxh = %dx%d\n", param->intra_refresh_mode,
+			param->intra_refresh_arg, num_ctu_row, num_ctu_col);
+		return -EINVAL;
+	}
+	if (param->intra_refresh_mode == 4 && param->intra_refresh_arg > ctu_sz) {
+		dev_err(dev, "mode %d, refresh %d wxh = %dx%d\n", param->intra_refresh_mode,
+			param->intra_refresh_arg, num_ctu_row, num_ctu_col);
+		return -EINVAL;
+	}
+	if (param->intra_refresh_mode == 4 && param->lossless_enable) {
+		dev_err(dev, "mode %d, and lossless_enable", param->intra_refresh_mode);
+		return -EINVAL;
+	}
+	if (param->intra_refresh_mode == 4 && param->roi_enable) {
+		dev_err(dev, "mode %d, and roi_enable", param->intra_refresh_mode);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int wave5_vpu_enc_check_param_valid(struct vpu_device *vpu_dev, struct enc_open_param *pop)
+{
+	struct enc_wave_param *param = &pop->wave_param;
+
+	if (pop->rc_enable) {
+		if (param->min_qp_i > param->max_qp_i || param->min_qp_p > param->max_qp_p ||
+		    param->min_qp_b > param->max_qp_b) {
+			dev_err(vpu_dev->dev, "CFG FAIL : not allowed min_qp > max_qp\n");
+			dev_err(vpu_dev->dev, "RECOMMEND CONFIG PARAMETER : min_qp = max_qp\n");
+			return -EINVAL;
+		}
+
+		if (pop->bit_rate <= (int)pop->frame_rate_info) {
+			dev_err(vpu_dev->dev, "not allowed enc_bit_rate <= frame_rate\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int wave5_vpu_enc_check_custom_gop(struct vpu_device *vpu_dev, struct enc_open_param *pop)
+{
+	struct custom_gop_param *gop_param;
+	struct custom_gop_pic_param *gop_pic_param;
+	struct custom_gop_pic_param new_gop[MAX_GOP_NUM * 2 + 1];
+
+	u32 i, ei, gi, gop_size;
+	s32 curr_poc;
+	s32 enc_tid[MAX_GOP_NUM * 2 + 1];
+
+	gop_param = &pop->wave_param.gop_param;
+	gop_size = gop_param->custom_gop_size;
+
+	new_gop[0].poc_offset = 0;
+	new_gop[0].temporal_id = 0;
+	new_gop[0].pic_type = PIC_TYPE_I;
+	new_gop[0].use_multi_ref_p = 0;
+	enc_tid[0] = 0;
+
+	for (i = 0; i < gop_size * 2; i++) {
+		ei = i % gop_size;
+		gi = i / gop_size;
+		gop_pic_param = &gop_param->pic_param[ei];
+
+		curr_poc = gi * gop_size + gop_pic_param->poc_offset;
+		new_gop[i + 1].poc_offset = curr_poc;
+		new_gop[i + 1].temporal_id = gop_pic_param->temporal_id;
+		new_gop[i + 1].pic_type = gop_pic_param->pic_type;
+		new_gop[i + 1].ref_poc_l0 = gop_pic_param->ref_poc_l0 + gi * gop_size;
+		new_gop[i + 1].ref_poc_l1 = gop_pic_param->ref_poc_l1 + gi * gop_size;
+		new_gop[i + 1].use_multi_ref_p = gop_pic_param->use_multi_ref_p;
+		enc_tid[i + 1] = -1;
+	}
+
+	for (i = 0; i < gop_size; i++) {
+		gop_pic_param = &gop_param->pic_param[i];
+
+		if (gop_pic_param->poc_offset <= 0) {
+			dev_err(vpu_dev->dev, "POC of the %d-th pic not greater then -1\n", i + 1);
+			return -EINVAL;
+		}
+		if (gop_pic_param->poc_offset > gop_size) {
+			dev_err(vpu_dev->dev, "POC of %dth pic bigger than gop_size\n", i + 1);
+			return -EINVAL;
+		}
+		if (gop_pic_param->temporal_id < 0) {
+			dev_err(vpu_dev->dev, "temporal_id of the %d-th  < 0\n", i + 1);
+			return -EINVAL;
+		}
+	}
+
+	for (ei = 1; ei < gop_size * 2 + 1; ei++) {
+		struct custom_gop_pic_param *cur_pic = &new_gop[ei];
+
+		if (ei <= gop_size) {
+			enc_tid[cur_pic->poc_offset] = cur_pic->temporal_id;
+			continue;
+		}
+
+		if (new_gop[ei].pic_type != PIC_TYPE_I) {
+			s32 ref_poc = cur_pic->ref_poc_l0;
+
+			/* reference picture is not encoded yet */
+			if (enc_tid[ref_poc] < 0) {
+				dev_err(vpu_dev->dev, "1st ref pic cant be ref of pic (POC %d)\n",
+					cur_pic->poc_offset - gop_size);
+				return -EINVAL;
+			}
+			if (enc_tid[ref_poc] > cur_pic->temporal_id) {
+				dev_err(vpu_dev->dev, "worng temporal_id of pic (POC %d)\n",
+					cur_pic->poc_offset - gop_size);
+				return -EINVAL;
+			}
+			if (ref_poc >= cur_pic->poc_offset) {
+				dev_err(vpu_dev->dev, "POC of 1st ref pic of %d-th pic is wrong\n",
+					cur_pic->poc_offset - gop_size);
+				return -EINVAL;
+			}
+		}
+		if (new_gop[ei].pic_type != PIC_TYPE_P) {
+			s32 ref_poc = cur_pic->ref_poc_l1;
+
+			/* reference picture is not encoded yet */
+			if (enc_tid[ref_poc] < 0) {
+				dev_err(vpu_dev->dev, "2nd ref pic cant be ref of pic (POC %d)\n"
+						, cur_pic->poc_offset - gop_size);
+				dev_err(vpu_dev->dev,  "2nd ref pic cant be ref of pic (POC %d)\n"
+						, cur_pic->poc_offset - gop_size);
+				return -EINVAL;
+			}
+			if (enc_tid[ref_poc] > cur_pic->temporal_id) {
+				dev_err(vpu_dev->dev,  "temporal_id of %d-th picture is wrong\n",
+					cur_pic->poc_offset - gop_size);
+				return -EINVAL;
+			}
+			if (new_gop[ei].pic_type == PIC_TYPE_P && new_gop[ei].use_multi_ref_p > 0) {
+				if (ref_poc >= cur_pic->poc_offset) {
+					dev_err(vpu_dev->dev,  "bad POC of 2nd ref pic of %dth pic\n",
+						cur_pic->poc_offset - gop_size);
+					return -EINVAL;
+				}
+			} else if (ref_poc == cur_pic->poc_offset) {
+				/* HOST_PIC_TYPE_B */
+				dev_err(vpu_dev->dev,  "POC of 2nd ref pic of %dth pic is wrong\n",
+					cur_pic->poc_offset - gop_size);
+				return -EINVAL;
+			}
+		}
+		curr_poc = cur_pic->poc_offset;
+		enc_tid[curr_poc] = cur_pic->temporal_id;
+	}
+	return 0;
+}
+
+int wave5_vpu_enc_check_open_param(struct vpu_instance *vpu_inst, struct enc_open_param *pop)
+{
+	s32 pic_width;
+	s32 pic_height;
+	s32 product_id = vpu_inst->dev->product;
+	struct vpu_attr *p_attr = &vpu_inst->dev->attr;
+
+	if (!pop)
+		return -EINVAL;
+
+	pic_width = pop->pic_width;
+	pic_height = pop->pic_height;
+
+	if (vpu_inst->std != W_HEVC_ENC && vpu_inst->std != W_AVC_ENC)
+		return -EOPNOTSUPP;
+
+	if (vpu_inst->std == W_AVC_ENC && pop->wave_param.internal_bit_depth == 10 &&
+	    !p_attr->support_avc10bit_enc)
+		return -EOPNOTSUPP;
+
+	if (vpu_inst->std == W_HEVC_ENC && pop->wave_param.internal_bit_depth == 10 &&
+	    !p_attr->support_hevc10bit_enc)
+		return -EOPNOTSUPP;
+
+	if (pop->ring_buffer_enable) {
+		if (pop->bitstream_buffer % 8)
+			return -EINVAL;
+
+		if (product_id == PRODUCT_ID_521) {
+			if (pop->bitstream_buffer % 16)
+				return -EINVAL;
+			if (pop->bitstream_buffer_size < (1024 * 64))
+				return -EINVAL;
+		}
+
+		if (pop->bitstream_buffer_size % 1024 || pop->bitstream_buffer_size < 1024)
+			return -EINVAL;
+	}
+
+	if (!pop->frame_rate_info) {
+		return -EINVAL;
+	} else if (vpu_inst->std == W_HEVC_ENC) {
+		if (product_id == PRODUCT_ID_521) {
+			if (pop->bit_rate > 700000000 || pop->bit_rate < 0)
+				return -EINVAL;
+		}
+	} else {
+		if (pop->bit_rate > 32767 || pop->bit_rate < 0)
+			return -EINVAL;
+	}
+
+	if (vpu_inst->std == W_HEVC_ENC ||
+	    (vpu_inst->std == W_AVC_ENC && product_id == PRODUCT_ID_521)) {
+		struct enc_wave_param *param = &pop->wave_param;
+
+		if (pic_width < W5_MIN_ENC_PIC_WIDTH || pic_width > W5_MAX_ENC_PIC_WIDTH)
+			return -EINVAL;
+
+		if (pic_height < W5_MIN_ENC_PIC_HEIGHT || pic_height > W5_MAX_ENC_PIC_HEIGHT)
+			return -EINVAL;
+
+		if (param->profile) {
+			if (vpu_inst->std == W_HEVC_ENC) { // only for HEVC condition
+				if (param->profile != HEVC_PROFILE_MAIN && param->profile
+						!= HEVC_PROFILE_MAIN10 &&
+						param->profile != HEVC_PROFILE_STILLPICTURE)
+					return -EINVAL;
+				if (param->internal_bit_depth > 8 &&
+				    param->profile == HEVC_PROFILE_MAIN)
+					return -EINVAL;
+			} else if (vpu_inst->std == W_AVC_ENC) {
+				if ((param->internal_bit_depth > 8 &&
+				     param->profile != H264_PROFILE_HIGH10))
+					return -EINVAL;
+			}
+		}
+
+		if (param->internal_bit_depth != 8 && param->internal_bit_depth != 10)
+			return -EINVAL;
+
+		if (param->decoding_refresh_type < 0 || param->decoding_refresh_type > 2)
+			return -EINVAL;
+
+		if (param->gop_preset_idx == PRESET_IDX_CUSTOM_GOP) {
+			if (param->gop_param.custom_gop_size < 1 ||
+			    param->gop_param.custom_gop_size > MAX_GOP_NUM)
+				return -EINVAL;
+		}
+
+		if (vpu_inst->std == W_AVC_ENC) {
+			if (param->custom_lambda_enable == 1)
+				return -EINVAL;
+		}
+		if (param->intra_refresh_mode < 0 || param->intra_refresh_mode > 4)
+			return -EINVAL;
+
+		if (vpu_inst->std == W_HEVC_ENC && param->independ_slice_mode &&
+		    param->depend_slice_mode > 2)
+			return -EINVAL;
+
+		if (param->scaling_list_enable == 3)
+			return -EINVAL;
+
+		if (!param->disable_deblk) {
+			if (param->beta_offset_div2 < -6 || param->beta_offset_div2 > 6)
+				return -EINVAL;
+
+			if (param->tc_offset_div2 < -6 || param->tc_offset_div2 > 6)
+				return -EINVAL;
+		}
+
+		if (param->intra_qp < 0 || param->intra_qp > 63)
+			return -EINVAL;
+
+		if (pop->rc_enable) {
+			if (param->min_qp_i < 0 || param->min_qp_i > 63)
+				return -EINVAL;
+			if (param->max_qp_i < 0 || param->max_qp_i > 63)
+				return -EINVAL;
+
+			if (param->min_qp_p < 0 || param->min_qp_p > 63)
+				return -EINVAL;
+			if (param->max_qp_p < 0 || param->max_qp_p > 63)
+				return -EINVAL;
+
+			if (param->min_qp_b < 0 || param->min_qp_b > 63)
+				return -EINVAL;
+			if (param->max_qp_b < 0 || param->max_qp_b > 63)
+				return -EINVAL;
+
+			if (param->hvs_qp_enable) {
+				if (param->hvs_max_delta_qp < 0 || param->hvs_max_delta_qp > 51)
+					return -EINVAL;
+			}
+
+			if (param->bit_alloc_mode > 2)
+				return -EINVAL;
+
+			if (pop->vbv_buffer_size < 10 || pop->vbv_buffer_size > 3000)
+				return -EINVAL;
+		}
+
+		// packed format & cbcr_interleave & nv12 can't be set at the same time.
+		if (pop->packed_format == 1 && pop->cbcr_interleave == 1)
+			return -EINVAL;
+
+		if (pop->packed_format == 1 && pop->nv21 == 1)
+			return -EINVAL;
+
+		// check valid for common param
+		if (wave5_vpu_enc_check_common_param_valid(vpu_inst, pop))
+			return -EINVAL;
+
+		// check valid for RC param
+		if (wave5_vpu_enc_check_param_valid(vpu_inst->dev, pop))
+			return -EINVAL;
+
+		if (param->gop_preset_idx == PRESET_IDX_CUSTOM_GOP) {
+			if (wave5_vpu_enc_check_custom_gop(vpu_inst->dev, pop))
+				return -EINVAL;
+		}
+
+		if (param->chroma_cb_qp_offset < -12 || param->chroma_cb_qp_offset > 12)
+			return -EINVAL;
+
+		if (param->chroma_cr_qp_offset < -12 || param->chroma_cr_qp_offset > 12)
+			return -EINVAL;
+
+		if (param->intra_refresh_mode == 3 && !param->intra_refresh_arg)
+			return -EINVAL;
+
+		if (vpu_inst->std == W_HEVC_ENC) {
+			if (param->nr_noise_sigma_y > 255)
+				return -EINVAL;
+
+			if (param->nr_noise_sigma_cb > 255)
+				return -EINVAL;
+
+			if (param->nr_noise_sigma_cr > 255)
+				return -EINVAL;
+
+			if (param->nr_intra_weight_y > 31)
+				return -EINVAL;
+
+			if (param->nr_intra_weight_cb > 31)
+				return -EINVAL;
+
+			if (param->nr_intra_weight_cr > 31)
+				return -EINVAL;
+
+			if (param->nr_inter_weight_y > 31)
+				return -EINVAL;
+
+			if (param->nr_inter_weight_cb > 31)
+				return -EINVAL;
+
+			if (param->nr_inter_weight_cr > 31)
+				return -EINVAL;
+
+			if ((param->nr_y_enable == 1 || param->nr_cb_enable == 1 ||
+			     param->nr_cr_enable == 1) &&
+					param->lossless_enable == 1)
+				return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
diff --git a/drivers/staging/media/wave5/wave5-regdefine.h b/drivers/staging/media/wave5/wave5-regdefine.h
new file mode 100644
index 000000000000..620774a619cc
--- /dev/null
+++ b/drivers/staging/media/wave5/wave5-regdefine.h
@@ -0,0 +1,650 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Wave5 series multi-standard codec IP - wave5 register definitions
+ *
+ * Copyright (C) 2021 CHIPS&MEDIA INC
+ */
+
+#ifndef __WAVE5_REGISTER_DEFINE_H__
+#define __WAVE5_REGISTER_DEFINE_H__
+
+enum W5_VPU_COMMAND {
+	W5_INIT_VPU        = 0x0001,
+	W5_WAKEUP_VPU      = 0x0002,
+	W5_SLEEP_VPU       = 0x0004,
+	W5_CREATE_INSTANCE = 0x0008,            /* queuing command */
+	W5_FLUSH_INSTANCE  = 0x0010,
+	W5_DESTROY_INSTANCE = 0x0020,            /* queuing command */
+	W5_INIT_SEQ        = 0x0040,            /* queuing command */
+	W5_SET_FB          = 0x0080,
+	W5_DEC_PIC         = 0x0100,            /* queuing command */
+	W5_ENC_PIC         = 0x0100,            /* queuing command */
+	W5_ENC_SET_PARAM   = 0x0200,            /* queuing command */
+	W5_QUERY           = 0x4000,
+	W5_UPDATE_BS       = 0x8000,
+	W5_MAX_VPU_COMD	   = 0x10000,
+};
+
+enum QUERY_OPT {
+	GET_VPU_INFO        = 0,
+	SET_WRITE_PROT      = 1,
+	GET_RESULT          = 2,
+	UPDATE_DISP_FLAG    = 3,
+	GET_BW_REPORT       = 4,
+	GET_BS_RD_PTR       = 5,    // for decoder
+	GET_BS_WR_PTR       = 6,    // for encoder
+	GET_SRC_BUF_FLAG    = 7,    // for encoder
+	SET_BS_RD_PTR       = 8,    // for decoder
+	GET_DEBUG_INFO      = 0x61,
+};
+
+/*
+ * A flag of user data buffer full.
+ * User data buffer full flag equal to 1 specifies that de-
+ * coded frame has more user data size than VPU internal
+ * buffer. VPU only dumps the internal buffer size of us-
+ * er data to USER_DATA_BUF_BASE buffer. In other
+ * words, VPU is unable to report the rest of the user data to
+ * USER_DATA_BUF_BASE buffer after the internal buffer
+ * fullness happens.
+ */
+#define USERDATA_FLAG_BUFF_FULL		1
+
+#define W5_REG_BASE                     0x00000000
+#define W5_CMD_REG_BASE                 0x00000100
+#define W5_CMD_REG_END                  0x00000200
+
+/*
+ * common
+ */
+/* power on configuration
+ * PO_DEBUG_MODE    [0]     1 - power on with debug mode
+ * USE_PO_CONF      [3]     1 - use power-on-configuration
+ */
+#define W5_PO_CONF                     (W5_REG_BASE + 0x0000)
+#define W5_VCPU_CUR_PC                 (W5_REG_BASE + 0x0004)
+#define W5_VCPU_CUR_LR                 (W5_REG_BASE + 0x0008)
+#define W5_VPU_PDBG_STEP_MASK_V        (W5_REG_BASE + 0x000C)
+#define W5_VPU_PDBG_CTRL               (W5_REG_BASE + 0x0010) // v_cpu debugger ctrl register
+#define W5_VPU_PDBG_IDX_REG            (W5_REG_BASE + 0x0014) // v_cpu debugger index register
+#define W5_VPU_PDBG_WDATA_REG          (W5_REG_BASE + 0x0018) // v_cpu debugger write data register
+#define W5_VPU_PDBG_RDATA_REG          (W5_REG_BASE + 0x001C) // v_cpu debugger read data register
+
+#define W5_VPU_FIO_CTRL_ADDR           (W5_REG_BASE + 0x0020)
+#define W5_VPU_FIO_DATA                (W5_REG_BASE + 0x0024)
+#define W5_VPU_VINT_REASON_USR         (W5_REG_BASE + 0x0030)
+#define W5_VPU_VINT_REASON_CLR         (W5_REG_BASE + 0x0034)
+#define W5_VPU_HOST_INT_REQ            (W5_REG_BASE + 0x0038)
+#define W5_VPU_VINT_CLEAR              (W5_REG_BASE + 0x003C)
+#define W5_VPU_HINT_CLEAR              (W5_REG_BASE + 0x0040)
+#define W5_VPU_VPU_INT_STS             (W5_REG_BASE + 0x0044)
+#define W5_VPU_VINT_ENABLE             (W5_REG_BASE + 0x0048)
+#define W5_VPU_VINT_REASON             (W5_REG_BASE + 0x004C)
+#define W5_VPU_RESET_REQ               (W5_REG_BASE + 0x0050)
+#define W5_RST_BLOCK_CCLK(_core)       BIT((_core))
+#define W5_RST_BLOCK_CCLK_ALL          (0xff)
+#define W5_RST_BLOCK_BCLK(_core)       (0x100 << (_core))
+#define W5_RST_BLOCK_BCLK_ALL          (0xff00)
+#define W5_RST_BLOCK_ACLK(_core)       (0x10000 << (_core))
+#define W5_RST_BLOCK_ACLK_ALL          (0xff0000)
+#define W5_RST_BLOCK_VCPU_ALL          (0x3f000000)
+#define W5_RST_BLOCK_ALL               (0x3fffffff)
+#define W5_VPU_RESET_STATUS            (W5_REG_BASE + 0x0054)
+
+#define W5_VCPU_RESTART                (W5_REG_BASE + 0x0058)
+#define W5_VPU_CLK_MASK                (W5_REG_BASE + 0x005C)
+
+/* REMAP_CTRL
+ * PAGE SIZE:   [8:0]   0x001 - 4K
+ *                      0x002 - 8K
+ *                      0x004 - 16K
+ *                      ...
+ *                      0x100 - 1M
+ * REGION ATTR1 [10]    0     - normal
+ *                      1     - make bus error for the region
+ * REGION ATTR2 [11]    0     - normal
+ *                      1     - bypass region
+ * REMAP INDEX  [15:12]       - 0 ~ 3
+ * ENDIAN       [19:16]       - see endian_mode in vdi.h
+ * AXI-ID       [23:20]       - upper AXI-ID
+ * BUS_ERROR    [29]    0     - bypass
+ *                      1     - make BUS_ERROR for unmapped region
+ * BYPASS_ALL   [30]    1     - bypass all
+ * ENABLE       [31]    1     - update control register[30:16]
+ */
+#define W5_VPU_REMAP_CTRL                       (W5_REG_BASE + 0x0060)
+#define W5_VPU_REMAP_VADDR                      (W5_REG_BASE + 0x0064)
+#define W5_VPU_REMAP_PADDR                      (W5_REG_BASE + 0x0068)
+#define W5_VPU_REMAP_CORE_START                 (W5_REG_BASE + 0x006C)
+#define W5_VPU_BUSY_STATUS                      (W5_REG_BASE + 0x0070)
+#define W5_VPU_HALT_STATUS                      (W5_REG_BASE + 0x0074)
+#define W5_VPU_VCPU_STATUS                      (W5_REG_BASE + 0x0078)
+#define W5_VPU_RET_PRODUCT_VERSION              (W5_REG_BASE + 0x0094)
+/*
+ * assign vpu_config0          = {conf_map_converter_reg,      // [31]
+ * conf_map_converter_sig,         // [30]
+ * 8'd0,                        // [29:22]
+ * conf_std_switch_en,          // [21]
+ * conf_bg_detect,              // [20]
+ * conf_3dnr_en,                // [19]
+ * conf_one_axi_en,             // [18]
+ * conf_sec_axi_en,             // [17]
+ * conf_bus_info,               // [16]
+ * conf_afbc_en,                // [15]
+ * conf_afbc_version_id,        // [14:12]
+ * conf_fbc_en,                 // [11]
+ * conf_fbc_version_id,         // [10:08]
+ * conf_scaler_en,              // [07]
+ * conf_scaler_version_id,      // [06:04]
+ * conf_bwb_en,                 // [03]
+ * 3'd0};                       // [02:00]
+ */
+#define W5_VPU_RET_VPU_CONFIG0                  (W5_REG_BASE + 0x0098)
+/*
+ * assign vpu_config1          = {4'd0,                        // [31:28]
+ * conf_perf_timer_en,          // [27]
+ * conf_multi_core_en,          // [26]
+ * conf_gcu_en,                 // [25]
+ * conf_cu_report,              // [24]
+ * 4'd0,                        // [23:20]
+ * conf_vcore_id_3,             // [19]
+ * conf_vcore_id_2,             // [18]
+ * conf_vcore_id_1,             // [17]
+ * conf_vcore_id_0,             // [16]
+ * conf_bwb_opt,                // [15]
+ * 7'd0,                        // [14:08]
+ * conf_cod_std_en_reserved_7,  // [7]
+ * conf_cod_std_en_reserved_6,  // [6]
+ * conf_cod_std_en_reserved_5,  // [5]
+ * conf_cod_std_en_reserved_4,  // [4]
+ * conf_cod_std_en_reserved_3,  // [3]
+ * conf_cod_std_en_reserved_2,  // [2]
+ * conf_cod_std_en_vp9,         // [1]
+ * conf_cod_std_en_hevc};       // [0]
+ * }
+ */
+#define W5_VPU_RET_VPU_CONFIG1                  (W5_REG_BASE + 0x009C)
+
+#define W5_VPU_DBG_REG0							(W5_REG_BASE + 0x00f0)
+#define W5_VPU_DBG_REG1							(W5_REG_BASE + 0x00f4)
+#define W5_VPU_DBG_REG2							(W5_REG_BASE + 0x00f8)
+#define W5_VPU_DBG_REG3							(W5_REG_BASE + 0x00fc)
+
+/************************************************************************/
+/* PRODUCT INFORMATION                                                  */
+/************************************************************************/
+#define W5_PRODUCT_NAME                        (W5_REG_BASE + 0x1040)
+#define W5_PRODUCT_NUMBER                      (W5_REG_BASE + 0x1044)
+
+/************************************************************************/
+/* DECODER/ENCODER COMMON                                               */
+/************************************************************************/
+#define W5_COMMAND                              (W5_REG_BASE + 0x0100)
+#define W5_COMMAND_OPTION                       (W5_REG_BASE + 0x0104)
+#define W5_QUERY_OPTION                         (W5_REG_BASE + 0x0104)
+#define W5_RET_SUCCESS                          (W5_REG_BASE + 0x0108)
+#define W5_RET_FAIL_REASON                      (W5_REG_BASE + 0x010C)
+#define W5_RET_QUEUE_FAIL_REASON                (W5_REG_BASE + 0x0110)
+#define W5_CMD_INSTANCE_INFO                    (W5_REG_BASE + 0x0110)
+
+#define W5_RET_QUEUE_STATUS                     (W5_REG_BASE + 0x01E0)
+#define W5_RET_BS_EMPTY_INST                    (W5_REG_BASE + 0x01E4)
+#define W5_RET_QUEUE_CMD_DONE_INST              (W5_REG_BASE + 0x01E8)
+#define W5_RET_STAGE0_INSTANCE_INFO             (W5_REG_BASE + 0x01EC)
+#define W5_RET_STAGE1_INSTANCE_INFO             (W5_REG_BASE + 0x01F0)
+#define W5_RET_STAGE2_INSTANCE_INFO             (W5_REG_BASE + 0x01F4)
+
+#define W5_RET_SEQ_DONE_INSTANCE_INFO           (W5_REG_BASE + 0x01FC)
+
+#define W5_BS_OPTION                            (W5_REG_BASE + 0x0120)
+
+// return info when QUERY (GET_RESULT) for en/decoder
+#define W5_RET_VLC_BUF_SIZE                     (W5_REG_BASE + 0x01B0)
+// return info when QUERY (GET_RESULT) for en/decoder
+#define W5_RET_PARAM_BUF_SIZE                   (W5_REG_BASE + 0x01B4)
+
+// set when SET_FB for en/decoder
+#define W5_CMD_SET_FB_ADDR_TASK_BUF             (W5_REG_BASE + 0x01D4)
+#define W5_CMD_SET_FB_TASK_BUF_SIZE             (W5_REG_BASE + 0x01D8)
+/************************************************************************/
+/* INIT_VPU - COMMON                                                    */
+/************************************************************************/
+/* note: W5_ADDR_CODE_BASE should be aligned to 4KB */
+#define W5_ADDR_CODE_BASE                       (W5_REG_BASE + 0x0110)
+#define W5_CODE_SIZE                            (W5_REG_BASE + 0x0114)
+#define W5_CODE_PARAM                           (W5_REG_BASE + 0x0118)
+#define W5_ADDR_TEMP_BASE                       (W5_REG_BASE + 0x011C)
+#define W5_TEMP_SIZE                            (W5_REG_BASE + 0x0120)
+#define W5_ADDR_SEC_AXI                         (W5_REG_BASE + 0x0124)
+#define W5_SEC_AXI_SIZE                         (W5_REG_BASE + 0x0128)
+#define W5_HW_OPTION                            (W5_REG_BASE + 0x012C)
+
+/************************************************************************/
+/* CREATE_INSTANCE - COMMON                                             */
+/************************************************************************/
+#define W5_ADDR_WORK_BASE                       (W5_REG_BASE + 0x0114)
+#define W5_WORK_SIZE                            (W5_REG_BASE + 0x0118)
+#define W5_CMD_DEC_BS_START_ADDR                (W5_REG_BASE + 0x011C)
+#define W5_CMD_DEC_BS_SIZE                      (W5_REG_BASE + 0x0120)
+#define W5_CMD_BS_PARAM                         (W5_REG_BASE + 0x0124)
+#define W5_CMD_NUM_CQ_DEPTH_M1                  (W5_REG_BASE + 0x013C)
+#define W5_CMD_ERR_CONCEAL                      (W5_REG_BASE + 0x0140)
+
+/************************************************************************/
+/* DECODER - INIT_SEQ                                                   */
+/************************************************************************/
+#define W5_BS_RD_PTR                            (W5_REG_BASE + 0x0118)
+#define W5_BS_WR_PTR                            (W5_REG_BASE + 0x011C)
+/************************************************************************/
+/* SET_FRAME_BUF                                                        */
+/************************************************************************/
+/* SET_FB_OPTION 0x00       REGISTER FRAMEBUFFERS
+ * 0x01       UPDATE FRAMEBUFFER, just one framebuffer(linear, fbc and mvcol)
+ */
+#define W5_SFB_OPTION                           (W5_REG_BASE + 0x0104)
+#define W5_COMMON_PIC_INFO                      (W5_REG_BASE + 0x0118)
+#define W5_PIC_SIZE                             (W5_REG_BASE + 0x011C)
+#define W5_SET_FB_NUM                           (W5_REG_BASE + 0x0120)
+#define W5_EXTRA_PIC_INFO                       (W5_REG_BASE + 0x0124)
+
+#define W5_ADDR_LUMA_BASE0                      (W5_REG_BASE + 0x0134)
+#define W5_ADDR_CB_BASE0                        (W5_REG_BASE + 0x0138)
+#define W5_ADDR_CR_BASE0                        (W5_REG_BASE + 0x013C)
+// compression offset table for luma
+#define W5_ADDR_FBC_Y_OFFSET0                   (W5_REG_BASE + 0x013C)
+// compression offset table for chroma
+#define W5_ADDR_FBC_C_OFFSET0                   (W5_REG_BASE + 0x0140)
+#define W5_ADDR_LUMA_BASE1                      (W5_REG_BASE + 0x0144)
+#define W5_ADDR_CB_ADDR1                        (W5_REG_BASE + 0x0148)
+#define W5_ADDR_CR_ADDR1                        (W5_REG_BASE + 0x014C)
+// compression offset table for luma
+#define W5_ADDR_FBC_Y_OFFSET1                   (W5_REG_BASE + 0x014C)
+// compression offset table for chroma
+#define W5_ADDR_FBC_C_OFFSET1                   (W5_REG_BASE + 0x0150)
+#define W5_ADDR_LUMA_BASE2                      (W5_REG_BASE + 0x0154)
+#define W5_ADDR_CB_ADDR2                        (W5_REG_BASE + 0x0158)
+#define W5_ADDR_CR_ADDR2                        (W5_REG_BASE + 0x015C)
+// compression offset table for luma
+#define W5_ADDR_FBC_Y_OFFSET2                   (W5_REG_BASE + 0x015C)
+// compression offset table for chroma
+#define W5_ADDR_FBC_C_OFFSET2                   (W5_REG_BASE + 0x0160)
+#define W5_ADDR_LUMA_BASE3                      (W5_REG_BASE + 0x0164)
+#define W5_ADDR_CB_ADDR3                        (W5_REG_BASE + 0x0168)
+#define W5_ADDR_CR_ADDR3                        (W5_REG_BASE + 0x016C)
+// compression offset table for luma
+#define W5_ADDR_FBC_Y_OFFSET3                   (W5_REG_BASE + 0x016C)
+// compression offset table for chroma
+#define W5_ADDR_FBC_C_OFFSET3                   (W5_REG_BASE + 0x0170)
+#define W5_ADDR_LUMA_BASE4                      (W5_REG_BASE + 0x0174)
+#define W5_ADDR_CB_ADDR4                        (W5_REG_BASE + 0x0178)
+#define W5_ADDR_CR_ADDR4                        (W5_REG_BASE + 0x017C)
+// compression offset table for luma
+#define W5_ADDR_FBC_Y_OFFSET4                   (W5_REG_BASE + 0x017C)
+// compression offset table for chroma
+#define W5_ADDR_FBC_C_OFFSET4                   (W5_REG_BASE + 0x0180)
+#define W5_ADDR_LUMA_BASE5                      (W5_REG_BASE + 0x0184)
+#define W5_ADDR_CB_ADDR5                        (W5_REG_BASE + 0x0188)
+#define W5_ADDR_CR_ADDR5                        (W5_REG_BASE + 0x018C)
+// compression offset table for luma
+#define W5_ADDR_FBC_Y_OFFSET5                   (W5_REG_BASE + 0x018C)
+// compression offset table for chroma
+#define W5_ADDR_FBC_C_OFFSET5                   (W5_REG_BASE + 0x0190)
+#define W5_ADDR_LUMA_BASE6                      (W5_REG_BASE + 0x0194)
+#define W5_ADDR_CB_ADDR6                        (W5_REG_BASE + 0x0198)
+#define W5_ADDR_CR_ADDR6                        (W5_REG_BASE + 0x019C)
+// compression offset table for luma
+#define W5_ADDR_FBC_Y_OFFSET6                   (W5_REG_BASE + 0x019C)
+// compression offset table for chroma
+#define W5_ADDR_FBC_C_OFFSET6                   (W5_REG_BASE + 0x01A0)
+#define W5_ADDR_LUMA_BASE7                      (W5_REG_BASE + 0x01A4)
+#define W5_ADDR_CB_ADDR7                        (W5_REG_BASE + 0x01A8)
+#define W5_ADDR_CR_ADDR7                        (W5_REG_BASE + 0x01AC)
+// compression offset table for luma
+#define W5_ADDR_FBC_Y_OFFSET7                   (W5_REG_BASE + 0x01AC)
+// compression offset table for chroma
+#define W5_ADDR_FBC_C_OFFSET7                   (W5_REG_BASE + 0x01B0)
+#define W5_ADDR_MV_COL0                         (W5_REG_BASE + 0x01B4)
+#define W5_ADDR_MV_COL1                         (W5_REG_BASE + 0x01B8)
+#define W5_ADDR_MV_COL2                         (W5_REG_BASE + 0x01BC)
+#define W5_ADDR_MV_COL3                         (W5_REG_BASE + 0x01C0)
+#define W5_ADDR_MV_COL4                         (W5_REG_BASE + 0x01C4)
+#define W5_ADDR_MV_COL5                         (W5_REG_BASE + 0x01C8)
+#define W5_ADDR_MV_COL6                         (W5_REG_BASE + 0x01CC)
+#define W5_ADDR_MV_COL7                         (W5_REG_BASE + 0x01D0)
+
+/* UPDATE_FB */
+/* CMD_SET_FB_STRIDE [15:0]     - FBC framebuffer stride
+ * [31:15]    - linear framebuffer stride
+ */
+#define W5_CMD_SET_FB_STRIDE                    (W5_REG_BASE + 0x0118)
+#define W5_CMD_SET_FB_INDEX                     (W5_REG_BASE + 0x0120)
+#define W5_ADDR_LUMA_BASE                       (W5_REG_BASE + 0x0134)
+#define W5_ADDR_CB_BASE                         (W5_REG_BASE + 0x0138)
+#define W5_ADDR_CR_BASE                         (W5_REG_BASE + 0x013C)
+#define W5_ADDR_MV_COL                          (W5_REG_BASE + 0x0140)
+#define W5_ADDR_FBC_Y_BASE                      (W5_REG_BASE + 0x0144)
+#define W5_ADDR_FBC_C_BASE                      (W5_REG_BASE + 0x0148)
+#define W5_ADDR_FBC_Y_OFFSET                    (W5_REG_BASE + 0x014C)
+#define W5_ADDR_FBC_C_OFFSET                    (W5_REG_BASE + 0x0150)
+
+/************************************************************************/
+/* DECODER - DEC_PIC                                                    */
+/************************************************************************/
+#define W5_CMD_DEC_VCORE_INFO                   (W5_REG_BASE + 0x0194)
+/* sequence change enable mask register
+ * CMD_SEQ_CHANGE_ENABLE_FLAG [5]   profile_idc
+ *                            [16]  pic_width/height_in_luma_sample
+ *                            [19]  sps_max_dec_pic_buffering, max_num_reorder, max_latency_increase
+ */
+#define W5_CMD_SEQ_CHANGE_ENABLE_FLAG           (W5_REG_BASE + 0x0128)
+#define W5_CMD_DEC_USER_MASK                    (W5_REG_BASE + 0x012C)
+#define W5_CMD_DEC_TEMPORAL_ID_PLUS1            (W5_REG_BASE + 0x0130)
+#define W5_CMD_DEC_FORCE_FB_LATENCY_PLUS1       (W5_REG_BASE + 0x0134)
+#define W5_USE_SEC_AXI                          (W5_REG_BASE + 0x0150)
+
+/************************************************************************/
+/* DECODER - QUERY : GET_VPU_INFO                                       */
+/************************************************************************/
+#define W5_RET_FW_VERSION                       (W5_REG_BASE + 0x0118)
+#define W5_RET_PRODUCT_NAME                     (W5_REG_BASE + 0x011C)
+#define W5_RET_PRODUCT_VERSION                  (W5_REG_BASE + 0x0120)
+#define W5_RET_STD_DEF0                         (W5_REG_BASE + 0x0124)
+#define W5_RET_STD_DEF1                         (W5_REG_BASE + 0x0128)
+#define W5_RET_CONF_FEATURE                     (W5_REG_BASE + 0x012C)
+#define W5_RET_CONF_DATE                        (W5_REG_BASE + 0x0130)
+#define W5_RET_CONF_REVISION                    (W5_REG_BASE + 0x0134)
+#define W5_RET_CONF_TYPE                        (W5_REG_BASE + 0x0138)
+#define W5_RET_PRODUCT_ID                       (W5_REG_BASE + 0x013C)
+#define W5_RET_CUSTOMER_ID                      (W5_REG_BASE + 0x0140)
+
+/************************************************************************/
+/* DECODER - QUERY : GET_RESULT                                         */
+/************************************************************************/
+#define W5_CMD_DEC_ADDR_REPORT_BASE         (W5_REG_BASE + 0x0114)
+#define W5_CMD_DEC_REPORT_SIZE              (W5_REG_BASE + 0x0118)
+#define W5_CMD_DEC_REPORT_PARAM             (W5_REG_BASE + 0x011C)
+
+#define W5_RET_DEC_BS_RD_PTR                (W5_REG_BASE + 0x011C)
+#define W5_RET_DEC_SEQ_PARAM                (W5_REG_BASE + 0x0120)
+#define W5_RET_DEC_COLOR_SAMPLE_INFO        (W5_REG_BASE + 0x0124)
+#define W5_RET_DEC_ASPECT_RATIO             (W5_REG_BASE + 0x0128)
+#define W5_RET_DEC_BIT_RATE                 (W5_REG_BASE + 0x012C)
+#define W5_RET_DEC_FRAME_RATE_NR            (W5_REG_BASE + 0x0130)
+#define W5_RET_DEC_FRAME_RATE_DR            (W5_REG_BASE + 0x0134)
+#define W5_RET_DEC_NUM_REQUIRED_FB          (W5_REG_BASE + 0x0138)
+#define W5_RET_DEC_NUM_REORDER_DELAY        (W5_REG_BASE + 0x013C)
+#define W5_RET_DEC_SUB_LAYER_INFO           (W5_REG_BASE + 0x0140)
+#define W5_RET_DEC_NOTIFICATION             (W5_REG_BASE + 0x0144)
+#define W5_RET_DEC_USERDATA_IDC             (W5_REG_BASE + 0x0148)
+#define W5_RET_DEC_PIC_SIZE                 (W5_REG_BASE + 0x014C)
+#define W5_RET_DEC_CROP_TOP_BOTTOM          (W5_REG_BASE + 0x0150)
+#define W5_RET_DEC_CROP_LEFT_RIGHT          (W5_REG_BASE + 0x0154)
+#define W5_RET_DEC_AU_START_POS             (W5_REG_BASE + 0x0158)
+#define W5_RET_DEC_AU_END_POS               (W5_REG_BASE + 0x015C)
+#define W5_RET_DEC_PIC_TYPE                 (W5_REG_BASE + 0x0160)
+#define W5_RET_DEC_PIC_POC                  (W5_REG_BASE + 0x0164)
+#define W5_RET_DEC_RECOVERY_POINT           (W5_REG_BASE + 0x0168)
+#define W5_RET_DEC_DEBUG_INDEX              (W5_REG_BASE + 0x016C)
+#define W5_RET_DEC_DECODED_INDEX            (W5_REG_BASE + 0x0170)
+#define W5_RET_DEC_DISPLAY_INDEX            (W5_REG_BASE + 0x0174)
+#define W5_RET_DEC_REALLOC_INDEX            (W5_REG_BASE + 0x0178)
+#define W5_RET_DEC_DISP_IDC                 (W5_REG_BASE + 0x017C)
+#define W5_RET_DEC_ERR_CTB_NUM              (W5_REG_BASE + 0x0180)
+#define W5_RET_DEC_PIC_PARAM                (W5_REG_BASE + 0x01A0)
+
+#define W5_RET_DEC_HOST_CMD_TICK            (W5_REG_BASE + 0x01B8)
+#define W5_RET_DEC_SEEK_START_TICK          (W5_REG_BASE + 0x01BC)
+#define W5_RET_DEC_SEEK_END_TICK            (W5_REG_BASE + 0x01C0)
+#define W5_RET_DEC_PARSING_START_TICK       (W5_REG_BASE + 0x01C4)
+#define W5_RET_DEC_PARSING_END_TICK         (W5_REG_BASE + 0x01C8)
+#define W5_RET_DEC_DECODING_START_TICK      (W5_REG_BASE + 0x01CC)
+#define W5_RET_DEC_DECODING_ENC_TICK        (W5_REG_BASE + 0x01D0)
+#define W5_RET_DEC_WARN_INFO                (W5_REG_BASE + 0x01D4)
+#define W5_RET_DEC_ERR_INFO                 (W5_REG_BASE + 0x01D8)
+#define W5_RET_DEC_DECODING_SUCCESS         (W5_REG_BASE + 0x01DC)
+
+/************************************************************************/
+/* DECODER - FLUSH_INSTANCE                                             */
+/************************************************************************/
+#define W5_CMD_FLUSH_INST_OPT               (W5_REG_BASE + 0x104)
+
+/************************************************************************/
+/* DECODER - QUERY : UPDATE_DISP_FLAG                                   */
+/************************************************************************/
+#define W5_CMD_DEC_SET_DISP_IDC             (W5_REG_BASE + 0x0118)
+#define W5_CMD_DEC_CLR_DISP_IDC             (W5_REG_BASE + 0x011C)
+
+/************************************************************************/
+/* DECODER - QUERY : SET_BS_RD_PTR                                      */
+/************************************************************************/
+#define W5_RET_QUERY_DEC_SET_BS_RD_PTR      (W5_REG_BASE + 0x011C)
+
+/************************************************************************/
+/* DECODER - QUERY : GET_BS_RD_PTR                                      */
+/************************************************************************/
+#define W5_RET_QUERY_DEC_BS_RD_PTR          (W5_REG_BASE + 0x011C)
+
+/************************************************************************/
+/* QUERY : GET_DEBUG_INFO                                               */
+/************************************************************************/
+#define W5_RET_QUERY_DEBUG_PRI_REASON       (W5_REG_BASE + 0x114)
+
+/************************************************************************/
+/* GDI register for debugging                                           */
+/************************************************************************/
+#define W5_GDI_BASE                         0x8800
+#define W5_GDI_BUS_CTRL                     (W5_GDI_BASE + 0x0F0)
+#define W5_GDI_BUS_STATUS                   (W5_GDI_BASE + 0x0F4)
+
+#define W5_BACKBONE_BASE_VCPU               0xFE00
+#define W5_BACKBONE_BUS_CTRL_VCPU           (W5_BACKBONE_BASE_VCPU + 0x010)
+#define W5_BACKBONE_BUS_STATUS_VCPU         (W5_BACKBONE_BASE_VCPU + 0x014)
+#define W5_BACKBONE_PROG_AXI_ID             (W5_BACKBONE_BASE_VCPU + 0x00C)
+
+#define W5_BACKBONE_BASE_VCORE0             0x8E00
+#define W5_BACKBONE_BUS_CTRL_VCORE0         (W5_BACKBONE_BASE_VCORE0 + 0x010)
+#define W5_BACKBONE_BUS_STATUS_VCORE0       (W5_BACKBONE_BASE_VCORE0 + 0x014)
+
+#define W5_BACKBONE_BASE_VCORE1             0x9E00  // for dual-core product
+#define W5_BACKBONE_BUS_CTRL_VCORE1         (W5_BACKBONE_BASE_VCORE1 + 0x010)
+#define W5_BACKBONE_BUS_STATUS_VCORE1       (W5_BACKBONE_BASE_VCORE1 + 0x014)
+
+#define W5_COMBINED_BACKBONE_BASE           0xFE00
+#define W5_COMBINED_BACKBONE_BUS_CTRL       (W5_COMBINED_BACKBONE_BASE + 0x010)
+#define W5_COMBINED_BACKBONE_BUS_STATUS     (W5_COMBINED_BACKBONE_BASE + 0x014)
+
+/************************************************************************/
+/*                                                                      */
+/*               for  ENCODER                                           */
+/*                                                                      */
+/************************************************************************/
+#define W5_RET_STAGE3_INSTANCE_INFO             (W5_REG_BASE + 0x1F8)
+/************************************************************************/
+/* ENCODER - CREATE_INSTANCE                                            */
+/************************************************************************/
+// 0x114 ~ 0x124 : defined above (CREATE_INSTANCE COMMON)
+#define W5_CMD_ENC_VCORE_INFO                   (W5_REG_BASE + 0x0194)
+#define W5_CMD_ENC_SRC_OPTIONS                  (W5_REG_BASE + 0x0128)
+
+/************************************************************************/
+/* ENCODER - SET_FB                                                     */
+/************************************************************************/
+#define W5_FBC_STRIDE                           (W5_REG_BASE + 0x128)
+#define W5_ADDR_SUB_SAMPLED_FB_BASE             (W5_REG_BASE + 0x12C)
+#define W5_SUB_SAMPLED_ONE_FB_SIZE              (W5_REG_BASE + 0x130)
+
+/************************************************************************/
+/* ENCODER - ENC_SET_PARAM (COMMON & CHANGE_PARAM)                      */
+/************************************************************************/
+#define W5_CMD_ENC_SEQ_SET_PARAM_OPTION         (W5_REG_BASE + 0x104)
+#define W5_CMD_ENC_SEQ_SET_PARAM_ENABLE         (W5_REG_BASE + 0x118)
+#define W5_CMD_ENC_SEQ_SRC_SIZE                 (W5_REG_BASE + 0x11C)
+#define W5_CMD_ENC_SEQ_CUSTOM_MAP_ENDIAN        (W5_REG_BASE + 0x120)
+#define W5_CMD_ENC_SEQ_SPS_PARAM                (W5_REG_BASE + 0x124)
+#define W5_CMD_ENC_SEQ_PPS_PARAM                (W5_REG_BASE + 0x128)
+#define W5_CMD_ENC_SEQ_GOP_PARAM                (W5_REG_BASE + 0x12C)
+#define W5_CMD_ENC_SEQ_INTRA_PARAM              (W5_REG_BASE + 0x130)
+#define W5_CMD_ENC_SEQ_CONF_WIN_TOP_BOT         (W5_REG_BASE + 0x134)
+#define W5_CMD_ENC_SEQ_CONF_WIN_LEFT_RIGHT      (W5_REG_BASE + 0x138)
+#define W5_CMD_ENC_SEQ_RDO_PARAM                (W5_REG_BASE + 0x13C)
+#define W5_CMD_ENC_SEQ_INDEPENDENT_SLICE        (W5_REG_BASE + 0x140)
+#define W5_CMD_ENC_SEQ_DEPENDENT_SLICE          (W5_REG_BASE + 0x144)
+#define W5_CMD_ENC_SEQ_INTRA_REFRESH            (W5_REG_BASE + 0x148)
+#define W5_CMD_ENC_SEQ_INPUT_SRC_PARAM          (W5_REG_BASE + 0x14C)
+
+#define W5_CMD_ENC_SEQ_RC_FRAME_RATE            (W5_REG_BASE + 0x150)
+#define W5_CMD_ENC_SEQ_RC_TARGET_RATE           (W5_REG_BASE + 0x154)
+#define W5_CMD_ENC_SEQ_RC_PARAM                 (W5_REG_BASE + 0x158)
+#define W5_CMD_ENC_SEQ_RC_MIN_MAX_QP            (W5_REG_BASE + 0x15C)
+#define W5_CMD_ENC_SEQ_RC_BIT_RATIO_LAYER_0_3   (W5_REG_BASE + 0x160)
+#define W5_CMD_ENC_SEQ_RC_BIT_RATIO_LAYER_4_7   (W5_REG_BASE + 0x164)
+#define W5_CMD_ENC_SEQ_RC_INTER_MIN_MAX_QP      (W5_REG_BASE + 0x168)
+#define W5_CMD_ENC_SEQ_RC_WEIGHT_PARAM          (W5_REG_BASE + 0x16C)
+
+#define W5_CMD_ENC_SEQ_ROT_PARAM                (W5_REG_BASE + 0x170)
+#define W5_CMD_ENC_SEQ_NUM_UNITS_IN_TICK        (W5_REG_BASE + 0x174)
+#define W5_CMD_ENC_SEQ_TIME_SCALE               (W5_REG_BASE + 0x178)
+#define W5_CMD_ENC_SEQ_NUM_TICKS_POC_DIFF_ONE   (W5_REG_BASE + 0x17C)
+
+#define W5_CMD_ENC_SEQ_CUSTOM_MD_PU04           (W5_REG_BASE + 0x184)
+#define W5_CMD_ENC_SEQ_CUSTOM_MD_PU08           (W5_REG_BASE + 0x188)
+#define W5_CMD_ENC_SEQ_CUSTOM_MD_PU16           (W5_REG_BASE + 0x18C)
+#define W5_CMD_ENC_SEQ_CUSTOM_MD_PU32           (W5_REG_BASE + 0x190)
+#define W5_CMD_ENC_SEQ_CUSTOM_MD_CU08           (W5_REG_BASE + 0x194)
+#define W5_CMD_ENC_SEQ_CUSTOM_MD_CU16           (W5_REG_BASE + 0x198)
+#define W5_CMD_ENC_SEQ_CUSTOM_MD_CU32           (W5_REG_BASE + 0x19C)
+#define W5_CMD_ENC_SEQ_NR_PARAM                 (W5_REG_BASE + 0x1A0)
+#define W5_CMD_ENC_SEQ_NR_WEIGHT                (W5_REG_BASE + 0x1A4)
+#define W5_CMD_ENC_SEQ_BG_PARAM                 (W5_REG_BASE + 0x1A8)
+#define W5_CMD_ENC_SEQ_CUSTOM_LAMBDA_ADDR       (W5_REG_BASE + 0x1AC)
+#define W5_CMD_ENC_SEQ_USER_SCALING_LIST_ADDR   (W5_REG_BASE + 0x1B0)
+#define W5_CMD_ENC_SEQ_VUI_HRD_PARAM            (W5_REG_BASE + 0x180)
+#define W5_CMD_ENC_SEQ_VUI_RBSP_ADDR            (W5_REG_BASE + 0x1B8)
+#define W5_CMD_ENC_SEQ_HRD_RBSP_ADDR            (W5_REG_BASE + 0x1BC)
+
+/************************************************************************/
+/* ENCODER - ENC_SET_PARAM (CUSTOM_GOP)                                 */
+/************************************************************************/
+#define W5_CMD_ENC_CUSTOM_GOP_PARAM             (W5_REG_BASE + 0x11C)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_0       (W5_REG_BASE + 0x120)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_1       (W5_REG_BASE + 0x124)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_2       (W5_REG_BASE + 0x128)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_3       (W5_REG_BASE + 0x12C)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_4       (W5_REG_BASE + 0x130)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_5       (W5_REG_BASE + 0x134)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_6       (W5_REG_BASE + 0x138)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_7       (W5_REG_BASE + 0x13C)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_8       (W5_REG_BASE + 0x140)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_9       (W5_REG_BASE + 0x144)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_10      (W5_REG_BASE + 0x148)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_11      (W5_REG_BASE + 0x14C)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_12      (W5_REG_BASE + 0x150)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_13      (W5_REG_BASE + 0x154)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_14      (W5_REG_BASE + 0x158)
+#define W5_CMD_ENC_CUSTOM_GOP_PIC_PARAM_15      (W5_REG_BASE + 0x15C)
+
+/************************************************************************/
+/* ENCODER - ENC_PIC                                                    */
+/************************************************************************/
+#define W5_CMD_ENC_BS_START_ADDR                (W5_REG_BASE + 0x118)
+#define W5_CMD_ENC_BS_SIZE                      (W5_REG_BASE + 0x11C)
+#define W5_CMD_ENC_PIC_USE_SEC_AXI              (W5_REG_BASE + 0x124)
+#define W5_CMD_ENC_PIC_REPORT_PARAM             (W5_REG_BASE + 0x128)
+
+#define W5_CMD_ENC_PIC_CUSTOM_MAP_OPTION_PARAM  (W5_REG_BASE + 0x138)
+#define W5_CMD_ENC_PIC_CUSTOM_MAP_OPTION_ADDR   (W5_REG_BASE + 0x13C)
+#define W5_CMD_ENC_PIC_SRC_PIC_IDX              (W5_REG_BASE + 0x144)
+#define W5_CMD_ENC_PIC_SRC_ADDR_Y               (W5_REG_BASE + 0x148)
+#define W5_CMD_ENC_PIC_SRC_ADDR_U               (W5_REG_BASE + 0x14C)
+#define W5_CMD_ENC_PIC_SRC_ADDR_V               (W5_REG_BASE + 0x150)
+#define W5_CMD_ENC_PIC_SRC_STRIDE               (W5_REG_BASE + 0x154)
+#define W5_CMD_ENC_PIC_SRC_FORMAT               (W5_REG_BASE + 0x158)
+#define W5_CMD_ENC_PIC_SRC_AXI_SEL              (W5_REG_BASE + 0x160)
+#define W5_CMD_ENC_PIC_CODE_OPTION              (W5_REG_BASE + 0x164)
+#define W5_CMD_ENC_PIC_PIC_PARAM                (W5_REG_BASE + 0x168)
+#define W5_CMD_ENC_PIC_LONGTERM_PIC             (W5_REG_BASE + 0x16C)
+#define W5_CMD_ENC_PIC_WP_PIXEL_SIGMA_Y         (W5_REG_BASE + 0x170)
+#define W5_CMD_ENC_PIC_WP_PIXEL_SIGMA_C         (W5_REG_BASE + 0x174)
+#define W5_CMD_ENC_PIC_WP_PIXEL_MEAN_Y          (W5_REG_BASE + 0x178)
+#define W5_CMD_ENC_PIC_WP_PIXEL_MEAN_C          (W5_REG_BASE + 0x17C)
+#define W5_CMD_ENC_PIC_CF50_Y_OFFSET_TABLE_ADDR  (W5_REG_BASE + 0x190)
+#define W5_CMD_ENC_PIC_CF50_CB_OFFSET_TABLE_ADDR (W5_REG_BASE + 0x194)
+#define W5_CMD_ENC_PIC_CF50_CR_OFFSET_TABLE_ADDR (W5_REG_BASE + 0x198)
+#define W5_CMD_ENC_PIC_PREFIX_SEI_NAL_ADDR       (W5_REG_BASE + 0x180)
+#define W5_CMD_ENC_PIC_PREFIX_SEI_INFO           (W5_REG_BASE + 0x184)
+#define W5_CMD_ENC_PIC_SUFFIX_SEI_NAL_ADDR       (W5_REG_BASE + 0x188)
+#define W5_CMD_ENC_PIC_SUFFIX_SEI_INFO           (W5_REG_BASE + 0x18c)
+
+/************************************************************************/
+/* ENCODER - QUERY (GET_RESULT)                                         */
+/************************************************************************/
+#define W5_RET_ENC_NUM_REQUIRED_FB              (W5_REG_BASE + 0x11C)
+#define W5_RET_ENC_MIN_SRC_BUF_NUM              (W5_REG_BASE + 0x120)
+#define W5_RET_ENC_PIC_TYPE                     (W5_REG_BASE + 0x124)
+#define W5_RET_ENC_PIC_POC                      (W5_REG_BASE + 0x128)
+#define W5_RET_ENC_PIC_IDX                      (W5_REG_BASE + 0x12C)
+#define W5_RET_ENC_PIC_SLICE_NUM                (W5_REG_BASE + 0x130)
+#define W5_RET_ENC_PIC_SKIP                     (W5_REG_BASE + 0x134)
+#define W5_RET_ENC_PIC_NUM_INTRA                (W5_REG_BASE + 0x138)
+#define W5_RET_ENC_PIC_NUM_MERGE                (W5_REG_BASE + 0x13C)
+
+#define W5_RET_ENC_PIC_NUM_SKIP                 (W5_REG_BASE + 0x144)
+#define W5_RET_ENC_PIC_AVG_CTU_QP               (W5_REG_BASE + 0x148)
+#define W5_RET_ENC_PIC_BYTE                     (W5_REG_BASE + 0x14C)
+#define W5_RET_ENC_GOP_PIC_IDX                  (W5_REG_BASE + 0x150)
+#define W5_RET_ENC_USED_SRC_IDX                 (W5_REG_BASE + 0x154)
+#define W5_RET_ENC_PIC_NUM                      (W5_REG_BASE + 0x158)
+#define W5_RET_ENC_VCL_NUT                      (W5_REG_BASE + 0x15C)
+
+#define W5_RET_ENC_PIC_DIST_LOW                 (W5_REG_BASE + 0x164)
+#define W5_RET_ENC_PIC_DIST_HIGH                (W5_REG_BASE + 0x168)
+
+#define W5_RET_ENC_PIC_MAX_LATENCY_PICS     (W5_REG_BASE + 0x16C)
+
+#define W5_RET_ENC_HOST_CMD_TICK                (W5_REG_BASE + 0x1B8)
+#define W5_RET_ENC_PREPARE_START_TICK           (W5_REG_BASE + 0x1BC)
+#define W5_RET_ENC_PREPARE_END_TICK             (W5_REG_BASE + 0x1C0)
+#define W5_RET_ENC_PROCESSING_START_TICK        (W5_REG_BASE + 0x1C4)
+#define W5_RET_ENC_PROCESSING_END_TICK          (W5_REG_BASE + 0x1C8)
+#define W5_RET_ENC_ENCODING_START_TICK          (W5_REG_BASE + 0x1CC)
+#define W5_RET_ENC_ENCODING_END_TICK            (W5_REG_BASE + 0x1D0)
+
+#define W5_RET_ENC_WARN_INFO                    (W5_REG_BASE + 0x1D4)
+#define W5_RET_ENC_ERR_INFO                     (W5_REG_BASE + 0x1D8)
+#define W5_RET_ENC_ENCODING_SUCCESS             (W5_REG_BASE + 0x1DC)
+
+/************************************************************************/
+/* ENCODER - QUERY (GET_BS_WR_PTR)                                      */
+/************************************************************************/
+#define W5_RET_ENC_RD_PTR                       (W5_REG_BASE + 0x114)
+#define W5_RET_ENC_WR_PTR                       (W5_REG_BASE + 0x118)
+#define W5_CMD_ENC_REASON_SEL                   (W5_REG_BASE + 0x11C)
+
+/************************************************************************/
+/* ENCODER - QUERY (GET_BW_REPORT)                                      */
+/************************************************************************/
+#define RET_QUERY_BW_PRP_AXI_READ               (W5_REG_BASE + 0x118)
+#define RET_QUERY_BW_PRP_AXI_WRITE              (W5_REG_BASE + 0x11C)
+#define RET_QUERY_BW_FBD_Y_AXI_READ             (W5_REG_BASE + 0x120)
+#define RET_QUERY_BW_FBC_Y_AXI_WRITE            (W5_REG_BASE + 0x124)
+#define RET_QUERY_BW_FBD_C_AXI_READ             (W5_REG_BASE + 0x128)
+#define RET_QUERY_BW_FBC_C_AXI_WRITE            (W5_REG_BASE + 0x12C)
+#define RET_QUERY_BW_PRI_AXI_READ               (W5_REG_BASE + 0x130)
+#define RET_QUERY_BW_PRI_AXI_WRITE              (W5_REG_BASE + 0x134)
+#define RET_QUERY_BW_SEC_AXI_READ               (W5_REG_BASE + 0x138)
+#define RET_QUERY_BW_SEC_AXI_WRITE              (W5_REG_BASE + 0x13C)
+#define RET_QUERY_BW_PROC_AXI_READ              (W5_REG_BASE + 0x140)
+#define RET_QUERY_BW_PROC_AXI_WRITE             (W5_REG_BASE + 0x144)
+#define RET_QUERY_BW_BWB_AXI_WRITE              (W5_REG_BASE + 0x148)
+#define W5_CMD_BW_OPTION                        (W5_REG_BASE + 0x14C)
+
+/************************************************************************/
+/* ENCODER - QUERY (GET_SRC_FLAG)                                       */
+/************************************************************************/
+#define W5_RET_ENC_SRC_BUF_FLAG                 (W5_REG_BASE + 0x18C)
+#define W5_RET_RELEASED_SRC_INSTANCE            (W5_REG_BASE + 0x1EC)
+
+#define W5_ENC_PIC_SUB_FRAME_SYNC_IF            (W5_REG_BASE + 0x0300)
+
+#endif /* __WAVE5_REGISTER_DEFINE_H__ */
+
diff --git a/drivers/staging/media/wave5/wave5-vpuapi.c b/drivers/staging/media/wave5/wave5-vpuapi.c
new file mode 100644
index 000000000000..5a80007c9523
--- /dev/null
+++ b/drivers/staging/media/wave5/wave5-vpuapi.c
@@ -0,0 +1,1053 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Wave5 series multi-standard codec IP - helper functions
+ *
+ * Copyright (C) 2021 CHIPS&MEDIA INC
+ */
+
+#include <linux/bug.h>
+#include "wave5-vpuapi.h"
+#include "wave5-regdefine.h"
+#include "wave5.h"
+
+#define DECODE_ALL_TEMPORAL_LAYERS 0
+#define DECODE_ALL_SPATIAL_LAYERS 0
+
+void wave5_vpu_clear_interrupt_ex(struct vpu_instance *inst, int32_t intr_flag)
+{
+	wave5_vpu_clear_interrupt(inst, intr_flag);
+}
+
+static int wave5_initialize_vpu(struct device *dev, u8 *code, uint32_t size)
+{
+	int ret;
+	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	if (wave5_vpu_is_init(vpu_dev)) {
+		wave5_vpu_re_init(dev, (void *)code, size);
+		ret = -EBUSY;
+		goto err_out;
+	}
+
+	ret = wave5_vpu_reset(dev, SW_RESET_ON_BOOT);
+	if (ret)
+		goto err_out;
+
+	ret = wave5_vpu_init(dev, (void *)code, size);
+
+err_out:
+	mutex_unlock(&vpu_dev->hw_lock);
+	return ret;
+}
+
+int wave5_vpu_init_with_bitcode(struct device *dev, u8 *code, uint32_t size)
+{
+	if (!code || size == 0)
+		return -EINVAL;
+
+	return wave5_initialize_vpu(dev, code, size);
+}
+
+int wave5_vpu_get_version_info(struct device *dev, uint32_t *version_info,
+			       u32 *revision, uint32_t *product_id)
+{
+	int ret;
+	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	if (!wave5_vpu_is_init(vpu_dev)) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
+	if (product_id)
+		*product_id = vpu_dev->product;
+	ret = wave5_vpu_get_version(vpu_dev, version_info, revision);
+
+err_out:
+	mutex_unlock(&vpu_dev->hw_lock);
+	return ret;
+}
+
+static int wave5_check_dec_open_param(struct vpu_device *dev, struct dec_open_param *param)
+{
+	struct vpu_attr *p_attr;
+
+	p_attr = &dev->attr;
+
+	if (param->bitstream_buffer % 8)
+		return -EINVAL;
+
+	if (param->bitstream_mode == BS_MODE_INTERRUPT &&
+	    (param->bitstream_buffer_size % 1024 || param->bitstream_buffer_size < 1024))
+		return -EINVAL;
+
+	if (!(BIT(param->bitstream_mode) & p_attr->support_bitstream_mode))
+		return -EINVAL;
+
+	if (!(BIT(param->frame_endian) & p_attr->support_endian_mask))
+		return -EINVAL;
+
+	if (!(BIT(param->stream_endian) & p_attr->support_endian_mask))
+		return -EINVAL;
+
+	return 0;
+}
+
+int wave5_vpu_dec_open(struct vpu_instance *vpu_inst, struct dec_open_param *pop)
+{
+	struct dec_info *p_dec_info;
+	int ret;
+	struct vpu_device *vpu_dev = vpu_inst->dev;
+
+	ret = wave5_check_dec_open_param(vpu_dev, pop);
+	if (ret)
+		return ret;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	if (!wave5_vpu_is_init(vpu_dev))
+		return -ENODEV;
+
+	vpu_inst->codec_info = kzalloc(sizeof(*vpu_inst->codec_info), GFP_KERNEL);
+	if (!vpu_inst->codec_info)
+		return -ENOMEM;
+
+	vpu_inst->id = ida_alloc_max(&vpu_inst->dev->inst_ida, MAX_NUM_INSTANCE - 1, GFP_KERNEL);
+	if (vpu_inst->id < 0) {
+		dev_warn(vpu_inst->dev->dev, "unable to allocate instance ID: %d\n", vpu_inst->id);
+		ret = vpu_inst->id;
+		goto free_codec_info;
+	}
+	p_dec_info = &vpu_inst->codec_info->dec_info;
+	memcpy(&p_dec_info->open_param, pop, sizeof(struct dec_open_param));
+
+	p_dec_info->stream_wr_ptr = pop->bitstream_buffer;
+	p_dec_info->stream_rd_ptr = pop->bitstream_buffer;
+	p_dec_info->stream_buf_start_addr = pop->bitstream_buffer;
+	p_dec_info->stream_buf_size = pop->bitstream_buffer_size;
+	p_dec_info->stream_buf_end_addr = pop->bitstream_buffer + pop->bitstream_buffer_size;
+	p_dec_info->reorder_enable = TRUE;
+	p_dec_info->mirror_direction = MIRDIR_NONE;
+	p_dec_info->temp_id_select_mode = TEMPORAL_ID_MODE_ABSOLUTE;
+	p_dec_info->target_temp_id = DECODE_ALL_TEMPORAL_LAYERS;
+	p_dec_info->target_spatial_id = DECODE_ALL_SPATIAL_LAYERS;
+
+	ret = wave5_vpu_build_up_dec_param(vpu_inst, pop);
+	if (ret)
+		goto free_ida;
+
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return 0;
+
+free_ida:
+	ida_free(&vpu_inst->dev->inst_ida, vpu_inst->id);
+free_codec_info:
+	kfree(vpu_inst->codec_info);
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_dec_close(struct vpu_instance *inst, u32 *fail_res)
+{
+	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+	int i;
+
+	*fail_res = 0;
+	if (!inst->codec_info)
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	ret = wave5_vpu_dec_fini_seq(inst, fail_res);
+	if (ret) {
+		dev_warn(inst->dev->dev, "dec sec end timed out\n");
+
+		if (*fail_res == WAVE5_SYSERR_VPU_STILL_RUNNING) {
+			mutex_unlock(&vpu_dev->hw_lock);
+			return ret;
+		}
+	}
+
+	dev_dbg(inst->dev->dev, "dec seq end complete\n");
+
+	if (p_dec_info->vb_work.size)
+		wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_work);
+
+	for (i = 0 ; i < MAX_REG_FRAME; i++) {
+		if (p_dec_info->vb_mv[i].size)
+			wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_mv[i]);
+		if (p_dec_info->vb_fbc_y_tbl[i].size)
+			wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_fbc_y_tbl[i]);
+		if (p_dec_info->vb_fbc_c_tbl[i].size)
+			wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_fbc_c_tbl[i]);
+	}
+
+	if (p_dec_info->vb_task.size)
+		wave5_vdi_free_dma_memory(vpu_dev, &p_dec_info->vb_task);
+
+	ida_free(&inst->dev->inst_ida, inst->id);
+
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	kfree(inst->codec_info);
+
+	return 0;
+}
+
+int wave5_vpu_dec_issue_seq_init(struct vpu_instance *inst)
+{
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	ret = wave5_vpu_dec_init_seq(inst);
+
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_dec_complete_seq_init(struct vpu_instance *inst, struct dec_initial_info *info)
+{
+	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	ret = wave5_vpu_dec_get_seq_info(inst, info);
+	if (!ret)
+		p_dec_info->initial_info_obtained = true;
+
+	info->rd_ptr = wave5_vpu_dec_get_rd_ptr(inst);
+	info->wr_ptr = p_dec_info->stream_wr_ptr;
+
+	p_dec_info->initial_info = *info;
+
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_dec_register_frame_buffer_ex(struct vpu_instance *inst,
+					   int num_fbs_for_decoding, int num_fbs_for_wtl,
+					 int stride, int height, int map_type)
+{
+	struct dec_info *p_dec_info;
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+	struct frame_buffer *fb;
+
+	if (num_fbs_for_decoding > WAVE5_MAX_FBS)
+		return -EINVAL;
+
+	if (num_fbs_for_wtl > WAVE5_MAX_FBS)
+		return -EINVAL;
+
+	p_dec_info = &inst->codec_info->dec_info;
+	p_dec_info->num_fbs_for_decoding = num_fbs_for_decoding;
+	p_dec_info->num_fbs_for_wtl = num_fbs_for_wtl;
+	p_dec_info->stride = stride;
+
+	if (!p_dec_info->initial_info_obtained)
+		return -EINVAL;
+
+	if (stride < p_dec_info->initial_info.pic_width || (stride % 8 != 0) ||
+	    height < p_dec_info->initial_info.pic_height)
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	fb = inst->frame_buf;
+	ret = wave5_vpu_dec_register_framebuffer(inst, &fb[p_dec_info->num_fbs_for_decoding],
+						 LINEAR_FRAME_MAP, p_dec_info->num_fbs_for_wtl);
+	if (ret)
+		goto err_out;
+
+	ret = wave5_vpu_dec_register_framebuffer(inst, &fb[0], COMPRESSED_FRAME_MAP,
+						 p_dec_info->num_fbs_for_decoding);
+
+err_out:
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_dec_get_bitstream_buffer(struct vpu_instance *inst, dma_addr_t *prd_ptr,
+				       dma_addr_t *pwr_ptr, uint32_t *size)
+{
+	struct dec_info *p_dec_info;
+	dma_addr_t rd_ptr;
+	dma_addr_t wr_ptr;
+	dma_addr_t temp_ptr;
+	int room;
+	struct vpu_device *vpu_dev = inst->dev;
+	int ret;
+
+	p_dec_info = &inst->codec_info->dec_info;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+	rd_ptr = wave5_vpu_dec_get_rd_ptr(inst);
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	wr_ptr = p_dec_info->stream_wr_ptr;
+
+	temp_ptr = rd_ptr;
+
+	if (p_dec_info->open_param.bitstream_mode != BS_MODE_PIC_END) {
+		if (wr_ptr < temp_ptr)
+			room = temp_ptr - wr_ptr;
+		else
+			room = (p_dec_info->stream_buf_end_addr - wr_ptr) +
+				(temp_ptr - p_dec_info->stream_buf_start_addr);
+		room--;
+	} else {
+		room = (p_dec_info->stream_buf_end_addr - wr_ptr);
+	}
+
+	if (prd_ptr)
+		*prd_ptr = temp_ptr;
+	if (pwr_ptr)
+		*pwr_ptr = wr_ptr;
+	if (size)
+		*size = room;
+
+	return 0;
+}
+
+int wave5_vpu_dec_update_bitstream_buffer(struct vpu_instance *inst, int size)
+{
+	struct dec_info *p_dec_info;
+	dma_addr_t wr_ptr;
+	dma_addr_t rd_ptr;
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	if (!inst->codec_info)
+		return -EINVAL;
+
+	p_dec_info = &inst->codec_info->dec_info;
+	wr_ptr = p_dec_info->stream_wr_ptr;
+	rd_ptr = p_dec_info->stream_rd_ptr;
+
+	if (size > 0) {
+		if (wr_ptr < rd_ptr && rd_ptr <= wr_ptr + size)
+			return -EINVAL;
+
+		wr_ptr += size;
+
+		if (p_dec_info->open_param.bitstream_mode != BS_MODE_PIC_END) {
+			if (wr_ptr > p_dec_info->stream_buf_end_addr) {
+				u32 room = wr_ptr - p_dec_info->stream_buf_end_addr;
+
+				wr_ptr = p_dec_info->stream_buf_start_addr;
+				wr_ptr += room;
+			} else if (wr_ptr == p_dec_info->stream_buf_end_addr) {
+				wr_ptr = p_dec_info->stream_buf_start_addr;
+			}
+		}
+
+		p_dec_info->stream_wr_ptr = wr_ptr;
+		p_dec_info->stream_rd_ptr = rd_ptr;
+	}
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+	ret = wave5_vpu_dec_set_bitstream_flag(inst, (size == 0));
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_dec_start_one_frame(struct vpu_instance *inst, struct dec_param *param, u32 *res_fail)
+{
+	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	if (p_dec_info->stride == 0) // this means frame buffers have not been registered.
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	p_dec_info->frame_start_pos = p_dec_info->stream_rd_ptr;
+
+	ret = wave5_vpu_decode(inst, param, res_fail);
+
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_dec_get_output_info(struct vpu_instance *inst, struct dec_output_info *info)
+{
+	struct dec_info *p_dec_info;
+	int ret;
+	struct vpu_rect rect_info;
+	u32 val;
+	u32 decoded_index;
+	u32 disp_idx;
+	u32 max_dec_index;
+	struct vpu_device *vpu_dev = inst->dev;
+	struct dec_output_info *disp_info;
+
+	if (!info)
+		return -EINVAL;
+
+	p_dec_info = &inst->codec_info->dec_info;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	memset(info, 0, sizeof(*info));
+
+	ret = wave5_vpu_dec_get_result(inst, info);
+	if (ret) {
+		info->rd_ptr = p_dec_info->stream_rd_ptr;
+		info->wr_ptr = p_dec_info->stream_wr_ptr;
+		goto err_out;
+	}
+
+	decoded_index = info->index_frame_decoded;
+
+	// calculate display frame region
+	val = 0;
+	if (decoded_index < WAVE5_MAX_FBS) {
+		//default value
+		rect_info.left = 0;
+		rect_info.right = info->dec_pic_width;
+		rect_info.top = 0;
+		rect_info.bottom = info->dec_pic_height;
+
+		if (inst->std == W_HEVC_DEC || inst->std == W_AVC_DEC)
+			rect_info = p_dec_info->initial_info.pic_crop_rect;
+
+		if (inst->std == W_HEVC_DEC)
+			p_dec_info->dec_out_info[decoded_index].decoded_poc = info->decoded_poc;
+
+		if (inst->std == W_AVS2_DEC)
+			p_dec_info->dec_out_info[decoded_index].avs2_info.decoded_poi =
+				info->avs2_info.decoded_poi;
+
+		info->rc_decoded.left = rect_info.left;
+		p_dec_info->dec_out_info[decoded_index].rc_decoded.left = rect_info.left;
+		info->rc_decoded.right = rect_info.right;
+		p_dec_info->dec_out_info[decoded_index].rc_decoded.right = rect_info.right;
+		info->rc_decoded.top = rect_info.top;
+		p_dec_info->dec_out_info[decoded_index].rc_decoded.top = rect_info.top;
+		info->rc_decoded.bottom = rect_info.bottom;
+		p_dec_info->dec_out_info[decoded_index].rc_decoded.bottom = rect_info.bottom;
+	} else {
+		info->rc_decoded.left = 0;
+		info->rc_decoded.right = info->dec_pic_width;
+		info->rc_decoded.top = 0;
+		info->rc_decoded.bottom = info->dec_pic_height;
+	}
+
+	disp_idx = info->index_frame_display;
+	disp_info = &p_dec_info->dec_out_info[disp_idx];
+	if (info->index_frame_display >= 0 && info->index_frame_display < WAVE5_MAX_FBS) {
+		if (p_dec_info->rotation_enable) {
+			switch (p_dec_info->rotation_angle) {
+			case 90:
+				info->rc_display.left =
+					disp_info->rc_decoded.top;
+				info->rc_display.right =
+					disp_info->rc_decoded.bottom;
+				info->rc_display.top =
+					disp_info->dec_pic_width -
+					disp_info->rc_decoded.right;
+					info->rc_display.bottom =
+						disp_info->dec_pic_width -
+						disp_info->rc_decoded.left;
+				break;
+			case 270:
+				info->rc_display.left =
+					disp_info->dec_pic_height -
+					disp_info->rc_decoded.bottom;
+				info->rc_display.right =
+					disp_info->dec_pic_height -
+					disp_info->rc_decoded.top;
+				info->rc_display.top =
+					disp_info->rc_decoded.left;
+				info->rc_display.bottom =
+					disp_info->rc_decoded.right;
+				break;
+			case 180:
+				info->rc_display.left =
+					disp_info->rc_decoded.left;
+				info->rc_display.right =
+					disp_info->rc_decoded.right;
+				info->rc_display.top =
+					disp_info->dec_pic_height -
+					disp_info->rc_decoded.bottom;
+				info->rc_display.bottom =
+					disp_info->dec_pic_height -
+					disp_info->rc_decoded.top;
+				break;
+			default:
+				info->rc_display.left =
+					disp_info->rc_decoded.left;
+				info->rc_display.right =
+					disp_info->rc_decoded.right;
+				info->rc_display.top =
+					disp_info->rc_decoded.top;
+				info->rc_display.bottom =
+					disp_info->rc_decoded.bottom;
+				break;
+			}
+
+		} else {
+			info->rc_display.left = disp_info->rc_decoded.left;
+			info->rc_display.right =
+				disp_info->rc_decoded.right;
+			info->rc_display.top = disp_info->rc_decoded.top;
+			info->rc_display.bottom =
+				disp_info->rc_decoded.bottom;
+		}
+
+		if (p_dec_info->mirror_enable) {
+			u32 temp;
+			u32 width = (p_dec_info->rotation_angle == 90 ||
+					p_dec_info->rotation_angle == 270) ? info->dec_pic_height :
+				info->dec_pic_width;
+			u32 height = (p_dec_info->rotation_angle == 90 ||
+					p_dec_info->rotation_angle == 270) ? info->dec_pic_width :
+				info->dec_pic_height;
+
+			if (p_dec_info->mirror_direction & MIRDIR_VER) {
+				temp = info->rc_display.top;
+				info->rc_display.top = height - info->rc_display.bottom;
+				info->rc_display.bottom = height - temp;
+			}
+			if (p_dec_info->mirror_direction & MIRDIR_HOR) {
+				temp = info->rc_display.left;
+				info->rc_display.left = width - info->rc_display.right;
+				info->rc_display.right = width - temp;
+			}
+		}
+
+		switch (inst->std) {
+		case W_HEVC_DEC:
+			info->display_poc = disp_info->decoded_poc;
+			break;
+		case W_AVS2_DEC:
+			info->avs2_info.display_poi =
+				disp_info->avs2_info.decoded_poi;
+			break;
+		case W_AVC_DEC:
+			info->display_poc = disp_info->decoded_poc;
+			break;
+		default:
+			break;
+		}
+
+		if (info->index_frame_display == info->index_frame_decoded) {
+			info->disp_pic_width = info->dec_pic_width;
+			info->disp_pic_height = info->dec_pic_height;
+		} else {
+			/*
+			 * when index_frame_decoded < 0, and index_frame_display >= 0
+			 * info->dec_pic_width and info->dec_pic_height are still valid
+			 * but those of p_dec_info->dec_out_info[disp_idx] are invalid in VP9
+			 */
+			info->disp_pic_width = disp_info->dec_pic_width;
+			info->disp_pic_height = disp_info->dec_pic_height;
+		}
+
+	} else {
+		info->rc_display.left = 0;
+		info->rc_display.right = 0;
+		info->rc_display.top = 0;
+		info->rc_display.bottom = 0;
+
+		if (p_dec_info->rotation_enable || p_dec_info->mirror_enable ||
+		    p_dec_info->dering_enable) {
+			info->disp_pic_width = info->dec_pic_width;
+			info->disp_pic_height = info->dec_pic_height;
+		} else {
+			info->disp_pic_width = 0;
+			info->disp_pic_height = 0;
+		}
+	}
+
+	p_dec_info->stream_rd_ptr = wave5_vpu_dec_get_rd_ptr(inst);
+	p_dec_info->frame_display_flag = vpu_read_reg(vpu_dev, W5_RET_DEC_DISP_IDC);
+	if (inst->std == W_VP9_DEC)
+		p_dec_info->frame_display_flag &= 0xFFFF;
+	p_dec_info->frame_end_pos = p_dec_info->stream_rd_ptr;
+
+	if (p_dec_info->frame_end_pos < p_dec_info->frame_start_pos)
+		info->consumed_byte = p_dec_info->frame_end_pos + p_dec_info->stream_buf_size -
+			p_dec_info->frame_start_pos;
+	else
+		info->consumed_byte = p_dec_info->frame_end_pos - p_dec_info->frame_start_pos;
+
+	if (p_dec_info->dering_enable || p_dec_info->mirror_enable || p_dec_info->rotation_enable) {
+		info->disp_frame = p_dec_info->rotator_output;
+		info->disp_frame.stride = p_dec_info->rotator_stride;
+	} else {
+		val = p_dec_info->num_fbs_for_decoding; //fb_offset
+
+		max_dec_index = (p_dec_info->num_fbs_for_decoding > p_dec_info->num_fbs_for_wtl) ?
+			p_dec_info->num_fbs_for_decoding : p_dec_info->num_fbs_for_wtl;
+
+		if (info->index_frame_display >= 0 &&
+		    info->index_frame_display < (int)max_dec_index)
+			info->disp_frame = inst->frame_buf[val + info->index_frame_display];
+	}
+
+	info->rd_ptr = p_dec_info->stream_rd_ptr;
+	info->wr_ptr = p_dec_info->stream_wr_ptr;
+	info->frame_display_flag = p_dec_info->frame_display_flag;
+
+	info->sequence_no = p_dec_info->initial_info.sequence_no;
+	if (decoded_index < WAVE5_MAX_FBS)
+		p_dec_info->dec_out_info[decoded_index] = *info;
+
+	if (disp_idx < WAVE5_MAX_FBS) {
+		info->num_of_tot_m_bs_in_disp = disp_info->num_of_tot_m_bs;
+		info->num_of_err_m_bs_in_disp = disp_info->num_of_err_m_bs;
+		info->disp_frame.sequence_no = info->sequence_no;
+	} else {
+		info->num_of_tot_m_bs_in_disp = 0;
+		info->num_of_err_m_bs_in_disp = 0;
+	}
+
+	if (info->sequence_changed &&
+	    ((info->sequence_changed & SEQ_CHANGE_INTER_RES_CHANGE) != SEQ_CHANGE_INTER_RES_CHANGE))
+		p_dec_info->initial_info.sequence_no++;
+
+err_out:
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_dec_clr_disp_flag(struct vpu_instance *inst, int index)
+{
+	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
+	int ret = 0;
+	s32 end_index;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	end_index = p_dec_info->num_fbs_for_wtl;
+
+	if (index < 0 || index >= end_index)
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+	ret = wave5_dec_clr_disp_flag(inst, index);
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_dec_give_command(struct vpu_instance *inst, enum codec_command cmd, void *param)
+{
+	struct dec_info *p_dec_info = &inst->codec_info->dec_info;
+	struct queue_status_info *queue_info = param;
+
+	switch (cmd) {
+	case DEC_GET_QUEUE_STATUS:
+		queue_info->instance_queue_count = p_dec_info->instance_queue_count;
+		queue_info->report_queue_count = p_dec_info->report_queue_count;
+		break;
+
+	case ENABLE_DEC_THUMBNAIL_MODE:
+		p_dec_info->thumbnail_mode = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int wave5_vpu_enc_open(struct vpu_instance *vpu_inst, struct enc_open_param *pop)
+{
+	struct enc_info *p_enc_info;
+	int ret;
+	struct vpu_device *vpu_dev = vpu_inst->dev;
+
+	ret = wave5_vpu_enc_check_open_param(vpu_inst, pop);
+	if (ret)
+		return ret;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	if (!wave5_vpu_is_init(vpu_dev))
+		return -ENODEV;
+
+	vpu_inst->codec_info = kzalloc(sizeof(*vpu_inst->codec_info), GFP_KERNEL);
+	if (!vpu_inst->codec_info)
+		return -ENOMEM;
+
+	vpu_inst->id = ida_alloc_max(&vpu_inst->dev->inst_ida, MAX_NUM_INSTANCE - 1, GFP_KERNEL);
+	if (vpu_inst->id < 0) {
+		dev_warn(vpu_inst->dev->dev, "unable to allocate instance ID: %d\n", vpu_inst->id);
+		ret = vpu_inst->id;
+		goto free_codec_info;
+	}
+	p_enc_info = &vpu_inst->codec_info->enc_info;
+	p_enc_info->open_param = *pop;
+
+	ret = wave5_vpu_build_up_enc_param(vpu_dev->dev, vpu_inst, pop);
+	if (ret)
+		goto free_ida;
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return 0;
+
+free_ida:
+	ida_free(&vpu_inst->dev->inst_ida, vpu_inst->id);
+free_codec_info:
+	kfree(vpu_inst->codec_info);
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_enc_close(struct vpu_instance *inst, u32 *fail_res)
+{
+	struct enc_info *p_enc_info;
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+	*fail_res = 0;
+
+	if (!inst->codec_info)
+		return -EINVAL;
+	p_enc_info = &inst->codec_info->enc_info;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	ret = wave5_vpu_enc_fini_seq(inst, fail_res);
+	if (ret) {
+		dev_warn(inst->dev->dev, "enc seq end timed out\n");
+
+		if (*fail_res == WAVE5_SYSERR_VPU_STILL_RUNNING) {
+			mutex_unlock(&vpu_dev->hw_lock);
+			return ret;
+		}
+	}
+
+	dev_dbg(inst->dev->dev, "enc seq end timed out\n");
+
+	if (p_enc_info->vb_work.size)
+		wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_work);
+
+	if (inst->std == W_HEVC_ENC || inst->std == W_AVC_ENC) {
+		if (p_enc_info->vb_sub_sam_buf.size)
+			wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_sub_sam_buf);
+
+		if (p_enc_info->vb_mv.size)
+			wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_mv);
+
+		if (p_enc_info->vb_fbc_y_tbl.size)
+			wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_fbc_y_tbl);
+
+		if (p_enc_info->vb_fbc_c_tbl.size)
+			wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_fbc_c_tbl);
+	}
+
+	if (p_enc_info->vb_task.size)
+		wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_task);
+
+	ida_free(&inst->dev->inst_ida, inst->id);
+
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	kfree(inst->codec_info);
+
+	return 0;
+}
+
+int wave5_vpu_enc_register_frame_buffer(struct vpu_instance *inst, int num, unsigned int stride,
+					int height, enum tiled_map_type map_type)
+{
+	struct enc_info *p_enc_info = &inst->codec_info->enc_info;
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+	u32 size_luma, size_chroma;
+	int i;
+
+	if (p_enc_info->stride)
+		return -EINVAL;
+
+	if (!p_enc_info->initial_info_obtained)
+		return -EINVAL;
+
+	if (num < p_enc_info->initial_info.min_frame_buffer_count)
+		return -EINVAL;
+
+	if (stride == 0 || stride % 8 != 0)
+		return -EINVAL;
+
+	if (height <= 0)
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	p_enc_info->num_frame_buffers = num;
+	p_enc_info->stride = stride;
+
+	size_luma = stride * height;
+	size_chroma = ALIGN(stride / 2, 16) * height;
+
+	for (i = 0; i < num; i++) {
+		if (!inst->frame_buf[i].update_fb_info)
+			continue;
+
+		inst->frame_buf[i].update_fb_info = false;
+		inst->frame_buf[i].stride = stride;
+		inst->frame_buf[i].height = height;
+		inst->frame_buf[i].map_type = COMPRESSED_FRAME_MAP;
+		inst->frame_buf[i].cbcr_interleave = true;
+		inst->frame_buf[i].endian = VDI_128BIT_LITTLE_ENDIAN;
+		inst->frame_buf[i].buf_y_size = size_luma;
+		inst->frame_buf[i].buf_cb = inst->frame_buf[i].buf_y + size_luma;
+		inst->frame_buf[i].buf_cb_size = size_chroma;
+		inst->frame_buf[i].buf_cr_size = 0;
+	}
+
+	ret = wave5_vpu_enc_register_framebuffer(inst->dev->dev, inst, &inst->frame_buf[0],
+						 COMPRESSED_FRAME_MAP,
+						 p_enc_info->num_frame_buffers);
+
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+static int wave5_check_enc_param(struct vpu_instance *inst, struct enc_param *param)
+{
+	struct enc_info *p_enc_info = &inst->codec_info->enc_info;
+
+	if (!param)
+		return -EINVAL;
+
+	if (!param->skip_picture && !param->source_frame)
+		return -EINVAL;
+
+	if (p_enc_info->open_param.bit_rate == 0 && inst->std == W_HEVC_ENC) {
+		if (param->force_pic_qp_enable == 1) {
+			if (param->force_pic_qp_i < 0 || param->force_pic_qp_i > 63)
+				return -EINVAL;
+
+			if (param->force_pic_qp_p < 0 || param->force_pic_qp_p > 63)
+				return -EINVAL;
+
+			if (param->force_pic_qp_b < 0 || param->force_pic_qp_b > 63)
+				return -EINVAL;
+		}
+		if (!p_enc_info->ring_buffer_enable &&
+		    (param->pic_stream_buffer_addr % 16 || param->pic_stream_buffer_size == 0))
+			return -EINVAL;
+	}
+	if (!p_enc_info->ring_buffer_enable &&
+	    (param->pic_stream_buffer_addr % 8 || param->pic_stream_buffer_size == 0))
+		return -EINVAL;
+
+	return 0;
+}
+
+static uint64_t wave5_get_timestamp(struct vpu_instance *vpu_inst)
+{
+	struct enc_info *p_enc_info;
+	u64 pts;
+	u32 fps;
+
+	if (!vpu_inst->codec_info)
+		return 0;
+
+	p_enc_info = &vpu_inst->codec_info->enc_info;
+	fps = p_enc_info->open_param.frame_rate_info;
+	if (fps == 0)
+		fps = 30;
+
+	pts = p_enc_info->cur_pts;
+	p_enc_info->cur_pts += 90000 / fps; /* 90_k_hz/fps */
+
+	return pts;
+}
+
+int wave5_vpu_enc_start_one_frame(struct vpu_instance *inst, struct enc_param *param, u32 *fail_res)
+{
+	struct enc_info *p_enc_info = &inst->codec_info->enc_info;
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	*fail_res = 0;
+
+	if (p_enc_info->stride == 0) // this means frame buffers have not been registered.
+		return -EINVAL;
+
+	ret = wave5_check_enc_param(inst, param);
+	if (ret)
+		return ret;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	p_enc_info->pts_map[param->src_idx] = p_enc_info->open_param.enable_pts ?
+					      wave5_get_timestamp(inst) : param->pts;
+
+	ret = wave5_vpu_encode(inst, param, fail_res);
+
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_enc_get_output_info(struct vpu_instance *inst, struct enc_output_info *info)
+{
+	struct enc_info *p_enc_info = &inst->codec_info->enc_info;
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	ret = wave5_vpu_enc_get_result(inst, info);
+	if (ret) {
+		info->pts = 0;
+		goto unlock;
+	}
+
+	if (info->recon_frame_index >= 0)
+		info->pts = p_enc_info->pts_map[info->enc_src_idx];
+
+unlock:
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_enc_give_command(struct vpu_instance *inst, enum codec_command cmd, void *param)
+{
+	struct enc_info *p_enc_info = &inst->codec_info->enc_info;
+
+	switch (cmd) {
+	case ENABLE_ROTATION:
+		p_enc_info->rotation_enable = true;
+		break;
+	case ENABLE_MIRRORING:
+		p_enc_info->mirror_enable = true;
+		break;
+	case SET_MIRROR_DIRECTION: {
+		enum mirror_direction mir_dir;
+
+		mir_dir = *(enum mirror_direction *)param;
+		if (mir_dir != MIRDIR_NONE && mir_dir != MIRDIR_HOR &&
+		    mir_dir != MIRDIR_VER && mir_dir != MIRDIR_HOR_VER)
+			return -EINVAL;
+		p_enc_info->mirror_direction = mir_dir;
+		break;
+	}
+	case SET_ROTATION_ANGLE: {
+		int angle;
+
+		angle = *(int *)param;
+		if (angle && angle != 90 && angle != 180 && angle != 270)
+			return -EINVAL;
+		if (p_enc_info->initial_info_obtained && (angle == 90 || angle == 270))
+			return -EINVAL;
+		p_enc_info->rotation_angle = angle;
+		break;
+	}
+	case ENC_GET_QUEUE_STATUS: {
+		struct queue_status_info *queue_info = param;
+
+		queue_info->instance_queue_count = p_enc_info->instance_queue_count;
+		queue_info->report_queue_count = p_enc_info->report_queue_count;
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int wave5_vpu_enc_issue_seq_init(struct vpu_instance *inst)
+{
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	ret = wave5_vpu_enc_init_seq(inst);
+
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return ret;
+}
+
+int wave5_vpu_enc_complete_seq_init(struct vpu_instance *inst, struct enc_initial_info *info)
+{
+	struct enc_info *p_enc_info = &inst->codec_info->enc_info;
+	int ret;
+	struct vpu_device *vpu_dev = inst->dev;
+
+	if (!info)
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&vpu_dev->hw_lock);
+	if (ret)
+		return ret;
+
+	ret = wave5_vpu_enc_get_seq_info(inst, info);
+	if (ret) {
+		p_enc_info->initial_info_obtained = false;
+		mutex_unlock(&vpu_dev->hw_lock);
+		return ret;
+	}
+
+	p_enc_info->initial_info_obtained = true;
+	p_enc_info->initial_info = *info;
+
+	mutex_unlock(&vpu_dev->hw_lock);
+
+	return 0;
+}
+
diff --git a/drivers/staging/media/wave5/wave5-vpuapi.h b/drivers/staging/media/wave5/wave5-vpuapi.h
new file mode 100644
index 000000000000..c0dc16b6741b
--- /dev/null
+++ b/drivers/staging/media/wave5/wave5-vpuapi.h
@@ -0,0 +1,1142 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Wave5 series multi-standard codec IP - helper definitions
+ *
+ * Copyright (C) 2021 CHIPS&MEDIA INC
+ */
+
+#ifndef VPUAPI_H_INCLUDED
+#define VPUAPI_H_INCLUDED
+
+#include <linux/kfifo.h>
+#include <linux/idr.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-mem2mem.h>
+#include <media/v4l2-ctrls.h>
+#include "wave5-vpuerror.h"
+#include "wave5-vpuconfig.h"
+#include "wave5-vdi.h"
+
+enum product_id {
+	PRODUCT_ID_521,
+	PRODUCT_ID_511,
+	PRODUCT_ID_517,
+	PRODUCT_ID_NONE,
+};
+
+struct vpu_attr;
+
+enum vpu_instance_type {
+	VPU_INST_TYPE_DEC = 0,
+	VPU_INST_TYPE_ENC = 1
+};
+
+enum vpu_instance_state {
+	VPU_INST_STATE_NONE = 0,
+	VPU_INST_STATE_OPEN = 1,
+	VPU_INST_STATE_INIT_SEQ = 2,
+	VPU_INST_STATE_PIC_RUN = 3,
+	VPU_INST_STATE_STOP = 4,
+	VPU_INST_STATE_WAIT_BUF = 5
+};
+
+#define WAVE5_MAX_FBS 32
+
+#define MAX_REG_FRAME (WAVE5_MAX_FBS * 2)
+
+#define WAVE5_DEC_HEVC_BUF_SIZE(_w, _h) (DIV_ROUND_UP(_w, 64) * DIV_ROUND_UP(_h, 64) * 256 + 64)
+#define WAVE5_DEC_AVC_BUF_SIZE(_w, _h) ((((ALIGN(_w, 256) / 16) * (ALIGN(_h, 16) / 16)) + 16) * 80)
+#define WAVE5_DEC_VP9_BUF_SIZE(_w, _h) (((ALIGN(_w, 64) * ALIGN(_h, 64)) >> 2))
+#define WAVE5_DEC_AVS2_BUF_SIZE(_w, _h) (((ALIGN(_w, 64) * ALIGN(_h, 64)) >> 5))
+// AV1 BUF SIZE : MFMV + segment ID + CDF probs table + film grain param Y+ film graim param C
+#define WAVE5_DEC_AV1_BUF_SZ_1(_w, _h)	\
+	(((ALIGN(_w, 64) / 64) * (ALIGN(_h, 64) / 64) * 512) + 41984 + 8192 + 4864)
+#define WAVE5_DEC_AV1_BUF_SZ_2(_w1, _w2, _h)	\
+	(((ALIGN(_w1, 64) / 64) * 256 + (ALIGN(_w2, 256) / 64) * 128) * (ALIGN(_h, 64) / 64))
+
+#define WAVE5_FBC_LUMA_TABLE_SIZE(_w, _h) (ALIGN(_h, 64) * ALIGN(_w, 256) / 32)
+#define WAVE5_FBC_CHROMA_TABLE_SIZE(_w, _h) (ALIGN((_h), 64) * ALIGN((_w) / 2, 256) / 32)
+#define WAVE5_ENC_AVC_BUF_SIZE(_w, _h) (ALIGN(_w, 64) * ALIGN(_h, 64) / 32)
+#define WAVE5_ENC_HEVC_BUF_SIZE(_w, _h) (ALIGN(_w, 64) / 64 * ALIGN(_h, 64) / 64 * 128)
+
+/*
+ * common struct and definition
+ */
+enum cod_std {
+	STD_AVC = 0,
+	STD_VC1 = 1,
+	STD_MPEG2 = 2,
+	STD_MPEG4 = 3,
+	STD_H263 = 4,
+	STD_DIV3 = 5,
+	STD_RV = 6,
+	STD_AVS = 7,
+	STD_THO = 9,
+	STD_VP3 = 10,
+	STD_VP8 = 11,
+	STD_HEVC = 12,
+	STD_VP9 = 13,
+	STD_AVS2 = 14,
+	STD_AV1 = 16,
+	STD_MAX
+};
+
+enum wave_std {
+	W_HEVC_DEC = 0x00,
+	W_HEVC_ENC = 0x01,
+	W_AVC_DEC = 0x02,
+	W_AVC_ENC = 0x03,
+	W_VP9_DEC = 0x16,
+	W_AVS2_DEC = 0x18,
+	W_AV1_DEC = 0x1A,
+	STD_UNKNOWN = 0xFF
+};
+
+enum SET_PARAM_OPTION {
+	OPT_COMMON = 0, /* SET_PARAM command option for encoding sequence */
+	OPT_CUSTOM_GOP = 1, /* SET_PARAM command option for setting custom GOP */
+	OPT_CUSTOM_HEADER = 2, /* SET_PARAM command option for setting custom VPS/SPS/PPS */
+	OPT_VUI = 3, /* SET_PARAM command option for encoding VUI */
+	OPT_CHANGE_PARAM = 0x10,
+};
+
+enum DEC_PIC_HDR_OPTION {
+	INIT_SEQ_NORMAL = 0x01,
+	INIT_SEQ_W_THUMBNAIL = 0x11,
+};
+
+enum DEC_PIC_OPTION {
+	DEC_PIC_NORMAL = 0x00, /* it is normal mode of DEC_PIC command. */
+	DEC_PIC_W_THUMBNAIL = 0x10, /* thumbnail mode (skip non-IRAP without reference reg.) */
+	SKIP_NON_IRAP = 0x11, /* it skips to decode non-IRAP pictures. */
+	SKIP_NON_REF_PIC = 0x13
+};
+
+/************************************************************************/
+/* PROFILE & LEVEL */
+/************************************************************************/
+/* HEVC */
+#define HEVC_PROFILE_MAIN 1
+#define HEVC_PROFILE_MAIN10 2
+#define HEVC_PROFILE_STILLPICTURE 3
+#define HEVC_PROFILE_MAIN10_STILLPICTURE 2
+
+/* H.264 profile for encoder*/
+#define H264_PROFILE_BP 1
+#define H264_PROFILE_MP 2
+#define H264_PROFILE_EXTENDED 3
+#define H264_PROFILE_HP 4
+#define H264_PROFILE_HIGH10 5
+#define H264_PROFILE_HIGH422 6
+#define H264_PROFILE_HIGH444 7
+
+/************************************************************************/
+/* error codes */
+/************************************************************************/
+
+/************************************************************************/
+/* utility macros */
+/************************************************************************/
+
+/************************************************************************/
+/* */
+/************************************************************************/
+/**
+ * \brief parameters of DEC_SET_SEQ_CHANGE_MASK
+ */
+#define SEQ_CHANGE_ENABLE_PROFILE BIT(5)
+#define SEQ_CHANGE_CHROMA_FORMAT_IDC BIT(15) /* AV1 */
+#define SEQ_CHANGE_ENABLE_SIZE BIT(16)
+#define SEQ_CHANGE_INTER_RES_CHANGE BIT(17) /* VP9 */
+#define SEQ_CHANGE_ENABLE_BITDEPTH BIT(18)
+#define SEQ_CHANGE_ENABLE_DPB_COUNT BIT(19)
+
+#define SEQ_CHANGE_ENABLE_ALL_VP9 (SEQ_CHANGE_ENABLE_PROFILE | \
+		SEQ_CHANGE_ENABLE_SIZE | \
+		SEQ_CHANGE_INTER_RES_CHANGE | \
+		SEQ_CHANGE_ENABLE_BITDEPTH | \
+		SEQ_CHANGE_ENABLE_DPB_COUNT)
+
+#define SEQ_CHANGE_ENABLE_ALL_HEVC (SEQ_CHANGE_ENABLE_PROFILE | \
+		SEQ_CHANGE_ENABLE_SIZE | \
+		SEQ_CHANGE_ENABLE_BITDEPTH | \
+		SEQ_CHANGE_ENABLE_DPB_COUNT)
+
+#define SEQ_CHANGE_ENABLE_ALL_AVS2 (SEQ_CHANGE_ENABLE_PROFILE | \
+		SEQ_CHANGE_ENABLE_SIZE | \
+		SEQ_CHANGE_ENABLE_BITDEPTH | \
+		SEQ_CHANGE_ENABLE_DPB_COUNT)
+
+#define SEQ_CHANGE_ENABLE_ALL_AVC (SEQ_CHANGE_ENABLE_SIZE | \
+		SEQ_CHANGE_ENABLE_BITDEPTH | \
+		SEQ_CHANGE_ENABLE_DPB_COUNT)
+
+#define SEQ_CHANGE_ENABLE_ALL_AV1 (SEQ_CHANGE_ENABLE_PROFILE | \
+		SEQ_CHANGE_CHROMA_FORMAT_IDC | \
+		SEQ_CHANGE_ENABLE_SIZE | \
+		SEQ_CHANGE_ENABLE_BITDEPTH | \
+		SEQ_CHANGE_ENABLE_DPB_COUNT)
+
+#define DISPLAY_IDX_FLAG_SEQ_END -1
+#define DISPLAY_IDX_FLAG_NO_FB -3
+#define DECODED_IDX_FLAG_NO_FB -1
+#define DECODED_IDX_FLAG_SKIP -2
+
+#define RECON_IDX_FLAG_ENC_END -1
+#define RECON_IDX_FLAG_ENC_DELAY -2
+#define RECON_IDX_FLAG_HEADER_ONLY -3
+#define RECON_IDX_FLAG_CHANGE_PARAM -4
+
+enum codec_command {
+	ENABLE_ROTATION,
+	ENABLE_MIRRORING,
+	SET_MIRROR_DIRECTION,
+	SET_ROTATION_ANGLE,
+	ENABLE_DEC_THUMBNAIL_MODE,
+	DEC_GET_QUEUE_STATUS,
+	ENC_GET_QUEUE_STATUS,
+};
+
+enum error_conceal_mode {
+	ERROR_CONCEAL_MODE_OFF = 0, /* conceal off */
+	ERROR_CONCEAL_MODE_INTRA_ONLY = 1, /* intra conceal in intra-picture, inter-picture */
+	ERROR_CONCEAL_MODE_INTRA_INTER = 2
+};
+
+enum error_conceal_unit {
+	ERROR_CONCEAL_UNIT_PICTURE = 0, /* picture-level error conceal */
+	ERROR_CONCEAL_UNIT_SLICE_TILE = 1, /* slice/tile-level error conceal */
+	ERROR_CONCEAL_UNIT_BLOCK_ROW = 2, /* block-row-level error conceal */
+	ERROR_CONCEAL_UNIT_BLOCK = 3 /* block-level conceal */
+};
+
+enum cb_cr_order {
+	CBCR_ORDER_NORMAL,
+	CBCR_ORDER_REVERSED
+};
+
+enum mirror_direction {
+	MIRDIR_NONE, /* no mirroring */
+	MIRDIR_VER, /* vertical mirroring */
+	MIRDIR_HOR, /* horizontal mirroring */
+	MIRDIR_HOR_VER /* horizontal and vertical mirroring */
+};
+
+enum frame_buffer_format {
+	FORMAT_ERR = -1,
+	FORMAT_420 = 0, /* 8bit */
+	FORMAT_422, /* 8bit */
+	FORMAT_224, /* 8bit */
+	FORMAT_444, /* 8bit */
+	FORMAT_400, /* 8bit */
+
+	/* little endian perspective */
+	/* | addr 0 | addr 1 | */
+	FORMAT_420_P10_16BIT_MSB = 5, /* lsb |000000xx|xxxxxxxx | msb */
+	FORMAT_420_P10_16BIT_LSB, /* lsb |xxxxxxx |xx000000 | msb */
+	FORMAT_420_P10_32BIT_MSB, /* lsb |00xxxxxxxxxxxxxxxxxxxxxxxxxxx| msb */
+	FORMAT_420_P10_32BIT_LSB, /* lsb |xxxxxxxxxxxxxxxxxxxxxxxxxxx00| msb */
+
+	/* 4:2:2 packed format */
+	/* little endian perspective */
+	/* | addr 0 | addr 1 | */
+	FORMAT_422_P10_16BIT_MSB, /* lsb |000000xx |xxxxxxxx | msb */
+	FORMAT_422_P10_16BIT_LSB, /* lsb |xxxxxxxx |xx000000 | msb */
+	FORMAT_422_P10_32BIT_MSB, /* lsb |00xxxxxxxxxxxxxxxxxxxxxxxxxxx| msb */
+	FORMAT_422_P10_32BIT_LSB, /* lsb |xxxxxxxxxxxxxxxxxxxxxxxxxxx00| msb */
+
+	FORMAT_YUYV, /* 8bit packed format : Y0U0Y1V0 Y2U1Y3V1 ... */
+	FORMAT_YUYV_P10_16BIT_MSB,
+	FORMAT_YUYV_P10_16BIT_LSB,
+	FORMAT_YUYV_P10_32BIT_MSB,
+	FORMAT_YUYV_P10_32BIT_LSB,
+
+	FORMAT_YVYU, /* 8bit packed format : Y0V0Y1U0 Y2V1Y3U1 ... */
+	FORMAT_YVYU_P10_16BIT_MSB,
+	FORMAT_YVYU_P10_16BIT_LSB,
+	FORMAT_YVYU_P10_32BIT_MSB,
+	FORMAT_YVYU_P10_32BIT_LSB,
+
+	FORMAT_UYVY, /* 8bit packed format : U0Y0V0Y1 U1Y2V1Y3 ... */
+	FORMAT_UYVY_P10_16BIT_MSB,
+	FORMAT_UYVY_P10_16BIT_LSB,
+	FORMAT_UYVY_P10_32BIT_MSB,
+	FORMAT_UYVY_P10_32BIT_LSB,
+
+	FORMAT_VYUY, /* 8bit packed format : V0Y0U0Y1 V1Y2U1Y3 ... */
+	FORMAT_VYUY_P10_16BIT_MSB,
+	FORMAT_VYUY_P10_16BIT_LSB,
+	FORMAT_VYUY_P10_32BIT_MSB,
+	FORMAT_VYUY_P10_32BIT_LSB,
+
+	FORMAT_MAX,
+};
+
+enum packed_format_num {
+	NOT_PACKED = 0,
+	PACKED_YUYV,
+	PACKED_YVYU,
+	PACKED_UYVY,
+	PACKED_VYUY,
+};
+
+enum wave5_interrupt_bit {
+	INT_WAVE5_INIT_VPU = 0,
+	INT_WAVE5_WAKEUP_VPU = 1,
+	INT_WAVE5_SLEEP_VPU = 2,
+	INT_WAVE5_CREATE_INSTANCE = 3,
+	INT_WAVE5_FLUSH_INSTANCE = 4,
+	INT_WAVE5_DESTROY_INSTANCE = 5,
+	INT_WAVE5_INIT_SEQ = 6,
+	INT_WAVE5_SET_FRAMEBUF = 7,
+	INT_WAVE5_DEC_PIC = 8,
+	INT_WAVE5_ENC_PIC = 8,
+	INT_WAVE5_ENC_SET_PARAM = 9,
+	INT_WAVE5_DEC_QUERY = 14,
+	INT_WAVE5_BSBUF_EMPTY = 15,
+	INT_WAVE5_BSBUF_FULL = 15,
+};
+
+enum pic_type {
+	PIC_TYPE_I = 0, /* I picture */
+	PIC_TYPE_KEY = 0, /* KEY frame for AV1*/
+	PIC_TYPE_P = 1, /* P picture */
+	PIC_TYPE_INTER = 1, /* inter frame for AV1*/
+	PIC_TYPE_B = 2, /* B picture (except VC1) */
+	PIC_TYPE_REPEAT = 2, /* repeat frame (VP9 only) */
+	PIC_TYPE_AV1_INTRA = 2, /* intra only frame (AV1 only) */
+	PIC_TYPE_VC1_BI = 2, /* VC1 BI picture (VC1 only) */
+	PIC_TYPE_VC1_B = 3, /* VC1 B picture (VC1 only) */
+	PIC_TYPE_D = 3,
+	PIC_TYPE_S = 3,
+	PIC_TYPE_AVS2_F = 3, /* F picture in AVS2 */
+	PIC_TYPE_AV1_SWITCH = 3, /* switch frame (AV1 only) */
+	PIC_TYPE_VC1_P_SKIP = 4, /* VC1 P skip picture (VC1 only) */
+	PIC_TYPE_MP4_P_SKIP_NOT_CODED = 4, /* not coded P picture in MPEG4 packed mode */
+	PIC_TYPE_AVS2_S = 4, /* S picture in AVS2 */
+	PIC_TYPE_IDR = 5, /* H.264/H.265 IDR picture */
+	PIC_TYPE_AVS2_G = 5, /* G picture in AVS2 */
+	PIC_TYPE_AVS2_GB = 6, /* GB picture in AVS2 */
+	PIC_TYPE_MAX /* no meaning */
+};
+
+enum bit_stream_mode {
+	BS_MODE_INTERRUPT,
+	BS_MODE_RESERVED, /* reserved for the future */
+	BS_MODE_PIC_END,
+};
+
+enum sw_reset_mode {
+	SW_RESET_SAFETY,
+	SW_RESET_FORCE,
+	SW_RESET_ON_BOOT
+};
+
+enum tiled_map_type {
+	LINEAR_FRAME_MAP = 0, /* linear frame map type */
+	COMPRESSED_FRAME_MAP = 17, /* compressed frame map type*/
+};
+
+enum temporal_id_mode {
+	TEMPORAL_ID_MODE_ABSOLUTE,
+	TEMPORAL_ID_MODE_RELATIVE,
+};
+
+struct vpu_attr {
+	u32 product_id; /* the product ID */
+	char product_name[8]; /* the product name in ascii code */
+	u32 product_version; /* the product version number */
+	u32 fw_version; /* the F/W version */
+	u32 customer_id; /* customer ID number */
+	u32 support_decoders; /* bitmask: see <<vpuapi_h_cod_std>> */
+	u32 support_encoders; /* bitmask: see <<vpuapi_h_cod_std>> */
+	bool support_bitstream_mode;
+	bool support_backbone;
+	bool support_avc10bit_enc;
+	bool support_hevc10bit_enc;
+	u32 support_endian_mask; /* A variable of supported endian mode in product */
+	bool support_dual_core; /* this indicates whether a product has two vcores. */
+	bool support_vcore_backbone;
+	bool support_vcpu_backbone;
+};
+
+struct frame_buffer {
+	dma_addr_t buf_y;
+	dma_addr_t buf_cb;
+	dma_addr_t buf_cr;
+	u32 buf_y_size;
+	u32 buf_cb_size;
+	u32 buf_cr_size;
+	int cbcr_interleave;
+	int endian;
+	enum tiled_map_type map_type;
+	int stride; /* A horizontal stride for given frame buffer */
+	int width; /* A width for given frame buffer */
+	int height; /* A height for given frame buffer */
+	int size; /* A size for given frame buffer */
+	int sequence_no;
+	bool update_fb_info;
+};
+
+struct vpu_rect {
+	u32 left; /* A horizontal pixel offset of top-left corner of rectangle from (0, 0) */
+	u32 top; /* A vertical pixel offset of top-left corner of rectangle from (0, 0) */
+	u32 right; /* A horizontal pixel offset of bottom-right corner of rectangle from (0, 0) */
+	u32 bottom; /* A vertical pixel offset of bottom-right corner of rectangle from (0, 0) */
+};
+
+/*
+ * decode struct and definition
+ */
+
+struct dec_open_param {
+	dma_addr_t bitstream_buffer;
+	int bitstream_buffer_size;
+	int cbcr_interleave;
+	int nv21;
+	int cbcr_order;
+	enum endian_mode frame_endian;
+	enum endian_mode stream_endian;
+	enum bit_stream_mode bitstream_mode;
+	bool enable_non_ref_fbc_write;
+	int av1_format;
+	enum error_conceal_unit error_conceal_unit;
+	enum error_conceal_mode error_conceal_mode;
+};
+
+struct dec_initial_info {
+	s32 pic_width;
+	s32 pic_height;
+	s32 f_rate_numerator; /* the numerator part of frame rate fraction */
+	s32 f_rate_denominator; /* the denominator part of frame rate fraction */
+	struct vpu_rect pic_crop_rect;
+	u32 min_frame_buffer_count; /* between 1 to 16 */
+	s32 frame_buf_delay;
+
+	s32 max_temporal_layers; /* it indicates the max number of temporal sub-layers. */
+	s32 max_spatial_layers;
+	s32 profile;
+	s32 level;
+	s32 tier;
+	s32 is_ext_sar;
+	s32 aspect_rate_info;
+	s32 bit_rate;
+	u32 user_data_header;
+	s32 user_data_size;
+	bool user_data_buf_full;
+	s32 chroma_format_idc;/* A chroma format indicator */
+	s32 luma_bitdepth; /* A bit-depth of luma sample */
+	s32 chroma_bitdepth; /* A bit-depth of chroma sample */
+	u32 seq_init_err_reason;
+	s32 warn_info;
+	dma_addr_t rd_ptr; /* A read pointer of bitstream buffer */
+	dma_addr_t wr_ptr; /* A write pointer of bitstream buffer */
+	u32 sequence_no;
+	u32 output_bit_depth;
+	u32 vlc_buf_size; /* the size of vlc buffer */
+	u32 param_buf_size; /* the size of param buffer */
+};
+
+#define WAVE_SKIPMODE_WAVE_NONE 0
+#define WAVE_SKIPMODE_NON_IRAP 1
+#define WAVE_SKIPMODE_NON_REF 2
+
+struct dec_param {
+	s32 skipframe_mode;
+	bool cra_as_bla_flag;
+	bool disable_film_grain;
+};
+
+struct dec_output_ext_data {
+	u32 user_data_header;
+	u32 user_data_size; /* this is the size of user data. */
+	bool user_data_buf_full;
+	u32 active_format;
+};
+
+struct h265_rp_sei {
+	unsigned int exist;
+	int recovery_poc_cnt; /* recovery_poc_cnt */
+	int exact_match_flag; /* exact_match_flag */
+	int broken_link_flag; /* broken_link_flag */
+};
+
+struct avs2_info {
+	int decoded_poi;
+	int display_poi;
+};
+
+struct av1_info {
+	int allow_screen_content_tools; /* it indicates whether screen content tool is enabled. */
+	int allow_intra_bc; /* it indicates whether intra block copy is enabled. */
+	int spatial_id; /* it indicates a spatial ID of the picture. */
+};
+
+struct dec_output_info {
+	/**
+	 * this is a frame buffer index for the picture to be displayed at the moment among
+	 * frame buffers which are registered using vpu_dec_register_frame_buffer(). frame
+	 * data to be displayed are stored into the frame buffer with this index.
+	 * when there is no display delay, this index is always
+	 * the same with index_frame_decoded. however, if display delay does exist for display
+	 * reordering in AVC
+	 * or B-frames in VC1), this index might be different with index_frame_decoded.
+	 * by checking this index, HOST application can easily know whether sequence decoding
+	 * has been finished or not.
+	 *
+	 * -3(0xFFFD) or -2(0xFFFE) : it is when a display output cannot be given due to picture
+	 * reordering or skip option.
+	 * -1(0xFFFF) : it is when there is no more output for display at the end of sequence
+	 * decoding.
+	 */
+	int index_frame_display;
+	int index_frame_display_for_tiled; /* in case of WTL mode, this index indicates a display
+					    * index of tiled or compressed framebuffer.
+					    */
+	/**
+	 * this is a frame buffer index of decoded picture among frame buffers which were
+	 * registered using vpu_dec_register_frame_buffer(). the currently decoded frame is stored
+	 * into the frame buffer specified by
+	 * this index.
+	 *
+	 * -2 : it indicates that no decoded output is generated because decoder meets EOS
+	 * (end of sequence) or skip.
+	 * -1 : it indicates that decoder fails to decode a picture because there is no available
+	 * frame buffer.
+	 */
+	int index_frame_decoded;
+	int index_inter_frame_decoded;
+	int index_frame_decoded_for_tiled;
+	int nal_type;
+	int pic_type;
+	int num_of_err_m_bs;
+	int num_of_tot_m_bs;
+	int num_of_err_m_bs_in_disp;
+	int num_of_tot_m_bs_in_disp;
+	u32 decoding_success;
+	struct vpu_rect rc_display;
+	int disp_pic_width;
+	int disp_pic_height;
+	struct vpu_rect rc_decoded;
+	int dec_pic_width;
+	int dec_pic_height;
+	struct avs2_info avs2_info;
+	struct av1_info av1_info;
+	int decoded_poc;
+	int display_poc;
+	int temporal_id; /* A temporal ID of the picture */
+	struct h265_rp_sei h265_rp_sei;
+	struct dec_output_ext_data dec_output_ext_data;
+	int consumed_byte; /* the number of bytes that are consumed by VPU. */
+	int rd_ptr; /* A stream buffer read pointer for the current decoder instance */
+	int wr_ptr; /* A stream buffer write pointer for the current decoder instance */
+	dma_addr_t byte_pos_frame_start;
+	dma_addr_t byte_pos_frame_end;
+	struct frame_buffer disp_frame;
+	int frame_display_flag; /* it reports a frame buffer flag to be displayed. */
+	/**
+	 * this variable reports that sequence has been changed while H.264/AVC stream decoding.
+	 * if it is 1, HOST application can get the new sequence information by calling
+	 * vpu_dec_get_initial_info() or wave5_vpu_dec_issue_seq_init().
+	 *
+	 * for H.265/HEVC decoder, each bit has a different meaning as follows.
+	 *
+	 * sequence_changed[5] : it indicates that the profile_idc has been changed.
+	 * sequence_changed[16] : it indicates that the resolution has been changed.
+	 * sequence_changed[19] : it indicates that the required number of frame buffer has
+	 * been changed.
+	 */
+	int sequence_changed;
+	int frame_cycle; /* this variable reports the number of cycles for processing a frame. */
+	int error_reason;
+	u32 error_reason_ext;
+	int warn_info;
+	u32 sequence_no;
+
+	u32 dec_host_cmd_tick; /* tick of DEC_PIC command for the picture */
+	u32 dec_seek_start_tick; /* start tick of seeking slices of the picture */
+	u32 dec_seek_end_tick; /* end tick of seeking slices of the picture */
+	u32 dec_parse_start_tick; /* start tick of parsing slices of the picture */
+	u32 dec_parse_end_tick; /* end tick of parsing slices of the picture */
+	u32 dec_decode_start_tick; /* start tick of decoding slices of the picture */
+	u32 dec_decode_end_tick; /* end tick of decoding slices of the picture */
+
+	u32 seek_cycle;
+	u32 parse_cycle;
+	u32 decoded_cycle;
+
+	s32 ctu_size;
+	s32 output_flag;
+};
+
+struct queue_status_info {
+	u32 instance_queue_count;
+	u32 report_queue_count;
+};
+
+/*
+ * encode struct and definition
+ */
+
+#define MAX_NUM_TEMPORAL_LAYER 7
+#define MAX_NUM_SPATIAL_LAYER 3
+#define MAX_GOP_NUM 8
+
+struct custom_gop_pic_param {
+	int pic_type; /* A picture type of nth picture in the custom GOP */
+	int poc_offset; /* A POC of nth picture in the custom GOP */
+	int pic_qp; /* A quantization parameter of nth picture in the custom GOP */
+	int use_multi_ref_p; /* use multiref pic for P picture. valid only if PIC_TYPE is P */
+	int ref_poc_l0; /* A POC of reference L0 of nth picture in the custom GOP */
+	int ref_poc_l1; /* A POC of reference L1 of nth picture in the custom GOP */
+	int temporal_id; /* A temporal ID of nth picture in the custom GOP */
+};
+
+struct custom_gop_param {
+	int custom_gop_size; /* the size of custom GOP (0~8) */
+	struct custom_gop_pic_param pic_param[MAX_GOP_NUM];
+};
+
+struct wave_custom_map_opt {
+	int roi_avg_qp; /* it sets an average QP of ROI map. */
+	int custom_roi_map_enable; /* it enables ROI map. */
+	int custom_lambda_map_enable; /* it enables custom lambda map. */
+	int custom_mode_map_enable;
+	int custom_coef_drop_enable;
+	dma_addr_t addr_custom_map;
+};
+
+struct enc_wave_param {
+	/*
+	 * A profile indicator (HEVC only)
+	 *
+	 * 0 : the firmware determines a profile according to internalbitdepth.
+	 * 1 : main profile
+	 * 2 : main10 profile
+	 * 3 : main still picture profile
+	 * in AVC encoder, a profile cannot be set by host application. the firmware decides it
+	 * based on internalbitdepth. it is HIGH profile for bitdepth of 8 and HIGH10 profile for
+	 * bitdepth of 10.
+	 */
+	int profile;
+	int en_still_picture; /* still picture profile */
+	int level; /* A level indicator (level * 10) */
+	int tier; /* 0=main, 1=high */
+	int internal_bit_depth;
+	int gop_preset_idx;
+	int decoding_refresh_type; /* 0=non-IRAP, 1=CRA, 2=IDR */
+	int intra_qp; /* A quantization parameter of intra picture */
+	int intra_period; /* A period of intra picture in GOP size */
+	int forced_idr_header_enable;
+	int conf_win_top; /* A top offset of conformance window */
+	int conf_win_bot; /* A bottom offset of conformance window */
+	int conf_win_left; /* A left offset of conformance window */
+	int conf_win_right; /* A right offset of conformance window */
+	int independ_slice_mode_arg;
+	int depend_slice_mode_arg;
+	int intra_refresh_mode;
+	/*
+	 * it specifies an intra CTU refresh interval. depending on intra_refresh_mode,
+	 * it can mean one of the following.
+	 *
+	 * the number of consecutive CTU rows for intra_ctu_refresh_mode of 1
+	 * the number of consecutive CTU columns for intra_ctu_refresh_mode of 2
+	 * A step size in CTU for intra_ctu_refresh_mode of 3
+	 * the number of intra ct_us to be encoded in a picture for intra_ctu_refresh_mode of 4
+	 */
+	int intra_refresh_arg;
+	/*
+	 * 0 : custom setting
+	 * 1 : recommended encoder parameters (slow encoding speed, highest picture quality)
+	 * 2 : boost mode (normal encoding speed, moderate picture quality)
+	 * 3 : fast mode (fast encoding speed, low picture quality)
+	 */
+	uint32_t depend_slice_mode : 2;
+	uint32_t independ_slice_mode : 1; /* 0=no-multi-slice, 1=slice-in-ctu-number*/
+	uint32_t use_recommend_enc_param: 2;
+	uint32_t max_num_merge: 2;
+	uint32_t scaling_list_enable: 2;
+	uint32_t bit_alloc_mode: 2; /* 0=ref-pic-priority, 1=uniform, 2=fixed_bit_ratio */
+	int beta_offset_div2: 4; /* it sets beta_offset_div2 for deblocking filter. */
+	int tc_offset_div2: 4; /* it sets tc_offset_div3 for deblocking filter. */
+	int hvs_qp_scale: 4; /* QP scaling factor for CU QP adjust if hvs_qp_scale_enable is 1 */
+	int hvs_max_delta_qp; /* A maximum delta QP for HVS */
+	/*
+	 * A fixed bit ratio (1 ~ 255) for each picture of GOP's bit
+	 * allocation
+	 *
+	 * N = 0 ~ (MAX_GOP_SIZE - 1)
+	 * MAX_GOP_SIZE = 8
+	 *
+	 * for instance when MAX_GOP_SIZE is 3, fixed_bit_ratio0, fixed_bit_ratio1, and
+	 * fixed_bit_ratio2 can be set as 2, 1, and 1 respectively for
+	 * the fixed bit ratio 2:1:1. this is only valid when bit_alloc_mode is 2.
+	 */
+	u8 fixed_bit_ratio[MAX_GOP_NUM];
+	struct custom_gop_param gop_param; /* <<vpuapi_h_custom_gop_param>> */
+	u32 num_units_in_tick;
+	u32 time_scale;
+	u32 num_ticks_poc_diff_one;
+	int chroma_cb_qp_offset; /* the value of chroma(cb) QP offset */
+	int chroma_cr_qp_offset; /* the value of chroma(cr) QP offset */
+	int initial_rc_qp;
+	u32 nr_intra_weight_y;
+	u32 nr_intra_weight_cb; /* A weight to cb noise level for intra picture (0 ~ 31) */
+	u32 nr_intra_weight_cr; /* A weight to cr noise level for intra picture (0 ~ 31) */
+	u32 nr_inter_weight_y;
+	u32 nr_inter_weight_cb; /* A weight to cb noise level for inter picture (0 ~ 31) */
+	u32 nr_inter_weight_cr; /* A weight to cr noise level for inter picture (0 ~ 31) */
+	u32 nr_noise_sigma_y; /* Y noise standard deviation if nr_noise_est_enable is 0. */
+	u32 nr_noise_sigma_cb;/* cb noise standard deviation if nr_noise_est_enable is 0. */
+	u32 nr_noise_sigma_cr;/* cr noise standard deviation if nr_noise_est_enable is 0. */
+	u32 bg_thr_diff;
+	u32 bg_thr_mean_diff;
+	u32 bg_lambda_qp;
+	int bg_delta_qp;
+	int pu04_delta_rate: 8; /* added to the total cost of 4x4 blocks */
+	int pu08_delta_rate: 8; /* added to the total cost of 8x8 blocks */
+	int pu16_delta_rate: 8; /* added to the total cost of 16x16 blocks */
+	int pu32_delta_rate: 8; /* added to the total cost of 32x32 blocks */
+	int pu04_intra_planar_delta_rate: 8;
+	int pu04_intra_dc_delta_rate: 8;
+	int pu04_intra_angle_delta_rate: 8;
+	int pu08_intra_planar_delta_rate: 8;
+	int pu08_intra_dc_delta_rate: 8;
+	int pu08_intra_angle_delta_rate: 8;
+	int pu16_intra_planar_delta_rate: 8;
+	int pu16_intra_dc_delta_rate: 8;
+	int pu16_intra_angle_delta_rate: 8;
+	int pu32_intra_planar_delta_rate: 8;
+	int pu32_intra_dc_delta_rate: 8;
+	int pu32_intra_angle_delta_rate: 8;
+	int cu08_intra_delta_rate: 8;
+	int cu08_inter_delta_rate: 8;
+	int cu08_merge_delta_rate: 8;
+	int cu16_intra_delta_rate: 8;
+	int cu16_inter_delta_rate: 8;
+	int cu16_merge_delta_rate: 8;
+	int cu32_intra_delta_rate: 8;
+	int cu32_inter_delta_rate: 8;
+	int cu32_merge_delta_rate: 8;
+	int coef_clear_disable: 8;
+	int min_qp_i; /* A minimum QP of I picture for rate control */
+	int max_qp_i; /* A maximum QP of I picture for rate control */
+	int min_qp_p; /* A minimum QP of P picture for rate control */
+	int max_qp_p; /* A maximum QP of P picture for rate control */
+	int min_qp_b; /* A minimum QP of B picture for rate control */
+	int max_qp_b; /* A maximum QP of B picture for rate control */
+	dma_addr_t custom_lambda_addr; /* it specifies the address of custom lambda map. */
+	dma_addr_t user_scaling_list_addr; /* it specifies the address of user scaling list file. */
+	int avc_idr_period;/* A period of IDR picture (0 ~ 1024). 0 - implies an infinite period */
+	int avc_slice_mode; /* 0=none, 1=slice-in-mb-number */
+	int avc_slice_arg;	/* the number of MB for a slice when avc_slice_mode is set with 1 */
+	int intra_mb_refresh_mode; /* 0=none, 1=row, 2=column, 3=step-size-in-mb */
+	/**
+	 * it specifies an intra MB refresh interval. depending on intra_mb_refresh_mode,
+	 * it can mean one of the following.
+	 *
+	 * the number of consecutive MB rows for intra_mb_refresh_mode of 1
+	 * the number of consecutive MB columns for intra_mb_refresh_mode of 2
+	 * A step size in MB for intra_mb_refresh_mode of 3
+	 */
+	int intra_mb_refresh_arg;
+	int entropy_coding_mode; /* 0=CAVLC, 1=CABAC */
+	u32 rc_weight_param;
+	u32 rc_weight_buf;
+
+	/* flags */
+	uint32_t lossless_enable: 1; /*enables lossless coding. */
+	uint32_t const_intra_pred_flag: 1; /*enables constrained intra prediction. */
+	uint32_t tmvp_enable: 1; /*enables temporal motion vector prediction. */
+	uint32_t wpp_enable: 1;
+	uint32_t disable_deblk: 1; /* it disables in-loop deblocking filtering. */
+	uint32_t lf_cross_slice_boundary_enable: 1;
+	uint32_t skip_intra_trans: 1;
+	uint32_t sao_enable: 1; /* it enables SAO (sample adaptive offset). */
+	uint32_t intra_nx_n_enable: 1; /* it enables intra nx_n p_us. */
+	uint32_t cu_level_rc_enable: 1; /* it enable CU level rate control. */
+	uint32_t hvs_qp_enable: 1; /* enable CU QP adjustment for subjective quality enhancement. */
+	uint32_t roi_enable: 1; /* it enables ROI map. NOTE: it is valid when rate control is on. */
+	uint32_t nr_y_enable: 1; /* it enables noise reduction algorithm to Y component. */
+	uint32_t nr_noise_est_enable: 1;
+	uint32_t nr_cb_enable: 1; /* it enables noise reduction algorithm to cb component. */
+	uint32_t nr_cr_enable: 1; /* it enables noise reduction algorithm to cr component. */
+	uint32_t use_long_term: 1; /* it enables long-term reference function. */
+	uint32_t monochrome_enable: 1; /* it enables monochrom encoding mode. */
+	uint32_t strong_intra_smooth_enable: 1; /* it enables strong intra smoothing. */
+	uint32_t weight_pred_enable: 1; /* it enables to use weighted prediction.*/
+	uint32_t bg_detect_enable: 1; /* it enables background detection. */
+	uint32_t custom_lambda_enable: 1; /* it enables custom lambda table. */
+	uint32_t custom_md_enable: 1; /* it enables custom mode decision. */
+	uint32_t rdo_skip: 1;	/* it skips RDO(rate distortion optimization). */
+	uint32_t lambda_scaling_enable: 1;	/* it enables lambda scaling using custom GOP. */
+	uint32_t transform8x8_enable: 1; /* it enables 8x8 intra prediction and 8x8 transform. */
+	uint32_t mb_level_rc_enable: 1;			/* it enables MB-level rate control. */
+	uint32_t s2fme_disable: 1; /* it disables s2me_fme (only for AVC encoder). */
+};
+
+struct enc_sub_frame_sync_config {
+	u32 sub_frame_sync_mode; /* 0=wire-based, 1=register-based */
+	u32 sub_frame_sync_on;
+};
+
+struct enc_open_param {
+	dma_addr_t bitstream_buffer;
+	u32 bitstream_buffer_size;
+	int ring_buffer_enable;
+	int pic_width; /* the width of a picture to be encoded in unit of sample. */
+	int pic_height; /* the height of a picture to be encoded in unit of sample. */
+	int frame_rate_info;/* desired fps */
+	int vbv_buffer_size;
+	int bit_rate; /* target bitrate in bps */
+	u32 rc_enable : 1; /* rate control */
+	struct enc_wave_param wave_param;
+	int cbcr_interleave;
+	int cbcr_order;
+	int stream_endian;
+	int source_endian;
+	int line_buf_int_en;
+	int packed_format; /* <<vpuapi_h_packed_format_num>> */
+	enum frame_buffer_format src_format;
+	enum frame_buffer_format output_format;
+	int nv21;
+	bool enable_pts; /* an enable flag to report PTS(presentation timestamp) */
+	bool enable_non_ref_fbc_write;
+	int sub_frame_sync_enable;
+	int sub_frame_sync_mode;
+	u32 enc_hrd_rbsp_in_vps; /* it encodes the HRD syntax rbsp into VPS. */
+	u32 hrd_rbsp_data_size; /* the bit size of the HRD rbsp data */
+	dma_addr_t hrd_rbsp_data_addr; /* the address of the HRD rbsp data */
+	u32 encode_vui_rbsp;
+	u32 vui_rbsp_data_size; /* the bit size of the VUI rbsp data */
+	dma_addr_t vui_rbsp_data_addr; /* the address of the VUI rbsp data */
+};
+
+struct enc_initial_info {
+	unsigned int min_frame_buffer_count; /* minimum number of frame buffer */
+	int min_src_frame_count; /* minimum number of source buffer */
+	int max_latency_pictures; /* maximum number of picture latency */
+	int seq_init_err_reason; /* error information */
+	int warn_info; /* warn information */
+	u32 vlc_buf_size; /* the size of task buffer */
+	u32 param_buf_size; /* the size of task buffer */
+};
+
+struct enc_code_opt {
+	int implicit_header_encode;
+	int encode_vcl; /* A flag to encode VCL nal unit explicitly */
+	int encode_vps; /* A flag to encode VPS nal unit explicitly */
+	int encode_sps; /* A flag to encode SPS nal unit explicitly */
+	int encode_pps; /* A flag to encode PPS nal unit explicitly */
+	int encode_aud; /* A flag to encode AUD nal unit explicitly */
+	int encode_eos;
+	int encode_eob;
+	int encode_vui; /* A flag to encode VUI nal unit explicitly */
+};
+
+struct enc_param {
+	struct frame_buffer *source_frame;
+	unsigned int skip_picture : 1;
+	dma_addr_t pic_stream_buffer_addr;
+	int pic_stream_buffer_size;
+	int force_pic_qp_enable; /* flag used to force picture quantization parameter */
+	int force_pic_qp_i;
+	int force_pic_qp_p;
+	int force_pic_qp_b;
+	int force_pic_type_enable; /* A flag to use a force picture type */
+	int force_pic_type;
+	int src_idx; /* A source frame buffer index */
+	int src_end_flag;
+	struct enc_code_opt code_option;
+	u32 use_cur_src_as_longterm_pic;
+	u32 use_longterm_ref;
+	u64 pts; /* the presentation timestamp (PTS) of input source */
+	struct wave_custom_map_opt custom_map_opt;
+	u32 wp_pix_sigma_y; /* pixel variance of Y component for weighted prediction */
+	u32 wp_pix_sigma_cb; /* pixel variance of cb component for weighted prediction */
+	u32 wp_pix_sigma_cr; /* pixel variance of cr component for weighted prediction */
+	u32 wp_pix_mean_y; /* pixel mean value of Y component for weighted prediction */
+	u32 wp_pix_mean_cb; /* pixel mean value of cb component for weighted prediction */
+	u32 wp_pix_mean_cr; /* pixel mean value of cr component for weighted prediction */
+	u32 force_all_ctu_coef_drop_enable; /* it forces all coefficients to be zero after TQ . */
+};
+
+struct enc_output_info {
+	dma_addr_t bitstream_buffer;
+	u32 bitstream_size; /* the byte size of encoded bitstream */
+	int bitstream_wrap_around;
+	int pic_type; /* <<vpuapi_h_pic_type>> */
+	int num_of_slices; /* the number of slices of the currently being encoded picture */
+	int recon_frame_index;
+	struct frame_buffer recon_frame;
+	int rd_ptr;
+	int wr_ptr;
+	int pic_skipped; /* whether the current encoding has been skipped or not */
+	int num_of_intra; /* the number of intra coded block */
+	int num_of_merge; /* the number of merge block in 8x8 */
+	int num_of_skip_block; /* the number of skip block in 8x8 */
+	int avg_ctu_qp; /* the average value of CTU q_ps */
+	int enc_pic_byte; /* the number of encoded picture bytes */
+	int enc_gop_pic_idx; /* the GOP index of the currently encoded picture */
+	int enc_pic_poc; /* the POC(picture order count) of the currently encoded picture */
+	int release_src_flag; /* the source buffer indicator of the encoded pictures */
+	int enc_src_idx; /* the source buffer index of the currently encoded picture */
+	int enc_vcl_nut;
+	int enc_pic_cnt; /* the encoded picture number */
+	int error_reason; /* the error reason of the currently encoded picture */
+	int warn_info; /* the warning information of the currently encoded picture */
+	int frame_cycle; /* the param for reporting the cycle number of encoding one frame.*/
+	u64 pts;
+	u32 enc_host_cmd_tick; /* tick of ENC_PIC command for the picture */
+	u32 enc_prepare_start_tick; /* start tick of preparing slices of the picture */
+	u32 enc_prepare_end_tick; /* end tick of preparing slices of the picture */
+	u32 enc_processing_start_tick; /* start tick of processing slices of the picture */
+	u32 enc_processing_end_tick; /* end tick of processing slices of the picture */
+	u32 enc_encode_start_tick; /* start tick of encoding slices of the picture */
+	u32 enc_encode_end_tick; /* end tick of encoding slices of the picture */
+	u32 prepare_cycle; /* the number of cycles for preparing slices of a picture */
+	u32 processing; /* the number of cycles for processing slices of a picture */
+	u32 encoded_cycle; /* the number of cycles for encoding slices of a picture */
+	u32 pic_distortion_low;
+	u32 pic_distortion_high;
+};
+
+enum ENC_PIC_CODE_OPTION {
+	CODEOPT_ENC_HEADER_IMPLICIT = BIT(0),
+	CODEOPT_ENC_VCL = BIT(1), /* A flag to encode VCL nal unit explicitly */
+};
+
+enum GOP_PRESET_IDX {
+	PRESET_IDX_CUSTOM_GOP = 0, /* user defined GOP structure */
+	PRESET_IDX_ALL_I = 1, /* all intra, gopsize = 1 */
+	PRESET_IDX_IPP = 2, /* consecutive P, cyclic gopsize = 1 */
+	PRESET_IDX_IBBB = 3, /* consecutive B, cyclic gopsize = 1 */
+	PRESET_IDX_IBPBP = 4, /* gopsize = 2 */
+	PRESET_IDX_IBBBP = 5, /* gopsize = 4 */
+	PRESET_IDX_IPPPP = 6, /* consecutive P, cyclic gopsize = 4 */
+	PRESET_IDX_IBBBB = 7, /* consecutive B, cyclic gopsize = 4 */
+	PRESET_IDX_RA_IB = 8, /* random access, cyclic gopsize = 8 */
+	PRESET_IDX_IPP_SINGLE = 9, /* consecutive P, cyclic gopsize = 1, with single ref */
+};
+
+struct sec_axi_info {
+	struct {
+		int use_ip_enable;
+		int use_lf_row_enable;
+		int use_bit_enable;
+		int use_enc_rdo_enable;
+		int use_enc_lf_enable;
+	} wave;
+	int buf_size;
+	dma_addr_t buf_base;
+};
+
+struct dec_info {
+	struct dec_open_param open_param;
+	struct dec_initial_info initial_info;
+	struct dec_initial_info new_seq_info; /* temporal new sequence information */
+	dma_addr_t stream_wr_ptr;
+	dma_addr_t stream_rd_ptr;
+	int stream_endflag;
+	int frame_display_flag;
+	dma_addr_t stream_buf_start_addr;
+	dma_addr_t stream_buf_end_addr;
+	int stream_buf_size;
+	struct vpu_buf vb_mv[MAX_REG_FRAME];
+	struct vpu_buf vb_fbc_y_tbl[MAX_REG_FRAME];
+	struct vpu_buf vb_fbc_c_tbl[MAX_REG_FRAME];
+	int num_fbs_for_decoding;
+	int num_fbs_for_wtl;
+	int stride;
+	bool rotation_enable;
+	bool mirror_enable;
+	int dering_enable;
+	enum mirror_direction mirror_direction;
+	int rotation_angle;
+	struct frame_buffer rotator_output;
+	int rotator_stride;
+	bool initial_info_obtained;
+	struct sec_axi_info sec_axi_info;
+	int seq_init_escape;
+	dma_addr_t user_data_buf_addr;
+	u32 user_data_enable;
+	int user_data_buf_size;
+	int frame_start_pos;
+	int frame_end_pos;
+	struct vpu_buf vb_work;
+	struct vpu_buf vb_task;
+	struct dec_output_info dec_out_info[WAVE5_MAX_FBS];
+	int reorder_enable;
+	int thumbnail_mode;
+	int seq_change_mask;
+	enum temporal_id_mode temp_id_select_mode;
+	s32 target_temp_id;
+	s32 target_spatial_id;
+	s32 instance_queue_count;
+	s32 report_queue_count;
+	bool first_cycle_check;
+	u32 cycle_per_tick;
+	u32 product_code;
+	u32 vlc_buf_size;
+	u32 param_buf_size;
+};
+
+struct enc_info {
+	struct enc_open_param open_param;
+	struct enc_initial_info initial_info;
+	dma_addr_t stream_rd_ptr;
+	dma_addr_t stream_wr_ptr;
+	dma_addr_t stream_buf_start_addr;
+	dma_addr_t stream_buf_end_addr;
+	int stream_buf_size;
+	int num_frame_buffers;
+	int stride;
+	bool rotation_enable;
+	bool mirror_enable;
+	enum mirror_direction mirror_direction;
+	int rotation_angle;
+	bool initial_info_obtained;
+	int ring_buffer_enable;
+	struct sec_axi_info sec_axi_info;
+	struct enc_sub_frame_sync_config sub_frame_sync_config;
+	int line_buf_int_en;
+	struct vpu_buf vb_work;
+	struct vpu_buf vb_mv; /* col_mv buffer */
+	struct vpu_buf vb_fbc_y_tbl; /* FBC luma table buffer */
+	struct vpu_buf vb_fbc_c_tbl; /* FBC chroma table buffer */
+	struct vpu_buf vb_sub_sam_buf; /* sub-sampled buffer for ME */
+	struct vpu_buf vb_task;
+	u64 cur_pts; /* current timestamp in 90_k_hz */
+	u64 pts_map[32]; /* PTS mapped with source frame index */
+	u32 instance_queue_count;
+	u32 report_queue_count;
+	bool first_cycle_check;
+	u32 cycle_per_tick;
+	u32 product_code;
+	u32 vlc_buf_size;
+	u32 param_buf_size;
+};
+
+struct vpu_device {
+	struct device *dev;
+	struct v4l2_device v4l2_dev;
+	struct v4l2_m2m_dev *v4l2_m2m_dev;
+	struct video_device *video_dev_dec;
+	struct video_device *video_dev_enc;
+	struct mutex dev_lock; /* the lock for the src,dst v4l2 queues */
+	struct mutex	 hw_lock; /* lock hw configurations */
+	struct kfifo irq_status;
+	int irq;
+	struct completion irq_done;
+	enum product_id	 product;
+	struct vpu_attr	 attr;
+	struct vpu_buf common_mem;
+	u32 last_performance_cycles;
+	struct dma_vpu_buf sram_buf;
+	void __iomem *vdb_register;
+	int product_code;
+	struct ida inst_ida;
+	struct clk_bulk_data *clks;
+	int num_clks;
+};
+
+struct vpu_instance;
+
+struct vpu_instance_ops {
+	void (*start_process)(struct vpu_instance *inst);
+	void (*stop_process)(struct vpu_instance *inst);
+	void (*finish_process)(struct vpu_instance *inst);
+};
+
+struct vpu_instance {
+	struct v4l2_fh v4l2_fh;
+	struct v4l2_ctrl_handler v4l2_ctrl_hdl;
+	struct vpu_device *dev;
+
+	struct v4l2_pix_format_mplane src_fmt;
+	struct v4l2_pix_format_mplane dst_fmt;
+	enum v4l2_colorspace colorspace;
+	enum v4l2_xfer_func xfer_func;
+	enum v4l2_ycbcr_encoding ycbcr_enc;
+	enum v4l2_quantization quantization;
+	enum v4l2_hsv_encoding hsv_enc;
+
+	enum vpu_instance_state state;
+	enum vpu_instance_type type;
+	const struct vpu_instance_ops *ops;
+
+	enum wave_std		 std;
+	int			 id;
+	union {
+		struct enc_info enc_info;
+		struct dec_info dec_info;
+	} *codec_info;
+	struct frame_buffer frame_buf[MAX_REG_FRAME];
+	struct vpu_buf frame_vbuf[MAX_REG_FRAME];
+	u32 min_dst_frame_buf_count;
+	u32 queued_src_buf_num;
+	u32 queued_dst_buf_num;
+	u64 timestamp;
+
+	spinlock_t bitstream_lock; /* lock the src buf queue of the m2m ctx */
+	struct vpu_buf bitstream_vbuf;
+	bool thumbnail_mode;
+
+	unsigned int min_src_frame_buf_count;
+	unsigned int rot_angle;
+	unsigned int mirror_direction;
+	unsigned int profile;
+	unsigned int level;
+	unsigned int bit_depth;
+	unsigned int frame_rate;
+	unsigned int vbv_buf_size;
+	unsigned int min_qp_i;
+	unsigned int max_qp_i;
+	unsigned int min_qp_p;
+	unsigned int max_qp_p;
+	unsigned int min_qp_b;
+	unsigned int max_qp_b;
+};
+
+void wave5_vdi_write_register(struct vpu_device *vpu_device, unsigned int addr, unsigned int data);
+unsigned int wave5_vdi_read_register(struct vpu_device *vpu_dev, unsigned int addr);
+int wave5_vdi_clear_memory(struct vpu_device *vpu_dev, struct vpu_buf *vb);
+int wave5_vdi_allocate_dma_memory(struct vpu_device *vpu_dev, struct vpu_buf *vb);
+int wave5_vdi_write_memory(struct vpu_device *vpu_dev, struct vpu_buf *vb, size_t offset,
+			   u8 *data, int len, int endian);
+int wave5_vdi_convert_endian(struct vpu_device *vpu_dev, unsigned int endian);
+void wave5_vdi_free_dma_memory(struct vpu_device *vpu_dev, struct vpu_buf *vb);
+
+int wave5_vpu_init_with_bitcode(struct device *dev, u8 *bitcode, uint32_t size);
+void wave5_vpu_clear_interrupt_ex(struct vpu_instance *inst, int32_t intr_flag);
+int wave5_vpu_get_version_info(struct device *dev, uint32_t *version_info, uint32_t *revision,
+			       uint32_t *product_id);
+int wave5_vpu_dec_open(struct vpu_instance *vpu_inst, struct dec_open_param *pop);
+int wave5_vpu_dec_close(struct vpu_instance *inst, u32 *fail_res);
+int wave5_vpu_dec_issue_seq_init(struct vpu_instance *inst);
+int wave5_vpu_dec_complete_seq_init(struct vpu_instance *inst, struct dec_initial_info *info);
+int wave5_vpu_dec_register_frame_buffer_ex(struct vpu_instance *inst, int num_of_dec_fbs,
+					   int num_of_display_fbs, int stride, int height,
+					   int map_type);
+int wave5_vpu_dec_start_one_frame(struct vpu_instance *inst, struct dec_param *param,
+				  u32 *res_fail);
+int wave5_vpu_dec_get_output_info(struct vpu_instance *inst, struct dec_output_info *info);
+int wave5_vpu_dec_give_command(struct vpu_instance *inst, enum codec_command cmd, void *parameter);
+int wave5_vpu_dec_get_bitstream_buffer(struct vpu_instance *inst, dma_addr_t *prd_prt,
+				       dma_addr_t *pwr_ptr, uint32_t *size);
+int wave5_vpu_dec_update_bitstream_buffer(struct vpu_instance *inst, int size);
+int wave5_vpu_dec_clr_disp_flag(struct vpu_instance *inst, int index);
+
+int wave5_vpu_enc_open(struct vpu_instance *vpu_inst, struct enc_open_param *enc_op_param);
+int wave5_vpu_enc_close(struct vpu_instance *inst, u32 *fail_res);
+int wave5_vpu_enc_issue_seq_init(struct vpu_instance *inst);
+int wave5_vpu_enc_complete_seq_init(struct vpu_instance *inst, struct enc_initial_info *info);
+int wave5_vpu_enc_register_frame_buffer(struct vpu_instance *inst, int num, unsigned int stride,
+					int height, enum tiled_map_type map_type);
+int wave5_vpu_enc_start_one_frame(struct vpu_instance *inst, struct enc_param *param,
+				  u32 *fail_res);
+int wave5_vpu_enc_get_output_info(struct vpu_instance *inst, struct enc_output_info *info);
+int wave5_vpu_enc_give_command(struct vpu_instance *inst, enum codec_command cmd, void *parameter);
+
+#endif
+
diff --git a/drivers/staging/media/wave5/wave5-vpuconfig.h b/drivers/staging/media/wave5/wave5-vpuconfig.h
new file mode 100644
index 000000000000..4c71799e440e
--- /dev/null
+++ b/drivers/staging/media/wave5/wave5-vpuconfig.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Wave5 series multi-standard codec IP - product config definitions
+ *
+ * Copyright (C) 2021 CHIPS&MEDIA INC
+ */
+
+#ifndef _VPU_CONFIG_H_
+#define _VPU_CONFIG_H_
+
+#define WAVE517_CODE                    0x5170
+#define WAVE537_CODE                    0x5370
+#define WAVE511_CODE                    0x5110
+#define WAVE521_CODE                    0x5210
+#define WAVE521C_CODE                   0x521c
+#define WAVE521C_DUAL_CODE              0x521d  // wave521 dual core
+#define WAVE521E1_CODE                  0x5211
+
+#define PRODUCT_CODE_W_SERIES(x) ({					\
+		int c = x;						\
+		((c) == WAVE517_CODE ||	(c) == WAVE537_CODE ||		\
+		 (c) == WAVE511_CODE || (c) == WAVE521_CODE ||		\
+		 (c) == WAVE521E1_CODE || (c) == WAVE521C_CODE ||	\
+		 (c) == WAVE521C_DUAL_CODE);				\
+})
+
+#define WAVE517_WORKBUF_SIZE            (2 * 1024 * 1024)
+#define WAVE521ENC_WORKBUF_SIZE         (128 * 1024)      //HEVC 128K, AVC 40K
+#define WAVE521DEC_WORKBUF_SIZE         (1784 * 1024)
+
+#define MAX_NUM_INSTANCE                32
+
+#define W5_MIN_ENC_PIC_WIDTH            256
+#define W5_MIN_ENC_PIC_HEIGHT           128
+#define W5_MAX_ENC_PIC_WIDTH            8192
+#define W5_MAX_ENC_PIC_HEIGHT           8192
+
+//  application specific configuration
+#define VPU_ENC_TIMEOUT                 60000
+#define VPU_DEC_TIMEOUT                 60000
+#define VPU_BUSY_CHECK_TIMEOUT          10000
+
+#define HOST_ENDIAN                     VDI_128BIT_LITTLE_ENDIAN
+#define VPU_FRAME_ENDIAN                HOST_ENDIAN
+#define VPU_STREAM_ENDIAN               HOST_ENDIAN
+#define VPU_USER_DATA_ENDIAN            HOST_ENDIAN
+#define VPU_SOURCE_ENDIAN               HOST_ENDIAN
+
+// for WAVE encoder
+#define USE_SRC_PRP_AXI         0
+#define USE_SRC_PRI_AXI         1
+#define DEFAULT_SRC_AXI         USE_SRC_PRP_AXI
+
+/************************************************************************/
+/* VPU COMMON MEMORY                                                    */
+/************************************************************************/
+#define VLC_BUF_NUM                     (3)
+
+#define COMMAND_QUEUE_DEPTH             (4)
+
+#define W5_REMAP_INDEX0                 0
+#define W5_REMAP_INDEX1                 1
+#define W5_REMAP_MAX_SIZE               (1024 * 1024)
+
+#define WAVE5_MAX_CODE_BUF_SIZE         (2 * 1024 * 1024)
+#define WAVE5_TEMPBUF_OFFSET            WAVE5_MAX_CODE_BUF_SIZE
+#define WAVE5_TEMPBUF_SIZE              (1024 * 1024)
+
+#define SIZE_COMMON                 (WAVE5_MAX_CODE_BUF_SIZE + WAVE5_TEMPBUF_SIZE)
+
+//=====4. VPU REPORT MEMORY  ======================//
+
+#define WAVE5_UPPER_PROC_AXI_ID     0x0
+
+#define WAVE5_PROC_AXI_ID           0x0
+#define WAVE5_PRP_AXI_ID            0x0
+#define WAVE5_FBD_Y_AXI_ID          0x0
+#define WAVE5_FBC_Y_AXI_ID          0x0
+#define WAVE5_FBD_C_AXI_ID          0x0
+#define WAVE5_FBC_C_AXI_ID          0x0
+#define WAVE5_SEC_AXI_ID            0x0
+#define WAVE5_PRI_AXI_ID            0x0
+
+#endif  /* _VPU_CONFIG_H_ */
+
diff --git a/drivers/staging/media/wave5/wave5-vpuerror.h b/drivers/staging/media/wave5/wave5-vpuerror.h
new file mode 100644
index 000000000000..0ece5bc517bd
--- /dev/null
+++ b/drivers/staging/media/wave5/wave5-vpuerror.h
@@ -0,0 +1,455 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Wave5 series multi-standard codec IP - error values
+ *
+ * Copyright (C) 2021 CHIPS&MEDIA INC
+ */
+
+#ifndef ERROR_CODE_H_INCLUDED
+#define ERROR_CODE_H_INCLUDED
+
+/*
+ * WAVE5
+ */
+
+/************************************************************************/
+/* WAVE5 COMMON SYSTEM ERROR (FAIL_REASON)                              */
+/************************************************************************/
+#define WAVE5_SYSERR_QUEUEING_FAIL                                     0x00000001
+#define WAVE5_SYSERR_ACCESS_VIOLATION_HW                               0x00000040
+#define WAVE5_SYSERR_BUS_ERROR                                         0x00000200
+#define WAVE5_SYSERR_DOUBLE_FAULT                                      0x00000400
+#define WAVE5_SYSERR_RESULT_NOT_READY                                  0x00000800
+#define WAVE5_SYSERR_VPU_STILL_RUNNING                                 0x00001000
+#define WAVE5_SYSERR_UNKNOWN_CMD                                       0x00002000
+#define WAVE5_SYSERR_UNKNOWN_CODEC_STD                                 0x00004000
+#define WAVE5_SYSERR_UNKNOWN_QUERY_OPTION                              0x00008000
+#define WAVE5_SYSERR_VLC_BUF_FULL                                      0x00010000
+#define WAVE5_SYSERR_WATCHDOG_TIMEOUT                                  0x00020000
+#define WAVE5_SYSERR_VCPU_TIMEOUT                                      0x00080000
+#define WAVE5_SYSERR_TEMP_SEC_BUF_OVERFLOW                             0x00200000
+#define WAVE5_SYSERR_NEED_MORE_TASK_BUF                                0x00400000
+#define WAVE5_SYSERR_PRESCAN_ERR                                       0x00800000
+#define WAVE5_SYSERR_ENC_GBIN_OVERCONSUME                              0x01000000
+#define WAVE5_SYSERR_ENC_MAX_ZERO_DETECT                               0x02000000
+#define WAVE5_SYSERR_ENC_LVL_FIRST_ERROR                               0x04000000
+#define WAVE5_SYSERR_ENC_EG_RANGE_OVER                                 0x08000000
+#define WAVE5_SYSERR_ENC_IRB_FRAME_DROP                                0x10000000
+#define WAVE5_SYSERR_INPLACE_V                                         0x20000000
+#define WAVE5_SYSERR_FATAL_VPU_HANGUP                                  0xf0000000
+
+/************************************************************************/
+/* WAVE5 COMMAND QUEUE ERROR (FAIL_REASON)                              */
+/************************************************************************/
+#define WAVE5_CMDQ_ERR_NOT_QUEABLE_CMD                                 0x00000001
+#define WAVE5_CMDQ_ERR_SKIP_MODE_ENABLE                                0x00000002
+#define WAVE5_CMDQ_ERR_INST_FLUSHING                                   0x00000003
+#define WAVE5_CMDQ_ERR_INST_INACTIVE                                   0x00000004
+#define WAVE5_CMDQ_ERR_QUEUE_FAIL                                      0x00000005
+#define WAVE5_CMDQ_ERR_CMD_BUF_FULL                                    0x00000006
+
+/************************************************************************/
+/* WAVE5 ERROR ON DECODER (ERR_INFO)                                    */
+/************************************************************************/
+// HEVC
+#define HEVC_SPSERR_SEQ_PARAMETER_SET_ID                               0x00001000
+#define HEVC_SPSERR_CHROMA_FORMAT_IDC                                  0x00001001
+#define HEVC_SPSERR_PIC_WIDTH_IN_LUMA_SAMPLES                          0x00001002
+#define HEVC_SPSERR_PIC_HEIGHT_IN_LUMA_SAMPLES                         0x00001003
+#define HEVC_SPSERR_CONF_WIN_LEFT_OFFSET                               0x00001004
+#define HEVC_SPSERR_CONF_WIN_RIGHT_OFFSET                              0x00001005
+#define HEVC_SPSERR_CONF_WIN_TOP_OFFSET                                0x00001006
+#define HEVC_SPSERR_CONF_WIN_BOTTOM_OFFSET                             0x00001007
+#define HEVC_SPSERR_BIT_DEPTH_LUMA_MINUS8                              0x00001008
+#define HEVC_SPSERR_BIT_DEPTH_CHROMA_MINUS8                            0x00001009
+#define HEVC_SPSERR_LOG2_MAX_PIC_ORDER_CNT_LSB_MINUS4                  0x0000100A
+#define HEVC_SPSERR_SPS_MAX_DEC_PIC_BUFFERING                          0x0000100B
+#define HEVC_SPSERR_SPS_MAX_NUM_REORDER_PICS                           0x0000100C
+#define HEVC_SPSERR_SPS_MAX_LATENCY_INCREASE                           0x0000100D
+#define HEVC_SPSERR_LOG2_MIN_LUMA_CODING_BLOCK_SIZE_MINUS3             0x0000100E
+#define HEVC_SPSERR_LOG2_DIFF_MAX_MIN_LUMA_CODING_BLOCK_SIZE           0x0000100F
+#define HEVC_SPSERR_LOG2_MIN_TRANSFORM_BLOCK_SIZE_MINUS2               0x00001010
+#define HEVC_SPSERR_LOG2_DIFF_MAX_MIN_TRANSFORM_BLOCK_SIZE             0x00001011
+#define HEVC_SPSERR_MAX_TRANSFORM_HIERARCHY_DEPTH_INTER                0x00001012
+#define HEVC_SPSERR_MAX_TRANSFORM_HIERARCHY_DEPTH_INTRA                0x00001013
+#define HEVC_SPSERR_SCALING_LIST                                       0x00001014
+#define HEVC_SPSERR_LOG2_DIFF_MIN_PCM_LUMA_CODING_BLOCK_SIZE_MINUS3    0x00001015
+#define HEVC_SPSERR_LOG2_DIFF_MAX_MIN_PCM_LUMA_CODING_BLOCK_SIZE       0x00001016
+#define HEVC_SPSERR_NUM_SHORT_TERM_REF_PIC_SETS                        0x00001017
+#define HEVC_SPSERR_NUM_LONG_TERM_REF_PICS_SPS                         0x00001018
+#define HEVC_SPSERR_GBU_PARSING_ERROR                                  0x00001019
+#define HEVC_SPSERR_EXTENSION_FLAG                                     0x0000101A
+#define HEVC_SPSERR_VUI_ERROR                                          0x0000101B
+#define HEVC_SPSERR_ACTIVATE_SPS                                       0x0000101C
+#define HEVC_SPSERR_PROFILE_SPACE                                      0x0000101D
+#define HEVC_PPSERR_PPS_PIC_PARAMETER_SET_ID                           0x00002000
+#define HEVC_PPSERR_PPS_SEQ_PARAMETER_SET_ID                           0x00002001
+#define HEVC_PPSERR_NUM_REF_IDX_L0_DEFAULT_ACTIVE_MINUS1               0x00002002
+#define HEVC_PPSERR_NUM_REF_IDX_L1_DEFAULT_ACTIVE_MINUS1               0x00002003
+#define HEVC_PPSERR_INIT_QP_MINUS26                                    0x00002004
+#define HEVC_PPSERR_DIFF_CU_QP_DELTA_DEPTH                             0x00002005
+#define HEVC_PPSERR_PPS_CB_QP_OFFSET                                   0x00002006
+#define HEVC_PPSERR_PPS_CR_QP_OFFSET                                   0x00002007
+#define HEVC_PPSERR_NUM_TILE_COLUMNS_MINUS1                            0x00002008
+#define HEVC_PPSERR_NUM_TILE_ROWS_MINUS1                               0x00002009
+#define HEVC_PPSERR_COLUMN_WIDTH_MINUS1                                0x0000200A
+#define HEVC_PPSERR_ROW_HEIGHT_MINUS1                                  0x0000200B
+#define HEVC_PPSERR_PPS_BETA_OFFSET_DIV2                               0x0000200C
+#define HEVC_PPSERR_PPS_TC_OFFSET_DIV2                                 0x0000200D
+#define HEVC_PPSERR_SCALING_LIST                                       0x0000200E
+#define HEVC_PPSERR_LOG2_PARALLEL_MERGE_LEVEL_MINUS2                   0x0000200F
+#define HEVC_PPSERR_NUM_TILE_COLUMNS_RANGE_OUT                         0x00002010
+#define HEVC_PPSERR_NUM_TILE_ROWS_RANGE_OUT                            0x00002011
+#define HEVC_PPSERR_MORE_RBSP_DATA_ERROR                               0x00002012
+#define HEVC_PPSERR_PPS_PIC_PARAMETER_SET_ID_RANGE_OUT                 0x00002013
+#define HEVC_PPSERR_PPS_SEQ_PARAMETER_SET_ID_RANGE_OUT                 0x00002014
+#define HEVC_PPSERR_NUM_REF_IDX_L0_DEFAULT_ACTIVE_MINUS1_RANGE_OUT     0x00002015
+#define HEVC_PPSERR_NUM_REF_IDX_L1_DEFAULT_ACTIVE_MINUS1_RANGE_OUT     0x00002016
+#define HEVC_PPSERR_PPS_CB_QP_OFFSET_RANGE_OUT                         0x00002017
+#define HEVC_PPSERR_PPS_CR_QP_OFFSET_RANGE_OUT                         0x00002018
+#define HEVC_PPSERR_COLUMN_WIDTH_MINUS1_RANGE_OUT                      0x00002019
+#define HEVC_PPSERR_ROW_HEIGHT_MINUS1_RANGE_OUT                        0x00002020
+#define HEVC_PPSERR_PPS_BETA_OFFSET_DIV2_RANGE_OUT                     0x00002021
+#define HEVC_PPSERR_PPS_TC_OFFSET_DIV2_RANGE_OUT                       0x00002022
+#define HEVC_SHERR_SLICE_PIC_PARAMETER_SET_ID                          0x00003000
+#define HEVC_SHERR_ACTIVATE_PPS                                        0x00003001
+#define HEVC_SHERR_ACTIVATE_SPS                                        0x00003002
+#define HEVC_SHERR_SLICE_TYPE                                          0x00003003
+#define HEVC_SHERR_FIRST_SLICE_IS_DEPENDENT_SLICE                      0x00003004
+#define HEVC_SHERR_SHORT_TERM_REF_PIC_SET_SPS_FLAG                     0x00003005
+#define HEVC_SHERR_SHORT_TERM_REF_PIC_SET                              0x00003006
+#define HEVC_SHERR_SHORT_TERM_REF_PIC_SET_IDX                          0x00003007
+#define HEVC_SHERR_NUM_LONG_TERM_SPS                                   0x00003008
+#define HEVC_SHERR_NUM_LONG_TERM_PICS                                  0x00003009
+#define HEVC_SHERR_LT_IDX_SPS_IS_OUT_OF_RANGE                          0x0000300A
+#define HEVC_SHERR_DELTA_POC_MSB_CYCLE_LT                              0x0000300B
+#define HEVC_SHERR_NUM_REF_IDX_L0_ACTIVE_MINUS1                        0x0000300C
+#define HEVC_SHERR_NUM_REF_IDX_L1_ACTIVE_MINUS1                        0x0000300D
+#define HEVC_SHERR_COLLOCATED_REF_IDX                                  0x0000300E
+#define HEVC_SHERR_PRED_WEIGHT_TABLE                                   0x0000300F
+#define HEVC_SHERR_FIVE_MINUS_MAX_NUM_MERGE_CAND                       0x00003010
+#define HEVC_SHERR_SLICE_QP_DELTA                                      0x00003011
+#define HEVC_SHERR_SLICE_QP_DELTA_IS_OUT_OF_RANGE                      0x00003012
+#define HEVC_SHERR_SLICE_CB_QP_OFFSET                                  0x00003013
+#define HEVC_SHERR_SLICE_CR_QP_OFFSET                                  0x00003014
+#define HEVC_SHERR_SLICE_BETA_OFFSET_DIV2                              0x00003015
+#define HEVC_SHERR_SLICE_TC_OFFSET_DIV2                                0x00003016
+#define HEVC_SHERR_NUM_ENTRY_POINT_OFFSETS                             0x00003017
+#define HEVC_SHERR_OFFSET_LEN_MINUS1                                   0x00003018
+#define HEVC_SHERR_SLICE_SEGMENT_HEADER_EXTENSION_LENGTH               0x00003019
+#define HEVC_SHERR_WRONG_POC_IN_STILL_PICTURE_PROFILE                  0x0000301A
+#define HEVC_SHERR_SLICE_TYPE_ERROR_IN_STILL_PICTURE_PROFILE           0x0000301B
+#define HEVC_SHERR_PPS_ID_NOT_EQUAL_PREV_VALUE                         0x0000301C
+#define HEVC_SPECERR_OVER_PICTURE_WIDTH_SIZE                           0x00004000
+#define HEVC_SPECERR_OVER_PICTURE_HEIGHT_SIZE                          0x00004001
+#define HEVC_SPECERR_OVER_CHROMA_FORMAT                                0x00004002
+#define HEVC_SPECERR_OVER_BIT_DEPTH                                    0x00004003
+#define HEVC_SPECERR_OVER_BUFFER_OVER_FLOW                             0x00004004
+#define HEVC_SPECERR_OVER_WRONG_BUFFER_ACCESS                          0x00004005
+#define HEVC_ETCERR_INIT_SEQ_SPS_NOT_FOUND                             0x00005000
+#define HEVC_ETCERR_DEC_PIC_VCL_NOT_FOUND                              0x00005001
+#define HEVC_ETCERR_NO_VALID_SLICE_IN_AU                               0x00005002
+#define HEVC_ETCERR_INPLACE_V                                          0x0000500F
+
+// AVC
+#define AVC_SPSERR_SEQ_PARAMETER_SET_ID                                0x00001000
+#define AVC_SPSERR_CHROMA_FORMAT_IDC                                   0x00001001
+#define AVC_SPSERR_PIC_WIDTH_IN_LUMA_SAMPLES                           0x00001002
+#define AVC_SPSERR_PIC_HEIGHT_IN_LUMA_SAMPLES                          0x00001003
+#define AVC_SPSERR_CONF_WIN_LEFT_OFFSET                                0x00001004
+#define AVC_SPSERR_CONF_WIN_RIGHT_OFFSET                               0x00001005
+#define AVC_SPSERR_CONF_WIN_TOP_OFFSET                                 0x00001006
+#define AVC_SPSERR_CONF_WIN_BOTTOM_OFFSET                              0x00001007
+#define AVC_SPSERR_BIT_DEPTH_LUMA_MINUS8                               0x00001008
+#define AVC_SPSERR_BIT_DEPTH_CHROMA_MINUS8                             0x00001009
+#define AVC_SPSERR_SPS_MAX_DEC_PIC_BUFFERING                           0x0000100B
+#define AVC_SPSERR_SPS_MAX_NUM_REORDER_PICS                            0x0000100C
+#define AVC_SPSERR_SCALING_LIST                                        0x00001014
+#define AVC_SPSERR_GBU_PARSING_ERROR                                   0x00001019
+#define AVC_SPSERR_VUI_ERROR                                           0x0000101B
+#define AVC_SPSERR_ACTIVATE_SPS                                        0x0000101C
+#define AVC_PPSERR_PPS_PIC_PARAMETER_SET_ID                            0x00002000
+#define AVC_PPSERR_PPS_SEQ_PARAMETER_SET_ID                            0x00002001
+#define AVC_PPSERR_NUM_REF_IDX_L0_DEFAULT_ACTIVE_MINUS1                0x00002002
+#define AVC_PPSERR_NUM_REF_IDX_L1_DEFAULT_ACTIVE_MINUS1                0x00002003
+#define AVC_PPSERR_INIT_QP_MINUS26                                     0x00002004
+#define AVC_PPSERR_PPS_CB_QP_OFFSET                                    0x00002006
+#define AVC_PPSERR_PPS_CR_QP_OFFSET                                    0x00002007
+#define AVC_PPSERR_SCALING_LIST                                        0x0000200E
+#define AVC_PPSERR_MORE_RBSP_DATA_ERROR                                0x00002012
+#define AVC_PPSERR_PPS_PIC_PARAMETER_SET_ID_RANGE_OUT                  0x00002013
+#define AVC_PPSERR_PPS_SEQ_PARAMETER_SET_ID_RANGE_OUT                  0x00002014
+#define AVC_PPSERR_NUM_REF_IDX_L0_DEFAULT_ACTIVE_MINUS1_RANGE_OUT      0x00002015
+#define AVC_PPSERR_NUM_REF_IDX_L1_DEFAULT_ACTIVE_MINUS1_RANGE_OUT      0x00002016
+#define AVC_PPSERR_PPS_CB_QP_OFFSET_RANGE_OUT                          0x00002017
+#define AVC_PPSERR_PPS_CR_QP_OFFSET_RANGE_OUT                          0x00002018
+#define AVC_SHERR_SLICE_PIC_PARAMETER_SET_ID                           0x00003000
+#define AVC_SHERR_ACTIVATE_PPS                                         0x00003001
+#define AVC_SHERR_ACTIVATE_SPS                                         0x00003002
+#define AVC_SHERR_SLICE_TYPE                                           0x00003003
+#define AVC_SHERR_FIRST_MB_IN_SLICE                                    0x00003004
+#define AVC_SHERR_RPLM                                                 0x00003006
+#define AVC_SHERR_LT_IDX_SPS_IS_OUT_OF_RANGE                           0x0000300A
+#define AVC_SHERR_NUM_REF_IDX_L0_ACTIVE_MINUS1                         0x0000300C
+#define AVC_SHERR_NUM_REF_IDX_L1_ACTIVE_MINUS1                         0x0000300D
+#define AVC_SHERR_PRED_WEIGHT_TABLE                                    0x0000300F
+#define AVC_SHERR_SLICE_QP_DELTA                                       0x00003011
+#define AVC_SHERR_SLICE_BETA_OFFSET_DIV2                               0x00003015
+#define AVC_SHERR_SLICE_TC_OFFSET_DIV2                                 0x00003016
+#define AVC_SHERR_DISABLE_DEBLOCK_FILTER_IDC                           0x00003017
+#define AVC_SPECERR_OVER_PICTURE_WIDTH_SIZE                            0x00004000
+#define AVC_SPECERR_OVER_PICTURE_HEIGHT_SIZE                           0x00004001
+#define AVC_SPECERR_OVER_CHROMA_FORMAT                                 0x00004002
+#define AVC_SPECERR_OVER_BIT_DEPTH                                     0x00004003
+#define AVC_SPECERR_OVER_BUFFER_OVER_FLOW                              0x00004004
+#define AVC_SPECERR_OVER_WRONG_BUFFER_ACCESS                           0x00004005
+#define AVC_ETCERR_INIT_SEQ_SPS_NOT_FOUND                              0x00005000
+#define AVC_ETCERR_DEC_PIC_VCL_NOT_FOUND                               0x00005001
+#define AVC_ETCERR_NO_VALID_SLICE_IN_AU                                0x00005002
+#define AVC_ETCERR_ASO                                                 0x00005004
+#define AVC_ETCERR_FMO                                                 0x00005005
+#define AVC_ETCERR_INPLACE_V                                           0x0000500F
+
+// AV1
+#define AV1_SPSERR_MAX_FRAME_WIDTH                                     0x00001001
+#define AV1_SPSERR_MAX_FRAME_HEIGHT                                    0x00001002
+#define AV1_SPSERR_ID_LEN_EXCEED_16                                    0x00001004
+#define AV1_SPSERR_NOT_FOUND_FIRST_SPS                                 0x0000100A
+#define AV1_SPSERR_SEQ_PROFILE                                         0x0000100B
+#define AV1_SPSERR_STILL_PICTURE                                       0x0000100C
+#define AV1_PPSERR_FRAME_SIZE_WIDTH                                    0x00002001
+#define AV1_PPSERR_FRAME_SIZE_HEIGHT                                   0x00002002
+#define AV1_PPSERR_SEEN_FRAME_HEADER                                   0x00002003
+#define AV1_PPSERR_REF_VALID                                           0x00002007
+#define AV1_PPSERR_LAST_ORDER_HINT                                     0x0000200B
+#define AV1_PPSERR_GOLD_ORDER_HINT                                     0x0000200C
+#define AV1_PPSERR_CODED_LOSSLESS_DELTA_Q                              0x0000200E
+#define AV1_PPSERR_FILM_GRAIN_PARAM_REF_IDX                            0x0000200F
+#define AV1_PPSERR_SEQ_CHANGE_BIT_DEPTH                                0x00002010
+#define AV1_PPSERR_SEQ_CHANGE_PROFILE                                  0x00002012
+#define AV1_PPSERR_SEQ_CHANGE_DETECTED_INTER                           0x00002013
+#define AV1_PPSERR_NUM_Y_POINTS                                        0x00002014
+#define AV1_PPSERR_POINT_Y_VALUE                                       0x00002015
+#define AV1_PPSERR_NUM_CB_POINTS                                       0x00002016
+#define AV1_PPSERR_POINT_CB_VALUE                                      0x00002017
+#define AV1_PPSERR_NUM_CR_POINTS                                       0x00002018
+#define AV1_PPSERR_POINT_CR_VALUE                                      0x00002019
+#define AV1_PPSERR_SUBSAMPLING_FORMAT                                  0x0000201A
+#define AV1_FRAMEERR_TILE_START_END_PRESENT                            0x00003001
+#define AV1_FRAMEERR_SHOW_EXISING_FRAME                                0x00003002
+#define AV1_TGERR_NUM_TILES_ZERO                                       0x00004001
+#define AV1_TGERR_START_NOT_TILE_NUM                                   0x00004002
+#define AV1_TGERR_END_LESS_THAN_TG_START                               0x00004003
+#define AV1_TGERR_TILE_SIZE_GREATER_THAN_32M                           0x00004004
+#define AV1_SPECERR_OVER_MAX_H_SIZE                                    0x00005001
+#define AV1_SPECERR_OVER_MAX_V_SIZE                                    0x00005002
+#define AV1_SPECERR_OVER_MAX_TILE_COLS                                 0x00005004
+#define AV1_SPECERR_OVER_MAX_TILE_ROWS                                 0x00005005
+#define AV1_SPECERR_OVER_TILE_SIZE                                     0x00005006
+#define AV1_SPECERR_OVER_NUMTILES_GT_MAX_TILES                         0x00005007
+#define AV1_ETCERR_OBU_HEADER                                          0x00006001
+#define AV1_ETCERR_OBU_SIZE                                            0x00006003
+#define AV1_ETCERR_OVERCONSUME                                         0x00006004
+#define AV1_ETCERR_NOT_SUPPORTED_FEATURE                               0x00006005
+#define AV1_ETCERR_RESILIENCE_FAIL                                     0x00006006
+
+// VP9
+#define VP9_PICERR_FRAME_MARKER                                        0x00001000
+#define VP9_PICERR_PROFILE                                             0x00001001
+#define VP9_PICERR_SYNC_CODE                                           0x00001002
+#define VP9_PICERR_PROFILE_COLOR_SAMPLE                                0x00001003
+#define VP9_PICERR_FRAME_SIZE                                          0x00001004
+#define VP9_PICERR_SEGMENT                                             0x00001005
+#define VP9_PICERR_TILE                                                0x00001006
+#define VP9_PICERR_PROFILE_COMP_MISMATCH_WITH_REF                      0x00001007
+#define VP9_PICERR_COMP_DAT_OVER_CS                                    0x00001008
+#define VP9_PICERR_COMP_TRAILING_BIT_ERR                               0x00001009
+#define VP9_PICERR_MARKER                                              0x0000100A
+#define VP9_PICERR_NOT_EXIST_REF_FRAME                                 0x0000100B
+#define VP9_PICERR_UNINIT_CTX                                          0x0000100C
+#define VP9_PICERR_FRAME_SIZE_LIMIT_BY_REF                             0x0000100D
+#define VP9_SPECERR_OVER_PICTURE_WIDTH_SIZE                            0x00004000
+#define VP9_SPECERR_OVER_PICTURE_HEIGHT_SIZE                           0x00004001
+#define VP9_SPECERR_OVER_CHROMA_FORMAT                                 0x00004002
+#define VP9_SPECERR_OVER_BIT_DEPTH                                     0x00004003
+#define VP9_ETCERR_INIT_KEY_FRAME_NOT_FOUND                            0x00005000
+#define VP9_ETCERR_FORBIDDEN_BS_MODE                                   0x00005004
+#define VP9_ETCERR_SPP_OVER_CS_AU                                      0x00005005
+
+// AVS2
+#define AVS2_SPSERR_PROFILE_ID                                         0x00001000
+#define AVS2_SPSERR_LEVEL_ID                                           0x00001001
+#define AVS2_SPSERR_HORIZONTAL_SIZE                                    0x00001002
+#define AVS2_SPSERR_VERTICAL_SIZE                                      0x00001003
+#define AVS2_SPSERR_CHROMA_FORMAT                                      0x00001004
+#define AVS2_SPSERR_SAMPLE_PRECISION                                   0x00001005
+#define AVS2_SPSERR_ENCODING_PRECISION                                 0x00001006
+#define AVS2_SPSERR_LCU_SIZE                                           0x00001007
+#define AVS2_SPSERR_WEIGHT_QUANT_MATRIX                                0x00001008
+#define AVS2_SPSERR_NUM_OF_RCS                                         0x00001009
+#define AVS2_SPSERR_REFERENCE_CONFIGURATION_SET                        0x0000100A
+#define AVS2_SPSERR_OUTPUT_REORDER_DELAY                               0x0000100B
+#define AVS2_PPSERR_BBV_DELAY                                          0x00002000
+#define AVS2_PPSERR_TIME_CODE                                          0x00002001
+#define AVS2_PPSERR_DECODE_ORDER_INDEX                                 0x00002002
+#define AVS2_PPSERR_TEMPORAL_ID                                        0x00002003
+#define AVS2_PPSERR_PICTURE_OUTPUT_DELAY                               0x00002004
+#define AVS2_PPSERR_RCS_INDEX                                          0x00002005
+#define AVS2_PPSERR_REFERENCE_CONFIGURATION_SET                        0x00002006
+#define AVS2_PPSERR_BBV_CHECK_TIMES                                    0x00002007
+#define AVS2_PPSERR_PICTURE_QP                                         0x00002008
+#define AVS2_PPSERR_ALPHA_C_OFFSET                                     0x00002009
+#define AVS2_PPSERR_BETA_OFFSET                                        0x0000200A
+#define AVS2_PPSERR_CHROMA_QUANT_PARAM_DELTA_CB                        0x0000200B
+#define AVS2_PPSERR_CHROMA_QUANT_PARAM_DELTA_CR                        0x0000200C
+#define AVS2_PPSERR_WEIGHT_QUANT_PARAM_DELTA1                          0x0000200D
+#define AVS2_PPSERR_WEIGHT_QUANT_PARAM_DELTA2                          0x0000200E
+#define AVS2_PPSERR_PICTURE_CODING_TYPE                                0x0000200F
+#define AVS2_PPSERR_ALF_FILTER_NUM_MINUS1                              0x00002010
+#define AVS2_PPSERR_ALF_REGION_DISTANCE                                0x00002011
+#define AVS2_PPSERR_ALF_COEFF_LUMA                                     0x00002012
+#define AVS2_PPSERR_ALF_COEFF_CHROMA_CB                                0x00002013
+#define AVS2_PPSERR_ALF_COEFF_CHROMA_CR                                0x00002014
+#define AVS2_SHERR_SLICE_VERTICAL_POSITION                             0x00003000
+#define AVS2_SHERR_SLICE_VERTICAL_POSITION_EXTENSION                   0x00003001
+#define AVS2_SHERR_SLICE_HORIZONTAL_POSITION                           0x00003002
+#define AVS2_SHERR_SLICE_HORIZONTAL_POSITION_EXTENSION                 0x00003003
+#define AVS2_SHERR_FIXED_SLICE_QP                                      0x00003004
+#define AVS2_SHERR_SLICE_QP                                            0x00003005
+#define AVS2_SHERR_SLICE_SAO_ENABLE_FLAG                               0x00003006
+#define AVS2_SHERR_AEC_BYTE_ALIGNMENT_BIT                              0x00003007
+#define AVS2_SHERR_STREAM_END                                          0x00003008
+#define AVS2_SPECERR_OVER_PICTURE_WIDTH_SIZE                           0x00004000
+#define AVS2_SPECERR_OVER_PICTURE_HEIGHT_SIZE                          0x00004001
+#define AVS2_SPECERR_OVER_CHROMA_FORMAT                                0x00004002
+#define AVS2_SPECERR_OVER_BIT_DEPTH                                    0x00004003
+#define AVS2_SPECERR_OVER_REF_TEMPORAL_ID                              0x00004004
+#define AVS2_ETCERR_SPS_NOT_FOUND                                      0x00005000
+#define AVS2_ETCERR_DEC_PIC_VCL_NOT_FOUND                              0x00005001
+#define AVS2_ETCERR_NO_VALID_SLICE_IN_AU                               0x00005002
+#define AVS2_ETCERR_PPS_ERROR                                          0x00005003
+#define AVS2_ETCERR_SLICE_NUM_OVERFLOW                                 0x00005004
+
+/************************************************************************/
+/* WAVE5 WARNING ON DECODER (WARN_INFO)                                 */
+/************************************************************************/
+// HEVC
+#define HEVC_SPSWARN_MAX_SUB_LAYERS_MINUS1                             0x00000001
+#define HEVC_SPSWARN_GENERAL_RESERVED_ZERO_44BITS                      0x00000002
+#define HEVC_SPSWARN_RESERVED_ZERO_2BITS                               0x00000004
+#define HEVC_SPSWARN_SUB_LAYER_RESERVED_ZERO_44BITS                    0x00000008
+#define HEVC_SPSWARN_GENERAL_LEVEL_IDC                                 0x00000010
+#define HEVC_SPSWARN_SPS_MAX_DEC_PIC_BUFFERING_VALUE_OVER              0x00000020
+#define HEVC_SPSWARN_RBSP_TRAILING_BITS                                0x00000040
+#define HEVC_SPSWARN_ST_RPS_UE_ERROR                                   0x00000080
+#define HEVC_SPSWARN_EXTENSION_FLAG                                    0x01000000
+#define HEVC_SPSWARN_REPLACED_WITH_PREV_SPS                            0x02000000
+#define HEVC_PPSWARN_RBSP_TRAILING_BITS                                0x00000100
+#define HEVC_PPSWARN_REPLACED_WITH_PREV_PPS                            0x00000200
+#define HEVC_SHWARN_FIRST_SLICE_SEGMENT_IN_PIC_FLAG                    0x00001000
+#define HEVC_SHWARN_NO_OUTPUT_OF_PRIOR_PICS_FLAG                       0x00002000
+#define HEVC_SHWARN_PIC_OUTPUT_FLAG                                    0x00004000
+#define HEVC_SHWARN_DUPLICATED_SLICE_SEGMENT                           0x00008000
+#define HEVC_ETCWARN_INIT_SEQ_VCL_NOT_FOUND                            0x00010000
+#define HEVC_ETCWARN_MISSING_REFERENCE_PICTURE                         0x00020000
+#define HEVC_ETCWARN_WRONG_TEMPORAL_ID                                 0x00040000
+#define HEVC_ETCWARN_ERROR_PICTURE_IS_REFERENCED                       0x00080000
+#define HEVC_SPECWARN_OVER_PROFILE                                     0x00100000
+#define HEVC_SPECWARN_OVER_LEVEL                                       0x00200000
+#define HEVC_PRESWARN_PARSING_ERR                                      0x04000000
+#define HEVC_PRESWARN_MVD_OUT_OF_RANGE                                 0x08000000
+#define HEVC_PRESWARN_CU_QP_DELTA_VAL_OUT_OF_RANGE                     0x09000000
+#define HEVC_PRESWARN_COEFF_LEVEL_REMAINING_OUT_OF_RANGE               0x0A000000
+#define HEVC_PRESWARN_PCM_ERR                                          0x0B000000
+#define HEVC_PRESWARN_OVERCONSUME                                      0x0C000000
+#define HEVC_PRESWARN_END_OF_SUBSET_ONE_BIT_ERR                        0x10000000
+#define HEVC_PRESWARN_END_OF_SLICE_SEGMENT_FLAG                        0x20000000
+
+// AVC
+#define AVC_SPSWARN_RESERVED_ZERO_2BITS                                0x00000004
+#define AVC_SPSWARN_GENERAL_LEVEL_IDC                                  0x00000010
+#define AVC_SPSWARN_RBSP_TRAILING_BITS                                 0x00000040
+#define AVC_PPSWARN_RBSP_TRAILING_BITS                                 0x00000100
+#define AVC_SHWARN_NO_OUTPUT_OF_PRIOR_PICS_FLAG                        0x00002000
+#define AVC_ETCWARN_INIT_SEQ_VCL_NOT_FOUND                             0x00010000
+#define AVC_ETCWARN_MISSING_REFERENCE_PICTURE                          0x00020000
+#define AVC_ETCWARN_ERROR_PICTURE_IS_REFERENCED                        0x00080000
+#define AVC_SPECWARN_OVER_PROFILE                                      0x00100000
+#define AVC_SPECWARN_OVER_LEVEL                                        0x00200000
+#define AVC_PRESWARN_MVD_RANGE_OUT                                     0x00400000
+#define AVC_PRESWARN_MB_QPD_RANGE_OUT                                  0x00500000
+#define AVC_PRESWARN_COEFF_RANGE_OUT                                   0x00600000
+#define AVC_PRESWARN_MV_RANGE_OUT                                      0x00700000
+#define AVC_PRESWARN_MB_SKIP_RUN_RANGE_OUT                             0x00800000
+#define AVC_PRESWARN_MB_TYPE_RANGE_OUT                                 0x00900000
+#define AVC_PRESWARN_SUB_MB_TYPE_RANGE_OUT                             0x00A00000
+#define AVC_PRESWARN_CBP_RANGE_OUT                                     0x00B00000
+#define AVC_PRESWARN_INTRA_CHROMA_PRED_MODE_RANGE_OUT                  0x00C00000
+#define AVC_PRESWARN_REF_IDX_RANGE_OUT                                 0x00D00000
+#define AVC_PRESWARN_COEFF_TOKEN_RANGE_OUT                             0x00E00000
+#define AVC_PRESWARN_TOTAL_ZERO_RANGE_OUT                              0x00F00000
+#define AVC_PRESWARN_RUN_BEFORE_RANGE_OUT                              0x01000000
+#define AVC_PRESWARN_OVERCONSUME                                       0x01100000
+#define AVC_PRESWARN_MISSING_SLICE                                     0x01200000
+
+// AV1
+#define AV1_SPSWARN_OBU_EXTENTION_FLAG_ZERO                            0x00001000
+#define AV1_SPSWARN_DUPLICATE_OPERATING_POINT_IDX                      0x00001001
+#define AV1_SPSWARN_MC_IDENTIY_SUBSAMPLING_X                           0x00001002
+#define AV1_PPSWARN_MC_IDENTIY_SUBSAMPLING_Y                           0x00001003
+#define AV1_SPSWARN_NUM_UNITS_IN_DISPLAY_TICK                          0x00001004
+#define AV1_SPSWARN_TIME_SCALE_ZERO                                    0x00001005
+#define AV1_SPSWARN_NUM_TICKS_PER_PICTURE                              0x00001006
+#define AV1_PPSWARN_TILE_WIDTH                                         0x00002001
+#define AV1_PPSWARN_TILE_HEIGHT                                        0x00002002
+#define AV1_PPSWARN_SHOW_EXISTING_KEY_FRAME_OUTPUT                     0x00002004
+#define AV1_PPSWARN_DIFF_FRAME_ID                                      0x00002008
+#define AV1_PPSWARN_CURRENT_FRAME_ID                                   0x00002010
+#define AV1_PPSWARN_REFRESH_FRAME_FLAGS                                0x00002020
+#define AV1_PPSWARN_DISPLAY_ID                                         0x00002040
+#define AV1_PPSWARN_PREV_FRAME_SHOWABLE_FLAG_ZERO                      0x00002080
+#define AV1_PPSWARN_EXPECTED_FRAME_ID                                  0x00002100
+#define AV1_SPECWARN_OVER_MAX_TILE_AREA_SB                             0x00005000
+#define AV1_SPECWARN_OVER_MAX_PIC_SIZE                                 0x00005001
+#define AV1_ETCWARN_OBU_EXTENTION_FLAG                                 0x00006000
+#define AV1_TGWARN_TRAIL_BIT_POS                                       0x00400000
+#define AV1_TGWARN_TRAIL_PAD_BIT                                       0x00800000
+#define AV1_TGWARN_SYM_MAX_OVER                                        0x01000000
+#define AV1_TGWARN_EXP_GOLB_OVER                                       0x02000000
+#define AV1_TGWARN_MV_NOT_VAILD                                        0x04000000
+
+// VP9
+#define VP9_PICWARN_COLOR_SPACE_MISMATCH_WITH_REF                      0x00001000
+#define VP9_PRESWARN_OVERCONSUME                                       0x00400000
+#define VP9_PRESWARN_TRAILING_BITS                                     0x00800000
+#define VP9_PRESWARN_MARKER                                            0x01000000
+#define VP9_PRESWARN_MV_RANGE_OVER                                     0x02000000
+#define VP9_PRESWARN_MISIZE_SEG_LVL_ACTIVE                             0x04000000
+
+// AVS2
+#define AVS2_ETCWARN_INIT_SEQ_VCL_NOT_FOUND                            0x00010000
+#define AVS2_ETCWARN_MISSING_REFERENCE_PICTURE                         0x00020000
+#define AVS2_ETCWARN_WRONG_TEMPORAL_ID                                 0x00040000
+#define AVS2_ETCWARN_ERROR_PICTURE_IS_REFERENCED                       0x00080000
+#define AVS2_ETCWARN_REF_WRONG_TEMPORAL_ID                             0x00080001
+#define AVS2_ETCWARN_SPS_ERROR                                         0x00080002
+
+/************************************************************************/
+/* WAVE5 ERROR ON ENCODER (ERR_INFO)                                    */
+/************************************************************************/
+
+/************************************************************************/
+/* WAVE5 WARNING ON ENCODER (WARN_INFO)                                 */
+/************************************************************************/
+#define WAVE5_ETCWARN_FORCED_SPLIT_BY_CU8X8                            0x000000001
+
+/************************************************************************/
+/* WAVE5 debug info (PRI_REASON)                                        */
+/************************************************************************/
+#define WAVE5_DEC_VCORE_VCE_HANGUP                                     0x0001
+#define WAVE5_DEC_VCORE_UNDETECTED_SYNTAX_ERR                          0x0002
+#define WAVE5_DEC_VCORE_MIB_BUSY                                       0x0003
+#define WAVE5_DEC_VCORE_VLC_BUSY                                       0x0004
+
+#endif /* ERROR_CODE_H_INCLUDED */
+
diff --git a/drivers/staging/media/wave5/wave5.h b/drivers/staging/media/wave5/wave5.h
new file mode 100644
index 000000000000..7c17b746c2fe
--- /dev/null
+++ b/drivers/staging/media/wave5/wave5.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Wave5 series multi-standard codec IP - wave5 backend definitions
+ *
+ * Copyright (C) 2021 CHIPS&MEDIA INC
+ */
+
+#ifndef __WAVE5_FUNCTION_H__
+#define __WAVE5_FUNCTION_H__
+
+#define WAVE5_SUBSAMPLED_ONE_SIZE(_w, _h)	(ALIGN((_w) / 4, 16) * ALIGN((_h) / 4, 8))
+#define WAVE5_SUBSAMPLED_ONE_SIZE_AVC(_w, _h)	(ALIGN((_w) / 4, 32) * ALIGN((_h) / 4, 4))
+
+#define BSOPTION_ENABLE_EXPLICIT_END        BIT(0)
+
+#define WTL_RIGHT_JUSTIFIED          0
+#define WTL_LEFT_JUSTIFIED           1
+#define WTL_PIXEL_8BIT               0
+#define WTL_PIXEL_16BIT              1
+#define WTL_PIXEL_32BIT              2
+
+bool wave5_vpu_is_init(struct vpu_device *vpu_dev);
+
+int32_t wave_vpu_get_product_id(struct vpu_device *vpu_dev);
+
+void wave5_bit_issue_command(struct vpu_instance *inst, uint32_t cmd);
+
+int wave5_vpu_get_version(struct vpu_device *vpu_dev, u32 *version_info, uint32_t *revision);
+
+int wave5_vpu_init(struct device *dev, u8 *firmware, uint32_t      size);
+
+int wave5_vpu_reset(struct device *dev, enum sw_reset_mode reset_mode);
+
+int wave5_vpu_build_up_dec_param(struct vpu_instance *inst, struct dec_open_param *param);
+
+int wave5_vpu_dec_set_bitstream_flag(struct vpu_instance *inst, bool eos);
+
+int wave5_vpu_dec_register_framebuffer(struct vpu_instance *inst,
+				       struct frame_buffer *fb_arr, enum tiled_map_type map_type,
+				       uint32_t count);
+
+int wave5_vpu_re_init(struct device *dev, u8 *firmware, uint32_t size);
+
+int wave5_vpu_dec_init_seq(struct vpu_instance *vpu_inst);
+
+int wave5_vpu_dec_get_seq_info(struct vpu_instance *vpu_inst, struct dec_initial_info *info);
+
+int wave5_vpu_decode(struct vpu_instance *vpu_inst, struct dec_param *option, u32 *fail_res);
+
+int wave5_vpu_dec_get_result(struct vpu_instance *inst, struct dec_output_info *result);
+
+int wave5_vpu_dec_fini_seq(struct vpu_instance *vpu_inst, u32 *fail_res);
+
+int wave5_dec_clr_disp_flag(struct vpu_instance *inst, uint32_t index);
+
+int wave5_vpu_clear_interrupt(struct vpu_instance *inst, uint32_t flags);
+
+dma_addr_t wave5_vpu_dec_get_rd_ptr(struct vpu_instance *vpu_inst);
+
+/***< WAVE5 encoder >******/
+
+int wave5_vpu_build_up_enc_param(struct device *dev, struct vpu_instance *inst,
+				 struct enc_open_param *param);
+
+int wave5_vpu_enc_init_seq(struct vpu_instance *vpu_inst);
+
+int wave5_vpu_enc_get_seq_info(struct vpu_instance *vpu_inst, struct enc_initial_info *info);
+
+int wave5_vpu_enc_register_framebuffer(struct device *dev, struct vpu_instance *vpu_inst,
+				       struct frame_buffer *fb_arr, enum tiled_map_type map_type,
+				       uint32_t count);
+
+int wave5_vpu_encode(struct vpu_instance *vpu_inst, struct enc_param *option, u32 *fail_res);
+
+int wave5_vpu_enc_get_result(struct vpu_instance *vpu_inst, struct enc_output_info *result);
+
+int wave5_vpu_enc_fini_seq(struct vpu_instance *vpu_inst, u32 *fail_res);
+
+int wave5_vpu_enc_check_open_param(struct vpu_instance *vpu_inst, struct enc_open_param *pop);
+
+#endif /* __WAVE5_FUNCTION_H__ */
+
-- 
2.17.1

