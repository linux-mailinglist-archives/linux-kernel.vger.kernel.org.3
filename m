Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417DD59B09B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 23:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbiHTVlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 17:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHTVlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 17:41:51 -0400
Received: from mx5.cs.washington.edu (mx5.cs.washington.edu [IPv6:2607:4000:200:11::6a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B2227FEA
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 14:41:50 -0700 (PDT)
Received: from mx5.cs.washington.edu (localhost [IPv6:0:0:0:0:0:0:0:1])
        by mx5.cs.washington.edu (8.17.1/8.17.1/1.26) with ESMTP id 27KLfdHh1089230;
        Sat, 20 Aug 2022 14:41:39 -0700
Received: from attu4.cs.washington.edu (attu4.cs.washington.edu [IPv6:2607:4000:200:10:0:0:0:8c])
        (authenticated bits=128)
        by mx5.cs.washington.edu (8.17.1/8.17.1/1.26) with ESMTPSA id 27KLfcRO1089226
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
        Sat, 20 Aug 2022 14:41:38 -0700
Received: from attu4.cs.washington.edu (localhost [127.0.0.1])
        by attu4.cs.washington.edu (8.15.2/8.15.2/1.23) with ESMTP id 27KLfcHB498192;
        Sat, 20 Aug 2022 14:41:38 -0700
Received: (from klee33@localhost)
        by attu4.cs.washington.edu (8.15.2/8.15.2/Submit/1.2) id 27KLfcr6498191;
        Sat, 20 Aug 2022 14:41:38 -0700
From:   Kenneth Lee <klee33@uw.edu>
To:     apw@canonical.com, joe@perches.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com
Cc:     linux-kernel@vger.kernel.org, Kenneth Lee <klee33@uw.edu>
Subject: [PATCH] checkpatch: add ALLOC_UNNECESSARY_ARRAY test
Date:   Sat, 20 Aug 2022 14:41:20 -0700
Message-Id: <20220820214120.497971-1-klee33@uw.edu>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using calloc|malloc_array(1, ...) can be simplified to zalloc|malloc(...)
and improves semantics. This is because we are only allocating one element
so there is no need to use the array version of the methods.

This can be applied to kvmalloc_array, kvcalloc, kcalloc, devm_kcalloc,
and devm_kmalloc_array. Note that there is no devm_kvmalloc_array or
devm_kvcalloc, so the regex does not check for this.

Signed-off-by: Kenneth Lee <klee33@uw.edu>
---
This is my first patch that is not a trivial cleanup, so please let me
know if I am approaching something wrong. Also unsure if the warning
name should be something else besides ALLOC_UNNECESSARY_ARRAY
---
 scripts/checkpatch.pl | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 79e759aac543..83d3a9f308ea 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7079,6 +7079,19 @@ sub process {
 			     "$1 uses number as first arg, sizeof is generally wrong\n" . $herecurr);
 		}
 
+# check for use of unnecessary array alloc methods
+# calloc|malloc_array(1, ...) should be zalloc|malloc(...)
+		if ($line =~ /(\b(?:devm_(?:kcalloc|kmalloc_array))|\b(?:kv|k)(?:calloc|malloc_array))\s*\(\s*1\s*,/) {
+			my $newfunc = "kmalloc";
+			$newfunc = "kvmalloc" if ($1 eq "kvmalloc_array");
+			$newfunc = "kvzalloc" if ($1 eq "kvcalloc");
+			$newfunc = "kzalloc" if ($1 eq "kcalloc");
+			$newfunc = "devm_kzalloc" if ($1 eq "devm_kcalloc");
+			$newfunc = "devm_kmalloc" if ($1 eq "devm_kmalloc_array");
+			WARN("ALLOC_UNNECESSARY_ARRAY",
+			     "$1(1, ...) can be simplified to $newfunc(...)\n" . $herecurr);
+		}
+
 # check for multiple semicolons
 		if ($line =~ /;\s*;\s*$/) {
 			if (WARN("ONE_SEMICOLON",
-- 
2.31.1

