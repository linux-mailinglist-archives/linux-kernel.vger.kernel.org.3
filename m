Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F57952AE30
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 00:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbiEQWdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 18:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiEQWdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 18:33:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170443EABA;
        Tue, 17 May 2022 15:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652826799; x=1684362799;
  h=from:to:cc:subject:date:message-id;
  bh=ktE04coO5bw2iUMOgThFEuycIpP9WgRpewz8e7wF3Ys=;
  b=dfFpUQCmdF+GPbwA+qeu7CA4BJ00tDcbpZRk9McNav+96Js1WM9JVnfT
   TpxVtjn4cV0iLEuqp2BT+nDijmh1GNva/EF0jfGLBSAz9RGIACFddb5Ld
   9ohNFqRvxT9japi5phaJLa9Tb0zJcHwrmoOaZ7TKI2JAuJmkFx4DnI3Nd
   VjoN8IV/MkieWvfONYogISW63T3Uo4gVuQ1MvZtK2doB6FMDK7fB4slFf
   2GqTL7LCiPMv5IljxhkCmMLc/KCT4tCfDQORkbHEBPSZmd7dxJaEz5f6J
   fJ6YmjQIqdG8Ri+0ePJYDf7VZnhUK52Fuq3GHYrjGXiyaPdNPRpl9roKA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="268945486"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="268945486"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 15:33:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="555993791"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga002.jf.intel.com with ESMTP; 17 May 2022 15:33:18 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de, rafael@kernel.org,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: [PATCH v4 0/2] x86/fpu: Make AMX state ready for CPU idle
Date:   Tue, 17 May 2022 15:24:28 -0700
Message-Id: <20220517222430.24524-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.2 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First of all, my apologies for the long delay with my vacation.

Changes from v3 [1]:
* Call out AMX state only needs to be initialized for CPU idle (Thomas).
* Drop the XCR0 accessor changes as not relevant (Dave).

The series is available here:
  git://github.com/intel/amx-linux.git tilerelease

=== Original Cover Letter ===

AMX state is a large state (at least 8KB or more). Entering CPU idle with
this non-initialized large state may result in shallow states while a
deeper low-power state is available.

We can confirm this behavior is implementation-specific. Section 3.3 in [2]
will be updated to clarify this.

Thanks,
Chang

[1]: https://lore.kernel.org/lkml/20220325022219.829-1-chang.seok.bae@intel.com/
[2]: Intel Architecture Instruction Set Extension Programming Reference
     May 2021, https://software.intel.com/content/dam/develop/external/us/en/documents-tps/architecture-instruction-set-extensions-programming-reference.pdf

Chang S. Bae (2):
  x86/fpu: Add a helper to prepare AMX state for low-power CPU idle
  intel_idle: Add a new flag to initialize the AMX state

 arch/x86/include/asm/fpu/api.h       |  2 ++
 arch/x86/include/asm/special_insns.h |  9 +++++++++
 arch/x86/kernel/fpu/core.c           | 13 +++++++++++++
 drivers/idle/intel_idle.c            | 18 ++++++++++++++++--
 4 files changed, 40 insertions(+), 2 deletions(-)


base-commit: 42226c989789d8da4af1de0c31070c96726d990c
-- 
2.17.1

