Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0E4516983
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 04:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240798AbiEBDAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 23:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbiEBDAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 23:00:35 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52380DEFD
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 19:57:07 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p12so11368414pfn.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 19:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bxWDbRcGNbfBiVZOS5Mg7GqLQnS0yNnvrGftZ6iHRTU=;
        b=OXusriHnyQ1M56It+EFHe11gDa1XKKY3gvIt8MNW2aR/GOYGxNX6sDPZhGDcE9FvTw
         X47nJd877qh8hkwgtpx+ON4kUxdeEvOYuKy0qr3T6WIdIHBuyXLJIbBfuxN6BBSHE3fK
         d/8HPYCH4ugYzF6xGvVonqZsG47e9VhGDw8qluuhu2WFBC4zfnLaZBRxIycAnzpfrWgK
         Q+XM/KRj7mhLAqNzjfTFRhLP1jcAc4JfZHVYmf+FtVC26h3oDvfQwjzz2thKs8D5f0lR
         uCpLOLyznptZN0yHR7EAg3iwQyO+vkFy4qQ70i3vEa5cLbfzWwZPvQHeWmbNPN38Kcyq
         Qrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bxWDbRcGNbfBiVZOS5Mg7GqLQnS0yNnvrGftZ6iHRTU=;
        b=HSUC9ngpXfboq/UVnkJCU0rHtFgmwigjIsWj+j2tH1nYczfLGf2XhiKgHiige2tFzI
         8QAC8ZASENphx3wiKtzYc1YM0PcZ092qMb/eKV9zHadOKfPTm73tUDbbnWDonFedd/ZD
         t4DhXYmWNZn+N3yUZpREZ68S+BObkmZh4Q+HsXMksbwjsyNy9sjVcYJvi3C0HVF7ra99
         MUbNv7aFpJeeoCuuN0Pr2g8/i//QtvpdkniHlohDckv2RnIYww5T+O4IHRqzr/sYKPIy
         /8JwrsnG2PTSazs7T8M8MOlgenwYzQsv9+HYKSMGS4EfPi9udYNP0GEr1M2eokueP5Zm
         9c6w==
X-Gm-Message-State: AOAM532CAg7rWxdBqMp/LgT8KbBeEo53YMpM01TcDq63ue0SoEZs+R4o
        ihVWDLqadVOh1GAkP/YSRQw=
X-Google-Smtp-Source: ABdhPJwoUi5/Ouj6rosnJWs8sDcix0jHTTOgXNFVt0/4KK/KOEcsC5/HcGp33j53Qlv/icHJIbTwhQ==
X-Received: by 2002:a65:6805:0:b0:3c1:bb28:6bd4 with SMTP id l5-20020a656805000000b003c1bb286bd4mr8177281pgt.585.1651460226819;
        Sun, 01 May 2022 19:57:06 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:fa8:c0d6:ea14:bd48])
        by smtp.gmail.com with ESMTPSA id t3-20020aa79383000000b0050dc762815asm3514694pfe.52.2022.05.01.19.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 19:57:06 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: fix declaration of _SecondaryResetVector_text_*
Date:   Sun,  1 May 2022 19:56:59 -0700
Message-Id: <20220502025659.1695726-1-jcmvbkbc@gmail.com>
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

Secondary reset vector is defined, compiled and used when
CONFIG_SECONDARY_RESET_VECTOR is enabled, not only on SMP.
Make declarations of _SecondaryResetVector_text_* symbols available
accordingly.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/sections.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/include/asm/sections.h b/arch/xtensa/include/asm/sections.h
index a8c42d08e281..3bc6b9afa993 100644
--- a/arch/xtensa/include/asm/sections.h
+++ b/arch/xtensa/include/asm/sections.h
@@ -29,7 +29,7 @@ extern char _Level5InterruptVector_text_end[];
 extern char _Level6InterruptVector_text_start[];
 extern char _Level6InterruptVector_text_end[];
 #endif
-#ifdef CONFIG_SMP
+#ifdef CONFIG_SECONDARY_RESET_VECTOR
 extern char _SecondaryResetVector_text_start[];
 extern char _SecondaryResetVector_text_end[];
 #endif
-- 
2.30.2

