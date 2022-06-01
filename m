Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD3E53AB2D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354160AbiFAQm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbiFAQm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:42:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611ED3C492
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 09:42:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB5F9615C7
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 16:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214B9C385B8;
        Wed,  1 Jun 2022 16:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654101745;
        bh=/xBaBBACrWyAc7xVPLhMoHdDwZ56uG6euBy9G76MsTg=;
        h=From:To:Cc:Subject:Date:From;
        b=IfN9K8qlFPktqlFvxyIq7m/+xksy4Ibt3VnNEnJjq+38hKwHJlZyv/MzsoR3l0tzG
         0DkzbNmZMbOTQweccDphnJQHt7NV0DhQivmLY40vZZyGcAfddnXH+cyJaC8Ss/P2wK
         lhdv7KRt9ZRyTppQvGjHrwEzdCxzpEB8gQdUq3KSKWu0o0VaK8qe1rXBu2LCHaxTk8
         eG1a8SfYOrtjp+3HpYyWjdVmntTNpOpaVfNmY8lDLZacg2Q9X2iH4aWj52banwxLaP
         zkK1N1TE97cS55/UO3TVB6OmG5kbXqbysB0j2KmKOQ8XwpIpLJWIgsC1rs2qPiNnh1
         CIRdmHBviJuGg==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] objtool: Fix obsolete reference to CONFIG_X86_SMAP
Date:   Wed,  1 Jun 2022 09:42:12 -0700
Message-Id: <44c57668768c1ba1b4ba1ff541ec54781636e07c.1654101721.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_X86_SMAP no longer exists.  For objtool's purposes it has been
replaced with CONFIG_HAVE_UACCESS_VALIDATION.

Fixes: 03f16cd020eb ("objtool: Add CONFIG_OBJTOOL")
Reported-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 lib/Kconfig.ubsan | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index c4fe15d38b60..a9f7eb047768 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -94,7 +94,7 @@ config UBSAN_UNREACHABLE
 	bool "Perform checking for unreachable code"
 	# objtool already handles unreachable checking and gets angry about
 	# seeing UBSan instrumentation located in unreachable places.
-	depends on !(OBJTOOL && (STACK_VALIDATION || UNWINDER_ORC || X86_SMAP))
+	depends on !(OBJTOOL && (STACK_VALIDATION || UNWINDER_ORC || HAVE_UACCESS_VALIDATION))
 	depends on $(cc-option,-fsanitize=unreachable)
 	help
 	  This option enables -fsanitize=unreachable which checks for control
-- 
2.34.3

