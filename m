Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBE34F4C3B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbiDEXNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573309AbiDESwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 14:52:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D74B1AA3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 11:50:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F042B618DE
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E675C385A0;
        Tue,  5 Apr 2022 18:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649184645;
        bh=9v4RqTFBMhIkEMkcdqjBprzzsU8Kal+EmgXjHs9Hfvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8cbUPZf+01/VPHkKaT4bjtrcbCTPE/ZabeIa9eTs4fyYuli/cUP8iQoLAWxzxkNl
         rHXogKRj2emil3DSJYuRhHhLeNBKsBHQHk4qhR/uuL2StPZsxFb5wWXMgk4U/DdlgR
         dfY99/C99VG5URZEklSy5J9kJgJBRjq0ytC2SFGM559ZyEaq+MMEmFQWOK3C3ymhsn
         fuiG9Y5L09kNj0ICIVf10hPLNcSIRqKp5pVxAvwvn0j3HRGolA3OgadYItGNfABf+O
         MOShxM/ZaPCf1y81V96V9FZTiQJApA4VJ+I72ukQVcbl4rzRBOaLsIwfIeq6oy2P8s
         erqd7vDKfYAfQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nboGJ-001tpg-5z; Tue, 05 Apr 2022 19:50:43 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        David Decotigny <ddecotig@google.com>
Subject: [PATCH v3 1/3] genirq/msi: Shutdown managed interrupts with unsatifiable affinities
Date:   Tue,  5 Apr 2022 19:50:38 +0100
Message-Id: <20220405185040.206297-2-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220405185040.206297-1-maz@kernel.org>
References: <20220405185040.206297-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, john.garry@huawei.com, wangxiongfeng2@huawei.com, ddecotig@google.com
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

When booting with maxcpus=<small number>, interrupt controllers
such as the GICv3 ITS may not be able to satisfy the affinity of
some managed interrupts, as some of the HW resources are simply
not available.

The same thing happens when loading a driver using managed interrupts
while CPUs are offline.

In order to deal with this, do not try to activate such interrupt
if there is no online CPU capable of handling it. Instead, place
it in shutdown state. Once a capable CPU shows up, it will be
activated.

Reported-by: John Garry <john.garry@huawei.com>
Tested-by: John Garry <john.garry@huawei.com>
Reported-by: David Decotigny <ddecotig@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 kernel/irq/msi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 2bdfce5edafd..a9ee535293eb 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -818,6 +818,21 @@ static int msi_init_virq(struct irq_domain *domain, int virq, unsigned int vflag
 		irqd_clr_can_reserve(irqd);
 		if (vflags & VIRQ_NOMASK_QUIRK)
 			irqd_set_msi_nomask_quirk(irqd);
+
+		/*
+		 * If the interrupt is managed but no CPU is available to
+		 * service it, shut it down until better times. Note that
+		 * we only do this on the !RESERVE path as x86 (the only
+		 * architecture using this flag) deals with this in a
+		 * different way by using a catch-all vector.
+		 */
+		if ((vflags & VIRQ_ACTIVATE) &&
+		    irqd_affinity_is_managed(irqd) &&
+		    !cpumask_intersects(irq_data_get_affinity_mask(irqd),
+					cpu_online_mask)) {
+			    irqd_set_managed_shutdown(irqd);
+			    return 0;
+		    }
 	}
 
 	if (!(vflags & VIRQ_ACTIVATE))
-- 
2.34.1

