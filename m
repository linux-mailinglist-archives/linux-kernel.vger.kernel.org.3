Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1374F6747
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbiDFR3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239106AbiDFR3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:29:12 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57241560A5;
        Wed,  6 Apr 2022 08:31:42 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 236FUcaQ017647;
        Thu, 7 Apr 2022 00:30:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 236FUcaQ017647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649259040;
        bh=6o17aiZBvHlMD/DzwDamCOdodobOeuUrwwxgJ29rqNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cbyS2Nd2FDsH4kPaPK8uaby5RDDNiWRu+WcCe9Yp/vPUTiV5R2Pk0RhXuDl9EGzlp
         C8pJFTT4ZeWSzQfi6GnZyDZc5l105tIzUExpgBUgjh0wH1Lm0XHf8JnBkqDJljA9oO
         YZIBIkThqqO7KBy9uLf2W0Rum+dREfpcUghFvWXn/lzdOsOiZiYuocauOp3/c32Swj
         W9vTg/k3VYgPvcoBxiqcDg2P/ms+mVcbXc0c7amDGzuDCYwDTYxXsnVssNP4+et0gv
         4qHzTfKwf88KNHyeP/8xK/PC+kog2zkUZPU3f19fNp1lCiAn0CtDeiG2oBqP8xF3n8
         cpDuSqlIJh+3A==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 1/7] kbuild: reuse suffix-search to refactor multi_depend
Date:   Thu,  7 Apr 2022 00:30:17 +0900
Message-Id: <20220406153023.500847-2-masahiroy@kernel.org>
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

The complicated part of multi_depend is the same as suffix-search.

Reuse it.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 9f69ecdd7977..d56cda3c1e8a 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -238,7 +238,7 @@ endif
 define multi_depend
 $(foreach m, $(notdir $1), \
 	$(eval $(obj)/$m: \
-	$(addprefix $(obj)/, $(foreach s, $3, $($(m:%$(strip $2)=%$(s)))))))
+	$(addprefix $(obj)/, $(call suffix-search, $m, $2, $3))))
 endef
 
 # Copy a file
-- 
2.32.0

