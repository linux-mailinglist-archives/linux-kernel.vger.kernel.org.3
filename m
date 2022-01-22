Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29513496DC7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbiAVT63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:58:29 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:40614 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbiAVT6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:58:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DBD0ECE0AAD
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A54C340E2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881478;
        bh=AfQkEq0w9hPyuDL60/63aDuYY0VV1sp/tkFBcOQipYw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hjH11kLExLKnR0BrUtDNGE/w7NH6ZVOwvOVVE9eYAOwASzUpQoSH63xKykgI5+D/b
         I70rHMZkMI/cDGuL1jV4v0yDKYNLQj6Ya+msO7cNfAiM2onXmhMkZHhzauBJLFS44L
         SXJksWlLr4Km+ergOUrIMdavbvwJ0lWQA82ckkUJuXsbbTQ0mzr27EYJDBlxkjGTTB
         7hLh5TIAsLhCPdBUqQoNvH7ubPSlEMiIXokAKJosOB7NZeuuyouxKxvXyO9XKkNqje
         rHq/SXv6P/EmUe4M6s9Jl508Nig0O9v9B9z2gNSFoyNjOMwmxWLaDnBm1T0LZYtfL1
         yEsDkAqPgS/kg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 17/30] habanalabs: there is no kernel TDR in future ASICs
Date:   Sat, 22 Jan 2022 21:57:18 +0200
Message-Id: <20220122195731.934494-17-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In future ASICs, there is no kernel TDR for new workloads that are
submitted directly from user-space to the device.

Therefore, the driver can NEVER know that a workload has timed-out.

So, when the user asks us to wait for interrupt on the workload's
completion, and the wait has timed-out, it doesn't mean the workload
has timed-out. It only means the wait has timed-out, which is NOT an
error from driver's perspective.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../misc/habanalabs/common/command_submission.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 96ec1fd3882a..0f41c283082c 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2941,11 +2941,14 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 				rc = -EIO;
 				*status = HL_WAIT_CS_STATUS_ABORTED;
 			} else {
-				dev_err_ratelimited(hdev->dev, "Waiting for interrupt ID %d timedout\n",
-						interrupt->interrupt_id);
-				rc = -ETIMEDOUT;
+				/* The wait has timed-out. We don't know anything beyond that
+				 * because the workload wasn't submitted through the driver.
+				 * Therefore, from driver's perspective, the workload is still
+				 * executing.
+				 */
+				rc = 0;
+				*status = HL_WAIT_CS_STATUS_BUSY;
 			}
-			*status = HL_WAIT_CS_STATUS_BUSY;
 		}
 	}
 
@@ -3058,6 +3061,12 @@ static int _hl_interrupt_wait_ioctl_user_addr(struct hl_device *hdev, struct hl_
 			interrupt->interrupt_id);
 		rc = -EINTR;
 	} else {
+		/* The wait has timed-out. We don't know anything beyond that
+		 * because the workload wasn't submitted through the driver.
+		 * Therefore, from driver's perspective, the workload is still
+		 * executing.
+		 */
+		rc = 0;
 		*status = HL_WAIT_CS_STATUS_BUSY;
 	}
 
-- 
2.25.1

