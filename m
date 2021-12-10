Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD849470B15
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbhLJT5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343714AbhLJT5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:57:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3A1C061746;
        Fri, 10 Dec 2021 11:54:08 -0800 (PST)
Date:   Fri, 10 Dec 2021 19:54:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639166047;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ph2b4i2Z+D2MXpBg/Qh+B3lDQg2sCSTiTTKrW4e/1gs=;
        b=MbZJU9MAhhNJAlB4JinRF4aZSGylZ5QsH8c6M3n5EBc05XsFtbI+NCanp/9LiRWfjDvHLP
        OpuTthXCXJFh1LtIz7MUgUMiFXT8lV1RGlx6QkCvokgjC4hLOnTOMejKLWrYNbBiAkPz7P
        8roec5wxuXAs/LN+bZ8P1ysDDAkJSQGWPFvj+618vxBoo4VN1qdvOqg2by7DJPsvk3Z8BI
        fPiko+tHjj2LL96nnm8fQuQifNWO2la8yND4uQ6GRbNcEoS8GPJDSMUyxj6GpnUpa2Ps9W
        TIE6ccPkwKrI8KDceBdh/2h4z7ET4F3ZZzHLfYUZGeLx6DJ/aRGQZIlXdmk4kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639166047;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ph2b4i2Z+D2MXpBg/Qh+B3lDQg2sCSTiTTKrW4e/1gs=;
        b=FUMX/PcoO8yZOoaNtJKXf53ifblI3KIcUkQ3yOpTncb8AW4PgynREcm3swxXNRAwe0WvMM
        LdD32Y1ROPJQceBQ==
From:   "tip-bot2 for Nitesh Narayan Lal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] be2net: Use irq_update_affinity_hint()
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210903152430.244937-9-nitesh@redhat.com>
References: <20210903152430.244937-9-nitesh@redhat.com>
MIME-Version: 1.0
Message-ID: <163916604653.23020.18360521220942463553.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b8b9dd525203304d36bd123fca3ce0c3b318339b
Gitweb:        https://git.kernel.org/tip/b8b9dd525203304d36bd123fca3ce0c3b318339b
Author:        Nitesh Narayan Lal <nitesh@redhat.com>
AuthorDate:    Fri, 03 Sep 2021 11:24:24 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 10 Dec 2021 20:47:39 +01:00

be2net: Use irq_update_affinity_hint()

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
Link: https://lore.kernel.org/r/20210903152430.244937-9-nitesh@redhat.com

---
 drivers/net/ethernet/emulex/benet/be_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index d51f24c..84b3ba9 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -3491,7 +3491,7 @@ static int be_msix_register(struct be_adapter *adapter)
 		if (status)
 			goto err_msix;
 
-		irq_set_affinity_hint(vec, eqo->affinity_mask);
+		irq_update_affinity_hint(vec, eqo->affinity_mask);
 	}
 
 	return 0;
@@ -3552,7 +3552,7 @@ static void be_irq_unregister(struct be_adapter *adapter)
 	/* MSIx */
 	for_all_evt_queues(adapter, eqo, i) {
 		vec = be_msix_vec_get(adapter, eqo);
-		irq_set_affinity_hint(vec, NULL);
+		irq_update_affinity_hint(vec, NULL);
 		free_irq(vec, eqo);
 	}
 
