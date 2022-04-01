Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8044EE713
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 06:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244803AbiDAESQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 00:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbiDAESO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 00:18:14 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A814190B49
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 21:16:23 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id t2so1481725pfj.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 21:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=74ylnfKmaB91Dte1fkFjw59xAp0QQDzufKTNNSjIwTM=;
        b=IjxYUt/vk+zIhmyFu8wJhBbIb5BGluikpkcnV2MyKM/8k8TjHZ0RNA7kVX9FuKZGIY
         3v+05iXk3OUqPrMfrhLgT3l1eNc1SSpZB6Q7Qd1sqGH2GHZlipdGYCfvvpxkxein58K2
         Sm3JS0gKNqMqWTE8ceHHOVBw3ew86GQcmsmrLiwDA6BUAX3KLcy09/Zk8K4fsSlAWkq/
         amfPizVf3cFguDZp0+wXKzDLqNOwx+fQ/3VGzo0hSvATzKbuh6Z3u0tbDqwavT/t+5Jw
         pG5unepVtfSA2Ze9wUMdT5I4s1aQnvjSJnIeOZ77Z+A4uoM6X+o+NsxyTdbb9dhYmE3C
         xi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=74ylnfKmaB91Dte1fkFjw59xAp0QQDzufKTNNSjIwTM=;
        b=jdPe6FZDvdAj6cp4zb3ZEzGZHyVbHNLRXFH2lTbFemaKWvn5n6PLRydUq3A03TWG82
         dtD6Dldyxumcu1Y+ELKpZQkkZD5PQuAxGxdDSz33xXal8zynf9akD0RFvj/qaZXbydOp
         IQaTs24oFSDL3ipcGdLopl0qcklCe84vxKjpKN8TfDvcVtoDNvt5oZblKDAc/cwCw50b
         BNt13NSXBeLt2ulAnHekqCnCRqIX9qLZ69ymsKmACCcvtY2asE9yVyiiS3ToyjxVSyUP
         42Q9ncRDzcBJb2JfIHNp8XzohUmjVMzfeijJamngAqoMcUZq2mR2f1pxM2RQwi0cpfpX
         v+ew==
X-Gm-Message-State: AOAM532AGuierok8zKIbmJ8OMjRHvqHP/dvjgCbpn70EclepftV4bJLP
        9I3nHDp4GWcI/IYdx1Q9biU=
X-Google-Smtp-Source: ABdhPJynM6eZ9mYnJarQcvXZQ/jPjrccbONLXCUpts+FGGHs1YsDxb+ay8uKx/aYPuFwKsJ9GYBzmQ==
X-Received: by 2002:a63:2248:0:b0:382:1b3e:6336 with SMTP id t8-20020a632248000000b003821b3e6336mr13149492pgm.271.1648786582748;
        Thu, 31 Mar 2022 21:16:22 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:6338:5657:1b69:f77])
        by smtp.gmail.com with ESMTPSA id j11-20020a63230b000000b00372a08b584asm839851pgj.47.2022.03.31.21.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 21:16:22 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Ohad Sharabi <osharabi@habana.ai>
Cc:     Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] habanalabs: fix build warning
Date:   Thu, 31 Mar 2022 21:16:15 -0700
Message-Id: <20220401041615.3296387-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

allmodconfig build fails on ARCH=xtensa with the following message:

  drivers/misc/habanalabs/common/memory.c:153:49: error: cast from pointer
	to integer of different size [-Werror=pointer-to-int-cast]
	(u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,

Fix it by adding intermediate conversion to uintptr_t as in other places
in that driver.

Fixes: e8458e20e0a3 ("habanalabs: make sure device mem alloc is page aligned")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
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
2.30.2

