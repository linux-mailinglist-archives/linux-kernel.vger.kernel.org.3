Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9254BAC40
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 23:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343780AbiBQWGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 17:06:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbiBQWGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 17:06:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F96341FAF;
        Thu, 17 Feb 2022 14:05:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37F39616CD;
        Thu, 17 Feb 2022 22:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772E7C340EC;
        Thu, 17 Feb 2022 22:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645135555;
        bh=xGGr8nolCA3MC3UDtSnlfXLw6r3mD7Bx3LfbJtOR3Xg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P1ytIcrwYt9p9kb2zidKPPnISP+rFHH7gJejQT2xvLRObgv6ejtM6XGaR8FEynZyN
         tkiNXFjTBbHfySKeTzcA8+9v+Pb8QamZs/IB3okFLpvO3Hso3Z+A4TPIXQ+kGpj0U6
         pdyL9i9Eipy1yrvSwNRIXLYUD3uKWwhqzpDwb9CqH5A1/2GYEYjWLxdATQ5G/vGPeW
         +Y3eRj5cSAuCuYbwtCD4n68Qh6FC+/QL8e4FNYngVGEX4NFyTLmOrvvsxkowyOkwiG
         jflT76vHISlo4uEJ2iBL0d6ysTbHVWw3redLrfGZx/H4UG63vR5SPeifCVhZbhCMk5
         Wt9hdDZ3J55QA==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH 1/2] clk: Mark 'all_lists' as const
Date:   Thu, 17 Feb 2022 14:05:53 -0800
Message-Id: <20220217220554.2711696-2-sboyd@kernel.org>
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

This list array doesn't change at runtime. Mark it const to move to RO
memory.

Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 8de6a22498e7..16384e9437f5 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -37,7 +37,7 @@ static HLIST_HEAD(clk_root_list);
 static HLIST_HEAD(clk_orphan_list);
 static LIST_HEAD(clk_notifier_list);
 
-static struct hlist_head *all_lists[] = {
+static const struct hlist_head *all_lists[] = {
 	&clk_root_list,
 	&clk_orphan_list,
 	NULL,
@@ -4095,7 +4095,7 @@ static void clk_core_evict_parent_cache_subtree(struct clk_core *root,
 /* Remove this clk from all parent caches */
 static void clk_core_evict_parent_cache(struct clk_core *core)
 {
-	struct hlist_head **lists;
+	const struct hlist_head **lists;
 	struct clk_core *root;
 
 	lockdep_assert_held(&prepare_lock);
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

