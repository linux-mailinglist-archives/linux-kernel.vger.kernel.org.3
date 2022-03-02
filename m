Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F6B4CAD01
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244433AbiCBSKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244429AbiCBSKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:10:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1699775232;
        Wed,  2 Mar 2022 10:10:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2923139F;
        Wed,  2 Mar 2022 10:10:01 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.195.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C9CF43F73D;
        Wed,  2 Mar 2022 10:09:59 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sean Kelley <skelley@nvidia.com>
Cc:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/3] x86, ACPI: rename init_freq_invariance_cppc to arch_init_invariance_cppc
Date:   Wed,  2 Mar 2022 18:09:11 +0000
Message-Id: <20220302180913.13229-2-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.29.2.dirty
In-Reply-To: <20220302180913.13229-1-ionela.voinescu@arm.com>
References: <20220302180913.13229-1-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_freq_invariance_cppc() was called in acpi_cppc_processor_probe(),
after CPU performance information and controls were populated from the
per-cpu _CPC objects.

But these _CPC objects provide information that helps with both CPU
(u-arch) and frequency invariance. Therefore, change the function name
to a more generic one, while adding the arch_ prefix, as this function
is expected to be defined differently by different architectures.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Giovanni Gherdovich <ggherdovich@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 arch/x86/include/asm/topology.h | 2 +-
 drivers/acpi/cppc_acpi.c        | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 2f0b6be8eaab..5ec70f186775 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -223,7 +223,7 @@ static inline void arch_set_max_freq_ratio(bool turbo_disabled)
 
 #if defined(CONFIG_ACPI_CPPC_LIB) && defined(CONFIG_SMP)
 void init_freq_invariance_cppc(void);
-#define init_freq_invariance_cppc init_freq_invariance_cppc
+#define arch_init_invariance_cppc init_freq_invariance_cppc
 #endif
 
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 866560cbb082..bfd142ab4e07 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -633,8 +633,8 @@ static bool is_cppc_supported(int revision, int num_ent)
  *  )
  */
 
-#ifndef init_freq_invariance_cppc
-static inline void init_freq_invariance_cppc(void) { }
+#ifndef arch_init_invariance_cppc
+static inline void arch_init_invariance_cppc(void) { }
 #endif
 
 /**
@@ -816,7 +816,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 		goto out_free;
 	}
 
-	init_freq_invariance_cppc();
+	arch_init_invariance_cppc();
 
 	kfree(output.pointer);
 	return 0;
-- 
2.25.1

