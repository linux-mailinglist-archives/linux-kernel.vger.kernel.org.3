Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FCA59286A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiHOEL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiHOEL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:11:56 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752FE13E3C;
        Sun, 14 Aug 2022 21:11:54 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so11030196pjz.1;
        Sun, 14 Aug 2022 21:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=vb8rCsWmHlVJjy/NaTZhvtDXtJh4hqkw3y+FnhmCRJs=;
        b=AW3HLFVYU3/t661XFQZ9t9Nou2ANccdI2QBF0Fxku4eo395l0KS7FpRHVlJwG/7xy9
         ZsEs6Z9vP9ZMc/pMUibpNEr5dSl3NO5lcDuUCrfURHBk64APUmdPCJSliGlVqjSInPw/
         zF4iAeQgdXwNjoHgVts8nKDwCMiw7ydAblUamkXhkVcafTkje6xfXT/7k0xS03wim5f+
         6vwYQFZHjsysBB9COkbv0HlxYFLSr5Wqlk4pOAyi1l0jNg9XDTLEo/Ety+60qL9lnoTi
         qXxh+epw3+HBMHbIag5lqz9DSa80LO4Y+glGjqsT4gHinCzShXRZ7BhKej2kszfebjkt
         1IbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=vb8rCsWmHlVJjy/NaTZhvtDXtJh4hqkw3y+FnhmCRJs=;
        b=pGRsNr+AMS2NQltourRUBhEYgZgIWe09B5PRPhpRUNXYzulct07Bemc7dOE5dDGeCQ
         LiDdoxJ5OdAD2lkPY8n+X0EGi+CtQkk6F/6a1nrV4WWFVfzuX6z9v7LyQSENktR6To1u
         fvEANe+nkDy+GQd31h893q8XG9YgjC39j4YjgnkRiPGUr/lhyXfxxXjqMQDG55xOtDPw
         cbGsJUwloI6Dcgq0L/++edwe8Xm88xjihxqkuqflCPtVHnXEjDmgs+2Mj6SfcEIsbDdd
         2LmbWIYEneryiLN5ZaE9twGSuO2GWZ8HVuzDu9Xus/RH/dzaO9YC3injhW31F7iOuTZK
         0OHg==
X-Gm-Message-State: ACgBeo3jFmn/N5GAkVuf3L2FCdKqFPRaBDjNjOSminVAyWeryhnWH7K0
        f6TtRM68MuJ5pnE5jWOQFO4=
X-Google-Smtp-Source: AA6agR4i40gIdQOjuAS6d0SkZTZFbOVlDwf8rV6SJr1grot6bURZPxQDxbQI+Mi2h5JBXxRTxUV+5A==
X-Received: by 2002:a17:902:cf0c:b0:16f:9023:e07b with SMTP id i12-20020a170902cf0c00b0016f9023e07bmr14897839plg.143.1660536713644;
        Sun, 14 Aug 2022 21:11:53 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090264c100b001713f45477asm6092300pli.250.2022.08.14.21.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 21:11:53 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
To:     gregkh@linuxfoundation.org, mika.westerberg@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw
Subject: [PATCH] thunderbolt: thunderbolt: add vendor's NVM formats
Date:   Mon, 15 Aug 2022 12:11:45 +0800
Message-Id: <20220815041145.35629-1-chensiying21@gmail.com>
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
Case nvm_upgrade: enable nvm's attribute by setting no_nvm_upgrade
flag to create nvm_authenticate file node.
Case nvm_add:add active/non-active NVM devices.
Case nvm_write:update firmware to non-ative NVM device.

Our patches were through checkpatch.pl. But the file(switch.c.)
have existed 13 warning before we patch it.

Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
---
 drivers/thunderbolt/nvm.c    | 147 +++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/switch.c |  17 ++++
 drivers/thunderbolt/tb.h     |  18 +++++
 3 files changed, 182 insertions(+)

diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
index b3f310389378..6db2034ec8e5 100644
--- a/drivers/thunderbolt/nvm.c
+++ b/drivers/thunderbolt/nvm.c
@@ -9,11 +9,158 @@
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
+	const u8 *buf = sw->nvm->buf;
+
+	switch (mode) {
+	case nvm_upgrade:
+		if (sw->no_nvm_upgrade)
+			sw->no_nvm_upgrade = false;
+
+		break;
+
+	case nvm_add:
+		nvm = tb_nvm_alloc(&sw->dev);
+		if (IS_ERR(nvm)) {
+			ret = PTR_ERR(nvm);
+			break;
+		}
+
+		ret = usb4_switch_nvm_read(sw, NVM_Date, &val, sizeof(val));
+		if (ret)
+			break;
+
+		nvm->nvm_asm.date = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
+		ret = usb4_switch_nvm_read(sw, NVM_CUSTOMER_ID, &val, sizeof(val));
+		if (ret)
+			break;
+
+		nvm->nvm_asm.customerID = (((u8)val) << 0x8 | ((u8)(val >> 0x8)));
+		nvm->nvm_asm.version = (u8)(val >> 0x10);
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
+	case nvm_write:
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
+	if ((mode == nvm_add) && (ret != 0))
+		tb_nvm_free(sw->nvm);
+
+	return ret;
+}
+
+struct tb_nvm_id {
+	u16 hw_vendor_id;
+	int (*validate)(struct tb_switch *sw, unsigned int handle);
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
+	int res, i;
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
index 244f8cd38b25..352e64f3dc92 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -114,6 +114,14 @@ static int nvm_validate_and_write(struct tb_switch *sw)
 	if (image_size < NVM_MIN_SIZE || image_size > NVM_MAX_SIZE)
 		return -EINVAL;

+	/*
+	 * Vendor's nvm write. If the image has been flushed to the
+	 * storage are, nvm write is complete.
+	 */
+	ret = tb_nvm_validate(sw, nvm_write);
+	if (sw->nvm->flushed)
+		return ret;
+
 	/*
 	 * FARB pointer must point inside the image and must at least
 	 * contain parts of the digital section we will be reading here.
@@ -390,6 +398,11 @@ static int tb_switch_nvm_add(struct tb_switch *sw)
 	if (!nvm_readable(sw))
 		return 0;

+	/* Vendor's NVM formats add */
+	ret = tb_nvm_validate(sw, nvm_add);
+	if (ret)
+		return ret;
+
 	/*
 	 * The NVM format of non-Intel hardware is not known so
 	 * currently restrict NVM upgrade for Intel hardware. We may
@@ -1953,6 +1966,9 @@ static ssize_t nvm_version_show(struct device *dev,
 		ret = -ENODATA;
 	else if (!sw->nvm)
 		ret = -EAGAIN;
+	/*ASMedia NVM version show format xxxxxx_xxxx_xx */
+	else if (sw->config.vendor_id == 0x174C)
+		ret = sprintf(buf, "%06x_%04x_%02x\n", sw->nvm->nvm_asm.date, sw->nvm->nvm_asm.customerID, sw->nvm->nvm_asm.version);
 	else
 		ret = sprintf(buf, "%x.%x\n", sw->nvm->major, sw->nvm->minor);

@@ -2860,6 +2876,7 @@ int tb_switch_add(struct tb_switch *sw)
 		tb_sw_dbg(sw, "uid: %#llx\n", sw->uid);

 		tb_check_quirks(sw);
+		tb_nvm_validate(sw, nvm_upgrade);

 		ret = tb_switch_set_uuid(sw);
 		if (ret) {
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 5db76de40cc1..7f20f10352d9 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -28,6 +28,22 @@
 #define NVM_VERSION		0x08
 #define NVM_FLASH_SIZE		0x45

+/* ASMedia specific NVM offsets */
+#define NVM_Date	0x1c
+#define NVM_CUSTOMER_ID	0x28
+
+/* ASMedia specific validation mode */
+#define nvm_upgrade 0
+#define nvm_add 1
+#define nvm_write 2
+
+struct nvm_asmedia {
+	u32 date;
+	u32 customerID:16;
+	u32 version:8;
+	u32 reserved:8;
+};
+
 /**
  * struct tb_nvm - Structure holding NVM information
  * @dev: Owner of the NVM
@@ -57,6 +73,7 @@ struct tb_nvm {
 	size_t buf_data_size;
 	bool authenticating;
 	bool flushed;
+	struct nvm_asmedia nvm_asm;
 };

 enum tb_nvm_write_ops {
@@ -736,6 +753,7 @@ static inline void tb_domain_put(struct tb *tb)
 	put_device(&tb->dev);
 }

+int tb_nvm_validate(struct tb_switch *sw, unsigned int mode);
 struct tb_nvm *tb_nvm_alloc(struct device *dev);
 int tb_nvm_add_active(struct tb_nvm *nvm, size_t size, nvmem_reg_read_t reg_read);
 int tb_nvm_write_buf(struct tb_nvm *nvm, unsigned int offset, void *val,
--
2.34.1

