Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76C957B008
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 06:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbiGTEgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 00:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGTEgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 00:36:04 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B5920F7B;
        Tue, 19 Jul 2022 21:36:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id A7160DF476;
        Tue, 19 Jul 2022 21:35:33 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EsG6Ij7e3Hjh; Tue, 19 Jul 2022 21:35:32 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1658291732; bh=Z395XdMnc9/hxp6HWecS680NJldQ34bRG9DAfW63U9Q=;
        h=From:To:Cc:Subject:Date:From;
        b=sizWD/b4xrs4MtrW1YRj/Mo4yhbLDlLLBhDjl14d0uv1ru2YgnUOI0vQAR9OMurqr
         9MJN37bGSLCdNacbzfyYOZpfCOE7xlN74zP0D0hMtLTyDUGl2QliTH+u94lfqzVIBR
         2SbtQTro1rImKW3WICY0M4fb2LcbdmVT8+SKE3OHz1VE3XlQT22vCO5aEPHyAL+x0/
         oi/WFenzLS01SfiToNADfE0hl+HyGEaEXjX3V6pRYws1T+d+lZlBRAyb9p86HZJGbx
         ZWM3To6DHKO9oPyJWpXNk952fiNbBNyD+hArpWPkcuRtiSq1/oEAqhg3SNe2NjeEnH
         g5EZM0eVT6bSQ==
To:     rafael@kernel.org, khilman@kernel.org, ulf.hansson@linaro.org,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        pavel@ucw.cz
Cc:     kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v4 0/3] power: domain: handle power supplies that need interrupts
Date:   Wed, 20 Jul 2022 06:34:41 +0200
Message-Id: <20220720043444.1289952-1-martin.kepplinger@puri.sm>
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
flag when any power-supply's parent DT node has "interrupts" described.
For i.MX8M* platforms, this should be ok. For other platforms this might
be useful too but needs to be tested.


revision history
----------------
v4: (thank you Ulf and Lucas)
* split up genpd core and gpcv2 changes
* set callbacks inside of pm_genpd_init()
* make flag name and description a bit more generic
* print an error in __genpd_dev_pm_attach() if there a "mismatch"

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
 drivers/soc/imx/gpcv2.c     |  9 +++++++++
 include/linux/pm_domain.h   | 20 +++++++++++++-------
 3 files changed, 35 insertions(+), 7 deletions(-)

-- 
2.30.2

