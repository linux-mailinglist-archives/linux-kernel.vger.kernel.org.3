Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED5750D49F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbiDXTOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238020AbiDXTNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:13:43 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0B45FAE;
        Sun, 24 Apr 2022 12:10:12 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 23OJ8o6A019069;
        Mon, 25 Apr 2022 04:09:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 23OJ8o6A019069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650827341;
        bh=q+sI2WvI+q2i6npMbfWAUGCdZca075FjNBQd8rvxMKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yuf2lqYWKVrxOfsTQbDa1MGht18VKIAX93EkPFO8/RH2HayipBCbouFBwt7oPBDLh
         tVm7Gc3oCiSccuo8IxX1MWUqtFmU1NsnR5XFZ0yV2/zQvMXBzMlzRm59LpKSNLP+so
         UiDyVpSC0LfDybVmkmPD4cPLLwLJp9NWIOM0GaNyl9sK/Nay007hKEVK9nrpQCRCm4
         ReJKoHMM4SWoG65JG0ChY6xRkqbgBX4bvz2QNv81lM+7t1hTZFubiwHcUA2JoyD6cz
         LE97/3tswoKrb9SIDUPuECB1lO982vslo+wjBOYW1cstQN/V1Wh7Lbx1cDkRP5xOUW
         IcXBzPuBBD3PQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 16/27] modpost: make multiple export error
Date:   Mon, 25 Apr 2022 04:08:00 +0900
Message-Id: <20220424190811.1678416-17-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220424190811.1678416-1-masahiroy@kernel.org>
References: <20220424190811.1678416-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
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

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 14044cd94aaa..73f0b98e3b5a 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -411,9 +411,9 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
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

