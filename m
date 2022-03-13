Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287D64D759D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 14:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbiCMN5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 09:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbiCMN5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 09:57:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8CC5F26F;
        Sun, 13 Mar 2022 06:56:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D9AD61132;
        Sun, 13 Mar 2022 13:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507B4C340E8;
        Sun, 13 Mar 2022 13:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647179782;
        bh=JzzzQoL0GbYCQzlYz/yEZ+EV3sEjDtQ9rE0YeOlbuRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aajCR6iU5GNO0BM0edEqBmoxaDfYv9j8hg//7hghdxCFOTrr/+nfIG7S+TTCn5A9A
         3mLslCc5tXYYRob+np3frOQyDX400ukq3hdLlqENWV6jFYO5jfSy6ykenQPSYJCEh7
         5owyAiWqTvbbB/RbuWuHhyPqXF0bZ4qjCSEUQew5B+8a0m1VuEsN+UJtMAH5Z1c4sJ
         lBWgKihmUXlihiXcz0SxkTBEi7l1vzlpALruWEDCb7lrWC04xfLZvbpMZG1ph29+nd
         g9DqsbTC/33Q2p8rh+l1eLnUrf5kcGVX8AXyxSJNzeYxOTKsvvxiDQ+YfHjggJOLee
         ulcFCvXaOmFEw==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 1/3] bootconfig: Check the checksum before removing the bootconfig from initrd
Date:   Sun, 13 Mar 2022 22:56:18 +0900
Message-Id: <164717977849.656425.521984791585777500.stgit@devnote2>
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

Check the bootconfig's checksum before removing the bootcinfig data
from initrd to avoid modifying initrd by mistake.
This will also simplifies the get_boot_config_from_initrd() interface.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 init/main.c |   22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/init/main.c b/init/main.c
index 65fa2e41a9c0..421050be5039 100644
--- a/init/main.c
+++ b/init/main.c
@@ -265,7 +265,7 @@ static int __init loglevel(char *str)
 early_param("loglevel", loglevel);
 
 #ifdef CONFIG_BLK_DEV_INITRD
-static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
+static void * __init get_boot_config_from_initrd(u32 *_size)
 {
 	u32 size, csum;
 	char *data;
@@ -299,17 +299,20 @@ static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
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
@@ -408,12 +411,12 @@ static void __init setup_boot_config(void)
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
@@ -437,11 +440,6 @@ static void __init setup_boot_config(void)
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
@@ -470,7 +468,7 @@ static void __init exit_boot_config(void)
 static void __init setup_boot_config(void)
 {
 	/* Remove bootconfig data from initrd */
-	get_boot_config_from_initrd(NULL, NULL);
+	get_boot_config_from_initrd(NULL);
 }
 
 static int __init warn_bootconfig(char *str)

