Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0635458EC0F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 14:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbiHJMd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 08:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbiHJMdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 08:33:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9188F7695E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 05:33:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38B5361351
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 12:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C20C433C1;
        Wed, 10 Aug 2022 12:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660134799;
        bh=r1pdHMac47LVUbZIJlp842Vu1LlKO5L0i0vtViGYPCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dUUziB0bKb2xOuypfXnJDbfXI+MK7MVXHZ5qZJ6qwws7cJVMMTWB5LbXIFB5FL9ZX
         CJwcuN+FD0ZYPiCTwHN1Qi1+llh8OyJPTkh2mfIEdmO2lSte66VScibZ4p+0N3Sguk
         jlU0QkQPAcVOMHnGXwInh7SzSikX7KF/CIoGfPfKuj6EnEMdhXe8rxygzB3+/FGntd
         WZC++r+2iANpoj52xNF7VXwJWKVEucwWnpzPdd9AS2LNZCigYpT16/XinYnxeq2S2f
         f74j6SMsN+hpBmlmenQ2S4iP3ffjYDFV4QvCuWoGk8EQT4YqRqJmxUzTViFhVHxIrO
         g0I3u5FhRLWew==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dafna Hirschfeld <dhirschfeld@habana.ai>
Subject: [PATCH 3/3] habanalabs: fix bug when setting va block size
Date:   Wed, 10 Aug 2022 15:33:12 +0300
Message-Id: <20220810123312.1683716-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810123312.1683716-1-ogabbay@kernel.org>
References: <20220810123312.1683716-1-ogabbay@kernel.org>
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

From: Dafna Hirschfeld <dhirschfeld@habana.ai>

the size of a block is always 'block->end - block->start + 1'

Signed-off-by: Dafna Hirschfeld <dhirschfeld@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 5bc704da889d..e3b40dbf154c 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -457,7 +457,7 @@ static void merge_va_blocks_locked(struct hl_device *hdev,
 	prev = list_prev_entry(va_block, node);
 	if (&prev->node != va_list && prev->end + 1 == va_block->start) {
 		prev->end = va_block->end;
-		prev->size = prev->end - prev->start;
+		prev->size = prev->end - prev->start + 1;
 		list_del(&va_block->node);
 		kfree(va_block);
 		va_block = prev;
@@ -466,7 +466,7 @@ static void merge_va_blocks_locked(struct hl_device *hdev,
 	next = list_next_entry(va_block, node);
 	if (&next->node != va_list && va_block->end + 1 == next->start) {
 		next->start = va_block->start;
-		next->size = next->end - next->start;
+		next->size = next->end - next->start + 1;
 		list_del(&va_block->node);
 		kfree(va_block);
 	}
-- 
2.25.1

