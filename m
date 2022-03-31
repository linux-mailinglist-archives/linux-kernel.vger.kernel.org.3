Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B744ED398
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 07:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiCaF6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 01:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiCaF6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 01:58:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966DD19BE6F;
        Wed, 30 Mar 2022 22:56:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31D2061543;
        Thu, 31 Mar 2022 05:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9F5C340ED;
        Thu, 31 Mar 2022 05:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648706174;
        bh=jLjZOnXI/ACGnxXl3tZNcFkD6L1cKyv9i4IjbKr7Ueg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eKgfxFIF5/aQoZPIhCFXNWPYQ+8y/O/fj7g4Z0Qkis+vGDCEXVzjMI9lCS4EjLRN3
         UnxfgV2ZYIDw2mvD3igr1yvuickWSjwaPgnZkoEAcqMfVFjkZC3UYAD6OMoF04D4c9
         mY2AoZ54e5+DbSAqOdMipOHhczECRtlLV6Gz7Xdf0HO/mWHvuGwscURFR5xhNreZB4
         V7n2uTK5ij9gzARhepX/LwF5NBVuFOX3bPbOtSHob3y6wx7zmbB9mKXVen9V59O7//
         ldVqATKFQVlOOLiRekE4gHiws616gP+/ATh9muRnaeYU+Zkly0lHw11mQvI4kASANx
         tRhMTQrEtPBug==
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
Subject: [PATCH v6 1/4] bootconfig: Make the bootconfig.o as a normal object file
Date:   Thu, 31 Mar 2022 14:56:10 +0900
Message-Id: <164870617012.127053.3864577306553523861.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164870615889.127053.9055569952366814752.stgit@devnote2>
References: <164870615889.127053.9055569952366814752.stgit@devnote2>
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
index 6b9ffc1bd1ee..08053df16c7c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -279,7 +279,7 @@ $(foreach file, $(libfdt_files), \
 	$(eval CFLAGS_$(file) = -I $(srctree)/scripts/dtc/libfdt))
 lib-$(CONFIG_LIBFDT) += $(libfdt_files)
 
-lib-$(CONFIG_BOOT_CONFIG) += bootconfig.o
+obj-$(CONFIG_BOOT_CONFIG) += bootconfig.o
 
 obj-$(CONFIG_RBTREE_TEST) += rbtree_test.o
 obj-$(CONFIG_INTERVAL_TREE_TEST) += interval_tree_test.o

