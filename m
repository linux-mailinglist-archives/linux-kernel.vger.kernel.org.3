Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A0A49712E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 12:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbiAWLRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 06:17:16 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:38470
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236248AbiAWLQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 06:16:58 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C476240052
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 11:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642936616;
        bh=oFyg+gwb7XtvC7QbtaeH/MyDAvhazxDlD6i95VQK5XA=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=LXO4MHgelNXm7sgbj39jWY7EpoyZuTToaQsV9sC2XsLXcYTidl3qtOaYVpxKvD7ZQ
         WpUCtZAqCjPeMQPHfHtS4jv1tw9duq0FNHuRflWae+yoPoQCpTNEfmOTWP52BA3T+/
         OvSqw1Bo5w5P3HgpvSesmEGrlz4G9rJLV0Wt4LevhIdZmb3Hc90vZSewUZL0+RRXt4
         Wk8IojkEz8QswoBwrboB0ktyVzDEKsGLDZbhiNofVUQ+gaXtBaAD78AUQnaZTVuijp
         esdpKCy/P2CPc5SAb2OVFcWwc1hhtoSu6IOHspKJJjPiHt1ISIu06aq4wmX6u8T7pp
         BRhdxh1kM+rNw==
Received: by mail-wm1-f72.google.com with SMTP id w5-20020a1cf605000000b0034b8cb1f55eso12953653wmc.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 03:16:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oFyg+gwb7XtvC7QbtaeH/MyDAvhazxDlD6i95VQK5XA=;
        b=uaYBxljhJ2z0qpWv4ditrmFe5EGmpiwBCj8tJfI6Ye/ZxLqqS4vRH+D3Yy8ccvtLUd
         0IRic/NK0zGYq4D0pKLqqo7UqguPNHYep5YgY1u4Q8Dv3epNuh0Jg8H/xnXGlzyGd8me
         woBFfErjDp41Imob8rup4rpVHOM67B1XNnHKEPE1BopkmfIRgf5XP3RjVkX+SvmEGsC2
         A/iVaETz/sTy951nJQjmDbYKiOcbokhvwm4HrazFosqa4n2TCybnn8Q6nPi/dG7EK6AE
         flAxzUWJNTyFN1olhHLEcMVQHaPA1Ig4HVfrgjcOBwuKXcqb8qSzYXk13Ewb3utAn/Lu
         Djdg==
X-Gm-Message-State: AOAM530jzvDgeHZOhuZKjXIdO65RlTs3TP0paQcY8r9TBvCfopmi9EHa
        T/Fm7rsuBRJYW+9PEoYU3lMF+ZDaWubH7NVjaasz6wkAo8BKPCNVMdpqwwY9sx+dTOFRgHmsNB0
        HMIiFtwXDe/rkIp1gN4BQM0vHmrnxe8Mnb+dwXEf3xA==
X-Received: by 2002:a7b:cb05:: with SMTP id u5mr7582894wmj.59.1642936616521;
        Sun, 23 Jan 2022 03:16:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzl/THDIXXxYVsa2sg8+CimTWrhi2Zjb2hJxs9yZ1xXuWrxrnlJt2icnBT+iFNOebYeJ8eo7g==
X-Received: by 2002:a7b:cb05:: with SMTP id u5mr7582884wmj.59.1642936616338;
        Sun, 23 Jan 2022 03:16:56 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m5sm10143729wms.4.2022.01.23.03.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 03:16:55 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/12] ARM: dts: exynos: add USB DWC3 supplies to Chromebook Peach Pit
Date:   Sun, 23 Jan 2022 12:16:39 +0100
Message-Id: <20220123111644.25540-8-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com>
References: <20220123111644.25540-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add required voltage regulators for USB DWC3 block on Exynos5420
Chromebook Peach Pit board.  Due to lack of board schematics, use same
regulators as on Odroid XU board (using same MAX77802 PMIC).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index e76fb104db19..6252089e4350 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -1090,6 +1090,16 @@ &tmu_gpu {
 	vtmu-supply = <&ldo10_reg>;
 };
 
+&usbdrd3_0 {
+	vdd10-supply = <&ldo15_reg>;
+	vdd33-supply = <&ldo12_reg>;
+};
+
+&usbdrd3_1 {
+	vdd10-supply = <&ldo15_reg>;
+	vdd33-supply = <&ldo12_reg>;
+};
+
 &usbdrd_dwc3_0 {
 	dr_mode = "host";
 };
-- 
2.32.0

