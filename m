Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9AE4C2902
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 11:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiBXKNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 05:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbiBXKNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 05:13:05 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D6D139CF8;
        Thu, 24 Feb 2022 02:12:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 685C0CE1E81;
        Thu, 24 Feb 2022 10:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942CBC340F0;
        Thu, 24 Feb 2022 10:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645697551;
        bh=8ZHNduwQaNGk2zn8xWtqbbqxqlXAPTPJ/aG+18WOME8=;
        h=From:To:Cc:Subject:Date:From;
        b=amRKZ9ofvfspv5X/pNlxFj9SF68eCdwcBy0fW/5FoDC4DvTbxU0FuGHOjPDCyICRZ
         r90Ad2WNx1isNwt+/K2f4A5SXw8l3mCpf9tVT/e/GjzXaKxo3qZgY4l+4wMoH21ndw
         pMCQSH8X7brTlUgRh3QxkoGqT1il5DBDD0RtTlN83iVdutboxvUPgjBAbRcty9zUvb
         1T0PUYal3aMuUBj5CFF62dNY5Yza/VCJ+n3X1Zl5cbW/zFKu3jQK5Ny8DzMazPBZso
         VrF0A3gqrnjWPDILw2hXj8QGscw/hubu2ErMOhuKxOTArPZGO/5H9kkx0OmyfQ1192
         EgyJ7FWinbIjQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nNB6r-00A979-2w; Thu, 24 Feb 2022 10:12:29 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/5] irqchip/qcom-pdc: Assorted cleanups and fixes
Date:   Thu, 24 Feb 2022 10:12:21 +0000
Message-Id: <20220224101226.88373-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, agross@kernel.org, bjorn.andersson@linaro.org, tglx@linutronix.de, linux-arm-msm@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently noticed the following message at boot time on my Lenovo
c630 laptop (SDM845, if I'm not mistaken):

<quote>
[    1.449499] debugfs: File ':soc@0:interrupt-controller@b220000' in directory 'domains' already present!
</quote>

which is usually the sign of something being amiss (multiple irqdomain
using the same fwnode and not being tagged properly).

Looking closer at the qcom-pdc driver (which is the one triggering the
above warning), I realised that this driver could do with some
cleanups:

- Pseudo hwirq indicating the lack of parent. Not completely wrong,
  but could be done in a more elegant way.

- Two irq domains, which provide the exact same service to the same
  IRQ space. Only the context is different, and the difference is not
  significant.

- Broken locking. You just need the right timing and a driver that
  disables its interrupt.

- A couple of open coded constructs that duplicate stuff the kernel
  already implements.

I've tested this series on the above HW, and nothing broke (suspend
works, interrupts get delivered). If nobody shouts, I'll plan to take
this into 5.18.

Marc Zyngier (5):
  irqchip/qcom-pdc: Kill PDC_NO_PARENT_IRQ
  irqchip/qcom-pdc: Kill non-wakeup irqdomain
  irqchip/qcom-pdc: Kill qcom_pdc_translate helper
  irqchip/qcom-pdc: Fix broken locking
  irqchip/qcom-pdc: Drop open coded version of __assign_bit()

 drivers/irqchip/qcom-pdc.c | 137 ++++++++-----------------------------
 1 file changed, 28 insertions(+), 109 deletions(-)

-- 
2.30.2
