Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD4C59E1D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 14:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355034AbiHWKjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 06:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355314AbiHWKXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 06:23:30 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188A1832C9;
        Tue, 23 Aug 2022 02:04:30 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id 2so12279887pll.0;
        Tue, 23 Aug 2022 02:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=S5y4sNEy9Nr+OHl5m3Guqy3MOlBJRFQsA1XbacwSLwg=;
        b=S49c4PSlq97BcWBHeWy5uWbt+gRhYay4N1krmq8YMJdzvSwoQbzPBSbhoHZhl3el1S
         WdQWm44042GXzuOqLDCxhOTU1z32JvFe4shqFGVNY3S3kjdLP10ZHQ/pVBBSm7CyU7t2
         3CEeex3jGkGqaDKy/34JEZ5grCXmnlQF5yL/SxqVTW9BnuFQ8EfUpTiv5tlB8nqW9Wxs
         Bfe5B6w2DeGIgvuDR5FDRE28mpT1ly9XHlgjb2Vs+mpgG2SAEn4+Boq0GTjiEWX/Ifp6
         vazFGs6QUZ0MOISfKF6bfFUbCmGQNcMY3o4SOTnUx6JflMPcw3ksMurT3r3lAPcR9glK
         IvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=S5y4sNEy9Nr+OHl5m3Guqy3MOlBJRFQsA1XbacwSLwg=;
        b=GA39ImdapnahUGRzkbzaEgHm6TN8+EMHq8GZgSMTLEcGibCVNcj5uDpgO0fFpmHYbC
         pr8HS7gvc3TG3D718lcyeJrqS76Dh5IwC9+78/XXSd6DpsrTMia0TmpqK2s4yft/kM6J
         czmoZImlSS+YKIE19xbgcGOPe9RopFEZt2LPA0sV/+hen0FFzTaHLTkKzt9kySz85ulO
         48QGEkeHYI9o1OHv43RokgCT4erX0YSsE2be560qw/NutTmz0W/ELBpvkK5cURXLbLK1
         ic/ct4/KLbZfvwIuU+qctX5VxmBOvHlmiuzxgZZ+DMLMVzGsaqxYO4W1NFd7CnTb1JXk
         dgYA==
X-Gm-Message-State: ACgBeo1pKQks+qtNXgb3jCLrzErDmRjuYj5rcegHlQ5Fbt376W1nFhPu
        8MaRQJq74F8yGCzFqsBqQtk=
X-Google-Smtp-Source: AA6agR6ECy3AZFvXRS2pB2DuO2W3+cRCpU0SVOuedTf9jbHIl72AsJGAj6+AlKHRmMlIPgZ3RP3umA==
X-Received: by 2002:a17:90a:e018:b0:1fa:c9c4:9e01 with SMTP id u24-20020a17090ae01800b001fac9c49e01mr2405819pjy.29.1661245469880;
        Tue, 23 Aug 2022 02:04:29 -0700 (PDT)
Received: from sw.. (220-128-98-63.hinet-ip.hinet.net. [220.128.98.63])
        by smtp.gmail.com with ESMTPSA id d5-20020a170903230500b00172ccb3f4ebsm6709333plh.160.2022.08.23.02.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 02:04:29 -0700 (PDT)
From:   Szuying Chen <chensiying21@gmail.com>
To:     gregkh@linuxfoundation.org, mario.limonciello@amd.com,
        mika.westerberg@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, YehezkelShB@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yd_Tseng@asmedia.com.tw, Chloe_Chen@asmedia.com.tw,
        Richard_Hsu@asmedia.com.tw
Subject: [PATCH 2/2] thunderbolt: thunderbolt: add nvm specific operations for
Date:   Tue, 23 Aug 2022 17:04:23 +0800
Message-Id: <20220823090423.5249-1-chensiying21@gmail.com>
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

The patch depends on patch 1/2. Add nvm specific operations for ASMedia.
And add tb_switch_nvm_upgradable() of enable firmware upgrade.

Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
---
 drivers/thunderbolt/nvm.c    | 46 ++++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/switch.c |  3 +++
 drivers/thunderbolt/tb.h     |  2 ++
 3 files changed, 51 insertions(+)

diff --git a/drivers/thunderbolt/nvm.c b/drivers/thunderbolt/nvm.c
index 5c7c2a284497..d2ef22f8b19b 100644
--- a/drivers/thunderbolt/nvm.c
+++ b/drivers/thunderbolt/nvm.c
@@ -15,6 +15,9 @@
 /* Switch NVM support */
 #define NVM_CSS		0x10

+/* ASMedia specific NVM offsets */
+#define ASMEDIA_NVM_VERSION	0x1c
+
 static DEFINE_IDA(nvm_ida);

 static inline int nvm_read(struct tb_switch *sw, unsigned int address,
@@ -116,11 +119,39 @@ static int intel_nvm_validate(struct tb_switch *sw)
 	return image_size;
 }

+static int asmedia_nvm_version(struct tb_switch *sw)
+{
+	struct tb_nvm *nvm = sw->nvm;
+	u64 val;
+	int ret;
+
+	ret = nvm_read(sw, ASMEDIA_NVM_VERSION, &val, sizeof(val));
+	if (ret)
+		return ret;
+
+	/* ASMedia NVM version show format include Firmware version and date xxxxxx.xxxxxx */
+	nvm->major = (((u8)val >> 0x18) << 0x10 | ((u8)(val >> 0x20)) << 0x8 | (u8)(val >> 0x28));
+	nvm->minor = (((u8)val) << 0x10 | ((u8)(val >> 0x8)) << 0x8 | (u8)(val >> 0x10));
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
 struct tb_nvm_vendor_ops intel_switch_nvm_ops = {
 	.version = intel_nvm_version,
 	.validate = intel_nvm_validate,
 };

+struct tb_nvm_vendor_ops asmedia_switch_nvm_ops = {
+	.nvm_upgrade = tb_switch_set_nvm_upgrade,
+	.version = asmedia_nvm_version,
+};
+
 struct switch_nvm_vendor {
 	u16 vendor;
 	const struct tb_nvm_vendor_ops *vops;
@@ -129,8 +160,23 @@ struct switch_nvm_vendor {
 static const struct switch_nvm_vendor switch_nvm_vendors[] = {
 	{ 0x8086, &intel_switch_nvm_ops },
 	{ 0x8087, &intel_switch_nvm_ops },
+	{ 0x174c, &asmedia_switch_nvm_ops },
 };

+void tb_switch_nvm_upgradable(struct tb_switch *sw)
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
  * tb_switch_nvm_alloc() - alloc nvm and set nvm->vops to point
  * the vendor specific operations.
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index d257219cb66e..23df70290ca2 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2829,6 +2829,9 @@ int tb_switch_add(struct tb_switch *sw)
 			return ret;
 	}

+	/* Enable the NVM firmware upgrade for specific vendors */
+	tb_switch_nvm_upgradable(sw);
+
 	ret = device_add(&sw->dev);
 	if (ret) {
 		dev_err(&sw->dev, "failed to add device: %d\n", ret);
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 73ae2e093a92..8e2887e9c669 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -75,6 +75,7 @@ enum tb_nvm_write_ops {
 struct tb_nvm_vendor_ops {
 	int (*version)(struct tb_switch *sw);
 	int (*validate)(struct tb_switch *sw);
+	void (*nvm_upgrade)(struct tb_switch *sw);
 };

 #define TB_SWITCH_KEY_SIZE		32
@@ -748,6 +749,7 @@ static inline void tb_domain_put(struct tb *tb)
 	put_device(&tb->dev);
 }

+void tb_switch_nvm_upgradable(struct tb_switch *sw);
 struct tb_nvm *tb_switch_nvm_alloc(struct tb_switch *sw);
 struct tb_nvm *tb_nvm_alloc(struct device *dev);
 int tb_nvm_add_active(struct tb_nvm *nvm, size_t size, nvmem_reg_read_t reg_read);
--
2.34.1

