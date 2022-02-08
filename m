Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6F54ACDBD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344720AbiBHBKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344213AbiBHAqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:46:16 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF49C061A73;
        Mon,  7 Feb 2022 16:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644281176; x=1675817176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jpG9hfXpHnLcADFZTQ12jgZ85kq17DbfUnpfb4LgYcQ=;
  b=SFpFVQ5pTiisUFeTwZhD0qKgOduvaDnBALDaxUav5w86+85aQf1ypcmw
   UwXwH+vWj/2oRiVFAIw6TubOpwkGnCDZT4IF5Zn6iK2Rnmo3OakDq8p+6
   qx95t9TWtrCO6csy8yTtOd+K25URrXO3jrFExz6g+arM6Vk6f+DA8HJkf
   NDCT1NRGJyoKO+6vGRn1J9B0b7FDrDHLFRd/U3ZoznxvxDW7mVpJ0DdyF
   uvkHrqIiNQByhNel5embOIbxt6U6a1nd9A9KbULddNnnFI5vcYJrHMc3J
   G4gH8UNsMCnoAIeazloG0M16Wfpq/FKfKYnJuKb1q+xub8vn4Z0av7rz8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="232407986"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="232407986"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:46:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="499389541"
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
Subject: [PATCH V2 24/32] Documentation/x86: Introduce enclave runtime management section
Date:   Mon,  7 Feb 2022 16:45:46 -0800
Message-Id: <81387cc6cfee70a98165377f234908037e40dcf8.1644274683.git.reinette.chatre@intel.com>
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

Enclave runtime management is introduced following the pattern
of the section describing enclave building. Provide a brief
summary of enclave runtime management, pointing to the functions
implementing the ioctl()s that will contain details within their
kernel-doc.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- New patch.

 Documentation/x86/sgx.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
index 9df620b59f83..4059efbb4d2e 100644
--- a/Documentation/x86/sgx.rst
+++ b/Documentation/x86/sgx.rst
@@ -138,6 +138,22 @@ pages and establish enclave page permissions.
                sgx_ioc_enclave_init
                sgx_ioc_enclave_provision
 
+Enclave runtime management
+--------------------------
+
+Systems supporting SGX2 additionally support changes to initialized
+enclaves: modifying enclave page permissions and type, and dynamically
+adding and removing of enclave pages. When an enclave accesses an address
+within its address range that does not have a backing page then a new
+regular page will be dynamically added to the enclave. The enclave is
+still required to run EACCEPT on the new page before it can be used.
+
+.. kernel-doc:: arch/x86/kernel/cpu/sgx/ioctl.c
+   :functions: sgx_ioc_enclave_relax_perm
+               sgx_ioc_enclave_restrict_perm
+               sgx_ioc_enclave_modt
+               sgx_ioc_enclave_remove_pages
+
 Enclave vDSO
 ------------
 
-- 
2.25.1

