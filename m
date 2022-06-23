Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0C1558902
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiFWTdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiFWTc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:32:56 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A0744751;
        Thu, 23 Jun 2022 12:13:23 -0700 (PDT)
Received: from localhost.localdomain (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 25NJC0li007138;
        Fri, 24 Jun 2022 04:12:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 25NJC0li007138
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1656011521;
        bh=mZGio26TLh9bx4bTM660/GNv2IG4KQEPMVRi+axAaKM=;
        h=From:To:Cc:Subject:Date:From;
        b=yopBilnRtVCQ+3lyWesXAY13fIMfB5vxjtTZB5AeiGdOqJx/BCzcTozE4udtXQiJs
         LuUvLsLIrSasfup4/sHXWup7RfQEj6IRO0dJxexI3U1HEPYn0WNWUS3a6fgOBbtNod
         AZZrhVWw9BI6y5ED+Ns2+fQwTGI3I25+CNEV+zWZ/dn8fZpcx4SZ24cAklrgCq4cAL
         iwSC/3zHxgxYeIg+WfZXRVRyi+vs/hxR/3u845B4qnAgNaSTK8z3uEVzIBwZss78f1
         hSYzxrwVxf8I29EsoWas9FJ94vIc21p6wQrpa4/nGx7bFlKqMbQd6vhrXgDDvzNI/H
         eyJ5Hz7xCRycQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] kbuild: link vmlinux only once for CONFIG_TRIM_UNUSED_KSYMS (2nd attempt)
Date:   Fri, 24 Jun 2022 04:11:47 +0900
Message-Id: <20220623191147.1916067-1-masahiroy@kernel.org>
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

If CONFIG_TRIM_UNUSED_KSYMS is enabled and the kernel is built from
a pristine state, the vmlinux is linked twice.

Commit 3fdc7d3fe4c0 ("kbuild: link vmlinux only once for
CONFIG_TRIM_UNUSED_KSYMS") explains why this happens, but it did not fix
the issue at all.

Now I realized I had applied a wrong patch.

In v1 patch [1], the autoksyms_recursive target correctly recurses to
"$(MAKE) -f $(srctree)/Makefile autoksyms_recursive".

In v2 patch [2], I accidentally dropped the diff line, and it recurses to
"$(MAKE) -f $(srctree)/Makefile vmlinux".

Restore the code I intended in v1.

[1]: https://lore.kernel.org/linux-kbuild/1521045861-22418-8-git-send-email-yamada.masahiro@socionext.com/
[2]: https://lore.kernel.org/linux-kbuild/1521166725-24157-8-git-send-email-yamada.masahiro@socionext.com/

Fixes: 3fdc7d3fe4c0 ("kbuild: link vmlinux only once for CONFIG_TRIM_UNUSED_KSYMS")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 513c1fbf7888..a3ff166c5035 100644
--- a/Makefile
+++ b/Makefile
@@ -1141,7 +1141,7 @@ KBUILD_MODULES := 1
 
 autoksyms_recursive: descend modules.order
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/adjust_autoksyms.sh \
-	  "$(MAKE) -f $(srctree)/Makefile vmlinux"
+	  "$(MAKE) -f $(srctree)/Makefile autoksyms_recursive"
 endif
 
 autoksyms_h := $(if $(CONFIG_TRIM_UNUSED_KSYMS), include/generated/autoksyms.h)
-- 
2.34.1

