Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCE857BE56
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 21:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiGTTXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 15:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiGTTXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 15:23:07 -0400
X-Greylist: delayed 548 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Jul 2022 12:23:06 PDT
Received: from blackbird.sr71.net (unknown [198.145.64.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 788A14F6A4;
        Wed, 20 Jul 2022 12:23:06 -0700 (PDT)
Received: from ray2.sr71.net (localhost [127.0.0.1])
        by blackbird.sr71.net (Postfix) with ESMTP id 1829EFA866;
        Wed, 20 Jul 2022 12:13:58 -0700 (PDT)
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     dave@sr71.net
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Haitao Huang <haitao.huang@linux.intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] x86/sgx: Allow enclaves to use Asynchrounous Exit Notification
Date:   Wed, 20 Jul 2022 12:13:47 -0700
Message-Id: <20220720191347.1343986-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1:
 * Make sure SGX_ATTR_ASYNC_EXIT_NOTIFY is in the masks that are
   used at bare-metal enclave initialization and that enumerates
   available attributes to KVM guests.

--

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
attribute is cleared from the list reserved attributes.  Instead
of adding to the open-coded lists of individual attributes,
add named lists of privileged (disallowed by default) and
unprivileged (allowed by default) attributes.  Add the AEX notify
attribute as an unprivileged attribute, which will keep the kernel
from rejecting enclaves with it set.

I just built this and ran it to make sure there were no obvious
regressions since I do not have the hardware (and new microcde)
to test it.

Testing on bare-metal and in VMs accompanied by Tested-by's
would be much appreciated.  (This means you, Intel folks who
actually have systems with the microcode that can do this.)

1. https://github.com/jovanbulck/sgx-step
2. https://cdrdv2.intel.com/v1/dl/getContent/671368?explicitVersion=true

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Kai Huang <kai.huang@intel.com>
Cc: Haitao Huang <haitao.huang@linux.intel.com>
Cc: x86@kernel.org
Cc: linux-sgx@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/sgx.h      | 33 ++++++++++++++++++++++++++-------
 arch/x86/kernel/cpu/sgx/ioctl.c |  2 +-
 arch/x86/kvm/cpuid.c            |  4 +---
 3 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
index 3f9334ef67cd..3004dfe76498 100644
--- a/arch/x86/include/asm/sgx.h
+++ b/arch/x86/include/asm/sgx.h
@@ -110,17 +110,36 @@ enum sgx_miscselect {
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
+
+#define SGX_ATTR_UNPRIV_MASK	(SGX_ATTR_DEBUG	    | \
+				 SGX_ATTR_MODE64BIT | \
+				 SGX_ATTR_KSS	    | \
+				 SGX_ATTR_ASYNC_EXIT_NOTIFY)
+
+#define SGX_ATTR_PRIV_MASK	(SGX_ATTR_PROVISIONKEY	| \
+				 SGX_ATTR_EINITTOKENKEY)
 
 /**
  * struct sgx_secs - SGX Enclave Control Structure (SECS)
diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 83df20e3e633..37d523895244 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -110,7 +110,7 @@ static int sgx_encl_create(struct sgx_encl *encl, struct sgx_secs *secs)
 	encl->base = secs->base;
 	encl->size = secs->size;
 	encl->attributes = secs->attributes;
-	encl->attributes_mask = SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT | SGX_ATTR_KSS;
+	encl->attributes_mask = SGX_ATTR_UNPRIV_MASK;
 
 	/* Set only after completion, as encl->lock has not been taken. */
 	set_bit(SGX_ENCL_CREATED, &encl->flags);
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 0c1ba6aa0765..96a73b5b4369 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1022,9 +1022,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		 * userspace.  ATTRIBUTES.XFRM is not adjusted as userspace is
 		 * expected to derive it from supported XCR0.
 		 */
-		entry->eax &= SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT |
-			      SGX_ATTR_PROVISIONKEY | SGX_ATTR_EINITTOKENKEY |
-			      SGX_ATTR_KSS;
+		entry->eax &= SGX_ATTR_PRIV_MASK | SGX_ATTR_UNPRIV_MASK;
 		entry->ebx &= 0;
 		break;
 	/* Intel PT */
-- 
2.34.1

