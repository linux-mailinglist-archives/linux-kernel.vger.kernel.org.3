Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274594F1C6D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358167AbiDDV1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379269AbiDDQvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:51:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ED73204D;
        Mon,  4 Apr 2022 09:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649090996; x=1680626996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JOqZTO9BJ6ZBD3WRZCWK3rVS9xdulCCUAXpq8W/WH40=;
  b=hFrZsM81Nvfea9jNYWSTj4tZ8Shzue1Ggcd/XsJxn3b6TM5f6oVIDbXJ
   88O3weVjhnBsOtuNswrC4U6eKqIYw6HaRidrT8PQ3BXm8lPWyMdVfYFZe
   Efb7E4j76oA/Moqt0KcDiJN0IBLQhWz6h4GGy2XkiULktP0l1UCJYqPCj
   8LIFu74dSt2Es7XXnfGZZvE1Cx7DCnRnDRdr0gM7u4gO6WA5QMXXNXjkR
   5LwsYMzvyJQoGIO41yq9z2h4oCeWVub0mRrzwzkmRiyNeuGD3dl6/C3Pr
   KIzCAM43p/77kPGY4+w2gGhjymU02tUGGJsVyYcRZvVsDPw0R3msfhF3D
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="323734051"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="323734051"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 09:49:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="523105195"
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
Subject: [PATCH V3 16/30] x86/sgx: Tighten accessible memory range after enclave initialization
Date:   Mon,  4 Apr 2022 09:49:24 -0700
Message-Id: <9f9e9582029dee93b5b37f2fb4dc062be9fe1fde.1648847675.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648847675.git.reinette.chatre@intel.com>
References: <cover.1648847675.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before an enclave is initialized the enclave's memory range is unknown.
The enclave's memory range is learned at the time it is created via the
SGX_IOC_ENCLAVE_CREATE ioctl() where the provided memory range is
obtained from an earlier mmap() of /dev/sgx_enclave. After an enclave
is initialized its memory can be mapped into user space (mmap()) from
where it can be entered at its defined entry points.

With the enclave's memory range known after it is initialized there is
no reason why it should be possible to map memory outside this range.

Lock down access to the initialized enclave's memory range by denying
any attempt to map memory outside its memory range.

Locking down the memory range also makes adding pages to an initialized
enclave more efficient. Pages are added to an initialized enclave by
accessing memory that belongs to the enclave's memory range but not yet
backed by an enclave page. If it is possible for user space to map
memory that does not form part of the enclave then an access to this
memory would eventually fail. Failures range from a prompt general
protection fault if the access was an ENCLU[EACCEPT] from within the
enclave, or a page fault via the vDSO if it was another access from
within the enclave, or a SIGBUS (also resulting from a page fault) if
the access was from outside the enclave.

Disallowing invalid memory to be mapped in the first place avoids
preventable failures.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
No changes since V2

Changes since V1:
- Add comment (Jarkko).

 arch/x86/kernel/cpu/sgx/encl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index fa4f947f8496..7909570736a0 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -409,6 +409,11 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 
 	XA_STATE(xas, &encl->page_array, PFN_DOWN(start));
 
+	/* Disallow mapping outside enclave's address range. */
+	if (test_bit(SGX_ENCL_INITIALIZED, &encl->flags) &&
+	    (start < encl->base || end > encl->base + encl->size))
+		return -EACCES;
+
 	/*
 	 * Disallow READ_IMPLIES_EXEC tasks as their VMA permissions might
 	 * conflict with the enclave page permissions.
-- 
2.25.1

