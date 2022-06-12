Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AA9547A98
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbiFLPAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236607AbiFLPAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:00:20 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C1249C99
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 08:00:18 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 077A041B15;
        Sun, 12 Jun 2022 20:00:13 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1655046015; bh=w9CeVCi+C6BJG8uInBNRrAT0+x3UqfgtsSmbk8rXYyI=;
        h=From:To:Cc:Subject:Date:From;
        b=VPXZgUMf6URdbfWbGQGXDt9/+jo62ilVeSUKuUaIPF+qZDJns7/4GF5BuSCC24QfD
         XCyj5kfFVcpA/XZrGfikjqeK/3JO93x8SOHQ9/SWObRDVy/ZN/FI1VbNfa7qSMqUJw
         ooXoiW5F86OTu9N2v46jJrq4duafrX/tK/je9jloHVTIL+zO35Xi+lalg8DaDaKAl6
         H63R5vVV8UJB35mZtiDhJJHcz93ulmKEjlH1WR6SZMy9Cbxcj0bgS+Z4qo2C+97/xw
         rBziGdNBQ7i6tJ9eh/oWcjMFcQI4HsLGLfZbOpSWE2lc4rNQV1pxwd9phE84147vN/
         hn3K/sig7ZzUQ==
From:   Nikita Travkin <nikita@trvn.ru>
To:     mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, tdas@codeaurora.org,
        joonwoop@codeaurora.org, svarbanov@mm-sol.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v2 0/4] Prepare general purpose clocks on msm8916
Date:   Sun, 12 Jun 2022 19:59:51 +0500
Message-Id: <20220612145955.385787-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices make use of general purpose clocks as PWM outputs by
controlling their duty cycle.

Notably, many devices (e.g. Samsung A3/A5, LG G Watch R and probably
many others) use clock based PWM to control the haptic feedback,
some other can control backlight or flash/torch LED brightness.

As a follow-up to a proposed clock based PWM output driver [1],
this series contains various fixes to make it useful on msm8916
based devices.

[1] - https://lore.kernel.org/lkml/20220612132203.290726-1-nikita@trvn.ru/T/#t

Changes since v1:
 - Use clamp() instead of two boundary checks

Nikita Travkin (4):
  clk: qcom: clk-rcg2: Fail Duty-Cycle configuration if MND divider is
    not enabled.
  clk: qcom: clk-rcg2: Make sure to not write d=0 to the NMD register
  pinctrl: qcom: msm8916: Allow CAMSS GP clocks to be muxed
  clk: qcom: gcc-msm8916: Add rates to the GP clocks

 drivers/clk/qcom/clk-rcg2.c            | 16 +++++++++---
 drivers/clk/qcom/gcc-msm8916.c         | 35 ++++++++++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-msm8916.c |  4 +--
 3 files changed, 49 insertions(+), 6 deletions(-)

-- 
2.35.3

