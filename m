Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212AD4D073C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 20:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244962AbiCGTHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 14:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237523AbiCGTHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 14:07:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734526E7B8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 11:06:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D30F8CE1184
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 19:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5584C340E9;
        Mon,  7 Mar 2022 19:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646680001;
        bh=XhUorjNUp2ro6l4CdTfTZVWn0r9yRVs9vs9fCjrsIjM=;
        h=From:To:Cc:Subject:Date:From;
        b=LqvAlHWOTZvvwAZ1hWYS7UpMeLTuh0Hs0pF9I0QokztUB53pzphXWS3ig00bNW80Q
         6pmLDBnPTCDnkobK8VRx7RX8cxhUcwEDtPUgijVmhmLpzQ2A8zjnflpz4jB1asQ15G
         Q0RaETofEeWmA+PBwr4/6Ow/MaKzKnxCmqCd70ZtUA7pQx1OtGfwBXhnWRDabNVTdS
         Vs6ekc3NSHP31qDTFIniN8oQ1IKBUtC9mVV1ZdIYz7DnPAI9MxI07vvBX0PYiozHaB
         iigGI4UGzq7H26x5rusLQwWtZpkx8jGik7Y5q5WI/CUIpDCVh4GikBsoiFC6XuaEwB
         h9aH+wFv7LIzg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nRIgp-00CsDZ-Eg; Mon, 07 Mar 2022 19:06:39 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>,
        David Decotigny <ddecotig@google.com>
Subject: [PATCH] genirq/msi: Shutdown managed interrupts with unsatifiable affinities
Date:   Mon,  7 Mar 2022 19:06:25 +0000
Message-Id: <20220307190625.254426-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, john.garry@huawei.com, ddecotig@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

In order to deal with this, do not try to activate such interrupt
if there is no online CPU capable of handling it. Instead, place
it in shutdown state. Once a capable CPU shows up, it will be
activated.

Reported-by: John Garry <john.garry@huawei.com>
Reported-by: David Decotigny <ddecotig@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 kernel/irq/msi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 2bdfce5edafd..aa84ce84c2ec 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -818,6 +818,18 @@ static int msi_init_virq(struct irq_domain *domain, int virq, unsigned int vflag
 		irqd_clr_can_reserve(irqd);
 		if (vflags & VIRQ_NOMASK_QUIRK)
 			irqd_set_msi_nomask_quirk(irqd);
+
+		/*
+		 * If the interrupt is managed but no CPU is available
+		 * to service it, shut it down until better times.
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
2.30.2

