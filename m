Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2AC4796E9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhLQWOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:14:12 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:41635 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhLQWOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:14:09 -0500
Received: by mail-ot1-f42.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so4566650otl.8;
        Fri, 17 Dec 2021 14:14:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HRPjZ6BCCRz8DgC5lU6t6/+QUdNthSGalR45oT3E+s4=;
        b=SyZ9IjW401wBZQHgIyB3x7nWemA/euwV8SHQ972GWY+7l60UC76F8h9aKaFZs5Osyj
         kDBvu1EQeQjNzkVnHOfoQDMeL00idWdNI880XHDqV0RgZzduerOQQ2Uj3vJti14/HC5h
         gKPrVteO4awsFGAaKdD5WBGA1mqIlHiikjtnK/HWE4eHhj0w3g3ujJamfwSD2lO3yWTF
         0mN/N7zFr6PTfN4221Sq6apT6QL9kRUnYj0ZMkZiVfQI/cysZ9HVQcbIufp1s4EVGIF2
         Xg7I/kQhs/k8IYAwTJzLG8nwUlKuHRjGJ620iJB7ZRY1EoJvKRMYlCbA2QVYsqTDaxMU
         PrUQ==
X-Gm-Message-State: AOAM531rNA+rMtdHtBv8wzHd4jyyJEjok6qIYEbGkvoaUcR+pRitKzli
        g1nt3OCVuzWv97lZi4wLuA==
X-Google-Smtp-Source: ABdhPJwh4Y9Lw6ei5ha5CA9qNLUhAYqUzn12Yng2m8cXlJN677jIVGkwJ+3t94R7Keqvk2kyYbmtMA==
X-Received: by 2002:a05:6830:2b14:: with SMTP id l20mr3649399otv.42.1639779248692;
        Fri, 17 Dec 2021 14:14:08 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id a16sm1813248otj.79.2021.12.17.14.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 14:14:08 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: dts: Remove "spidev" nodes
Date:   Fri, 17 Dec 2021 16:14:00 -0600
Message-Id: <20211217221400.3667133-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"spidev" is not a real device, but a Linux implementation detail. It has
never been documented either. The kernel has WARNed on the use of it for
over 6 years. Time to remove its usage from the tree.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/powerpc/boot/dts/digsy_mtc.dts | 8 --------
 arch/powerpc/boot/dts/o2d.dtsi      | 6 ------
 2 files changed, 14 deletions(-)

diff --git a/arch/powerpc/boot/dts/digsy_mtc.dts b/arch/powerpc/boot/dts/digsy_mtc.dts
index 57024a4c1e7d..dfaf974c0ce6 100644
--- a/arch/powerpc/boot/dts/digsy_mtc.dts
+++ b/arch/powerpc/boot/dts/digsy_mtc.dts
@@ -25,14 +25,6 @@ rtc@800 {
 			status = "disabled";
 		};
 
-		spi@f00 {
-			msp430@0 {
-				compatible = "spidev";
-				spi-max-frequency = <32000>;
-				reg = <0>;
-			};
-		};
-
 		psc@2000 {		// PSC1
 			status = "disabled";
 		};
diff --git a/arch/powerpc/boot/dts/o2d.dtsi b/arch/powerpc/boot/dts/o2d.dtsi
index b55a9e5bd828..7e52509fa506 100644
--- a/arch/powerpc/boot/dts/o2d.dtsi
+++ b/arch/powerpc/boot/dts/o2d.dtsi
@@ -34,12 +34,6 @@ psc@2000 {		// PSC1
 			#address-cells = <1>;
 			#size-cells = <0>;
 			cell-index = <0>;
-
-			spidev@0 {
-				compatible = "spidev";
-				spi-max-frequency = <250000>;
-				reg = <0>;
-			};
 		};
 
 		psc@2200 {		// PSC2
-- 
2.32.0

