Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81434D75A1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 14:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbiCMN5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 09:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiCMN5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 09:57:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC245F270;
        Sun, 13 Mar 2022 06:56:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4C3EB80CAA;
        Sun, 13 Mar 2022 13:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9019BC340E8;
        Sun, 13 Mar 2022 13:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647179800;
        bh=73rd6F+wRPyuWn2PJNKyBIpSAN5NcV1wb/fm3qTL78Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=peVZnn05PjSL2hwSxpz5p92QIVWGRZOLkqotSVgZlb1A+/Bg9V/kLVPhWN7FNZpOU
         VrQy98bFfmAWUAT3VJ0UCKMMP9DY0i3i3LO9RNKjEqHYcd9wnZt7ct7ETfCH+mK8Vx
         bw1bng52fFQaK2KUkhpnQXFvIBYhATajRm+e9MXeHpIsHyRNmTvwSWeBVz0mGT/FBT
         BzOnJ1auXxo0NJrx/EnHNeePv4kESHbEXVYzS4fHCx80lcFimDC78cc1aYI4PVHbT5
         ta+6xJn6udE5CUjezBjYG/5hlQbBXK0NKxreq6Ahj03R9rfPgYEvuhGc6e1NzkGJVd
         +pyAYagnI5CiQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 3/3] docs: bootconfig: Add how to embed the bootconfig into kernel
Date:   Sun, 13 Mar 2022 22:56:37 +0900
Message-Id: <164717979739.656425.17945326639021989871.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164717976871.656425.6189991392886085524.stgit@devnote2>
References: <164717976871.656425.6189991392886085524.stgit@devnote2>
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
 Documentation/admin-guide/bootconfig.rst |   31 +++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index a1860fc0ca88..a172c669997a 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -158,9 +158,15 @@ Each key-value pair is shown in each line with following style::
 Boot Kernel With a Boot Config
 ==============================
 
-Since the boot configuration file is loaded with initrd, it will be added
-to the end of the initrd (initramfs) image file with padding, size,
-checksum and 12-byte magic word as below.
+There are 2 options to boot the kernel with bootconfig, one is attaching
+bootconfig to initrd image, and embedding the kernel itself.
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
+If you can not use initrd, you can also embed the bootconfig file to the
+kernel by Kconfig options. In This case, you need to recompile the kernel
+with the following configs::
+
+ COFNIG_EMBED_BOOT_CONFIG=y
+ CONFIG_EMBED_BOOT_CONFIG_FILE="/PATH/TO/BOOTCONFIG/FILE"
+
+You need to set the correct path (relative path from kernel build directory
+or absolute path) to the ``CONFIG_EMBED_BOOT_CONFIG_FILE`` option.
+Then the kernel will embed the bootconfig file as a default bootconfig.
+
+As same as attaching to initrd, you need ``bootconfig`` option to the
+kernel command line to enable the embedded bootconfig.
+
+Note that even if you set this option, you can override the embedded
+bootconfig by another bootconfig which attached to the initrd.
 
 Kernel parameters via Boot Config
 =================================

