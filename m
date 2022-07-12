Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C7F5729BC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 01:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiGLXOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 19:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiGLXNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 19:13:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910D9B0B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 16:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657667611; x=1689203611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ccx0RgNBfz7piuZWOrmJMdKV3R7Gsc2VojQmQ6vSEyk=;
  b=ifL0xduc/fDMqiPNBhFClh9G4EwjNcFoQlebl7l5MhYE6iQUsTBgmgk9
   UAqniLm9Sa1UqsLs2BatJb6rtuqDP9rxxEyRFPOB94Gq+6+zCWztIAmax
   ZapTFsw0bL9i7cPkJ8YBEp6VkQAneDHuanlDOjTSHyph+qy6UWD7vjmF8
   zXO1W/8n0KkXtn120Vl/LjDJ7ySeIG2l4R6ZKg+S8NE38dgESgi7vNH5C
   d6ju6jfVuoem4RqedvC1IiDjf2d6fy9iUltcU53pQzdfTh5GDDVf+bW3e
   8erim6MGybFleHelJlulHGawl7Xy5qi+mWWwf6+qkwJ3BhiSi6gQK1G/A
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="285808447"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="285808447"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 16:13:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="592792970"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 12 Jul 2022 16:13:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 4ABDA6CE; Wed, 13 Jul 2022 02:13:30 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Weihong Zhang <weihong.zhang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv5 OPTIONAL 13/13] selftests/x86/lam: Add tests cases for LAM_U48
Date:   Wed, 13 Jul 2022 02:13:28 +0300
Message-Id: <20220712231328.5294-14-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712231328.5294-1-kirill.shutemov@linux.intel.com>
References: <20220712231328.5294-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weihong Zhang <weihong.zhang@intel.com>

LAM supports configurations that differ regarding which pointer bits are masked.
With LAM_U48, bits 62:48 in pointers can be masked as metadata bits, the width
of LAM is 15.

Add test cases in existed test scenarios:

MALLOC:

 - Enable LAM_U48, masks bits 48:62 of user pointers as metadata, the
   process can dereference these pointers.

MMAP:

 - Enable LAM_U48, mmaping with high address (above bits 47) have to be
   failed, which lead to trigger SIGSEGV.

 - LAM_U48 can't be enabled if there is a mmaping with high
   address(above bits 47) before enable LAM_U48.

SYSCALL:

 - LAM supports set metadata in high bits 62:48 (LAM48) of user process,
   pass these pointers to SYSCALL, SYSCALL can dereference pointers and
   return correct result.

IO_URING:

 - Add LAM_U48 test on IO_URING, Enable LAM_U48, set metadata in bits
   62:48 of buffers, IO_URING can handle these buffers well.

FORK/EXEC:

 - Add LAM_U48 test cases in inherit scenarios. these cases should same
   as LAM_U57;

Signed-off-by: Weihong Zhang <weihong.zhang@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 tools/testing/selftests/x86/lam.c | 67 ++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index fcac5feb47d0..b354e57bf072 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -24,6 +24,7 @@
 /* LAM modes, these definitions were copied from kernel code */
 #define LAM_NONE                0
 #define LAM_U57_BITS            6
+#define LAM_U48_BITS            15
 /* arch prctl for LAM */
 #define ARCH_GET_UNTAG_MASK     0x4001
 #define ARCH_ENABLE_TAGGED_ADDR 0x4002
@@ -126,7 +127,7 @@ static int set_lam(unsigned long lam)
 	int ret = 0;
 	uint64_t ptr = 0;
 
-	if (lam != LAM_U57_BITS && lam != LAM_NONE)
+	if (lam != LAM_U48_BITS && lam != LAM_U57_BITS && lam != LAM_NONE)
 		return -1;
 
 	/* Skip check return */
@@ -138,6 +139,8 @@ static int set_lam(unsigned long lam)
 	/* Check mask returned is expected */
 	if (lam == LAM_U57_BITS)
 		ret = (ptr != ~(0x3fULL << 57));
+	else if (lam == LAM_U48_BITS)
+		ret = (ptr != ~(0x7fffULL << 48));
 	else if (lam == LAM_NONE)
 		ret = (ptr != -1ULL);
 
@@ -161,6 +164,8 @@ static int get_lam(void)
 		ret = LAM_U57_BITS;
 	else if (ptr == -1ULL)
 		ret = LAM_NONE;
+	else if (ptr == ~(0x7fffULL << 48))
+		ret = LAM_U48_BITS;
 
 
 	return ret;
@@ -176,6 +181,9 @@ static uint64_t get_metadata(uint64_t src, unsigned long lam)
 	metadata = rand();
 
 	switch (lam) {
+	case LAM_U48_BITS: /* Set metadata in bits 62:48 */
+		metadata = (src & ~(0x7fffULL << 48)) | ((metadata & 0x7fff) << 48);
+		break;
 	case LAM_U57_BITS: /* Set metadata in bits 62:57 */
 		metadata = (src & ~(0x3fULL << 57)) | ((metadata & 0x3f) << 57);
 		break;
@@ -552,6 +560,9 @@ int do_uring(unsigned long lam)
 			uint64_t addr = ((uint64_t)fi->iovecs[i].iov_base);
 
 			switch (lam) {
+			case LAM_U48_BITS: /* Clear bits 62:48 */
+				addr = (addr & ~(0x7fffULL << 48));
+				break;
 			case LAM_U57_BITS: /* Clear bits 62:57 */
 				addr = (addr & ~(0x3fULL << 57));
 				break;
@@ -696,6 +707,12 @@ static struct testcases uring_cases[] = {
 		.test_func = handle_uring,
 		.msg = "URING: LAM_U57. Dereferencing pointer with metadata\n",
 	},
+	{
+		.later = 0,
+		.lam = LAM_U48_BITS,
+		.test_func = handle_uring,
+		.msg = "URING: LAM_U48. Dereferencing pointer with metadata.\n",
+	},
 	{
 		.later = 1,
 		.expected = 1,
@@ -712,6 +729,12 @@ static struct testcases malloc_cases[] = {
 		.test_func = handle_malloc,
 		.msg = "MALLOC: LAM_U57. Dereferencing pointer with metadata\n",
 	},
+	{
+		.later = 0,
+		.lam = LAM_U48_BITS,
+		.test_func = handle_malloc,
+		.msg = "MALLOC: LAM_U48. Dereferencing pointer with metadata.\n",
+	},
 	{
 		.later = 1,
 		.expected = 2,
@@ -728,6 +751,12 @@ static struct testcases syscall_cases[] = {
 		.test_func = handle_syscall,
 		.msg = "SYSCALL: LAM_U57. syscall with metadata\n",
 	},
+	{
+		.later = 0,
+		.lam = LAM_U48_BITS,
+		.test_func = handle_syscall,
+		.msg = "SYSCALL: LAM_U48. syscall with metadata\n",
+	},
 	{
 		.later = 1,
 		.expected = 1,
@@ -738,6 +767,14 @@ static struct testcases syscall_cases[] = {
 };
 
 static struct testcases mmap_cases[] = {
+	{
+		.later = 0,
+		.expected = 2,
+		.lam = LAM_U48_BITS,
+		.addr = HIGH_ADDR,
+		.test_func = handle_mmap,
+		.msg = "MMAP: [Negtive] First LAM_U48, then High address.\n",
+	},
 	{
 		.later = 1,
 		.expected = 0,
@@ -746,6 +783,14 @@ static struct testcases mmap_cases[] = {
 		.test_func = handle_mmap,
 		.msg = "MMAP: First mmap high address, then set LAM_U57.\n",
 	},
+	{
+		.later = 1,
+		.expected = 1,
+		.lam = LAM_U48_BITS,
+		.addr = HIGH_ADDR,
+		.test_func = handle_mmap,
+		.msg = "MMAP: [Negtive] First mmap high address, then set LAM_U48.\n",
+	},
 	{
 		.later = 0,
 		.expected = 0,
@@ -762,6 +807,14 @@ static struct testcases mmap_cases[] = {
 		.test_func = handle_mmap,
 		.msg = "MMAP: First LAM_U57, then Low address.\n",
 	},
+	{
+		.later = 0,
+		.expected = 0,
+		.lam = LAM_U48_BITS,
+		.addr = LOW_ADDR,
+		.test_func = handle_mmap,
+		.msg = "MMAP: First LAM_U48, then low address.\n",
+	},
 };
 
 static struct testcases inheritance_cases[] = {
@@ -771,12 +824,24 @@ static struct testcases inheritance_cases[] = {
 		.test_func = handle_inheritance,
 		.msg = "FORK: LAM_U57, child process should get LAM mode same as parent\n",
 	},
+	{
+		.expected = 0,
+		.lam = LAM_U48_BITS,
+		.test_func = handle_inheritance,
+		.msg = "FORK: LAM_U48, child process should get LAM mode same as parent\n",
+	},
 	{
 		.expected = 0,
 		.lam = LAM_U57_BITS,
 		.test_func = handle_execve,
 		.msg = "EXECVE: LAM_U57, child process should get disabled LAM mode\n",
 	},
+	{
+		.expected = 0,
+		.lam = LAM_U48_BITS,
+		.test_func = handle_execve,
+		.msg = "EXECVE: LAM_U48, child process should get disabled LAM mode\n",
+	},
 };
 
 static void cmd_help(void)
-- 
2.35.1

