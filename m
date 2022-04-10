Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C0C4FAFB3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 21:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241315AbiDJTPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 15:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbiDJTPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 15:15:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488EC60D80;
        Sun, 10 Apr 2022 12:13:03 -0700 (PDT)
Date:   Sun, 10 Apr 2022 19:13:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649617981;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJoK25JDofhxRdIrTxLqJwZkQUXucj2lIQYsvAF0X+8=;
        b=jole1FYhyfKKoR5cINqVJ6Ek/jQmDOke3tZ//kEBRTGm7DGKLTFG/WCoMIY8yoTd6C+mm1
        o2icvxnkQySn5EO/4tfYU7uuEUxRLmnSkfCPTv+Ap3+Wr/s4GvSRCgGIA997G5UslDWCzP
        VIVgpvVRlSKCVHFQXlcjL964j/44MIpSXWaWMz25DniNDGdSc+g/FH501gUjaTdBECI4iZ
        iIQUzIgFzmVfafyT9SpckdDEIRFZ4/6qBOqnHT2jsTCRk2ULc7fK0Nm9/JNQcQ0lnSQuZg
        KXY0yFqqnbqPdy8mwdc1k2m0ZJVuxWiJdYsiQVM1Clv1vCi5Z4c0qKG7QmcZcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649617981;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJoK25JDofhxRdIrTxLqJwZkQUXucj2lIQYsvAF0X+8=;
        b=GRecYXDsYkIri9W6Ki84EQ0qTaeQESYddYfEQ2XT32ZGCmrwdcPxh6xIRLBePO+4fvaLuH
        i9TmrcgUX2CDNxAQ==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Shutdown managed interrupts with
 unsatifiable affinities
Cc:     John Garry <john.garry@huawei.com>,
        David Decotigny <ddecotig@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220405185040.206297-2-maz@kernel.org>
References: <20220405185040.206297-2-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164961798087.4207.9105739459698939975.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d802057c7c553ad426520a053da9f9fe08e2c35a
Gitweb:        https://git.kernel.org/tip/d802057c7c553ad426520a053da9f9fe08e2c35a
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 05 Apr 2022 19:50:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 10 Apr 2022 21:06:30 +02:00

genirq/msi: Shutdown managed interrupts with unsatifiable affinities

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
Reported-by: David Decotigny <ddecotig@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: John Garry <john.garry@huawei.com>
Link: https://lore.kernel.org/r/20220405185040.206297-2-maz@kernel.org

---
 kernel/irq/msi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 2bdfce5..a9ee535 100644
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
