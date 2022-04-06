Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD144F5D3A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbiDFMIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbiDFMHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:07:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2887274E59;
        Tue,  5 Apr 2022 19:31:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 18A49CE2049;
        Wed,  6 Apr 2022 02:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22770C385A1;
        Wed,  6 Apr 2022 02:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649212263;
        bh=OEz1OieAEVLpYShok1rv8Y+hnxwh95YbTkBGw64pwW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rDLdOejqAdW9XOVth+WrjU+baIxSjLNJPcLDSEueYZr2QjP9LMESEcvtOFLlgiewO
         Ps5fBlEm8jcfnSFUDjLKK2MW1JXiV5NHyKsbPRWzprAxblhXP6HPis+AAOt1Q1AdEq
         M5gsFaLhjIyTE1JAKGLphHUMKLy/oo+VPYNbfk/otKFbSk3U67nX8OeBlVoIBrYv9b
         G/iMDtWoX8KafxRdEb/a3aD2QEfzknVMK3HVwr28GGnk1EDt7veCWcOonOCuFSpDlK
         xusJTTlbBMm9a3uYjtm7F/cU8qm6tFgV2ToNFSRaT4s7iSbF9VzmFd2aTRs1FrO2UX
         GRec1GFwCjC1A==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: [PATCH v8 1/4] bootconfig: Make the bootconfig.o as a normal object file
Date:   Wed,  6 Apr 2022 11:30:59 +0900
Message-Id: <164921225875.1090670.15565363126983098971.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164921224829.1090670.9700650651725930602.stgit@devnote2>
References: <164921224829.1090670.9700650651725930602.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the APIs defined in the bootconfig.o are not individually used,
it is meaningless to build it as library by lib-y. Use obj-y for that.

Reported-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v6:
  - Newly added.
---
 lib/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Makefile b/lib/Makefile
index 353bc09ce38d..4fc48543dc8f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -276,7 +276,7 @@ $(foreach file, $(libfdt_files), \
 	$(eval CFLAGS_$(file) = -I $(srctree)/scripts/dtc/libfdt))
 lib-$(CONFIG_LIBFDT) += $(libfdt_files)
 
-lib-$(CONFIG_BOOT_CONFIG) += bootconfig.o
+obj-$(CONFIG_BOOT_CONFIG) += bootconfig.o
 
 obj-$(CONFIG_RBTREE_TEST) += rbtree_test.o
 obj-$(CONFIG_INTERVAL_TREE_TEST) += interval_tree_test.o

