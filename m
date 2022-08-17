Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE81596863
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbiHQFMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiHQFMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:12:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15C16DFA5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660713120; x=1692249120;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VRRoOQfEhbiAOOZznNm1KYfqSWKIHCwQvtIkjoBNBg8=;
  b=ZbhdybUGAoxuYByQXjX3GC780b+T94PkU60kB7z8briq7LuOZEgXPcD2
   skfIFC+bpn9q2P9piaPRSCHFJSbUmuzggxFZSzi4aOtJ1FXZ+H58NILpR
   1HwyWljr0+JFcZhXAicdpRMOM8zht/CxkRapOcQjpY+1v07OuaunK3ibA
   HtoXbIqAyKc48Z3w2l+sPNXbMvaLgCQPxaBV0OovY2y6pRrlGnKtfgGN6
   sQrRMDvVR7PIJrX/SyMG5oYIkSCCGVb23fwVjTstJY7ex06yjCMbMirqe
   T2n7JJrOsyoTYnbhxEhv42Y80C5iWH6Rgsqc6cThUM9voEtaXh51w4Ph/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="289972493"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="289972493"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 22:12:00 -0700
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="557976681"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 22:11:59 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Jacon Jun Pan" <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v3 0/5] Making microcode late-load robust
Date:   Wed, 17 Aug 2022 05:11:22 +0000
Message-Id: <20220817051127.3323755-1-ashok.raj@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris

I thought v2 worked, but there were some glaring errors in them.
I added more trace and this did go through and finish. More testing would
help.

Let me know how you want to handle 1-3. patch4,5 needs more review and some
help testing on AMD as well.

v2: https://lore.kernel.org/lkml/20220816043754.3258815-1-ashok.raj@intel.com/
v1: https://lore.kernel.org/lkml/20220813223825.3164861-1-ashok.raj@intel.com/


Changes since v2

- Dropped Documentation, queued for tip
  https://lore.kernel.org/lkml/166063601497.401.9527776956724011207.tip-bot2@tip-bot2/

Patches: 1-3
   No Changes since v1

Patch4:
   x2apic doesn't handle NMI vector via the self IPI MSR, it can only
   send Fixed mode interrupts. Enhance send_IPI_self() to comprehend
   and use a function that will deliver to the NMI.

Patch5: 
   - Modified when the NMI was triggered. Moved it closer to when
     __reload_late() is running.
   - Used the new apic->send_IPI_self() support helper.
   - Added an atomic to check if the primary has completed the load.
   - Triggering the NMI and when its taken determines how long the primary
     CPU needs to wait. For Now i have no timeout, but will check on couple
     more platforms before coming with a number, so it can bail out if
     secondaries don't show up in a reasonable amount of time.

Ashok Raj (5):
  x86/microcode/intel: Check against CPU signature before saving
    microcode
  x86/microcode/intel: Allow a late-load only if a min rev is specified
  x86/microcode: Avoid any chance of MCE's during microcode update
  x86/x2apic: Support x2apic self IPI with NMI_VECTOR
  x86/microcode: Place siblings in NMI loop while update in progress

 arch/x86/include/asm/mce.h             |   4 +
 arch/x86/include/asm/microcode_intel.h |   4 +-
 arch/x86/kernel/apic/x2apic_phys.c     |   6 +-
 arch/x86/kernel/cpu/mce/core.c         |   9 +
 arch/x86/kernel/cpu/microcode/core.c   | 229 ++++++++++++++++++++++++-
 arch/x86/kernel/cpu/microcode/intel.c  |  34 +++-
 6 files changed, 274 insertions(+), 12 deletions(-)

-- 
2.32.0

