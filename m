Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6462247E2FC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348173AbhLWMJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243436AbhLWMIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:08:53 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA268C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 04:08:51 -0800 (PST)
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:29a7:866a:cac1:4c27])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 670BF2866B2;
        Thu, 23 Dec 2021 13:08:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1640261329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TpkkGK1HUml0mP08FJk1cHUKfwB7mgaDR1xVUUyYboc=;
        b=snCbznz6B9FyJgvGHi3VI9smwgA1jzayACciJr7gSexY24/+75qZXVGCc0146QU9A6D9SS
        gYPYOSeMHXNKYowYDUAgIpOv2+wE4seN7Cw1wHa1EGDVmdqQE8FaAyM0fp6yA1bJmMzpz2
        6rdOs+dcUPZWDenYMjOg/duhZrusTTuMSgxFm+yHr+jI0BslyIJrHzBafSCEjGlSVrCXfN
        F0gMq3JuBHaqWVsrDYk24ELXV8rjq3p1fzw/G3lR/gcyLb80P7mf5ODNJnJIWPsE5HnO30
        K89luZAsy3xetCImy2VKqhBAeIY/gV0INDPnb1AjAp/vqt9YepL1tzJqF1S5vQ==
From:   Sander Vanheule <sander@svanheule.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [RFC PATCH v1 1/4] irqchip: realtek-rtl: map control data to virq
Date:   Thu, 23 Dec 2021 13:08:31 +0100
Message-Id: <7f89a2ed75482b8d1d8469d2c6bfd479aba07b9f.1640261161.git.sander@svanheule.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640261161.git.sander@svanheule.net>
References: <cover.1640261161.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver assigned the irqchip and irq handler to the hardware irq,
instead of the virq. This is incorrect, and only worked because these
irq numbers happened to be the same on the devices used for testing the
original driver.

Fixes: 9f3a0f34b84a ("irqchip: Add support for Realtek RTL838x/RTL839x interrupt controller")
Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/irqchip/irq-realtek-rtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
index fd9f275592d2..d6788dd93c7b 100644
--- a/drivers/irqchip/irq-realtek-rtl.c
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -62,7 +62,7 @@ static struct irq_chip realtek_ictl_irq = {
 
 static int intc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 {
-	irq_set_chip_and_handler(hw, &realtek_ictl_irq, handle_level_irq);
+	irq_set_chip_and_handler(irq, &realtek_ictl_irq, handle_level_irq);
 
 	return 0;
 }
-- 
2.33.1

