Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BAA4889F5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 15:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiAIOyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 09:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbiAIOys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 09:54:48 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB72C061748
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 06:54:48 -0800 (PST)
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:f20a:f473:2021:45ec])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id D42D928EE24;
        Sun,  9 Jan 2022 15:54:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1641740087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TpkkGK1HUml0mP08FJk1cHUKfwB7mgaDR1xVUUyYboc=;
        b=8q5MbwPnrWK7owgLbfqfyAHRlTblYQrhuXGBdeW2QQe1bhoQ7SJBeCwDll2yYc5KwxM1iA
        bnQGLXOsfkuLaDchhdTzaLnFE1CGzeHAqAm2RAuAW0TmtmCKFJwPMCeySNpg+yHK7OsUr1
        WECS+Le6cVPvPRvaiUCQrBgfH3sKe/jV/bRu3hgnpi8TeSa7dchbTX+oAjjcz865DC9igA
        sUralPlfusr77jorgQPO18MvbncBs0ezWRqMH450usDGCIlJrYzlIEFKreTbaQw6M18iSR
        UobK/UsFTbIAtfBLT2JD/2XaxIzcphYk1llVJ/DTM3Gk05YRaTH05zN733lrpw==
From:   Sander Vanheule <sander@svanheule.net>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v3 1/6] irqchip/realtek-rtl: map control data to virq
Date:   Sun,  9 Jan 2022 15:54:32 +0100
Message-Id: <4b4936606480265db47df152f00bc2ed46340599.1641739718.git.sander@svanheule.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1641739718.git.sander@svanheule.net>
References: <cover.1641739718.git.sander@svanheule.net>
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

