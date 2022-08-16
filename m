Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06E759537B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiHPHKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbiHPHJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:09:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309D5388E13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 21:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660624789; x=1692160789;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VRCftzWpPIXf/vR0QtotYc7X/oGN0w4zYSw9wkJfaaI=;
  b=Ds44TzdYmhUoR9aTI7TGUZx8mXMwvIHIIcWlZp6/e7UjHX1Rn7M33MkG
   qCD/RSqwERW3fk7qHIn1uUJFYRKKGQwO23oU1tYeecit5+hJ4TSZFt3pD
   eKK8AJDyjqQyZotGE+nlUIo0VbGBsLN/YESduhuMzSlMydvPiGsEPZAzD
   xcCYmU0pGiocZS3cxZzWyT+Z2pcqqy7TMNvvW5hk9EhMhUlQJiVdJhsNQ
   yb8TgI6MqoHZnOhBQcVnIhaxZV7Tsw1vt9BAwXf36OK3NjF1jj5w9xTpV
   r+kYn7R66QqYMPBcUSRJDryQdeKcf5gJ5xnbIY/SPfQARVeKnW4+F8NGr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="293395136"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="293395136"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 21:38:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="675071585"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 21:38:18 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 0/4] Making microcode loading more robust
Date:   Tue, 16 Aug 2022 04:37:49 +0000
Message-Id: <20220816043754.3258815-1-ashok.raj@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Here is an update that handles siblings in NMI loop.

Changes since v1:
Patch 1,2,3: No Change.
Patch 4: 
- Move from lazy NMI handling to sending siblings in NMI early. This makes
  things more robust, since there might be something we could trip over
  before the handler is called that might be patched by the update.
  [ Suggested by Andy Cooper ]

TBD: Handle DR7, temporarily disable until the update is done
   [ Suggested by Andy Lutomirsky ]


Ashok Raj (4):
  x86/microcode/intel: Check against CPU signature before saving
    microcode
  x86/microcode/intel: Allow a late-load only if a min rev is specified
  x86/microcode: Avoid any chance of MCE's during microcode update
  x86/microcode: Place siblings in NMI loop while update in progress

 arch/x86/include/asm/mce.h             |   4 +
 arch/x86/include/asm/microcode_intel.h |   4 +-
 arch/x86/kernel/cpu/mce/core.c         |   9 ++
 arch/x86/kernel/cpu/microcode/core.c   | 202 ++++++++++++++++++++++++-
 arch/x86/kernel/cpu/microcode/intel.c  |  34 ++++-
 5 files changed, 242 insertions(+), 11 deletions(-)

-- 
2.32.0

