Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BC74A008A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 19:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346566AbiA1S7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 13:59:32 -0500
Received: from relay.a.hostedemail.com ([64.99.140.24]:62530 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243033AbiA1S7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 13:59:30 -0500
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 369AB203B8;
        Fri, 28 Jan 2022 18:59:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf17.hostedemail.com (Postfix) with ESMTPA id 508FD1A;
        Fri, 28 Jan 2022 18:58:55 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] checkpatch: Add --fix option for some TRAILING_STATEMENTS
Date:   Fri, 28 Jan 2022 10:59:24 -0800
Message-Id: <20220128185924.80137-2-joe@perches.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 508FD1A
X-Spam-Status: No, score=0.25
X-Stat-Signature: rnonmx6zi7pp7bh3xxfsozfb8eddtf7n
X-Rspamd-Server: rspamout06
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX191qvOQZP7VqG+VwPBTf5I8lY+gY6QqRZE=
X-HE-Tag: 1643396335-664539
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Single line code like:

	if (foo) bar;

should generally be written:

	if (foo)
		bar;

Add a --fix test to do so.

This fix is not done when an ASSIGN_IN_IF in the same line exists.

Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b7c181ea0ac56..046a018093a7b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5551,6 +5551,7 @@ sub process {
 		    defined($stat) && defined($cond) &&
 		    $line =~ /\b(?:if|while|for)\s*\(/ && $line !~ /^.\s*#/) {
 			my ($s, $c) = ($stat, $cond);
+			my $fixed_assign_in_if = 0;
 
 			if ($c =~ /\bif\s*\(.*[^<>!=]=[^=].*/s) {
 				if (ERROR("ASSIGN_IN_IF",
@@ -5575,6 +5576,7 @@ sub process {
 						$newline .= ')';
 						$newline .= " {" if (defined($brace));
 						fix_insert_line($fixlinenr + 1, $newline);
+						$fixed_assign_in_if = 1;
 					}
 				}
 			}
@@ -5598,8 +5600,20 @@ sub process {
 					$stat_real = "[...]\n$stat_real";
 				}
 
-				ERROR("TRAILING_STATEMENTS",
-				      "trailing statements should be on next line\n" . $herecurr . $stat_real);
+				if (ERROR("TRAILING_STATEMENTS",
+					  "trailing statements should be on next line\n" . $herecurr . $stat_real) &&
+				    !$fixed_assign_in_if &&
+				    $cond_lines == 0 &&
+				    $fix && $perl_version_ok &&
+				    $fixed[$fixlinenr] =~ /^\+(\s*)((?:if|while|for)\s*$balanced_parens)\s*(.*)$/) {
+					my $indent = $1;
+					my $test = $2;
+					my $rest = rtrim($4);
+					if ($rest =~ /;$/) {
+						$fixed[$fixlinenr] = "\+$indent$test";
+						fix_insert_line($fixlinenr + 1, "$indent\t$rest");
+					}
+				}
 			}
 		}
 
-- 
2.30.0

