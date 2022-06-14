Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B611A54AFBC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355305AbiFNMBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243641AbiFNMBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:01:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083F34755C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655208097; x=1686744097;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sQ+7xgbA7GrBKRkaQXzkDulkXu4yc8Go4H019plaIso=;
  b=UCxVWJPehtmN9If7n4GJDfCUP4iga4fog/5aswqPygxv68F9DtcQKPak
   0pFS9btRhWEkdW8dsxSttjXKV/HlQKQuRN34NTEu8zm9QsE0VXGI/KUHk
   Uup/ZKMZvN2oUvlxEtOE4gsgQhxbGnUuYNQ/x6m2HNRBw7TC2YLL+Pl8u
   DhKqi63/iuwNU6HTboHOjP7LeeexjAJBUzLMRQpy2qzCQfFXSpdbe0ltF
   bCvIp/KL4GGauJ1UEy1WoalCOrwENRg9DB500m5T408NX1MiCJ0JFEjll
   Vgk/hesfHJaP0q/qUXcAe23Uk6U31fxidMbOeC731iUi/6HxtD7Qa/hbm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="304007391"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="304007391"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 05:01:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="588429520"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2022 05:01:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id D3A09346; Tue, 14 Jun 2022 15:01:36 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org
Cc:     ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        thomas.lendacky@amd.com, x86@kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 0/3] An updated version of the load_unaligned_zeropad() fix
Date:   Tue, 14 Jun 2022 15:01:32 +0300
Message-Id: <20220614120135.14812-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An updated version of the load_unaligned_zeropad() fix.

v4:
 - Allow unaligned MMIO access, but fail split page accesses;
 - Explicit switch() in ve_instr_len() helper;
 - Update comments;
v3:
 - Rework load_unaligned_zeropad() fix: fail misaligned MMIO accesses
   instead of upfront exception fixups;
 - Add ve_instr_len() helper to wrap access to ve->instr_len;
 - Add Reviewed-by from Sathya;
v2:
 - Clarify RIP adjustments during #VE handling;
 - Fix early #VE handling;
 - Fix comment and commit message;

Kirill A. Shutemov (3):
  x86/tdx: Fix early #VE handling
  x86/tdx: Clarify RIP adjustments in #VE handler
  x86/tdx: Handle load_unaligned_zeropad() page-cross to a shared page

 arch/x86/coco/tdx/tdx.c | 187 +++++++++++++++++++++++++++++-----------
 1 file changed, 136 insertions(+), 51 deletions(-)

-- 
2.35.1

