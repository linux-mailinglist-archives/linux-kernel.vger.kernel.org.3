Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9A557AD81
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241924AbiGTCBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241092AbiGTCBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:01:17 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C5E24B0F0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:01:16 -0700 (PDT)
Received: from localhost.localdomain.localdomain (unknown [10.2.5.46])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn9DeYddirMYpAA--.14711S3;
        Wed, 20 Jul 2022 10:01:05 +0800 (CST)
From:   Jianmin Lv <lvjianmin@loongson.cn>
To:     Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V17 01/13] LoongArch: Provisionally add ACPICA data structures
Date:   Wed, 20 Jul 2022 10:00:49 +0800
Message-Id: <1658282461-35489-2-git-send-email-lvjianmin@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1658282461-35489-1-git-send-email-lvjianmin@loongson.cn>
References: <1658282461-35489-1-git-send-email-lvjianmin@loongson.cn>
X-CM-TRANSID: AQAAf9Dxn9DeYddirMYpAA--.14711S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXF13WrykGr4rKw43uFWkCrg_yoWrZw4fpF
        WDC343K3yUXFWfKw1aqay8A3W3JFyrAFn7Xws3Ga43JrnFgrWUZF4ktr17GFZ5ta1rKay5
        Zr10v3W5Wa17CrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcx
        kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
        6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
        Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k20xvY0x0EwIxG
        rwCF04k20xvE74AGY7Cv6cx26ryrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0J
        UdHUDUUUUU=
X-CM-SenderInfo: 5oymxthqpl0qxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

The LoongArch architecture is using ACPI, but the spec containing
the required updates still is in an unreleased state.

Instead of preventing the inclusion of the IRQ support into the
kernel, add the missing bits to the arch-specific parts of
the ACPICA support.

Once the ACPICA bits are updated to the version that supports
LoongArch, these bits can eventually be removed.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn>
---
 arch/loongarch/include/asm/acpi.h | 142 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/arch/loongarch/include/asm/acpi.h b/arch/loongarch/include/asm/acpi.h
index 62044cd..c510821 100644
--- a/arch/loongarch/include/asm/acpi.h
+++ b/arch/loongarch/include/asm/acpi.h
@@ -31,6 +31,148 @@ static inline bool acpi_has_cpu_in_madt(void)
 
 extern struct list_head acpi_wakeup_device_list;
 
+/*
+ * Temporary definitions until the core ACPICA code gets updated (see
+ * 1656837932-18257-1-git-send-email-lvjianmin@loongson.cn and its
+ * follow-ups for the "rationale").
+ *
+ * Once the "legal reasons" are cleared and that the code is merged,
+ * this can be dropped entierely.
+ */
+#if (ACPI_CA_VERSION == 0x20220331 && !defined(LOONGARCH_ACPICA_EXT))
+
+#define LOONGARCH_ACPICA_EXT	1
+
+#define	ACPI_MADT_TYPE_CORE_PIC		17
+#define	ACPI_MADT_TYPE_LIO_PIC		18
+#define	ACPI_MADT_TYPE_HT_PIC		19
+#define	ACPI_MADT_TYPE_EIO_PIC		20
+#define	ACPI_MADT_TYPE_MSI_PIC		21
+#define	ACPI_MADT_TYPE_BIO_PIC		22
+#define	ACPI_MADT_TYPE_LPC_PIC		23
+
+/* Values for Version field above */
+
+enum acpi_madt_core_pic_version {
+	ACPI_MADT_CORE_PIC_VERSION_NONE = 0,
+	ACPI_MADT_CORE_PIC_VERSION_V1 = 1,
+	ACPI_MADT_CORE_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_lio_pic_version {
+	ACPI_MADT_LIO_PIC_VERSION_NONE = 0,
+	ACPI_MADT_LIO_PIC_VERSION_V1 = 1,
+	ACPI_MADT_LIO_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_eio_pic_version {
+	ACPI_MADT_EIO_PIC_VERSION_NONE = 0,
+	ACPI_MADT_EIO_PIC_VERSION_V1 = 1,
+	ACPI_MADT_EIO_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_ht_pic_version {
+	ACPI_MADT_HT_PIC_VERSION_NONE = 0,
+	ACPI_MADT_HT_PIC_VERSION_V1 = 1,
+	ACPI_MADT_HT_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_bio_pic_version {
+	ACPI_MADT_BIO_PIC_VERSION_NONE = 0,
+	ACPI_MADT_BIO_PIC_VERSION_V1 = 1,
+	ACPI_MADT_BIO_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_msi_pic_version {
+	ACPI_MADT_MSI_PIC_VERSION_NONE = 0,
+	ACPI_MADT_MSI_PIC_VERSION_V1 = 1,
+	ACPI_MADT_MSI_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+enum acpi_madt_lpc_pic_version {
+	ACPI_MADT_LPC_PIC_VERSION_NONE = 0,
+	ACPI_MADT_LPC_PIC_VERSION_V1 = 1,
+	ACPI_MADT_LPC_PIC_VERSION_RESERVED = 2	/* 2 and greater are reserved */
+};
+
+#pragma pack(1)
+
+/* Core Interrupt Controller */
+
+struct acpi_madt_core_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u32 processor_id;
+	u32 core_id;
+	u32 flags;
+};
+
+/* Legacy I/O Interrupt Controller */
+
+struct acpi_madt_lio_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 address;
+	u16 size;
+	u8 cascade[2];
+	u32 cascade_map[2];
+};
+
+/* Extend I/O Interrupt Controller */
+
+struct acpi_madt_eio_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u8 cascade;
+	u8 node;
+	u64 node_map;
+};
+
+/* HT Interrupt Controller */
+
+struct acpi_madt_ht_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 address;
+	u16 size;
+	u8 cascade[8];
+};
+
+/* Bridge I/O Interrupt Controller */
+
+struct acpi_madt_bio_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 address;
+	u16 size;
+	u16 id;
+	u16 gsi_base;
+};
+
+/* MSI Interrupt Controller */
+
+struct acpi_madt_msi_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 msg_address;
+	u32 start;
+	u32 count;
+};
+
+/* LPC Interrupt Controller */
+
+struct acpi_madt_lpc_pic {
+	struct acpi_subtable_header header;
+	u8 version;
+	u64 address;
+	u16 size;
+	u8 cascade;
+};
+
+#pragma pack()
+
+#endif
+
 #endif /* !CONFIG_ACPI */
 
 #define ACPI_TABLE_UPGRADE_MAX_PHYS ARCH_LOW_ADDRESS_LIMIT
-- 
1.8.3.1

