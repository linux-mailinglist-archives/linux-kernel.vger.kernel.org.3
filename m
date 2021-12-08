Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D5446C946
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243135AbhLHAma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243205AbhLHAlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:41:53 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1B9C061756;
        Tue,  7 Dec 2021 16:38:15 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id iq11so722279pjb.3;
        Tue, 07 Dec 2021 16:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hvQSZSJjmQDhoVNAws8o0GpYR+Fym5ONsESevW2QHHo=;
        b=YsYqXKHsvXhdeM/IyL1SKgdv98pj1oIHs339moNg3VVUItJOpTqWYEMgEippDCxYjO
         KuprQ9Hswo1X7gZUmVfZT0I2/+gZpbJMPKzSN/QXgPofOBMo2/hoLnAkVMfb+c87piZd
         HH2s1KMm25sGNpE9gCaRO+nxCF95y5CtHGVr1VNZEmMrWs8E1KBByPhu2HwuiEP9WczL
         LHniJbJFyX6/5jvVXDyiRboFUopWUG2bNilh9fv89GLgeJJ5xqqSqgkIhIa2fTZSs+IT
         HISaQjcwXdVrhYk0eDkEIdklHvI6YbH4zRN3fWv7ENq76tVB8TOKrQVCwBtXNDMYMEIv
         AbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hvQSZSJjmQDhoVNAws8o0GpYR+Fym5ONsESevW2QHHo=;
        b=F9/30azIJ/aauBhsEiyVDBBsCi78qPYV3aR3LtIqMeLkA4cz8iJO9D5l4bwIvOyI2H
         udG59GT6Je9pIQTpxGvApNIEWqjgGiwukj9QUibYgQWPPNoec2f5YJ+YJ3EsqDSCe1z8
         hC20E0uaUlbsYKzupWKCWw70+e2K/VGB/3yX2UW3i7G0mDNVXG0r7Q7c3LwYT6O6u8KR
         CG2qzi4lhhWwgiJ94gbc86KUwwZ5+DEbX/a63QAsErCE7KWjytpFh6GwZ9DpTdstMIon
         7av5zdYaRPCo9pYk7O+QsKuiGchoB/vYr3co4eSsJH8FowVQGCZhyiJQQPTGm9Qe/rIP
         hAfg==
X-Gm-Message-State: AOAM531mAoAWWUu++B5A+K4E5WY+PyncUuc7alOrrgmzoeLQbeHyMN+g
        yBTqvxvk4NJazLCvzI+Nn/RqvgIHdas=
X-Google-Smtp-Source: ABdhPJwi2iTXT2ws2ooLafhem0ya4FCPo70jwLmcLcMt0E5aW7hbyB9AO5Qs3VpZ3vFfMnSC/qMl8Q==
X-Received: by 2002:a17:90b:4d09:: with SMTP id mw9mr3067383pjb.238.1638923894705;
        Tue, 07 Dec 2021 16:38:14 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n16sm926379pfv.123.2021.12.07.16.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 16:38:14 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Gregory Fong <gregory.0xf0@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list),
        linux-gpio@vger.kernel.org (open list:GPIO SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        linux-mmc@vger.kernel.org (open list:MULTIMEDIA CARD (MMC), SECURE
        DIGITAL (SD) AND...),
        linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
        linux-crypto@vger.kernel.org (open list:HARDWARE RANDOM NUMBER
        GENERATOR CORE),
        linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM),
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
Subject: [PATCH v3 12/15] ARM: dts: NSP: Rename SATA unit name
Date:   Tue,  7 Dec 2021 16:37:23 -0800
Message-Id: <20211208003727.3596577-13-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208003727.3596577-1-f.fainelli@gmail.com>
References: <20211208003727.3596577-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the SATA controller unit name from ahci to sata in preparation
for adding the Broadcom SATA3 controller YAML binding which will bring
validation.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 1c08daa18858..ded5a59e0679 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -534,7 +534,7 @@ sata_phy1: sata-phy@1 {
 			};
 		};
 
-		sata: ahci@41000 {
+		sata: sata@41000 {
 			compatible = "brcm,bcm-nsp-ahci";
 			reg-names = "ahci", "top-ctrl";
 			reg = <0x41000 0x1000>, <0x40020 0x1c>;
-- 
2.25.1

