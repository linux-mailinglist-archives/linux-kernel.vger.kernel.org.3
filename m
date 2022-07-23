Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2630757F134
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 21:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbiGWTbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 15:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiGWTba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 15:31:30 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B14E1CFCC
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 12:31:29 -0700 (PDT)
Received: from hednb3.intra.ispras.ru (unknown [109.252.119.247])
        by mail.ispras.ru (Postfix) with ESMTPSA id 9CA8D40737A5;
        Sat, 23 Jul 2022 19:31:25 +0000 (UTC)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] objtool,x86: Remove unneeded code in special_get_alts()
Date:   Sat, 23 Jul 2022 22:31:13 +0300
Message-Id: <1658604673-16080-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 134ab5bd1883 ("objtool,x86: Replace alternatives with .retpoline_sites")
basically reverts
commit 50e7b4a1a1b2 ("objtool: Skip magical retpoline .altinstr_replacement"),
but it is an incomplete revert. As a result an unreachable code is left in
special_get_alts() that was intended to skip magical special sections.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 134ab5bd1883 ("objtool,x86: Replace alternatives with .retpoline_sites")
Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 tools/objtool/special.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index e2223dd91c37..6e84cb4d6774 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -168,8 +168,6 @@ int special_get_alts(struct elf *elf, struct list_head *alts)
 			memset(alt, 0, sizeof(*alt));
 
 			ret = get_alt_entry(elf, entry, sec, idx, alt);
-			if (ret > 0)
-				continue;
 			if (ret < 0)
 				return ret;
 
-- 
2.7.4

