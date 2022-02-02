Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE9094A6ECC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 11:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343571AbiBBKfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 05:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343559AbiBBKfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 05:35:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7994C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 02:35:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 902FFB83081
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 10:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE2BC004E1;
        Wed,  2 Feb 2022 10:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643798102;
        bh=04k9hI1lDL83uVuLeU5l/WfniMS8Cd7uYQ4KJhRhQu0=;
        h=From:To:Cc:Subject:Date:From;
        b=RPKtgAIXtLfW21hCZPmMEQZcY4xTmmOMKEcZgAaRlKyGwjcHfqG2wBu8VjoA3+v2J
         bXdX56iy1NORTssyKzB5eyivpfsFOMyaKMuMiD7MmCIwpXgvtwASlB7YJp+RPfUuhh
         6dzi4Ahq6564XViGh5yYmXZKDzUYPjvRIIyDDTkVLRgRY8ebHbtSMB5ho3omD1Tjqy
         CK/xcmENeczUv9Q21c1z4Ixnw/vYE3e/e/s+NiXUVJxpHzIsC0IeTUGekipeohalkg
         fBVjUZOKpDN9r1JjtKdzTEhHy70DgLbf0vQd/BJZYf+QgZ6MCvyy9Xeq6Oa88vyC5i
         KHtj1thD5GQwA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nFCyZ-004sh4-Q4; Wed, 02 Feb 2022 10:34:59 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        Steev Klimaszewski <steev@kali.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH] irqchip/gic-v3-its: Skip HP notifier when no ITS is registered
Date:   Wed,  2 Feb 2022 10:34:54 +0000
Message-Id: <20220202103454.2480465-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, kernel-team@android.com, steev@kali.org, valentin.schneider@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have some systems out there that have both LPI support and an
ITS, but that don't expose the ITS in their firmware tables
(either because it is broken or because they run under a hypervisor
that hides it...).

Is such a configuration, we still register the HP notifier to free
the allocated tables if needed, resulting in a warning as there is
no memory to free (nothing was allocated the first place).

Fix it by keying the HP notifier on the presence of at least one
sucessfully probed ITS.

Fixes: d23bc2bc1d63 ("irqchip/gic-v3-its: Postpone LPI pending table freeing and memreserve")
Reported-by: Steev Klimaszewski <steev@kali.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 9e93ff2b6375..cd772973114a 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5517,6 +5517,9 @@ int __init its_lpi_memreserve_init(void)
 	if (!efi_enabled(EFI_CONFIG_TABLES))
 		return 0;
 
+	if (list_empty(&its_nodes))
+		return 0;
+
 	gic_rdists->cpuhp_memreserve_state = CPUHP_INVALID;
 	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				  "irqchip/arm/gicv3/memreserve:online",
-- 
2.34.1

