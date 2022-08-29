Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1CF5A5645
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiH2Vhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiH2Vhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:37:36 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E32280F50;
        Mon, 29 Aug 2022 14:37:34 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9F8EB8211EE;
        Mon, 29 Aug 2022 21:29:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a210 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 1830E8214F4;
        Mon, 29 Aug 2022 21:29:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1661808562; a=rsa-sha256;
        cv=none;
        b=889wU+ypFOzUxMo8tE7wsNg3AIyIc/z3cecJyw1ISG+NPwtjl+h/wTnEd5K2TzIi0NMf5a
        B3OnPpWSdDJsv8NGNvKvgsjALhGxAdwJtoXP2pkRTPmZZpxTKB/1MbtMb+hNnViynGXU1a
        FhZG3r1VNOeQEvplpdBV53hf5Ak9tS7fvqEARbZMSk3UHCXNFTgGrnvz6L4/8/DjL9UQfG
        U+TVlYpfFHU96osU991mXYk2xQSC0yu0wkFJTqRfkjZ0BQW9V1OkjrCQg/5C7b6P4zXxVr
        cItJfpBehRIE+hmPetg1eWyH/C4AtxZOpf6OPa7InPlouRnp3aFlIpT4pSJC4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1661808562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=wPrGN55jL4h8TZE8TdRCRKUBj7LPUTZEAsucC9jQbN4=;
        b=fHIx0ajVzaapgHX+wHAy9i3SSOOpjYSGaygTwB1lTiPccD0mI/aSoFb49HaJxbSX/j1ISg
        V1/rvlDaEZvUnFRxs2yB9+gkc4ylnB5uk3Tz5zANwIzCyrkjSbeqQY0EXYL1i6GBYBwcit
        GFXQ8kdR8pyuZ1LxShT2ILU95KNjLN1mJVGjedzVaRmUg5YaycMchDtaEFUYbpR1FmkwVm
        7BQ1ulyvigt4GoHxBoKAMN66oedQaegs6reEa1C89qBIbEez6jgsHyKgyTEzc3YhC6C+ey
        /Us23SboeeHKM8d/LsCrNUf22DL7tPZmLVQdyJh8uPf0Cuztdn0Ns7b4Tq/NAQ==
ARC-Authentication-Results: i=1;
        rspamd-75b4464bd-sv695;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Descriptive-Arithmetic: 79cfb0b32f60848c_1661808562489_673253421
X-MC-Loop-Signature: 1661808562489:2375646447
X-MC-Ingress-Time: 1661808562489
Received: from pdx1-sub0-mail-a210 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.123.39.217 (trex/6.7.1);
        Mon, 29 Aug 2022 21:29:22 +0000
Received: from offworld.. (unknown [104.36.31.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a210 (Postfix) with ESMTPSA id 4MGk8x0m25zPZ;
        Mon, 29 Aug 2022 14:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1661808561;
        bh=wPrGN55jL4h8TZE8TdRCRKUBj7LPUTZEAsucC9jQbN4=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=VrOY05yZROs1ioLx4CRmSRE9GcO9LhV1i39YKM/9L2L7CgMCeigurV/Za/8wK+sF1
         gD/yJ7XqCeqQ8ao12sQa9O4nfu7CVsCIR7Yjgo9kVQC0lAv5YRClls7fEjsO6lu7QH
         K64O2ulQfuRhkMaN314IyQII0OfEgrQkzODS6h8wtc8CobKDrdZwrKMKak95QI7ixc
         o7caov7A0AVGadItP313BMl75g2keZxcPYDElQJWus2X55LE3hHGI0fW0ATZkoCR1e
         qb8Uk/uewGrNKhNrLQoGi2jC4+YX/qtepWMwRXcY9Y7d53Rt7qh9YMLiQ2gug5Im9X
         7IysfS+wHKuPw==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     x86@kernel.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        peterz@infradead.org, bp@alien8.de, akpm@linux-foundation.org,
        dave.jiang@intel.com, Jonathan.Cameron@huawei.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        a.manzanares@samsung.com, linux-kernel@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH -next] memregion: Add arch_flush_memregion() interface
Date:   Mon, 29 Aug 2022 14:29:18 -0700
Message-Id: <20220829212918.4039240-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CXL security features, global CPU cache flushing nvdimm requirements
are no longer specific to that subsystem, even beyond the scope of
security_ops. CXL will need such semantics for features not necessarily
limited to persistent memory.

The functionality this is enabling is to be able to instantaneously
secure erase potentially terabytes of memory at once and the kernel
needs to be sure that none of the data from before the secure is still
present in the cache. It is also used when unlocking a memory device
where speculative reads and firmware accesses could have cached poison
from before the device was unlocked.

This capability is typically only used once per-boot (for unlock), or
once per bare metal provisioning event (secure erase), like when handing
off the system to another tenant or decommissioning a device.

Users must first call arch_has_flush_memregion() to know whether this
functionality is available on the architecture. Only enable it on x86-64
via the wbinvd() hammer.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---

Changes from v2 (https://lore.kernel.org/all/20220819171024.1766857-1-dave@stgolabs.net/):
- Redid to use memregion based interfaces + VMM check on x86 (Dan)
- Restricted the flushing to x86-64.

Note: Since we still are dealing with a physical "range" at this level,
added the spa range for nfit even though this is unused.

 arch/x86/Kconfig             |  1 +
 arch/x86/mm/pat/set_memory.c | 14 +++++++++++
 drivers/acpi/nfit/intel.c    | 45 ++++++++++++++++++------------------
 include/linux/memregion.h    | 25 ++++++++++++++++++++
 lib/Kconfig                  |  3 +++
 5 files changed, 65 insertions(+), 23 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f9920f1341c8..594e6b6a4925 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -81,6 +81,7 @@ config X86
 	select ARCH_HAS_KCOV			if X86_64
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
+	select ARCH_HAS_MEMREGION_INVALIDATE    if X86_64
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PTE_DEVMAP		if X86_64
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 1abd5438f126..18463cb704fb 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -330,6 +330,20 @@ void arch_invalidate_pmem(void *addr, size_t size)
 EXPORT_SYMBOL_GPL(arch_invalidate_pmem);
 #endif
 
+#ifdef CONFIG_ARCH_HAS_MEMREGION_INVALIDATE
+bool arch_has_flush_memregion(void)
+{
+	return !cpu_feature_enabled(X86_FEATURE_HYPERVISOR);
+}
+EXPORT_SYMBOL(arch_has_flush_memregion);
+
+void arch_flush_memregion(phys_addr_t phys, resource_size_t size)
+{
+	wbinvd_on_all_cpus();
+}
+EXPORT_SYMBOL(arch_flush_memregion);
+#endif
+
 static void __cpa_flush_all(void *arg)
 {
 	unsigned long cache = (unsigned long)arg;
diff --git a/drivers/acpi/nfit/intel.c b/drivers/acpi/nfit/intel.c
index 8dd792a55730..32e622f51cde 100644
--- a/drivers/acpi/nfit/intel.c
+++ b/drivers/acpi/nfit/intel.c
@@ -3,6 +3,7 @@
 #include <linux/libnvdimm.h>
 #include <linux/ndctl.h>
 #include <linux/acpi.h>
+#include <linux/memregion.h>
 #include <asm/smp.h>
 #include "intel.h"
 #include "nfit.h"
@@ -190,12 +191,11 @@ static int intel_security_change_key(struct nvdimm *nvdimm,
 	}
 }
 
-static void nvdimm_invalidate_cache(void);
-
 static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
 		const struct nvdimm_key_data *key_data)
 {
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
+	struct acpi_nfit_system_address *spa = nfit_mem->spa_dcr;
 	struct {
 		struct nd_cmd_pkg pkg;
 		struct nd_intel_unlock_unit cmd;
@@ -213,6 +213,9 @@ static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
 	if (!test_bit(NVDIMM_INTEL_UNLOCK_UNIT, &nfit_mem->dsm_mask))
 		return -ENOTTY;
 
+	if (!arch_has_flush_memregion())
+		return -EINVAL;
+
 	memcpy(nd_cmd.cmd.passphrase, key_data->data,
 			sizeof(nd_cmd.cmd.passphrase));
 	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
@@ -228,7 +231,7 @@ static int __maybe_unused intel_security_unlock(struct nvdimm *nvdimm,
 	}
 
 	/* DIMM unlocked, invalidate all CPU caches before we read it */
-	nvdimm_invalidate_cache();
+	arch_flush_memregion(spa->address, spa->length);
 
 	return 0;
 }
@@ -279,6 +282,7 @@ static int __maybe_unused intel_security_erase(struct nvdimm *nvdimm,
 {
 	int rc;
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
+	struct acpi_nfit_system_address *spa = nfit_mem->spa_dcr;
 	unsigned int cmd = ptype == NVDIMM_MASTER ?
 		NVDIMM_INTEL_MASTER_SECURE_ERASE : NVDIMM_INTEL_SECURE_ERASE;
 	struct {
@@ -297,8 +301,11 @@ static int __maybe_unused intel_security_erase(struct nvdimm *nvdimm,
 	if (!test_bit(cmd, &nfit_mem->dsm_mask))
 		return -ENOTTY;
 
+	if (!arch_has_flush_memregion())
+		return -EINVAL;
+
 	/* flush all cache before we erase DIMM */
-	nvdimm_invalidate_cache();
+	arch_flush_memregion(spa->address, spa->length);
 	memcpy(nd_cmd.cmd.passphrase, key->data,
 			sizeof(nd_cmd.cmd.passphrase));
 	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
@@ -318,7 +325,7 @@ static int __maybe_unused intel_security_erase(struct nvdimm *nvdimm,
 	}
 
 	/* DIMM erased, invalidate all CPU caches before we read it */
-	nvdimm_invalidate_cache();
+	arch_flush_memregion(spa->address, spa->length);
 	return 0;
 }
 
@@ -326,6 +333,7 @@ static int __maybe_unused intel_security_query_overwrite(struct nvdimm *nvdimm)
 {
 	int rc;
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
+	struct acpi_nfit_system_address *spa = nfit_mem->spa_dcr;
 	struct {
 		struct nd_cmd_pkg pkg;
 		struct nd_intel_query_overwrite cmd;
@@ -341,6 +349,9 @@ static int __maybe_unused intel_security_query_overwrite(struct nvdimm *nvdimm)
 	if (!test_bit(NVDIMM_INTEL_QUERY_OVERWRITE, &nfit_mem->dsm_mask))
 		return -ENOTTY;
 
+	if (!arch_has_flush_memregion())
+		return -EINVAL;
+
 	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
 	if (rc < 0)
 		return rc;
@@ -355,7 +366,7 @@ static int __maybe_unused intel_security_query_overwrite(struct nvdimm *nvdimm)
 	}
 
 	/* flush all cache before we make the nvdimms available */
-	nvdimm_invalidate_cache();
+	arch_flush_memregion(spa->address, spa->length);
 	return 0;
 }
 
@@ -364,6 +375,7 @@ static int __maybe_unused intel_security_overwrite(struct nvdimm *nvdimm,
 {
 	int rc;
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
+	struct acpi_nfit_system_address *spa = nfit_mem->spa_dcr;
 	struct {
 		struct nd_cmd_pkg pkg;
 		struct nd_intel_overwrite cmd;
@@ -380,8 +392,11 @@ static int __maybe_unused intel_security_overwrite(struct nvdimm *nvdimm,
 	if (!test_bit(NVDIMM_INTEL_OVERWRITE, &nfit_mem->dsm_mask))
 		return -ENOTTY;
 
+	if (!arch_has_flush_memregion())
+		return -EINVAL;
+
 	/* flush all cache before we erase DIMM */
-	nvdimm_invalidate_cache();
+	arch_flush_memregion(spa->address, spa->length);
 	memcpy(nd_cmd.cmd.passphrase, nkey->data,
 			sizeof(nd_cmd.cmd.passphrase));
 	rc = nvdimm_ctl(nvdimm, ND_CMD_CALL, &nd_cmd, sizeof(nd_cmd), NULL);
@@ -401,22 +416,6 @@ static int __maybe_unused intel_security_overwrite(struct nvdimm *nvdimm,
 	}
 }
 
-/*
- * TODO: define a cross arch wbinvd equivalent when/if
- * NVDIMM_FAMILY_INTEL command support arrives on another arch.
- */
-#ifdef CONFIG_X86
-static void nvdimm_invalidate_cache(void)
-{
-	wbinvd_on_all_cpus();
-}
-#else
-static void nvdimm_invalidate_cache(void)
-{
-	WARN_ON_ONCE("cache invalidation required after unlock\n");
-}
-#endif
-
 static const struct nvdimm_security_ops __intel_security_ops = {
 	.get_flags = intel_security_flags,
 	.freeze = intel_security_freeze,
diff --git a/include/linux/memregion.h b/include/linux/memregion.h
index c04c4fd2e209..c35201c0696f 100644
--- a/include/linux/memregion.h
+++ b/include/linux/memregion.h
@@ -20,4 +20,29 @@ static inline void memregion_free(int id)
 {
 }
 #endif
+
+/*
+ * Device memory technologies like NVDIMM and CXL have events like
+ * secure erase and dynamic region provision that can invalidate an
+ * entire physical memory address range at once. Limit that
+ * functionality to architectures that have an efficient way to
+ * writeback and invalidate potentially terabytes of memory at once.
+ *
+ * To ensure this, users must first call arch_has_flush_memregion()
+ * before anything, to verify the operation is feasible.
+ */
+#ifdef CONFIG_ARCH_HAS_MEMREGION_INVALIDATE
+void arch_flush_memregion(phys_addr_t phys, resource_size_t size);
+bool arch_has_flush_memregion(void);
+#else
+static inline bool arch_has_flush_memregion(void)
+{
+       return false;
+}
+static inline void arch_flush_memregion(phys_addr_t phys, resource_size_t size)
+{
+	WARN_ON_ONCE("cache invalidation required");
+}
+#endif
+
 #endif /* _MEMREGION_H_ */
diff --git a/lib/Kconfig b/lib/Kconfig
index dc1ab2ed1dc6..8319e7731e7b 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -662,6 +662,9 @@ config ARCH_HAS_PMEM_API
 config MEMREGION
 	bool
 
+config ARCH_HAS_MEMREGION_INVALIDATE
+       bool
+
 config ARCH_HAS_MEMREMAP_COMPAT_ALIGN
 	bool
 
-- 
2.37.2

