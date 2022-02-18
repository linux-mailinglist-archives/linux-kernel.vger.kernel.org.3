Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FC44BB0DC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 05:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiBREsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 23:48:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiBREsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:48:02 -0500
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BFD2A267;
        Thu, 17 Feb 2022 20:47:45 -0800 (PST)
Received: from grover.. (133-32-176-37.west.xps.vectant.ne.jp [133.32.176.37]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 21I4kcpD010407;
        Fri, 18 Feb 2022 13:46:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 21I4kcpD010407
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1645159599;
        bh=JIjbg7vgzAe37E26iyaSzTnZQmUAVRx74bHrvZXfv4Y=;
        h=From:To:Cc:Subject:Date:From;
        b=0ZMfvvYrLvkbVPttL8eDFaVoj19pgO+okECRE1fVHZRBMuTUaUAWIu1Aji3zl9cek
         Fukii7oFc2BT2GII/0p2Wu0Yxkishv8Fb5Nnd4ljU+K27K6t8yA4yIRuVIH5/B4imN
         WG6LPfkJJ5wWdXimKmd0MaSjrR31IP5a6ANeUc6rs1wjKHwBa17Yc+zolWH6B4gfE8
         eWUxEU6i1WRIL4HqRFo275ycNsjLv0bvWq6FvndkFDkxygUpVvyrWcxnEbAwG/O7d0
         onyaiAo00EdgBB1bktFaD8KSa0M/tKzci/Qc3eSiboivfvISKrLK1U99dWE4K6xz2B
         kEEkTZ6LK8wAA==
X-Nifty-SrcIP: [133.32.176.37]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org, David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/2] certs: include certs/signing_key.x509 unconditionally
Date:   Fri, 18 Feb 2022 13:46:33 +0900
Message-Id: <20220218044634.169520-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
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

I do not see much sense in the #if conditional in system_certificates.S;
even if the condition is true, there exists no signing key when
CONFIG_MODULE_SIG_KEY="".

So, certs/Makefile generates empty certs/signing_key.x509 in such a
case. We can always do this, irrespective of CONFIG_MODULE_SIG or
(CONFIG_IMA_APPRAISE_MODSIG && CONFIG_MODULES).

We only need to check CONFIG_MODULE_SIG_KEY, then both *.S and Makefile
will become much simpler.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 certs/Makefile              | 16 ----------------
 certs/system_certificates.S |  3 ---
 2 files changed, 19 deletions(-)

diff --git a/certs/Makefile b/certs/Makefile
index 3ea7fe60823f..68c1d7b9a388 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -22,25 +22,10 @@ $(obj)/x509_certificate_list: $(CONFIG_SYSTEM_TRUSTED_KEYS) $(obj)/extract-cert
 
 targets += x509_certificate_list
 
-ifeq ($(CONFIG_MODULE_SIG),y)
-	SIGN_KEY = y
-endif
-
-ifeq ($(CONFIG_IMA_APPRAISE_MODSIG),y)
-ifeq ($(CONFIG_MODULES),y)
-	SIGN_KEY = y
-endif
-endif
-
-ifdef SIGN_KEY
-###############################################################################
-#
 # If module signing is requested, say by allyesconfig, but a key has not been
 # supplied, then one will need to be generated to make sure the build does not
 # fail and that the kernel may be used afterwards.
 #
-###############################################################################
-
 # We do it this way rather than having a boolean option for enabling an
 # external private key, because 'make randconfig' might enable such a
 # boolean option and we unfortunately can't make it depend on !RANDCONFIG.
@@ -76,7 +61,6 @@ $(obj)/system_certificates.o: $(obj)/signing_key.x509
 
 $(obj)/signing_key.x509: $(X509_DEP) $(obj)/extract-cert FORCE
 	$(call if_changed,extract_certs,$(if $(CONFIG_MODULE_SIG_KEY),$(if $(X509_DEP),$<,$(CONFIG_MODULE_SIG_KEY)),""))
-endif # CONFIG_MODULE_SIG
 
 targets += signing_key.x509
 
diff --git a/certs/system_certificates.S b/certs/system_certificates.S
index e1645e6f4d97..003e25d4a17e 100644
--- a/certs/system_certificates.S
+++ b/certs/system_certificates.S
@@ -9,10 +9,7 @@
 system_certificate_list:
 __cert_list_start:
 __module_cert_start:
-#if defined(CONFIG_MODULE_SIG) || (defined(CONFIG_IMA_APPRAISE_MODSIG) \
-			       && defined(CONFIG_MODULES))
 	.incbin "certs/signing_key.x509"
-#endif
 __module_cert_end:
 	.incbin "certs/x509_certificate_list"
 __cert_list_end:
-- 
2.32.0

