Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3242574435
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 07:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbiGNFHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 01:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiGNFHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 01:07:19 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7AC193C8;
        Wed, 13 Jul 2022 22:03:55 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 26E52j5G024585;
        Thu, 14 Jul 2022 14:02:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 26E52j5G024585
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1657774968;
        bh=HuP/NgE3e2YKnte18ErEap8o8BxYAN/GPsNIuS117tU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c8SXeNmkDtTGxvqP6WKnZXeI1xQQTknQNh7wb1FLdX53PfZCgnQy8Vwp1JQ4SoHBC
         PE2eBp+qakFfKE4/TdhoM6rlhy0PEVGna+ulTWicyp/pqWvKYlrHwjDvzqXQvCn856
         SInNHSqxMk7xHbZ+rGOe89aOuU9mwcSNmyOW6QFyQHv1EJytm9KU7DPx0n1f+Mp4qY
         yuc/pwPw3pJ/rAefZIv2yneP+rRs+d8c6alXdsEjKXGLLiIxWfWSjyywRGO3RwYGV0
         7/3fCOnlnNZxSUOhd0FFdbY4rOm1k+s2HPdxA5vEB0sHhn/SUuLLNs76Elcfhs+dR2
         L9FM3nyWnXmgw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] kbuild: error out if $(INSTALL_MOD_PATH) contains % or :
Date:   Thu, 14 Jul 2022 14:02:43 +0900
Message-Id: <20220714050243.16411-4-masahiroy@kernel.org>
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

If the directory pass given to INSTALL_MOD_PATH contains % or :,
the module_install fails.

% is used in pattern rules, and : as the separator of dependencies.

Bail out with a clearer error message.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.modinst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index 16a02e9237d3..a4c987c23750 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -18,6 +18,9 @@ INSTALL_MOD_DIR ?= extra
 dst := $(MODLIB)/$(INSTALL_MOD_DIR)
 endif
 
+$(foreach x, % :, $(if $(findstring $x, $(dst)), \
+	$(error module installation path cannot contain '$x')))
+
 suffix-y				:=
 suffix-$(CONFIG_MODULE_COMPRESS_GZIP)	:= .gz
 suffix-$(CONFIG_MODULE_COMPRESS_XZ)	:= .xz
-- 
2.34.1

