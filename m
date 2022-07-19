Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B8E57A460
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbiGSQyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiGSQyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:54:18 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC325140D;
        Tue, 19 Jul 2022 09:54:15 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 26JGr86E000327;
        Wed, 20 Jul 2022 01:53:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 26JGr86E000327
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658249589;
        bh=faEd56KvTw/aJ/wkl8ut/p+LDXVDArJL5xfoHqZEFGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tRTDy9WtncFb0RGpL6Uner6xA5yfvz1OtQub9YjipsXclIDkwXPfzmlkedwf1jnti
         flpSED20uRoeiIG2JEiaRvyc6ffGZQJssoUZMeC/cWNqj4+I+HF629hKSkg9H6duok
         VJXRkO++ISdUT/SGrjbNoaWvFAyc383tLyVKF2gmszTNvfeO8J0+IuKTkOc518xZYp
         aJRUZpI8gEZL+ItSBbxKgHPv4oWUKNm24YKYZ5kL9Dj+b0kuuzokVrRakZN64W1na5
         k5LmTC6JCNhZD+BdxlhsdX/oyhy6UI3J8QoDcZhFZReGcNksKh7hxtg5JCXVFWMfi9
         hqV+oYdrre39Q==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] modpost: use sym_get_data() to get module device_table data
Date:   Wed, 20 Jul 2022 01:53:00 +0900
Message-Id: <20220719165300.3000580-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220719165300.3000580-1-masahiroy@kernel.org>
References: <20220719165300.3000580-1-masahiroy@kernel.org>
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

Use sym_get_data() to replace the long code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/file2alias.c | 4 +---
 scripts/mod/modpost.c    | 2 +-
 scripts/mod/modpost.h    | 1 +
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index cbd6b0f48b4e..80d973144fde 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -1571,9 +1571,7 @@ void handle_moddevtable(struct module *mod, struct elf_info *info,
 		zeros = calloc(1, sym->st_size);
 		symval = zeros;
 	} else {
-		symval = (void *)info->hdr
-			+ info->sechdrs[get_secindex(info, sym)].sh_offset
-			+ sym->st_value;
+		symval = sym_get_data(info, sym);
 	}
 
 	/* First handle the "special" cases */
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 6370f9accb8e..26254e96c300 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -324,7 +324,7 @@ static void *sym_get_data_by_offset(const struct elf_info *info,
 	return (void *)info->hdr + sechdr->sh_offset + offset;
 }
 
-static void *sym_get_data(const struct elf_info *info, const Elf_Sym *sym)
+void *sym_get_data(const struct elf_info *info, const Elf_Sym *sym)
 {
 	return sym_get_data_by_offset(info, get_secindex(info, sym),
 				      sym->st_value);
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 044bdfb894b7..4d8a1ae1d1e3 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -187,6 +187,7 @@ void get_src_version(const char *modname, char sum[], unsigned sumlen);
 /* from modpost.c */
 char *read_text_file(const char *filename);
 char *get_line(char **stringp);
+void *sym_get_data(const struct elf_info *info, const Elf_Sym *sym);
 
 enum loglevel {
 	LOG_WARN,
-- 
2.34.1

