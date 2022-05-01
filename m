Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D314516312
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344145AbiEAIrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343592AbiEAIpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:45:53 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11A34CD69;
        Sun,  1 May 2022 01:42:27 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2418f2SC008518;
        Sun, 1 May 2022 17:41:18 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2418f2SC008518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651394478;
        bh=IzSTHBCFo5w8MwRPWETclURyaZh7eklggt7ocsWZ4ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DtYErU1U++poZDMqANR1RWIH8k5CAruNQAVbJ60k0nGSkFiiUKPK+pR6zI/sBig3h
         SqMnNk3MC77m/Tcmnho5GcKlaTqBbWmg2D6fGMVJCGfrzFCm1dMaIJQzhpK6HDmuBk
         SkSzC+0xtkF/ZzE4O3sDWXA4ZL1nYSVtp96vN+czXDViPSMA97LqsKEQ3okmr8u8qL
         lqsjVPZdGrRNLWrIs3vSZ2klQ5rZVE5qsr/zRg89L/5kMm9qYf6nZUZhzUSx1E4DE6
         ldP+OCnhkYbIgKwGaB3V5TzmAFsJ5nJFrBrY9KA/bseJ/yzh1YYGRMRXHoCVek3lWi
         FRhA+ldZYDMlQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 25/26] modpost: simplify the ->is_static initialization
Date:   Sun,  1 May 2022 17:40:31 +0900
Message-Id: <20220501084032.1025918-26-masahiroy@kernel.org>
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

->is_static is set to true at allocation, then to false if the symbol
comes from the dump file.

It is simpler to use !mod->from_dump as the init value.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - New patch

 scripts/mod/modpost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 1f2f53688d40..85fcac84d2d1 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -250,7 +250,7 @@ static struct symbol *alloc_symbol(const char *name)
 
 	memset(s, 0, sizeof(*s));
 	strcpy(s->name, name);
-	s->is_static = true;
+
 	return s;
 }
 
@@ -424,6 +424,7 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 
 	s = alloc_symbol(name);
 	s->module = mod;
+	s->is_static = !mod->from_dump;
 	s->export    = export;
 	list_add_tail(&s->list, &mod->exported_symbols);
 	hash_add_symbol(s);
@@ -2518,7 +2519,6 @@ static void read_dump(const char *fname)
 			mod->from_dump = true;
 		}
 		s = sym_add_exported(symname, mod, export_no(export));
-		s->is_static = false;
 		sym_set_crc(s, crc);
 		sym_update_namespace(symname, namespace);
 	}
-- 
2.32.0

