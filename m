Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9304EF704
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349998AbiDAPsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 11:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357888AbiDAPjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 11:39:20 -0400
Received: from gateway23.websitewelcome.com (gateway23.websitewelcome.com [192.185.50.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF523F1E97
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 08:15:01 -0700 (PDT)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 6434611A06
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 10:15:00 -0500 (CDT)
Received: from 162-215-252-75.unifiedlayer.com ([208.91.199.152])
        by cmsmtp with SMTP
        id aIzMnsUSl22u3aIzMn3Fyz; Fri, 01 Apr 2022 10:15:00 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=B6uLE9LWeBsrM9LH92gc4OCyLh9lvLjJBmhivgz69Cw=; b=Dts8U8qmYfpSekbBgyEdHboSWp
        R8Le9lDx8re4x6IHJryX/8XgwSfk+VUJBU2AubxPtIgduhcoL5uysUfuK19Rc8rBbrWyJu9PppcWg
        WNvLFA8t+7zsll9BX2yRDVxL9Tne470cUGyI5GfsKAhCejbBp8WzUWUr1eDCUne3NH9Wd1c5bqNMG
        Z2ioCCqhEfqhB+YB7d41Cnsl/vqwU9IBR5nsizJC2L2yhiQ0/gHcNPkpq+1rcjTF37fKu6tlxm5jh
        0C2WxiE5HxtHtRxPywgjDywMHZ7zK/LbAK3PWQDw6McxdDn5ghllHQZUXky4f6UJsJ8FoGvK1abD9
        Bh0WYUsA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57800 helo=localhost)
        by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@roeck-us.net>)
        id 1naIzL-003xkZ-UX; Fri, 01 Apr 2022 15:15:00 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH (RESEND)] habanalabs: Fix test build failures
Date:   Fri,  1 Apr 2022 08:14:50 -0700
Message-Id: <20220401151450.3414694-1-linux@roeck-us.net>
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
X-Exim-ID: 1naIzL-003xkZ-UX
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:57800
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 11
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

Add the missing typecast.

Fixes: e8458e20e0a3c ("habanalabs: make sure device mem alloc is page aligned")
Cc: Ohad Sharabi <osharabi@habana.ai>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Resend: Sorry, forgot to copy mailing list

 drivers/misc/habanalabs/common/memory.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index e008d82e4ba3..f0d373171d2a 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -150,9 +150,9 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 		for (i = 0 ; i < num_pgs ; i++) {
 			if (is_power_of_2(page_size))
 				phys_pg_pack->pages[i] =
-						(u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
-										page_size, NULL,
-										page_size);
+					(u64)(uintptr_t)gen_pool_dma_alloc_align(vm->dram_pg_pool,
+										 page_size, NULL,
+										 page_size);
 			else
 				phys_pg_pack->pages[i] = (u64) gen_pool_alloc(vm->dram_pg_pool,
 										page_size);
-- 
2.35.1

