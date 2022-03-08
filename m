Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED3B4D1A64
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347446AbiCHOZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239921AbiCHOZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:25:21 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199684B1CE;
        Tue,  8 Mar 2022 06:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1646749465;
  x=1678285465;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mFtYJAkI1dCyXIaGgRAGOKTPa8IX45yA6MGULzN9kow=;
  b=beRRryRjerIuKdMAwepncmRoDy4MXHsp5rnUhha3igzazh2rnRaCBZCn
   UE/ebnSeHEDnUnY/n+MRU4BJZNOi9CV6CzGkj2gv9WwA9vbOy1KDGHICF
   G+V8VRz5xOfVA6eK4KsyAM2V7f2AmyzBjOw1UMY4SMKd83elEQlT17Bgk
   HpQ5a/KY/fVkLo5PNs/1FqCnXygx6K2nTDYOqCyQWChY85jbU7h3VAS6M
   VkIDpCgmbbWkaE8d2BXO6HrBJIhMEiADxHOUyGT1bo0qtlClDNWvXNRJO
   u/h9w2TvQ2WUSxStNYWEDFSXjmaXBi/lemcelqbEMU8Zm6Xx2moaDNesf
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <krzysztof.kozlowski@canonical.com>, <tglx@linutronix.de>,
        <daniel.lezcano@linaro.org>
CC:     <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alim.akhtar@samsung.com>, <robh+dt@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH v2 0/4] clocksource: Add MCT support for ARTPEC-8
Date:   Tue, 8 Mar 2022 15:24:06 +0100
Message-ID: <20220308142410.3193729-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add supports for the timer block on ARTPEC-8.  The block itself is
fully compatible with the existing exynos4210-mct driver.  The ARTPEC-8 SoC
uses this block from two separate processors running Linux (AMP) so it needs
some extra code to allow this sharing.

v2:
- The series is now rebased on top of Krzysztof's patch "dt-bindings: timer:
  exynos4210-mct: describe known hardware and its interrupts".
- Combine the Kconfig change and the local timer change into one series
- Use devicetree property rather than module parameter for the local timer handling
- Add specific compatible with the correct number of interrupts.

Vincent Whitchurch (4):
  dt-bindings: timer: exynos4210-mct: Add ARTPEC-8 MCT
  dt-bindings: timer: exynos4210-mct: Support using only local timer
  clocksource/drivers/exynos_mct: Support local-timer-index property
  clocksource/drivers/exynos_mct: Enable building on ARTPEC

 .../timer/samsung,exynos4210-mct.yaml         | 11 ++++++++
 drivers/clocksource/Kconfig                   |  2 +-
 drivers/clocksource/exynos_mct.c              | 25 +++++++++++++++----
 3 files changed, 32 insertions(+), 6 deletions(-)

-- 
2.34.1

