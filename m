Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489EC508FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381614AbiDTSvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381592AbiDTSvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:51:02 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4C642EEC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:48:16 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c23so2653205plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=LErP8U/PzejnwsS9KxvOA1A5d+doq+yW06k2+06H9yw=;
        b=SrUq1R9xL5OZEC4Ze67UAVTlCaR8u01nNPPk8oP1eppqz7PD0gBzsRZXnuhDevMwsl
         JKPcgMqhBle7UJ1lQpjq81l3IaPYq1YfYIuc22hlfQe+sJEpAGeTpitbhg0M9FoMS6Eb
         JWh7O5Qk/dz8TgOSvZTVv8rfk+D9uarBySHEo1zK+XMILDSzBxe93kfQ/D3iNRSmWyHv
         MrUz5aeweAEgbOxEYUVYklujxkRgWZAP2UNLy2aImjJR3QZW2LwyKanqf0piJX1tCQxW
         p6gg7IVLhUVllO4RYluFhedDiovafl5YmzL0213rDk5ywouSLj4h86NRtxyqUbjVmbcm
         hyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=LErP8U/PzejnwsS9KxvOA1A5d+doq+yW06k2+06H9yw=;
        b=by3P9Idk5D24rIN1lbkIozgGrkUEUMx7EfJf2h5KX1fYfJDATwZuJ8v8PSZ7tDy3K3
         Sq0YFcEuvUp/mJFcpSGNoK3VjneMvdTdHHJoGXvLbD7f1EeoH6KkMFxMYNfcH8Fxcp88
         IIG7XPlhlM2zOIXcprBhkHY/7F5pc283pDWGrxlOQEdbCvRW1IOutLUYkcXkunX+Qles
         AOkZwZ067bu2k5S1ZW2hQlvQUE1mD3gh4ul3LznMYOUfvD6BUuX8fcwbtQNAkh4ySX5f
         eJmjRR/hlGeUJp1xC+qzT0xonhxLlc4KypppffiSSdvNyAo5tRrn99MJrhey5IoyRXBv
         QHJQ==
X-Gm-Message-State: AOAM530uSmK4rHvTTG52aWkFTqZk/epanrEVHom6EmY6rdqrJO3mPxxO
        9/CL8noGTgV+LOXU4H6XAZ9QjDvhCQgpZw==
X-Google-Smtp-Source: ABdhPJwMcgsPdT/Mfw3ofmgGrcnyzn6fQu1hFzXbYaHfj+5RimVQrPpgk9LKR0TuPR+a5veVzb58Yg==
X-Received: by 2002:a17:902:b590:b0:153:a243:3331 with SMTP id a16-20020a170902b59000b00153a2433331mr22836465pls.129.1650480495784;
        Wed, 20 Apr 2022 11:48:15 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id g14-20020a63200e000000b0039d9816238fsm20335794pgg.81.2022.04.20.11.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 11:48:15 -0700 (PDT)
Subject: [PATCH v2 4/4] RISC-V: Fix the XIP build
Date:   Wed, 20 Apr 2022 11:40:56 -0700
Message-Id: <20220420184056.7886-5-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220420184056.7886-1-palmer@rivosinc.com>
References: <20220420184056.7886-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, vincent.chen@sifive.com, guoren@kernel.org,
        Atish Patra <atishp@rivosinc.com>,
        alexandre.ghiti@canonical.com, jszhang@kernel.org,
        vitaly.wool@konsulko.com, gatecat@ds0.me,
        wangkefeng.wang@huawei.com, mick@ics.forth.gr,
        panqinglin2020@iscas.ac.cn, rppt@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org, rdunlap@infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

A handful of functions unused functions were enabled during XIP builds,
which themselves didn't build correctly.  This just disables the
functions entirely.

Fixes: e8a62cc26ddf ("riscv: Implement sv48 support")
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 7bc9a21e29fb..d2054a6cd791 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -660,7 +660,7 @@ static __init pgprot_t pgprot_from_va(uintptr_t va)
 }
 #endif /* CONFIG_STRICT_KERNEL_RWX */
 
-#ifdef CONFIG_64BIT
+#if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
 static void __init disable_pgtable_l5(void)
 {
 	pgtable_l5_enabled = false;
-- 
2.34.1

