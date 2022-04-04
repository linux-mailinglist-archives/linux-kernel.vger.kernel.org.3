Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2896B4F167B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 15:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358676AbiDDNvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 09:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356949AbiDDNvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 09:51:00 -0400
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com [192.185.144.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181EE29829
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 06:49:04 -0700 (PDT)
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 8A2E5129A4D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 08:49:03 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id bN4pnuLj19AGSbN4pnXqco; Mon, 04 Apr 2022 08:49:03 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uf3+N2Jmm9SwnY5qhYETfam054vBqdkvozLaomc7hz0=; b=1ZT/r09h8QC0WMF3tvhhrgVcmJ
        IUkUaJYBk+5iwqB4YLez8EuFK7D6NweQ+hnWA1uW9U4CTT4OSz2ARj4FjZpruhiLhBzGx6jHb+kfv
        Rg80cdduBZX7QjW8sZGpQ0AtN7GRxjtBHUD+Y5t7EA7Ub9CZb2BODO7XtH/eZAWV+9ZkK1vegt1vR
        BMDdGBAjujj01kFD3nzAmn8cTIRzFjWKGCElTtIZVVQqaQVdp3QYASA4bSnHzSicij9HoAItIYFo5
        SO3vHDOYzquB+tfXiX2NUpqgU+/jgQr5sToxdNQOjEghujsOOHGehOCsfU3K5K3y+PRnkxsbqrKWR
        /M81Z62Q==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57846 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1nbN4p-000gqQ-2P; Mon, 04 Apr 2022 13:49:03 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH v2] habanalabs: Fix test build failures
Date:   Mon,  4 Apr 2022 06:48:59 -0700
Message-Id: <20220404134859.3278599-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1nbN4p-000gqQ-2P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57846
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 13
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

allmodconfig builds on 32-bit architectures fail with the following error.

drivers/misc/habanalabs/common/memory.c: In function 'alloc_device_memory':
drivers/misc/habanalabs/common/memory.c:153:49: error:
	cast from pointer to integer of different size

Fix the typecast. While at it, drop other unnecessary typecasts associated
with the same commit.

Fixes: e8458e20e0a3c ("habanalabs: make sure device mem alloc is page aligned")
Cc: Ohad Sharabi <osharabi@habana.ai>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Drop unnecessary (u64) typecasts

 drivers/misc/habanalabs/common/memory.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index e008d82e4ba3..a13506dd8119 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -111,10 +111,10 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 
 	if (contiguous) {
 		if (is_power_of_2(page_size))
-			paddr = (u64) (uintptr_t) gen_pool_dma_alloc_align(vm->dram_pg_pool,
-								total_size, NULL, page_size);
+			paddr = (uintptr_t) gen_pool_dma_alloc_align(vm->dram_pg_pool,
+								     total_size, NULL, page_size);
 		else
-			paddr = (u64) (uintptr_t) gen_pool_alloc(vm->dram_pg_pool, total_size);
+			paddr = gen_pool_alloc(vm->dram_pg_pool, total_size);
 		if (!paddr) {
 			dev_err(hdev->dev,
 				"failed to allocate %llu contiguous pages with total size of %llu\n",
@@ -150,12 +150,12 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 		for (i = 0 ; i < num_pgs ; i++) {
 			if (is_power_of_2(page_size))
 				phys_pg_pack->pages[i] =
-						(u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
-										page_size, NULL,
-										page_size);
+					(uintptr_t)gen_pool_dma_alloc_align(vm->dram_pg_pool,
+									    page_size, NULL,
+									    page_size);
 			else
-				phys_pg_pack->pages[i] = (u64) gen_pool_alloc(vm->dram_pg_pool,
-										page_size);
+				phys_pg_pack->pages[i] = gen_pool_alloc(vm->dram_pg_pool,
+									page_size);
 			if (!phys_pg_pack->pages[i]) {
 				dev_err(hdev->dev,
 					"Failed to allocate device memory (out of memory)\n");
-- 
2.35.1

