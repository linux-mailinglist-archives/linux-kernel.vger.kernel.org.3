Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658E3544A10
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243704AbiFIL1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiFIL1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:27:45 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A5316A520;
        Thu,  9 Jun 2022 04:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1654774064;
  x=1686310064;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bhskym4sqQMSOth67vOfsFUFtLxH4cebU75ziJNIKt4=;
  b=KqH6xDCergcQvqxlnEwkcNL+B4agtQ2M1T8RDtmeiwIsaiDXPpQaV8dh
   u7m+qIt0W5SawDunUAL+zXyZt5FbMjF0RHJm+nPk61KVJhlWgK87xMHEN
   /NtK94K/dSgUCd6aBT80Lw5dphkwmJbiP/B4YnQHVsp/TH2pXIdN9roH4
   XrWlYf3TlJZ5QnVDGGJGarBv3FCNWeDTulG9Od6k43k35FsYNYYMa+Z3E
   KvmbGeDtX5W+4brEkpbaDSZOEKmRTxrJ1Wc/s37fRte98Hxqc1SLR7qL4
   WZUb3iLnYULdSkoobidTfCf51YQVYzozL7yTtuJPgWLWBbfZ49xj5JzJz
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <krzysztof.kozlowski@linaro.org>, <tglx@linutronix.de>,
        <daniel.lezcano@linaro.org>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <alim.akhtar@samsung.com>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: [PATCH v4 0/4] clocksource: Add MCT support for ARTPEC-8
Date:   Thu, 9 Jun 2022 13:27:34 +0200
Message-ID: <20220609112738.359385-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add supports for the timer block on ARTPEC-8.  The block itself is
fully compatible with the existing exynos4210-mct driver.  The ARTPEC-8 SoC
uses this block from two separate processors running Linux (AMP) so it needs
some extra code to allow this sharing.

v4:
- Rebase on v5.19-rc1 where all pre-requisites are merged
- Minor rework of patch 4 as requested, see patch for details

v3:
- Split and rename devicetree properties
- Add vendor prefix to devicetree properties
- Change descriptions of properties to hopefully describe hardware
- Remove addition of more global variables to the driver

v2:
- The series is now rebased on top of Krzysztof's patch "dt-bindings: timer:
  exynos4210-mct: describe known hardware and its interrupts".
- Combine the Kconfig change and the local timer change into one series
- Use devicetree property rather than module parameter for the local timer handling
- Add specific compatible with the correct number of interrupts.

Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Cc: linux-samsung-soc@vger.kernel.org
Cc: alim.akhtar@samsung.com

Cc: devicetree@vger.kernel.org
Cc: robh+dt@kernel.org

Vincent Whitchurch (4):
  dt-bindings: timer: exynos4210-mct: Add ARTPEC-8 MCT support
  clocksource/drivers/exynos_mct: Support frc-shared property
  clocksource/drivers/exynos_mct: Support local-timers property
  clocksource/drivers/exynos_mct: Enable building on ARTPEC

 .../timer/samsung,exynos4210-mct.yaml         | 26 ++++++
 drivers/clocksource/Kconfig                   |  2 +-
 drivers/clocksource/exynos_mct.c              | 83 +++++++++++++++++--
 3 files changed, 101 insertions(+), 10 deletions(-)


base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.34.1

