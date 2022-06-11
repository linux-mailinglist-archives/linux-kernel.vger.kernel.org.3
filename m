Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948645476D7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 19:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbiFKRX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 13:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbiFKRXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 13:23:43 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30783CA54;
        Sat, 11 Jun 2022 10:23:37 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 25BHMhjQ022692;
        Sun, 12 Jun 2022 02:22:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 25BHMhjQ022692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654968166;
        bh=A23KTIgin1aGL7tlLpcBM/pr60oqIzwLBoV8Wxeh2p0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Llyi0YLJ14b5QWQVQPqHLa7n2JvTbXAheXVqnQLLwV0dA7csg05zwWc8mLxmZ0bTj
         rAV3r35WL7MPi6o487lTvAsb//1F7Y4OHCgePgTH/1I+q/IVsQZhWBgSB2yvhdP10e
         YZmOYrv0zRp/1mQaUqky6+MZM3SdSr3Z778OEhDjM84ORNU5/nqSdtOdXt7dB7NP9f
         sIlf0jfmyFU8xV0RBK52K66MsXzXjxfBObAHb7cgkwgAHL7vpN8KPUzR64FTmW0lou
         DGiWioOnHdDVKsgy2fW8e6xGEgYUaUjVATsKAe7hwOOUHouugTZhBJH3DjyTuDrbR7
         FIfgpRrAQ1IeQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?q?Micka=8F=AB=B3l=20Sala=8F=AB=E4n?= 
        <mic@linux.microsoft.com>, Masahiro Yamada <masahiroy@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] certs: unify blacklist_hashes.c and blacklist_nohashes.c
Date:   Sun, 12 Jun 2022 02:22:33 +0900
Message-Id: <20220611172233.1494073-4-masahiroy@kernel.org>
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

These two files are very similar. Unify them.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 certs/Makefile             | 12 +++++-------
 certs/blacklist_hashes.c   |  1 -
 certs/blacklist_nohashes.c |  6 ------
 3 files changed, 5 insertions(+), 14 deletions(-)
 delete mode 100644 certs/blacklist_nohashes.c

diff --git a/certs/Makefile b/certs/Makefile
index df7aaeafd19c..7068d45db807 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -4,24 +4,22 @@
 #
 
 obj-$(CONFIG_SYSTEM_TRUSTED_KEYRING) += system_keyring.o system_certificates.o common.o
-obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o common.o
+obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist.o common.o blacklist_hashes.o
 obj-$(CONFIG_SYSTEM_REVOCATION_LIST) += revocation_certificates.o
-ifneq ($(CONFIG_SYSTEM_BLACKLIST_HASH_LIST),)
 
 $(obj)/blacklist_hashes.o: $(obj)/blacklist_hash_list
 CFLAGS_blacklist_hashes.o := -I $(obj)
 
 quiet_cmd_check_and_copy_blacklist_hash_list = GEN     $@
       cmd_check_and_copy_blacklist_hash_list = \
+	$(if $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST), \
 	$(AWK) -f $(srctree)/$(src)/check-blacklist-hashes.awk $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) >&2; \
-	cat $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) > $@
+	{ cat $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST); echo $(comma) NULL; } > $@, \
+	echo NULL > $@)
 
 $(obj)/blacklist_hash_list: $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) FORCE
 	$(call if_changed,check_and_copy_blacklist_hash_list)
-obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_hashes.o
-else
-obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_nohashes.o
-endif
+
 targets += blacklist_hash_list
 
 quiet_cmd_extract_certs  = CERT    $@
diff --git a/certs/blacklist_hashes.c b/certs/blacklist_hashes.c
index 86d66fe11348..0c5476abebd9 100644
--- a/certs/blacklist_hashes.c
+++ b/certs/blacklist_hashes.c
@@ -3,5 +3,4 @@
 
 const char __initconst *const blacklist_hashes[] = {
 #include "blacklist_hash_list"
-	, NULL
 };
diff --git a/certs/blacklist_nohashes.c b/certs/blacklist_nohashes.c
deleted file mode 100644
index 753b703ef0ef..000000000000
--- a/certs/blacklist_nohashes.c
+++ /dev/null
@@ -1,6 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include "blacklist.h"
-
-const char __initconst *const blacklist_hashes[] = {
-	NULL
-};
-- 
2.32.0

