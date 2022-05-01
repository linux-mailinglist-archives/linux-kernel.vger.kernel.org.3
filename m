Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D37D51630A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343959AbiEAIqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343538AbiEAIpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:45:53 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215BA4C785;
        Sun,  1 May 2022 01:42:24 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2418f2Rw008518;
        Sun, 1 May 2022 17:41:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2418f2Rw008518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651394469;
        bh=QmTs3PR7KEELPPIayd/c+OePSoC6ZzypNfbFAbQl0aE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oomdjl7AUftSaHcbRjkePwpd8QcyDHk+DfgteGdrMEx8naD6UgDs0xnMbaXQihoXK
         I4O5mpf0X8RUR5yryYpjV8h9ekor1yYmPBlrzs5r651ZGMDWXiCHfToUv5Yb4WKI/l
         9RYxGEEAnTjXr21d9o/glYL5G4x3MDJstqWtXVg3WbraluYqFhVzMRfwLOJg890rR5
         ry6YVdmkJ3nK9kkJlBJO/CuA/f5A7x4UOieo7olmhMWcihi+qMdwELZmGothV7CA3k
         6OGf+jVscInMlb2VfBLS604DAiLzW93/+a/NbymU/PMJHP1qbpEOS3w9WQ4UUNbLkt
         jauqmYGG/3qeQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v2 11/26] modpost: make multiple export error
Date:   Sun,  1 May 2022 17:40:17 +0900
Message-Id: <20220501084032.1025918-12-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220501084032.1025918-1-masahiroy@kernel.org>
References: <20220501084032.1025918-1-masahiroy@kernel.org>
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

This is currently a warning, but I think modpost should stop building
in this case.

If the same symbol is exported multiple times and we let it keep going,
the sanity check becomes difficult.

Only the legitimate case is that an external module overrides the
corresponding in-tree module to provide a different implementation
with the same interface.

Also, there exists an upstream example that exploits this feature.

  $ make M=tools/testing/nvdimm

... builds tools/testing/nvdimm/libnvdimm.ko. This is a mocked module
that overrides the symbols from drivers/nvdimm/libnvdimm.ko.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

Changes in v2:
  - Add more commit description

 scripts/mod/modpost.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 4ce8d164b8e0..1f01fc942f94 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -417,9 +417,9 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 		list_add_tail(&s->list, &mod->exported_symbols);
 	} else if (!external_module || s->module->is_vmlinux ||
 		   s->module == mod) {
-		warn("%s: '%s' exported twice. Previous export was in %s%s\n",
-		     mod->name, name, s->module->name,
-		     s->module->is_vmlinux ? "" : ".ko");
+		error("%s: '%s' exported twice. Previous export was in %s%s\n",
+		      mod->name, name, s->module->name,
+		      s->module->is_vmlinux ? "" : ".ko");
 		return s;
 	}
 
-- 
2.32.0

