Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011FC468488
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 12:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344429AbhLDLs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 06:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbhLDLsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 06:48:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408D0C061751;
        Sat,  4 Dec 2021 03:45:30 -0800 (PST)
Date:   Sat, 04 Dec 2021 11:45:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638618327;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Rv16amoOJU48Qefvj434LiLlJQhglGv2zTakpo7RAU=;
        b=uLHUkgl6A9txw49je5/tPe4GTs2pG4L5pc6TgvYfVc8dUPYQmD5G/qsjew7L2F5TTnkjK8
        HNc/2Xs+YEG+9//qoV10nsuJsWwi2SV/ad1YGKLY17PG4oDjocNxPlywn5s2zYzu+VOAz3
        msUQSK2ULjkcnb/ca0oY3Y3XNey57xWW1xpPTKbWHhzdtaGY425GJTNPA2WQ21vc7hkxpo
        8I2WuUnIL3r3kEhW26IDZsU+PPbTQHU67MhTWACxXUD38maKUE1QwOg3i4qNcORWduWYw5
        2Mxc60Dg94Q68dwVY1JQdOUzTTa9dtJMj5T4bxg3XaWryA8BRsf4OlAngGV0xA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638618327;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Rv16amoOJU48Qefvj434LiLlJQhglGv2zTakpo7RAU=;
        b=7pGzpJxvKpllgV3hAtF5eCWnadpv4elxqXuJo0b9QHSrLD95XUL7dpU0xmkv/mZKvUyNw4
        NNpad8Lpxqt/kfDQ==
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry: Use the correct fence macro after swapgs
 in kernel CR3
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211126101209.8613-3-jiangshanlai@gmail.com>
References: <20211126101209.8613-3-jiangshanlai@gmail.com>
MIME-Version: 1.0
Message-ID: <163861832657.11128.14542109186341632803.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     1367afaa2ee90d1c956dfc224e199fcb3ff3f8cc
Gitweb:        https://git.kernel.org/tip/1367afaa2ee90d1c956dfc224e199fcb3ff3f8cc
Author:        Lai Jiangshan <laijs@linux.alibaba.com>
AuthorDate:    Fri, 26 Nov 2021 18:11:22 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 03 Dec 2021 19:13:53 +01:00

x86/entry: Use the correct fence macro after swapgs in kernel CR3

The commit

  c75890700455 ("x86/entry/64: Remove unneeded kernel CR3 switching")

removed a CR3 write in the faulting path of load_gs_index().

But the path's FENCE_SWAPGS_USER_ENTRY has no fence operation if PTI is
enabled, see spectre_v1_select_mitigation().

Rather, it depended on the serializing CR3 write of SWITCH_TO_KERNEL_CR3
and since it got removed, add a FENCE_SWAPGS_KERNEL_ENTRY call to make
sure speculation is blocked.

 [ bp: Massage commit message and comment. ]

Fixes: c75890700455 ("x86/entry/64: Remove unneeded kernel CR3 switching")
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211126101209.8613-3-jiangshanlai@gmail.com
---
 arch/x86/entry/entry_64.S | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index f1a8b5b..f9e1c06 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -987,11 +987,6 @@ SYM_CODE_START_LOCAL(error_entry)
 	pushq	%r12
 	ret
 
-.Lerror_entry_done_lfence:
-	FENCE_SWAPGS_KERNEL_ENTRY
-.Lerror_entry_done:
-	ret
-
 	/*
 	 * There are two places in the kernel that can potentially fault with
 	 * usergs. Handle them here.  B stepping K8s sometimes report a
@@ -1014,8 +1009,14 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * .Lgs_change's error handler with kernel gsbase.
 	 */
 	SWAPGS
-	FENCE_SWAPGS_USER_ENTRY
-	jmp .Lerror_entry_done
+
+	/*
+	 * Issue an LFENCE to prevent GS speculation, regardless of whether it is a
+	 * kernel or user gsbase.
+	 */
+.Lerror_entry_done_lfence:
+	FENCE_SWAPGS_KERNEL_ENTRY
+	ret
 
 .Lbstep_iret:
 	/* Fix truncated RIP */
