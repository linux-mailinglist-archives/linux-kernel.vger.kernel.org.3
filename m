Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986074D792F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 02:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbiCNBzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 21:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbiCNBzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 21:55:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7838B1FA7D;
        Sun, 13 Mar 2022 18:54:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BF86B80CA5;
        Mon, 14 Mar 2022 01:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475E3C340F3;
        Mon, 14 Mar 2022 01:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647222868;
        bh=RifitOjP23r/n90fOwga9VQHt9fkjAf4eMxj3baN9Y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bF+eGwI4xtJGHh4ld2A/T1LFP4O5uH7X0Y00OD4/iHYsNkmEPZsznCpJuq8XqKSe5
         Xd+GDiefpzt72fEd+dqVC+FekUBvQViExgZAbIq2orjOoolhDT7si7oTjVVrxfd/Sm
         kZ8FU4l8RFvyC60ngNUbYCtjxzjeEBmePyz0Q8bJYXmNkrC8Z3k17ul5qE5bOAJb7+
         NJOYP578acSznTx2NGeUn2V+U2yviKZFbuQKiof+rQ7b9mo+/UDWBDxnM5yUKJ5m5H
         RMosLkKz80zB4gfGx50s8LzqTDIzCKjFRsFQmn9JC+e1FaBLVBtpIZixD/nS/UHWaM
         SCkergFEFQbZA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 3/3] docs: bootconfig: Add how to embed the bootconfig into kernel
Date:   Mon, 14 Mar 2022 10:54:23 +0900
Message-Id: <164722286373.689258.9817790360544187508.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164722283333.689258.144495814460576707.stgit@devnote2>
References: <164722283333.689258.144495814460576707.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 Changes in v2:
  - Corrected the text accoding to Randy's suggestion.
  - Do not reccomend to use relative path for CONFIG_EMBED_BOOT_CONFIG_FILE.
---
 Documentation/admin-guide/bootconfig.rst |   30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index a1860fc0ca88..1af1a172fdd4 100644
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
 
@@ -196,6 +202,24 @@ To remove the config from the image, you can use -d option as below::
 Then add "bootconfig" on the normal kernel command line to tell the
 kernel to look for the bootconfig at the end of the initrd file.
 
+Embedding a Boot Config into Kernel
+-----------------------------------
+
+If you can not use initrd, you can also embed the bootconfig file in the
+kernel by Kconfig options. In this case, you need to recompile the kernel
+with the following configs::
+
+ COFNIG_EMBED_BOOT_CONFIG=y
+ CONFIG_EMBED_BOOT_CONFIG_FILE="/PATH/TO/BOOTCONFIG/FILE"
+
+``CONFIG_EMBED_BOOT_CONFIG_FILE`` requires a correct absolute path to
+the bootconfig file. The kernel will embed it as the default bootconfig.
+
+Just as when attaching the bootconfig to the initrd, you need ``bootconfig``
+option to the kernel command line to enable the embedded bootconfig.
+
+Note that even if you set this option, you can override the embedded
+bootconfig by another bootconfig which attached to the initrd.
 
 Kernel parameters via Boot Config
 =================================

