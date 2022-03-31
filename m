Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C404ED579
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiCaI0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbiCaI0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:26:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD313E5EB;
        Thu, 31 Mar 2022 01:24:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5060B81FBA;
        Thu, 31 Mar 2022 08:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CDEC340ED;
        Thu, 31 Mar 2022 08:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648715086;
        bh=/pcY0qB26eKeKCiib1+H0TY1vZCA9lmqTBCYWM/MIgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ogLXPlhY4XW7CMerWzh0rUwxDEgncjsl1QInpH9dkPtmDBufm47Kige5mh61RDZld
         Lbv2VhtKem5ER3iPzbZzOIS5Tbwie8Ju5Z4DGoD35zo+rzOZoDKVJbjA8FO3qcuSfT
         SvOk1uG5qQ6t3Mv8bnhr74lTqYP3J7vzI1Lelzm409fgwPqmeKac7VwG7zHIxNoZ6r
         XCXJ8cZTRFuHjbC3ttsma5cIgcG8kJ/EKLHQFUy3k7/P+aFQkt1Vq/p8dZX07r1GGb
         k1yk1upH+2D/4/LRQVlWGRr12EukHcFiIUnzbgrUVEE0yw94jNL20UgAk6l4zZItFe
         gKzg62ilLbsig==
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
Subject: [PATCH v7 2/4] bootconfig: Check the checksum before removing the bootconfig from initrd
Date:   Thu, 31 Mar 2022 17:24:40 +0900
Message-Id: <164871508057.178991.1275961945357225120.stgit@devnote2>
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

Check the bootconfig's checksum before removing the bootcinfig data
from initrd to avoid modifying initrd by mistake.
This will also simplifies the get_boot_config_from_initrd() interface.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 init/main.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/init/main.c b/init/main.c
index 98182c3c2c4b..266d61bc67b0 100644
--- a/init/main.c
+++ b/init/main.c
@@ -266,7 +266,7 @@ static int __init loglevel(char *str)
 early_param("loglevel", loglevel);
 
 #ifdef CONFIG_BLK_DEV_INITRD
-static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
+static void * __init get_boot_config_from_initrd(u32 *_size)
 {
 	u32 size, csum;
 	char *data;
@@ -300,17 +300,20 @@ static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
 		return NULL;
 	}
 
+	if (xbc_calc_checksum(data, size) != csum) {
+		pr_err("bootconfig checksum failed\n");
+		return NULL;
+	}
+
 	/* Remove bootconfig from initramfs/initrd */
 	initrd_end = (unsigned long)data;
 	if (_size)
 		*_size = size;
-	if (_csum)
-		*_csum = csum;
 
 	return data;
 }
 #else
-static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
+static void * __init get_boot_config_from_initrd(u32 *_size)
 {
 	return NULL;
 }
@@ -409,12 +412,12 @@ static void __init setup_boot_config(void)
 	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
 	const char *msg;
 	int pos;
-	u32 size, csum;
+	u32 size;
 	char *data, *err;
 	int ret;
 
 	/* Cut out the bootconfig data even if we have no bootconfig option */
-	data = get_boot_config_from_initrd(&size, &csum);
+	data = get_boot_config_from_initrd(&size);
 
 	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
@@ -438,11 +441,6 @@ static void __init setup_boot_config(void)
 		return;
 	}
 
-	if (xbc_calc_checksum(data, size) != csum) {
-		pr_err("bootconfig checksum failed\n");
-		return;
-	}
-
 	ret = xbc_init(data, size, &msg, &pos);
 	if (ret < 0) {
 		if (pos < 0)
@@ -471,7 +469,7 @@ static void __init exit_boot_config(void)
 static void __init setup_boot_config(void)
 {
 	/* Remove bootconfig data from initrd */
-	get_boot_config_from_initrd(NULL, NULL);
+	get_boot_config_from_initrd(NULL);
 }
 
 static int __init warn_bootconfig(char *str)

