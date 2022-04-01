Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAC24EED09
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 14:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345832AbiDAMWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345813AbiDAMWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:22:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B25277950
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 05:20:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A39EB824BC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B99C2BBE4;
        Fri,  1 Apr 2022 12:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648815625;
        bh=WgcDm8lINjYoBfcpf/qZCYYpX6TB3e3SEjJlr3phKWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/fBPLL1xTJFIpmUJbBlKXiCNVEpHlFUFLOT2fC0tFDl6NaEAA5q1/TyEBjje+Hw5
         QawVDRehVgV6BSl7McX1/WqGW3acaNdg3iyD8oqByuajwI30GTSUhN48IqXhi/68in
         GrjXGsjCrgmVnMmogv6baRbWIRpSFHkK/LSC2WgdDw0c4W2Huxvy3Bq+gavBfBaBiG
         MuAu2yqqQM6H5IyfImmw1tIAmr7mWlJbU2x23WGEVWRPR3lz140zfi7gZf6Ez0jT41
         obITWV1shiE5J7TxyAjgHeZ7KPln5U6+q3JPRIw7DwwdPe8UaRuxUuh6cPmbtqNoOd
         o9PYBo7ix7UtQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dafna Hirschfeld <dhirschfeld@habana.ai>
Subject: [PATCH 3/7] habanalabs: enforce alignment upon registers access through debugfs
Date:   Fri,  1 Apr 2022 15:20:13 +0300
Message-Id: <20220401122017.116205-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401122017.116205-1-ogabbay@kernel.org>
References: <20220401122017.116205-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dafna Hirschfeld <dhirschfeld@habana.ai>

When accessing the configuration registers through debugfs,
it is only allowed to access aligned address.
Fail if address is not aligned.

Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index bd76a68d44be..9a71737fc804 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -94,6 +94,11 @@ int hl_access_cfg_region(struct hl_device *hdev, u64 addr, u64 *val,
 	struct pci_mem_region *cfg_region = &hdev->pci_mem_region[PCI_REGION_CFG];
 	u32 val_h, val_l;
 
+	if (!IS_ALIGNED(addr, sizeof(u32))) {
+		dev_err(hdev->dev, "address %#llx not a multiple of %zu\n", addr, sizeof(u32));
+		return -EINVAL;
+	}
+
 	switch (acc_type) {
 	case DEBUGFS_READ32:
 		*val = RREG32(addr - cfg_region->region_base);
-- 
2.25.1

