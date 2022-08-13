Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14629591D1C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 01:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiHMXKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 19:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiHMXKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 19:10:47 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E996CE13;
        Sat, 13 Aug 2022 16:10:45 -0700 (PDT)
Received: from localhost.localdomain (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 27DN9Uaa027502;
        Sun, 14 Aug 2022 08:09:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 27DN9Uaa027502
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660432171;
        bh=ahg1CMgPdBccimZ2s74hcE1OLQP4DgFeRxW/1pJsvtg=;
        h=From:To:Cc:Subject:Date:From;
        b=LpRXBB6SwH4T3kDcZrLDEPp6JtAAoWiYGrMgrZNzccriJCwlxW66J40Xido/hKp7e
         C4z7JsryglMXEhdlpuBOgqOYww6qkDVq0eIEeZ7PI7sYZfhWwFQyvHQu0RgpOKtEKX
         BZWZpyiBPuo2L+LAiErHHgWMcIU0mWIjP3s8JDupxdJWRsEQOsqDb/kllIVPEXKnvd
         r5IkcGVI7y04jQC4LHmy5C71pAG3rMv0YBs2H91fOyMIYKty7GUfOV+iLXgdHh+0FD
         xIDnYJQ8I1jsyG6C+36Jq4i/SI0xVBL3NbKDyT9Cl+DaGutYdKFrIpVAfSeKkQ5w7Q
         hX5290dw5AGkA==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: fix the modules order between drivers and libs
Date:   Sun, 14 Aug 2022 08:09:28 +0900
Message-Id: <20220813230928.1260981-1-masahiroy@kernel.org>
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

Commit b2c885549122 ("kbuild: update modules.order only when contained
modules are updated") accidentally changed the modules order.

Prior to that commit, the modules order was determined based on
vmlinux-dirs, which lists core-y/m, drivers-y/m, libs-y/m, in this order.

Now, subdir-modorder lists them in a different order: core-y/m, libs-y/m,
drivers-y/m.

Presumably, there was no practical issue because the modules in drivers
and libs are orthogonal, but there is no reason to have this distortion.

Get back to the original order.

Fixes: b2c885549122 ("kbuild: update modules.order only when contained modules are updated")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 5f5c43a52455..c4e06e8020f1 100644
--- a/Makefile
+++ b/Makefile
@@ -1113,13 +1113,11 @@ vmlinux-alldirs	:= $(sort $(vmlinux-dirs) Documentation \
 		     $(patsubst %/,%,$(filter %/, $(core-) \
 			$(drivers-) $(libs-))))
 
-subdir-modorder := $(addsuffix modules.order,$(filter %/, \
-			$(core-y) $(core-m) $(libs-y) $(libs-m) \
-			$(drivers-y) $(drivers-m)))
-
 build-dirs	:= $(vmlinux-dirs)
 clean-dirs	:= $(vmlinux-alldirs)
 
+subdir-modorder := $(addsuffix /modules.order, $(build-dirs))
+
 # Externally visible symbols (used by link-vmlinux.sh)
 KBUILD_VMLINUX_OBJS := $(head-y) $(patsubst %/,%/built-in.a, $(core-y))
 KBUILD_VMLINUX_OBJS += $(addsuffix built-in.a, $(filter %/, $(libs-y)))
-- 
2.34.1

