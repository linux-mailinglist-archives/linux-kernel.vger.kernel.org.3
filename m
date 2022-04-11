Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3E0C4FB6FF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbiDKJKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344172AbiDKJKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:10:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DB327FE9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:08:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57F35B81125
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:08:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11264C385A3;
        Mon, 11 Apr 2022 09:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649668096;
        bh=fOYgRv8B5h/y7wpaCury1d0zh6qAGN6yx1x6Ku6Tfi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dAS1VQjjuBQhRzPolVgAQXOJj45Klx556dOLMn4FxqwNsp5pk/Qbr7PJkCEPQd5T2
         9mXZ0WKwdc5vUo8Le5RRcv7zjJxrm7i7AgF8kdc2S4pxY5LXXa1TCh5M6ePPqwJCYw
         dnOhfbk7/TLs1tdJgdVKqGWn/8gz6P8qUPFf/4KhgSmhNU0jTSVIYtVbLO3TmV2Aof
         e9QFALqomt50MpryByAOKZSiFWZwbkI66YEmoDxqbbmjIaFpx71UM9RJynHaFCl28Y
         sa0Hml/VtAEC3WGmLu4TGsn+FPw7L/ySHh2wzGE3aowk3FSwmzFrdLYwvMhDXDzHFl
         leDLFmS7AsLRA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rajaravi Krishna Katta <rkatta@habana.ai>
Subject: [PATCH 5/7] habanalabs/gaudi: use lower_32_bits() for casting
Date:   Mon, 11 Apr 2022 12:08:03 +0300
Message-Id: <20220411090805.1617112-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411090805.1617112-1-ogabbay@kernel.org>
References: <20220411090805.1617112-1-ogabbay@kernel.org>
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

From: Rajaravi Krishna Katta <rkatta@habana.ai>

Use standard kernel macro to take lower 32 bits of 64-bits variable.

Signed-off-by: Rajaravi Krishna Katta <rkatta@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index b4bd40d47000..2824d2f16a25 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -8957,7 +8957,7 @@ static int gaudi_add_sync_to_engine_map_entry(
 	 */
 	if (reg_value == 0 || reg_value == 0xffffffff)
 		return 0;
-	reg_value -= (u32)CFG_BASE;
+	reg_value -= lower_32_bits(CFG_BASE);
 
 	/* create a new hash entry */
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
-- 
2.25.1

