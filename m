Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3826551AEB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345232AbiFTNOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344036AbiFTNJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:09:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506501C107
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:05:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 105B8B811D7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0F9C3411B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655730296;
        bh=1yA8R9rgoBzQSs+wO4HV7BvhsC6wNusIZSlchWaGX4U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ny254GilopqKQxai6WG1tWOoJSt/L3aT+V7HUitNRgqQXVFwE2Ng6hfLVhWzBA3BN
         5warp78B+N+sM6kzqd4UPyy0ss9itkseNwTa8vNvIiKfE9Wqf5zCy2yfEgOkpwPeuu
         S536ImCN75d9w2kg1XdgVXmQ09LeDHP3lo4AmzLwsJNT3TvXncWpCV+z7ZJVsNLKK0
         La2ZjhTw+toaxJ0nWVs2Un/PevPSVlwrjswIXm47md3Q0T+ngxct9rYGjKGVt7PB5S
         BWEF5KcKymGeIvzYgYjb7d9/rFoY7qKf8UZtzIP6tXnfwA+vJLf7xiOADwPc0OenHQ
         7jmZgIuxoyCqQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 15/17] habanalabs: print pointer with correct modifier
Date:   Mon, 20 Jun 2022 16:04:30 +0300
Message-Id: <20220620130432.1180451-15-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620130432.1180451-1-ogabbay@kernel.org>
References: <20220620130432.1180451-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use %p instead of %llx for printing pointers.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index e5549a9da42e..5130a63e49cf 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -3035,8 +3035,8 @@ static int ts_buff_get_kernel_ts_record(struct hl_mmap_mem_buf *buf,
 
 	*pend = requested_offset_record;
 
-	dev_dbg(buf->mmg->dev, "Found available node in TS kernel CB(0x%llx)\n",
-						(u64)(uintptr_t)requested_offset_record);
+	dev_dbg(buf->mmg->dev, "Found available node in TS kernel CB %p\n",
+		requested_offset_record);
 	return 0;
 }
 
-- 
2.25.1

