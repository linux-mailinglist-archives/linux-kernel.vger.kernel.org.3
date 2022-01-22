Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0C4496DB8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiAVT5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiAVT5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:57:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57802C06173B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 11:57:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 87309CE0171
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 19:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7DDC004E1;
        Sat, 22 Jan 2022 19:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642881456;
        bh=gw45sq55Pv/BmV/aNJVu1hzrywsEWLtsYJx2Htq7liU=;
        h=From:To:Cc:Subject:Date:From;
        b=LhR+3OXX/ACiJK4O9WWdjcCAfqq+UDhyaAjODpIcnkQSmpR/5dYTn8yKOCut04d+F
         89xsvfjvZtyE95K8F1yQNflXfBtu6jlMS7yddb8rx/PZm3NneH0pusPWuTZX2A9MaC
         WKrSDNYJ+yecd60n8x3G/iHOGsvx1It09CZOuPNR0vpbFhLUKlPpPeDP7601Vch1+W
         qTqrRGXtpbIQCqBK1pFqEjyfFN9ovv8Hc9eHfgq/3zuG6U1PW62xzymQgJ1sWUYBnq
         WcgnYuA0LUAU8L1UNNoE374bUJSLYXCiz1aJzxvvxsT8aQrP80H0rYq1dHDBH7onz8
         pr+KtLBYLQw+w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 01/30] habanalabs: check the return value of hl_cs_poll_fences()
Date:   Sat, 22 Jan 2022 21:57:02 +0200
Message-Id: <20220122195731.934494-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

As part of handling of the multi-CS wait ioctl, hl_cs_poll_fences() is
called in a "while (true)" loop. This function can fail, but the
checking of its return value was missed.
Add this check and exit the loop in case of a failure.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 0a4ef13d9ac4..2f40b937c59f 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2739,7 +2739,7 @@ static int hl_multi_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 		mcs_data.update_ts = false;
 		rc = hl_cs_poll_fences(&mcs_data, mcs_compl);
 
-		if (mcs_data.completion_bitmap)
+		if (rc || mcs_data.completion_bitmap)
 			break;
 
 		/*
-- 
2.25.1

