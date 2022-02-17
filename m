Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF054BAC41
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 23:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343787AbiBQWGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 17:06:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343778AbiBQWGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 17:06:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4B6403FC;
        Thu, 17 Feb 2022 14:05:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 473C8B82525;
        Thu, 17 Feb 2022 22:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE725C340ED;
        Thu, 17 Feb 2022 22:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645135555;
        bh=xC3sMas1elxgw4kLQbsaL4sAm9oZF/1lhrWsO+BjMh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dnuDsIo7jyXpfa2RxcQQJmHgLpP+VVvafAXhrBI6jqsLT7JcZc0FQOXhHUSH0IeY3
         qLiSThNYW5Rt6TrAaTt5h0SwgHCdgBJZMNVu/1P0jfV7bFDizpqvLYrucxOV14X0mt
         hykTBw4AJ6ctVoZ4x195ufVj/hPoQ4SNoKWNYC0grWyjh73iZg3+2bmOZzCXVdx7wy
         jrdCi3kFgphSMKniH7PT/5eJj9J9E0dTVqLI+vn1LpIYyuSP67jlb+QGubGGcvMyND
         gIYIXggiZVmD+khZLPVchhAexej+BwRDDo/MIlgOjwXgrDL8LdnsQZA0iQwN4Pvn0R
         nEjkJWSy6fYEA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 2/2] clk: Mark clk_core_evict_parent_cache_subtree() 'target' const
Date:   Thu, 17 Feb 2022 14:05:54 -0800
Message-Id: <20220217220554.2711696-3-sboyd@kernel.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
In-Reply-To: <20220217220554.2711696-1-sboyd@kernel.org>
References: <20220217220554.2711696-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clarify that the 'target' clk isn't being modified, instead it's being
searched for. Mark it const so the function can't modify it.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 16384e9437f5..d15997ea3930 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4079,7 +4079,7 @@ static const struct clk_ops clk_nodrv_ops = {
 };
 
 static void clk_core_evict_parent_cache_subtree(struct clk_core *root,
-						struct clk_core *target)
+						const struct clk_core *target)
 {
 	int i;
 	struct clk_core *child;
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

