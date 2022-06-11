Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B22D5476D6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 19:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238589AbiFKRXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 13:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbiFKRXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 13:23:43 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EDB3CA69;
        Sat, 11 Jun 2022 10:23:37 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 25BHMhjO022692;
        Sun, 12 Jun 2022 02:22:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 25BHMhjO022692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654968164;
        bh=8AWMt733UhcZGFWaooWxFtWrKXN+8+wup6CjtPDO6HI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XYhJnBknDInKrNeS1UG7IGBZnYZHMyxY0WhfBjLIHd/8MruGSwXYxXiXr+gBoNnEY
         BHg9VYYgaDMSN7ZL2sQibUwk/wyIAQdvOXOHWPW+SpiqGub0cioXWLqnXG2LoYArP0
         l8kleYoBIwQLLCaseDFKM0PqGK7lvFG+YmyK2TxcUv8R8r0RZGU3EwmIDpaKjM0pPq
         1LB5ljuwYVk1hL26y74JLaJXjBUufWut56ic5xuctz2bFRERJUUPMelydqSArn79iY
         tw7zh9Zrn50iCoFVqlPuIy3uVj8Gh5rOcYLIaEmcKgDb38eX5dBv0lQzEZYEF4eyeU
         CbH/r/y4TbRmA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?q?Micka=8F=AB=B3l=20Sala=8F=AB=E4n?= 
        <mic@linux.microsoft.com>, Masahiro Yamada <masahiroy@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] certs: fix and refactor CONFIG_SYSTEM_BLACKLIST_HASH_LIST build
Date:   Sun, 12 Jun 2022 02:22:31 +0900
Message-Id: <20220611172233.1494073-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220611172233.1494073-1-masahiroy@kernel.org>
References: <20220611172233.1494073-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit addf466389d9 ("certs: Check that builtin blacklist hashes are
valid") was applied 8 months after the submission.

In the meantime, the base code had been removed by commit b8c96a6b466c
("certs: simplify $(srctree)/ handling and remove config_filename
macro").

Fix the Makefile.

Create a local copy of $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST). It is
included from certs/blacklist_hashes.c and also works as a timestamp.

Send error messages from check-blacklist-hashes.awk to stderr instead
of stdout.

Fixes: addf466389d9 ("certs: Check that builtin blacklist hashes are valid")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 certs/.gitignore         |  2 +-
 certs/Makefile           | 20 ++++++++++----------
 certs/blacklist_hashes.c |  2 +-
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/certs/.gitignore b/certs/.gitignore
index 56637aceaf81..cec5465f31c1 100644
--- a/certs/.gitignore
+++ b/certs/.gitignore
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-/blacklist_hashes_checked
+/blacklist_hash_list
 /extract-cert
 /x509_certificate_list
 /x509_revocation_list
diff --git a/certs/Makefile b/certs/Makefile
index cb1a9da3fc58..a8d628fd5f7b 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -7,22 +7,22 @@ obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o c
 obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o common.o
 obj-$(CONFIG_SYSTEM_REVOCATION_LIST) += revocation_certificates.o
 ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),)
-quiet_cmd_check_blacklist_hashes = CHECK   $(patsubst "%",%,$(2))
-      cmd_check_blacklist_hashes = $(AWK) -f $(srctree)/scripts/check-blacklist-hashes.awk $(2); touch $@
 
-$(eval $(call config_filename,SYSTEM_BLACKLIST_HASH_LIST))
+$(obj)/blacklist_hashes.o: $(obj)/blacklist_hash_list
+CFLAGS_blacklist_hashes.o := -I $(obj)
 
-$(obj)/blacklist_hashes.o: $(obj)/blacklist_hashes_checked
+quiet_cmd_check_and_copy_blacklist_hash_list = GEN     $@
+      cmd_check_and_copy_blacklist_hash_list = \
+	$(AWK) -f $(srctree)/scripts/check-blacklist-hashes.awk $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) >&2; \
+	cat $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) > $@
 
-CFLAGS_blacklist_hashes.o += -I$(srctree)
-
-targets += blacklist_hashes_checked
-$(obj)/blacklist_hashes_checked: $(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(SYSTEM_BLACKLIST_HASH_LIST_FILENAME) scripts/check-blacklist-hashes.awk FORCE
-	$(call if_changed,check_blacklist_hashes,$(SYSTEM_BLACKLIST_HASH_LIST_SRCPREFIX)$(CONFIG_SYSTEM_BLACKLIST_HASH_LIST))
+$(obj)/blacklist_hash_list: $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) FORCE
+	$(call if_changed,check_and_copy_blacklist_hash_list)
 obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_hashes.o
 else
 obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_nohashes.o
 endif
+targets += blacklist_hash_list
 
 quiet_cmd_extract_certs  = CERT    $@
       cmd_extract_certs  = $(obj)/extract-cert $(extract-cert-in) $@
@@ -33,7 +33,7 @@ $(obj)/system_certificates.o: $(obj)/x509_certificate_list
 $(obj)/x509_certificate_list: $(CONFIG_SYSTEM_TRUSTED_KEYS) $(obj)/extract-cert FORCE
 	$(call if_changed,extract_certs)
 
-targets += x509_certificate_list blacklist_hashes_checked
+targets += x509_certificate_list
 
 # If module signing is requested, say by allyesconfig, but a key has not been
 # supplied, then one will need to be generated to make sure the build does not
diff --git a/certs/blacklist_hashes.c b/certs/blacklist_hashes.c
index d5961aa3d338..86d66fe11348 100644
--- a/certs/blacklist_hashes.c
+++ b/certs/blacklist_hashes.c
@@ -2,6 +2,6 @@
 #include "blacklist.h"
 
 const char __initconst *const blacklist_hashes[] = {
-#include CONFIG_SYSTEM_BLACKLIST_HASH_LIST
+#include "blacklist_hash_list"
 	, NULL
 };
-- 
2.32.0

