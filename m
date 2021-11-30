Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206D2463210
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237292AbhK3LSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237021AbhK3LSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:18:33 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42CEC061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:15:14 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u11so14661370plf.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rdsjfFHqX642qunomfVevr0xZO4B7l7BwZzd9GncTMg=;
        b=YjLjEJ4yELBTYRjMTc/fX9pW67vArm4i/SowWdVZWtLN3bA1NgpPCWVcb0WJhfGtFk
         Uip7lllxMxDB+prkwQfpNjNM6ZrAI1tYUum8AfCPslX5jL1kGQa/3r/P+KSUx0OPcZuC
         ZbOQka1QSchSrPg06A4eFJiXZFIYnldiIkyU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rdsjfFHqX642qunomfVevr0xZO4B7l7BwZzd9GncTMg=;
        b=xUETnsmFJs1OHAFwIlz8Eib4zOIYCKhptX26IhZOclbT/a8luQ9DNw9zWCTAesukoL
         k5ncY+wiIyuaWBobduAzKZRitHnKTfV0CIre64y4D/6uLQ1qttYPTJ7AY1X0ab0MrcBU
         +4ewmcKVDuh7uTQliFzbSjo8AI/W7n9AEw+zwG6JDUqOdb2T7uAziw36ThI4x8AYpSwl
         1sMHmnr9dS2On+Dd+x2GqLZwrxKyDelpV/jhZDk76brNVeEB0+1nwKb3Kj5aHA5DrNI0
         IPYM4WiHwKWkztwRjVgJw4H20/LlelRNMhgwG4pjnznErFWoYJc8zlMHfrRf6v195zj0
         I3Sw==
X-Gm-Message-State: AOAM531hDRcayeEV8tBW9EoEvKNfn499b31oSKuYbfDeV5LylCBVVisA
        85jsrra9mByQT2zDVW0UE7y0mA==
X-Google-Smtp-Source: ABdhPJwr05mwONjYFKktSg6D9PwX/cNhWN0ds3xJvtnD4qdwvn1PIwNh2hF0abiJ8CW5MmyPxU8K/w==
X-Received: by 2002:a17:902:a40e:b0:143:ca72:be9d with SMTP id p14-20020a170902a40e00b00143ca72be9dmr67090947plq.67.1638270914271;
        Tue, 30 Nov 2021 03:15:14 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:8ed3:948d:3bfd:26b3])
        by smtp.gmail.com with ESMTPSA id h36sm15624206pgb.9.2021.11.30.03.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:15:13 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC][PATCH] checkpatch: require Fixes tag for fixup patches
Date:   Tue, 30 Nov 2021 20:15:03 +0900
Message-Id: <20211130111503.2930770-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Require "Fixes: hash" tag in those patches that appear to be
fixing some particular commit.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 scripts/checkpatch.pl | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index df8b23dc1eb0..4e97d0f6b995 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2493,6 +2493,9 @@ sub process {
 	my $commit_log_has_diff = 0;
 	my $reported_maintainer_file = 0;
 	my $non_utf8_charset = 0;
+	my $fixes_id = 0;
+	my $fixes_description = 0;
+	my $fixes_tag = 0;
 
 	my $last_blank_line = 0;
 	my $last_coalesced_string_linenr = -1;
@@ -3076,6 +3079,11 @@ sub process {
 			}
 		}
 
+# Check for Fixes tag
+		if ($in_commit_log && $line =~ /\b[Ff]ixes:\s*[0-9a-f]{12,40}/) {
+			$fixes_tag = 1;
+		}
+
 # Check for git id commit length and improperly formed commit descriptions
 		if ($in_commit_log && !$commit_log_possible_stack_dump &&
 		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink|base-commit):/i &&
@@ -3128,6 +3136,11 @@ sub process {
 			($id, $description) = git_commit_info($orig_commit,
 							      $id, $orig_desc);
 
+			if (defined($id)) {
+				$fixes_id = $id;
+				$fixes_description = $description;
+			}
+
 			if (defined($id) &&
 			   ($short || $long || $space || $case || ($orig_desc ne $description) || !$hasparens)) {
 				ERROR("GIT_COMMIT_ID",
@@ -7326,6 +7339,12 @@ sub process {
 		}
 	}
 
+	if ($is_patch && $has_commit_log && $fixes_id && !$fixes_tag) {
+		ERROR("GIT_COMMIT_ID",
+		      "Please add 'Fixes: $fixes_id (\"$fixes_description\")'\n", );
+		$fixes_id = 0;
+	}
+
 	print report_dump();
 	if ($summary && !($clean == 1 && $quiet == 1)) {
 		print "$filename " if ($summary_file);
-- 
2.34.0.rc2.393.gf8c9666880-goog

