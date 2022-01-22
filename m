Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A854496DCB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbiAVT6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbiAVT6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:58:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63810C061749
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 11:58:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F27CC60E04
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774DDC340E2;
        Sat, 22 Jan 2022 19:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881485;
        bh=lGEIBdwJSfqAcTa3FHn1G+D7bTF3b/d85Cq5TUjG774=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sQR0HeZrqFkVbICV3wufYIhuqXDY5qH6TwT+V5MULrBRqDaXiQqVc3aOX8mWRbstH
         6cDnUvcXPrGFgrP8nZfnDdwLcj4EkFX36J4jNpYjp+R4EcUVwOGkyKM9KV/rW08rqK
         9NLIYjkksHw+j/eOV+E6eH/J/2ciH7rTd18mzgn177T/D9lUTziWUlqSWsHO1PzZ0l
         zgPc3OI6/coV0dzvK55FTyiQCsSQD9ZrMBcdJUGR19M+aZa5Drv7dOgsLQLjUlZPnu
         GwVobB6raRFrDfrr6RW0nrqagYqO06bpMle6iVE1yI9+EWTWzszgosso5ulrFXxVv5
         MAZEcHVt06nWA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 22/30] habanalabs: fix soft reset flow in case of failure
Date:   Sat, 22 Jan 2022 21:57:23 +0200
Message-Id: <20220122195731.934494-22-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dani Liberman <dliberman@habana.ai>

In case of soft reset failure, hard reset should be initiated, but
reset flags were not set to enable it, which caused another soft reset
followed by another failure.
Updated reset flags to enable hard reset flow in case of soft reset
failure.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index c98a0a81e7d5..727315b36b8b 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1293,11 +1293,14 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 		hdev->reset_info.hard_reset_cnt++;
 	} else if (reset_upon_device_release) {
 		dev_err(hdev->dev, "Failed to reset device after user release\n");
+		flags |= HL_DRV_RESET_HARD;
+		flags &= ~HL_DRV_RESET_DEV_RELEASE;
 		hard_reset = true;
 		goto again;
 	} else {
 		dev_err(hdev->dev, "Failed to do soft-reset\n");
 		hdev->reset_info.soft_reset_cnt++;
+		flags |= HL_DRV_RESET_HARD;
 		hard_reset = true;
 		goto again;
 	}
-- 
2.25.1

