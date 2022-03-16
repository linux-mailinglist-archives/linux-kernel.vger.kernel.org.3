Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043774DB806
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 19:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355305AbiCPSj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 14:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240813AbiCPSjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 14:39:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91B11CB08
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 11:38:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 570AF618D2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DABDC340E9;
        Wed, 16 Mar 2022 18:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647455888;
        bh=B44gI3eqtidBdl9JbCiN+XY0RrXD4K8IvxUOi+CN0lA=;
        h=From:To:Cc:Subject:Date:From;
        b=U4+gfYSo5pOAJFR3Q5557xe3zQWxbZZMpGPHu9zPQrmq2GDKsofsw/2qFINdr43jC
         NfI59lmeNhax1dqpTn4TohBpt+XM9XbfNN9yAScjAT1K8ijxisG7p++6PCL+JC97Oy
         HjcF6TLq1trAmpP9/octZ2EVJ2jvBq6OvK4xcQsq7gnu+9U3sYTMCAdMxizyfSkedD
         pa8XybsJNKKqAxnxr5I1R+5fLOmZ7oZRmE6LJYANLl2tkCZsDgWiC5C8SlZnslm/l5
         eyLqp6Sar41lEBwr4oizuGcFfcYotxFHkLDcta4M5VhRidUBGL+Ub2FH99FoPUnoec
         DAqewCIY/uPbA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        James Morse <james.morse@arm.com>,
        Rich Wiley <rwiley@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: errata: avoid duplicate field initializer
Date:   Wed, 16 Mar 2022 19:37:45 +0100
Message-Id: <20220316183800.1546731-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The '.type' field is initialized both in place and in the macro
as reported by this W=1 warning:

arch/arm64/include/asm/cpufeature.h:281:9: error: initialized field overwritten [-Werror=override-init]
  281 |         (ARM64_CPUCAP_SCOPE_LOCAL_CPU | ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU)
      |         ^
arch/arm64/kernel/cpu_errata.c:136:17: note: in expansion of macro 'ARM64_CPUCAP_LOCAL_CPU_ERRATUM'
  136 |         .type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,                         \
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/arm64/kernel/cpu_errata.c:145:9: note: in expansion of macro 'ERRATA_MIDR_RANGE'
  145 |         ERRATA_MIDR_RANGE(m, var, r_min, var, r_max)
      |         ^~~~~~~~~~~~~~~~~
arch/arm64/kernel/cpu_errata.c:613:17: note: in expansion of macro 'ERRATA_MIDR_REV_RANGE'
  613 |                 ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A510, 0, 0, 2),
      |                 ^~~~~~~~~~~~~~~~~~~~~
arch/arm64/include/asm/cpufeature.h:281:9: note: (near initialization for 'arm64_errata[18].type')
  281 |         (ARM64_CPUCAP_SCOPE_LOCAL_CPU | ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU)
      |         ^

Remove the extranous initializer.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/cpu_errata.c | 1 -
 1 file changed, 1 deletion(-)

I see this warning on 5.17-rc8, but did not test it on linux-next,
which may already have a fix.

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index a337760f4423..ee7fbd13d030 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -609,7 +609,6 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 	{
 		.desc = "ARM erratum 2077057",
 		.capability = ARM64_WORKAROUND_2077057,
-		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A510, 0, 0, 2),
 	},
 #endif
-- 
2.29.2

