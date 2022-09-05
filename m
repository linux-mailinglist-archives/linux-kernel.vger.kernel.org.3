Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955E85ACE09
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236064AbiIEIjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237545AbiIEIiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:38:10 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5AC15FE0;
        Mon,  5 Sep 2022 01:37:45 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 2858aYjD013979;
        Mon, 5 Sep 2022 17:36:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 2858aYjD013979
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662366995;
        bh=Vt4IowzK+iXEF9eSOlkcqvghicJnWrspKfJyi1CRqyU=;
        h=From:To:Cc:Subject:Date:From;
        b=IMqKvKN+bK1+N0cZB6530aaXcy7bg+xZhSyAc5qAeOfEgOXpec72JikOvRQX51WgD
         WTQu6SSISSJPXhFlVCqS++0U8A0cHiSE+vSzEHTe29qozgnHiD3d8cF1KwfvbgUOXg
         sU260haY5LO1C8eDCmWynLeRW5/a9bYK6QI+b+HSgRiveaQdfNvcCQMkQ4Ifh2ChgZ
         mziHFxi1wTJFSsy8W2Ctd81IK95Wfe9fvM3Vs8B7oQzDGlHGNodCajlPfYtyq5ZhyL
         r2qCyx9w7mybixPwgS7dVExGUdgkrRUJ0cNzC2kVlNB2AXOHzu7P2wSaKlboTgRN5+
         YnJVB8G7R476w==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kbuild: move -Werror from KBUILD_CFLAGS to KBUILD_CPPFLAGS
Date:   Mon,  5 Sep 2022 17:36:18 +0900
Message-Id: <20220905083619.672091-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

CONFIG_WERROR makes warnings into errors, but it only happens for *.c
files because -Werror is added to KBUILD_CFLAGS.

For example, you can put a #warning directive in any preprocessed
source file:

    #warning "blah blah ..."

If it is placed in a *.c file, it emits a warning by default, and it
is promoted to an error when CONFIG_WERROR is enabled:

    error: #warning "blah blah ..." [-Werror=cpp]

If it is placed in a *.S file, it is still a warning.

Move it to KBUILD_CPPFLAGS, so it works in the same way for *.c,
*.S, *.lds.S or whatever needs preprocessing.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index ebcb75442d7f..027d9163eff6 100644
--- a/Makefile
+++ b/Makefile
@@ -788,7 +788,8 @@ stackp-flags-$(CONFIG_STACKPROTECTOR_STRONG)      := -fstack-protector-strong
 
 KBUILD_CFLAGS += $(stackp-flags-y)
 
-KBUILD_CFLAGS-$(CONFIG_WERROR) += -Werror
+KBUILD_CPPFLAGS-$(CONFIG_WERROR) += -Werror
+KBUILD_CPPFLAGS += $(KBUILD_CPPFLAGS-y)
 KBUILD_CFLAGS-$(CONFIG_CC_NO_ARRAY_BOUNDS) += -Wno-array-bounds
 KBUILD_CFLAGS += $(KBUILD_CFLAGS-y) $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
 
-- 
2.34.1

