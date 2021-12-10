Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE4447059F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243190AbhLJQbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbhLJQay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:30:54 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A069C0617A2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 08:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=HNiSJIcT+WgTuaTP9fJr+4ZtI7RCeEuBy0Bm4isXlec=; b=MZevILwoJEb/cjWREWAeyI8oSn
        1brhFTDcDx6OMDy7Q567zCLjahwUBHThQ0/3iw4Uo4rrTJPEzOZO6DwFDBD3pw42ptNFcJfUxYZt0
        fBMKPPw5XyOdsauEtQfgZEKfCfY33IBaUz9+CVNYTAmdzZGOiWMEkfD8spUazsjDLp3KKG8XWhwRm
        bPJHOngGzih+rlCNdHQP/Q2tCcWsWKliHf7/QcVtfSW+OCPX74QBKSAZy5laaH5/xP1nC3cE5MJQ9
        TwcayDzRCE2TMLe6LhoyZIWmggXkLM/pEw/5e4qFzYSIFdP9QvFlE3XkPvg7JA2OGYT1kI0GMKbAf
        NiE7ZgMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mvijm-000aWW-Ck; Fri, 10 Dec 2021 16:27:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81C51300459;
        Fri, 10 Dec 2021 17:27:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5F5EA2B3C36C2; Fri, 10 Dec 2021 17:27:09 +0100 (CET)
Message-ID: <20211210162313.377798220@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 10 Dec 2021 17:16:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, elver@google.com, keescook@chromium.org,
        hch@infradead.org, torvalds@linux-foundation.org, axboe@kernel.dk
Subject: [PATCH v2 2/9] atomic: Add xchg.tbl
References: <20211210161618.645249719@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tail of gen-atomic-instrumented.sh now looks like a hard-coded
variant of atomics.tbl, extract it into xchg.tbl.

Add meta-'M' to generate the order variants.

No change in generated files.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 scripts/atomic/atomic-tbl.sh              |   10 +++++-----
 scripts/atomic/atomics.tbl                |    2 +-
 scripts/atomic/gen-atomic-instrumented.sh |   18 ++----------------
 scripts/atomic/xchg.tbl                   |   13 +++++++++++++
 4 files changed, 21 insertions(+), 22 deletions(-)

--- a/scripts/atomic/atomic-tbl.sh
+++ b/scripts/atomic/atomic-tbl.sh
@@ -15,31 +15,31 @@ meta_in()
 #meta_has_ret(meta)
 meta_has_ret()
 {
-	meta_in "$1" "bBiIfFlRm"
+	meta_in "$1" "bBiIfFlRMm"
 }
 
 #meta_has_acquire(meta)
 meta_has_acquire()
 {
-	meta_in "$1" "BFIlR"
+	meta_in "$1" "BFIlRM"
 }
 
 #meta_has_release(meta)
 meta_has_release()
 {
-	meta_in "$1" "BFIRs"
+	meta_in "$1" "BFIRsM"
 }
 
 #meta_has_relaxed(meta)
 meta_has_relaxed()
 {
-	meta_in "$1" "BFIR"
+	meta_in "$1" "BFIRM"
 }
 
 #meta_has_macro(meta)
 meta_has_macro()
 {
-	meta_in "$1" "mn"
+	meta_in "$1" "Mmn"
 }
 
 #find_fallback_template(pfx, name, sfx, order)
--- a/scripts/atomic/atomics.tbl
+++ b/scripts/atomic/atomics.tbl
@@ -10,7 +10,7 @@
 # * F/f	- fetch: returns base type (has fetch_ variants)
 # * l	- load: returns base type (has _acquire order variant)
 # * s	- store: returns void (has _release order variant)
-# * m	- macro: with return value
+# * M/m	- macro: with return value
 # * n	- macro: with No return value
 #
 # Where args contains list of type[:name], where type is:
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -195,22 +195,8 @@ grep '^[a-z]' "$1" | while read name met
 	gen_proto "${meta}" "${name}" "atomic_long" "long" ${args}
 done
 
-for xchg in "xchg" "cmpxchg" "cmpxchg64"; do
-	for order in "" "_acquire" "_release" "_relaxed"; do
-		gen_proto_order_variant "m" "" "${xchg}" "" "${order}" "" "" "v:ptr" "V:..."
-	done
-done
-
-for order in "" "_acquire" "_release" "_relaxed"; do
-	gen_proto_order_variant "m" "" "try_cmpxchg" "" "${order}" "" "" "v:ptr" "p:oldp" "V:..."
-done
-
-for xchg in "cmpxchg_local" "cmpxchg64_local" "sync_cmpxchg"; do
-	gen_proto_order_variant "m" "" "${xchg}" "" "" "" "" "v:ptr" "V:..."
-done
-
-for xchg in "cmpxchg_double" "cmpxchg_double_local"; do
-	gen_proto_order_variant "m" "" "${xchg}" "" "" "" "" "P:ptr" "V:..."
+grep '^[a-z]' $(dirname $1)/xchg.tbl | while read name meta args; do
+	gen_proto "${meta}" "${name}" "" "" ${args}
 done
 
 cat <<EOF
--- /dev/null
+++ b/scripts/atomic/xchg.tbl
@@ -0,0 +1,13 @@
+# name	meta	args...
+#
+# see atomics.tbl for a description of meta and args...
+#
+xchg			M	v:ptr	V:...
+cmpxchg			M	v:ptr	V:...
+cmpxchg64		M	v:ptr	V:...
+try_cmpxchg		M	v:ptr	p:oldp	V:...
+cmpxchg_local		m	v:ptr	V:...
+cmpxchg64_local		m	v:ptr	V:...
+sync_cmpxchg		m	v:ptr	V:...
+cmpxchg_double		m	P:ptr	V:...
+cmpxchg_double_local	m	P:ptr	V:...


