Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85A44ED3A6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 07:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiCaF6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 01:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiCaF6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 01:58:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7BB1A8C06;
        Wed, 30 Mar 2022 22:56:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F88361657;
        Thu, 31 Mar 2022 05:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE1BC340ED;
        Thu, 31 Mar 2022 05:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648706207;
        bh=0fJAVjmpmWefISZQ/CbYY4ljN8LhkUpwEfBUSoXFz/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oe3jNjmYl/NQlVnpoyt9JVeao3XZookq1ax3MeMDxLz6Kr7KbTQith3SQdOLWydfi
         9st+Duoi509DMiwXt9Owg90VNJ8Q7FVIux/BCmh5QhEM8ZStEVA06RdAl0pMk+Kw6o
         I+plAe9TBsVTCRb5hkKO8sJ9vIwpVrBiA/Rc2vdOgKyifwBLRfhT+2CVdM3/QbnMo5
         w3VtX7vuXi0OcZHDBWNOAw87ghHaHfjcSehPHI0uW/c7o9jWSghxocf/HATZD0zqFp
         J61yNoermor4RIsWsZisuQ0pkDm7GLXyFQi+hLQkLig/wnA1tklZy0BAVtVXAk37k3
         leRodwfbO4r2g==
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
Subject: [PATCH v6 4/4] docs: bootconfig: Add how to embed the bootconfig into kernel
Date:   Thu, 31 Mar 2022 14:56:42 +0900
Message-Id: <164870620264.127053.14258877588862671243.stgit@devnote2>
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

Add a description how to embed the bootconfig file into kernel.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v5:
  - Update CONFIG_EMBED_BOOT_CONFIG_FILE which can accept relative path.
 Changes in v3:
  - Fix typos.
 Changes in v2:
  - Corrected the text accoding to Randy's suggestion.
  - Do not reccomend to use relative path for CONFIG_EMBED_BOOT_CONFIG_FILE.
---
 Documentation/admin-guide/bootconfig.rst |   31 +++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index a1860fc0ca88..83a2a0cc9afa 100644
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
+ CONFIG_EMBED_BOOT_CONFIG=y
+ CONFIG_EMBED_BOOT_CONFIG_FILE="/PATH/TO/BOOTCONFIG/FILE"
+
+``CONFIG_EMBED_BOOT_CONFIG_FILE`` requires an absolute path or a relative
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

