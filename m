Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B177A4EF860
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349958AbiDAQxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350180AbiDAQwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:52:33 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9637BB82D8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 09:41:49 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id s11so3090527pfu.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 09:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=qFBAvnSg79zoT3+JHM3vRs2zXL9WFcit8FJyzU3capc=;
        b=Us9JNrHb8FSQA4yTPo9jEb5jZcr9MnUGvOzX0HJAQCEJXT/eL24QXIXcLjAkg8q6Kl
         HeCP8i0HPITMmBTyTOiKz4oxtxFFmv23M8iIV7Y+Bkq8/Tjkt3enC2MT03L9eVRCjhGv
         WK/EbevIn/hV3WIBoDuxL1zntTpJdCVehsc053Ajjx6LlY4LcaGAhj87+Kpy0e1vaCG7
         KVaRkPKD/4KYlvT97s1lFo+8gQtO5ne2j91rbWGKqL5WZRFgve4EdR7buLFyxj/YzNJ3
         0UGgPy4Sp+hXDWYd/ObktV48tCsv4pMsUQuTbUSvxdX3VI3W5YFXOah8r6FuSGtHy0DI
         YqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=qFBAvnSg79zoT3+JHM3vRs2zXL9WFcit8FJyzU3capc=;
        b=y7RSFMM0gynIrP7clUBMZc5NFQJBpoPfpHO9XaXDGjk+o/z2vTDv+1aIyyUvo7Js/p
         Pg5InxFaO+SM+dAylY4qwVdBX3C6ogO0ESZ9I+hNfi2FW/OCCagjGy5/gjwQOxl0EqFR
         v5XuyBVL8Hk4Mm9E+1GEfR5VwV05vi1iC4Ou4m5mixUqUKL3FwizJfE2TwvGPSo1qCyC
         ptLV+jSmzUJ7G9hJxnBLvAtidEdWdx1lCS5+wNtQxLGTg4FeeQ0mt1EVhdAKbd1GyRnn
         vD8PBp35/kj4XOG7lJ6QbjMrwLsigAVLRKCIrGM8aI/uIw0XEsut06KjanY2Etpu6niV
         4T5g==
X-Gm-Message-State: AOAM531kRFIvQLe9T3rAwDgFwko99RMEnARsHZ8BMRI/3dLPACTzHqu5
        tq6hpyJe9BSa68onxob1fOg1ww==
X-Google-Smtp-Source: ABdhPJwes6GB4QofFG33x08DcMvHD/tGHasWxDQKJg/phGDL3vN9pemPhlXzw0y3X93EX8EhZ203Hw==
X-Received: by 2002:a05:6a00:b87:b0:4fa:a79a:72e7 with SMTP id g7-20020a056a000b8700b004faa79a72e7mr11808231pfj.68.1648831309069;
        Fri, 01 Apr 2022 09:41:49 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id m7-20020a056a00080700b004fb28fafc4csm3812953pfk.97.2022.04.01.09.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 09:41:48 -0700 (PDT)
Subject: [PATCH] habanalabs: Elide a warning on 32-bit targets
Date:   Fri,  1 Apr 2022 09:39:09 -0700
Message-Id: <20220401163909.20343-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc:     ogabbay@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>, ynudelman@habana.ai,
        obitton@habana.ai, fkassabri@habana.ai, daniel.vetter@ffwll.ch,
        ttayar@habana.ai, sozeri@habana.ai, bjauhari@habana.ai,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

This double-cast pattern looks a bit awkward, but it already exists
elsewhere in the driver.  Without this patch I get

drivers/misc/habanalabs/common/memory.c: In function ‘alloc_device_memory’:
drivers/misc/habanalabs/common/memory.c:153:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
  153 |                                                 (u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
      |                                                 ^

which ends up promoted to a build error in my test setup.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

---

I don't know anything about this driver, I'm just pattern-matching the
warning away.
---
 drivers/misc/habanalabs/common/memory.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index e008d82e4ba3..f1fc79c1fc10 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -150,12 +150,12 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 		for (i = 0 ; i < num_pgs ; i++) {
 			if (is_power_of_2(page_size))
 				phys_pg_pack->pages[i] =
-						(u64) gen_pool_dma_alloc_align(vm->dram_pg_pool,
-										page_size, NULL,
-										page_size);
+						(u64) (uintptr_t) gen_pool_dma_alloc_align(vm->dram_pg_pool,
+											   page_size, NULL,
+											   page_size);
 			else
-				phys_pg_pack->pages[i] = (u64) gen_pool_alloc(vm->dram_pg_pool,
-										page_size);
+				phys_pg_pack->pages[i] = (u64) (uintptr_t) gen_pool_alloc(vm->dram_pg_pool,
+											  page_size);
 			if (!phys_pg_pack->pages[i]) {
 				dev_err(hdev->dev,
 					"Failed to allocate device memory (out of memory)\n");
-- 
2.34.1

