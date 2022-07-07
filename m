Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E27856AA95
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbiGGS1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbiGGS1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:27:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECBE5A2DF;
        Thu,  7 Jul 2022 11:27:36 -0700 (PDT)
Date:   Thu, 07 Jul 2022 18:27:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657218454;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SqAo/PVKyAt6loE1MQhW84rDqNPsr9M3MwOg5xRSsX0=;
        b=SA0bMWCBd97hgB4Dhf53H7vGwABUVxhhIlpw/9XhxA/BFEQsf8yP1XsOpGFQbjylNraPWT
        3qhUD476Ps2tMVea5MG8O+mk1p4QTjIU1tqOeZjalwW8T0S9cyvH3FL7n2qkw09Fo0jbYO
        9FDB095V2i2wysCVITiOJTnCC/Xae/N+NTtck5KpjU1lX8VZh/+Mln+9MszVlMqi4dFFNl
        ZGTturPe69brMX2RlYc2nm0TMmneqKKY0tXIdyX05O6U/z6WRidthb8urd0C54InjnkboZ
        oaKdBu8ZmwJALWL0ZUOHH0dfu16A96YWSp7lYVlQLwZPh00AahjDbkhdMe1+ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657218454;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SqAo/PVKyAt6loE1MQhW84rDqNPsr9M3MwOg5xRSsX0=;
        b=zh9Gn8CdxAoBtCN2+KoaNl52HGWfMc16Yu41e/7rLzcWzwD1GgeOJimTODw+gCe9zOYQ1R
        rWvnQvVzIXbQlmDQ==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Introduce TCS initialization enclave operation
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cbad6052056188bde753a54313da1ac8f1e29088a=2E16521?=
 =?utf-8?q?37848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Cbad6052056188bde753a54313da1ac8f1e29088a=2E165213?=
 =?utf-8?q?7848=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165721845384.15455.15798019288134106051.tip-bot2@tip-bot2>
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

Commit-ID:     b564982fda13be6314e49f2344e7c422565e34d3
Gitweb:        https://git.kernel.org/tip/b564982fda13be6314e49f2344e7c422565e34d3
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 10 May 2022 11:09:02 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Jul 2022 10:13:04 -07:00

selftests/sgx: Introduce TCS initialization enclave operation

The Thread Control Structure (TCS) contains meta-data used by the
hardware to save and restore thread specific information when
entering/exiting the enclave. A TCS can be added to an initialized
enclave by first adding a new regular enclave page, initializing the
content of the new page from within the enclave, and then changing that
page's type to a TCS.

Support the initialization of a TCS from within the enclave.
The variable information needed that should be provided from outside
the enclave is the address of the TCS, address of the State Save Area
(SSA), and the entry point that the thread should use to enter the
enclave. With this information provided all needed fields of a TCS
can be initialized.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lkml.kernel.org/r/bad6052056188bde753a54313da1ac8f1e29088a.1652137848.git.reinette.chatre@intel.com
---
 tools/testing/selftests/sgx/defines.h   |  8 ++++++-
 tools/testing/selftests/sgx/test_encl.c | 30 ++++++++++++++++++++++++-
 2 files changed, 38 insertions(+)

diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selftests/sgx/defines.h
index b638eb9..d8587c9 100644
--- a/tools/testing/selftests/sgx/defines.h
+++ b/tools/testing/selftests/sgx/defines.h
@@ -26,6 +26,7 @@ enum encl_op_type {
 	ENCL_OP_NOP,
 	ENCL_OP_EACCEPT,
 	ENCL_OP_EMODPE,
+	ENCL_OP_INIT_TCS_PAGE,
 	ENCL_OP_MAX,
 };
 
@@ -68,4 +69,11 @@ struct encl_op_emodpe {
 	uint64_t flags;
 };
 
+struct encl_op_init_tcs_page {
+	struct encl_op_header header;
+	uint64_t tcs_page;
+	uint64_t ssa;
+	uint64_t entry;
+};
+
 #endif /* DEFINES_H */
diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index 5b6c653..c0d6397 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -57,6 +57,35 @@ static void *memcpy(void *dest, const void *src, size_t n)
 	return dest;
 }
 
+static void *memset(void *dest, int c, size_t n)
+{
+	size_t i;
+
+	for (i = 0; i < n; i++)
+		((char *)dest)[i] = c;
+
+	return dest;
+}
+
+static void do_encl_init_tcs_page(void *_op)
+{
+	struct encl_op_init_tcs_page *op = _op;
+	void *tcs = (void *)op->tcs_page;
+	uint32_t val_32;
+
+	memset(tcs, 0, 16);			/* STATE and FLAGS */
+	memcpy(tcs + 16, &op->ssa, 8);		/* OSSA */
+	memset(tcs + 24, 0, 4);			/* CSSA */
+	val_32 = 1;
+	memcpy(tcs + 28, &val_32, 4);		/* NSSA */
+	memcpy(tcs + 32, &op->entry, 8);	/* OENTRY */
+	memset(tcs + 40, 0, 24);		/* AEP, OFSBASE, OGSBASE */
+	val_32 = 0xFFFFFFFF;
+	memcpy(tcs + 64, &val_32, 4);		/* FSLIMIT */
+	memcpy(tcs + 68, &val_32, 4);		/* GSLIMIT */
+	memset(tcs + 72, 0, 4024);		/* Reserved */
+}
+
 static void do_encl_op_put_to_buf(void *op)
 {
 	struct encl_op_put_to_buf *op2 = op;
@@ -100,6 +129,7 @@ void encl_body(void *rdi,  void *rsi)
 		do_encl_op_nop,
 		do_encl_eaccept,
 		do_encl_emodpe,
+		do_encl_init_tcs_page,
 	};
 
 	struct encl_op_header *op = (struct encl_op_header *)rdi;
