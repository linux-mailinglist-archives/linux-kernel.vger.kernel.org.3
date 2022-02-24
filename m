Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D36A4C306F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbiBXPzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236404AbiBXPz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:55:27 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7D017C407;
        Thu, 24 Feb 2022 07:54:56 -0800 (PST)
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id 454D540755CF;
        Thu, 24 Feb 2022 15:44:53 +0000 (UTC)
From:   Baskov Evgeniy <baskov@ispras.ru>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Baskov Evgeniy <baskov@ispras.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 1/2] libstub: declare DXE services table
Date:   Thu, 24 Feb 2022 18:43:29 +0300
Message-Id: <20220224154330.26564-2-baskov@ispras.ru>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224154330.26564-1-baskov@ispras.ru>
References: <20220224154330.26564-1-baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UEFI DXE services are not yet used in kernel code
but are required to manipulate page table memory
protection flags.

Add required declarations to use DXE services functions.

Signed-off-by: Baskov Evgeniy <baskov@ispras.ru>

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 03cb12775043..4614d54383ac 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -352,6 +352,11 @@ static inline u32 efi64_convert_status(efi_status_t status)
 						   runtime),		\
 				    func, __VA_ARGS__))
 
+#define efi_dxe_call(func, ...)						\
+	(efi_is_native()						\
+		? efi_dxe_table->func(__VA_ARGS__)			\
+		: __efi64_thunk_map(efi_dxe_table, func, __VA_ARGS__))
+
 #else /* CONFIG_EFI_MIXED */
 
 static inline bool efi_is_64bit(void)
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index edb77b0621ea..647f060c7318 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -36,6 +36,9 @@ extern bool efi_novamap;
 
 extern const efi_system_table_t *efi_system_table;
 
+typedef union efi_dxe_services_table efi_dxe_services_table_t;
+extern const efi_dxe_services_table_t *efi_dxe_table;
+
 efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 				   efi_system_table_t *sys_table_arg);
 
@@ -44,6 +47,7 @@ efi_status_t __efiapi efi_pe_entry(efi_handle_t handle,
 #define efi_is_native()		(true)
 #define efi_bs_call(func, ...)	efi_system_table->boottime->func(__VA_ARGS__)
 #define efi_rt_call(func, ...)	efi_system_table->runtime->func(__VA_ARGS__)
+#define efi_dxe_call(func, ...)	efi_dxe_table->func(__VA_ARGS__)
 #define efi_table_attr(inst, attr)	(inst->attr)
 #define efi_call_proto(inst, func, ...) inst->func(inst, ##__VA_ARGS__)
 
@@ -329,6 +333,55 @@ union efi_boot_services {
 	} mixed_mode;
 };
 
+/*
+ * EFI DXE Services table
+ */
+union efi_dxe_services_table {
+	struct {
+		efi_table_hdr_t hdr;
+		void *add_memory_space;
+		void *allocate_memory_space;
+		void *free_memory_space;
+		void *remove_memory_space;
+		void *get_memory_space_descriptor;
+		efi_status_t (__efiapi *set_memory_space_attributes)(efi_physical_addr_t,
+								     u64, u64);
+		void *get_memory_space_map;
+		void *add_io_space;
+		void *allocate_io_space;
+		void *free_io_space;
+		void *remove_io_space;
+		void *get_io_space_descriptor;
+		void *get_io_space_map;
+		void *dispatch;
+		void *schedule;
+		void *trust;
+		void *process_firmware_volume;
+		void *set_memory_space_capabilities;
+	};
+	struct {
+		efi_table_hdr_t hdr;
+		u32 add_memory_space;
+		u32 allocate_memory_space;
+		u32 free_memory_space;
+		u32 remove_memory_space;
+		u32 get_memory_space_descriptor;
+		u32 set_memory_space_attributes;
+		u32 get_memory_space_map;
+		u32 add_io_space;
+		u32 allocate_io_space;
+		u32 free_io_space;
+		u32 remove_io_space;
+		u32 get_io_space_descriptor;
+		u32 get_io_space_map;
+		u32 dispatch;
+		u32 schedule;
+		u32 trust;
+		u32 process_firmware_volume;
+		u32 set_memory_space_capabilities;
+	} mixed_mode;
+};
+
 typedef union efi_uga_draw_protocol efi_uga_draw_protocol_t;
 
 union efi_uga_draw_protocol {
diff --git a/include/linux/efi.h b/include/linux/efi.h
index ccd4d3f91c98..c5ad6245c7ec 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -383,6 +383,7 @@ void efi_native_runtime_setup(void);
 #define EFI_LOAD_FILE_PROTOCOL_GUID		EFI_GUID(0x56ec3091, 0x954c, 0x11d2,  0x8e, 0x3f, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
 #define EFI_LOAD_FILE2_PROTOCOL_GUID		EFI_GUID(0x4006c0c1, 0xfcb3, 0x403e,  0x99, 0x6d, 0x4a, 0x6c, 0x87, 0x24, 0xe0, 0x6d)
 #define EFI_RT_PROPERTIES_TABLE_GUID		EFI_GUID(0xeb66918a, 0x7eef, 0x402a,  0x84, 0x2e, 0x93, 0x1d, 0x21, 0xc3, 0x8a, 0xe9)
+#define EFI_DXE_SERVICES_TABLE_GUID		EFI_GUID(0x05ad34ba, 0x6f02, 0x4214,  0x95, 0x2e, 0x4d, 0xa0, 0x39, 0x8e, 0x2b, 0xb9)
 
 #define EFI_IMAGE_SECURITY_DATABASE_GUID	EFI_GUID(0xd719b2cb, 0x3d3a, 0x4596,  0xa3, 0xbc, 0xda, 0xd0, 0x0e, 0x67, 0x65, 0x6f)
 #define EFI_SHIM_LOCK_GUID			EFI_GUID(0x605dab50, 0xe046, 0x4300,  0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23)
@@ -435,6 +436,7 @@ typedef struct {
 } efi_config_table_type_t;
 
 #define EFI_SYSTEM_TABLE_SIGNATURE ((u64)0x5453595320494249ULL)
+#define EFI_DXE_SERVICES_TABLE_SIGNATURE ((u64)0x565245535f455844ULL)
 
 #define EFI_2_30_SYSTEM_TABLE_REVISION  ((2 << 16) | (30))
 #define EFI_2_20_SYSTEM_TABLE_REVISION  ((2 << 16) | (20))
-- 
2.35.1

