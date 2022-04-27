Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3295122E7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbiD0TlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiD0Tj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:39:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C964FEE;
        Wed, 27 Apr 2022 12:36:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12BC261B8A;
        Wed, 27 Apr 2022 19:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17A4C385B1;
        Wed, 27 Apr 2022 19:36:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1njnSs-002IvQ-0P;
        Wed, 27 Apr 2022 15:36:42 -0400
Message-ID: <20220427193641.826142252@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Apr 2022 15:36:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 13/21] docs: bootconfig: Add how to embed the bootconfig into kernel
References: <20220427193623.529296556@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add a description how to embed the bootconfig file into kernel.

Link: https://lkml.kernel.org/r/164921228987.1090670.16843569536974147213.stgit@devnote2

Cc: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/admin-guide/bootconfig.rst | 31 +++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index a1860fc0ca88..d99994345d41 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -158,9 +158,15 @@ Each key-value pair is shown in each line with following style::
 Boot Kernel With a Boot Config
 ==============================
 
-Since the boot configuration file is loaded with initrd, it will be added
-to the end of the initrd (initramfs) image file with padding, size,
-checksum and 12-byte magic word as below.
+There are two options to boot the kernel with bootconfig: attaching the
+bootconfig to the initrd image or embedding it in the kernel itself.
+
+Attaching a Boot Config to Initrd
+---------------------------------
+
+Since the boot configuration file is loaded with initrd by default,
+it will be added to the end of the initrd (initramfs) image file with
+padding, size, checksum and 12-byte magic word as below.
 
 [initrd][bootconfig][padding][size(le32)][checksum(le32)][#BOOTCONFIG\n]
 
@@ -196,6 +202,25 @@ To remove the config from the image, you can use -d option as below::
 Then add "bootconfig" on the normal kernel command line to tell the
 kernel to look for the bootconfig at the end of the initrd file.
 
+Embedding a Boot Config into Kernel
+-----------------------------------
+
+If you can not use initrd, you can also embed the bootconfig file in the
+kernel by Kconfig options. In this case, you need to recompile the kernel
+with the following configs::
+
+ CONFIG_BOOT_CONFIG_EMBED=y
+ CONFIG_BOOT_CONFIG_EMBED_FILE="/PATH/TO/BOOTCONFIG/FILE"
+
+``CONFIG_BOOT_CONFIG_EMBED_FILE`` requires an absolute path or a relative
+path to the bootconfig file from source tree or object tree.
+The kernel will embed it as the default bootconfig.
+
+Just as when attaching the bootconfig to the initrd, you need ``bootconfig``
+option on the kernel command line to enable the embedded bootconfig.
+
+Note that even if you set this option, you can override the embedded
+bootconfig by another bootconfig which attached to the initrd.
 
 Kernel parameters via Boot Config
 =================================
-- 
2.35.1
