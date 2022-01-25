Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDDA49B841
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 17:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1583023AbiAYQIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 11:08:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60906 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377671AbiAYQHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 11:07:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BEF06172F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 16:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923C9C340F3;
        Tue, 25 Jan 2022 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643126870;
        bh=IdjPE/FcDNJAM0qD96J2RdCr8IUfsVB52t3qpnigWlc=;
        h=From:To:Cc:Subject:Date:From;
        b=Y+MbnJETvxadz2gQQIEjRRgYBsqwnTlXFwfLpi0QqZol2TQxy+NOB7fgalVp+EORF
         3lLyCk25bKOj4NUnKjR8YVfGR/K4yUY1965Ztl0zulgudJqI7kls+pxeFM9W401L1W
         GSDDNyt3NV5PTzDpyuh82wPDOW1qHUv3FbtsKgv0j+z9xtjxyvsyA/Byz5F1IheZRK
         Y6mNSY7V9VE4/rH/l2cJpiQb7ibyPsH14bO+WoGs33BJKKTofRg6pTYLVo/M3WCErw
         qHBfyrJQoMiS0suvJv7F+dT/E8D3esrMBm400snFevzT3ZLNPNXH7u132eO0Nxvaz6
         Zw+y8GdihuBlg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: mm: init: mark satp_mode __ro_after_init
Date:   Wed, 26 Jan 2022 00:00:12 +0800
Message-Id: <20220125160012.3884-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

satp_mode is never modified after init, so it can be marked as
__ro_after_init.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/mm/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 8347d0fda8cd..35586688a1b6 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -38,9 +38,9 @@ EXPORT_SYMBOL(kernel_map);
 #endif
 
 #ifdef CONFIG_64BIT
-u64 satp_mode = !IS_ENABLED(CONFIG_XIP_KERNEL) ? SATP_MODE_48 : SATP_MODE_39;
+u64 satp_mode __ro_after_init = !IS_ENABLED(CONFIG_XIP_KERNEL) ? SATP_MODE_48 : SATP_MODE_39;
 #else
-u64 satp_mode = SATP_MODE_32;
+u64 satp_mode __ro_after_init = SATP_MODE_32;
 #endif
 EXPORT_SYMBOL(satp_mode);
 
-- 
2.34.1

