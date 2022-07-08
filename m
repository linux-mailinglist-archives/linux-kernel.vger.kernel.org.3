Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93F756BFEF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbiGHQWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238980AbiGHQWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:22:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486971A056;
        Fri,  8 Jul 2022 09:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657297317; x=1688833317;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TLktB3DWhGcfA3dzlR4wAGKKP4dbQc5qRQzQxykmlpk=;
  b=L7ag4MZrpPHGU1My4nC8dAq933g15zYpIrqkB8LuvQgTiCsGrEyqP0e2
   zO74eQcrpfuEhV298sK7oTTNPJQBRBlBcnrR47qW/m5+NCTIClMjdSrup
   5cp7d//egU+/q5gj6Jl0QwcOrgcWPOrjD/UoE/dog5+6Xicrw1Js3UsjE
   BiPLz5WQG37pdRFBTVQnACx0UqOAoWdwZd+L3FVnGzZcUn2wdKR18JnQr
   diPbiO+OjU/+orv5p4vCHewOamHXnnGdmhMyTbQsNzb3Nl+oPTYrf9HUA
   sbjMSCReiliOeTbCsxBAlM4fJ+5Mnz8008a7rK/cazsVtvcNLdzSBgvPd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="370629427"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="370629427"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 09:21:33 -0700
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="621275732"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.147.154])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 09:21:32 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     linux-sgx@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH] x86/sgx: Drop 'page_index' from sgx_backing
Date:   Fri,  8 Jul 2022 09:21:24 -0700
Message-Id: <20220708162124.8442-1-kristen@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Storing the 'page_index' value in the sgx_backing struct is
dead code and no longer needed.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/cpu/sgx/encl.c | 1 -
 arch/x86/kernel/cpu/sgx/encl.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 19876ebfb504..fa93586a536c 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -735,7 +735,6 @@ static int sgx_encl_get_backing(struct sgx_encl *encl, unsigned long page_index,
 		return PTR_ERR(pcmd);
 	}
 
-	backing->page_index = page_index;
 	backing->contents = contents;
 	backing->pcmd = pcmd;
 	backing->pcmd_offset = page_pcmd_off & (PAGE_SIZE - 1);
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 332ef3568267..eeb1a53ddf48 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -78,7 +78,6 @@ struct sgx_va_page {
 };
 
 struct sgx_backing {
-	pgoff_t page_index;
 	struct page *contents;
 	struct page *pcmd;
 	unsigned long pcmd_offset;
-- 
2.20.1

