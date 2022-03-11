Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644B84D570A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345253AbiCKA7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 19:59:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241066AbiCKA7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 19:59:39 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F93E98D4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 16:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646960316; x=1678496316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wzyA39JwdZxDDT/IXqrk8/yZKwNXu3aWKvXpfEakV14=;
  b=Ebc6/R9JQ6ah3AAIAy5kxC4//PxF+ZzB6ZZUIaRGGRyks/phEP7wXJYX
   sPJauC6h0bOZjm3+UwjnVKcY5cx/04RNZ+XeoF57QJMBkhgWrgAdTuSV4
   BWGofFUMnVT4NiJ7spMw6uaYYGXZSCh35bXL1sDkaAZmE/1qtwbNUxYJG
   eAYuCA+f5D0DGAUPJJXOkfNojoLILA9FnemT1e4HBelRNI6j9fwLsWX/7
   SF7vU+ssBVrKDeOVw6KiWovI/UK9i+spZLdNfqQ2erqtBbOsacD/Z2GnU
   RpOhCQLJcxV56nhhsi1aPuDHucm+pS6vdemUvYpoqZ4eIQpmhU5w5t+A3
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255405810"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="255405810"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 16:57:47 -0800
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="538750565"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 16:57:47 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] powerpc/pkeys: Properly type pkey in init_{i}amr()
Date:   Thu, 10 Mar 2022 16:57:40 -0800
Message-Id: <20220311005742.1060992-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311005742.1060992-1-ira.weiny@intel.com>
References: <20220311005742.1060992-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Negative values passed to pkeyshift() will cause an overflow of the amr
and imar values.  Pkey should not be negative in this call path and u8
is large enough for the 32 pkeys available on powerpc.

Change pkey to u8 in init_amr() and init_iamr().

To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/powerpc/mm/book3s64/pkeys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/pkeys.c b/arch/powerpc/mm/book3s64/pkeys.c
index 753e62ba67af..d6456f8846de 100644
--- a/arch/powerpc/mm/book3s64/pkeys.c
+++ b/arch/powerpc/mm/book3s64/pkeys.c
@@ -310,7 +310,7 @@ void pkey_mm_init(struct mm_struct *mm)
 	mm->context.execute_only_pkey = execute_only_key;
 }
 
-static inline void init_amr(int pkey, u8 init_bits)
+static inline void init_amr(u8 pkey, u8 init_bits)
 {
 	u64 new_amr_bits = (((u64)init_bits & 0x3UL) << pkeyshift(pkey));
 	u64 old_amr = current_thread_amr() & ~((u64)(0x3ul) << pkeyshift(pkey));
@@ -318,7 +318,7 @@ static inline void init_amr(int pkey, u8 init_bits)
 	current->thread.regs->amr = old_amr | new_amr_bits;
 }
 
-static inline void init_iamr(int pkey, u8 init_bits)
+static inline void init_iamr(u8 pkey, u8 init_bits)
 {
 	u64 new_iamr_bits = (((u64)init_bits & 0x1UL) << pkeyshift(pkey));
 	u64 old_iamr = current_thread_iamr() & ~((u64)(0x1ul) << pkeyshift(pkey));
-- 
2.35.1

