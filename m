Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500BA470B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343884AbhLJT6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343749AbhLJT5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:57:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82F5C0617A1;
        Fri, 10 Dec 2021 11:54:09 -0800 (PST)
Date:   Fri, 10 Dec 2021 19:54:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639166048;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eli+i8B3YqwyV5fufQoUmaaoGq+yqffRRuPCsYwCP04=;
        b=wd4PPVoMv8cPcrgDHJR3g9Og8SfHJZLyTcwhvVL1gOys0muPmCwkU+Ch3EfLgUKlRDWjom
        l61EfAPsAQx/7OF6/3IEkVHsQgdXag3SsFAb51ggbX2k/MRbXX3BOMuAliEV30EUZHShTl
        rgxpaLcjsdM60GQdgjp75EO7qla0jJLg0qLTVfo9OsV7uUJzxA4FR9Zkwy7QHOF0+aKqJ7
        0lRRxjFPaVyBd4Gg+sRlmTDWO6ShaEWFMtin/xBvXREvjzKZhFzX/NYxKyr801Z5B9+6U7
        SO2zxt/J7HKI5c1Mq7pbBIts97Rwd06krJV5AR7UUxEw/GzSxQCJZsd89gKd8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639166048;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eli+i8B3YqwyV5fufQoUmaaoGq+yqffRRuPCsYwCP04=;
        b=dffEgf84q1W6xTpl5hVnLsh5whTSNhAS9UWka8v5r3rpt/o8QUgIa44cboK7SvteQfF7vW
        jbkH+qFNnmE0DxCQ==
From:   "tip-bot2 for Nitesh Narayan Lal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] enic: Use irq_update_affinity_hint()
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Benvenuti <benve@cisco.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210903152430.244937-8-nitesh@redhat.com>
References: <20210903152430.244937-8-nitesh@redhat.com>
MIME-Version: 1.0
Message-ID: <163916604722.23020.6008266156884327428.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     cb39ca92eb74d00b5b2e1debdba1f33e6e4c8ebd
Gitweb:        https://git.kernel.org/tip/cb39ca92eb74d00b5b2e1debdba1f33e6e4c8ebd
Author:        Nitesh Narayan Lal <nitesh@redhat.com>
AuthorDate:    Fri, 03 Sep 2021 11:24:23 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 10 Dec 2021 20:47:39 +01:00

enic: Use irq_update_affinity_hint()

The driver uses irq_set_affinity_hint() to update the affinity_hint mask
that is consumed by the userspace to distribute the interrupts. However,
under the hood irq_set_affinity_hint() also applies the provided cpumask
(if not NULL) as the affinity for the given interrupt which is an
undocumented side effect.

To remove this side effect irq_set_affinity_hint() has been marked
as deprecated and new interfaces have been introduced. Hence, replace the
irq_set_affinity_hint() with the new interface irq_update_affinity_hint()
that only updates the affinity_hint pointer.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christian Benvenuti <benve@cisco.com>
Link: https://lore.kernel.org/r/20210903152430.244937-8-nitesh@redhat.com

---
 drivers/net/ethernet/cisco/enic/enic_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index aacf141..2faba07 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -150,10 +150,10 @@ static void enic_set_affinity_hint(struct enic *enic)
 		    !cpumask_available(enic->msix[i].affinity_mask) ||
 		    cpumask_empty(enic->msix[i].affinity_mask))
 			continue;
-		err = irq_set_affinity_hint(enic->msix_entry[i].vector,
-					    enic->msix[i].affinity_mask);
+		err = irq_update_affinity_hint(enic->msix_entry[i].vector,
+					       enic->msix[i].affinity_mask);
 		if (err)
-			netdev_warn(enic->netdev, "irq_set_affinity_hint failed, err %d\n",
+			netdev_warn(enic->netdev, "irq_update_affinity_hint failed, err %d\n",
 				    err);
 	}
 
@@ -173,7 +173,7 @@ static void enic_unset_affinity_hint(struct enic *enic)
 	int i;
 
 	for (i = 0; i < enic->intr_count; i++)
-		irq_set_affinity_hint(enic->msix_entry[i].vector, NULL);
+		irq_update_affinity_hint(enic->msix_entry[i].vector, NULL);
 }
 
 static int enic_udp_tunnel_set_port(struct net_device *netdev,
