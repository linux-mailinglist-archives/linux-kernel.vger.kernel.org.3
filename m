Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 210314ACDD5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344618AbiBHBKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344214AbiBHAqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:46:16 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32273C043180;
        Mon,  7 Feb 2022 16:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644281176; x=1675817176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8/l41GYdNmbgP2ToNZ8AUjD5rze4OQVd0hNF/VcPaSI=;
  b=C5UG+rrBnA6ovTiWh8pbOXgONhDGiWpnNaSQjjlpWN8fHwM9ycdYuG5b
   ZZCjmBl0z7YX0VIsU43YlenHICLSPy3SdqmhCzoGPbgNWaEtKyrXwFXFX
   e9r41lY/wG8tLqHtjjV/L+ZWJs4jgx6HmH1b2t+oLcQzXeEf/H5WBFZ0x
   +nDxD4tDoFgsAfGcSPTQAbs6kUl2/uHHNn/5szAZjp9zeCtHkdnnBEx+n
   G63ohNRlAUJpWfm8b2Qq1EhjL8hwOlfh6uk1vMtiw7KyY5T7KrJktO98x
   OfjuGO9F4bZUw9meUmDWuHqPo+twNHNBHuY1CtoH1rOXVV5fZ/JOJpAUm
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="232407988"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="232407988"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:46:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="499389545"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:46:09 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 25/32] selftests/sgx: Introduce dynamic entry point
Date:   Mon,  7 Feb 2022 16:45:47 -0800
Message-Id: <65c137c875bd4da675eaba35316ff43d7cfd52f8.1644274683.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1644274683.git.reinette.chatre@intel.com>
References: <cover.1644274683.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
No changes since V1.

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

