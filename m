Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105915533C4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349905AbiFUNhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351251AbiFUNgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:36:42 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9CB23BED;
        Tue, 21 Jun 2022 06:35:30 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id c2so22463396lfk.0;
        Tue, 21 Jun 2022 06:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V/pJJPQHdhr1X6GXakjW2t24XxjC4Wm3mry4MS1kuhQ=;
        b=A15lnbTyDN1bihZ3NQjR7koVWIn2pcEyi8IoNnhoJJ0ZU9wNrzK6b/HeRmq2pTjkeS
         j0Pz3mZSsEmiOJ81pm7Fm2QQXQ3HUdbIrn55z1AenbwTXA0C0pTnM70DYMPFgnKbwX1P
         agWj6P5CVYesSSQfOia7DbM4846Swcrq1mVwVbUQDcdynEn31M0Rw1nxGvl5sBXKwWPc
         pu96WalvEnGSpe1uTDuhfo+8gcnpY30SUHlJx/xZOOAZeYaaxTRqTCR6HNs5/OUmax/A
         oog57eN5yqGmp5YJnb3hXYNKkrDBQNKy9yNmutBV9z4cYryIHHnVL4Z/BfyaPgbzk6mB
         cWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V/pJJPQHdhr1X6GXakjW2t24XxjC4Wm3mry4MS1kuhQ=;
        b=p25OGoTOaAy84nFm53dzQosgUK1nmGEUXkV2v0/GVNuemHleepJhM1ceaN12PDMUEv
         8i+75OJWH5rlPzU/N4KOtEaXUsjcuRW8reVEEfyWIgt7IWFT0s0W7QbQwLyIG7jyEFoP
         QNS1yzPxc9eAPWnqJuNjmdDICDdS5OgyTxO5K4O26Aj26Dm0QBS7SOYs08txm51MgBTr
         ow0doXfIYLht8ZkpH2pmEFWNX99+/EknUJvWvyt8Xkwx5VHflKlhOe6vTPNLmKt1FW8p
         owjuWbx8hXWPlJXbu5f+STDNSD+/XcHeD8E1dGFtEc0Ial5jNzLJ/dT86/K+Cv1m8k1K
         OLPw==
X-Gm-Message-State: AJIora+HDjqS0o+6mSCa3SswfbIHC/BkrzV8IobqI1webhESOe+81quP
        ELznHECm9v3Qt61lgSWGZS5rmyGaaSe8f5C9
X-Google-Smtp-Source: AGRyM1uOgvRC1Qe3dwS8TCGpEsJjmszOrkvZDUBMkFfrk8xoVEiNxsbB7lk2+ejP577wC8Ag0t5lmA==
X-Received: by 2002:a05:6512:22cf:b0:47f:7b38:73e7 with SMTP id g15-20020a05651222cf00b0047f7b3873e7mr2651904lfu.523.1655818528591;
        Tue, 21 Jun 2022 06:35:28 -0700 (PDT)
Received: from sakura.myxoz.lan (2-248-181-228-no2390.tbcn.telia.com. [2.248.181.228])
        by smtp.gmail.com with ESMTPSA id a16-20020a19ca10000000b00478a8b7ab1csm347142lfg.150.2022.06.21.06.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 06:35:28 -0700 (PDT)
From:   Miko Larsson <mikoxyzzz@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miko Larsson <mikoxyzzz@gmail.com>, linux-kbuild@vger.kernel.org,
        x86@kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Down <chris@chrisdown.name>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>
Subject: [PATCH 2/2] Kconfig: Allow -O3 for all architectures
Date:   Tue, 21 Jun 2022 15:35:26 +0200
Message-Id: <20220621133526.29662-3-mikoxyzzz@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220621133526.29662-1-mikoxyzzz@gmail.com>
References: <20220621133526.29662-1-mikoxyzzz@gmail.com>
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

This commit allows all architectures to use the experimental -O3
optimization option. Previously, only ARC was allowed to use this
option.

Signed-off-by: Miko Larsson <mikoxyzzz@gmail.com>
---
 init/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 9c292acb2..b88613cb5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1403,7 +1403,6 @@ config CC_OPTIMIZE_FOR_PERFORMANCE
 
 config CC_OPTIMIZE_FOR_PERFORMANCE_O3
 	bool "Optimize more for performance (-O3) (EXPERIMENTAL)"
-	depends on ARC
 	help
 	  Choosing this option will pass "-O3" to your compiler to optimize
 	  the kernel yet more for performance.
-- 
2.36.1

