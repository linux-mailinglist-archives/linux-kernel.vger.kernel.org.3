Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484B54E74C6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 15:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359292AbiCYOHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 10:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359264AbiCYOGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 10:06:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AC4D8F4B;
        Fri, 25 Mar 2022 07:05:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E551D61AFB;
        Fri, 25 Mar 2022 14:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4396AC340F5;
        Fri, 25 Mar 2022 14:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648217118;
        bh=WUbC8iv4z1FG3/dSJ3crKi1kvQQgoCPRCCQlmTdH6fM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VrsvSUsJfXJ8qBH/DFssjDNCvUv3ZrJdlq+jA6yYU4rWDt89hoIdFF4g8HB2vBZHa
         eyBPxVIirW6iquG4DcAOQfqwY3v6Z8GviMCJy6ZHPtMFx/cASuarYLBZxjNuOgef5m
         +FTXX3EGNh5/hmPxg9SgM6MaamOiw4d0t2n5LzGzSmSqJQPB6SkYbGzhrfecPSohux
         iP+32gh8wEyWzEiBxlzkGi8yZlVuMM6GCV0oFJqedt7VEP159hVAoYZ5wJ0YEBZk0r
         ezG3jjX4ylfFONrr3NKS6dtm4W+6JohqdgcpNm+/2Ub7rDpzoxNKobI8hyeZbWnsTN
         346I1xwlWUzEg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nXkZ1-00Axz1-Rb; Fri, 25 Mar 2022 15:05:15 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] docs: kernel_feat.py: add build dependencies
Date:   Fri, 25 Mar 2022 15:05:13 +0100
Message-Id: <c4684a9a6ddd59e894b3f2776044f713b53ee9ca.1648216561.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648216561.git.mchehab@kernel.org>
References: <cover.1648216561.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
See [PATCH v2 0/4] at: https://lore.kernel.org/all/cover.1648216561.git.mchehab@kernel.org/

 Documentation/sphinx/kernel_feat.py | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/sphinx/kernel_feat.py b/Documentation/sphinx/kernel_feat.py
index 8138d69a6987..6b40ac1806bb 100644
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
+        line_regex = re.compile("^#define FILE (\S+)$")
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

