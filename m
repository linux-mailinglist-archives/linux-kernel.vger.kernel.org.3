Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D33464D26
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 12:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243066AbhLALpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 06:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237407AbhLALoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 06:44:54 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557ACC061574;
        Wed,  1 Dec 2021 03:41:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A1C6BCE1DCE;
        Wed,  1 Dec 2021 11:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CCEC53FCC;
        Wed,  1 Dec 2021 11:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638358889;
        bh=wH45hyQlmJM24maz22UNQq+SE3Cp0npAZJ/TYl3zh8Q=;
        h=From:To:Cc:Subject:Date:From;
        b=dhv5MG0GtQQK4AeuZIuluh9je1D2S0MtQgwZ2z+DUDoV7ftOZ3meYHM+8qYGi2KHB
         rSB9JfxsUKWGnQDA/Dg0Fc1uqgrBB0Zh382SHMf0XX1RG/RPSFt5s9cZTwCNnOdqjn
         er4y6Lh+ZHpZKJlUzZYn4TrFD+SnUjqR/hPXI65JP9uMslw2laifaNJm1rBRAkVWyc
         m4uZYF4ZazfZN7bhHr/G7jPajr5hntDdFKKzRQmY1ReFFF0dZShEWl20wibFpK4QuE
         aPFyYDoAldqjOm5ZdE3xJoFCSKu3CfaVaa5zBLT1AtIAKCAmlibwiQs7PijSb4t6j1
         rzso3/JmO6+uw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=hot-poop.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1msNzL-0096wy-Cw; Wed, 01 Dec 2021 11:41:27 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kernel-team@android.com, Rob Herring <robh@kernel.org>,
        John Crispin <john@phrozen.org>, Biwen Li <biwen.li@nxp.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v2] of/irq: Add a quirk for controllers with their own definition of interrupt-map
Date:   Wed,  1 Dec 2021 11:41:02 +0000
Message-Id: <20211201114102.13446-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, kernel-team@android.com, robh@kernel.org, john@phrozen.org, biwen.li@nxp.com, chris.brandt@renesas.com, geert+renesas@glider.be, sander@svanheule.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 041284181226 ("of/irq: Allow matching of an interrupt-map local
to an interrupt controller"), a handful of interrupt controllers have
stopped working correctly. This is due to the DT exposing a non-sensical
interrupt-map property, and their drivers relying on the kernel ignoring
this property.

Since we cannot realistically fix this terrible behaviour, add a quirk
for the limited set of devices that have implemented this monster,
and document that this is a pretty bad practice.

Cc: Rob Herring <robh@kernel.org>
Cc: John Crispin <john@phrozen.org>
Cc: Biwen Li <biwen.li@nxp.com>
Cc: Chris Brandt <chris.brandt@renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Sander Vanheule <sander@svanheule.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---

Notes:
    v2: Switched over to of_device_compatible_match() as per Rob's
        request.

 drivers/of/irq.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index b10f015b2e37..65a325aad984 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -76,6 +76,26 @@ struct device_node *of_irq_find_parent(struct device_node *child)
 }
 EXPORT_SYMBOL_GPL(of_irq_find_parent);
 
+/*
+ * These interrupt controllers abuse interrupt-map for unspeakable
+ * reasons and rely on the core code to *ignore* it (the drivers do
+ * their own parsing of the property).
+ *
+ * If you think of adding to the list for something *new*, think
+ * again. There is a high chance that you will be sent back to the
+ * drawing board.
+ */
+static const char * const of_irq_imap_abusers[] = {
+	"CBEA,platform-spider-pic",
+	"sti,platform-spider-pic",
+	"realtek,rtl-intc",
+	"fsl,ls1021a-extirq",
+	"fsl,ls1043a-extirq",
+	"fsl,ls1088a-extirq",
+	"renesas,rza1-irqc",
+	NULL,
+};
+
 /**
  * of_irq_parse_raw - Low level interrupt tree parsing
  * @addr:	address specifier (start of "reg" property of the device) in be32 format
@@ -159,12 +179,16 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 		/*
 		 * Now check if cursor is an interrupt-controller and
 		 * if it is then we are done, unless there is an
-		 * interrupt-map which takes precedence.
+		 * interrupt-map which takes precedence if we're not
+		 * in presence of once of these broken platform that
+		 * want to parse interrupt-map themselves for $reason.
 		 */
 		bool intc = of_property_read_bool(ipar, "interrupt-controller");
+		bool imap_abuse;
 
 		imap = of_get_property(ipar, "interrupt-map", &imaplen);
-		if (imap == NULL && intc) {
+		imap_abuse = imap && of_device_compatible_match(ipar, of_irq_imap_abusers);
+		if (intc && (imap == NULL || imap_abuse)) {
 			pr_debug(" -> got it !\n");
 			return 0;
 		}
-- 
2.30.2

