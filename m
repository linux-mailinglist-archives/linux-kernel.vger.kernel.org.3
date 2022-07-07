Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C38C56AAA4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbiGGS2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236376AbiGGS1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:27:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC3D5A46F;
        Thu,  7 Jul 2022 11:27:37 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218455;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qFzrDo3LNNe7xaXTxt9rHG1m0jzIZEvP7XMJ0ZuNWzk=;
        b=2sHe8hUuVBICiBnKv+fdIF/JARgu5NkY6fOWu6B5grzg7fHtbVQYoCMp/Q0VUc5bGuzPy+
        JgeFOC1xdbG4LZIezljPkn8FYO7OmTYXNqZkTR1LhJT67LpkyH3MSlTHRLuS+IeCeUiuM1
        ND7p5XWr9fEv6e5W4VMPOXBqtHMLo5irCijOpoy9RxyRrZjyoW95vPJYyCnsRxez7sMTR3
        uB9HHFeIGkWPRiQ7BJsZjrwdEZ1F2pjeK/nSvHo9NXIfU7c6jvGbmABFI+jNOCWsPhj9ZV
        Cj9MjPkHKk836N4B18cH/y0cvniPs6JognxdHJEzHosXxnBhOeWH2vilAqQP3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218455;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qFzrDo3LNNe7xaXTxt9rHG1m0jzIZEvP7XMJ0ZuNWzk=;
        b=HmiKzVSJVoQ50AKj5/DTdDT8np7h1D5qmwWLDdBysT0HqaZP3FdxCHovc5wMEiBVyQkcjh
        nsMfjD76VQr/CiCA==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Introduce dynamic entry point
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C93e9c420dedf5f773ba6965c18245bc7d62aca83=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C93e9c420dedf5f773ba6965c18245bc7d62aca83=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721845475.15455.9759564937321882112.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     7eb4370152beb2f1e25543088bce2e3f0621ab81
Gitweb:        https://git.kernel.org/tip/7eb4370152beb2f1e25543088bce2e3f0621ab81
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:09:01 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:04 -07:00

selftests/sgx: Introduce dynamic entry point

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
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/93e9c420dedf5f773ba6965c18245bc7d62aca83.1652137848.git.reinette.chatre@intel.com
---
 tools/testing/selftests/sgx/test_encl_bootstrap.S | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/testing/selftests/sgx/test_encl_bootstrap.S
index 82fb0df..03ae0f5 100644
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
 
