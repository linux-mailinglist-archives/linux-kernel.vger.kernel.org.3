Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99164CC087
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbiCCPA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiCCPAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:00:53 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A00DEA14
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 07:00:06 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j17so8338422wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 07:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iSr9Qn9Bz4exSvEIEKJ560kFdgKVqwLanGXFW+iTqRM=;
        b=jQ1YpTJ1Ll/9O3lki/NjFoQNdp1yiVr3Pt2tjAcuEzvv8bTqWSx7nP7Xnt8kv3QbyL
         vjHge3gDM7u7t+4ZBWzpEC5dvN9IuhJFgri2ZNF1XbvFmMq4emqLXYoHigyQpGH8PWHp
         yaesPGBBKpxzFjTf4+dUk4KFCCCvl+zcHdmGGPPUULnzRgw3l0/pIMZJzy8jrejt5oDj
         NOX/EGVI73j662MmjO9O3TnF/yVFefVCcgcP3ejkNfcDyRJg6FAJ7WgOz+8q2ACfYESd
         xJZy0Y1uNfJmg4KauRT70vX3pJAszb+aUF0oEGyQBt+Y7kv0BzaHEhOJAW0xQ0K8IaO9
         kskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iSr9Qn9Bz4exSvEIEKJ560kFdgKVqwLanGXFW+iTqRM=;
        b=sC1HfNDqXYMFVSEhgDNo31ZjF8an/c2pcAN2LuoCXE+LFcS6uafR5e5jVHnsvV0VeF
         tHDij7qUeAC6ZM6cv3YnbNNbGZSVTfJI4XB5C98NGGEqxdtFgZFj0Ki8mjk/czOk713O
         0sQM9TEFwlOTJVCtmVxV1l/f3swIbISiAqjTjydlC0SC5LDEZMp9dtj2Nu0eubKmSWuU
         jMgyrA/run4vEGVXoczzS/6DM7V7IZLlHPP9sxWj4chOaSryyOo/50lwOidgV0nV0aZH
         cs8lsYPJdKItORSVZNXQo8mTSEoRNR1B4SdiHvWsp3aKH5JkS7NbyBgSrVbjF/v2iBwh
         7tWQ==
X-Gm-Message-State: AOAM530S8ZJFw/9AJdmLiaIIBbaGi7tyC8bBwp/20ryG3nPx0/m/s1N7
        SPyQjYc42TTM2o5pJ1EvV7Z0DA==
X-Google-Smtp-Source: ABdhPJyEf2EHXO3BVWONDnMa14Ao/RzwdbENiJaMea2ppdwcPZbQ/wag664EK5SDdJHuReSkBZ+zAg==
X-Received: by 2002:adf:ec41:0:b0:1ed:beee:6f8f with SMTP id w1-20020adfec41000000b001edbeee6f8fmr26073123wrn.110.1646319605099;
        Thu, 03 Mar 2022 07:00:05 -0800 (PST)
Received: from localhost.localdomain ([49.206.7.17])
        by smtp.gmail.com with ESMTPSA id i15-20020a5d522f000000b001e85b14dadcsm2224166wra.5.2022.03.03.06.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:00:04 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Abner Chang <abner.chang@hpe.com>,
        Jessica Clarke <jrtc27@jrtc27.com>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH V2 1/1] riscv/efi_stub: Add support for RISCV_EFI_BOOT_PROTOCOL
Date:   Thu,  3 Mar 2022 20:29:44 +0530
Message-Id: <20220303145944.307321-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220303145944.307321-1-sunilvl@ventanamicro.com>
References: <20220303145944.307321-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the support for getting the boot hart ID in
Linux EFI stub using RISCV_EFI_BOOT_PROTOCOL. This protocol
is preferred method over existing DT based solution since it
works irrespective of DT or ACPI.

The specification of the protocol is hosted at:
https://github.com/riscv-non-isa/riscv-uefi

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/firmware/efi/libstub/efistub.h    |  7 ++++++
 drivers/firmware/efi/libstub/riscv-stub.c | 29 +++++++++++++++++++----
 include/linux/efi.h                       |  1 +
 3 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index edb77b0621ea..aced62a0907e 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -720,6 +720,13 @@ union efi_tcg2_protocol {
 	} mixed_mode;
 };
 
+struct riscv_efi_boot_protocol {
+	u64 revision;
+
+	efi_status_t (__efiapi * get_boot_hartid)(struct riscv_efi_boot_protocol *this,
+						  size_t *boot_hartid);
+};
+
 typedef union efi_load_file_protocol efi_load_file_protocol_t;
 typedef union efi_load_file_protocol efi_load_file2_protocol_t;
 
diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
index 9c460843442f..915ad209d004 100644
--- a/drivers/firmware/efi/libstub/riscv-stub.c
+++ b/drivers/firmware/efi/libstub/riscv-stub.c
@@ -23,7 +23,7 @@
 
 typedef void __noreturn (*jump_kernel_func)(unsigned int, unsigned long);
 
-static u32 hartid;
+static size_t hartid;
 
 static int get_boot_hartid_from_fdt(void)
 {
@@ -47,14 +47,33 @@ static int get_boot_hartid_from_fdt(void)
 	return 0;
 }
 
+static efi_status_t get_boot_hartid_from_efi(void)
+{
+	efi_guid_t boot_protocol_guid = RISCV_EFI_BOOT_PROTOCOL_GUID;
+	efi_status_t status;
+	struct riscv_efi_boot_protocol *boot_protocol;
+
+	status = efi_bs_call(locate_protocol, &boot_protocol_guid, NULL,
+			     (void **)&boot_protocol);
+	if (status == EFI_SUCCESS) {
+		status = efi_call_proto(boot_protocol,
+					get_boot_hartid, &hartid);
+	}
+	return status;
+}
+
 efi_status_t check_platform_features(void)
 {
 	int ret;
+	efi_status_t status;
 
-	ret = get_boot_hartid_from_fdt();
-	if (ret) {
-		efi_err("/chosen/boot-hartid missing or invalid!\n");
-		return EFI_UNSUPPORTED;
+	status = get_boot_hartid_from_efi();
+	if (status != EFI_SUCCESS) {
+		ret = get_boot_hartid_from_fdt();
+		if (ret) {
+			efi_err("/chosen/boot-hartid missing or invalid!\n");
+			return EFI_UNSUPPORTED;
+		}
 	}
 	return EFI_SUCCESS;
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index ccd4d3f91c98..9822c730207c 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -380,6 +380,7 @@ void efi_native_runtime_setup(void);
 #define EFI_CONSOLE_OUT_DEVICE_GUID		EFI_GUID(0xd3b36f2c, 0xd551, 0x11d4,  0x9a, 0x46, 0x00, 0x90, 0x27, 0x3f, 0xc1, 0x4d)
 #define APPLE_PROPERTIES_PROTOCOL_GUID		EFI_GUID(0x91bd12fe, 0xf6c3, 0x44fb,  0xa5, 0xb7, 0x51, 0x22, 0xab, 0x30, 0x3a, 0xe0)
 #define EFI_TCG2_PROTOCOL_GUID			EFI_GUID(0x607f766c, 0x7455, 0x42be,  0x93, 0x0b, 0xe4, 0xd7, 0x6d, 0xb2, 0x72, 0x0f)
+#define RISCV_EFI_BOOT_PROTOCOL_GUID		EFI_GUID(0xccd15fec, 0x6f73, 0x4eec,  0x83, 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
 #define EFI_LOAD_FILE_PROTOCOL_GUID		EFI_GUID(0x56ec3091, 0x954c, 0x11d2,  0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
 #define EFI_LOAD_FILE2_PROTOCOL_GUID		EFI_GUID(0x4006c0c1, 0xfcb3, 0x403e,  0x99, 0x6d, 0x4a, 0x6c, 0x87, 0x24, 0xe0, 0x6d)
 #define EFI_RT_PROPERTIES_TABLE_GUID		EFI_GUID(0xeb66918a, 0x7eef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)
-- 
2.25.1

