Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39B45AF47C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiIFTgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIFTfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:35:52 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D03804A7;
        Tue,  6 Sep 2022 12:35:49 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 286JYjqY018889;
        Wed, 7 Sep 2022 04:34:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 286JYjqY018889
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662492886;
        bh=h1Wn/PkFpnuQ5ZufXwU4XYgsqEkmLcWVv+UYyLr6tSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=20e0T6hjUxqE+YC/3Extlb5G6lvIqRAVanct260dna7ibMm7QxX4XXLXs2Z9Y3lzQ
         Ez1M+gEg5Z8KFM3rG95cGb6ymqtOjnDP+ZbtMTaCQimUNbdaLXMG5TwfS2eq29XCTK
         DSRG+TEQi8YrPDPXb05pepO5919zII3tKiyO3ihPSVwzK7ornEwExe+sR9Z7c/0Vc6
         hiLci4D8C+pm8dxJEWOVAExwGhDw2YnW4oGjufFeN7hu/L5KwtDTVhF/H4BFov6QfF
         xa6ns332RJ2ELUhFzQe1hoYHW9h+nEMW0rRAyhGw787dqv8wvIvIT+uE2tHm0sxMl+
         tE2w2g8Wq9QOQ==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 2/2] kbuild: re-run modpost stage when scripts/mod/modpost is updated
Date:   Wed,  7 Sep 2022 04:34:36 +0900
Message-Id: <20220906193436.2135744-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906193436.2135744-1-masahiroy@kernel.org>
References: <20220906193436.2135744-1-masahiroy@kernel.org>
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

vmlinux depends on .vmlinux.export.c, modules depend on *.mod.c.

They are output from modpost, so the modpost stage must be re-run
when the modpost code is updated.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.modpost | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 87821a5fe16b..1afe50971f3b 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -120,7 +120,7 @@ quiet_cmd_modpost = MODPOST $@
 	sed 's/ko$$/o/' $(or $(modorder-if-needed), /dev/null) | $(MODPOST) $(modpost-args-y) $(vmlinux.o-if-present) -T - -o $@
 
 targets += $(output-symdump)
-$(output-symdump): $(modorder-if-needed) $(vmlinux.o-if-present) $(moudle.symvers-if-present) FORCE
+$(output-symdump): $(modorder-if-needed) $(vmlinux.o-if-present) $(moudle.symvers-if-present) $(MODPOST) FORCE
 	$(call if_changed,modpost)
 
 __modpost: $(output-symdump)
-- 
2.34.1

