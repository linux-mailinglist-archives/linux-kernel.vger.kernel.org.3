Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B074D4D30
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244593AbiCJPHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245475AbiCJPFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:05:55 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F92C19BE6B;
        Thu, 10 Mar 2022 06:56:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 470DE16A3;
        Thu, 10 Mar 2022 06:55:43 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.195.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6AB533F7B4;
        Thu, 10 Mar 2022 06:55:41 -0800 (PST)
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
        linux-arm-kernel@lists.infradead.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v4 1/3] x86, ACPI: rename init_freq_invariance_cppc to arch_init_invariance_cppc
Date:   Thu, 10 Mar 2022 14:54:49 +0000
Message-Id: <20220310145451.15596-2-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.29.2.dirty
In-Reply-To: <20220310145451.15596-1-ionela.voinescu@arm.com>
References: <20220310145451.15596-1-ionela.voinescu@arm.com>
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
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
index 127b693273e3..9619385bf749 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -228,7 +228,7 @@ static inline void init_freq_invariance(bool secondary, bool cppc_ready)
 
 #ifdef CONFIG_ACPI_CPPC_LIB
 void init_freq_invariance_cppc(void);
-#define init_freq_invariance_cppc init_freq_invariance_cppc
+#define arch_init_invariance_cppc init_freq_invariance_cppc
 
 bool amd_set_max_freq_ratio(u64 *ratio);
 #else
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

