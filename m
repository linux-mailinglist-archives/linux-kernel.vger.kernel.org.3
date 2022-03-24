Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6A14E6824
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 18:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352417AbiCXRz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 13:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352397AbiCXRzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 13:55:55 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF4E3968C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:54:23 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id mp11-20020a17090b190b00b001c79aa8fac4so2778168pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 10:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gm+N+de+ywCT6zySGwW3DpE5hrvwRPG1W5+NjCS8u20=;
        b=LANaYHwar9TlXM6EfRwBq1ZGJHXeEamyb40OwWw1/pRque7M/nmxIWLW1h602zyd02
         ou3oBNg+VlwVaOZjpAi8Yrk6OVg4UJ3quiBegvOWOgh1LcYH8z+9SOp+MTqeOG5MfkN/
         WiapD9HDIw9YKPcyLie6Grz1Fv5F8Dk5oBJdBp2PtlBOEmQatdMxckDk0xACYcD1Tauy
         DFlUFju5KRrnUCdof7RYpNjNFBGmQMUeIfeHKtgBuY1WxRopGF55VMwE1PVdYFXEihYV
         5qywqlx+iQlqAbu2c2E2aVEsuPpL9/7jIZr3pEypEbS2ci9Fppn9C4mUIG7JgRpnmrV0
         S8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gm+N+de+ywCT6zySGwW3DpE5hrvwRPG1W5+NjCS8u20=;
        b=Ooyjl+9DFmFcrJLSZ7O9pFX3PU5vh2WbTywNfZiorZcEK5CdBks5330iRqh0UxsmQP
         gjVN765cLOwwjoN+nWK7WlU8unkC3vocLyu77RMDx0q5+7wIsDIV8/6+JF8CokeAedrq
         ivSTFG67NtoQUxFD/6vzBlGZSg142+cJN0f+ONgeYQ7NUYUPl7EYbvnK4B18p4DB0QkK
         PynwQNe2YLBe7Sn2xuwdfB4mCEyNwFoJAxQTRKtSKUfZ2Ybrq7OKxpIyuUAqxLYKBj/h
         dFUOkdPfgI0CX4blAPP6rfsUBvpZOezsJzlAtvkWSHNP2lFbvkyX/i4TZFPk40/ZCbbE
         Kyww==
X-Gm-Message-State: AOAM532VoDeQo5EEL5eyAksXqVcMRPZhqF+PZ+ET1cAFyq3hRJDyzQp2
        WztaLNF8+CiVxc0GFB9i2sg=
X-Google-Smtp-Source: ABdhPJzAAuA5N8ACSqo+esBu2LrJPnNgvZu+UoLuWbJMrahfS/0XVVqmttHSUrbeiOqcJc9rJTtp3A==
X-Received: by 2002:a17:903:244b:b0:154:2cb2:86d with SMTP id l11-20020a170903244b00b001542cb2086dmr7081997pls.123.1648144462674;
        Thu, 24 Mar 2022 10:54:22 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f21-20020a056a00239500b004fb02a7a45bsm1003193pfc.214.2022.03.24.10.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 10:54:22 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org (open list),
        linus.walleij@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 1/2] ARM: Fix off by one in checking DMA zone size
Date:   Thu, 24 Mar 2022 10:54:16 -0700
Message-Id: <20220324175417.1014562-2-f.fainelli@gmail.com>
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

The maximum DMA address is PAGE_OFFSET + arm_dma_zone_size - 1, fix this
by doing the appropriate subtraction.

Fixes: 650320181a08 ("ARM: change ARM_DMA_ZONE_SIZE into a variable")
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/asm/dma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/dma.h b/arch/arm/include/asm/dma.h
index a81dda65c576..f244ee68e814 100644
--- a/arch/arm/include/asm/dma.h
+++ b/arch/arm/include/asm/dma.h
@@ -11,7 +11,7 @@
 #define MAX_DMA_ADDRESS	({ \
 	extern phys_addr_t arm_dma_zone_size; \
 	arm_dma_zone_size && arm_dma_zone_size < (0x10000000 - PAGE_OFFSET) ? \
-		(PAGE_OFFSET + arm_dma_zone_size) : 0xffffffffUL; })
+		(PAGE_OFFSET + arm_dma_zone_size - 1) : 0xffffffffUL; })
 #endif
 
 #ifdef CONFIG_ISA_DMA_API
-- 
2.25.1

