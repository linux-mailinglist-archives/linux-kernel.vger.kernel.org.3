Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1711591D04
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 00:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiHMWiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 18:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiHMWiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 18:38:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A406CD19
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 15:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660430330; x=1691966330;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=85x1sxGCpd+Ll28PVX2zz+ru9CVroI576LAmHQ8XoRI=;
  b=ZLCXUO0OcBYSGZABTp95rnmn1c7gNXFNp1m3y9yla+rbfCvGsFt6vC8G
   0jvq7TSgRslChxX/oEeiuD2jIA4O0bA3u8I0NTt3K+cH9nw0DIpc9eJ94
   hctxuj8/x8PtC+nn7PrRPv6TttdVa9TtbgNuDwcdPMUZrSH6NVuGQZ1Hf
   4Jc0vRNw62TJdvjdUgF7JnVquOmBQOaqAjmI/gmVslRpoSFlDwXEoQ7GC
   5+z6EcTn84YerNb9P78TaXcfLxURqGHB13WLXcwBW4xSzg2Wg1gw1Be33
   xE1/frGXC5qSVpH6JA1KP9c91OVfx8wOQ1Pj2mxbySt1CO+IPBozPrK2Y
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="353523718"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="353523718"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 15:38:49 -0700
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="556890222"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 15:38:49 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH 0/5] Adding more robustness to microcode loading
Date:   Sat, 13 Aug 2022 22:38:20 +0000
Message-Id: <20220813223825.3164861-1-ashok.raj@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris and Thomas,

This is an attempt to move towards enabling late-load ON by default, and if
the taint flag can be removed after this patch series.

- Patch1: Documentation improvements. (to tainted-kernels.rst) and
  x86/microcode.rst.
- Patch2: (Intel) Fix in patch-match during an update left the old patch still in
  the list. This isn't necessary.
- Patch3: One key improvement is the addition of min_rev_id in the 
  microcode header.  This allows a way for CPU microcode to declare itself
  if this is suitable for late-loads.
- Patch4: Avoid any MCE's while a microcode update is in progress. This
  basically promotes any arriving MCE's to shutdown automatically.
- Patch5: Protect the secondary thread from entering NMI before a microcode
  update is complete in the primary thread.
  

Ashok Raj (5):
  x86/microcode: Add missing documentation that late-load will taint
    kernel
  x86/microcode/intel: Check against CPU signature before saving
    microcode
  x86/microcode/intel: Allow a late-load only if a min rev is specified
  x86/microcode: Avoid any chance of MCE's during microcode update
  x86/microcode: Handle NMI's during microcode update.

 Documentation/admin-guide/tainted-kernels.rst |  8 +-
 Documentation/x86/microcode.rst               | 95 +++++++++++++++++-
 arch/x86/include/asm/mce.h                    |  4 +
 arch/x86/include/asm/microcode_intel.h        |  4 +-
 arch/x86/kernel/cpu/mce/core.c                |  9 ++
 arch/x86/kernel/cpu/microcode/core.c          | 99 ++++++++++++++++++-
 arch/x86/kernel/cpu/microcode/intel.c         | 34 ++++++-
 7 files changed, 240 insertions(+), 13 deletions(-)

-- 
2.32.0

