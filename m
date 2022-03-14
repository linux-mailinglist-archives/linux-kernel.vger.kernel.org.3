Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB614D7E34
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbiCNJJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbiCNJJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:09:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D2237A23;
        Mon, 14 Mar 2022 02:08:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78905B80D55;
        Mon, 14 Mar 2022 09:08:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF8EC340E9;
        Mon, 14 Mar 2022 09:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647248915;
        bh=JzzzQoL0GbYCQzlYz/yEZ+EV3sEjDtQ9rE0YeOlbuRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AH1VJFY9xqpt3O7fLoRfBGbg99R9/1TFlUYe3QA670YX1+RT0QP4PuDBh6T7yim2z
         Ye93+atkQQAG20CMmgILWf9969/w+IdjWGPP17ob88d1apCN+5eH40TXBPDfsyIC7i
         jgsK0f/oujLD+fSZFsNrywJUtPGSdk+PXV5xQVB3DYRWmg6H4YvjZqjMJEUbnWoxV7
         Gu1u0RXLgGo7ot16z/nqmae7aO2zkS5AajlU4+VRyQx+0bF8F499dz/3EdzZIX5Kux
         n5mFZ5m8LFf79XL0e29PAYZOoikbNq0qjTFkW4OTK8Lk9oGa4LUHToa85143Gj6VYv
         VS3ZB11T+a8wQ==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 1/3] bootconfig: Check the checksum before removing the bootconfig from initrd
Date:   Mon, 14 Mar 2022 18:08:31 +0900
Message-Id: <164724891101.731226.10764834379284738438.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164724890153.731226.1478494969800777757.stgit@devnote2>
References: <164724890153.731226.1478494969800777757.stgit@devnote2>
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

