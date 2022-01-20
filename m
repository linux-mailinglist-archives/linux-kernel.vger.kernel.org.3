Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910A44954DC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 20:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347174AbiATTXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 14:23:34 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:24706 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243427AbiATTXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 14:23:31 -0500
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 20KJMCMO001376;
        Fri, 21 Jan 2022 04:22:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 20KJMCMO001376
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1642706533;
        bh=e7aATIIG+VEhoI3nC/mHzVmccU9dk9dBlThTaanPlSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mbJhvdlLRE2ESnBfuaVbAUo5c0rr+qIWClKFNU+NF5n3/pqjMaEJoFHBtArAzhtyZ
         025imjOK78Rz6EXfNri06RXcAwNsIULJs7Mo9w8CKmUlxRADfeoHGCUS3QTVv7N20r
         XlWZNYrbzatI5j98vt7cqhU1f09lJzquJmuzM7F7b8esaEqRgU2rW3w38orsqlO1M4
         L+ZCPARxdBcMSFnw0YHgkAFt7kPVGkYcrIqub9G10HclxfMgCKf1/ki7p7N9TYJaq0
         aG5ulSbCQ91EP/xocZT2enqbmRcmpdy0j9TG7gDTOZ2NcirY6y+Kn0MSb8A7ZjiTNu
         oGxK43KW4aI2w==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Michal Kubecek <mkubecek@suse.cz>,
        Masahiro Yamada <masahiroy@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] certs: Fix build error when CONFIG_MODULE_SIG_KEY is empty
Date:   Fri, 21 Jan 2022 04:22:05 +0900
Message-Id: <20220120192205.525103-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220120192205.525103-1-masahiroy@kernel.org>
References: <20220120192205.525103-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since b8c96a6b466c ("certs: simplify $(srctree)/ handling and remove
config_filename macro"), when CONFIG_MODULE_SIG_KEY is empty,
signing_key.x509 fails to build:

    CERT    certs/signing_key.x509
  Usage: extract-cert <source> <dest>
  make[1]: *** [certs/Makefile:78: certs/signing_key.x509] Error 2
  make: *** [Makefile:1831: certs] Error 2

Pass "" to the first argument of extract-cert to fix the build error.

Link: https://lore.kernel.org/linux-kbuild/20220120094606.2skuyb26yjlnu66q@lion.mk-sys.cz/T/#u
Fixes: b8c96a6b466c ("certs: simplify $(srctree)/ handling and remove config_filename macro")
Reported-by: Michal Kubecek <mkubecek@suse.cz>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 certs/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/Makefile b/certs/Makefile
index 0c459cfd09df..3ea7fe60823f 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -75,7 +75,7 @@ endif
 $(obj)/system_certificates.o: $(obj)/signing_key.x509
 
 $(obj)/signing_key.x509: $(X509_DEP) $(obj)/extract-cert FORCE
-	$(call if_changed,extract_certs,$(if $(X509_DEP),$<,$(CONFIG_MODULE_SIG_KEY)))
+	$(call if_changed,extract_certs,$(if $(CONFIG_MODULE_SIG_KEY),$(if $(X509_DEP),$<,$(CONFIG_MODULE_SIG_KEY)),""))
 endif # CONFIG_MODULE_SIG
 
 targets += signing_key.x509
-- 
2.32.0

