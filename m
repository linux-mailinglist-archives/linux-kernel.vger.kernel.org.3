Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D3C4B402E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 04:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239920AbiBNDUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 22:20:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiBNDUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 22:20:09 -0500
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AE9517CF;
        Sun, 13 Feb 2022 19:20:02 -0800 (PST)
Received: from grover.. (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 21E3JJ7a001202;
        Mon, 14 Feb 2022 12:19:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 21E3JJ7a001202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644808759;
        bh=ql8+b3TEYomACRoOIs8g23qHNaRl+z76CCcop7mRJqI=;
        h=From:To:Cc:Subject:Date:From;
        b=htKOIDI5i7hKnZkGAg0/MKZx3Bp7CN1FTfRppi4pIpLyTtEn91ZY8sFxsewY2ylPN
         xXDOl+CTQvrekzEuLVRfZ4VtKcbp+mhlCuqxtsmDdUPOZ94gImkbpwTVk2UyPfoaCX
         Ma48G/GstG8NC6I16Gy7mcqCXBJU4wlbjO63OFgy++R2LRZ3vvX6BjMT9vJlN5QB/I
         K8O1/g86KDo3GLUT9cRXooa1ozyyKchuEzofouONSlGUu/4rDTmK2PRJ9ZG19Hq9Cv
         3YRsTFk3msIHRczGN5mVNZV5387Ee4X9k1NCkpPplC0DxvDpw3MGW6Lu5wwf2N767R
         PKEoVe4UROjoQ==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] kconfig: fix missing '# end of' for empty menu
Date:   Mon, 14 Feb 2022 12:19:18 +0900
Message-Id: <20220214031918.2407212-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, "# end of ..." is inserted when the menu goes back to its
parent.

Hence, an empty menu:

  menu "Foo"
  endmenu

... ends up with unbalanced menu comments, like this:

  #
  # Foo
  #

Let's close the menu comments properly:

  #
  # Foo
  #
  # end of Foo

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/confdata.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index d3c3a61308ad..36fd254fcaa1 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -903,19 +903,20 @@ int conf_write(const char *name)
 			menu = menu->list;
 			continue;
 		}
-		if (menu->next)
+
+end_check:
+		if (!menu->sym && menu_is_visible(menu) && menu != &rootmenu &&
+		    menu->prompt->type == P_MENU) {
+			fprintf(out, "# end of %s\n", menu_get_prompt(menu));
+			need_newline = true;
+		}
+
+		if (menu->next) {
 			menu = menu->next;
-		else while ((menu = menu->parent)) {
-			if (!menu->sym && menu_is_visible(menu) &&
-			    menu != &rootmenu) {
-				str = menu_get_prompt(menu);
-				fprintf(out, "# end of %s\n", str);
-				need_newline = true;
-			}
-			if (menu->next) {
-				menu = menu->next;
-				break;
-			}
+		} else {
+			menu = menu->parent;
+			if (menu)
+				goto end_check;
 		}
 	}
 	fclose(out);
-- 
2.32.0

