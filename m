Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599074E6823
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352430AbiCXR4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352410AbiCXRz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:55:56 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AEE3968C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:54:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id jx9so5339896pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jKyYn/8x1r3aq5yDhbWNBcNW8nQVJUhymtL9BdNTCak=;
        b=JHR9OsnDe32cYkFuQG30yVf4IIy04Gd4f4cS9Jfup69kp9HQcphhKnJ9CHj6uixQ13
         hCGK9/5Ttevrc7XvcWHiC0scEoQDhXQFSSWqeiGoC3MDEtSyHwBjQ1Sb2oneayNShOY0
         1dsdJa33UfBu/6nqLkKH7N0K6bW6A5fnAMOTQNg7U0558UBoJBGEAt2NBevAbQFrR/2I
         6WJX36SjgAEDj/5ePihT4GV2pu7uEYxt6RCvYXTL31WL67j0yui7njsX0CXRYq25H7N2
         dONEMRWxZZvqSN77t3l/MSkpJgdMDpZfAHF+CshzVekdT+0U49za42nq71qdUaOaXcYB
         sm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jKyYn/8x1r3aq5yDhbWNBcNW8nQVJUhymtL9BdNTCak=;
        b=ykIrb2qZghZtSdn3fEDEtOe/ogchjWKL/y6kHJYSu2aURV9AJvduggqrJGr/WKTgaT
         tmRWVt1evRKzWim8GMNIt3pDDUKuYfAWggi5KtbZQoPzZqZJyZwZ2Z2H3SZJGx/b36YP
         3IHANcgnrAdoiRubOjtLHREEkxTOJ3ldtjlERCkQjsOGJJpQyYu3YxkmGBk9pvYMLZVb
         iArv2KmdswALCBRVbtwqzUUp9szGGYMJGMZdNGJQFI2Edy9ZDGy3fpQIP6WkpwlzOh4N
         uuxtgT34f3unVQ3Y+Uj3E2YKecf7RNCChlm7gYlK2u5mJK4A2jsMwlL0q9W5JEqwnF2g
         MUtw==
X-Gm-Message-State: AOAM531DHCY2aeLfgImItFUu0N/tAPvty7szOLypYv6cdp4Arof5UeyQ
        3/NCd8fPjbCL2KQPwbwAJaM=
X-Google-Smtp-Source: ABdhPJzXDtBnQmmfVzd/7DM+GwJdkOhngZyeyhrF6BjpSvFW2oCpd/etdNVcxpTwK7WvQFb2wzWrsw==
X-Received: by 2002:a17:902:f60f:b0:151:4f66:55b4 with SMTP id n15-20020a170902f60f00b001514f6655b4mr7048785plg.127.1648144464284;
        Thu, 24 Mar 2022 10:54:24 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f21-20020a056a00239500b004fb02a7a45bsm1003193pfc.214.2022.03.24.10.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 10:54:23 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org (open list),
        linus.walleij@linaro.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 2/2] ARM: Clamp MAX_DMA_ADDRESS to 32-bit
Date:   Thu, 24 Mar 2022 10:54:17 -0700
Message-Id: <20220324175417.1014562-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324175417.1014562-1-f.fainelli@gmail.com>
References: <20220324175417.1014562-1-f.fainelli@gmail.com>
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

MAX_DMA_ADDRESS is a virtual address, therefore it needs to fit within a
32-bit unsigned quantity. Platforms defining a DMA zone size in
their machine descriptor can easily overflow this quantity depending on
the DMA zone size and/or the PAGE_OFFSET setting.

In most cases this is harmless, however in the case of a
CONFIG_DEBUG_VIRTUAL enabled, __virt_addr_valid() will be unable to
return that MAX_DMA_ADDRESS is valid because the value passed to that
function is an unsigned long which has already overflowed.

Fixes: e377cd8221eb ("ARM: 8640/1: Add support for CONFIG_DEBUG_VIRTUAL")
Fixes: 2fb3ec5c9503 ("ARM: Replace platform definition of ISA_DMA_THRESHOLD/MAX_DMA_ADDRESS")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/asm/dma.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/dma.h b/arch/arm/include/asm/dma.h
index f244ee68e814..ea47420babd4 100644
--- a/arch/arm/include/asm/dma.h
+++ b/arch/arm/include/asm/dma.h
@@ -8,10 +8,12 @@
 #ifndef CONFIG_ZONE_DMA
 #define MAX_DMA_ADDRESS	0xffffffffUL
 #else
+#include <linux/minmax.h>
 #define MAX_DMA_ADDRESS	({ \
 	extern phys_addr_t arm_dma_zone_size; \
 	arm_dma_zone_size && arm_dma_zone_size < (0x10000000 - PAGE_OFFSET) ? \
-		(PAGE_OFFSET + arm_dma_zone_size - 1) : 0xffffffffUL; })
+		min_t(phys_addr_t, (PAGE_OFFSET + arm_dma_zone_size - 1), 0xffffffffUL) : \
+		0xffffffffUL; })
 #endif
 
 #ifdef CONFIG_ISA_DMA_API
-- 
2.25.1

