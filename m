Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C21E46ED38
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbhLIQlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:41:09 -0500
Received: from box.trvn.ru ([194.87.146.52]:52907 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232484AbhLIQlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:41:08 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id C6DF84016B;
        Thu,  9 Dec 2021 21:37:29 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1639067851; bh=N8tokcRkGkUEgrS4jlQxlIHSVtgsxGpTaqS1h2mb4lc=;
        h=From:To:Cc:Subject:Date:From;
        b=yi6N61QarMoBQVbS3Ed4HOfmqG0FoJuzV4dlw6CI12M6ERDdoff+bvKYVLzQYPnew
         7zw2sk6xMtLxsxvO0bucktXOdJeYf6nQdCQbZyoDVdmpjOa1wAwYAss6gUeEA12N+B
         jslyyx+5vcSBQm+138tphWhSQdLjntJl5/WvvFdeBn8eFFW9QPpX6LBOvxmJ53JzhX
         CZiyb3qFF9tXjjnsHHOLtqqc+grSAUpt/b91f/UYcDv30ld9FDpa8CilQkZKloScUu
         eHDEZokj/e73Ms9HvlJI6+nmXXiOMNfZFjrPWWRq7Vyf8KQhSngiJ4fosI0wGNNB2K
         gwKzHSVBDJ5yw==
From:   Nikita Travkin <nikita@trvn.ru>
To:     mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, tdas@codeaurora.org,
        joonwoop@codeaurora.org, svarbanov@mm-sol.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 0/4] Prepare general purpose clocks on msm8916
Date:   Thu,  9 Dec 2021 21:37:16 +0500
Message-Id: <20211209163720.106185-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

[1] - https://lore.kernel.org/lkml/20211209162020.105255-1-nikita@trvn.ru/T/

Nikita Travkin (4):
  clk: qcom: clk-rcg2: Fail Duty-Cycle configuration if MND divider is
    not enabled.
  clk: qcom: clk-rcg2: Make sure to not write d=0 to the NMD register
  pinctrl: qcom: msm8916: Allow CAMSS GP clocks to be muxed
  clk: qcom: gcc-msm8916: Add rates to the GP clocks

 drivers/clk/qcom/clk-rcg2.c            | 11 +++++++-
 drivers/clk/qcom/gcc-msm8916.c         | 35 ++++++++++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-msm8916.c |  4 +--
 3 files changed, 47 insertions(+), 3 deletions(-)

-- 
2.30.2

