Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B1A4F67B7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbiDFRaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239105AbiDFR3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:29:12 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCE439A693;
        Wed,  6 Apr 2022 08:31:41 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 236FUcaW017647;
        Thu, 7 Apr 2022 00:30:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 236FUcaW017647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649259044;
        bh=xi61ivU7WXkz9So9Rg07E0Isc4c3Oyfk6ijcms131ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l/IgoVgbWFj4IWz0iLgxZnxikrdfuYjVN6WHn7/uITderaEbd7ocTNr8lMizOBJZF
         92dFshMCkZoro3xeyINSpOoNGu3R9SpiwiRDVQtS3w0pLoiVtJwmuN0/hWbp7MQwC8
         +au02BeAuOnZhIAKNolJ3KRjBGo7KFVcfYXW7hpGIToMoFPPQrdZgmzH2cBy+QcSVL
         gU11ko1P5ByatlJPIlEjvqP8rVja0eyYLhTzp3zzFwC2fFFneD1BDhKX8R1gPvBw//
         oF498F8fSyPQMTy8vC+nsfhrvLdHulLRcDCYQ1lHuCu8SV8yeRSNE/OCgES+dKeAeK
         k4zfy3YU1ZmVQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 7/7] kbuild: read *.mod to get objects passed to $(LD) or $(AR)
Date:   Thu,  7 Apr 2022 00:30:23 +0900
Message-Id: <20220406153023.500847-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220406153023.500847-1-masahiroy@kernel.org>
References: <20220406153023.500847-1-masahiroy@kernel.org>
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

ld and ar support @file, which command-line options are read from.

Now that *.mod lists the member objects in the correct order, without
duplication, it is ready to be passed to ld and ar.

By using the @file syntax, people will not be worried about the pitfall
described in the NOTE.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.build | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 3da731cf6978..f6a506318795 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -450,22 +450,18 @@ quiet_cmd_ar_lib = AR      $@
 $(obj)/lib.a: $(lib-y) FORCE
 	$(call if_changed,ar_lib)
 
-# NOTE:
-# Do not replace $(filter %.o,^) with $(real-prereqs). When a single object
-# module is turned into a multi object module, $^ will contain header file
-# dependencies recorded in the .*.cmd file.
 ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
 quiet_cmd_link_multi-m = AR [M]  $@
 cmd_link_multi-m =						\
 	$(cmd_update_lto_symversions);				\
 	rm -f $@; 						\
-	$(AR) cDPrsT $@ $(filter %.o,$^)
+	$(AR) cDPrsT $@ @$(patsubst %.o,%.mod,$@)
 else
 quiet_cmd_link_multi-m = LD [M]  $@
-      cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter %.o,$^)
+      cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ @$(patsubst %.o,%.mod,$@)
 endif
 
-$(multi-obj-m): FORCE
+$(multi-obj-m): %.o: %.mod FORCE
 	$(call if_changed,link_multi-m)
 $(call multi_depend, $(multi-obj-m), .o, -objs -y -m)
 
-- 
2.32.0

