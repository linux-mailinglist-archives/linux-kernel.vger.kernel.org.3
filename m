Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB76F4F6721
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbiDFR3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239079AbiDFR3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:29:11 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3114B39B281;
        Wed,  6 Apr 2022 08:31:42 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 236FUcaS017647;
        Thu, 7 Apr 2022 00:30:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 236FUcaS017647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649259041;
        bh=IqKgxjmspFS2kV2tike/FlcIHIij7jL1YxZaqBPEov8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uc+pFg8JPgFbK1H3pD+CwlIfnn/jDBZkolRtzDNvHuXcfbEqGPYX7FyuM0JfHm9HK
         kBmUIU709T4K9DmHxUOCTgHmEgL0BwjVzNZYScUlQOussJFDpRmIGGbgtK19iDSd1r
         D0CzDclCWlA7vyAAkT29HPnPag/Kf1p4/oIhUYT4UQScdvlULjsNmA2P42pXZGW3LP
         iChW5f+PB/TpBYWc0sCC8LbXJvJw+wDMVBCdiMkAhGwga+Fsumc9hwnIcf5dgfOCkH
         /5W3+aarJKjfVZ0tnczdqm/NWaITC+SEPG62cq3wPlxmBLMDNCyz8GK+ryLlI4gCsG
         4gj9Ydg1cjaSQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 3/7] kbuild: reuse real-search to simplify cmd_mod
Date:   Thu,  7 Apr 2022 00:30:19 +0900
Message-Id: <20220406153023.500847-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220406153023.500847-1-masahiroy@kernel.org>
References: <20220406153023.500847-1-masahiroy@kernel.org>
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

The first command in cmd_mod is similar to the real-search macro.
Reuse it.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index f15c245dc17e..857329844789 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -306,7 +306,7 @@ $(obj)/%.prelink.o: $(obj)/%.o FORCE
 endif
 
 cmd_mod = { \
-	echo $(if $($*-objs)$($*-y)$($*-m), $(addprefix $(obj)/, $($*-objs) $($*-y) $($*-m)), $(@:.mod=.o)); \
+	echo $(addprefix $(obj)/, $(call real-search, $*.o, .o, -objs -y -m)); \
 	$(undefined_syms) echo; \
 	} > $@
 
-- 
2.32.0

