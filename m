Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494FD57442D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 07:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbiGNFHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 01:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiGNFHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 01:07:17 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D1C186D3;
        Wed, 13 Jul 2022 22:03:55 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 26E52j5F024585;
        Thu, 14 Jul 2022 14:02:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 26E52j5F024585
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1657774967;
        bh=6PBSAGLUCdmVZ4v3fyCX6+8X7AUwDfZAbY+nDDOXwGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bWnphJpPxxcJ7B2pb/svEFmOdbM6Kq3hFJ0ll56tzJG7AVLXJTlnW1igIrLpxJ0sT
         9mo0Da+ECrkG0ei6uag4Pemc8fpWoSvwz82K98BmiAywNutM6Dk2rSDX0a+9q7byGY
         xSg8qmXJelXZzNe++ceQr2dDbNgznnipZJrueGadS8OtAtsgs//qjl0anSjlNYQtmA
         F9H+u7/cRZ99qmpyKuvjrXor07d8xAF7raumuVGvZXVwEsldjw2/NJNu60G7lczoH2
         Bkmk9CmU8NzN76z3Zun6Gmd/AHLsYNlLQXti4Squ3TVd1HStB1SjW8QUvmC6c0d3Mz
         0rkWcK9JY3wRg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] kbuild: error out if $(KBUILD_EXTMOD) contains % or :
Date:   Thu, 14 Jul 2022 14:02:42 +0900
Message-Id: <20220714050243.16411-3-masahiroy@kernel.org>
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

If the directory pass given to KBUILD_EXTMOD (or M=) contains % or :,
the module fails to build.

% is used in pattern rules, and : as the separator of dependencies.

Bail out with a clearer error message.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index faa4880f25f7..ecda62e27553 100644
--- a/Makefile
+++ b/Makefile
@@ -129,6 +129,9 @@ endif
 $(if $(word 2, $(KBUILD_EXTMOD)), \
 	$(error building multiple external modules is not supported))
 
+$(foreach x, % :, $(if $(findstring $x, $(KBUILD_EXTMOD)), \
+	$(error module directory path cannot contain '$x')))
+
 # Remove trailing slashes
 ifneq ($(filter %/, $(KBUILD_EXTMOD)),)
 KBUILD_EXTMOD := $(shell dirname $(KBUILD_EXTMOD).)
-- 
2.34.1

