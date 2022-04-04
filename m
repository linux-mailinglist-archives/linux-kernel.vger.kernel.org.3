Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083894F1C48
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351900AbiDDV0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379266AbiDDQvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:51:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0DE3135B;
        Mon,  4 Apr 2022 09:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649090994; x=1680626994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m4/HuKY7IlIZ1WPP9o98DA/8FnlmNMaQ5SjeGB/v9kw=;
  b=Uf/YH24IJr0PAevLGgz5daig1Tj1sz9kOOZE8evuLzVuDnikPPsejIMM
   +xVQhEXIYhcabKMyiH73y1ozu5a4FK/Z4Rkcyo1FB/pZqbO4ixJI3IElQ
   fLD1hm8PLkuEB6gj8MGroS8Z5GRAUgOrJgfUIUGyBkEzDh6Tc/xDVSVFe
   GdnwWrIu8Vzt5PahgDiHXjn69fCJi36p5PyDBJu9+Sw11l42rtADB5IPN
   7keRW69PK74CSzIgWUSSh5mS2UlGS9FCiYf28dyPE2msR0wpRojeLr6x5
   mF3vX25TZChLlAB3h+S1lkiZbhQV3wRB/mYmxFwC/91jO9VqsPtIaTaoi
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="259390789"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="259390789"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 09:49:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="523105220"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 09:49:50 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 24/30] selftests/sgx: Introduce dynamic entry point
Date:   Mon,  4 Apr 2022 09:49:32 -0700
Message-Id: <a3fe0be22afdde289966b87861ff1c141f9ef512.1648847675.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648847675.git.reinette.chatre@intel.com>
References: <cover.1648847675.git.reinette.chatre@intel.com>
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

The test enclave (test_encl.elf) is built with two initialized
Thread Control Structures (TCS) included in the binary. Both TCS are
initialized with the same entry point, encl_entry, that correctly
computes the absolute address of the stack based on the stack of each
TCS that is also built into the binary.

A new TCS can be added dynamically to the enclave and requires to be
initialized with an entry point used to enter the enclave. Since the
existing entry point, encl_entry, assumes that the TCS and its stack
exists at particular offsets within the binary it is not able to handle
a dynamically added TCS and its stack.

Introduce a new entry point, encl_dyn_entry, that initializes the
absolute address of that thread's stack to the address immediately
preceding the TCS itself. It is now possible to dynamically add a
contiguous memory region to the enclave with the new stack preceding
the new TCS. With the new TCS initialized with encl_dyn_entry as entry
point the absolute address of the stack is computed correctly on entry.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
No changes since V2

No changes since V1

 tools/testing/selftests/sgx/test_encl_bootstrap.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/testing/selftests/sgx/test_encl_bootstrap.S
index 82fb0dfcbd23..03ae0f57e29d 100644
--- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
+++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
@@ -45,6 +45,12 @@ encl_entry:
 	# TCS #2. By adding the value of encl_stack to it, we get
 	# the absolute address for the stack.
 	lea	(encl_stack)(%rbx), %rax
+	jmp encl_entry_core
+encl_dyn_entry:
+	# Entry point for dynamically created TCS page expected to follow
+	# its stack directly.
+	lea -1(%rbx), %rax
+encl_entry_core:
 	xchg	%rsp, %rax
 	push	%rax
 
-- 
2.25.1

