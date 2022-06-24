Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC17559ADB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbiFXOEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiFXOEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:04:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28552D71
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:04:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B84B361FB8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FEBC3411C
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656079477;
        bh=9bsbJVTNJkaKXWkDpMbj2ZbIIDMqrNz8MQ8KiiTEWV4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=K+YmJ3mHHKvGdiqkB68Y6VUD4qG5SzQ3hRQO8lUGswdr7ePD6pVGY4yWjj5Iy+HY7
         +1BqNuPcriFaX18KYgGvytelti06XahARQFqpcTVmBqe/68IbOmA6PsqG3zy95udNi
         LA7ViY4CPcEsjY4CMZF+eYQvzelZQuJhJ+VJCSo+fJG5vfmhdGx5WIn7hg1GA0zpR/
         BnSvBROh9vDFaFkis3chhKAFZpHOjk8emGJkZC66MNojCAc4Gj5YFCr9YOHgqdz/Nv
         tjJkQq+9RfQs/W4LloRTnkzJrTFDJFPNgmkgzmlCCuupS53YHk2jpMQ+OwKhC3/rqe
         jGdA+VuLGegSg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] habanalabs/gaudi: use correct type in assignment
Date:   Fri, 24 Jun 2022 17:04:27 +0300
Message-Id: <20220624140429.1778402-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624140429.1778402-1-ogabbay@kernel.org>
References: <20220624140429.1778402-1-ogabbay@kernel.org>
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

packets are defined as LE so we need to convert before assigning
values to them.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 8cf3382fa039..9ecae3da9133 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -5772,7 +5772,7 @@ static void gaudi_add_end_of_cb_packets(struct hl_device *hdev, void *kernel_add
 	cq_pkt = kernel_address + len - (sizeof(struct packet_msg_prot) * 2);
 
 	while ((void *)cq_padding < (void *)cq_pkt) {
-		cq_padding->ctl = FIELD_PREP(GAUDI_PKT_CTL_OPCODE_MASK, PACKET_NOP);
+		cq_padding->ctl = cpu_to_le32(FIELD_PREP(GAUDI_PKT_CTL_OPCODE_MASK, PACKET_NOP));
 		cq_padding++;
 	}
 
-- 
2.25.1

