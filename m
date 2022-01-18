Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A61492489
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239432AbiARLR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239125AbiARLRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:17:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5452BC061574;
        Tue, 18 Jan 2022 03:17:53 -0800 (PST)
Date:   Tue, 18 Jan 2022 11:17:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642504670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fLzf2s+4QQWlsj3NdXrHo9g2Z2ZTEwjHLMXEx+8HKj4=;
        b=sl/yO5Kku+VwTm75Knx4+iKxRWFLm24DfgrkFGaUNgQ4XYxcIREebkf7v9pLcW5mNV99iW
        rQMLt7iPuUfHLo440pGwRBwwC+PvHKuD8ATadv38FOle6cG/jUdZEN+kCcEOM2hbOREX5l
        8ouXcZG9k0p3GzcfBB9A77iyAVYWZfKAMKNNqVEdbrqYjFG/wEJAByzUIgIvVyrscgx/Ly
        0LiFry4j9bTZ6mq47zGRcP/i9ljl2Yt0g6C3C7E+P2SM6GGvcY7GSPMPH2LHD55zWrcsPf
        rIoltBQBS0XUafLOTtEwWTPGbWyFMOSlHrbUX6rmIbypFMLQf3D+bOQAXzH5Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642504670;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fLzf2s+4QQWlsj3NdXrHo9g2Z2ZTEwjHLMXEx+8HKj4=;
        b=auSM/Jp/jmvdPAgURUywZkAsNlgmxH8x+Bfq+Tw8pVzqXrVDmylxItfscLIKaahyG7Y5Eh
        imQj1vcuU3VoLfDQ==
From:   "tip-bot2 for Andi Kleen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] x86/perf: Avoid warning for Arch LBR without XSAVE
Cc:     Andi Kleen <ak@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211215204029.150686-1-ak@linux.intel.com>
References: <20211215204029.150686-1-ak@linux.intel.com>
MIME-Version: 1.0
Message-ID: <164250466897.16921.8103023739640458495.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     8c16dc047b5dd8f7b3bf4584fa75733ea0dde7dc
Gitweb:        https://git.kernel.org/tip/8c16dc047b5dd8f7b3bf4584fa75733ea0dde7dc
Author:        Andi Kleen <ak@linux.intel.com>
AuthorDate:    Wed, 15 Dec 2021 12:40:29 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Jan 2022 12:09:49 +01:00

x86/perf: Avoid warning for Arch LBR without XSAVE

Some hypervisors support Arch LBR, but without the LBR XSAVE support.
The current Arch LBR init code prints a warning when the xsave size (0) is
unexpected. Avoid printing the warning for the "no LBR XSAVE" case.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211215204029.150686-1-ak@linux.intel.com
---
 arch/x86/events/intel/lbr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index f8fd255..669c2be 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1751,6 +1751,9 @@ static bool is_arch_lbr_xsave_available(void)
 	 * Check the LBR state with the corresponding software structure.
 	 * Disable LBR XSAVES support if the size doesn't match.
 	 */
+	if (xfeature_size(XFEATURE_LBR) == 0)
+		return false;
+
 	if (WARN_ON(xfeature_size(XFEATURE_LBR) != get_lbr_state_size()))
 		return false;
 
