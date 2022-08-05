Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046FC58AEEE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241386AbiHERav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241301AbiHERag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:30:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E0D19C03
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 10:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659720627; x=1691256627;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lNpl3WpX5qBLgUm1l2qwRW/uFaqWkaKUUWTJTe511pE=;
  b=GljWQ+Nl9aioX0ZwA6tmsf/IDgb/8l9DiSeges51mje1zNmisFi+IZ46
   ZWjca0QMOf2GzopGKAu6UMJ4G/0VfdPGTkocw9aN2fOnHqr3cBvvthot4
   dckwiMBTJ76HKlflH1yCpoZqGcm+LLW7biupXGk+KYkA9qMY/nqBU1/w9
   fMp5MY41NXzLBe0/g83LGdjZH+Sb9yUUV62Z9DLfd1NOA+1ZEVB5pmFPJ
   hXNgAffF2lrdd0pFgQp5UCAtkV9U8vU3Gl1ZSCalJj0DXttwC4zsqP3jk
   sbZRAiqAdV/SJ0XTpLxX5b3i2qrx4huetE4zjtz2l7VM2JwMxZDi+LumY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="287814607"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="287814607"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 10:30:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="663064578"
Received: from amecham-mobl.amr.corp.intel.com (HELO localhost) ([10.255.0.242])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 10:30:19 -0700
From:   ira.weiny@intel.com
To:     Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 0/5] Print CPU at segfault time
Date:   Fri,  5 Aug 2022 10:30:04 -0700
Message-Id: <20220805173009.3128098-1-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>


Rik reported that the knowledge of which CPU's are seeing faults can help in
determining which CPUs are failing in a large data center.[1]

Storing the CPU at exception entry time allows this print to report the CPU
which actually took the exception.  This still may not be the CPU which is
failing but it should be closer.

Dave and Boris recognized that the auxiliary pt_regs work I did for the PKS
series could help to store this value and avoid passing the CPU throughout the
fault handler call stack.

I'm posting this RFC for a few reasons.

1) I've left in arch_restore_aux_pt_regs().  This is called on exception exit
   and is not needed for this use case but I believe it is better to leave it
   for symmetry within the generic entry code.  This also means that patch
   1/5 could be dropped completely.

2) I want to see if 0day has any issues with the Kconfig option changes I made
   which may creep in from a 32bit build.

3) The final patch could be squashed with Rik's but it seemed better to leave
   them split for authorship clarity.

Compile tested only.

[1] https://lore.kernel.org/all/20220805101644.2e674553@imladris.surriel.com/

Ira Weiny (4):
  entry: Pass pt_regs to irqentry_exit_cond_resched()
  entry: Add calls for save/restore auxiliary pt_regs
  x86/entry: Add auxiliary pt_regs space
  x86/entry: Store CPU info on exception entry

Rik van Riel (1):
  x86,mm: print likely CPU at segfault time

 arch/arm64/include/asm/preempt.h    |  2 +-
 arch/arm64/kernel/entry-common.c    |  4 +--
 arch/x86/Kconfig                    |  4 +++
 arch/x86/entry/calling.h            | 19 ++++++++++++++
 arch/x86/entry/common.c             |  2 +-
 arch/x86/entry/entry_64.S           | 22 ++++++++++++++++
 arch/x86/entry/entry_64_compat.S    |  6 +++++
 arch/x86/include/asm/entry-common.h | 12 +++++++++
 arch/x86/include/asm/ptrace.h       | 19 ++++++++++++++
 arch/x86/kernel/asm-offsets_64.c    | 15 +++++++++++
 arch/x86/kernel/head_64.S           |  6 +++++
 arch/x86/mm/fault.c                 | 10 ++++++++
 include/linux/entry-common.h        | 25 +++++++++++++-----
 kernel/entry/common.c               | 29 ++++++++++++++++-----
 kernel/sched/core.c                 | 40 ++++++++++++++---------------
 15 files changed, 178 insertions(+), 37 deletions(-)


base-commit: b2a88c212e652e94f1e4b635910972ac57ba4e97
-- 
2.35.3

