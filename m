Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A0D469CE1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358554AbhLFP1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349081AbhLFPRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:17:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1C9C08C5FE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:11:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB2CEB810F1
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 15:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9BAC341C2;
        Mon,  6 Dec 2021 15:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638803467;
        bh=U/XXFOPv34D0TreArL806EvYm/WhdZkqjsAHo+8vbsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sBppVPtQwwPnjYq9/6k76KsKhYGK5RsaltsWG1YuSDnb7xcbYZbfQ5XzxyNhKDHqa
         fmCyFVFCpPtaV10H4fZ8c/FpDQWseyd2lMLsvQyBICW9MQ2757wa9EeZkujWDrJmCg
         EcqlKVctM3diiIjRJ6thMJf7bT3QPXsNGwhD299Xhn0/xqn0J8cYJxbFabx8SrsYad
         PSn+9AHoGImkjMbVZOT345oy2WPGJneTdrSGxTSYkz0IlX40nVoa0uzeK9yOP/ODa+
         swlP6vu6ma/Vm27tTxf2wdDpn8EecfM3YxTQkvG4a1hDS0s5BM49OLxQ//O03VzCuf
         q4KGrMxjH6eRA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] riscv: mm: init: remove unnecessary "#ifdef CONFIG_CRASH_DUMP"
Date:   Mon,  6 Dec 2021 23:03:49 +0800
Message-Id: <20211206150353.731-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206150353.731-1-jszhang@kernel.org>
References: <20211206150353.731-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The is_kdump_kernel() returns false for !CRASH_DUMP case, so we don't
need the #ifdef CONFIG_CRASH_DUMP for is_kdump_kernel() checking.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/mm/init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 3c0649dba4ff..745f26a3b02e 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -790,12 +790,10 @@ static void __init reserve_crashkernel(void)
 	 * since it doesn't make much sense and we have limited memory
 	 * resources.
 	 */
-#ifdef CONFIG_CRASH_DUMP
 	if (is_kdump_kernel()) {
 		pr_info("crashkernel: ignoring reservation request\n");
 		return;
 	}
-#endif
 
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&crash_size, &crash_base);
-- 
2.34.1

