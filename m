Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EC3568F8F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbiGFQq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbiGFQqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:46:17 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439032A402
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 09:46:11 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o3-20020a17090a744300b001ef8f7f3dddso7858494pjk.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 09:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T6h4OXZQzG/asYA1Xhet59Cfd+Yad4rt+k1tqeixPrk=;
        b=De2uO9CQ5L4IinSS9lNjF/ybUMyCNO/YriA8s+55skSi4g+zi714vlbOwMmlS6z4LI
         EbBrS1t3Zag2WNj7j7cYtIGtEWaj2XU55Ck5zMhmUoYVz2bJguVc/AQSplRg84pPQQ4J
         2glPhD6VnbUlZQpFxRqYuIickekcGecpH1jY7afR119n6Q3tB/R/jkXw8v0kqWX+w43o
         z69r7fl8THK9m6YsETr+f+QFBTt+K4mKRWocWgjuHOqq6jJa0QNWDTOuF9/Goox5unaZ
         eHu7Cz6d133HhRySEPz2CU8Igs4SBFtpLuXEbyOlO2Idhl7e4uDaAH5Bsg9HpOAX8kYf
         czLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T6h4OXZQzG/asYA1Xhet59Cfd+Yad4rt+k1tqeixPrk=;
        b=b4iv5K+QS3XsFEzsuyjTSJ9CPB6tHhEa+XkECaCtHJ2UlqGF/ZBzheeedABtNGwHts
         AFbHR4tMWUtOqW7/ULVerGMC36UcDbePvZvvPEGsJKI4TOlxnbXVrOnSE5gRibv2S1X7
         RuKB3N0Ge3Z1XGiDst3jnoRSwOWyeQTt1chJh6FTX23lH0Ws/QPO7rbv8gu8jtsUFMRX
         f/+3oRcodpIpZRB0/zOxznpQv3/Ywsb/lvSL2nkz9LmESuzf82SWaR0FwOO/mLk+1149
         V1mN3jroW8dT8nBZcKTSta8BdcKZM2GEPo44fs016S+hyaVaGREvl9FYPpdhHFU9y/+8
         CPEA==
X-Gm-Message-State: AJIora/Hncy2c4WeYe12sUivsS5seWtQ+1Mvo8gKOP5G9PpuDiCbwura
        BFBoC24KRdB1ol5gNf1A6iw=
X-Google-Smtp-Source: AGRyM1s7AZd0vr/XZymwLu9du7fU96fJXpCPY9tl0IZc+G5d2bdtoysfx0eL0yJNRapfvhsqHsYiGQ==
X-Received: by 2002:a17:902:d5d3:b0:16b:e3ed:966f with SMTP id g19-20020a170902d5d300b0016be3ed966fmr16945531plh.156.1657125970522;
        Wed, 06 Jul 2022 09:46:10 -0700 (PDT)
Received: from localhost.localdomain (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id z184-20020a6265c1000000b005286697ec68sm3911000pfb.133.2022.07.06.09.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 09:46:10 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-kernel@vger.kernel.org (open list), ssantosh@kernel.org,
        ardb@kernel.org, linus.walleij@linaro.org, geert+renesas@glider.be
Subject: [PATCH v2] ARM: Fix MAX_DMA_ADDRESS overflow
Date:   Wed,  6 Jul 2022 09:46:06 -0700
Message-Id: <20220706164606.68528-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
added a check to determine whether arm_dma_zone_size is exceeding the
amount of kernel virtual address space available between the upper 4GB
virtual address limit and PAGE_OFFSET in order to provide a suitable
definition of MAX_DMA_ADDRESS that should fit within the 32-bit virtual
address space. The quantity used for comparison was off by a missing
trailing 0, leading to MAX_DMA_ADDRESS to be overflowing a 32-bit
quantity.

This was caught with the bcm2711 platforms which defines a dma_zone_size
of 1GB, and using a PAGE_OFFSET of 0xc000_0000 (CONFIG_VMSPLIT_3G) with
CONFIG_DEBUG_VIRTUAL enabled would lead to MAX_DMA_ADDRESS being
0x1_0000_0000 which overflows the unsigned long type used throughout
__pa() and __virt_addr_valid(). Because the virtual address passed to
__virt_addr_valid() would now be 0, the function would loudly warn, thus
making the platform unable to boot properly.

Fixes: 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- simplify the patch and drop the first patch that attempted to fix an
  off by one in the calculation.

 arch/arm/include/asm/dma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/dma.h b/arch/arm/include/asm/dma.h
index a81dda65c576..1ffa75beb709 100644
--- a/arch/arm/include/asm/dma.h
+++ b/arch/arm/include/asm/dma.h
@@ -10,7 +10,7 @@
 #else
 #define MAX_DMA_ADDRESS	({ \
 	extern phys_addr_t arm_dma_zone_size; \
-	arm_dma_zone_size && arm_dma_zone_size < (0x10000000 - PAGE_OFFSET) ? \
+	arm_dma_zone_size && arm_dma_zone_size < (0x100000000 - PAGE_OFFSET) ? \
 		(PAGE_OFFSET + arm_dma_zone_size) : 0xffffffffUL; })
 #endif
 
-- 
2.25.1

