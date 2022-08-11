Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7186358F5F4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 04:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiHKCtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 22:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiHKCtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 22:49:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE4C88DE5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 19:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660186146; x=1691722146;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8Mt8sFUCI2ItkayZuKBCPZE74Aj7OpvNmrzBBHWPO9E=;
  b=hl6of4rAO8yDNB+CkegIWRglDcS8FEZl4Orty5GjVdWN7QOXC9tMePcN
   ylUVJOPOxakmpikNz/Q1eSQah4Rg5FUndvJzw9IFIyO6jIBme0xVbSNUK
   zhF9PjNH7QSTDueWT4IU8WAkABwT441Kv5FW8xWlcV0OVW7rbbm4pnL+Y
   Ip+Weh2PLmFdeX9osxJ2UT0RODzwaF1JsBjdlAyrtpGV+WrX2OS3kAek7
   s64KfIAgjSspSBgxJfapX2sKmMsAxWbhE7sfe2hZLVxHa8xLEA1o+b4j7
   zL/ASSeikLCgt2AKQPv+Ylb9Gdo9Vmex5PsaaMW0uHqA45wq3icGjduB5
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="271018788"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="271018788"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 19:49:06 -0700
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="933141852"
Received: from zjoseph-mobl3.amr.corp.intel.com (HELO localhost) ([10.209.123.207])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 19:49:05 -0700
From:   ira.weiny@intel.com
To:     Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/3] Print CPU at segfault time
Date:   Wed, 10 Aug 2022 19:49:00 -0700
Message-Id: <20220811024903.178925-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Changes from RFC:
	Drop patch 1 as I misunderstood the code and it is not needed for this
		use case
	Combine patch 2 and 5 into a patch 3 which stores the CPU only for page
		faults

Rik reported that the knowledge of which CPU's are seeing faults can help in
determining which CPUs are failing in a large data center.[1]

Storing the CPU at exception entry time allows this print to report the CPU
which actually took the exception.  This still may not be the CPU which is
failing but it should be closer.

Dave and Boris recognized that the auxiliary pt_regs work I did for the PKS
series could help to store this value and avoid passing the CPU throughout the
fault handler call stack.

The patches I sent for RFC had a lot more overhead than is needed to report the
CPU in a page fault.[2]  After the discussions the generic save/restore of the
auxiliary pt_regs is overkill for the current use case.  Skip that overhead and
only store the CPU in the page fault path.

[1] https://lore.kernel.org/all/20220805101644.2e674553@imladris.surriel.com/
[2] https://lore.kernel.org/lkml/20220805173009.3128098-1-ira.weiny@intel.com/

Ira Weiny (2):
  x86/entry: Add auxiliary pt_regs space
  x86/mm: Store CPU info on exception entry

Rik van Riel (1):
  x86,mm: print likely CPU at segfault time

 arch/x86/Kconfig                 |  4 ++++
 arch/x86/entry/calling.h         | 19 +++++++++++++++++++
 arch/x86/entry/entry_64.S        | 22 ++++++++++++++++++++++
 arch/x86/entry/entry_64_compat.S |  6 ++++++
 arch/x86/include/asm/ptrace.h    | 19 +++++++++++++++++++
 arch/x86/kernel/asm-offsets_64.c | 15 +++++++++++++++
 arch/x86/kernel/head_64.S        |  6 ++++++
 arch/x86/mm/fault.c              | 18 ++++++++++++++++++
 8 files changed, 109 insertions(+)


base-commit: d4252071b97d2027d246f6a82cbee4d52f618b47
-- 
2.35.3

