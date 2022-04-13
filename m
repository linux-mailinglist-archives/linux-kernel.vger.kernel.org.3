Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2424FF03E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiDMG54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbiDMG5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:57:35 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705D02DD72
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:55:14 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p10so1156692plf.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NTNvsaYQsVOBKwXhFRizlr6gNAaZNdWVxUOJaeUiNZE=;
        b=j+3PZTmYmUVLvMaCvmv87lqY2I3xXpgpzEiA42kI+lTOaVCqI+5d7VDErZIGYwhOCT
         pwddTg9Nrtb/asc9nxKYwgf0WETpAqYxYktp8tbEEzOJ1NH2ZcMXGQ9Iq6EPWJfcQ5Wi
         iEZvqxhUpSSuDGXtL0CjHCjdAVHxBbVbNoizO9BpIbCQWDixVOH+D8R49FP6FpW+EchY
         f3u+6v1+GhKtReSPJgYxvj7NxEcNs50Ukf8p3Z/MhUI7p6O6zlQkYRgEo4hjK7B5Z5bs
         qusUb5fxdVYYDRZfk3ZAKoOrMbIMfJDDgQPBnJVpY7dxetqpW1kw/8GCHVrE9e4ZewuT
         WGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NTNvsaYQsVOBKwXhFRizlr6gNAaZNdWVxUOJaeUiNZE=;
        b=rQW/5hulvWtJS+UfbrsFZs2H5d+cD8kTATDwlqjSc8p1qRXBO7FFkEiL7eGJo21fA4
         ux+zZR/r9zHcTErqkEyOXgKHumQZJ5tRlgTA/uF1uLHHNTnREDuYdOueFMbQ4yu6ZA6o
         zM2eab8ZjivJ2QRzqzkfoduk66Uh0qIJKFn9C9Zl6Ujwo8wZJnWlXd0+7aWn+mprPCIC
         KZSBErsgXLH1mRxYgTu9RRQwpSlmTrzs7Ha9SD+PMut5IKP471yhDu8NdxLU+M57o2G3
         L+RDz7ye79EBeX/P6jCGti+pqicbUXpDOaho3ZLjPPkLHuZPZZCHAKjycsprERrAO9ih
         h/0A==
X-Gm-Message-State: AOAM530tfGws3UA1Hx0Dp9Q7x1MhIKgsriJs/6gJFaESy+RqXZHohxiY
        E8EvipxF92gWgvjJIOIni0KDIQ==
X-Google-Smtp-Source: ABdhPJyvFxG274Zs7yDnH2SyWAserZi3+Y7NKJp2WGbghG9SqGQxo7K8enBdXjaEmi/lXRb4P9De2A==
X-Received: by 2002:a17:90a:430d:b0:1bc:f340:8096 with SMTP id q13-20020a17090a430d00b001bcf3408096mr8920797pjg.93.1649832913843;
        Tue, 12 Apr 2022 23:55:13 -0700 (PDT)
Received: from localhost.localdomain ([223.177.215.72])
        by smtp.gmail.com with ESMTPSA id m15-20020a638c0f000000b003827bfe1f5csm4926908pgd.7.2022.04.12.23.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 23:55:13 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, dianders@chromium.org,
        will@kernel.org, liwei391@huawei.com
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com, mhiramat@kernel.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        maz@kernel.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 0/2] arm64: Fix pending single-step debugging issues
Date:   Wed, 13 Apr 2022 12:24:56 +0530
Message-Id: <20220413065458.88541-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes in v2:
- Replace patch #1 to rather follow Will's suggestion.

Sumit Garg (2):
  arm64: entry: Skip single stepping interrupt handlers
  arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step

 arch/arm64/include/asm/debug-monitors.h |  1 +
 arch/arm64/kernel/debug-monitors.c      |  5 +++++
 arch/arm64/kernel/entry-common.c        | 18 +++++++++++++++++-
 arch/arm64/kernel/kgdb.c                |  2 ++
 4 files changed, 25 insertions(+), 1 deletion(-)

-- 
2.25.1

