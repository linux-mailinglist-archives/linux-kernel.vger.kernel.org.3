Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C6B4DADF2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355067AbiCPJ4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355048AbiCPJ4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:56:15 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3F046B1B;
        Wed, 16 Mar 2022 02:54:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s11so3289721pfu.13;
        Wed, 16 Mar 2022 02:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sSsdnbeFBGRpAHEWScvJp+8IqsMrONhOglatDZMGi28=;
        b=DfFTiQfqkJ+JM7CvK9dJwjCu7rirFCJeUv7VHYndMvlHDQjnm5aCtsyvR1b1C5Jnd6
         38AmWZXPahEZgCFCdqmiRDMaUIgl9KzaewRuqhEh9uuHnw/0LYqmRNmK/fv4yV8/yqGM
         QOnXrNX5bejZ5sXn4HntfJctIIMDnrnrv+fFcQ/6SOhDlWIw0YKbZFIicN1EyVnWin9O
         yluELGNNFKynQ6mrkXjg4mYsRUL+grzMSei0gNgdVZHsxzPrtv6Sv+JUSm1FEyNgKksM
         tbkti8RWvyT7Zy++3CzTIFzLJdJb/ErTpTFsMGOO30/nLrcR/CTEYJ4UhEjAysSWVmCz
         DazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sSsdnbeFBGRpAHEWScvJp+8IqsMrONhOglatDZMGi28=;
        b=FRajm1ge9ht9B45tzhMzvIoaEQBQi/slCebm6D9iHIuPRYPNLB7a1H7NQdBvOHYTGE
         HmXWMWBuoUrD5nZYahYRrQDpfe+5SUYMk+jx3llvgqaNMwMuGn3CxuKQ45cwKRLCSzjP
         BlRO/CDAbRDPvFHCZ5dxSigjikdtoZNd7iuVmY4fnyOhzSWfyZp3TnEbNTM6d75KnPUM
         gHXYZHVvihoUFXUQhSMUUjT6IoM06l22qSqKmlkqjfSar12P1JsFmmnKV/Vng5POHaAC
         tV1ZfuZWtdsaGrIIQae6rmnWIVJgpCjUa12pCVdByZdEkPm/RaxKfA/xfpE1lHJQGyTh
         O2kg==
X-Gm-Message-State: AOAM530NOA33b/aqwXN7UiB23VDw8uweQ9uoECYQOoCJfmJITMTOHrqK
        AkGtuxUy4Wa5sfZ0jH5mx6w=
X-Google-Smtp-Source: ABdhPJyDCctCLEh3Xon/NQ2FnvCPoNDq0IZjmtHGxKdpGMSs3wCa80O68QSAJ8XuCfhwXaW2V3UpRA==
X-Received: by 2002:a63:4d5a:0:b0:381:eef7:33f8 with SMTP id n26-20020a634d5a000000b00381eef733f8mr1143310pgl.193.1647424496523;
        Wed, 16 Mar 2022 02:54:56 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id a22-20020a056a000c9600b004f7b8b3a44csm2567070pfv.29.2022.03.16.02.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 02:54:56 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: [PATCH 3/3] clocksource: arch_timer: Add arm,cortex-a7/15-timer in of_match list
Date:   Wed, 16 Mar 2022 15:24:32 +0530
Message-Id: <20220316095433.20225-4-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316095433.20225-1-singh.kuldeep87k@gmail.com>
References: <20220316095433.20225-1-singh.kuldeep87k@gmail.com>
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

Few platforms such as Renesas RZ/N1D, Calxeda, Alpine etc. are using
arm,cortex-a15-timer and arm,cortex-a7-timer entries in conjugation with
arm,armv7-timer which are not currently defined in driver file. Add
these entries in arch_timer_of_match list to bring them in use.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 drivers/clocksource/arm_arch_timer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 1ecd52f903b8..805e60c09916 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1266,6 +1266,8 @@ static int __init arch_timer_mem_register(void __iomem *base, unsigned int irq)
 static const struct of_device_id arch_timer_of_match[] __initconst = {
 	{ .compatible   = "arm,armv7-timer",    },
 	{ .compatible   = "arm,armv8-timer",    },
+	{ .compatible   = "arm,cortex-a7-timer",    },
+	{ .compatible   = "arm,cortex-a15-timer",    },
 	{},
 };
 
-- 
2.25.1

