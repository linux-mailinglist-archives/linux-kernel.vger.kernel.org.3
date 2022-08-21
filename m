Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D851159B2C2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 10:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiHUI2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 04:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiHUI2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 04:28:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6C513D0F
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 01:28:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87AAFB80064
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 08:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C77BC433D6;
        Sun, 21 Aug 2022 08:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661070512;
        bh=FTEZEyVkvI/TWwdRDe4djoiDLycJmGuJmPjUE9ZpdfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRcmQsEV6lUM+8QpBMPsg1XWpzG+7ZUelDauwBvXcbOfexc5l/3udQdlgNuqmepfr
         ni7BHHoCqDoCq+WNa9XK2k25UAXBZUDSJrOnD6ASUrrBW1Od2RjUlcI6tKgb6cAoFE
         7zyY1mxlsEr7SYu7LeWV0kLhUX91RNGuDty8erTN4x7DTyrDeTack5inq6+xs3SnEh
         yEMLeiXcn7vPzT0YwCk7mhM4E0kI260tziUQJS5WcustyzgdhIrqyoj2tT9zHM64Zo
         yTlIwmXoL50+94KwV40BBMlEpRMARC1BCD0wQpA/f+sGTFsxASp2vhSlZdjyPeV5Ot
         4HE6YjKIU99VQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 4/5] habanalabs: fix calculation of DRAM base address in PCIe BAR
Date:   Sun, 21 Aug 2022 11:28:22 +0300
Message-Id: <20220821082823.62846-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220821082823.62846-1-ogabbay@kernel.org>
References: <20220821082823.62846-1-ogabbay@kernel.org>
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

From: Tomer Tayar <ttayar@habana.ai>

The calculation of the device DRAM base address before setting the
relevant PCIe BAR to point at it, has an assumption that this BAR is
used to access only the DRAM, and thus the covered DRAM size is a power
of 2.
In future ASICs it is not necessarily true, so need to update the
calculation to support also a non-power-of-2 size.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index b662d40f18e8..0b3097802b00 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -42,7 +42,11 @@ static uint64_t hl_set_dram_bar(struct hl_device *hdev, u64 addr)
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	u64 bar_base_addr;
 
-	bar_base_addr = addr & ~(prop->dram_pci_bar_size - 0x1ull);
+	if (is_power_of_2(prop->dram_pci_bar_size))
+		bar_base_addr = addr & ~(prop->dram_pci_bar_size - 0x1ull);
+	else
+		bar_base_addr = DIV_ROUND_DOWN_ULL(addr, prop->dram_pci_bar_size) *
+				prop->dram_pci_bar_size;
 
 	return hdev->asic_funcs->set_dram_bar_base(hdev, bar_base_addr);
 }
-- 
2.25.1

