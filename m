Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75994BB0DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 05:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiBREsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 23:48:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiBREsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:48:02 -0500
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B5315A39;
        Thu, 17 Feb 2022 20:47:45 -0800 (PST)
Received: from grover.. (133-32-176-37.west.xps.vectant.ne.jp [133.32.176.37]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 21I4kcpE010407;
        Fri, 18 Feb 2022 13:46:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 21I4kcpE010407
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1645159600;
        bh=GN3A4s3pyb9fSh7Ms+c8YnkOwQrlzBzILa3sx7wg7n4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fjhE2x8OF4hry3M8b93q2elLg1KmVBLLr1Us8YxSi6WaCnrDF4Mu1x0K1r92mcl+l
         xzZEEG20cYqZPaOU90e2gG8nbcoZ8d/LeXZhUeDpYf2j3wyDWVaxNkoHaA/gk/iU4G
         6bRf08tBbVvo28ZikRbL3P9tMVGgHvFcCFbegrW/kLrXn9pMH24Tey+LKij59Ai2lQ
         0moyw9m50iI6JxrmJNYUJhm+OALH6Ba4O3r56Md7QQJhaLPJpTqKPRHmN4zFV+vNr1
         ccXcvxAzhWVq6lYdfjiAbHlwMiiiUim5N4fZcVhxgOCh/pGEsH+aa7fVdyCNWlQ8R6
         LgKHyk5T0a0pw==
X-Nifty-SrcIP: [133.32.176.37]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org, David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/2] certs: simplify empty certs creation in certs/Makefile
Date:   Fri, 18 Feb 2022 13:46:34 +0900
Message-Id: <20220218044634.169520-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220218044634.169520-1-masahiroy@kernel.org>
References: <20220218044634.169520-1-masahiroy@kernel.org>
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

To create an empty cert file, we need to pass "" to the extract-cert
tool, which is common for all the three call-sites of cmd_exract_certs.

Factor out the logic into extract-cert-in.

One exceptional case is PKCS#11 case, where we override extract-cert-in
with the URI.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 certs/Makefile | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/certs/Makefile b/certs/Makefile
index 68c1d7b9a388..d8443cfb1c40 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -13,12 +13,13 @@ obj-$(CONFIG_SYSTEM_BLACKLIST_KEYRING) += blacklist_nohashes.o
 endif
 
 quiet_cmd_extract_certs  = CERT    $@
-      cmd_extract_certs  = $(obj)/extract-cert $(2) $@
+      cmd_extract_certs  = $(obj)/extract-cert $(extract-cert-in) $@
+extract-cert-in = $(or $(filter-out $(obj)/extract-cert, $(real-prereqs)),"")
 
 $(obj)/system_certificates.o: $(obj)/x509_certificate_list
 
 $(obj)/x509_certificate_list: $(CONFIG_SYSTEM_TRUSTED_KEYS) $(obj)/extract-cert FORCE
-	$(call if_changed,extract_certs,$(if $(CONFIG_SYSTEM_TRUSTED_KEYS),$<,""))
+	$(call if_changed,extract_certs)
 
 targets += x509_certificate_list
 
@@ -52,22 +53,22 @@ $(obj)/x509.genkey:
 
 endif # CONFIG_MODULE_SIG_KEY
 
-# If CONFIG_MODULE_SIG_KEY isn't a PKCS#11 URI, depend on it
-ifneq ($(filter-out pkcs11:%, $(CONFIG_MODULE_SIG_KEY)),)
-X509_DEP := $(CONFIG_MODULE_SIG_KEY)
-endif
-
 $(obj)/system_certificates.o: $(obj)/signing_key.x509
 
-$(obj)/signing_key.x509: $(X509_DEP) $(obj)/extract-cert FORCE
-	$(call if_changed,extract_certs,$(if $(CONFIG_MODULE_SIG_KEY),$(if $(X509_DEP),$<,$(CONFIG_MODULE_SIG_KEY)),""))
+PKCS11_URI := $(filter pkcs11:%, $(CONFIG_MODULE_SIG_KEY))
+ifdef PKCS11_URI
+$(obj)/signing_key.x509: extract-cert-in := $(PKCS11_URI)
+endif
+
+$(obj)/signing_key.x509: $(filter-out $(PKCS11_URI),$(CONFIG_MODULE_SIG_KEY)) $(obj)/extract-cert FORCE
+	$(call if_changed,extract_certs)
 
 targets += signing_key.x509
 
 $(obj)/revocation_certificates.o: $(obj)/x509_revocation_list
 
 $(obj)/x509_revocation_list: $(CONFIG_SYSTEM_REVOCATION_KEYS) $(obj)/extract-cert FORCE
-	$(call if_changed,extract_certs,$(if $(CONFIG_SYSTEM_REVOCATION_KEYS),$<,""))
+	$(call if_changed,extract_certs)
 
 targets += x509_revocation_list
 
-- 
2.32.0

