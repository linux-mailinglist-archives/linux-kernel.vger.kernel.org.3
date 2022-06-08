Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B815439FC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 19:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiFHRLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 13:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiFHRK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 13:10:26 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929A73FB136;
        Wed,  8 Jun 2022 09:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654707409; x=1686243409;
  h=from:to:cc:subject:date:message-id;
  bh=wUmH7qcy24OFUjvHh7PD/2Ig8kxRpR/I+tlicOArX/M=;
  b=ee5t227dp3jzuAbSn55U0rlhCJlG2/y7dFyXl9QDf7QiimCqAMAf516P
   vOXhydjeNemK2Xa1iWCx98tNfY6XXQs9aWkkGhAvKAzudmagusLXDGjLM
   YsfmkL9D9qX1k2lGY+abcwl3JYdtyrAl0lpi4wrfVE7ty0s8pDGS6fluV
   QE2aJxMEW9uywuRcA4gfbuqf081f0z/M7Wzc8keJE8HZdiXwmueExfb85
   UskuAmAedfx4v8mYpaA8Ai3wkGlCH5CeuyB6cuaRPEXX+Otj+sDpnDhE0
   46jDhtwAtjXpY7w9XFatpGX5hOiVRcUQI4aFNqpD5usaMfneW7XyGhsvJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="265768289"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="265768289"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 09:56:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="585001301"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jun 2022 09:56:47 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de, rafael@kernel.org, riel@fb.com,
        bigeasy@linutronix.de, hch@lst.de, fenghua.yu@intel.com,
        rui.zhang@intel.com, artem.bityutskiy@linux.intel.com,
        jacob.jun.pan@linux.intel.com, lenb@kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v5 0/2] x86/fpu: Make AMX state ready for CPU idle
Date:   Wed,  8 Jun 2022 09:47:46 -0700
Message-Id: <20220608164748.11864-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.6 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the fifth version of this series.

I've addressed Dave's comment [2] assuming that the change makes sense to
folks:
* Check the AMX_TILE feature bit instead of XGETBV1.
* Massage the changelog accordingly.

While many people had their eyeballs on this, Rafael's ACK was given so
far. Hopefully this can attracts more acknowledgment or endorsement if it
looks fine.

=== Cover Letter ===

AMX state is a large state (at least 8KB or more). Entering CPU idle with
this non-initialized large state may result in shallow states while a
deeper low-power state is available.

We can confirm this behavior is implementation-specific. Section 3.3 in [3]
will be updated to clarify this.

This patch set ensures the AMX state is initialized before entering the CPU
idle state.

The patch set is based on 5.19-rc1. It is also available here:
  git://github.com/intel/amx-linux.git tilerelease

[1]: V4 https://lore.kernel.org/lkml/20220517222430.24524-1-chang.seok.bae@intel.com/
[2]: https://lore.kernel.org/lkml/25a2a82f-b5e5-0fce-86c8-03d7da5fcdd1@intel.com/
[3]: Intel Architecture Instruction Set Extension Programming Reference
     May 2021, https://software.intel.com/content/dam/develop/external/us/en/documents-tps/architecture-instruction-set-extensions-programming-reference.pdf

Chang S. Bae (2):
  x86/fpu: Add a helper to prepare AMX state for low-power CPU idle
  intel_idle: Add a new flag to initialize the AMX state

 arch/x86/include/asm/fpu/api.h       |  2 ++
 arch/x86/include/asm/special_insns.h |  9 +++++++++
 arch/x86/kernel/fpu/core.c           | 14 ++++++++++++++
 drivers/idle/intel_idle.c            | 18 ++++++++++++++++--
 4 files changed, 41 insertions(+), 2 deletions(-)


base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.17.1

