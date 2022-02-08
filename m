Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822D34ACDBC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbiBHBJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344153AbiBHAqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 19:46:12 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B857C061A73;
        Mon,  7 Feb 2022 16:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644281172; x=1675817172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8EpFNPqK4DbJWTi/iUeiaR91d3oTWcQUQu8VuBjJR+0=;
  b=CIqUnrNBOoznRL/jpluw/dAx4BhtbnEfnmQMGS9Ih9/HYOi0gz5jo32C
   IglfX5miebaH0QCTy9ZJcMEF+HJ5V2XlYFjpDXQJrzbkWxXBXRQKguPGt
   Ca4pme40vY11QUrye6WiZPPbYyCp1x2l6pLPhjS78WgehmUVBirYnDzMA
   uqUKeHcMk4HgaJWE79oq2qTmwa8Ybn2n5S4+YnieTt4ocQCs/rovFfYBC
   pl/fEI7b2Eu0ISHY0HjtsvT+UcXxCIxEIQ+N4H3xYXPor0gKNf210obbk
   o4g6OsIYH/6Mgp04hO7juelnxdO2S/UCAg+OF0Kqg8xF5Rpszj8guUd9Q
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="232407942"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="232407942"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:46:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="499389480"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 16:46:08 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 05/32] Documentation/x86: Document SGX permission details
Date:   Mon,  7 Feb 2022 16:45:27 -0800
Message-Id: <39ad1503cfa6004abfd3de1e3b01650e09cd9e4c.1644274683.git.reinette.chatre@intel.com>
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

Provide summary of the various permissions involved in
managing access to enclave pages. This summary documents
the foundation for additions related to runtime managing of
enclave page permissions that is made possible with SGX2.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- New patch.

 Documentation/x86/sgx.rst | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
index 265568a9292c..89ff924b1480 100644
--- a/Documentation/x86/sgx.rst
+++ b/Documentation/x86/sgx.rst
@@ -71,16 +71,34 @@ The processor tracks EPC pages in a hardware metadata structure called the
 which describes the owning enclave, access rights and page type among the other
 things.
 
-EPCM permissions are separate from the normal page tables.  This prevents the
-kernel from, for instance, allowing writes to data which an enclave wishes to
-remain read-only.  EPCM permissions may only impose additional restrictions on
-top of normal x86 page permissions.
-
 For all intents and purposes, the SGX architecture allows the processor to
 invalidate all EPCM entries at will.  This requires that software be prepared to
 handle an EPCM fault at any time.  In practice, this can happen on events like
 power transitions when the ephemeral key that encrypts enclave memory is lost.
 
+Details about enclave page permissions
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+EPCM permissions are separate from the normal page tables.  This prevents the
+kernel from, for instance, allowing writes to data which an enclave wishes
+to remain read-only.
+
+Three permission masks are relevant to SGX:
+
+* EPCM permissions.
+* Page Table Entry (PTE) permissions.
+* Virtual Memory Area (VMA) permissions.
+
+An enclave is only able to access an enclave page if all three permission
+masks enable it to do so.
+
+The relationships between the different permission masks are:
+
+* An SGX VMA can only be created if its permissions are the same or weaker
+  than the EPCM permissions.
+* PTEs are installed to match the EPCM permissions, but not be more
+  relaxed than the VMA permissions.
+
 Application interface
 =====================
 
-- 
2.25.1

