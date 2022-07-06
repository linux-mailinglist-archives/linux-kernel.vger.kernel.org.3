Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A12256935D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiGFUeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiGFUeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:34:00 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ADE63DF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 13:34:00 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id v4-20020a17090abb8400b001ef966652a3so7102286pjr.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 13:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CWCLa+dTVXWwsrUUTc1ULWbuRRtRrFjABx527QYlRYE=;
        b=N3mfqfa8QIYI2oMOnSFfuS+ztGJzFRckUNR60Rg7uj0J6KdS5RiNyoKRlYbfh0xKDP
         miNEQDrvOEAW5HkFaO++0utAkCCH4gvrj/JSV4V/RhCKNpcq+NyoHrCPSI3rIYG6GNlu
         v27ODgmoQE9bllvvKMUdP06XIFx+LSlfYDQVU/3lEeBY9WKcEpq3SZ7ln8frW8plw0Bm
         um0LZ33TKl333MX/RChX0fqReTrqXLAklWNN1yr6CvsDolJFGpEtHn8CnniukAzvPIbZ
         nNZpd/YBLec0jEJNkaUHiIQLAh6Nl+VF1BrCEerL2s4AAIkyZH6S+1a88bX6lwVOozYe
         Equg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CWCLa+dTVXWwsrUUTc1ULWbuRRtRrFjABx527QYlRYE=;
        b=VVfnqqshkUVi63GiIdjZwSWv7NLOm+kIwXunukOwj/+lhdKjfcnxPe4iggcP74lfH0
         5R7ANoxG06J/O8Yiw7sMY9pi3j3oZYG5DbCARYe8Jx7mIiyW0aB6Vx5xyPtqLDGkt8RN
         SlMLcSQQDvhvKd2m1gfwMaBawAD79lU5EZ54ZUehWGkGJoNqq2Jr3LuYkcXvOdpRhdym
         qKuC+02sTQ8a66sBY9ghsCagEKFOUkIb0vjzkjsulmKSYDtqezd19QINr2bFy5uYSQ3A
         W7nogYjT1zqjMj0jv+RUOv8eRSFxj26chbdPRKAKsvEE57k46Xrp+7cIZp4H8YSjVLYI
         BO2w==
X-Gm-Message-State: AJIora+BY57hpIf+QUrJnIYku9jq5sIaQmS1egRD7iTB/f+DbOE0LEZw
        eqfC6qEASjCkPZ8gy4sHCeQ=
X-Google-Smtp-Source: AGRyM1tXewrWxIrfYGjV6cq7zTptlUMB++mYEvJvssDzXJFuaW8LXUuYbRWfiGSaFp1zNFRn47dwkA==
X-Received: by 2002:a17:902:dace:b0:16b:e8d4:2955 with SMTP id q14-20020a170902dace00b0016be8d42955mr15758494plx.135.1657139639489;
        Wed, 06 Jul 2022 13:33:59 -0700 (PDT)
Received: from localhost.localdomain (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id v11-20020a17090a4ecb00b001ef863193f4sm7797248pjl.33.2022.07.06.13.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 13:33:58 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        linux-kernel@vger.kernel.org (open list), ssantosh@kernel.org,
        ardb@kernel.org, linus.walleij@linaro.org, geert+renesas@glider.be
Subject: [PATCH v3] ARM: Fix MAX_DMA_ADDRESS overflow
Date:   Wed,  6 Jul 2022 13:33:53 -0700
Message-Id: <20220706203353.247633-1-f.fainelli@gmail.com>
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

This was caught thanks to CONFIG_DEBUG_VIRTUAL on the bcm2711 platform
where we define a dma_zone_size of 1GB and we have a PAGE_OFFSET value
of 0xc000_0000 (CONFIG_VMSPLIT_3G) leading to MAX_DMA_ADDRESS being
0x1_0000_0000 which overflows the unsigned long type used throughout
__pa() and then __virt_addr_valid(). Because the virtual address passed
to __virt_addr_valid() would now be 0, the function would loudly warn
and flood the kernel log, thus making the platform unable to boot
properly.

Fixes: 26f09e9b3a06 ("mm/memblock: add memblock memory allocation apis")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v3:

- added ULL suffix to the constant
- reworded the commit message to be clearer

Changes in v2:

- simplify the patch and drop the first patch that attempted to fix an
  off by one in the calculation.

 arch/arm/include/asm/dma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/dma.h b/arch/arm/include/asm/dma.h
index a81dda65c576..45180a2cc47c 100644
--- a/arch/arm/include/asm/dma.h
+++ b/arch/arm/include/asm/dma.h
@@ -10,7 +10,7 @@
 #else
 #define MAX_DMA_ADDRESS	({ \
 	extern phys_addr_t arm_dma_zone_size; \
-	arm_dma_zone_size && arm_dma_zone_size < (0x10000000 - PAGE_OFFSET) ? \
+	arm_dma_zone_size && arm_dma_zone_size < (0x100000000ULL - PAGE_OFFSET) ? \
 		(PAGE_OFFSET + arm_dma_zone_size) : 0xffffffffUL; })
 #endif
 
-- 
2.25.1

