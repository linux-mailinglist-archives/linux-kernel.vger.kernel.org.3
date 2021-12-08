Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB42946CC44
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 05:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhLHETL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 23:19:11 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58504 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLHETK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:19:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 77958CE1FA2;
        Wed,  8 Dec 2021 04:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54452C00446;
        Wed,  8 Dec 2021 04:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638936935;
        bh=SdvmY357Xa+44K5RGgydVE1FWlqYpzR+EtZm8fMQmyE=;
        h=From:To:Cc:Subject:Date:From;
        b=bRHjDp7cze+eHW+Amc5UZ/AAadony6NQ2cRTIYfezxiJvqBsvAe0QBB7BazTPpZLH
         ZgGAslxt49+2drTF4SvYC+HHBYzWWkSsR1J3HzxlVyCyYvmEcFW+OJA3mATiDnIrlj
         ku+ZhRnBmn84n7pxzDslWh0zMUTyf6igP3fdcLjrtvc0+GD9EgmiJANa+ZxuEJaQXo
         Chmce4OW6T1b3aIUm2fG5qH2uyZQBtK7cdx2dsc7Ab6v4cq0czFNHUAQIiht0CsKZt
         +jTTbPj577/0Tzgq3Rm7rL5h6CRiPTgh7uK72NwopUWWDELAXrTNYoHe6yZ+Fo1pFf
         dpAtshcyJPdQw==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 1/2] clk: clk_core_get() can also return NULL
Date:   Tue,  7 Dec 2021 20:15:33 -0800
Message-Id: <20211208041534.3928718-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing stops a clk controller from registering an OF clk provider
before registering those clks with the clk framework. This is not great
but we deal with it in the clk framework by refusing to hand out struct
clk pointers when 'hw->core' is NULL, the indication that clk_register()
has been called.

Within clk_core_fill_parent_index() we considered this case when a
clk_hw pointer is referenced directly by filling in the parent cache
with an -EPROBE_DEFER pointer when the core pointer is NULL. When we
lookup a parent with clk_core_get() we don't care about the return value
being NULL though, because that was considered largely impossible, but
it's been proven now that it can be NULL if two clk providers are
probing in parallel and the parent provider has been registered before
the clk has. Let's check for NULL here as well and treat it the same as
direct clk_hw references.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index f467d63bbf1e..add86a4b8e8c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -424,19 +424,20 @@ static void clk_core_fill_parent_index(struct clk_core *core, u8 index)
 
 	if (entry->hw) {
 		parent = entry->hw->core;
-		/*
-		 * We have a direct reference but it isn't registered yet?
-		 * Orphan it and let clk_reparent() update the orphan status
-		 * when the parent is registered.
-		 */
-		if (!parent)
-			parent = ERR_PTR(-EPROBE_DEFER);
 	} else {
 		parent = clk_core_get(core, index);
 		if (PTR_ERR(parent) == -ENOENT && entry->name)
 			parent = clk_core_lookup(entry->name);
 	}
 
+	/*
+	 * We have a direct reference but it isn't registered yet?
+	 * Orphan it and let clk_reparent() update the orphan status
+	 * when the parent is registered.
+	 */
+	if (!parent)
+		parent = ERR_PTR(-EPROBE_DEFER);
+
 	/* Only cache it if it's not an error */
 	if (!IS_ERR(parent))
 		entry->core = parent;

base-commit: fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

