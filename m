Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95AA4E807B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 11:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbiCZK3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 06:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiCZK3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 06:29:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA9B4F44E;
        Sat, 26 Mar 2022 03:27:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C26DA60B8A;
        Sat, 26 Mar 2022 10:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EAFC34100;
        Sat, 26 Mar 2022 10:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648290447;
        bh=+MIt+athm81UOKvOGZ5ZQcQ4L0fnD6TdonEeO/0FhQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dyyW0Q4+ZIt8W1n0J5Zg9uDJEsXLhDtBkhqVtrloMm5rBoY0azcmyRQRRH4xjmkYy
         hxdjaxIixFqpIsSl45hZDImEXpz6BaqyRh63ZHMEI167tqUZ5AnMQ6I6fQ23MaatD5
         5JOjnZ8E1Nb7B8g3ucNapkZdbVOnEwb0dLqGLNeN8QvpZc6cxn6uPDSQBZG1DW6LJZ
         KYe0MZ2Sd6zbDRCJijvrGQtWG+6uWKEXy89V8cPhddONGxTz6ShcARMe+VOr+t6YQJ
         7H4g54vPWEgJoZ+MAHdOYTsEZvrcbz/3B90oCmOK/IneGJDGASKxniIoW6wY5uBON/
         rbsFtq38YWz0A==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nY3dl-00Co0Y-3N; Sat, 26 Mar 2022 11:27:25 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] docs: kernel_feat.py: add build dependencies
Date:   Sat, 26 Mar 2022 11:27:20 +0100
Message-Id: <5cdf7a8300019129dcc09d4c2557f75908754445.1648290305.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648290305.git.mchehab@kernel.org>
References: <cover.1648290305.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that the feature files will be regenerated if any
changes happen at the Documentation/features files that were
processed by gen_feat.pl.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH v3 0/6] at: https://lore.kernel.org/all/cover.1648290305.git.mchehab@kernel.org/

 Documentation/sphinx/kernel_feat.py | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/sphinx/kernel_feat.py b/Documentation/sphinx/kernel_feat.py
index 8138d69a6987..27b701ed3681 100644
--- a/Documentation/sphinx/kernel_feat.py
+++ b/Documentation/sphinx/kernel_feat.py
@@ -33,6 +33,7 @@ u"""
 
 import codecs
 import os
+import re
 import subprocess
 import sys
 
@@ -82,7 +83,7 @@ class KernelFeat(Directive):
 
         env = doc.settings.env
         cwd = path.dirname(doc.current_source)
-        cmd = "get_feat.pl rest --dir "
+        cmd = "get_feat.pl rest --enable-fname --dir "
         cmd += self.arguments[0]
 
         if len(self.arguments) > 1:
@@ -102,7 +103,22 @@ class KernelFeat(Directive):
         shell_env["srctree"] = srctree
 
         lines = self.runCmd(cmd, shell=True, cwd=cwd, env=shell_env)
-        nodeList = self.nestedParse(lines, fname)
+
+        line_regex = re.compile("^\.\. FILE (\S+)$")
+
+        out_lines = ""
+
+        for line in lines.split("\n"):
+            match = line_regex.search(line)
+            if match:
+                fname = match.group(1)
+
+                # Add the file to Sphinx build dependencies
+                env.note_dependency(os.path.abspath(fname))
+            else:
+                out_lines += line + "\n"
+
+        nodeList = self.nestedParse(out_lines, fname)
         return nodeList
 
     def runCmd(self, cmd, **kwargs):
-- 
2.35.1

