Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C3E580F16
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238323AbiGZIdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiGZIdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:33:36 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABC72F3A8;
        Tue, 26 Jul 2022 01:33:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 6CF94DFD95;
        Tue, 26 Jul 2022 01:33:05 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Q3g532GNHPNk; Tue, 26 Jul 2022 01:33:04 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1658824384; bh=0CIJU3zSyImAICa4IB+pz0lnhOh+ryj8sbHTB94JLEM=;
        h=From:To:Cc:Subject:Date:From;
        b=F4aSqK5kFT4K11jxNfoPfVmCANO6UV0bER52kMqexn3endu9STsOymIupg7mSDZ1t
         AlaXX8+mbXZHI8nurHj+OUMTmZ5+jomwnhuUp6vGkEAYFhkLzNJos0z+xA4rQJd90o
         ONH+cciT1YerEGsjEZABqpjr3zj0WosnQfMWMNzgK7y2JeHVttJ9vfVZzA/lEPcqfw
         ve+pJUiotnLsJcExPuBngpQS87ffYYFDSR/1vfVrln1uUebG6PBKQSfH8N8Tmm2VK8
         YnSvu79p2I43Fp0QoP9eVFWhcoFgmf7BCfYVqStIC0rdbkX+rOzPIfIhGugF1Te/Da
         MKrKg4X4WX1IA==
To:     rafael@kernel.org, khilman@kernel.org, ulf.hansson@linaro.org,
        robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        pavel@ucw.cz
Cc:     kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v6 0/2] power: domain: handle power supplies that need interrupts
Date:   Tue, 26 Jul 2022 10:32:55 +0200
Message-Id: <20220726083257.1730630-1-martin.kepplinger@puri.sm>
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

This makes available a new genpd flag GENPD_FLAG_IRQ_ON in a relatively
generic way:
genpd providers can set it when irqs are needed to manage power on/off.
Since the main goal here has been to fix systemd suspend/resume,
adjusting these callbacks is all that's being done when this flag gets set.

And since I'm working on imx8mq, the 2nd patch makes gpcv2 set this new
flag when a power domain has a power-supply described in DT.
For i.MX8M* platforms, this should be ok. For other platforms this might
be useful too but needs to be tested.


revision history
----------------
v6: (thank you Ulf and Lucas)
* drop the cleanup patch to use BIT()
* use of_property_read_bool() to find the power-supply
* clean up the callback assignment
* remove the wrong error printing
  (flag-check can be added later to *drivers* that have noirq callbacks)

v5: (thank you Lucas)
* simplify gpcv2 code: just set GENPD_FLAG_IRQ_ON when a power-supply is present
https://lore.kernel.org/linux-arm-kernel/20220721043608.1527686-1-martin.kepplinger@puri.sm/

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



Martin Kepplinger (2):
  power: domain: handle genpd correctly when needing interrupts
  soc: imx: gpcv2: fix suspend/resume by setting GENPD_FLAG_IRQ_ON

 drivers/base/power/domain.c | 13 +++++++++++--
 drivers/soc/imx/gpcv2.c     |  3 +++
 include/linux/pm_domain.h   |  5 +++++
 3 files changed, 19 insertions(+), 2 deletions(-)

-- 
2.30.2

