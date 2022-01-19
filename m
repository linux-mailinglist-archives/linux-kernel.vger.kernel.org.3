Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076954935C2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352150AbiASHq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245700AbiASHq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:46:26 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216B0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 23:46:26 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id hv15so1725470pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 23:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CjGlKRPaKETs3fmFERLry6AgFLftgNGdja3wVLccreQ=;
        b=ENZ0qaDCO/Qqijwn3xT4AR1ccgXJ0Uq9+CVyZu6IGdYtJzGVK3YN8ij4R9bbXd/jvV
         oTE0u1ECOkbOGwK2Gwc/feo/n3AVlQccsa+IDzzgtxeXCUm4JoKWcpRjI/XUMmJtHTuo
         QfaY4xsjhk/+a65svTKRyhH4H3cgXcP+LxEFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CjGlKRPaKETs3fmFERLry6AgFLftgNGdja3wVLccreQ=;
        b=4GQNhC5iNba0izN7wjavR75uF18oEAxPOgDF1z7l2ZAy6ppCIH1tJRh9lKw60SBKJk
         tC/M+FqvXMpRcgnEinZ0qmUo6LrHPFMMzZxzQmIOoGDvL78Qk+c4ByGDyWnF9F3yGVme
         f52lIHSWPEYvzpvaKSLkn1GuZQGDCtiCPK5lrdOn7pPBaqprvociSqtJoH3JPTRLQgdd
         9fz0Czg318sz94gPjI9n255HFRvaBdizbjCSFkgjmOMP3RwVsPC3lo5vI9wuS60gaqzy
         pvrarJNre7DF9jsJ0U2PlFyJfxypC6VUD0GAZ80kCEY9jWoen9AGqfmkt7cylFjoo9O1
         97lQ==
X-Gm-Message-State: AOAM532prfjVj5H7XeKJ2/48W8pPt8KTNuBEuEEn9yTAAIS9H4PfI661
        J4zIWo/V3CByr/0YO9OBLESCuyImipYvH6OU
X-Google-Smtp-Source: ABdhPJy2hLMp74v0H/70JiMyBH1BfKIbz4duQ7DFZwL+FqlfZsve7ZcWKQZk+XS10x/U7ji5pEpyzw==
X-Received: by 2002:a17:902:dac7:b0:14a:537b:db2a with SMTP id q7-20020a170902dac700b0014a537bdb2amr31318501plx.3.1642578385636;
        Tue, 18 Jan 2022 23:46:25 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:3343:314a:558d:5df7])
        by smtp.gmail.com with ESMTPSA id r19sm8480476pgi.58.2022.01.18.23.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 23:46:25 -0800 (PST)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RESEND][PATCH] checkpatch: make sure fix-up patches have Fixes tag
Date:   Wed, 19 Jan 2022 16:46:09 +0900
Message-Id: <20220119074609.4162747-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a patch contains "commit hash (commit name)", in other words
if the patch fixes some particular commit, then require "Fixes:"
tag.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Change-Id: I066ae0e607a67ac83c6ba0ff8d883f7e7a4a73e0
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
2.34.1.703.g22d0c6ccf7-goog

