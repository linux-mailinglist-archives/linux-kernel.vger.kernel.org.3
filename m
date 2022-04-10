Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8814FB034
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 22:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243425AbiDJUon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 16:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235427AbiDJUom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 16:44:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D43109A;
        Sun, 10 Apr 2022 13:42:30 -0700 (PDT)
Date:   Sun, 10 Apr 2022 20:42:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649623348;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2zWUV+nMMwSggeVHi8blL9PevsrRBPc46LpSIX0ts0=;
        b=PM7dI6nIWKaeiY/JSy+FE+dkvCPvMJC/ymmXVKNiuWENsiYqdEVakAkLWKW6jGDx8k90ez
        V1fC04ZBi//d+rYjn6dspQkLYhS6N4RbG+xPyeJgEfJvik9qb+cRcDclamYhRbblaqfOLK
        HzVuSTvZPUcVThAwpNlX5LFmEBAeaQwa6mBCAIiFrKEyyUFUCaHpwZchmozjXCyJ4uNgNk
        Vxk6m++4HLWIBs/ZaFzvkf/kvZ6nZq1+wunj4LBkJ2QVK9HTLJQy+XZC0QquBK9Gp0Fjgw
        DbDy6aznWrMoGfv5nnAAlP7v5HfmzSTdnMnYBWg5pVYgD1z1FVqyFiOFMqsmjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649623348;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2zWUV+nMMwSggeVHi8blL9PevsrRBPc46LpSIX0ts0=;
        b=3fJfGIPy0dgtpv/OYyusdCOvZCvt+FYWZHIfe9Jsx2IE9nrf9V4f2ms4zzGFM0A8hSDqMQ
        5XERuFby0/4eJYCA==
From:   "tip-bot2 for Yury Norov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mm: Replace nodes_weight() with nodes_empty()
 where appropriate
Cc:     Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220210224933.379149-26-yury.norov@gmail.com>
References: <20220210224933.379149-26-yury.norov@gmail.com>
MIME-Version: 1.0
Message-ID: <164962334763.4207.6178679393836557321.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     c2a911d302b0d014a4d0d732a2bfc319e643eb62
Gitweb:        https://git.kernel.org/tip/c2a911d302b0d014a4d0d732a2bfc319e643eb62
Author:        Yury Norov <yury.norov@gmail.com>
AuthorDate:    Thu, 10 Feb 2022 14:49:09 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 10 Apr 2022 22:35:38 +02:00

x86/mm: Replace nodes_weight() with nodes_empty() where appropriate

Various mm code calls nodes_weight() to check if any bit of a given
nodemask is set.

This can be done more efficiently with nodes_empty() because nodes_empty()
stops traversing the nodemask as soon as it finds first set bit, while
nodes_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220210224933.379149-26-yury.norov@gmail.com

---
 arch/x86/mm/amdtopology.c    | 2 +-
 arch/x86/mm/numa_emulation.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/amdtopology.c b/arch/x86/mm/amdtopology.c
index 058b2f3..b3ca7d2 100644
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
index 1a02b79..9a93053 100644
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
