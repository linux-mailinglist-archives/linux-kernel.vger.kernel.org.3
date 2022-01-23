Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F8E497496
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239767AbiAWSlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239923AbiAWSlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:41:11 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED325C06176A
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:41:10 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id n8so13503017plc.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Va/u2iX1YVOINaxIuJLKJ3LTGOLOqvsNjPRhFp+Rqeo=;
        b=eagkQ6Q6MYIyUa2gGTCr0XP5Aj+BdjWz9lZgHECpuGLi3hniUg1vL04exTfY56Hd1E
         UQYcD0Az1f9gMpbExHH7+zle8nBUUcfkZnNB1N4d7yIalhSNXjF7FSmEJjs4Bo0exVu/
         YCP495oGvt7PpQvBlyvD+w0qqqR7r/LG0ES5OU2Ogjc+uci4x3heIZYQMjeVZ4FrQ5FV
         1W2RBQfKY1WNoTa6PY8XqJk7Lc3XawRe+hoQeiDVpxs8buZgdFT9jX1YsYXTbCfAQ6br
         vBCq01+NLc+plLrUmN/sZDmpb91ldk9OK1uKeec/eXNC3RqATlokAapxKDgOge4P9Aat
         X3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Va/u2iX1YVOINaxIuJLKJ3LTGOLOqvsNjPRhFp+Rqeo=;
        b=PdRLn2Bn+P4bZCI4VgP2+EBlRH+xTr+tSh1W8QIRXmfZ4OYZv/GmoCT2yi9uQg6q9l
         Dj9ZTI8FpFGXEqZVNqodheTgJnVWK77L9flxFCTToOTVDfzhqOcKFBoWTXdz2QY1erUm
         OSs1LETZq9iIt9xBcBMPRK5jKHBweceMWs3sLWYllYbnmY7lPeOg7T6/VNXJPGd0jM11
         nR1K+npjbgilKxZenigqeL4BQTEZncS77YQCZ3rYKO+C1SB+9w81y0ejxeJkM+XncKBL
         MgMfZVWSJIM3urHbovqBAcMIgsoS43sHZixVyzG5Pv3+s6HatFoRQSubFkFjQ/Y+uICe
         Q1dQ==
X-Gm-Message-State: AOAM531VtPKLmNtwNfk77u4iaSpJYjz2uE2xLQQxwEhNLgB6ABcxKZCa
        txLYfNjGF26Z5xiSe48Wm04=
X-Google-Smtp-Source: ABdhPJxvxbe+z7NuSUkqm9rEuKdHdlkqT/vD80MI3bNETHPdwJquHkS8H8ObhnEdYy/07LJ3AxKonQ==
X-Received: by 2002:a17:90a:4601:: with SMTP id w1mr10006540pjg.113.1642963270445;
        Sun, 23 Jan 2022 10:41:10 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id l17sm216332pfu.61.2022.01.23.10.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:41:10 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH 26/54] arch/x86: replace nodes_weight with nodes_empty where appropriate
Date:   Sun, 23 Jan 2022 10:38:57 -0800
Message-Id: <20220123183925.1052919-27-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm code calls nodes_weight() to check if any bit of a given nodemask is
set. We can do it more efficiently with nodes_empty() because nodes_empty()
stops traversing the nodemask as soon as it finds first set bit, while
nodes_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 arch/x86/mm/amdtopology.c    | 2 +-
 arch/x86/mm/numa_emulation.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/amdtopology.c b/arch/x86/mm/amdtopology.c
index 058b2f36b3a6..b3ca7d23e4b0 100644
--- a/arch/x86/mm/amdtopology.c
+++ b/arch/x86/mm/amdtopology.c
@@ -154,7 +154,7 @@ int __init amd_numa_init(void)
 		node_set(nodeid, numa_nodes_parsed);
 	}
 
-	if (!nodes_weight(numa_nodes_parsed))
+	if (nodes_empty(numa_nodes_parsed))
 		return -ENOENT;
 
 	/*
diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index 1a02b791d273..9a9305367fdd 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -123,7 +123,7 @@ static int __init split_nodes_interleave(struct numa_meminfo *ei,
 	 * Continue to fill physical nodes with fake nodes until there is no
 	 * memory left on any of them.
 	 */
-	while (nodes_weight(physnode_mask)) {
+	while (!nodes_empty(physnode_mask)) {
 		for_each_node_mask(i, physnode_mask) {
 			u64 dma32_end = PFN_PHYS(MAX_DMA32_PFN);
 			u64 start, limit, end;
@@ -270,7 +270,7 @@ static int __init split_nodes_size_interleave_uniform(struct numa_meminfo *ei,
 	 * Fill physical nodes with fake nodes of size until there is no memory
 	 * left on any of them.
 	 */
-	while (nodes_weight(physnode_mask)) {
+	while (!nodes_empty(physnode_mask)) {
 		for_each_node_mask(i, physnode_mask) {
 			u64 dma32_end = PFN_PHYS(MAX_DMA32_PFN);
 			u64 start, limit, end;
-- 
2.30.2

