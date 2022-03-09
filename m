Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A114D3D3D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 23:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiCIWnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 17:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238826AbiCIWno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 17:43:44 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C01C12631;
        Wed,  9 Mar 2022 14:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646865763; x=1678401763;
  h=from:to:cc:subject:date:message-id;
  bh=1tVzL02J/uPSeMguKb6BuoOk71zpDiImwextYpgASjA=;
  b=GdtrvGQ4cWKEmxmCKXN/EHn7n3eT3lswpHhIs2Mtz3ME1mifUb+n3/P5
   RKofmUQfOz/1F1KArH8jnv2eWzXmnEGm/zZ9P3mWGoGsHguiMwG/hMiFB
   8oR8Cl6/yRgBbkC+j2Y0ygXOt4TV+5nC5y7q+XLMteSOhmuJMs2nSzyBG
   A4Kb1ZVMS10jLZw1POU0+OIdp5BGGXgPu9MKCWnTjrAISrI4SampTHkyY
   wGBllSuYoKHp6PZusaZbyje4jB9kO+tU1of+tv8VXVG3E0Ls11h6HuhXu
   vUPxsLw5jganKGSeUDC4iMRCFZGhz9Ro50xwMd+feR8jIJb5wAdbCJIHU
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="253938953"
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="253938953"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 14:42:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,168,1643702400"; 
   d="scan'208";a="554329563"
Received: from chang-linux-3.sc.intel.com ([172.25.112.114])
  by orsmga008.jf.intel.com with ESMTP; 09 Mar 2022 14:42:38 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de, rafael@kernel.org,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: [PATCH v2 0/2] x86/fpu: Make AMX state ready for CPU idle
Date:   Wed,  9 Mar 2022 14:34:29 -0800
Message-Id: <20220309223431.26560-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMX state is a large state (at least 8KB or more). Entering CPU idle with
this non-initialized large state may result in shallow states while a
deeper low-power state is available.

We can confirm this behavior is implementation-specific. Section 3.3 in [1]
will be updated to clarify this. Sorry for the delay in this conclusion
and the update here.

Changes from v1 [2]:
* Drop the code to call TILERELEASE from arch_cpu_idle_enter(). Instead,
  do it from the intel-idle driver, as the behavior is *not* architectural.
* Simplify the driver code change (Rui).
* Improve the dynamic state flag check in the helper function.
* Drop the new C-state table as it is done by another patchset [3].
* Drop the opcode map changes as tip's x86/misc [4] has merged it already.

With the last two changes, the series depends on these:
* The C-state table update for Sapphire Rapids in linux-pm [3].
* The update of the x86 opcode map in the tip's branch [4].

The series on top of the above is available here:
  git://github.com/intel/amx-linux.git tilerelease

Thanks,
Chang

[1]: Intel Architecture Instruction Set Extension Programming Reference
     May 2021, https://software.intel.com/content/dam/develop/external/us/en/documents-tps/architecture-instruction-set-extensions-programming-reference.pdf
[2]: https://lore.kernel.org/lkml/20211104225226.5031-1-chang.seok.bae@intel.com/
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=9edf3c0ffef0ec1bed8300315852b5c6a0997130
[4]: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/misc&id=9dd94df75b30eca03ed2151dd5bbc152a6f19abf

Chang S. Bae (2):
  x86/fpu: Add a helper to prepare AMX state for low-power CPU idle
  intel_idle: Add a new flag to initialize the AMX state

 arch/x86/include/asm/fpu/api.h       |  2 ++
 arch/x86/include/asm/special_insns.h |  9 +++++++++
 arch/x86/kernel/fpu/core.c           | 15 +++++++++++++++
 drivers/idle/intel_idle.c            | 18 ++++++++++++++++--
 4 files changed, 42 insertions(+), 2 deletions(-)

-- 
2.17.1

