Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FC046CC45
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 05:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbhLHETM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 23:19:12 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58506 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhLHETK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:19:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B7873CE0DB2;
        Wed,  8 Dec 2021 04:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F84C341C8;
        Wed,  8 Dec 2021 04:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638936935;
        bh=H4hWUkxjwgVjZRb5VbGPA9WRx0ymtWEj1ZFEQc1KMi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jNBkBJFxqTzZ5i8QQFTndZOchAK8x+hwaDTUiMn8Bn71Nqec5z3JujFzTzxIXwdze
         dmZQElAhhVVVLYqjsDeXj3yVuXqevlmgxhtSKBxkn7sKDZrz2GEwRnXlCOysnKn3jw
         PJz1VKDUMD/a/sCVYWvfK40Q1IWkQnBJUSQkxAOLZBNglnw7Q7cNPZCaPAyhgK4/+Q
         2uM4RDo+ZiVdnVdkafBp/cMq1kpdtDQZsjymFp2IJPGry9aRmfeQjMFB3MXhxeusD3
         Lwe0QuHeX6ge1Lf9lb4YcLdOaTrRivDaIQZGWmQDMimnoAFSXz1HW/gEufLxgLx6WR
         HRsLRlX2paj5g==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 2/2] clk: __clk_core_init() never takes NULL
Date:   Tue,  7 Dec 2021 20:15:34 -0800
Message-Id: <20211208041534.3928718-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
In-Reply-To: <20211208041534.3928718-1-sboyd@kernel.org>
References: <20211208041534.3928718-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only caller of __clk_core_init() allocates the pointer and checks
the allocation for NULL so this check is impossible. Remove it.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index add86a4b8e8c..d9414a7d585b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3414,9 +3414,6 @@ static int __clk_core_init(struct clk_core *core)
 	unsigned long rate;
 	int phase;
 
-	if (!core)
-		return -EINVAL;
-
 	clk_prepare_lock();
 
 	ret = clk_pm_runtime_get(core);
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

