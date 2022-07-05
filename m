Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE935676AA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbiGESjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiGESi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:38:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF6A1EED0;
        Tue,  5 Jul 2022 11:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657046335; x=1688582335;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bp/6skjaHsxhHpW9+rU5zrpeFxQXZKGs9YnkmuQGVP8=;
  b=YFmK8QzleZ2+Oj7ovd/cL6offmnX+u8cWdJpPg+m+8iHxCkL141O8WOx
   ScjTSGPwHk92+vAXVKGs5NznqhHalQGVW8DW34n+xrxpy63azkJCnT+Pb
   xda5G34m9iEiiSxr9RgjxXuN7E45PNVCbnoVX4phrU96jzZ9QnYg9yXJK
   UOYWR1onRyXYvqaZsrBUh7/sY9PGEPOxun3xgyAuguewG9NgqAsIxK7Wc
   X1NtUXLRJ2Xz6cv3tnBG5M5rhLtOp5eLXoqhvjPIENxlm8K/iJtdMqJNc
   tp/LQZbCdxKpbu+qSQ+DMxwbZPfxYkF3vOGoOqLETzqLAfuq6jl5oRkZ2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="284173882"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="284173882"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 11:38:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="619965099"
Received: from viggo.jf.intel.com (HELO ray2.sr71.net) ([10.54.77.144])
  by orsmga008.jf.intel.com with ESMTP; 05 Jul 2022 11:38:55 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-sgx@vger.kernel.org
Subject: [PATCH] x86/sgx: Allow enclaves to use Asynchrounous Exit Notification
Date:   Tue,  5 Jul 2022 11:36:48 -0700
Message-Id: <20220705183648.3739111-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Short Version:

Allow enclaves to use the new Asynchronous EXit (AEX)
notification mechanism.  This mechanism lets enclaves run a
handler after an AEX event.  These handlers can run mitigations
for things like SGX-Step[1].

AEX Notify will be made available both on upcoming processors and
on some older processors through microcode updates.

Long Version:

== SGX Attribute Background ==

The SGX architecture includes a list of SGX "attributes".  These
attributes ensure consistency and transparency around specific
enclave features.

As a simple example, the "DEBUG" attribute allows an enclave to
be debugged, but also destroys virtually all of SGX security.
Using attributes, enclaves can know that they are being debugged.
Attributes also affect enclave attestation so an enclave can, for
instance, be denied access to secrets while it is being debugged.

The kernel keeps a list of known attributes and will only
initialize enclaves that use a known set of attributes.  This
kernel policy eliminates the chance that a new SGX attribute
could cause undesired effects.

For example, imagine a new attribute was added called
"PROVISIONKEY2" that provided similar functionality to
"PROVISIIONKEY".  A kernel policy that allowed indiscriminate use
of unknown attributes and thus PROVISIONKEY2 would undermine the
existing kernel policy which limits use of PROVISIONKEY enclaves.

== AEX Notify Background ==

"Intel Architecture Instruction Set Extensions and Future
Features - Version 45" is out[2].  There is a new chapter:

	Asynchronous Enclave Exit Notify and the EDECCSSA User Leaf Function.

Enclaves exit can be either synchronous and consensual (EEXIT for
instance) or asynchronous (on an interrupt or fault).  The
asynchronous ones can evidently be exploited to single step
enclaves[1], on top of which other naughty things can be built.

AEX Notify will be made available both on upcoming processors and
on some older processors through microcode updates.

== The Problem ==

These attacks are currently entirely opaque to the enclave since
the hardware does the save/restore under the covers. The
Asynchronous Enclave Exit Notify (AEX Notify) mechanism provides
enclaves an ability to detect and mitigate potential exposure to
these kinds of attacks.

== The Solution ==

Define the new attribute value for AEX Notification.  Ensure the
attribute is cleared from the list reserved attributes which
allows it to be used in enclaves.

I just built this and ran it to make sure there were no obvious
regressions since I do not have the hardware to test it handy.
Tested-by's would be much appreciated.

1. https://github.com/jovanbulck/sgx-step
2. https://cdrdv2.intel.com/v1/dl/getContent/671368?explicitVersion=true

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-sgx@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/sgx.h | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index 3f9334ef67cd..f7328d8efd83 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -110,17 +110,28 @@ enum sgx_miscselect {
  * %SGX_ATTR_EINITTOKENKEY:	Allow to use token signing key that is used to
  *				sign cryptographic tokens that can be passed to
  *				EINIT as an authorization to run an enclave.
+ * %SGX_ATTR_ASYNC_EXIT_NOTIFY:	Allow enclaves to be notified after an
+ *				asynchronous exit has occurred.
  */
 enum sgx_attribute {
-	SGX_ATTR_INIT		= BIT(0),
-	SGX_ATTR_DEBUG		= BIT(1),
-	SGX_ATTR_MODE64BIT	= BIT(2),
-	SGX_ATTR_PROVISIONKEY	= BIT(4),
-	SGX_ATTR_EINITTOKENKEY	= BIT(5),
-	SGX_ATTR_KSS		= BIT(7),
+	SGX_ATTR_INIT		   = BIT(0),
+	SGX_ATTR_DEBUG		   = BIT(1),
+	SGX_ATTR_MODE64BIT	   = BIT(2),
+				  /* BIT(3) is reserved */
+	SGX_ATTR_PROVISIONKEY	   = BIT(4),
+	SGX_ATTR_EINITTOKENKEY	   = BIT(5),
+				  /* BIT(6) is for CET */
+	SGX_ATTR_KSS		   = BIT(7),
+				  /* BIT(8) is reserved */
+				  /* BIT(9) is reserved */
+	SGX_ATTR_ASYNC_EXIT_NOTIFY = BIT(10),
 };
 
-#define SGX_ATTR_RESERVED_MASK	(BIT_ULL(3) | BIT_ULL(6) | GENMASK_ULL(63, 8))
+#define SGX_ATTR_RESERVED_MASK	(BIT_ULL(3) | \
+				 BIT_ULL(6) | \
+				 BIT_ULL(8) | \
+				 BIT_ULL(9) | \
+				 GENMASK_ULL(63, 11))
 
 /**
  * struct sgx_secs - SGX Enclave Control Structure (SECS)
-- 
2.34.1

