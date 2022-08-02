Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4934A5882FD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 22:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiHBULf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 16:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiHBULc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 16:11:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F1C14D1C;
        Tue,  2 Aug 2022 13:11:31 -0700 (PDT)
Date:   Tue, 02 Aug 2022 20:11:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659471090;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SATzoMBj9sEgF2bNHztIfGVAPHICwvpaJN0/DnFssCE=;
        b=0WnbN0rCWBUNLiRsDbdtB5rxJmUqdiPD4O3srcqQi0Xfx4RSr4JjXO9LQ8e0UtXASh9tjb
        /PkbnNmPuDXt+r6S+wBwOY3RtSp/J2g+CUO388gwZur/Q0r4c9GHBfmczONCbNALD4+/J5
        xaYpJGirRSD/k1GGtaPlvvQyaPsAAWOGWyX5eqgJBXWUo8y4eWOrftsTC0YhjqJLuY+CYA
        dlptixOnXnaPWAuq7X7rviS1qoCQhp2gZRZRqJ+Zvj3gFHZboMgjrB5VuThdxKGLLSjuDi
        bWX2BR2/LJlPNLB25B0OUbEi59bSxStuWkVLi/BjNgiDwb4sRbukhhC51rZP5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659471090;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SATzoMBj9sEgF2bNHztIfGVAPHICwvpaJN0/DnFssCE=;
        b=H6466TLXs9t1PVXst4R+I9kB9HZUbhYULlnm4Rig0JEZ7ElNDEDVZxXO8q/4fHiKiV5c1X
        UivLrFOw3xVXgMBg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] scripts/faddr2line: Fix vmlinux detection on arm64
Cc:     John Garry <john.garry@huawei.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <dad1999737471b06d6188ce4cdb11329aa41682c.1658426357.git.jpoimboe@kernel.org>
References: <dad1999737471b06d6188ce4cdb11329aa41682c.1658426357.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <165947108915.15455.153331710686410.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     b6a5068854cfe372da7dee3224dcf023ed5b00cb
Gitweb:        https://git.kernel.org/tip/b6a5068854cfe372da7dee3224dcf023ed5b00cb
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Thu, 21 Jul 2022 11:01:23 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 02 Aug 2022 22:08:16 +02:00

scripts/faddr2line: Fix vmlinux detection on arm64

Since commit dcea997beed6 ("faddr2line: Fix overlapping text section
failures, the sequel"), faddr2line is completely broken on arm64.

For some reason, on arm64, the vmlinux ELF object file type is ET_DYN
rather than ET_EXEC.  Check for both when determining whether the object
is vmlinux.

Modules and vmlinux.o have type ET_REL on all arches.

Fixes: dcea997beed6 ("faddr2line: Fix overlapping text section failures, the sequel")
Reported-by: John Garry <john.garry@huawei.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: John Garry <john.garry@huawei.com>
Link: https://lore.kernel.org/r/dad1999737471b06d6188ce4cdb11329aa41682c.1658426357.git.jpoimboe@kernel.org
---
 scripts/faddr2line | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index 94ed98d..5709968 100755
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
