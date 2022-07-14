Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A190957442E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 07:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiGNFHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 01:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiGNFHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 01:07:19 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBD2193D8;
        Wed, 13 Jul 2022 22:03:55 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 26E52j5E024585;
        Thu, 14 Jul 2022 14:02:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 26E52j5E024585
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1657774966;
        bh=gh5qXSnB7guosq/2r/U6NMm7kNaH/f1eCk7aqtUJfk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M8JY7j55M1Um364xUI0/jUYbdBs9CQkvcsQsO4BwF5lq3903GLEa3WOkLqkpQk0ol
         nLoR4RO4qr9HvfB7SN+4aKG8WHVgtRaQHjbPaWwZN8e+gutKEM5b1sT7HiJxJOoKFU
         hu6ht2cdmx1rYIJUb6/9b3MiNRG8jTNCsRi8MvLuEqmGghhuk8VvpZmb4xyA5R2YGU
         C1qPJ0HwQlf56R5HPfmPTk/V6tEH5ekps1EQMm4Qadj5D+ikkiWEmgHN0BouFchwyM
         W/qECXndV55bIfHoyyFLkY8f1sT0QJVXRNuoX5T2KxAw4O4JH5HMwkUnqngJUP7uRh
         q6PmdDPs6H2/Q==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] kbuild: rpm-pkg: pass 'linux' to --target option of rpmbuild
Date:   Thu, 14 Jul 2022 14:02:41 +0900
Message-Id: <20220714050243.16411-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220714050243.16411-1-masahiroy@kernel.org>
References: <20220714050243.16411-1-masahiroy@kernel.org>
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

Presumably, _target_os is defined even if the --target flag does not
specify it, but it is better to make it explicit.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.package | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 77b612183c08..5017f6b2da80 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -56,7 +56,7 @@ rpm-pkg:
 	$(MAKE) clean
 	$(CONFIG_SHELL) $(MKSPEC) >$(objtree)/kernel.spec
 	$(call cmd,src_tar,$(KERNELPATH),kernel.spec)
-	+rpmbuild $(RPMOPTS) --target $(UTS_MACHINE) -ta $(KERNELPATH).tar.gz \
+	+rpmbuild $(RPMOPTS) --target $(UTS_MACHINE)-linux -ta $(KERNELPATH).tar.gz \
 	--define='_smp_mflags %{nil}'
 
 # binrpm-pkg
@@ -66,7 +66,7 @@ binrpm-pkg:
 	$(MAKE) -f $(srctree)/Makefile
 	$(CONFIG_SHELL) $(MKSPEC) prebuilt > $(objtree)/binkernel.spec
 	+rpmbuild $(RPMOPTS) --define "_builddir $(objtree)" --target \
-		$(UTS_MACHINE) -bb $(objtree)/binkernel.spec
+		$(UTS_MACHINE)-linux -bb $(objtree)/binkernel.spec
 
 PHONY += deb-pkg
 deb-pkg:
-- 
2.34.1

