Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3068B4DE0C7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 19:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240024AbiCRSLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 14:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiCRSLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:11:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA002E842A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1C79B81747
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 18:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D4CC340E8;
        Fri, 18 Mar 2022 18:10:20 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc:     Rich Wiley <rwiley@nvidia.com>, James Morse <james.morse@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH] arm64: errata: avoid duplicate field initializer
Date:   Fri, 18 Mar 2022 18:10:18 +0000
Message-Id: <164762664708.829336.6118267245056806692.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220316183800.1546731-1-arnd@kernel.org>
References: <20220316183800.1546731-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2022 19:37:45 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The '.type' field is initialized both in place and in the macro
> as reported by this W=1 warning:
> 
> arch/arm64/include/asm/cpufeature.h:281:9: error: initialized field overwritten [-Werror=override-init]
>   281 |         (ARM64_CPUCAP_SCOPE_LOCAL_CPU | ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU)
>       |         ^
> arch/arm64/kernel/cpu_errata.c:136:17: note: in expansion of macro 'ARM64_CPUCAP_LOCAL_CPU_ERRATUM'
>   136 |         .type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,                         \
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/arm64/kernel/cpu_errata.c:145:9: note: in expansion of macro 'ERRATA_MIDR_RANGE'
>   145 |         ERRATA_MIDR_RANGE(m, var, r_min, var, r_max)
>       |         ^~~~~~~~~~~~~~~~~
> arch/arm64/kernel/cpu_errata.c:613:17: note: in expansion of macro 'ERRATA_MIDR_REV_RANGE'
>   613 |                 ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A510, 0, 0, 2),
>       |                 ^~~~~~~~~~~~~~~~~~~~~
> arch/arm64/include/asm/cpufeature.h:281:9: note: (near initialization for 'arm64_errata[18].type')
>   281 |         (ARM64_CPUCAP_SCOPE_LOCAL_CPU | ARM64_CPUCAP_OPTIONAL_FOR_LATE_CPU)
>       |         ^
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: errata: avoid duplicate field initializer
      https://git.kernel.org/arm64/c/316e46f65a54

-- 
Catalin

