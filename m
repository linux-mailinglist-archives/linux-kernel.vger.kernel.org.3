Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027094F1B67
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352689AbiDDVUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379260AbiDDQvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:51:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B907F2F027;
        Mon,  4 Apr 2022 09:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649090993; x=1680626993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q1gzI1p7lYlJM1ES/b7kTxpDoldvcsTYjSPg9p/YXLo=;
  b=JqlDy1MP2/LHUb9/n1NM1CpSPVRsP1d+cOlmDIzopIzH3a+ZnHojM2Uc
   DG0nWCd2l4JEqZCswO2fxMm/RQOscE1WIcSlyI0+59G246veDZNZHGT+d
   AOKP7znpt+4ZNPPkJ2nlc3OtJW1Eym+v/GgR/aiucICWLrREjQXxspnil
   wmpe36yI9WcJaAsSjyc0Cdj8I0w4YKsdYX0jBTbhXQBePTF73Jmex//++
   30sxDxZ+lZET/yh+PKeqImqZppNC1MscD9ZZeDtIY//zD6XUMaGToNo7s
   A56J2VZh87WjEhmUYk3Ql+RQCD+zUaSY6r9ZMuio8FrLHuWwV5bHhj1Q6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="259390782"
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="259390782"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 09:49:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,234,1643702400"; 
   d="scan'208";a="523105183"
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
Subject: [PATCH V3 12/30] x86/sgx: Export sgx_encl_{grow,shrink}()
Date:   Mon,  4 Apr 2022 09:49:20 -0700
Message-Id: <97f03b1ad11ff70839bdf239609a62957c804523.1648847675.git.reinette.chatre@intel.com>
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

In order to use sgx_encl_{grow,shrink}() in the page augmentation code
located in encl.c, export these functions.

Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V2:
- New patch.

 arch/x86/kernel/cpu/sgx/encl.h  | 2 ++
 arch/x86/kernel/cpu/sgx/ioctl.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index 07abfc70c8e3..9d673d9531f0 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -120,5 +120,7 @@ bool sgx_va_page_full(struct sgx_va_page *va_page);
 void sgx_encl_free_epc_page(struct sgx_epc_page *page);
 struct sgx_encl_page *sgx_encl_load_page(struct sgx_encl *encl,
 					 unsigned long addr);
+struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl);
+void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page);
 
 #endif /* _X86_ENCL_H */
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 0c211af8e948..746acddbb774 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -17,7 +17,7 @@
 #include "encl.h"
 #include "encls.h"
 
-static struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
+struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
 {
 	struct sgx_va_page *va_page = NULL;
 	void *err;
@@ -43,7 +43,7 @@ static struct sgx_va_page *sgx_encl_grow(struct sgx_encl *encl)
 	return va_page;
 }
 
-static void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page)
+void sgx_encl_shrink(struct sgx_encl *encl, struct sgx_va_page *va_page)
 {
 	encl->page_cnt--;
 
-- 
2.25.1

