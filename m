Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6070A48A0AB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 21:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243781AbiAJUGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 15:06:07 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40950 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243576AbiAJUGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 15:06:06 -0500
Received: from localhost.localdomain (unknown [IPv6:2a00:c281:11a2:800:8072:ec19:b639:c4ab])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1D36D1F42377;
        Mon, 10 Jan 2022 20:05:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641845165;
        bh=EfMqLa5saIQ7vkG2HnyNEt/xCNewg7ww2t58HHVgepc=;
        h=From:To:Cc:Subject:Date:From;
        b=YEqwaPnII+HcRPIglimlEqjI47THt14ruc4Et6VMA/MFW/CHZ5i6zAhNsAk4/eXPy
         ltySWvQenLiJQoymoqfl1iTDCxxx4sBRGgDXa2q7VMQ3FZKUCNCWayvtvE2+CxYY0W
         Bae26+wYn+cJNIWHmZv11W++SlegeJFPln4ks/yXvSJptxLj5QrJNLLg5QZBvoMp/A
         DvYdIkEgZsbAWlpF/x6c58pNz+ceAz/CMcSWAL6QqbPpUdrKGtpQkbNfPDP8vuuJvY
         04HCtHClnrckLcya6IVXHU4mTwRFp4tYo4qxqCXOU5gRkcRqOE4n0Wh4Tt8ekZ9MIV
         Ajs+yw2/6uTLw==
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        kernel@collabora.com, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] checkpatch: warn for p0 patch only if prefix is not b
Date:   Mon, 10 Jan 2022 22:05:29 +0200
Message-Id: <20220110200529.18601-1-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It might be that file 'b' happens to exit. In that
case, if the prefix is also 'b' (which is the
common case) we get the falsely warning:

patch prefix 'b' exists, appears to be a -p0 patch

So warn only if prefix is not 'b'

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1784921c645d..72263b142e39 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2821,7 +2821,7 @@ sub process {
 			$in_commit_log = 0;
 
 			$p1_prefix = $1;
-			if (!$file && $tree && $p1_prefix ne '' &&
+			if (!$file && $tree && $p1_prefix ne '' && $p1_prefix ne 'b' &&
 			    -e "$root/$p1_prefix") {
 				WARN("PATCH_PREFIX",
 				     "patch prefix '$p1_prefix' exists, appears to be a -p0 patch\n");
-- 
2.17.1

