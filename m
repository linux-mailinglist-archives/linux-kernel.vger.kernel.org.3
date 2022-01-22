Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88718496DC6
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiAVT6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:58:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33248 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbiAVT6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:58:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4109260E04
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1197C340E4;
        Sat, 22 Jan 2022 19:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881479;
        bh=UyhmqyYYymp4D+POO9zvg+tN/Lot2LylB9i/7P3+08k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+IIKE2al4zl9JX7qwSEeJGTefY3Hk8vg2V8z2jc+B05doo8K5neTJKRw0rQTUZbc
         J8xvcO2cbKDTW3Ko6htI5XBaySNBkbj1CGIl/WMl4XAj/fpBYdoEUe89B7SghYBX5m
         CTSI7wUqilftdaujclO+7tHp6PoHWsvJuv/uJWSE9kGPJY6A509phYLg83vXUpqiSP
         hp1TIaCq+j1ketIWNsixuYyVqJQEQnAop5BJYI7EhfLQ25zvndQhy5O0KGwgOY+zq5
         tphnVU6hedmI55H0cyOkjvWHi/E3bRuBA6vBEfiX5ujJUVWKLSe/3XN7JoxkSfabP8
         3/YDkzsHgD2tQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 18/30] habanalabs: duplicate HOP table props to MMU props
Date:   Sat, 22 Jan 2022 21:57:19 +0200
Message-Id: <20220122195731.934494-18-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

In order to support several device MMU blocks with different
architectures (e.g. different HOP table size) we need to move to
per-MMU properties rather than keeping those properties as ASIC
properties.

Refactoring the code to use "per-MMU proprties" is a major effort.

To start making the transition towards this goal but still support
taking the properties from ASIC properties (for code that currently
uses them) this patch copies some of the properties to the "per-MMU"
properties and later, when implementing the per-MMU properties, we
would be able to delete the MMU props from the ASIC props.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 3 +++
 drivers/misc/habanalabs/goya/goya.c   | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index c58e21e2db3b..f2242aa3baa2 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -613,6 +613,9 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
 	prop->pmmu.page_size = PAGE_SIZE_4KB;
 	prop->pmmu.num_hops = MMU_ARCH_5_HOPS;
 	prop->pmmu.last_mask = LAST_MASK;
+	/* TODO: will be duplicated until implementing per-MMU props */
+	prop->pmmu.hop_table_size = prop->mmu_hop_table_size;
+	prop->pmmu.hop0_tables_total_size = prop->mmu_hop0_tables_total_size;
 
 	/* PMMU and HPMMU are the same except of page size */
 	memcpy(&prop->pmmu_huge, &prop->pmmu, sizeof(prop->pmmu));
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index d8c6dea7c809..3785fb33260d 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -430,6 +430,9 @@ int goya_set_fixed_properties(struct hl_device *hdev)
 	prop->dmmu.page_size = PAGE_SIZE_2MB;
 	prop->dmmu.num_hops = MMU_ARCH_5_HOPS;
 	prop->dmmu.last_mask = LAST_MASK;
+	/* TODO: will be duplicated until implementing per-MMU props */
+	prop->dmmu.hop_table_size = prop->mmu_hop_table_size;
+	prop->dmmu.hop0_tables_total_size = prop->mmu_hop0_tables_total_size;
 
 	/* shifts and masks are the same in PMMU and DMMU */
 	memcpy(&prop->pmmu, &prop->dmmu, sizeof(prop->dmmu));
@@ -438,6 +441,9 @@ int goya_set_fixed_properties(struct hl_device *hdev)
 	prop->pmmu.page_size = PAGE_SIZE_4KB;
 	prop->pmmu.num_hops = MMU_ARCH_5_HOPS;
 	prop->pmmu.last_mask = LAST_MASK;
+	/* TODO: will be duplicated until implementing per-MMU props */
+	prop->pmmu.hop_table_size = prop->mmu_hop_table_size;
+	prop->pmmu.hop0_tables_total_size = prop->mmu_hop0_tables_total_size;
 
 	/* PMMU and HPMMU are the same except of page size */
 	memcpy(&prop->pmmu_huge, &prop->pmmu, sizeof(prop->pmmu));
-- 
2.25.1

