Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2834ED586
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiCaI1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiCaI07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:26:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999E81BB794;
        Thu, 31 Mar 2022 01:25:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B01DB82005;
        Thu, 31 Mar 2022 08:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1E4C340ED;
        Thu, 31 Mar 2022 08:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648715109;
        bh=2MxGsdREcZcC5dPhVe4pegMYaaOwE0pzgrqWpuXtrGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A1lgvRIuimSfgiCzSsPqrqzPyqJ/Ts6QNUpz89s8ANThoeoFMFD3+ixQA727+HWOq
         REuBOInQOtfZoLxQGzi1HT1fAoN63Fcit+so0ojLvQ3R/HUlvNitTG8lnnYQ8h2VG4
         EVguk8Nk4AnfSV4RKvcwqVp0qg56pDWvHDwKSIT3eIDgeMUjmC5fCwLuZEc4gc6MgE
         Lt/ifHthtHVcalu9xui4rO+kozd/ZER98FqzuTcfHNdUWqxMtGAc7FeE8lOeakOegP
         /N2iVe/5PHy066XlyX+NS5o2NF2W9CsvPYLQpvsCKCMdKTcKDTxgdT4v5D0pm0YP/V
         /8ayKrr16WUaw==
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
Subject: [PATCH v7 4/4] docs: bootconfig: Add how to embed the bootconfig into kernel
Date:   Thu, 31 Mar 2022 17:25:03 +0900
Message-Id: <164871510350.178991.10848731777317835399.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164871505771.178991.7870442736805590948.stgit@devnote2>
References: <164871505771.178991.7870442736805590948.stgit@devnote2>
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
 Changes in v7:
  - Rename CONFIG_EMBED_BOOT_CONFIG* to CONFIG_BOOT_CONFIG_EMBED*.
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

