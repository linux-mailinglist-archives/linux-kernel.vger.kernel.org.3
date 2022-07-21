Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5200E57D2E3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiGUSBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbiGUSBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:01:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92A48B4B2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:01:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48D21B8261F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 18:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977E1C341C0;
        Thu, 21 Jul 2022 18:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658426495;
        bh=2X7EC2fEKDDFX9102vFFdzD+y+hPXyUc3ajPWGZzqEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aY9uxJy7cF9+x2tJCU/mnh0SX/gtaYfhZ220LHGFM//Ccz1nZLz/g81ECAjQBq237
         rYmViIPkpRlAGX0sBHvSkrgWqqjtUHoZ010bnxPCwbVrtQ81Zf+ON6OLDaSsZqWv+l
         sogwpcIbH5DH95ePWEJST/+dTGEEwKqtDYgqDEKxwEZpXAht0t2h25m1/sD/3geZNV
         J0LUnHUZRNdKxzo7CeOLsz47YfOj/PbyJLw4ppuatdj8TK9SvY83mVYXY4ILWK/f3S
         xGsFqCTzw2cQCvFmqGYx0nL8aIhEu11Ma8RlvGd55bMXAFXsNkcKpbWoNxhiJYLZuu
         jtvB7D8/EohGw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 1/2] scripts/faddr2line: Fix vmlinux detection on arm64
Date:   Thu, 21 Jul 2022 11:01:23 -0700
Message-Id: <dad1999737471b06d6188ce4cdb11329aa41682c.1658426357.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1658426357.git.jpoimboe@kernel.org>
References: <cover.1658426357.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit dcea997beed6 ("faddr2line: Fix overlapping text section
failures, the sequel"), faddr2line is completely broken on arm64.

For some reason, on arm64, the vmlinux ELF object file type is ET_DYN
rather than ET_EXEC.  Check for both when determining whether the object
is vmlinux.

Modules and vmlinux.o have type ET_REL on all arches.

Fixes: dcea997beed6 ("faddr2line: Fix overlapping text section failures, the sequel")
Reported-by: John Garry <john.garry@huawei.com>
Tested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/faddr2line | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 94ed98dd899f..57099687e5e1 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -112,7 +112,9 @@ __faddr2line() {
 	# section offsets.
 	local file_type=$(${READELF} --file-header $objfile |
 		${AWK} '$1 == "Type:" { print $2; exit }')
-	[[ $file_type = "EXEC" ]] && is_vmlinux=1
+	if [[ $file_type = "EXEC" ]] || [[ $file_type == "DYN" ]]; then
+		is_vmlinux=1
+	fi
 
 	# Go through each of the object's symbols which match the func name.
 	# In rare cases there might be duplicates, in which case we print all
-- 
2.36.1

