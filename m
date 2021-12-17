Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14727478400
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 05:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhLQEUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 23:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbhLQEUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 23:20:16 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F03CC06173E;
        Thu, 16 Dec 2021 20:20:16 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 200so972437pgg.3;
        Thu, 16 Dec 2021 20:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hvQSZSJjmQDhoVNAws8o0GpYR+Fym5ONsESevW2QHHo=;
        b=VCLMgUs3P2HRhSbZzwxM1P5j9NYLF+tWlrBYBKuNZQV0ComR8SANLymGpQtIksO75I
         p/BNZf/3NNAplUfm34AXrjqvIGkh+pwNeolLwI7hnxom+j8LpEJklqNVAP71AKDW+IQr
         HvWF+0f1ikF3zI4+puJ9zMcA5ObqPp2Q90a1RcuaL7NEC31UrWEIorFJYyrClhbelmR/
         g2/WOES0f/Hz/dA0RFpsePJKwpxOgLGnFRYjDNnGAKSienFFR21Fjx9CSaDFxwtP6khr
         W7lEmY+t8JqM3aPcvEXk24lpgGeUE+wt6WMmfzwQa2XOtV3r+IxPJUuOcCwJotRaace4
         JxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hvQSZSJjmQDhoVNAws8o0GpYR+Fym5ONsESevW2QHHo=;
        b=Mxh9bKymEPKIFXvUHBQuVWzH6871giBiDnmYulktvzbGFT5J+RTJ7kZGCka1OWCKP8
         HtvYUxAt/6i5kwkefRycn9eQW1Gt3q4BXUCyek3z8EGxqT377y1KR5BCSIlH+M57djBq
         VU3LSZzJWp2JxRx8HNR58SsjgB6lLYIwtTswfy3M1jBOG7QDQF4qjH0tyFgFhrE5fPZo
         OaE1JgXAwkEewSGpHiVIjnZiNhqPFBL3v+BDt0Ium7iGEGizg8R6L15OcGgEzamCoedw
         HJcPfHFxsRywWng/+KdRgyYhTo2OzfnXZ/Qa7Ey3kWrbYSjJd0E88XmpbVBmwVidyjTx
         WjlA==
X-Gm-Message-State: AOAM532dhklfIQ5+Xml9c5Qiw1PwcwT6xBLE9cC/7Wx3hWQrg/H/CoyN
        oIB6Jox15drI4ObQCczaEh3S2YaxaF8=
X-Google-Smtp-Source: ABdhPJwkisUtzEda3tzD4bYdOMoMHn17gkOvTZhkm5bs9qxmGRaGjO45sdXG/2Elh4jamoSMvLNGcA==
X-Received: by 2002:a63:8bc4:: with SMTP id j187mr1281031pge.189.1639714815537;
        Thu, 16 Dec 2021 20:20:15 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id mq10sm7553496pjb.3.2021.12.16.20.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 20:20:15 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE),
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
Subject: [PATCH v4 3/6] ARM: dts: NSP: Rename SATA unit name
Date:   Thu, 16 Dec 2021 20:19:58 -0800
Message-Id: <20211217042001.479577-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217042001.479577-1-f.fainelli@gmail.com>
References: <20211217042001.479577-1-f.fainelli@gmail.com>
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

