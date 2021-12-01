Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B31464F22
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 14:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349865AbhLANx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 08:53:58 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47122 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349646AbhLANwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 08:52:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2BAFB81F4A;
        Wed,  1 Dec 2021 13:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9497C53FAD;
        Wed,  1 Dec 2021 13:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638366562;
        bh=ubMvbkyG3fbA7PXxZrJzwClBOdnD1Ai0NXgnl6pNNMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SuErtqKszv1Ws220RKzT+tdPCvZw+pV8mEFwqfKVCuxvXEf4meHBrAU81/FZ2UsNq
         oAhsQ9mAhS1usgaB1g7LcJQerUz/qZRuuuSjfFSwvg32drsJTqBDjpo9aAei5Rg4W/
         xnR9h7qUKHHn9MddLigwg/m5pQOtaiIuOwQubeOwmJH2R488JTRs8pl65CFWZwF8wM
         5vOncVz6+PwMIu9kyb7OQli27wtmXXDYEke9UY7iq3QhJgGxMv/Pb8h/8pvYlZh6A2
         KlTxidXQTK1J7OtbtQro7T+xNEQXEyh2vGfW9Zm0VaHh3bUVr02ceuvNSmqL8fS3NM
         2GNrCgo/gJ21A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1msPz6-0098G7-Pl; Wed, 01 Dec 2021 13:49:20 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dougall <dougallj@gmail.com>, kernel-team@android.com
Subject: [PATCH v2 7/8] drivers/perf: arm_pmu: Handle 47 bit counters
Date:   Wed,  1 Dec 2021 13:49:08 +0000
Message-Id: <20211201134909.390490-8-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201134909.390490-1-maz@kernel.org>
References: <20211201134909.390490-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, robh+dt@kernel.org, tglx@linutronix.de, dougallj@gmail.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current ARM PMU framework can only deal with 32 or 64bit counters.
Teach it about a 47bit flavour.

Yes, this is odd.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/perf/arm_pmu.c       | 2 ++
 include/linux/perf/arm_pmu.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 295cc7952d0e..0a9ed1a061ac 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -109,6 +109,8 @@ static inline u64 arm_pmu_event_max_period(struct perf_event *event)
 {
 	if (event->hw.flags & ARMPMU_EVT_64BIT)
 		return GENMASK_ULL(63, 0);
+	else if (event->hw.flags & ARMPMU_EVT_47BIT)
+		return GENMASK_ULL(46, 0);
 	else
 		return GENMASK_ULL(31, 0);
 }
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 2512e2f9cd4e..0407a38b470a 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -26,6 +26,8 @@
  */
 /* Event uses a 64bit counter */
 #define ARMPMU_EVT_64BIT		1
+/* Event uses a 47bit counter */
+#define ARMPMU_EVT_47BIT		2
 
 #define HW_OP_UNSUPPORTED		0xFFFF
 #define C(_x)				PERF_COUNT_HW_CACHE_##_x
-- 
2.30.2

