Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DFA469D15
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356962AbhLFP2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357218AbhLFPRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:17:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FA0C08E6E2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:11:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AB14B810AC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 15:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38DDC341C9;
        Mon,  6 Dec 2021 15:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638803472;
        bh=X4sDq1AysZLgZ/CXaf2/6j6xZAfoF8ID51G9Lzvmb9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ehl/4Ziqd/eXWLxbnMmRqC7wPoiimhuy5+C1OlIZYMrvbQEUQ9k3uPtTyR1WfEvXj
         59UcE96mzT0QQJFHqgXKLfnUcjCUUzrytNmULKwayMyL+gjUB/IPD5/26O+zu3iUl4
         ueDPkGzfs7v7NxcABOsM0atdwNdH9RrY65sHfIFy/eWcuLenwYGWiIKOmvG7CHut5Q
         lYGq7vdyPSM7ByTpCHgoa7mlt7Yf2VRAF613/48JRgTA6qWFGyXXVUGFEiH1SsDCzf
         d76TmMHRrjRcfyP12p8WOTf3JvM8g3WuvesC3kLwfmSvIw9gJx4R59M4UoNuGIQ6UE
         Olx3rUcwrl63w==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] riscv: mm: init: remove _pt_ops and use pt_ops directly
Date:   Mon,  6 Dec 2021 23:03:51 +0800
Message-Id: <20211206150353.731-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206150353.731-1-jszhang@kernel.org>
References: <20211206150353.731-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Except "pt_ops", other global vars when CONFIG_XIP_KERNEL=y is defined
as below:

|foo_type foo;
|#ifdef CONFIG_XIP_KERNEL
|#define foo	(*(foo_type *)XIP_FIXUP(&foo))
|#endif

Follow the same way for pt_ops to unify the style and to simplify code.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/mm/init.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 4edf5600bea9..9c5816971f40 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -227,12 +227,10 @@ static void __init setup_bootmem(void)
 }
 
 #ifdef CONFIG_MMU
-static struct pt_alloc_ops _pt_ops __initdata;
+static struct pt_alloc_ops pt_ops __initdata;
 
 #ifdef CONFIG_XIP_KERNEL
-#define pt_ops (*(struct pt_alloc_ops *)XIP_FIXUP(&_pt_ops))
-#else
-#define pt_ops _pt_ops
+#define pt_ops (*(struct pt_alloc_ops *)XIP_FIXUP(&pt_ops))
 #endif
 
 unsigned long riscv_pfn_base __ro_after_init;
-- 
2.34.1

