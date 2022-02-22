Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004A94C01C1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbiBVS6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbiBVS6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:58:15 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F1ABF97B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645556269; x=1677092269;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ofWFZpzYO/qnLxOCsHEB1xbjxhDgd/GCEJLCnQf88OQ=;
  b=Mk1GSR3qctuLQqHAyCAPsnNWWJXu60WKC/IJ5rEmCdLdrdqlG14wqNL8
   XTI6pABveH6r91R6LTDSUAxO6IS3/XyTOuomqTqEB0AULyoZ55VUhwyFH
   y+3KMiiUKzWhz9D/1R1AlvF/FzjSVgno6XpFFLIqeOsNdpmAiFfcz2C5G
   acgz3hogcesYZBmDMKZyHXwhSkDV9c/G+1ABPntZfQdA0exmKbelbyzdS
   ifofFs9rikZnD/yN/eGLsuMIMULLuDNH9MDx/woQDijJim6rnjbCwlnlq
   hZ60jOmrAJC2pv5Dxf0hGJ1xwQH3s7YMt2GEVTOQMVAK2jmbPG68K3CtJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="231756953"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="231756953"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 10:57:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="490900618"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 22 Feb 2022 10:57:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 3905D142; Tue, 22 Feb 2022 20:57:50 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jmattson@google.com, seanjc@google.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/4] x86: Cleanup and extend computing computing API
Date:   Tue, 22 Feb 2022 21:57:36 +0300
Message-Id: <20220222185740.26228-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates for CC API:
 - Fix for HyperV when AMD SME/SEV disabled;
 - New home for CC code: arch/x86/coco;
 - Explicitly declare vendor of CC platform;
 - New cc_mkenc() and cc_mkdec();

Kirill A. Shutemov (4):
  x86/hyperv: Add missing ARCH_HAS_CC_PLATFORM dependency
  x86: Rename cc_platform.c to arch/x86/coco/core.c
  x86/coco: Explicitly declare type of confidential computing platform
  x86/coco: Add API to handle encryption mask

 arch/x86/Kbuild                               |  2 +
 arch/x86/coco/Makefile                        |  6 ++
 .../x86/{kernel/cc_platform.c => coco/core.c} | 56 +++++++++++++++----
 arch/x86/include/asm/coco.h                   | 32 +++++++++++
 arch/x86/include/asm/pgtable.h                | 13 +++--
 arch/x86/kernel/Makefile                      |  5 --
 arch/x86/kernel/cpu/mshyperv.c                |  3 +
 arch/x86/mm/mem_encrypt_identity.c            | 12 ++--
 arch/x86/mm/pat/set_memory.c                  |  5 +-
 drivers/hv/Kconfig                            |  1 +
 10 files changed, 106 insertions(+), 29 deletions(-)
 create mode 100644 arch/x86/coco/Makefile
 rename arch/x86/{kernel/cc_platform.c => coco/core.c} (73%)
 create mode 100644 arch/x86/include/asm/coco.h

-- 
2.34.1

