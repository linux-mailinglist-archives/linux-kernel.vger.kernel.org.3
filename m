Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776114E6C88
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 03:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357736AbiCYCcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 22:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242818AbiCYCcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 22:32:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19563B6E45;
        Thu, 24 Mar 2022 19:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648175436; x=1679711436;
  h=from:to:cc:subject:date:message-id;
  bh=UvEWWF7X10dCTVo/eglip4ty3sbfJC5IVaGkQMFf0Ms=;
  b=mOjIjFsJswnBDlIOAkNiMJBU5gXEIvWOJOHSVmU3SvTZDMMjkD3negDu
   UdzQfe8WUZ4KAgnOg5dbTbCj3qbjUmDZ6PInCsfDqz5sle2J6NCRkobgE
   rOrKq4cNYJBWLMAvIdIIGvtlGFdCHLBUa5gMr+Jjsjwoj53ELw+ccRxdJ
   xquGp+L1u7KXANaq4toEti2U1F4LBLDQ+rUXTDFq7ATE2dkqAe5tFIqsQ
   ksS5oqp3AgROswavcSnJHRdzE536YGtUd98cSsmN/pzyMoaN/06cWvxOH
   Xs65UTh9GCbsNR+zw/3rf+7ogVDDmWf0oRN5M6fSPLU/0tmrFrNj2n5VK
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="321733681"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="321733681"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 19:30:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="693531275"
Received: from chang-linux-3.sc.intel.com ([172.25.112.114])
  by fmsmga001.fm.intel.com with ESMTP; 24 Mar 2022 19:30:35 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de, rafael@kernel.org,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: [PATCH v3 0/3] x86/fpu: Make AMX state ready for CPU idle
Date:   Thu, 24 Mar 2022 19:22:16 -0700
Message-Id: <20220325022219.829-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.0 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v2 [1]:
* Secure XCR0 accessors from the compiler reordering issue (Dave Hansen).
* Check the feature flag instead of fpu_state_size_dynamic() (Dave Hansen).
* Remove the meaningless backslash (Rafael Wysocki).

Note the two changes this series wants are now in the mainline:
* the opcode for TILERELEASE [2] and
* the C-state table for Sapphire Rapids [3]

The series on top of the above is available here:
  git://github.com/intel/amx-linux.git tilerelease

Thanks,
Chang

[1]: https://lore.kernel.org/lkml/20220309223431.26560-1-chang.seok.bae@intel.com/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch?id=9dd94df75b30eca03ed2151dd5bbc152a6f19abf
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch?id=9edf3c0ffef0ec1bed8300315852b5c6a0997130

Chang S. Bae (3):
  x86/fpu: Make XCR0 accessors immune to unwanted compiler reordering
  x86/fpu: Add a helper to prepare AMX state for low-power CPU idle
  intel_idle: Add a new flag to initialize the AMX state

 arch/x86/include/asm/fpu/api.h       |  2 ++
 arch/x86/include/asm/fpu/xcr.h       |  8 ++++++--
 arch/x86/include/asm/special_insns.h |  9 +++++++++
 arch/x86/kernel/fpu/core.c           | 13 +++++++++++++
 drivers/idle/intel_idle.c            | 18 ++++++++++++++++--
 5 files changed, 46 insertions(+), 4 deletions(-)

-- 
2.17.1

