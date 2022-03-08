Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63B54D1271
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343897AbiCHIlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240639AbiCHIll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:41:41 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943E13FBDA;
        Tue,  8 Mar 2022 00:40:44 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.90,164,1643670000"; 
   d="scan'208";a="7901334"
Received: from randriaga.irisa.fr (HELO randriaga) ([131.254.10.20])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 09:40:42 +0100
User-agent: mu4e 1.6.10; emacs 27.2
From:   Randrianaina Georges Aaron <georges-aaron.randrianaina@irisa.fr>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathieu Acher <mathieu.acher@irisa.fr>
Subject: [PATCH v2] kconfig: add KCONFIG_ALLCONFIG support for tinyconfig
Date:   Tue, 08 Mar 2022 09:34:16 +0100
Message-ID: <87v8wo25we.fsf@irisa.fr>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since f8f0d06438e5, tinyconfig overrides KCONFIG_ALLCONFIG to include
kernel/configs/tiny-base.config. However, this ignores user's preset if
defined.

This modification checks if the user has set KCONFIG_ALLCONFIG and if so,
concatenates it with kernel/configs/tiny-base.config to be used as preset
config symbols.

Changes in v2:
- Remove `<(echo)` in the cat command as it is not portable
- Add $(srctree) in presets' path to make it compatible with O=<dir>

Signed-off-by: Randrianaina Georges Aaron <georges-aaron.randrianaina@irisa.fr>
---
 scripts/kconfig/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index b8ef0fb4bbef..58a677db9a73 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -102,7 +102,13 @@ configfiles=$(wildcard $(srctree)/kernel/configs/$@ $(srctree)/arch/$(SRCARCH)/c
 
 PHONY += tinyconfig
 tinyconfig:
+ifeq ($(KCONFIG_ALLCONFIG),)
 	$(Q)KCONFIG_ALLCONFIG=kernel/configs/tiny-base.config $(MAKE) -f $(srctree)/Makefile allnoconfig
+else
+	$(Q)cat $(srctree)/$(KCONFIG_ALLCONFIG) $(srctree)/kernel/configs/tiny-base.config > $(srctree)/.tmp.config
+	$(Q)KCONFIG_ALLCONFIG=$(srctree)/.tmp.config $(MAKE) -f $(srctree)/Makefile allnoconfig
+	$(Q)rm -f $(srctree)/.tmp.config
+endif
 	$(Q)$(MAKE) -f $(srctree)/Makefile tiny.config
 
 # CHECK: -o cache_dir=<path> working?
-- 
2.34.1
