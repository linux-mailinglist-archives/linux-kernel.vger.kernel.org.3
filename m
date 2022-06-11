Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4ABA5476D4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 19:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbiFKRXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 13:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238181AbiFKRXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 13:23:43 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C317B3CFC9;
        Sat, 11 Jun 2022 10:23:37 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 25BHMhjP022692;
        Sun, 12 Jun 2022 02:22:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 25BHMhjP022692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654968165;
        bh=MMlWHI79ZXLVfVOPspFzx7WO3YALeI7+en73nS8lFyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BPPzm9G0e6v8UIo5UGvWV0+CS09mXXIW3BFcw18fSZLEkOet4hu6efpdPrCVjuOWb
         I2CJb4QtmLSyESS+JDvVKxbDWuhE1Zbejlb6XpWGX0e/FGzVUU+RhEylEtIVu9hI9G
         Sux8kMsCqnJ+Z2lQHhnmBJjiBbaqwaRlYUH5SmP1mZv3stMcrG/bXRvNxNu9kmkJ4L
         VhE6vEpva8xUzxhrMLQZI+6qDiLomI4r1XkR5XTZo8rjakxevx3rBFskiMw+mf45o3
         Njb+uypw1Pk1fqynv+6cNh1GqX7/AK0dvTB4zmiG1JUyiyn6x1i1BtvIdm+kcfIT55
         3RaI0LCqLS0xw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?q?Micka=8F=AB=B3l=20Sala=8F=AB=E4n?= 
        <mic@linux.microsoft.com>, Masahiro Yamada <masahiroy@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] certs: move scripts/check-blacklist-hashes.awk to certs/
Date:   Sun, 12 Jun 2022 02:22:32 +0900
Message-Id: <20220611172233.1494073-3-masahiroy@kernel.org>
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

This script is only used in certs/Makefile, so certs/ is a better
home for it.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 MAINTAINERS                                   | 1 -
 certs/Makefile                                | 2 +-
 {scripts => certs}/check-blacklist-hashes.awk | 0
 3 files changed, 1 insertion(+), 2 deletions(-)
 rename {scripts => certs}/check-blacklist-hashes.awk (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1fc9ead83d2a..7c2a7c304824 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4627,7 +4627,6 @@ L:	keyrings@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/module-signing.rst
 F:	certs/
-F:	scripts/check-blacklist-hashes.awk
 F:	scripts/sign-file.c
 F:	tools/certs/
 
diff --git a/certs/Makefile b/certs/Makefile
index a8d628fd5f7b..df7aaeafd19c 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -13,7 +13,7 @@ CFLAGS_blacklist_hashes.o := -I $(obj)
 
 quiet_cmd_check_and_copy_blacklist_hash_list = GEN     $@
       cmd_check_and_copy_blacklist_hash_list = \
-	$(AWK) -f $(srctree)/scripts/check-blacklist-hashes.awk $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) >&2; \
+	$(AWK) -f $(srctree)/$(src)/check-blacklist-hashes.awk $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) >&2; \
 	cat $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) > $@
 
 $(obj)/blacklist_hash_list: $(CONFIG_SYSTEM_BLACKLIST_HASH_LIST) FORCE
diff --git a/scripts/check-blacklist-hashes.awk b/certs/check-blacklist-hashes.awk
similarity index 100%
rename from scripts/check-blacklist-hashes.awk
rename to certs/check-blacklist-hashes.awk
-- 
2.32.0

