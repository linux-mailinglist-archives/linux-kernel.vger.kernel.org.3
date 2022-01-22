Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EB9496CCA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 16:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbiAVPQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 10:16:24 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33944 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbiAVPQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 10:16:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D657B808C4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 15:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C469CC004E1;
        Sat, 22 Jan 2022 15:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642864580;
        bh=S2f6TWIAXyFZZQY51S1BI0oD3vQ3Mobw/lDTLao4niw=;
        h=From:To:Cc:Subject:Date:From;
        b=O2VfXN2MOe9t8ZyCPzbEHGTbEK4SEGuZEVnFrykPJGgNE5WgjPPSJfsKoB2BUekV8
         48OJaEGXiUEiDOjFdkzIwLF5hpM6Vyr0eVTaP7sVdbprhVnPFyH5/OTtlG9Ln/DQXT
         d/iw8oNd0YB6Dopc0lIC/4oDauMKZP24/9cvLBCBT5r2HTgS2q5m2U6fMS9SyMS/oK
         cnvC/ZrdfaFTPddDD7lMOG8hWIMKXkv/OhmiwY7PaQovwaGdlIcsNXA9szd2zpHUPx
         GpTYFK5DoCfVeZ4ml0ckAd++kLvGXfh2IRq8k0mhBamZ6i2OEMnXg99OsIhggxVwFU
         MHDGdMLLmavMA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     maz@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH] irqchip: gic-v3-its: fix build for !SMP
Date:   Sat, 22 Jan 2022 16:16:14 +0100
Message-Id: <20220122151614.133766-1-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1205; h=from:subject; bh=S2f6TWIAXyFZZQY51S1BI0oD3vQ3Mobw/lDTLao4niw=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBh7B+9uYPmJ1Hbc/foLnR4cibQHm+VG/8fPrcl/Ttj Dv1ehdOJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYewfvQAKCRDDTyI5ktmPJHHDC/ 9T9hVFyFkNpCc1tjqWIKhchdUNCnnYtwaNd8Nr5OBCbcoubHUhm/002b3Pbsl/pmfqvIbtWtTXnRDI OLfv/vVQoOsVCKIznkzrZQeBMe4e2u4ai0/y/qAas0SbZ9tpbLTduLHoQMLZHk34hBIyZqHyyAa3/M 39EdithE3dpgN+tAFBRBKl7vRyDKNDN3fjHgCWw+G5xm+coFACL1k+8UFFZrnE5EmJOIe1IFcPsQno cdhvL3T9l3XM/iIJpUwRs7V2JpSJiskWz1/YBN6CjKFi14akvskKGIws/bwuKFwmxN0fU8QO06cz6V h4LOWyjGLBzcUEqCKbsIB47rgMYS1ZNY34NAA0Re5CeUetSWbNm32LfC3kkdyvviFWc+Gm1W9srVW1 ZmnkwLCAt50y3dFH+0Fo8T1tgoZ9F4oDBW7Y4VhfUCJaPn34zt8Y9T8mphdH51zUpYoLwIGCwaE1pm GwW6Kzp033K/A3pIjqpkvLGNqAyqq6fomjBX03aU4dZ5M=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 835f442fdbce ("irqchip/gic-v3-its: Limit memreserve cpuhp state
lifetime") added a reference to cpus_booted_once_mask, which does not
exist on !SMP builds, breaking the build for such configurations.

Given the intent of the check, short circuit it to always pass.

Cc: Valentin Schneider <valentin.schneider@arm.com>
Fixes: 835f442fdbce ("irqchip/gic-v3-its: Limit memreserve cpuhp state lifetime")
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index d25b7a864bbb..d2d61d89c3b8 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5241,7 +5241,8 @@ static int its_cpu_memreserve_lpi(unsigned int cpu)
 
 out:
 	/* Last CPU being brought up gets to issue the cleanup */
-	if (cpumask_equal(&cpus_booted_once_mask, cpu_possible_mask))
+	if (!IS_ENABLED(CONFIG_SMP) ||
+	    cpumask_equal(&cpus_booted_once_mask, cpu_possible_mask))
 		schedule_work(&rdist_memreserve_cpuhp_cleanup_work);
 
 	gic_data_rdist()->flags |= RD_LOCAL_MEMRESERVE_DONE;
-- 
2.30.2

