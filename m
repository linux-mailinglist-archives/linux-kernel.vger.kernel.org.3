Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0315905AF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236591AbiHKRTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbiHKRSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:18:36 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3A598CBE;
        Thu, 11 Aug 2022 10:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=6kuAZYwVluI2sAlDZx4xQvA8ERYgrpESzYZj4B/AR7A=; b=gsXYvXPnsl+tpkifXN8kTpyVeB
        kkvgEPG3bwjBXqdunzmRA8hl/sNMJnUgO4RWEGWVNmXqcgfEzjDuD2HpZGXf/QUoiOSHz5oDh/Lkp
        OOuC+jeyBvseqGM3UxWyKT4okFnoQ4uaorUaOvpOlFFLE4uhcMU8Ie+Zri22V/MY7K41PtIPppjJw
        d2PeRxySsXVGiAEcKU/J60ygarozwnhYJCGo2fuEkyuXcrKIGal2QHnTAc3sYPKdXCL4oc9xnSKSN
        xiBVIQaSCjF//4CuUSWppTzPAO/s9MUApOHn4yt5MKr21S9krIfM5a55zyoExGkqy8pKCLWjsyUsm
        OUsE9l+A==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oMBlJ-00EAyj-Rk; Thu, 11 Aug 2022 11:14:27 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oMBlI-000cRD-2t; Thu, 11 Aug 2022 11:14:24 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 11 Aug 2022 11:14:15 -0600
Message-Id: <20220811171417.147697-4-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220811171417.147697-1-logang@deltatee.com>
References: <20220811171417.147697-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 3/5] md/raid5: Drop extern on function declarations in raid5.h
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

externs should not be used in function declarations, so clean those
up.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/raid5.h | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index a5082bed83c8..4be2feb9e74a 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -803,16 +803,14 @@ raid5_get_dev_page(struct stripe_head *sh, int disk_idx)
 }
 #endif
 
-extern void md_raid5_kick_device(struct r5conf *conf);
-extern int raid5_set_cache_size(struct mddev *mddev, int size);
-extern sector_t raid5_compute_blocknr(struct stripe_head *sh, int i, int previous);
-extern void raid5_release_stripe(struct stripe_head *sh);
-extern sector_t raid5_compute_sector(struct r5conf *conf, sector_t r_sector,
-				     int previous, int *dd_idx,
-				     struct stripe_head *sh);
-extern struct stripe_head *
-raid5_get_active_stripe(struct r5conf *conf, sector_t sector,
-			bool previous, bool noblock, bool noquiesce);
-extern int raid5_calc_degraded(struct r5conf *conf);
-extern int r5c_journal_mode_set(struct mddev *mddev, int journal_mode);
+void md_raid5_kick_device(struct r5conf *conf);
+int raid5_set_cache_size(struct mddev *mddev, int size);
+sector_t raid5_compute_blocknr(struct stripe_head *sh, int i, int previous);
+void raid5_release_stripe(struct stripe_head *sh);
+sector_t raid5_compute_sector(struct r5conf *conf, sector_t r_sector,
+		int previous, int *dd_idx, struct stripe_head *sh);
+struct stripe_head *raid5_get_active_stripe(struct r5conf *conf,
+		sector_t sector, bool previous, bool noblock, bool noquiesce);
+int raid5_calc_degraded(struct r5conf *conf);
+int r5c_journal_mode_set(struct mddev *mddev, int journal_mode);
 #endif
-- 
2.30.2

