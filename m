Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA75499BD3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 23:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576717AbiAXV4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 16:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449996AbiAXVRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 16:17:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96958C067A6D;
        Mon, 24 Jan 2022 12:12:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B37D6137A;
        Mon, 24 Jan 2022 20:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D139DC340EB;
        Mon, 24 Jan 2022 20:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643055160;
        bh=byMO3nYSC2TvSH32oHHrAxbZ7HoV85bYK3g6rU+Vckk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ebm4MB3E88Yqn7BvQzfMhMEsishhVM9UX7r3FPZu846+SL16XmVkZHDFFbeOw/RS9
         TWWh5aN2GJa/EBJPnVKVQyVHCEiEN+t9tqlBHiUXiznH51+NefoYO/vDxfMVtDU+Hy
         /aYkJL44EeYBfkj1HjzdzSrRLARG5NjUu/O/NJ3/3uiyNTzZgsl1PlhTh4/4pxuTe/
         K76MRh7c5RfUO/EgezAlJNQoo89bSIFXn80CR50EIkCRvbTR45TFXXKCuedF3mUVuG
         dgGYhI5GT/gtzT9eqsWjkPHE+c/uEmFWYa6I5pfHj+4ShNIcjkpkXTNiBMC3CcgOC1
         K2lDT3qIKpfoA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nC5hf-002Y3f-07; Mon, 24 Jan 2022 20:12:39 +0000
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
Subject: [PATCH v4 09/10] drivers/perf: arm_pmu: Handle 47 bit counters
Date:   Mon, 24 Jan 2022 20:12:30 +0000
Message-Id: <20220124201231.298961-10-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124201231.298961-1-maz@kernel.org>
References: <20220124201231.298961-1-maz@kernel.org>
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

Reviewed-by: Hector Martin <marcan@marcan.st>
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

