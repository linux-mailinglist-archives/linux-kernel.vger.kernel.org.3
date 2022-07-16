Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC555576CCC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 11:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiGPJdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 05:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiGPJdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 05:33:00 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492502657A;
        Sat, 16 Jul 2022 02:32:58 -0700 (PDT)
Received: from grover.sesame ([133.106.62.13]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 26G9VZu3010688;
        Sat, 16 Jul 2022 18:31:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 26G9VZu3010688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1657963897;
        bh=lo5mfoKD7vRR8DCYCccjxLLxvc3Zerc9iud4vad1cjM=;
        h=From:To:Cc:Subject:Date:From;
        b=tkPRoc/IKNMhC15S0dVGMiXp5Y6Al6ATPBFzkIeDcLgtp16gxEImu4M6A3bdlZ8YW
         EmCEgER2gk6jph2g+jCpCN7mCYNakohvyk86OoeaGpfWaP70w9BZ8h3f8DFsdcw9y/
         4j7iwF+mm5LscWv0pbH2BnrqwZMF7Qkmx132dXeNx/245XJKojzO/HaeOnKQIvJ/yc
         6x8kANnU2awHonRtuq8Vff0yxpsKEJQD/W89IAYrkA0oOrPRuTWZ9/bPHoP+32gHBN
         rItGiAnsVYFx1MV62ksAvrhFn5nLIEa1pDAuO0kIfZUIvyNc8E1aypYtvv+6dl7J9Z
         NZMe2titjEKNw==
X-Nifty-SrcIP: [133.106.62.13]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: add dtbs_prepare target
Date:   Sat, 16 Jul 2022 18:31:22 +0900
Message-Id: <20220716093122.137494-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the common prerequisites for DT compilation into the new
target, dtbs_prepare.

Add comments in case you wonder why include/config/kernel.release is
the prerequisite. Our policy is that installation targets must not
(re)compile any build artifacts in the tree. If we make modules_install
depend on include/config/kernel.release and it is executed under the
root privilege, it may be owned by root.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index a9bd55edb75e..8aa4dbb8f878 100644
--- a/Makefile
+++ b/Makefile
@@ -1367,16 +1367,22 @@ endif
 
 ifneq ($(dtstree),)
 
-%.dtb: include/config/kernel.release scripts_dtc
+%.dtb: dtbs_prepare
 	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
 
-%.dtbo: include/config/kernel.release scripts_dtc
+%.dtbo: dtbs_prepare
 	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@
 
-PHONY += dtbs dtbs_install dtbs_check
-dtbs: include/config/kernel.release scripts_dtc
+PHONY += dtbs dtbs_prepare dtbs_install dtbs_check
+dtbs: dtbs_prepare
 	$(Q)$(MAKE) $(build)=$(dtstree)
 
+# include/config/kernel.release is not actually required for building DTBs,
+# but for installing DTBs because INSTALL_DTBS_PATH contains $(KERNELRELEASE).
+# We do not want to move it to dtbs_install. The policy is installation
+# targets (, which may run as root) must not modify the tree.
+dtbs_prepare: include/config/kernel.release scripts_dtc
+
 ifneq ($(filter dtbs_check, $(MAKECMDGOALS)),)
 export CHECK_DTBS=y
 dtbs: dt_binding_check
-- 
2.34.1

