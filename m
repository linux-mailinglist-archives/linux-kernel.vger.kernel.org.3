Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374FB5718A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiGLLeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbiGLLeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:34:08 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B3EAB6AC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:34:07 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id l124so7232439pfl.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oyv6ls5n5LtXZ+eFrLN0Kgir8c8eeeHctyKmi21xDfU=;
        b=AyZLVnJOfk8Tv6TtGpOoeRkeSR/b2bV4cgBFR+EBkHCgQMDbETZffoXTdHDIUPNu9w
         MPceWlvtTUpd2Il2fH9qVvKyKGmHid9Ubmmx11ImERS2dK8RJMsD/jHRXt9qjLKyqbqB
         Ye28s/LK71UsY72Kl4jB7XGuGUGKLQHFCfvN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oyv6ls5n5LtXZ+eFrLN0Kgir8c8eeeHctyKmi21xDfU=;
        b=cY5KAzyHMEtYArWD/6HV+M+vpHywiqQwHtSwHq5FoPpa7Hdj1wmT3PcTPSwJrkkPjL
         226Yg8Qyh3W5O+3I2tl9TtNNS4jAfAHUb/Ka7gelRBXJdcee1hgPGIxVqMr10akMuAz8
         FFZ+6sC9yy4gIHoj0VjZIYodL/7LGG4/nHq+CWLGlRrPSwr+aIjjWmmU6u3lvaGKy5cm
         npn3Ji6A7bOwYdQ9E8sI1d8w/MzigfoBpQwpIFPi1Zsn8K6/+PA52eBN4GSvIfqWjn9p
         aUUxtJokd2WfwaE6x7mTnU4TQ+WbfYZ8eOQBG/y3ELkNzvz3sMAINkt1Hpwl+/YuRXxp
         RQ7w==
X-Gm-Message-State: AJIora/39Oj29oojdouCTaNfDqb7BzbcGxGStJIVRIJ41/fUcDyaphkS
        epbmGjIaCNb44Hsz72ry3Ofs+s0ap8PJxg==
X-Google-Smtp-Source: AGRyM1treUZQGKzP/srWrhQQXfnWw5A2LzmcIyergVoaqHN/hKKC5TFTd7y1OL9WwsehvALKJwR1NA==
X-Received: by 2002:a63:5b16:0:b0:416:1b3b:9562 with SMTP id p22-20020a635b16000000b004161b3b9562mr5669714pgb.146.1657625647430;
        Tue, 12 Jul 2022 04:34:07 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:d1a9:ca7d:e86f:cf6f])
        by smtp.gmail.com with ESMTPSA id 80-20020a621653000000b0052890d61628sm6537967pfw.60.2022.07.12.04.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:34:06 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
Subject: [PATCH 0/2] clk: Fix CLK_OPS_PARENT_ENABLE and runtime PM
Date:   Tue, 12 Jul 2022 19:34:00 +0800
Message-Id: <20220712113402.871838-1-wenst@chromium.org>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike, Stephen,

Here are a couple fixes for the clk core. They are unrelated but overlap
in diff context, so I'm sending them together.

Patch 1 makes the clk core honor CLK_OPS_PARENT_ENABLE for clk gate ops.
Without this, dumping clk_summary on the MT8192 would cause the system
to hang.

Patch 2 reorders the runtime PM call in clk_core_unprepare() to match
the order described in its original commit, and the opposite of that
in clk_core_prepare().


Regards
ChenYu

Chen-Yu Tsai (2):
  clk: core: Honor CLK_OPS_PARENT_ENABLE for clk gate ops
  clk: core: Fix runtime PM sequence in clk_core_unprepare()

 drivers/clk/clk.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

-- 
2.37.0.144.g8ac04bfd2-goog

