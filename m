Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235DD5790E9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 04:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbiGSCh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 22:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGSCh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 22:37:58 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128A322BDA;
        Mon, 18 Jul 2022 19:37:56 -0700 (PDT)
Received: from grover.jp (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 26J2bJ4H004522;
        Tue, 19 Jul 2022 11:37:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 26J2bJ4H004522
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658198239;
        bh=HQK6QEDJxQcORRIWR/HJ2dPOwcOH2XLZjLHhiFJZjLc=;
        h=From:To:Cc:Subject:Date:From;
        b=136eVUOFw7hnvltqX0qb8mAv8hsb5qD3E5F5G99GR4eflY3VlUd6kIAU0PRMVrnMW
         6biWEwuhmOWrkUJ0s1FGlsmq7ueWmaWZnvHY4TmEwoZHBTT9uUhS8mIH7OVW0BfsAy
         EZV0eiazj1AjM8X29LjcSy8jo9/NE2+vKKzedFuwabxHy3zFh7powUjwo+9hqNEahE
         C0B6S15AYGF3qNkW3chx+rmvbnceYg2f7R2JU7MKK0qDLHaXUYRQUPArdkX2BxiTbT
         N0RMxmgGcjq68wW+T5HUQSyD5GSkuYDCu4iqR6mZLbbTY4GR7kNCcRlHolV3S43GKv
         STyuVN8/cOp6Q==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: shorten the temporary directory name for cc-option
Date:   Tue, 19 Jul 2022 11:35:39 +0900
Message-Id: <20220719023539.2199045-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

The cc-option macro creates the temporary directory, .tmp_$$$$, which
is expanded into .tmp_<PID><PID>, but the second <PID> is redundant.
(<PID> is the process ID of the sub-shell)

If it were the Makefile code, .tmp_$$$$ would be the correct code.
(see the TMPOUT macro in scripts/Malefile.compiler)

In Makefile, '$$' is an escape sequence of '$'. Make expands '$$$$'
into '$$', then shell expands it into the process ID.

This does not apply to Kconfig because Kconfig requires variable
references to be enclosed by curly braces, like ${variable}.
The '$' that is not followed by '{' loses its special function.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Kconfig.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Kconfig.include b/scripts/Kconfig.include
index 0496efd6e117..c1f4222d223d 100644
--- a/scripts/Kconfig.include
+++ b/scripts/Kconfig.include
@@ -25,7 +25,7 @@ failure = $(if-success,$(1),n,y)
 
 # $(cc-option,<flag>)
 # Return y if the compiler supports <flag>, n otherwise
-cc-option = $(success,mkdir .tmp_$$$$; trap "rm -rf .tmp_$$$$" EXIT; $(CC) -Werror $(CLANG_FLAGS) $(1) -c -x c /dev/null -o .tmp_$$$$/tmp.o)
+cc-option = $(success,mkdir .tmp_$$; trap "rm -rf .tmp_$$" EXIT; $(CC) -Werror $(CLANG_FLAGS) $(1) -c -x c /dev/null -o .tmp_$$/tmp.o)
 
 # $(ld-option,<flag>)
 # Return y if the linker supports <flag>, n otherwise
-- 
2.34.1

