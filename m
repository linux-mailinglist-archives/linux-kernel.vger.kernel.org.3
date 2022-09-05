Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD6B35ACE33
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbiIEIjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236977AbiIEIiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 04:38:11 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC75E1A06F;
        Mon,  5 Sep 2022 01:37:45 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 2858aYjE013979;
        Mon, 5 Sep 2022 17:36:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 2858aYjE013979
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662366996;
        bh=KusObtaX7Ag7sc+HekaUhYfJGxNdYNFdGQ0FDlAuqWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TAoL0IwUki+XcjS/ltKVdSfc09ebVkONdrUqkDk48xkjpdxK7itGNH7bxm9sV+H/y
         weRKAsZaN5C8pJEogdKbEaIGNk764fHAFkkbIh0bc5uZnu6eY9zOHHoQ6aS6FQ2SbG
         VpzgRMveAOBHhRQcQ4VXQBnyyp7b3ypt2EpTPfGoKEUyYZQ6DR2BfA5/WGOYTDkTfG
         xi3mIBSnABQYo1RKUAi7vkqAtb3n5Ndze0/eksQR2qT/zweqok/13mDwVNDIQCYcBi
         QqNGUEHIA2ZoFkG/7Q4WGBCy4HSFEMKu3bG3yi0xxkWXIlXIIccLd1/fMsdTSq10mg
         WNpCbuqofnyWA==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kbuild: move -Wundef from KBUILD_CFLAGS to KBUILD_CPPFLAGS
Date:   Mon,  5 Sep 2022 17:36:19 +0900
Message-Id: <20220905083619.672091-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220905083619.672091-1-masahiroy@kernel.org>
References: <20220905083619.672091-1-masahiroy@kernel.org>
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

The use of an undefined macro in an #if directive is warned, but only
in *.c files. No warning from other files such as *.S, *.lds.S.

Since -Wundef is a preprocessor-related warning, it should be added to
KBUILD_CPPFLAGS instead of KBUILD_CFLAGS.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 027d9163eff6..898a759e314e 100644
--- a/Makefile
+++ b/Makefile
@@ -523,12 +523,12 @@ LINUXINCLUDE    := \
 		$(USERINCLUDE)
 
 KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
-KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
+KBUILD_CFLAGS   := -Wall -Werror=strict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
 		   -Werror=implicit-function-declaration -Werror=implicit-int \
 		   -Werror=return-type -Wno-format-security \
 		   -std=gnu11
-KBUILD_CPPFLAGS := -D__KERNEL__
+KBUILD_CPPFLAGS := -D__KERNEL__ -Wundef
 KBUILD_AFLAGS_KERNEL :=
 KBUILD_CFLAGS_KERNEL :=
 KBUILD_AFLAGS_MODULE  := -DMODULE
-- 
2.34.1

