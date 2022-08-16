Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53A6595A43
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbiHPLeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbiHPLdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:33:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457EDB69;
        Tue, 16 Aug 2022 03:55:40 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso1112659pjk.0;
        Tue, 16 Aug 2022 03:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=B3c/DLw64sS1zypvr0XvqVQaDOcVU4AcI36pzBt1fV4=;
        b=mw4dwu0Wtzio4J7+uInb5hdMPZT5vDDa5My0CbEDlIhlGKuFSlE4ORfZB8P1/0wGDh
         E1zvfBhJtSpgYl9BPUSIZQPfmlDrMCS7eip4JPyAY9te2TXyZ4ROBGPdy9TgKJk21EtB
         F+mYKxJZn1qZC70obKxfdHiqpHRD26wywJ/pBJbjHm4fsj0/oVXYypMnvo1A2A1hj1i/
         jiEnIgCMwW0ttgKMzAFE1FWJUnRt7dzic9U5xAfgvogk6rTdE/OFDarf6Z+Pc9wve9KI
         rpMGdC7NFDoesRJ+lY5R5Ac16nOR+xuEFKilum1WjA7TDeQH5xQ1CB1HPchIYDwk2uiW
         QPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=B3c/DLw64sS1zypvr0XvqVQaDOcVU4AcI36pzBt1fV4=;
        b=6OydKJBrUAP1oaDVaEli6fxQJCi8hIUJkA9hek3yo/HZE7cQUxj8jTL66ARoW8FIiE
         pt0KpdQ2VaA7j8a88giXx6xmz9E/Jti08q+bFM0PiK2KmhnEJ1alkgJtRThgZ0Qyz6nV
         5cyBil4zNKfqFKityeku3pYNe8QzV/hcAv5BjUhPkhv+i3G3VxQ1Ng+dSpvIhjN2Onn0
         klIQtkAaCIvibQ3j/CBWW6bgOirS43EM86PE3+LhHLklmviiBz9IlnybRY/iIYt1ZhGL
         Qr5BH9RDbntsuCroiT/+7tKVxnNmgSckPPPh+PemV1k6wFzsGkCRhlSn+GXrm9TzOy7a
         uTNw==
X-Gm-Message-State: ACgBeo3JilnlT5jn1To/WQrq1QKLg+ICcj8nEYLUgGGVCn6s/62v5D3u
        3jzk7qWF5BvrmOcT/QbMe52dfaDpxatjGBOz
X-Google-Smtp-Source: AA6agR4sft2UbVRyHO4hfMQfvsKtJ9jiBOVdNHm9yoDXgWGCSe5RSOs2kk49awozNmq6w43wvR4n9Q==
X-Received: by 2002:a17:902:bd49:b0:170:953d:c489 with SMTP id b9-20020a170902bd4900b00170953dc489mr21520620plx.96.1660647339612;
        Tue, 16 Aug 2022 03:55:39 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b0016d23e941f2sm8665790pli.258.2022.08.16.03.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 03:55:39 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
To:     gregkh@linuxfoundation.org, mario.limonciello@amd.com,
        mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw
Subject: [PATCH v4] thunderbolt: thunderbolt: add vendor's NVM formats
Date:   Tue, 16 Aug 2022 18:55:02 +0800
Message-Id: <20220816105502.9059-1-chensiying21@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Szuying Chen <Chloe_Chen@asmedia.com.tw>

The patch add tb_nvm_validate() contain an array that has functions
pointers to asmedia_nvm_validate().
And asmedia_nvm_validate() that recognize supported vendor works in one
of the following cases:
Case NVM_UPGRADE: enable nvm's attribute by setting no_nvm_upgrade
flag to create nvm_authenticate file node.
Case NVM_ADD: add active/non-active NVM devices.
Case NVM_WRITE: update firmware to non-ative NVM device.

Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
---Add enum nvm_validate_ops and modify ASMedia NVM Version format.
---Repair file(switch.c) has existed warning, but have 7 warn not fixed.

Note: The three previous submissions accidentally used the same subject
prefix. This changelog is relative to the most recent submission at
https://github.com/intel-lab-lkp/linux/commits/Szuying-Chen/thunderbolt-thunderbolt-add-vendor-s-NVM-formats/20220815-121330

 drivers/thunderbolt/nvm.c    | 148 +++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/switch.c |  28 ++++++-
 drivers/thunderbolt/tb.h     |  23 ++++++
 3 files changed, 196 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
index b3f310389378..be8cbcfafb80 100644
--- a/drivers/thunderbolt/nvm.c
+++ b/drivers/thunderbolt/nvm.c
@@ -9,11 +9,159 @@
 #include <linux/idr.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
+#include <linux/pm_runtime.h>

 #include "tb.h"

 static DEFINE_IDA(nvm_ida);

+static int tb_switch_nvm_read(void *priv, unsigned int offset, void *val,
+			      size_t bytes)
+{
+	struct tb_nvm *nvm = priv;
+	struct tb_switch *sw = tb_to_switch(nvm->dev);
+	int ret;
+
+	pm_runtime_get_sync(&sw->dev);
+	if (!mutex_trylock(&sw->tb->lock)) {
+		ret = restart_syscall();
+		goto out;
+	}
+	ret = usb4_switch_nvm_read(sw, offset, val, bytes);
+	mutex_unlock(&sw->tb->lock);
+
+out:
+	pm_runtime_mark_last_busy(&sw->dev);
+	pm_runtime_put_autosuspend(&sw->dev);
+
+	return ret;
+}
+
+static int tb_switch_nvm_write(void *priv, unsigned int offset, void *val,
+			       size_t bytes)
+{
+	struct tb_nvm *nvm = priv;
+	struct tb_switch *sw = tb_to_switch(nvm->dev);
+	int ret;
+
+	if (!mutex_trylock(&sw->tb->lock))
+		return restart_syscall();
+
+	/*
+	 * Since writing the NVM image might require some special steps,
+	 * for example when CSS headers are written, we cache the image
+	 * locally here and handle the special cases when the user asks
+	 * us to authenticate the image.
+	 */
+	ret = tb_nvm_write_buf(nvm, offset, val, bytes);
+	mutex_unlock(&sw->tb->lock);
+
+	return ret;
+}
+
+static int asmedia_nvm_validate(struct tb_switch *sw, unsigned int mode)
+{
+	struct tb_nvm *nvm;
+	u32 val;
+	u32 nvm_size;
+	int ret = 0;
+	unsigned int image_size;
+
+	switch (mode) {
+	case NVM_UPGRADE:
+		if (sw->no_nvm_upgrade)
+			sw->no_nvm_upgrade = false;
+
+		break;
+
+	case NVM_ADD:
+		nvm = tb_nvm_alloc(&sw->dev);
+		if (IS_ERR(nvm)) {
+			ret = PTR_ERR(nvm);
+			break;
+		}
+
+		ret = usb4_switch_nvm_read(sw, ASMEDIA_NVM_VERSION, &val, sizeof(val));
+		if (ret)
+			break;
+
+		nvm->nvm_asm.major = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
+		ret = usb4_switch_nvm_read(sw, ASMEDIA_NVM_DATE, &val, sizeof(val));
+		if (ret)
+			break;
+
+		nvm->nvm_asm.minor = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
+		nvm_size = SZ_512K;
+		ret = tb_nvm_add_active(nvm, nvm_size, tb_switch_nvm_read);
+		if (ret)
+			break;
+
+		ret = tb_nvm_add_non_active(nvm, NVM_MAX_SIZE, tb_switch_nvm_write);
+		if (ret)
+			break;
+
+		sw->nvm = nvm;
+		break;
+
+	case NVM_WRITE:
+		const u8 *buf = sw->nvm->buf;
+
+		if (!buf) {
+			ret = -EINVAL;
+			break;
+		}
+		image_size = sw->nvm->buf_data_size;
+		if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE) {
+			ret = -EINVAL;
+			break;
+		}
+		ret = usb4_switch_nvm_write(sw, 0, buf, image_size);
+		if (!ret)
+			sw->nvm->flushed = true;
+
+		break;
+
+	default:
+		break;
+	}
+
+	if ((mode == NVM_ADD) && (ret != 0))
+		tb_nvm_free(sw->nvm);
+
+	return ret;
+}
+
+struct tb_nvm_id {
+	u16 hw_vendor_id;
+	int (*validate)(struct tb_switch *sw, unsigned int mode);
+};
+
+static const struct tb_nvm_id tb_nvm_vendors[] = {
+	/* ASMedia software CM firmware upgrade */
+	{ 0x174c, asmedia_nvm_validate },
+};
+
+/**
+ * tb_nvm_vendor_handle() - support vendor's NVM format
+ * @sw: Thunderbolt switch
+ * @handle: 0:NvmUpgradeSuppport, 1:NvmAdd, 2:NvmWrite
+ */
+int tb_nvm_validate(struct tb_switch *sw, unsigned int mode)
+{
+	int i;
+	int res = 0;
+
+	for (i = 0; i < ARRAY_SIZE(tb_nvm_vendors); i++) {
+		const struct tb_nvm_id *id = &tb_nvm_vendors[i];
+
+		if (id->hw_vendor_id && id->hw_vendor_id != sw->config.vendor_id)
+			continue;
+
+		 res = id->validate(sw, mode);
+	}
+	return res;
+}
+
 /**
  * tb_nvm_alloc() - Allocate new NVM structure
  * @dev: Device owning the NVM
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 244f8cd38b25..de380fb5a166 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -114,6 +114,14 @@ static int nvm_validate_and_write(struct tb_switch *sw)
 	if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE)
 		return -EINVAL;

+	/*
+	 * Vendor's nvm write. If the image has been flushed to the
+	 * storage are, nvm write is complete.
+	 */
+	ret = tb_nvm_validate(sw, NVM_WRITE);
+	if (sw->nvm->flushed)
+		return ret;
+
 	/*
 	 * FARB pointer must point inside the image and must at least
 	 * contain parts of the digital section we will be reading here.
@@ -391,10 +399,14 @@ static int tb_switch_nvm_add(struct tb_switch *sw)
 		return 0;

 	/*
-	 * The NVM format of non-Intel hardware is not known so
-	 * currently restrict NVM upgrade for Intel hardware. We may
-	 * relax this in the future when we learn other NVM formats.
+	 * The NVM format of Intel and Asmedia hardware are known so
+	 * currently restrict NVM upgrade for Intel and Asmedia hardware.
+	 * We may relax this in the future when we learn other NVM formats.
 	 */
+	ret = tb_nvm_validate(sw, NVM_ADD);
+	if (ret)
+		return ret;
+
 	if (sw->config.vendor_id != PCI_VENDOR_ID_INTEL &&
 	    sw->config.vendor_id != 0x8087) {
 		dev_info(&sw->dev,
@@ -527,6 +539,7 @@ int tb_port_state(struct tb_port *port)
 {
 	struct tb_cap_phy phy;
 	int res;
+
 	if (port->cap_phy == 0) {
 		tb_port_WARN(port, "does not have a PHY\n");
 		return -EINVAL;
@@ -556,6 +569,7 @@ int tb_wait_for_port(struct tb_port *port, bool wait_if_unplugged)
 {
 	int retries = 10;
 	int state;
+
 	if (!port->cap_phy) {
 		tb_port_WARN(port, "does not have PHY\n");
 		return -EINVAL;
@@ -653,6 +667,7 @@ int tb_port_add_nfc_credits(struct tb_port *port, int credits)
 int tb_port_clear_counter(struct tb_port *port, int counter)
 {
 	u32 zero[3] = { 0, 0, 0 };
+
 	tb_port_dbg(port, "clearing counter %d\n", counter);
 	return tb_port_write(port, zero, TB_CFG_COUNTERS, 3 * counter, 3);
 }
@@ -875,6 +890,7 @@ static inline bool tb_switch_is_reachable(const struct tb_switch *parent,
 					  const struct tb_switch *sw)
 {
 	u64 mask = (1ULL << parent->config.depth * 8) - 1;
+
 	return (tb_route(parent) & mask) == (tb_route(sw) & mask);
 }

@@ -1345,6 +1361,7 @@ bool tb_pci_port_is_enabled(struct tb_port *port)
 int tb_pci_port_enable(struct tb_port *port, bool enable)
 {
 	u32 word = enable ? ADP_PCIE_CS_0_PE : 0x0;
+
 	if (!port->cap_adap)
 		return -ENXIO;
 	return tb_port_write(port, &word, TB_CFG_PORT,
@@ -1918,6 +1935,7 @@ static ssize_t nvm_authenticate_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	int ret = nvm_authenticate_sysfs(dev, buf, false);
+
 	if (ret)
 		return ret;
 	return count;
@@ -1953,6 +1971,9 @@ static ssize_t nvm_version_show(struct device *dev,
 		ret = -ENODATA;
 	else if (!sw->nvm)
 		ret = -EAGAIN;
+	/*ASMedia NVM version show format xxxxxx_xxxxxx */
+	else if (sw->config.vendor_id == 0x174C)
+		ret = sprintf(buf, "%06x.%06x\n", sw->nvm->nvm_asm.major, sw->nvm->nvm_asm.minor);
 	else
 		ret = sprintf(buf, "%x.%x\n", sw->nvm->major, sw->nvm->minor);

@@ -2860,6 +2881,7 @@ int tb_switch_add(struct tb_switch *sw)
 		tb_sw_dbg(sw, "uid: %#llx\n", sw->uid);

 		tb_check_quirks(sw);
+		tb_nvm_validate(sw, NVM_UPGRADE);

 		ret = tb_switch_set_uuid(sw);
 		if (ret) {
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 5db76de40cc1..7f5c8ae731a0 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -28,6 +28,15 @@
 #define NVM_VERSION		0x08
 #define NVM_FLASH_SIZE		0x45

+/* ASMedia specific NVM offsets */
+#define ASMEDIA_NVM_VERSION	0x28
+#define ASMEDIA_NVM_DATE	0x1c
+
+struct nvm_asmedia {
+	u32 major;
+	u32 minor;
+};
+
 /**
  * struct tb_nvm - Structure holding NVM information
  * @dev: Owner of the NVM
@@ -57,6 +66,7 @@ struct tb_nvm {
 	size_t buf_data_size;
 	bool authenticating;
 	bool flushed;
+	struct nvm_asmedia nvm_asm;
 };

 enum tb_nvm_write_ops {
@@ -65,6 +75,18 @@ enum tb_nvm_write_ops {
 	AUTHENTICATE_ONLY = 3,
 };

+/*
+ * enum nvm_validate_ops - Nvm upgrade for each vendor
+ * @NVM_UPGRADE: Not prevent NVM upgrade.
+ * @NVM_ADD: Vendor's NVM device add.
+ * @NVM_WRITE: Vendor's NVM write.
+ */
+enum nvm_validate_ops {
+	NVM_UPGRADE = 0,
+	NVM_ADD = 1,
+	NVM_WRITE = 2,
+};
+
 #define TB_SWITCH_KEY_SIZE		32
 #define TB_SWITCH_MAX_DEPTH		6
 #define USB4_SWITCH_MAX_DEPTH		5
@@ -736,6 +758,7 @@ static inline void tb_domain_put(struct tb *tb)
 	put_device(&tb->dev);
 }

+int tb_nvm_validate(struct tb_switch *sw, unsigned int mode);
 struct tb_nvm *tb_nvm_alloc(struct device *dev);
 int tb_nvm_add_active(struct tb_nvm *nvm, size_t size, nvmem_reg_read_t reg_read);
 int tb_nvm_write_buf(struct tb_nvm *nvm, unsigned int offset, void *val,
--
2.34.1

