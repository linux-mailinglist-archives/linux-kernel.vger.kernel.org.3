Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F5C585B6F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 19:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbiG3Rh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 13:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbiG3Rhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 13:37:50 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B7215A00;
        Sat, 30 Jul 2022 10:37:49 -0700 (PDT)
Received: from localhost.localdomain (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 26UHad9b015991;
        Sun, 31 Jul 2022 02:36:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 26UHad9b015991
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1659202600;
        bh=6qVoxOFybVIZw2PUGjoIGqId1JG7AuoiXXZ4w7M9+lQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JgFWAuog3tIvAJbXlRNQZCZV04LW+eLeE3PMW6++84sM/2DUqpnpeXb315Yd7QgvH
         cvqbgeRlHOfKsKYiTMVQwOoBHv8E3DrzgHOgIIw71i3gBBev6Bxio0ZccSgAR8HLiL
         GLapMKgHMts2vBDlkOrRD8TI7zlFOcyETRtEDNS8vNdzJF7Cn4EAHzzK7xhNIYZuep
         57HVawRZSG9MNnxT8oFeStp0ioPVTn+mUuB3JVVi4hCOe1MF2KW9kX3WeIYeUZPkLn
         ATDIEBUVn7BYatTTCfW8D+T5It/13scTYg/vAvtvgHEKm76fngcodtvA9/5BQKRcTB
         JanDoz0UU3A2w==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Revert "Kbuild, lto, workaround: Don't warn for initcall_reference in modpost"
Date:   Sun, 31 Jul 2022 02:36:36 +0900
Message-Id: <20220730173636.1303357-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220730173636.1303357-1-masahiroy@kernel.org>
References: <20220730173636.1303357-1-masahiroy@kernel.org>
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

This reverts commit 77ab21adae509c5540956729e2d03bc1a59bc82a.

That commit was 8 years old, and it said "This is a workaround".
If this is needed for GCC LTO, it should be added in a proper way.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index c6a055c0291e..a8ee27496da7 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1462,9 +1462,6 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	from = find_elf_symbol2(elf, r->r_offset, fromsec);
 	fromsym = sym_name(elf, from);
 
-	if (strstarts(fromsym, "reference___initcall"))
-		return;
-
 	tosec = sec_name(elf, get_secindex(elf, sym));
 	to = find_elf_symbol(elf, r->r_addend, sym);
 	tosym = sym_name(elf, to);
-- 
2.34.1

