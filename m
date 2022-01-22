Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860C2496DCA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbiAVT6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:58:42 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:40648 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbiAVT6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:58:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1E888CE0A5F
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF4AC340E7;
        Sat, 22 Jan 2022 19:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881482;
        bh=3ObafY3sIJoHvBAR59IO6fLa1o5XPaMnAyvjVUOWSuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XMldG4ltOhLL9ETQOiFX6D0rQdTq+F/ILgaUFUV8XnW2b0D9xVbiWIvkGkkier0Up
         yzMUSsOo14YlPGuRpUTmvwm1Hv8noJkBjogYbaovbrnkzBeqX0DSomHrXnGx7HM4H3
         Dbc60WiKPg3lhs3Jf4X7WNMvYePyRfHMT9DLQf/gE83I1yACjOYtSnEmn+onPaBk1c
         2MyLMzTIy6h/F9pO4BUd0cLff5hQ6eKcYQnuCwNT4UJDCKyXu3H5h4pFJNmdGbOb0K
         FQOs0Eyja5yRU7tDk4iSYGbm/UeOtEM2FlCP+mY6ZMKuhKvwvnv9Q+oinwWXRAMsb8
         C0QEOj8gQAUVg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 20/30] habanalabs: avoid copying pll data if pll_info_get fails
Date:   Sat, 22 Jan 2022 21:57:21 +0200
Message-Id: <20220122195731.934494-20-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

If reading PLL info from F/W fails, the PLL info is not set in the
"result" variable, and hence shouldn't be copied to the caller's array.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 93e9045461ae..7f76f98154f0 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -958,15 +958,17 @@ int hl_fw_cpucp_pll_info_get(struct hl_device *hdev, u32 pll_index,
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
 			HL_CPUCP_INFO_TIMEOUT_USEC, &result);
-	if (rc)
+	if (rc) {
 		dev_err(hdev->dev, "Failed to read PLL info, error %d\n", rc);
+		return rc;
+	}
 
 	pll_freq_arr[0] = FIELD_GET(CPUCP_PKT_RES_PLL_OUT0_MASK, result);
 	pll_freq_arr[1] = FIELD_GET(CPUCP_PKT_RES_PLL_OUT1_MASK, result);
 	pll_freq_arr[2] = FIELD_GET(CPUCP_PKT_RES_PLL_OUT2_MASK, result);
 	pll_freq_arr[3] = FIELD_GET(CPUCP_PKT_RES_PLL_OUT3_MASK, result);
 
-	return rc;
+	return 0;
 }
 
 int hl_fw_cpucp_power_get(struct hl_device *hdev, u64 *power)
-- 
2.25.1

