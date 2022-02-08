Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CD74AE23E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 20:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386052AbiBHT3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 14:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386036AbiBHT3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 14:29:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E4FC0613CB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 11:28:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5207C615BE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA574C004E1;
        Tue,  8 Feb 2022 19:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644348538;
        bh=apg2zAmxzFAOlQgDzTn4uZYbSkV0Nbg+lunnI4sRxio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R/h/iAaT33b+JYQQ+ztHQe4OqsGJl4iKDPfoUOmEw7XurR3kl+s7F6EEqOG+7l/N3
         sn4gXkaGWl16SH+4cAUQmH6/X2ei1Mja9UUR26Bf/upNwXX2xOZ9tLAlffclbHwSoa
         04inZUdmY79V2ABzHGy09OAQcN73eAoUBzXEkt2j+801h8zR3fdRGPDLLL7an9alGT
         +UsBMK7icoeV+Xpyc6YkkxdSCLTZOfaDBCKomxRk9oGYjD46QRXDKcryqFIZQaSfGP
         ue8GTpW3nYMj1WUrSr2hxSNXoe2hlygcsTEsb35n1R756qTpSZHAHuMEWGAxMnFW72
         vIKS/ScQF1KqA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 3/4] habanalabs: use proper max_power variable for device utilization
Date:   Tue,  8 Feb 2022 21:28:49 +0200
Message-Id: <20220208192850.3526511-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208192850.3526511-1-ogabbay@kernel.org>
References: <20220208192850.3526511-1-ogabbay@kernel.org>
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

The max_power variable which is used for calculating the device
utilization is the ASIC specific property which is set during init.
However, the max value can be modified via sysfs, and thus the updated
value in the device structure should be used instead.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 60bfd737404b..63e2449ad136 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -614,7 +614,7 @@ int hl_device_utilization(struct hl_device *hdev, u32 *utilization)
 	u64 max_power, curr_power, dc_power, dividend;
 	int rc;
 
-	max_power = hdev->asic_prop.max_power_default;
+	max_power = hdev->max_power;
 	dc_power = hdev->asic_prop.dc_power_default;
 	rc = hl_fw_cpucp_power_get(hdev, &curr_power);
 
-- 
2.25.1

