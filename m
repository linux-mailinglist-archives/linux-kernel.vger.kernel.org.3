Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FEC49C2CE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 05:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbiAZEuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 23:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiAZEuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 23:50:04 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544DDC061747;
        Tue, 25 Jan 2022 20:50:04 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id v123so26816557wme.2;
        Tue, 25 Jan 2022 20:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mqGfir27zJmToE36fS5ePo6W0AQ+1+pKPU+ftIb1KDQ=;
        b=H/u5aTGxe7bDkyVyj/WetTyDAkwOgDrbmlbTQSSNgeOl6fu43dLrxIejkDwHUUc38I
         NV1ic0G6uTxbIXSNr24DUy2lc0kMwnsA+obl/mpNa9owGGfCRGYH/7RTTG0xWJROd0/K
         S3e8yJbW1GWEpgW/4irF2AcrlXnmzRSj/Ij7PAefYPYZ7SJfOFhz7BPWILcCprgz94V3
         WIJ5VW4Q+ambXWN68hI+LMGTpOtVwjz7LtBGelRccZoqr9K66L//pWwweyDKE5eB8MCt
         vae6RgKiYXenV7eWbEOXVrFxow6KOf+wzq27kHaLi5HiOfDsY7seh5iY+wmsoOzAF5ij
         TCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mqGfir27zJmToE36fS5ePo6W0AQ+1+pKPU+ftIb1KDQ=;
        b=Tpp7tFxvTZnsHfa0QEP8n1miEpWwSiBWxXuD9lZpbvy8SMSx6qTsNxVzUlNjjaWBGH
         pgVOjxozbDQdTuV+4u0z+lb2ibX8hs0gBHfuOAGSqS2eKbcCdEvwClngfuFz3aS2NYiK
         dWoiV+LPEpHVEtNvChQYkdU+NCSpIdoRfof3RSHNLFOjNhIo/CKe4pqEyKAf3PmLQMOA
         90j5EyPsiT/RS1Q2NdzaHiUa2ScosfD6mBK4MTOPtGiRFORNjdy0MM7tlDH+gctGNa5+
         4qYih5GJt/DDIQBjiDu/MmdMmG/wFaGThUXbtNKgdwUHcLDVsISuAyiQOf+WG2wTf31j
         YdPQ==
X-Gm-Message-State: AOAM5329CDKevl0uzWCD0FYabFsl4idQoKnzEGXJIXjrZbAFqFuUlsJb
        dYq4/BFWc6zYADA0XxPhBEU=
X-Google-Smtp-Source: ABdhPJx7OSVbyDVHUckRwup7sGaYF8zhkCb8BJsjlfWSgjXp0ZhBEmMgluIICeh6SPivrPEIAx/fGQ==
X-Received: by 2002:a05:600c:19d1:: with SMTP id u17mr5668891wmq.24.1643172602946;
        Tue, 25 Jan 2022 20:50:02 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id n15sm2171342wmr.26.2022.01.25.20.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 20:50:02 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 2/3] arm64: dts: meson-g12: add ATF BL32 reserved-memory region
Date:   Wed, 26 Jan 2022 04:49:53 +0000
Message-Id: <20220126044954.19069-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126044954.19069-1-christianshewitt@gmail.com>
References: <20220126044954.19069-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an additional reserved memory region for the BL32 trusted firmware
present in many devices that boot from Amlogic vendor u-boot.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 6d99c23261fb..45947c1031c4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -107,6 +107,12 @@
 			no-map;
 		};
 
+		/* 32 MiB reserved for ARM Trusted Firmware (BL32) */
+		secmon_reserved_bl32: secmon@5300000 {
+			reg = <0x0 0x05300000 0x0 0x2000000>;
+			no-map;
+		};
+
 		linux,cma {
 			compatible = "shared-dma-pool";
 			reusable;
-- 
2.17.1

