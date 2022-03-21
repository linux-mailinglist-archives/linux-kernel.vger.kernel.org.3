Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1994E2D92
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350937AbiCUQOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350830AbiCUQN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:13:58 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C086D3A5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=eyCy4gH1ISkq/h
        cizrtlSR4kldwLUiAicgF4MO82BoU=; b=rW4apfZGDhE6f+hlw5EfVprqgPU18i
        LPcGhpqLvPOf8ZGAjstnWCEWFAg1C6aNO7VGZpK9f8tK2ftETx5w532eI9Whf6Jv
        3Yuct9CppxBIfeWNpkjFAxSoE81G+x8SHgGbMxPqexflqiRxmVUARB/wTv7aWVtj
        yoe3sQqpqZuDo=
Received: (qmail 957765 invoked from network); 21 Mar 2022 17:12:30 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Mar 2022 17:12:30 +0100
X-UD-Smtp-Session: l3s3148p1@0EVnw7zaINkgAwDPXxCoAIeNYiWy88zT
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 05/15] memory: tegra: use new name 'usleep_autoyield' instead of 'fsleep'
Date:   Mon, 21 Mar 2022 17:12:13 +0100
Message-Id: <20220321161223.2837-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321161223.2837-1-wsa+renesas@sang-engineering.com>
References: <20220321161223.2837-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function was just renamed to be easier understandable. No functional
change.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
RFC, please do not apply yet

 drivers/memory/tegra/tegra20.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra20.c b/drivers/memory/tegra/tegra20.c
index fcd7738fcb53..29ec45e79edf 100644
--- a/drivers/memory/tegra/tegra20.c
+++ b/drivers/memory/tegra/tegra20.c
@@ -463,7 +463,7 @@ static void tegra20_mc_stat_gather(struct tegra20_mc_stat *stat)
 	mc_writel(mc, 0xffffffff, MC_STAT_EMC_CLOCK_LIMIT);
 
 	mc_writel(mc, EMC_GATHER_ENABLE, MC_STAT_CONTROL);
-	fsleep(stat->sample_time_usec);
+	usleep_autoyield(stat->sample_time_usec);
 	mc_writel(mc, EMC_GATHER_DISABLE, MC_STAT_CONTROL);
 
 	count0 = mc_readl(mc, MC_STAT_EMC_COUNT_0);
-- 
2.34.1

