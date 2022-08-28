Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E625A3AE9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 04:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiH1Cki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 22:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1Ck0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 22:40:26 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1F419C01;
        Sat, 27 Aug 2022 19:40:23 -0700 (PDT)
Received: from localhost.localdomain (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 27S2e6Gj030639;
        Sun, 28 Aug 2022 11:40:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 27S2e6Gj030639
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1661654407;
        bh=GBayUjw41o8Ha0J4vO9A3wCOvGjxHrTwsRhpPXXTmuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ByT6NL1vCaRIYM1STLowZiUmlIgG7PkN+6+lGPAn8L/R2Cr7XzQruqQd2MVCCKMtU
         vbFLivYm+qeSFa65gBldUTzt7dKj/u4XsGdq+1tgZ2fCLnQjg0fRaQ1llfvhrzt639
         HPfW585oZ0YgeVqmpliddnnW+XQ5eOM8KHJW1ZUFtfYV/+23Iiam8BfcF4vduFDAPl
         2LKRGxtoL3D2FW5vwFrMjgMp3SLhwcWfyIk0S53RMYEtCbY8cZn++Gz5twlzs47sey
         xAXaBQDKHW1z5lgLtZiipdCn07Ec3SIdEHQXW/Jl8faI0ObNbvB6tluAUWr9+00LtZ
         yPwMEFKL/00ow==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 01/15] kbuild: remove duplicated dependency between modules and modules_check
Date:   Sun, 28 Aug 2022 11:39:49 +0900
Message-Id: <20220828024003.28873-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220828024003.28873-1-masahiroy@kernel.org>
References: <20220828024003.28873-1-masahiroy@kernel.org>
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

The dependency, "modules: modules_check" is specified twice.
Commit 1a998be620a1 ("kbuild: check module name conflict for external
modules as well") missed to clean it up.

'PHONY += modules' also appears twice.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 7c955e906445..f04126181885 100644
--- a/Makefile
+++ b/Makefile
@@ -1436,8 +1436,7 @@ endif
 # Build modules
 #
 
-PHONY += modules
-modules: $(if $(KBUILD_BUILTIN),vmlinux) modules_check modules_prepare
+modules: $(if $(KBUILD_BUILTIN),vmlinux) modules_prepare
 
 cmd_modules_order = cat $(real-prereqs) > $@
 
-- 
2.34.1

