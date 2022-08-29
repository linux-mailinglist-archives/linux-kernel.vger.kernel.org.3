Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D5F5A45FD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiH2JXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiH2JXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:23:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FF35AA1A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:23:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87A1960F9E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A211C433C1;
        Mon, 29 Aug 2022 09:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661764984;
        bh=SP6FO5OVX0W3tqYYHyor3Axas/34MtKo+fTrqAskab4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FJKVc9l8KE28b12hq8Sb8gZ9pGgt1iR1C7hngDVoYimmS6ZrJC3A+VVz2zNpzNpqy
         1H7jgTFoXVnQJl0i9yCzQW1Mszg+lHluu+hhEziQEWhcv6QSEZMMoqkDES6R5k0roR
         9LFl+nvtq/b3nZoZlZdnWMWCIdQvKhkXdb4wSTfA8slYESBmtUZd9nBS7qiIFwnVIg
         HWbY2ylr7G8HPZ9AKU6mJS4ywUqChFH4mSxWJR6KsJyUHERYdxXMa+COGvdQ1ZKc2x
         pldVVzua3bqk5AFTs8hxJdOyRlpsL41SXudzzucg8EI8xKuVYeYtaC40GTSpmt4pRC
         09dL6odI/mOOA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 4/7] habanalabs/gaudi2: log critical events with no rate limit
Date:   Mon, 29 Aug 2022 12:22:51 +0300
Message-Id: <20220829092254.930753-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829092254.930753-1-ogabbay@kernel.org>
References: <20220829092254.930753-1-ogabbay@kernel.org>
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

From: farah kassabri <fkassabri@habana.ai>

When we have a storm of errors of HBM ECC SERR we can reach a situation
where driver start hard reset flow without logging the error cause
that caused the hard reset due to logs rate limiting.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi2/gaudi2.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi2/gaudi2.c b/drivers/misc/habanalabs/gaudi2/gaudi2.c
index ff0f9e9db1b5..6bebd5eb0294 100644
--- a/drivers/misc/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/misc/habanalabs/gaudi2/gaudi2.c
@@ -8200,10 +8200,17 @@ static bool gaudi2_handle_hbm_mc_sei_err(struct hl_device *hdev, u16 event_type,
 		return true;
 	}
 
-	dev_err_ratelimited(hdev->dev,
-		"System Error Interrupt - HBM(%u) MC(%u) MC_CH(%u) MC_PC(%u). Critical(%u). Error cause: %s\n",
-		hbm_id, mc_id, sei_data->hdr.mc_channel, sei_data->hdr.mc_pseudo_channel,
-		sei_data->hdr.is_critical, hbm_mc_sei_cause[cause_idx]);
+	if (sei_data->hdr.is_critical)
+		dev_err(hdev->dev,
+			"System Critical Error Interrupt - HBM(%u) MC(%u) MC_CH(%u) MC_PC(%u). Error cause: %s\n",
+			hbm_id, mc_id, sei_data->hdr.mc_channel, sei_data->hdr.mc_pseudo_channel,
+			hbm_mc_sei_cause[cause_idx]);
+
+	else
+		dev_err_ratelimited(hdev->dev,
+			"System Non-Critical Error Interrupt - HBM(%u) MC(%u) MC_CH(%u) MC_PC(%u). Error cause: %s\n",
+			hbm_id, mc_id, sei_data->hdr.mc_channel, sei_data->hdr.mc_pseudo_channel,
+			hbm_mc_sei_cause[cause_idx]);
 
 	/* Print error-specific info */
 	switch (cause_idx) {
-- 
2.25.1

