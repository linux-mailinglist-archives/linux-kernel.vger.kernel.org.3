Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BE2496DD4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbiAVT7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbiAVT6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:58:24 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EEBC061744
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 11:58:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5874DCE09EC
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24CE3C36AE3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881495;
        bh=1Y9RHVEo2r/sQAdjNV6r0yQYdfLSQw7kZLim75WA30w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HES4iFEdz/RpwigpATW9wAkeO5Sc/6DcIV9eXR9gq9FrZ2mPKvvPcqEagYgkIn2Z1
         IOh2UAdE4LFQAraPDlJuLxvJsSSCiXDzpmxBGhAvFCNRoB9BO2xsEF+qhQ+p7iZf0c
         QUKiMPPkQqD2xUz5hpkVHnsjO2X8ORXdoqxjgovGii3yD711c+TqLwX6R6CGmhg1uQ
         eFF683mNVSSJr9CE71c0M+QGSQJiNa7/+Z18V0KR1KdU/diwwYoMPvNSXsv9EuRm3r
         gwUwRZBgbpsj8pTvyddJAzSMj0VRijmAVH0rwU9iXAX62lvVHPY9VDHk/aTdRcHi+r
         1O8gXMb9j37oQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 30/30] habanalabs: remove duplicate print
Date:   Sat, 22 Jan 2022 21:57:31 +0200
Message-Id: <20220122195731.934494-30-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220122195731.934494-1-ogabbay@kernel.org>
References: <20220122195731.934494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We print detailed messages inside the internal ioctl functions. No need
to print a generic message at the end, it doesn't add any information.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 3d9020825df5..4e57e0ba5c57 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -3135,13 +3135,8 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 				args->in.interrupt_timeout_us, args->in.addr,
 				args->in.target, interrupt, &status,
 				&timestamp);
-	if (rc) {
-		if (rc != -EINTR)
-			dev_err_ratelimited(hdev->dev,
-				"interrupt_wait_ioctl failed (%d)\n", rc);
-
+	if (rc)
 		return rc;
-	}
 
 	memset(args, 0, sizeof(*args));
 	args->out.status = status;
-- 
2.25.1

