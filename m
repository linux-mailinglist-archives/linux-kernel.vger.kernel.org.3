Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348494F47EB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347414AbiDEVXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384122AbiDEM1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:27:11 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D39574BC;
        Tue,  5 Apr 2022 04:35:18 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 235BYCGt000464;
        Tue, 5 Apr 2022 20:34:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 235BYCGt000464
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649158457;
        bh=g76dlQF6mmZzr43YQ6WiTAVzfZji/JTWeTt9/x6nhy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fhkX7GfZ1icPtiA7cEpfvegqzI8mfJATIDbetdt2odNtdCLvwcVJbCeOwONU77Vz4
         nSePOhux0lQk44IYWxfyYxJwmKw8ZT5qQwaQuMa5RRkjeByWbGxewF0m8GzKNhEjpw
         3mU7LXD1uWZhPhC1MGCcPsytnpd6qEDZCSRBIG9xJU5clVEv4nv0OImbzNqdgNIc+w
         qo+J86PA3PYHQr/pkfo5OdrBlC7XpaF3HaBw8740gCbiiKgtIXY7z0/ZilnObun8OT
         /qBp6C97UmE0EJKvHrXoC8t1Wuct2SKs4qOzErdjGLh5jpcHfrUWWjudhk5MWbXJya
         dvzaDo8oWbJeg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 07/10] kbuild: get rid of duplication in the first line of *.mod files
Date:   Tue,  5 Apr 2022 20:33:55 +0900
Message-Id: <20220405113359.2880241-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405113359.2880241-1-masahiroy@kernel.org>
References: <20220405113359.2880241-1-masahiroy@kernel.org>
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

The first line of *.mod lists the member objects of the module.
This list may contain duplication if the same object is added multiple
times, like this:

  obj-m := foo.o
  foo-$(CONFIG_FOO1_X) += foo1.o
  foo-$(CONFIG_FOO1_Y) += foo1.o
  foo-$(CONFIG_FOO2_X) += foo2.o
  foo-$(CONFIG_FOO2_Y) += foo2.o

This is probably not a big deal. As far as I know, the only small
problem is scripts/mod/sumversion.c parses the same file over again.
This can be avoided by adding $(sort ...). It has a side-effect that
sorts the objects alphabetically, but it is not a big deal, either.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - new

 scripts/Makefile.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 3ef2373f0a57..63625877aeae 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -307,8 +307,10 @@ $(obj)/%.prelink.o: $(obj)/%.o FORCE
 	$(call if_changed,cc_prelink_modules)
 endif
 
+multi-m-prereqs = $(sort $(addprefix $(obj)/, $($*-objs) $($*-y) $($*-m)))
+
 cmd_mod = { \
-	echo $(if $($*-objs)$($*-y)$($*-m), $(addprefix $(obj)/, $($*-objs) $($*-y) $($*-m)), $(@:.mod=.o)); \
+	echo $(if $(multi-m-prereqs), $(multi-m-prereqs), $(@:.mod=.o)); \
 	$(undefined_syms) echo; \
 	} > $@
 
-- 
2.32.0

