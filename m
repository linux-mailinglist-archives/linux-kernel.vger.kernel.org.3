Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D9050A4D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390416AbiDUQAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390408AbiDUQAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:00:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C9141304
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:57:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t6so3890022wra.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 08:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c5v2dcbpfIREeY44tdPJXPJiKXCQO1isQe1PN8hnmtA=;
        b=x7mIAao/XjRhFqxaq69esUVD9gaSAFe7pBZaCn5vqPJ7FGAfIcxMddEd/ZwhipP4xe
         adLF8gMXeI+5Lr2Vr6CL40gna2y9IIhkZ19d1Kk17qzehiOtRLwt0VEWd5VamUDeaQMs
         xzeNByKjw9cAqJpO9CPiyjTLidYUSP84vxCflxxes3yEc40nRsQS7DNzcbMT6FyGVp4A
         ajm565I5vOTyqmV9Vqb9UHeQZhhoHlk9JHUiTrC/fEuvyTkAZ3XGkhwi8Cc75rAs9/qJ
         Brkd+R0DlIuzJ878hwMF9F8pQg9hkmzm8h6EoiAyMKBBplvmBjqaw2Mrq/Fo7uODcUhH
         HGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c5v2dcbpfIREeY44tdPJXPJiKXCQO1isQe1PN8hnmtA=;
        b=rHq5k10BoiCZbm/PPtIKV6DPI82B0DR5NTsjf6b7G58ZnqbnPQ5kZKioTS36LcnW+U
         0QtLU26PI+sWD1P4IVbjoj+QUsOl6Ec+FKn/jlTT4kIzyBrRjH3aMZR84HSK2Uk1Z4VO
         1e6WGplQYN9BqmVWLzQh9n0XWDIghyKkz8bYVZhEW3JG75nqqkXNanr2+M8sNkIeG5dw
         +IWruaAXpA9ulpj4hY8SqLuFoOTEDhwK71jKo3kcAXOsAgKWfbZClJ8a0YKdimlwKW9d
         7Jkf3xjHZMUKI5rNsAidISgfBKs0pYWpNwJHGBPMXvxwEHq2RHs+jCawuVpYApZLTAmW
         H8Ww==
X-Gm-Message-State: AOAM533HG3P4iBhPybUKMvlwqUfjpX2xurKL1Jc58fmL/VM1M1vEitX8
        8J4nTMFYcK9PLqTXKpp7+dW52Q==
X-Google-Smtp-Source: ABdhPJz8PBGJzTWGkvR9SDIvidKwEabWHonllUxUaq2TEm4JZ76WETtMHbtWwFFwMYrsLL0Ek3CKbw==
X-Received: by 2002:a05:6000:713:b0:20a:92f1:c057 with SMTP id bs19-20020a056000071300b0020a92f1c057mr289175wrb.241.1650556651171;
        Thu, 21 Apr 2022 08:57:31 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:35ba:2677:956:980d])
        by smtp.gmail.com with ESMTPSA id 61-20020adf8143000000b002061d8d807esm2623140wrm.87.2022.04.21.08.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 08:57:30 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dmitry Shmidt <dimitrysh@google.com>
Subject: [PATCH 2/2] Revert "ASoC: meson: axg-card: make links nonatomic"
Date:   Thu, 21 Apr 2022 17:57:25 +0200
Message-Id: <20220421155725.2589089-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421155725.2589089-1-narmstrong@baylibre.com>
References: <20220421155725.2589089-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit e138233e56e9829e65b6293887063a1a3ccb2d68 causes the
following system crash when using audio on G12A/G12B & SM1 systems:
 BUG: sleeping function called from invalid context at kernel/locking/mutex.c:282
  in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/0
 preempt_count: 10001, expected: 0
 RCU nest depth: 0, expected: 0
 Preemption disabled at:
 schedule_preempt_disabled+0x20/0x2c
 CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.17.0-rc6-03747-gd403c3588f77-dirty #957
 Hardware name: SEI Robotics SEI610 (DT)
 Call trace:
 dump_backtrace+0xd8/0xf4
 show_stack+0x18/0x30
 dump_stack_lvl+0x70/0x8c
 dump_stack+0x18/0x38
 __might_resched+0x154/0x164
 __might_sleep+0x48/0x78
 mutex_lock+0x24/0x60
 _snd_pcm_stream_lock_irqsave+0x20/0x3c
 snd_pcm_period_elapsed+0x24/0xa4
 axg_fifo_pcm_irq_block+0x64/0xdc
 __handle_irq_event_percpu+0x104/0x264
 handle_irq_event+0x48/0xb4
 ...
 start_kernel+0x3f0/0x484
 __primary_switched+0xc0/0xc8

Revert this commit until the crash is fixed.

Reported-by: Dmitry Shmidt <dimitrysh@google.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 sound/soc/meson/axg-card.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index cbbaa55d92a6..2b77010c2c5c 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -320,7 +320,6 @@ static int axg_card_add_link(struct snd_soc_card *card, struct device_node *np,
 
 	dai_link->cpus = cpu;
 	dai_link->num_cpus = 1;
-	dai_link->nonatomic = true;
 
 	ret = meson_card_parse_dai(card, np, &dai_link->cpus->of_node,
 				   &dai_link->cpus->dai_name);
-- 
2.25.1

