Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3A2465653
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 20:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352690AbhLAT1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 14:27:23 -0500
Received: from mga05.intel.com ([192.55.52.43]:21702 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245107AbhLAT1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:27:05 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="322784106"
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="322784106"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 11:23:43 -0800
X-IronPort-AV: E=Sophos;i="5.87,279,1631602800"; 
   d="scan'208";a="500380477"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 11:23:42 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/25] x86/sgx: Tighten accessible memory range after enclave initialization
Date:   Wed,  1 Dec 2021 11:23:12 -0800
Message-Id: <66da195d44cbbed57b6840c5d20bb789c06fb99f.1638381245.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638381245.git.reinette.chatre@intel.com>
References: <cover.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before an enclave is initialized the enclave's memory range is unknown.
The enclave's memory range is learned at the time it is created via the
SGX_IOC_ENCLAVE_CREATE ioctl where the provided memory range is obtained
from an earlier mmap() of the sgx_enclave device. After an enclave is
initialized its memory can be mapped into user space (mmap()) from where
it can be entered at its defined entry points.

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
 arch/x86/kernel/cpu/sgx/encl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 342b97dd4c33..37203da382f8 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -403,6 +403,10 @@ int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
 
 	XA_STATE(xas, &encl->page_array, PFN_DOWN(start));
 
+	if (test_bit(SGX_ENCL_INITIALIZED, &encl->flags) &&
+	    (start < encl->base || end > encl->base + encl->size))
+		return -EACCES;
+
 	/*
 	 * Disallow READ_IMPLIES_EXEC tasks as their VMA permissions might
 	 * conflict with the enclave page permissions.
-- 
2.25.1

