Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705064ED39E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 07:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiCaF6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 01:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiCaF6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 01:58:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2114D19F238;
        Wed, 30 Mar 2022 22:56:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0B8E61543;
        Thu, 31 Mar 2022 05:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC145C340F0;
        Thu, 31 Mar 2022 05:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648706186;
        bh=/pcY0qB26eKeKCiib1+H0TY1vZCA9lmqTBCYWM/MIgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/BGPLXhNfCDu+TgI7uhWWvH5Md8sHjltOEJYq4B246S5z2/lb/TM0qCXZyJ/PXbc
         VCh14XkyZUIzZ/qOcj0L4nFLDE1Vi4gwi3PcigYBncb6+5cSVpnj/VpDgva3OfbNhw
         beY58UCsMeFfilWlV542dNTGj8foKlfWHyP2E8btNIiR0/6K3w0jt3+VOGNNizNE2u
         dI/87GUazfxo3UsH4XYy5eTsP/nc8RiiEo88SJA93CxzPoT137OObSe1YJCkzkGl5Q
         jYgYw4f7LMEAKLdfz8N+eX5EVA8LavMVWf4NAu61/oV7nuNXVlfPFGipnqcHpCo/a5
         6XsYdpq3XgcEQ==
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
Subject: [PATCH v6 2/4] bootconfig: Check the checksum before removing the bootconfig from initrd
Date:   Thu, 31 Mar 2022 14:56:20 +0900
Message-Id: <164870618003.127053.14933543809840547148.stgit@devnote2>
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

