Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300404C5A1E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 10:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiB0JEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 04:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiB0JEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 04:04:50 -0500
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C50A4EF47;
        Sun, 27 Feb 2022 01:04:13 -0800 (PST)
Received: from grover.. (133-32-176-37.west.xps.vectant.ne.jp [133.32.176.37]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 21R93gHs015379;
        Sun, 27 Feb 2022 18:03:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 21R93gHs015379
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1645952623;
        bh=SOnJgFa6V3ZI1dsgC2zXzWcRks3lO0Eg8LmrKD8Eilk=;
        h=From:To:Cc:Subject:Date:From;
        b=GKAqkaAc/9aR/KwlaebLRJRMTPFbiBMdorHCH1vx8NcimDkPKZNUYpFgiKUI79Xj3
         kpv4RO1raPz8XREyCVRBnuGWMEBQ1os2gsOqE1Z30oZYWVTKfnBd96Xm/s0jUUcMUv
         QeUkKvcIZY8I8Ko8u6qTQXb9ppL2xJJ/yP3t8jgWcE3bafW8YUDIlU6QLGgF5AbNyQ
         EM67lBHmieAdSy22UmQGuNvFOzKm1WTSV2xPS7SyQpUDRn0yvALPKFqZgIUZgF42I8
         wxjGow1wyHJSzinFNFG0mh0NQBQLPaNIOLcPULwBZI2HxwAyLOHaSwHy9kXiIzNT9J
         tphybGv03bnxw==
X-Nifty-SrcIP: [133.32.176.37]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usr/include: replace extra-y with all-y
Date:   Sun, 27 Feb 2022 18:03:35 +0900
Message-Id: <20220227090335.207130-1-masahiroy@kernel.org>
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

extra-y is not run for 'make modules'. The header compile test should
be run irrespective of the build target. all-y is a better fit.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 usr/include/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/usr/include/Makefile b/usr/include/Makefile
index 5bc0d566cfe0..758df4058814 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -95,7 +95,7 @@ endif
 # asm-generic/*.h is used by asm/*.h, and should not be included directly
 no-header-test += asm-generic/%
 
-extra-y := $(patsubst $(obj)/%.h,%.hdrtest, $(shell find $(obj) -name '*.h' 2>/dev/null))
+all-y := $(patsubst $(obj)/%.h,%.hdrtest, $(shell find $(obj) -name '*.h' 2>/dev/null))
 
 # Include the header twice to detect missing include guard.
 quiet_cmd_hdrtest = HDRTEST $<
-- 
2.32.0

