Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BA34D5E96
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347545AbiCKJjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239888AbiCKJjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:39:15 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03471BBE25;
        Fri, 11 Mar 2022 01:38:10 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id b8so7678838pjb.4;
        Fri, 11 Mar 2022 01:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+sti7R5r7TlUzIhwq2afJWAsp4Iedj4R4baq+ryUh2g=;
        b=UPsLXqoS5RBH3+XHcocj3dT6VT/oGbCNu4zvXSVjMWOQiIW4Zv17pEQjwbEJSmuHKq
         nwt/rKa9jWswtdLbCpD7380vcsbGTynIJOI+EJOU1h24OKwK9TOjMpg9t2KCq89gkedX
         rrzz28GkgRUXbJ8yI9rda/V2EE7WzDjn74gJiwec3XUzXqWu84Tv355++8yxsjlK8OCr
         slB+drV0Yvrnt1rRSJOGrEFj/+gHKsH53kXryJxw9tB1AIbdUcpyjUv0Z9hkhy0DOKEd
         5pv8Y9K17lZ4i1+xAmlhZruknJN1k+vaMTTA0LNYp6VuZm+Ut3GT05DuXjkEdPPJjUZu
         sMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+sti7R5r7TlUzIhwq2afJWAsp4Iedj4R4baq+ryUh2g=;
        b=UEFdijlLkokXLInQ46BCqFR+xJBxU6Ul5Cbb7HAk72spTVTvt8xs+BVts4MMXVnDV+
         r3ymBtYnGc7GbvjGyXTDNctG5/mefkqd27ZImVOON1w7xs+LBgKYhiH1zbszGztw181V
         /x4JyGwEKpXZ3dnTJ+Fgpl7b1PtUQELE/+LeRWRPIxzw7Zje2nyWoSP+2gntPsObNMJq
         rr1PijKSec6LRBW6BEizClWdGJ3ddDx26kMhwv8GX97ZzPJDnP2ysFpv8lEaGjhk5Wrq
         PH+tLCpMzrtGUpuEjLbeyoRMo2a2oIvK06esPAl1O3wu6gFjCy+N0L6K8dv0X0Ac0DbW
         7m2A==
X-Gm-Message-State: AOAM5313nmYAICDpf+NjZIAukC8XObmO/0dM2RiaaH9BI/B4dtPn6unp
        XMX7yw4D5omfXNvzn3j8uTY=
X-Google-Smtp-Source: ABdhPJzYRJlhVYjsiUbgyuUOuHb8yYvjyX5Y3NPJ7anc1+dPGbWZPcJPM2mEEqB5bo8jjieTu90yqg==
X-Received: by 2002:a17:90b:1c86:b0:1bf:2a7e:5c75 with SMTP id oo6-20020a17090b1c8600b001bf2a7e5c75mr9954721pjb.145.1646991489547;
        Fri, 11 Mar 2022 01:38:09 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id m11-20020a056a00080b00b004f75d5f9b5csm9011011pfk.26.2022.03.11.01.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 01:38:09 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Brijesh Singh <brijeshkumar.singh@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/3] arm64: dts: seattle: Update spi clock properties
Date:   Fri, 11 Mar 2022 15:07:58 +0530
Message-Id: <20220311093800.18778-2-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311093800.18778-1-singh.kuldeep87k@gmail.com>
References: <20220311093800.18778-1-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PL022 binding require two clocks to be defined but AMD seattle platform
does't comply with binding and define only one clock i.e apb_pclk.

Update spi clocks and clocks-names property by adding appropriate clock
reference to make it compliant with bindings.

CC: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
v2:
- Resend to soc ML
- Add Rob's acked-by tag

 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index b664e7af74eb..2aa21d98d560 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -113,8 +113,8 @@ spi0: spi@e1020000 {
 			reg = <0 0xe1020000 0 0x1000>;
 			spi-controller;
 			interrupts = <0 330 4>;
-			clocks = <&uartspiclk_100mhz>;
-			clock-names = "apb_pclk";
+			clocks = <&uartspiclk_100mhz>, <&uartspiclk_100mhz>;
+			clock-names = "sspclk", "apb_pclk";
 		};
 
 		spi1: spi@e1030000 {
@@ -123,8 +123,8 @@ spi1: spi@e1030000 {
 			reg = <0 0xe1030000 0 0x1000>;
 			spi-controller;
 			interrupts = <0 329 4>;
-			clocks = <&uartspiclk_100mhz>;
-			clock-names = "apb_pclk";
+			clocks = <&uartspiclk_100mhz>, <&uartspiclk_100mhz>;
+			clock-names = "sspclk", "apb_pclk";
 			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.25.1

