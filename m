Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23434522C11
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239409AbiEKGFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbiEKGFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:05:38 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3089E1D48C8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:05:35 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n18so899237plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=44YMyg+y7+0XOrlHKgxD4Jgi/RkwoC3Hf7YIVT+pqw8=;
        b=J2VgpinATzf5U7v3GD/URBVzDrLE/Be+fgR9/cc4aXckH4EM7tgb2TXnBQideVB1k+
         kt37Ko+I4WOqarmCcufBO1O1Wotbe6EPBDkjDXFWiTgaOdFLZU+NkhVtODWyoJNXskOW
         n4l+pwS5eNofuW4QIqnjKg8FnDu/esyPdST57Ed3+FjNGcGJhcbL+d5MHXvOkC7/zxUm
         PMQ6zMzL0EDqVQj8wWFdXpxIUYzfFWGJiwRow+0K0xV1r53i6iBfVPtWxOuNItoUbBrv
         UGaP8bF96xlAqwPA5HYtA8Iv83CWh0HY3ElzgSZS00M+EoLBshH/fZamoYPHygSjqMi5
         hlLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=44YMyg+y7+0XOrlHKgxD4Jgi/RkwoC3Hf7YIVT+pqw8=;
        b=Jol0tLfuToSwxjjLSb0k7StxXhG+IBOV/enkMRIhvSE4XumWkLPMixXdkKKTEloynU
         JuuyBulw+Zq6U08aQpuvM3g6p8T1gwPmim21312E/3qHXU5brnYSLa2SrJxwfYbHb94E
         lMNxqe/WtiMqIhsCjKZ++cDW5QLGKoOxlDYReBNxqDEmKTitcPdI2pfSkZSbW2EV6xpM
         8vgKBt8XyHYiB/uvRAGeW8gNjFcepeTo3Nd2ZLDid7AVf/PG8HHe8PnriANH7CpsnjMI
         RfqwVRAKad1XqwSlOABgOT5LVPY3xYbBPx76WHs1vOvh7rbzDGXtfw8WQIHyJQqpbwXf
         azGg==
X-Gm-Message-State: AOAM530hV4GRvte5CYpmYJjaUGv8LzBvL09dNpJ8QYHlsX92W+GcUvs/
        RCOp0HCvKcnSgA1fCqAfdditvA==
X-Google-Smtp-Source: ABdhPJxhsdYmiva7DALqPxo/Vq36UUbL0+6lm95RmyP6zL3xnKYPGyymObuicUB3Y981KfqmgTNXKA==
X-Received: by 2002:a17:90a:c908:b0:1dd:1c2e:b1f7 with SMTP id v8-20020a17090ac90800b001dd1c2eb1f7mr3663443pjt.198.1652249134761;
        Tue, 10 May 2022 23:05:34 -0700 (PDT)
Received: from localhost.localdomain ([106.213.2.134])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090a31c700b001d960eaed66sm800216pjf.42.2022.05.10.23.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 23:05:34 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     daniel.thompson@linaro.org, dianders@chromium.org, will@kernel.org,
        liwei391@huawei.com
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com, mhiramat@kernel.org,
        jason.wessel@windriver.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 0/2] arm64: Fix pending single-step debugging issues
Date:   Wed, 11 May 2022 11:35:19 +0530
Message-Id: <20220511060521.465744-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set reworks pending fixes from Wei's series [1] to make
single-step debugging via kgdb/kdb on arm64 work as expected. There was
a prior discussion on ML [2] regarding if we should keep the interrupts
enabled during single-stepping. So patch #1 follows suggestion from Will
[3] to not disable interrupts during single stepping but rather skip
single stepping within interrupt handler.

[1] https://lore.kernel.org/all/20200509214159.19680-1-liwei391@huawei.com/
[2] https://lore.kernel.org/all/CAD=FV=Voyfq3Qz0T3RY+aYWYJ0utdH=P_AweB=13rcV8GDBeyQ@mail.gmail.com/
[3] https://lore.kernel.org/all/20200626095551.GA9312@willie-the-truck/

Changes in v3:
- Reword commit descriptions as per Daniel's suggestions.

Changes in v2:
- Replace patch #1 to rather follow Will's suggestion.

Sumit Garg (2):
  arm64: entry: Skip single stepping into interrupt handlers
  arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step

 arch/arm64/include/asm/debug-monitors.h |  1 +
 arch/arm64/kernel/debug-monitors.c      |  5 +++++
 arch/arm64/kernel/entry-common.c        | 18 +++++++++++++++++-
 arch/arm64/kernel/kgdb.c                |  2 ++
 4 files changed, 25 insertions(+), 1 deletion(-)

-- 
2.25.1

