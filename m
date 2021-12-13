Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B56847331C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 18:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241631AbhLMRfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 12:35:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36244 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241493AbhLMRfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 12:35:12 -0500
Date:   Mon, 13 Dec 2021 17:35:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639416910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w9wJqBLnc8EyiMWdevWmek45Ba2p/f0U0rHqDab0VK0=;
        b=D0NDCR0ic2qUWMjL6xirF2SP1btorQu0SEV7OMmEzlz2rNYJY91tz8yQ+LaFMhmebcssx2
        6Sqx0gHJXiY0atIN6tY8BRnGnzvFGAAGPt/Wp5QYwne1y21OzMM9qaPzXqSc9FXfVdxZT6
        o/v0Y7BRFgfxPc+95WUxiwTImVbTHO3jquoUXkyd8dro/m/m5ZsxuhX8ImiQty0U+S9iSm
        0AW8JB1WT+w7A4gjD3JlbZivn2qXuF7H38T5e7X9zD1MmYOyj/cpgN1jo8uAs9cmwb6xbJ
        fdMywW/aHzlvhv9LP2FToJ84QKixli9ysLMERKlKpdsQaSF0iMdh9hwK4HNgOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639416910;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w9wJqBLnc8EyiMWdevWmek45Ba2p/f0U0rHqDab0VK0=;
        b=ZdGL2GLo1ubu/yAK9ASv/yBvyijNezsSu+NT6GVPCaDibmGA675cCABJ7B20Rah0JK0liX
        5d7ypkVZ5KYivVDA==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Do not use memset to clear the banks bitmaps
Cc:     Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211208111343.8130-2-bp@alien8.de>
References: <20211208111343.8130-2-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <163941690952.23020.7152977304266098823.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     cd5e0d1fc93a2218fbfb2b614f06e04e218ca948
Gitweb:        https://git.kernel.org/tip/cd5e0d1fc93a2218fbfb2b614f06e04e218ca948
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Mon, 01 Nov 2021 15:34:48 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Dec 2021 14:11:22 +01:00

x86/mce: Do not use memset to clear the banks bitmaps

The bitmap is a single unsigned long so no need for the function call.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211208111343.8130-2-bp@alien8.de
---
 arch/x86/kernel/cpu/mce/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 30de00f..7c264ee 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1336,8 +1336,8 @@ static noinstr void unexpected_machine_check(struct pt_regs *regs)
 noinstr void do_machine_check(struct pt_regs *regs)
 {
 	int worst = 0, order, no_way_out, kill_current_task, lmce;
-	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS);
-	DECLARE_BITMAP(toclear, MAX_NR_BANKS);
+	DECLARE_BITMAP(valid_banks, MAX_NR_BANKS) = { 0 };
+	DECLARE_BITMAP(toclear, MAX_NR_BANKS) = { 0 };
 	struct mca_config *cfg = &mca_cfg;
 	struct mce m, *final;
 	char *msg = NULL;
@@ -1381,7 +1381,6 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	final = this_cpu_ptr(&mces_seen);
 	*final = m;
 
-	memset(valid_banks, 0, sizeof(valid_banks));
 	no_way_out = mce_no_way_out(&m, &msg, valid_banks, regs);
 
 	barrier();
