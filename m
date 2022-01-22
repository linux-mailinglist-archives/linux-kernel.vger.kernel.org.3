Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AC6496DC9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbiAVT6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:58:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33316 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbiAVT6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:58:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7526660EB3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01018C004E1;
        Sat, 22 Jan 2022 19:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881483;
        bh=PheG8NEXgK/aSJKn5yNZH+0qdOnqN8oKUc3WNUtTv2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UANpiaeOUghNn20pK6QIrsPayHMdoDlO9DKjEkfdPDgQUzRafWjRnJZZfRPQ2mMd6
         kYGnKnx7GJ89Uhr8XS8s/0lt3HtU3VdxniRUHrN2BlnPkdeW1vs6iv9FWrXMXqlJPG
         m9mg5vvBgPUQpGMoF5ABwXxWXGrNRs0jLzh4fNJi6igI6fgKA6R+WfTtc0KxvLJ9oO
         mcnebgImIHcEhpoY7NEkNn/6JqBWJ0ipYvVW1D6eiwc9+vvjJGraXJueN4hkgPSgsL
         ChaCYnQuDvEFJ2biuxgDVe1yFLIak/up2w4Y35lQbgg7+EIlKFN14tqoHAN6vJK1PV
         Th34cK73P//Pg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 21/30] habanalabs: add missing error check in sysfs clk_freq_mhz_show
Date:   Sat, 22 Jan 2022 21:57:22 +0200
Message-Id: <20220122195731.934494-21-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Add a missing error check in the sysfs show functions for
clk_max_freq_mhz and clk_cur_freq_mhz_show.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index 3f220dd3b6b2..c665a3ac8876 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -18,6 +18,8 @@ static ssize_t clk_max_freq_mhz_show(struct device *dev, struct device_attribute
 		return -ENODEV;
 
 	value = hl_fw_get_frequency(hdev, hdev->asic_prop.clk_pll_index, false);
+	if (value < 0)
+		return value;
 
 	hdev->asic_prop.max_freq_value = value;
 
@@ -59,6 +61,8 @@ static ssize_t clk_cur_freq_mhz_show(struct device *dev, struct device_attribute
 		return -ENODEV;
 
 	value = hl_fw_get_frequency(hdev, hdev->asic_prop.clk_pll_index, true);
+	if (value < 0)
+		return value;
 
 	return sprintf(buf, "%lu\n", (value / 1000 / 1000));
 }
-- 
2.25.1

