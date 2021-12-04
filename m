Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97B346848A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 12:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353842AbhLDLtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 06:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbhLDLsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 06:48:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ED4C061354;
        Sat,  4 Dec 2021 03:45:30 -0800 (PST)
Date:   Sat, 04 Dec 2021 11:45:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638618328;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IHdrmbcguTtQSIVO9y+Ktomr3vJVgk+MvIzxkFtJN+U=;
        b=18mvdTg6g2wE1tGbNR9UQfGI5OGQd4OFZphEhcOFHCd8mChLlBqjsBkqbK4yn4InzG6L8H
        YuTuBgqgY4OdQi9TGK1yMRsFRzRRlBlm+RoVYKHMt4MtcGLGHmTChJMzwOfxjKUyRxeWOs
        S9TBSbOVD16Xv3DjDS5ZhS0AOJCyqxHhPw/znnpZmouo0uReY32cFMoDcHl7tgL+x0L74s
        V9ZHLaaa2AU6uRCxCn4Gi6AqbIiR/vEXjXCS+/KqHNViDzEg+GLWwEqh9TU3vOPSdY5ej3
        maBbT4Ogbu2Y5CFdhKQZWG5qfLih4mYe89hqjpqf7F9QA8WNEiDzvdDew7MOFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638618328;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IHdrmbcguTtQSIVO9y+Ktomr3vJVgk+MvIzxkFtJN+U=;
        b=BNIIVVAHVPXtQbJ5qpD2yxhhaC3el82zSpq8gafJYLFxfbMKNKFBn59FOZRnUkfPG0CSq5
        1ueulDz7JXX85QDg==
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry: Add a fence for kernel entry SWAPGS in
 paranoid_entry()
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211126101209.8613-2-jiangshanlai@gmail.com>
References: <20211126101209.8613-2-jiangshanlai@gmail.com>
MIME-Version: 1.0
Message-ID: <163861832744.11128.13308101823885299337.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c07e45553da1808aa802e9f0ffa8108cfeaf7a17
Gitweb:        https://git.kernel.org/tip/c07e45553da1808aa802e9f0ffa8108cfeaf7a17
Author:        Lai Jiangshan <laijs@linux.alibaba.com>
AuthorDate:    Fri, 26 Nov 2021 18:11:21 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 03 Dec 2021 18:55:47 +01:00

x86/entry: Add a fence for kernel entry SWAPGS in paranoid_entry()

Commit

  18ec54fdd6d18 ("x86/speculation: Prepare entry code for Spectre v1 swapgs mitigations")

added FENCE_SWAPGS_{KERNEL|USER}_ENTRY for conditional SWAPGS. In
paranoid_entry(), it uses only FENCE_SWAPGS_KERNEL_ENTRY for both
branches. This is because the fence is required for both cases since the
CR3 write is conditional even when PTI is enabled.

But

  96b2371413e8f ("x86/entry/64: Switch CR3 before SWAPGS in paranoid entry")

changed the order of SWAPGS and the CR3 write. And it missed the needed
FENCE_SWAPGS_KERNEL_ENTRY for the user gsbase case.

Add it back by changing the branches so that FENCE_SWAPGS_KERNEL_ENTRY
can cover both branches.

  [ bp: Massage, fix typos, remove obsolete comment while at it. ]

Fixes: 96b2371413e8f ("x86/entry/64: Switch CR3 before SWAPGS in paranoid entry")
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211126101209.8613-2-jiangshanlai@gmail.com
---
 arch/x86/entry/entry_64.S | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index e38a4cf..f1a8b5b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -890,6 +890,7 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 .Lparanoid_entry_checkgs:
 	/* EBX = 1 -> kernel GSBASE active, no restore required */
 	movl	$1, %ebx
+
 	/*
 	 * The kernel-enforced convention is a negative GSBASE indicates
 	 * a kernel value. No SWAPGS needed on entry and exit.
@@ -897,21 +898,14 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	movl	$MSR_GS_BASE, %ecx
 	rdmsr
 	testl	%edx, %edx
-	jns	.Lparanoid_entry_swapgs
-	ret
+	js	.Lparanoid_kernel_gsbase
 
-.Lparanoid_entry_swapgs:
+	/* EBX = 0 -> SWAPGS required on exit */
+	xorl	%ebx, %ebx
 	swapgs
+.Lparanoid_kernel_gsbase:
 
-	/*
-	 * The above SAVE_AND_SWITCH_TO_KERNEL_CR3 macro doesn't do an
-	 * unconditional CR3 write, even in the PTI case.  So do an lfence
-	 * to prevent GS speculation, regardless of whether PTI is enabled.
-	 */
 	FENCE_SWAPGS_KERNEL_ENTRY
-
-	/* EBX = 0 -> SWAPGS required on exit */
-	xorl	%ebx, %ebx
 	ret
 SYM_CODE_END(paranoid_entry)
 
