Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22FC56D41A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 06:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiGKEvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 00:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiGKEvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 00:51:09 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFB8DF03;
        Sun, 10 Jul 2022 21:51:07 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 26B4o0ZG024708;
        Mon, 11 Jul 2022 13:50:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 26B4o0ZG024708
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1657515001;
        bh=VOCHHLRHh1lLpKyixQ4sfkIWymDvLwbX+ywMi3wCVpo=;
        h=From:To:Cc:Subject:Date:From;
        b=rRCj0qF6u9icqqOx8T4cVX6F/su2ZFkjobBuMguq181E4wy2sYH0HhanvoFsvd6fN
         eJ2sG8pSmdlUR7QZ8UDTaZlKX1CFiqBKxkfoKn7lfeGhPwX8FDYVD8WV6dKpJvLIAJ
         ES1dh+vGUMsZotwHbhskX8RC0MTxJfyh0RmXMF9z/Dw/7qU1jOsULi7Xp2HNnMEq6v
         AjiBKYV8IxPJycE6Ew5swXfpl3ww6RK/YalOrKYu2NNbQ6sGQiDPrI5gJqHGxa8HVb
         o2UQT0aJgo3vNsppAgP9xvPHiD2FEDDhNHi9D2ZZMKMRt89GwcNregJ5GlxpZGyjiy
         /UKJSQPWR7uqA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Revert "scripts/mod/modpost.c: permit '.cranges' secton for sh64 architecture."
Date:   Mon, 11 Jul 2022 13:49:41 +0900
Message-Id: <20220711044942.122792-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
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

This reverts commit 4d10c223baab8be8f717df3625cfece5be26dead.

Commit 37744feebc08 ("sh: remove sh5 support") removed the sh64 support
entirely.

Note:
.cranges was only used for sh64 ever.
Commit 211dc24b8744 ("Remove sh5 and sh64 support") in binutils-gdb
already removed the relevant code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

Changes in v2:
  - Mention that binutils-gdb also remove the .cranges code.

 scripts/mod/modpost.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index ba7c5a8ad448..7735d095338c 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -753,7 +753,6 @@ static const char *const section_white_list[] =
 {
 	".comment*",
 	".debug*",
-	".cranges",		/* sh64 */
 	".zdebug*",		/* Compressed debug sections. */
 	".GCC.command.line",	/* record-gcc-switches */
 	".mdebug*",        /* alpha, score, mips etc. */
-- 
2.32.0

