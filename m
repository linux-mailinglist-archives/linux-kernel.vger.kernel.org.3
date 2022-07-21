Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3006457C395
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 06:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbiGUEhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 00:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiGUEhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 00:37:37 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199487AB2F;
        Wed, 20 Jul 2022 21:37:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 59FF4DFFA0;
        Wed, 20 Jul 2022 21:36:43 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UzK8WlnFj0S6; Wed, 20 Jul 2022 21:36:42 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1658378202; bh=ZFOL7yrrCkugJn9Il2E109WmveIIj3yyKsNUvMgVJ00=;
        h=From:To:Cc:Subject:Date:From;
        b=ss1B0T8D/3eORrO1Ag26DhqWwnbHiNjI0bf4aN488AHkWj1xkaiLmT2YytfJMeubL
         RZ7Z4aiLqxGbNXAE5CDyeyUIGcyX0K7l0xUW5VQPZNV5HE0eX8AyYml/1nZF5BH4cf
         jpcJomFhayN6ifhCYRuQyzqDy0qvnLkBThvJopwDOw6ARdJ1t+fRxQpT8RRt2fkNHP
         c78ViuMjkRAflZKDV3p5iJ9ybcRGKzEQoBcZVI4nYxCXl0hhXxqVwUG4DKW9NitRay
         +7kYuHmXqFvnroSaeVkZanLZw9JI6CxI8zYhMCBJIA9bfGiW0QBWFsC6jo1YxijyAP
         tGwshl5C0WYQA==
To:     rafael@kernel.org, khilman@kernel.org, ulf.hansson@linaro.org,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        pavel@ucw.cz
Cc:     kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v5 0/3] power: domain: handle power supplies that need interrupts
Date:   Thu, 21 Jul 2022 06:36:05 +0200
Message-Id: <20220721043608.1527686-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Ulf, Lucas and all interested,

This (after a cleanup patch) makes available a new genpd flag
GENPD_FLAG_IRQ_ON in a relatively generic way: genpd providers can set
it when irqs are needed to manage power on/off. Since the main goal
here has been to fix systemd suspend/resume, adjusting these callbacks
is all that's being done when this flag gets set.

And since I'm working on imx8mq, the 3rd patch makes gpcv2 set this new
flag when a power domain has a power-supply descirbed in DT.
For i.MX8M* platforms, this should be ok. For other platforms this might
be useful too but needs to be tested.


revision history
----------------
v5: (thank you Lucas)
* simplify gpcv2 code: just set GENPD_FLAG_IRQ_ON when a power-supply is present

v4: (thank you Ulf and Lucas)
* split up genpd core and gpcv2 changes
* set callbacks inside of pm_genpd_init()
* make flag name and description a bit more generic
* print an error in __genpd_dev_pm_attach() if there a "mismatch"
https://lore.kernel.org/linux-arm-kernel/20220720043444.1289952-1-martin.kepplinger@puri.sm/T/#t

v3: (thank you Ulf)
* move DT parsing to gpcv2 and create a genpd flag that gets set
https://lore.kernel.org/linux-arm-kernel/20220718210302.674897-1-martin.kepplinger@puri.sm/

v2: (thank you Krzysztof)
* rewrite: find possible regulators' interrupts property in parents
  instead of inventing a new property.
https://lore.kernel.org/linux-arm-kernel/20220712121832.3659769-1-martin.kepplinger@puri.sm/

v1: (initial idea)
https://lore.kernel.org/linux-arm-kernel/20220711094549.3445566-1-martin.kepplinger@puri.sm/T/#t

Martin Kepplinger (3):
  PM: domain: fix indentation and use BIT macro for flags
  power: domain: handle genpd correctly when needing interrupts
  soc: imx: gpcv2: fix suspend/resume by setting GENPD_FLAG_IRQ_ON

 drivers/base/power/domain.c | 13 +++++++++++++
 drivers/soc/imx/gpcv2.c     |  3 +++
 include/linux/pm_domain.h   | 20 +++++++++++++-------
 3 files changed, 29 insertions(+), 7 deletions(-)

-- 
2.30.2

