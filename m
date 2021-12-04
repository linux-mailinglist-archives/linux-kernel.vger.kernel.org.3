Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E34B468805
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 23:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352149AbhLDWH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 17:07:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40680 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241313AbhLDWHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 17:07:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FABBB80DAB
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 22:03:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED114C341C6;
        Sat,  4 Dec 2021 22:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638655434;
        bh=KKkQKz7YaSOijVhEN1jjAuBeRAr88jX6ff5BW+zjNw8=;
        h=From:To:Cc:Subject:Date:From;
        b=ZA2VYsetzp1OCF0rdJHZ0dFEHyDo+sfyFEvJRm7rJE/gRTLicu3g9tV0E+AcV6px5
         FCw35TLq/hOKTTrL4WC9/ZMJDT6WIzPS/TRLdZ/xNYfB8v1pKmmVXr5eotBBAjpF+z
         VrjV3eSK+DCYFCgkOoj1lMOJ1zTMqj3eZYbXbnLVT3TPwfBpK7tZVVTRaqjFWtvcgJ
         peWBtkUv628feX1BqTW7dlkba6hNlhnqgkgGhEA88FcvI/UY1+O2EZyPQxBR9+jF4h
         MtdkcoJFZk97e+TLRJupWZwaIM5WeeS3daRpzeWW4lY/aiQQOHJHtukRZxZ9G+Ezym
         4kZpypqOQb6BQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] cachefiles: fix __cachefiles_prepare_write() error handling
Date:   Sat,  4 Dec 2021 23:03:16 +0100
Message-Id: <20211204220350.633811-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

clang points out that __cachefiles_prepare_write() returns an
uninitialized error code in one of the code paths:

fs/cachefiles/io.c:489:6: error: variable 'ret' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
        if (pos == 0)
            ^~~~~~~~
fs/cachefiles/io.c:492:6: note: uninitialized use occurs here
        if (ret < 0) {
            ^~~
fs/cachefiles/io.c:489:2: note: remove the 'if' if its condition is always true
        if (pos == 0)
        ^~~~~~~~~~~~~
fs/cachefiles/io.c:440:9: note: initialize the variable 'ret' to silence this warning
        int ret;
               ^

Rework to return zero for success here and skip the rest of the
function.

Fixes: 0443b01eccbb ("cachefiles: Implement the I/O routines")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/cachefiles/io.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 74ef4d1fc562..0fab313a604d 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -486,9 +486,11 @@ static int __cachefiles_prepare_write(struct netfs_cache_resources *cres,
 	/* Partially allocated, but insufficient space: cull. */
 	fscache_count_no_write_space();
 	pos = cachefiles_inject_remove_error();
-	if (pos == 0)
-		ret = vfs_fallocate(file, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-				    *_start, *_len);
+	if (pos != 0)
+		return 0;
+
+	ret = vfs_fallocate(file, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+			    *_start, *_len);
 	if (ret < 0) {
 		trace_cachefiles_io_error(object, file_inode(file), ret,
 					  cachefiles_trace_fallocate_error);
-- 
2.29.2

