Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4284745F2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbhLNPF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:05:59 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40576 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhLNPF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:05:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 710CB6155E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 15:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AFDC34605;
        Tue, 14 Dec 2021 15:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639494356;
        bh=6WJwC8wuw9W5D9fG3GAt53kJLwtzBytYI2PupSVdcDc=;
        h=From:To:Cc:Subject:Date:From;
        b=HRJEUdR8M0ZYAfEONSFV4m/MjV9rp1YTJ/HFepHRahQg/HL8pXpRZ9lEY0mnCd2i8
         Lr57TI7+kpV7ZwU2a5zSXi2EYQVpnO7pQR7rnE6RMmqVAg2B6BVGuZDLhCjat8KsIX
         bc+zZvRwgNvdxGv+QhI/dug3UDch4hfP65LIVB49j0aBDj8+ZAuBFNNImx4EmUb8rh
         8xVAkvCyq4LLoekt0xm0n4uYgFhxXhECME2a0Y2n8zHUY4kVcHCS0+eNCiFP66kIxY
         v811ifXsosfcIGphE60KADYvYdiE7vKHN4phQ5CCHKIGKGSQbEA2UkHTU2WSnPrjk0
         Hrwler6nB1JdA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 01/11] habanalabs: return correct clock throttling period
Date:   Tue, 14 Dec 2021 17:05:41 +0200
Message-Id: <20211214150551.1568192-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Current clock throttling period returned from driver was wrong due
to wrong time comparison.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/habanalabs_ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 9210114beefe..f571641c19ae 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -335,9 +335,9 @@ static int clk_throttle_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 			ktime_to_us(hdev->clk_throttling.timestamp[i].start);
 
 		if (ktime_compare(hdev->clk_throttling.timestamp[i].end, zero_time))
-			end_time = ktime_get();
-		else
 			end_time = hdev->clk_throttling.timestamp[i].end;
+		else
+			end_time = ktime_get();
 
 		clk_throttle.clk_throttling_duration_ns[i] =
 			ktime_to_ns(ktime_sub(end_time,
-- 
2.25.1

