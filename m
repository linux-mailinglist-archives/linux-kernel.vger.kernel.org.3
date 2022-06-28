Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6AE55D6D6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240397AbiF1J6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344682AbiF1J5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:57:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F492F66C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ol0vCMaWlj3xRpRtD6xgeBpq8sM8wJOrSwpovqb5Oqg=; b=LGGJ6IUUPsmP67NCIIwApCOpZb
        C3zYxbyPHfbOBxCW8nVA3J77CnKzgUdEGrcBUV3yRNwfaB/ZDESe3mD/FgjE+qwIC+FXPnp9+0KI/
        b10WrelHhSRXWt9f4+/rkSKELiB7mI+r84ax9MEgSuBWgXj3lU6z9zXoB20zcl5jT7X3xtOc/OJNk
        4jacvMiRBIwsiYkoPxlFD1POjYF7IwPwECyqeFtB+TyIvVCrsM/8m+pPooR8syk+JpEgywsEMqNpX
        Np4WlLV6VcR0qd+t4yTXEq6dAr5MI/akvVUEqYk6WpPDcxOHZijRGsEl1UUJJb49TWJeefjydUCYY
        FySqfitA==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o67x7-00E15L-Dp; Tue, 28 Jun 2022 09:56:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AA4593001F3;
        Tue, 28 Jun 2022 11:56:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8BF512022E4D3; Tue, 28 Jun 2022 11:56:10 +0200 (CEST)
Date:   Tue, 28 Jun 2022 11:56:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     masahiroy@kernel.org, mmarek@suse.cz, paul.gortmaker@windriver.com,
        arnd@arndb.de
Cc:     rppt@kernel.org, bp@alien8.de, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH] kconfig: Add implicit CONFIG_ prefix to IS_ENABLED()
 and co
Message-ID: <YrrQOifFIiISf/3g@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Since IS_ENABLED() (and friends) are clearly meant to be used on
CONFIG_foo symbols and IS_ENABLED(CONFIG_ is so long and almost an
tautology, allow the more compact usage of: IS_ENABLED(foo).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---

With this on, something like:

  for i in IS_BUILTIN IS_MODULE IS_REACHABLE IS_ENABLED;
  do
	git grep -wl $i | while read file;
	do
		sed -ie "s/${i}(CONFIG_/${i}(/g" $file;
        done;
  done

can be used to convert all existing instance. Allowing, after time
passes, to remove the CONFIG_ usage if so desired.

---
 tools/include/linux/kconfig.h   |    7 ++++---
 include/linux/kconfig.h         |    7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

--- a/include/linux/kconfig.h
+++ b/include/linux/kconfig.h
@@ -38,6 +38,7 @@
  * When CONFIG_BOOGER is not defined, we generate a (... 1, 0) pair, and when
  * the last step cherry picks the 2nd arg, we get a zero.
  */
+#define _is_defined(x)			__or(__is_defined(x), __is_defined(CONFIG_##x))
 #define __is_defined(x)			___is_defined(x)
 #define ___is_defined(val)		____is_defined(__ARG_PLACEHOLDER_##val)
 #define ____is_defined(arg1_or_junk)	__take_second_arg(arg1_or_junk 1, 0)
@@ -47,14 +48,14 @@
  * otherwise. For boolean options, this is equivalent to
  * IS_ENABLED(CONFIG_FOO).
  */
-#define IS_BUILTIN(option) __is_defined(option)
+#define IS_BUILTIN(option) _is_defined(option)
 
 /*
  * IS_MODULE(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'm', 0
  * otherwise.  CONFIG_FOO=m results in "#define CONFIG_FOO_MODULE 1" in
  * autoconf.h.
  */
-#define IS_MODULE(option) __is_defined(option##_MODULE)
+#define IS_MODULE(option) _is_defined(option##_MODULE)
 
 /*
  * IS_REACHABLE(CONFIG_FOO) evaluates to 1 if the currently compiled
@@ -63,7 +64,7 @@
  * built-in code when CONFIG_FOO is set to 'm'.
  */
 #define IS_REACHABLE(option) __or(IS_BUILTIN(option), \
-				__and(IS_MODULE(option), __is_defined(MODULE)))
+				__and(IS_MODULE(option), _is_defined(MODULE)))
 
 /*
  * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y' or 'm',
--- a/tools/include/linux/kconfig.h
+++ b/tools/include/linux/kconfig.h
@@ -32,6 +32,7 @@
  * When CONFIG_BOOGER is not defined, we generate a (... 1, 0) pair, and when
  * the last step cherry picks the 2nd arg, we get a zero.
  */
+#define _is_defined(x)			__or(__is_defined(x), __is_defined(CONFIG_##x))
 #define __is_defined(x)			___is_defined(x)
 #define ___is_defined(val)		____is_defined(__ARG_PLACEHOLDER_##val)
 #define ____is_defined(arg1_or_junk)	__take_second_arg(arg1_or_junk 1, 0)
@@ -41,13 +42,13 @@
  * otherwise. For boolean options, this is equivalent to
  * IS_ENABLED(CONFIG_FOO).
  */
-#define IS_BUILTIN(option) __is_defined(option)
+#define IS_BUILTIN(option) _is_defined(option)
 
 /*
  * IS_MODULE(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'm', 0
  * otherwise.
  */
-#define IS_MODULE(option) __is_defined(option##_MODULE)
+#define IS_MODULE(option) _is_defined(option##_MODULE)
 
 /*
  * IS_REACHABLE(CONFIG_FOO) evaluates to 1 if the currently compiled
@@ -56,7 +57,7 @@
  * built-in code when CONFIG_FOO is set to 'm'.
  */
 #define IS_REACHABLE(option) __or(IS_BUILTIN(option), \
-				__and(IS_MODULE(option), __is_defined(MODULE)))
+				__and(IS_MODULE(option), _is_defined(MODULE)))
 
 /*
  * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y' or 'm',

