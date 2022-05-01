Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37D75162F9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344364AbiEAIqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343554AbiEAIpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:45:53 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E37B4C795;
        Sun,  1 May 2022 01:42:24 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2418f2Rn008518;
        Sun, 1 May 2022 17:41:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2418f2Rn008518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651394464;
        bh=deZf4KMCB529EGzoEfuY/52trWUR7WdRSXqW2hg+fYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PeTubxZ9DiV7Jc81qLCc4yNu2bLZ/kGCVJ3ruf02cwmSCcjUPLCDlbwNF1Q1juCiz
         vmwWXmL+NCBZtdk6XKdcYYXsYbfK0PayaaYcpb0lCMTuQwFmw8k0FnmUzFJsuVHnSy
         LfnofMDrrhgee1oOZ6bm1Yai8l4Xx+9NRjmOJcOkqLRwLApOlu2FEnxGSjcIihiGPF
         P8nHD4IPK0xxnpioQ2BWHj30a//jyXTKpWoIpmJPKZJSMpG/PSd7OxwBiavHGPOHWr
         9kvy5BQQOJpcO3xd9kHmzVzy0E78JbOKMwitI1WpAsKyaHpsPDdxch0D8iOVGiSHi2
         oh9IKw0SVkwMA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 02/26] modpost: change mod->gpl_compatible to bool type
Date:   Sun,  1 May 2022 17:40:08 +0900
Message-Id: <20220501084032.1025918-3-masahiroy@kernel.org>
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

Currently, mod->gpl_compatible is tristate; it is set to -1 by default,
then to 1 or 0 when MODULE_LICENSE() is found.

Maybe, -1 was chosen to represent the 'unknown' license, but it is not
useful.

The current code:

    if (!mod->gpl_compatible)
            check_for_gpl_usage(exp->export, basename, exp->name);

... only cares whether gpl_compatible is zero or not.

Change it to a bool type with the initial value 'true', which has no
functional change.

The default value should be 'true' instead of 'false'.

Since commit 1d6cd3929360 ("modpost: turn missing MODULE_LICENSE() into
error"), unknown module license is an error.

The error message, "missing MODULE_LICENSE()" is enough to explain the
issue. It is not sensible to show another message, "GPL-incompatible
module ... uses GPL-only symbol".

Add comments to explain this.

While I was here, I renamed gpl_compatible to is_gpl_compatible for
clarification, and also slightly refactored the code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Split as a separate commit
  - More code refactoring
  - Add a comment
  - Rename it to ->is_gpl_compatible (Nick)

 scripts/mod/modpost.c | 17 +++++++++++------
 scripts/mod/modpost.h |  2 +-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index a6035ab78cd8..f2d6c152cd3f 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -187,7 +187,14 @@ static struct module *new_module(const char *modname)
 	/* add to list */
 	strcpy(mod->name, modname);
 	mod->is_vmlinux = (strcmp(modname, "vmlinux") == 0);
-	mod->gpl_compatible = -1;
+
+	/*
+	 * Set mod->is_gpl_compatible to true by default to skip
+	 * check_for_gpl_usage() when MODULE_LICENSE() is missing.
+	 * If it is the case, modpost will exit with error anyway.
+	 */
+	mod->is_gpl_compatible = true;
+
 	mod->next = modules;
 	modules = mod;
 
@@ -2012,10 +2019,8 @@ static void read_symbols(const char *modname)
 		if (!license)
 			error("missing MODULE_LICENSE() in %s\n", modname);
 		while (license) {
-			if (license_is_gpl_compatible(license))
-				mod->gpl_compatible = 1;
-			else {
-				mod->gpl_compatible = 0;
+			if (!license_is_gpl_compatible(license)) {
+				mod->is_gpl_compatible = false;
 				break;
 			}
 			license = get_next_modinfo(&info, "license", license);
@@ -2183,7 +2188,7 @@ static void check_exports(struct module *mod)
 			add_namespace(&mod->missing_namespaces, exp->namespace);
 		}
 
-		if (!mod->gpl_compatible)
+		if (!mod->is_gpl_compatible)
 			check_for_gpl_usage(exp->export, basename, exp->name);
 	}
 }
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 7ccfcc8899c1..f21a3782885b 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -110,7 +110,7 @@ buf_write(struct buffer *buf, const char *s, int len);
 
 struct module {
 	struct module *next;
-	int gpl_compatible;
+	bool is_gpl_compatible;
 	struct symbol *unres;
 	bool from_dump;		/* true if module was loaded from *.symvers */
 	bool is_vmlinux;
-- 
2.32.0

