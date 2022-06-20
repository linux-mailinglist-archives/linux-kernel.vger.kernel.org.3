Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91407551B6F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 15:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344913AbiFTNOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 09:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344014AbiFTNJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:09:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9941C106
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:05:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4552B811C4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CEFC3411C;
        Mon, 20 Jun 2022 13:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655730294;
        bh=H1k0Cznz8WyYeBmkHYrxWLlxVvaYwUkpPArF6xP7LtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IXNIzmU4SJUGa3S537s8688egYLwn7nXzGsucE12GKf33iN95yyBQ468L59s4wok/
         q89FcdVXG5aeTw+iurdD1FXNlQeLPLOOYYTPCfehngRPu84FTmTkAuU1YdbuUS5WV3
         Fzt4smwaBwm3T0P0Fci/x/eLnjPCNK1y/BTEAF7KY7EFuDiXD768F53ORfUCrD6otD
         ttgkInYMZr+Bl5pWdU8UvF0Z4w4BcFI4BQEmDs5sCn12jL0IW0RT/YT11ZzwRL8rF7
         j8pRVAn60uSschD/eY6vmAk9dPN8sVF/KSQyYn4nFRDMpdmdRsYWul5v8SJXZN7TFC
         6czcBZ8M9rX4w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     ran shalit <rshalit@habana.ai>
Subject: [PATCH 13/17] habanalabs: add critical indication in sram ecc
Date:   Mon, 20 Jun 2022 16:04:28 +0300
Message-Id: <20220620130432.1180451-13-ogabbay@kernel.org>
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

From: ran shalit <rshalit@habana.ai>

Multiple SRAM SERR events are treated as critical events,
and host should be notified about it. Thus, adding is_critical
indication as part of SRAM ECC failure packet.

Signed-off-by: ran shalit <rshalit@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/include/common/cpucp_if.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/include/common/cpucp_if.h b/drivers/misc/habanalabs/include/common/cpucp_if.h
index 38e44b6cf581..b190a44ef2e2 100644
--- a/drivers/misc/habanalabs/include/common/cpucp_if.h
+++ b/drivers/misc/habanalabs/include/common/cpucp_if.h
@@ -68,7 +68,8 @@ struct hl_eq_ecc_data {
 	__le64 ecc_address;
 	__le64 ecc_syndrom;
 	__u8 memory_wrapper_idx;
-	__u8 pad[7];
+	__u8 is_critical;
+	__u8 pad[6];
 };
 
 enum hl_sm_sei_cause {
-- 
2.25.1

