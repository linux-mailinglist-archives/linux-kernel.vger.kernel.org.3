Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A854B3000
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 23:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353905AbiBKWAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 17:00:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345375AbiBKWAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 17:00:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5B8C75;
        Fri, 11 Feb 2022 14:00:17 -0800 (PST)
Date:   Fri, 11 Feb 2022 22:00:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644616816;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lKd8q2+J3VOSwegSadHlfeWHmE9sZZFjkJGUTPDB8N0=;
        b=beAZlOqYihCa1r6LpMUoQk6XV2cHk3e7TgO6huaMgm5T4SFVs5tZx1fua9KlF0XDxpyPF0
        hDOPJkuqyhchvXKAmzlSvpUU+yZPs3KjBG4UHLVn0BFfPJLB4W882vJLUJ/JuDvQJMR6HD
        H0Medtv3hVm/iOxJmjnZXYVgYgen9wHRysnQQz2LvNB4yhF+EbhOf5QNen8QC8VgHesjN7
        Ed9y3mDuELUdERxFNl3yPuD4GT4zZkat4ENpafom51QZrvI8bAF7RNh9KIDE7hM4vOGaUL
        lefq2CXTcAWxRDBJCQAR3YhWAPGDtnzrwgg2piEcQw2JJQa0DqjsdN1+m65/mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644616816;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lKd8q2+J3VOSwegSadHlfeWHmE9sZZFjkJGUTPDB8N0=;
        b=Ejrc2oMxkKHq8sC0crD+FeUfav+jwSEi4FkhNzzNoe3Cet7pXslELM8D1Y+gjm6FMf30xh
        TdJqPg/iPSxP0aAA==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Fix NULL-pointer-dereference upon early
 test failure
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C90a31dfd640ea756fa324712e7cbab4a90fa7518=2E16443?=
 =?utf-8?q?55600=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C90a31dfd640ea756fa324712e7cbab4a90fa7518=2E164435?=
 =?utf-8?q?5600=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <164461681510.16921.7342982385624280943.tip-bot2@tip-bot2>
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

Commit-ID:     2d03861e0d1d1ee81efc59338101cdd86a7474f6
Gitweb:        https://git.kernel.org/tip/2d03861e0d1d1ee81efc59338101cdd86a7474f6
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 08 Feb 2022 13:48:39 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 11 Feb 2022 13:52:47 -08:00

selftests/sgx: Fix NULL-pointer-dereference upon early test failure

== Background ==

The SGX selftests track parts of the enclave binaries in an array:
encl->segment_tbl[]. That array is dynamically allocated early
(but not first) in the test's lifetime. The array is referenced
at the end of the test in encl_delete().

== Problem ==

encl->segment_tbl[] can be NULL if the test fails before its
allocation. That leads to a NULL-pointer-dereference in encl_delete().
This is triggered during early failures of the selftest like if the
enclave binary ("test_encl.elf") is deleted.

== Solution ==

Ensure encl->segment_tbl[] is valid before attempting to access
its members. The offset with which it is accessed, encl->nr_segments,
is initialized before encl->segment_tbl[] and thus considered valid
to use after the encl->segment_tbl[] check succeeds.

Fixes: 3200505d4de6 ("selftests/sgx: Create a heap for the test enclave")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lkml.kernel.org/r/90a31dfd640ea756fa324712e7cbab4a90fa7518.1644355600.git.reinette.chatre@intel.com
---
 tools/testing/selftests/sgx/load.c |  9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index 9d4322c..006b464 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -21,7 +21,7 @@
 
 void encl_delete(struct encl *encl)
 {
-	struct encl_segment *heap_seg = &encl->segment_tbl[encl->nr_segments - 1];
+	struct encl_segment *heap_seg;
 
 	if (encl->encl_base)
 		munmap((void *)encl->encl_base, encl->encl_size);
@@ -32,10 +32,11 @@ void encl_delete(struct encl *encl)
 	if (encl->fd)
 		close(encl->fd);
 
-	munmap(heap_seg->src, heap_seg->size);
-
-	if (encl->segment_tbl)
+	if (encl->segment_tbl) {
+		heap_seg = &encl->segment_tbl[encl->nr_segments - 1];
+		munmap(heap_seg->src, heap_seg->size);
 		free(encl->segment_tbl);
+	}
 
 	memset(encl, 0, sizeof(*encl));
 }
