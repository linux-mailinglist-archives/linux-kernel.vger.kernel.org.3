Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877875A4A7B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 13:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbiH2Ljv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 07:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbiH2LjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 07:39:09 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA247765C;
        Mon, 29 Aug 2022 04:23:22 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u9-20020a17090a1f0900b001fde6477464so1201824pja.4;
        Mon, 29 Aug 2022 04:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=IihSJSDDowO+7Hn0wm0O2Udx5LTTxpSsaZAYxjkQZMA=;
        b=mrurtxCKjRbvgiSXp0BZxc3SecsUsUtHfvszB2XpEgHLk7ciWSjPP/cULR7lXe2D9w
         I+ZeT7QLIHz7+4+Xk7MY8MYLESlTUhK/fgafZCn1KE0SEXJXxRX9OuhOq92XC3vft2Cc
         pL52aDRyrQPiOITUteQfTXAn2oT0t7x/3XuBqv0b1mm7f9MkGDpSev2hvWeUhuLcLD9j
         whONK3CKbdt8abrxR756E1iMkveMav52r4MgQlgKexRegRK5V2uJ+T+SGRbCRj2FI52i
         qjEOBI5Ja/KlgSKaW9JWiDhhGEkbjOnls2YfgQT9zjrXGxVI8CszymGGhlT444QSHAh8
         Pshw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=IihSJSDDowO+7Hn0wm0O2Udx5LTTxpSsaZAYxjkQZMA=;
        b=GZxpCCv/WfOjNznIn+E04bB93t6pYR2qw6Xwk/2orByTph+N6vYOc+D/CMTt9Fh72J
         x5gTZ20m7VM6TKTQTP7/E9GjhCZn13ZMxQrKzd4bgPbR752ac5hn3BnMZ1E0hfgefbPK
         eja03TKyhA2bJPDOTtUQ8iPj3rQIdxvfARWVW/zBopll1Ia1XNSLHgwCqMZLWB1id525
         WzDt2CuUCnr4k+mqIWeHLJgzYDF4/PC02cX40z9k0ZAwh+vwfk0oTqPaog1HeKScrFRu
         rNR4Ag8USZrH5IUs4NaFAdf4PUiFWjG0Lll/NGV1uhyGl1b33Z8/bxyRz7CmMLTpwlBe
         ee1w==
X-Gm-Message-State: ACgBeo19qFbL7EGDrkfOHCUEvROuFrYwYc4U8Q2zgPyjZnr5adSx0/ev
        +Y130VwuHGXCl0acI5mO4GilDJQCDifOPw==
X-Google-Smtp-Source: AA6agR7X+jgSOHxui3jHgkXaVuCDpeBo2245nHZsMD1wkAjcRQVkcAt4vqK3/B5MukA6shhCsiY8kQ==
X-Received: by 2002:a17:903:40cf:b0:174:be28:6d3c with SMTP id t15-20020a17090340cf00b00174be286d3cmr4810569pld.126.1661771664581;
        Mon, 29 Aug 2022 04:14:24 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902680900b0015e8d4eb26esm7177973plk.184.2022.08.29.04.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 04:14:23 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
To:     gregkh@linuxfoundation.org, mario.limonciello@amd.com,
        mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw
Subject: [PATCH v7 3/3] thunderbolt: To extend ASMedia NVM formats.
Date:   Mon, 29 Aug 2022 19:10:59 +0800
Message-Id: <20220829111059.665305-4-chensiying21@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220829111059.665305-1-chensiying21@gmail.com>
References: <20220829111059.665305-1-chensiying21@gmail.com>
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

The patch add ASMedia NVM formats. And add tb_switch_nvm_upgradeable()
to enable firmware upgrade.

Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
---
Add ASMedia NVM formats. And fix asmedia_nvm_version() part of code so
that easier to read.

 drivers/thunderbolt/nvm.c    | 68 ++++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/switch.c |  3 ++
 drivers/thunderbolt/tb.h     |  1 +
 3 files changed, 72 insertions(+)

diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
index 91c8848b4d2e..c69db5b65f7d 100644
--- a/drivers/thunderbolt/nvm.c
+++ b/drivers/thunderbolt/nvm.c
@@ -15,16 +15,25 @@
 /* Switch NVM support */
 #define NVM_CSS		0x10

+/* Vendor ID of the Router. It's assigned by the USB-IF */
+#define ROUTER_VENDOR_ID_ASMEDIA 0x174c
+
+/* ASMedia specific NVM offsets */
+#define ASMEDIA_NVM_DATE	0x1c
+#define ASMEDIA_NVM_VERSION	0x28
+
 static DEFINE_IDA(nvm_ida);

 /**
  * struct tb_nvm_vendor_ops - Vendor NVM specific operations
  * @read_version: Used NVM read get Firmware version.
  * @validate: Vendors have their validate method before NVM write.
+ * @nvm_upgrade: Enable NVM upgrade.
  */
 struct tb_nvm_vendor_ops {
 	int (*read_version)(struct tb_switch *sw);
 	int (*validate)(struct tb_switch *sw);
+	void (*nvm_upgrade)(struct tb_switch *sw);
 };

 static inline int nvm_read(struct tb_switch *sw, unsigned int address,
@@ -128,11 +137,49 @@ static int intel_nvm_validate(struct tb_switch *sw)
 	return 0;
 }

+static int asmedia_nvm_version(struct tb_switch *sw)
+{
+	struct tb_nvm *nvm = sw->nvm;
+	u32 val;
+	int ret;
+
+	/* ASMedia get version and date format is xxxxxx.xxxxxx */
+	ret = nvm_read(sw, ASMEDIA_NVM_VERSION, &val, sizeof(val));
+	if (ret)
+		return ret;
+
+	nvm->major = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
+
+	ret = nvm_read(sw, ASMEDIA_NVM_DATE, &val, sizeof(val));
+	if (ret)
+		return ret;
+
+	nvm->minor = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
+
+	/*
+	 * Asmedia NVM size fixed on 512K. We currently have no plan
+	 * to increase size in the future.
+	 */
+	nvm->nvm_size = SZ_512K;
+
+	return 0;
+}
+
+static void tb_switch_set_nvm_upgrade(struct tb_switch *sw)
+{
+	sw->no_nvm_upgrade = false;
+}
+
 static const struct tb_nvm_vendor_ops intel_switch_nvm_ops = {
 	.read_version = intel_nvm_version,
 	.validate = intel_nvm_validate,
 };

+static const struct tb_nvm_vendor_ops asmedia_switch_nvm_ops = {
+	.nvm_upgrade = tb_switch_set_nvm_upgrade,
+	.read_version = asmedia_nvm_version,
+};
+
 struct switch_nvm_vendor {
 	u16 vendor;
 	const struct tb_nvm_vendor_ops *vops;
@@ -143,6 +190,27 @@ static const struct switch_nvm_vendor switch_nvm_vendors[] = {
 	{ 0x8087, &intel_switch_nvm_ops },
 };

+/**
+ * tb_switch_nvm_upgradeable() - Enable NVM upgrade of a switch
+ * @sw: Switch whose NVM upgrade to enable
+ *
+ * This function must be called before creating the switch devices, it will
+ * make the no_active NVM device visible.
+ */
+void tb_switch_nvm_upgradeable(struct tb_switch *sw)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(switch_nvm_vendors); i++) {
+		const struct switch_nvm_vendor *v = &switch_nvm_vendors[i];
+
+		if (v->vendor == sw->config.vendor_id) {
+			if (v->vops->nvm_upgrade)
+				v->vops->nvm_upgrade(sw);
+		}
+	}
+}
+
 /**
  * tb_switch_nvm_validate() - Validate NVM image
  * @switch: Switch to NVM write
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 2dbfd75202bf..f8dc18f6c5c8 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2822,6 +2822,9 @@ int tb_switch_add(struct tb_switch *sw)
 			return ret;
 	}

+	/* Enable the NVM firmware upgrade */
+	tb_switch_nvm_upgradeable(sw);
+
 	ret = device_add(&sw->dev);
 	if (ret) {
 		dev_err(&sw->dev, "failed to add device: %d\n", ret);
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 9cf62d5f25d2..642af7473851 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -773,6 +773,7 @@ int tb_switch_reset(struct tb_switch *sw);
 int tb_switch_wait_for_bit(struct tb_switch *sw, u32 offset, u32 bit,
 			   u32 value, int timeout_msec);
 int tb_switch_nvm_validate(struct tb_switch *sw);
+void tb_switch_nvm_upgradeable(struct tb_switch *sw);
 void tb_sw_set_unplugged(struct tb_switch *sw);
 struct tb_port *tb_switch_find_port(struct tb_switch *sw,
				    enum tb_port_type type);
--
2.34.1

