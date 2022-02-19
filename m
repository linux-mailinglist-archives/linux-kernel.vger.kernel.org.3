Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AC84BCAEC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 22:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243196AbiBSV4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 16:56:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243185AbiBSV4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 16:56:14 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAEB54696
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 13:55:53 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d187so5304103pfa.10
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 13:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/Twze+jWTz4YOh5YSziAhocCfC52Co0EJtrbTTXd7Pg=;
        b=vG+JbMUigvy10tcTl88GkDpP8OmExegUMriyny+TvwZBp2EZ8MYdUDzDsDW+k5E7ST
         d5eAd26zzDX92/Tl2ElwHXXBDjJpK5/z5Vkz0YjOSMbonMsyPIl4pTTJRTG1Fe04XzSQ
         TD/Dtki5l8Eey8CyLMmED80b5ur24iDA+d86gs1HP+A+L0fqNjw6WNu1GkgDz5tQVozT
         qp1EuQxH2/gTPSdmSc0v8jlYHnrTo0RvGZNWW1r/S5q56l5xjDc3i2rapMZ1aKYqDOg1
         d8mNp50h8HwwhOt4BMglIrIvaiu/0lT6uTBfb/hi5feQ5SLchwQlgZZAXIY4EdQBuIME
         SdJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Twze+jWTz4YOh5YSziAhocCfC52Co0EJtrbTTXd7Pg=;
        b=ExDPLDA7q/T3uWZCiuMhplVvkGZ9vqfeaTAgj1eQToxz7nFehFOkUOEY+orqrVPmiI
         7iycdSrXkROk4zYxF5qm6W01OszP5rLXLVQ2pOyeCpNjjN3rnN1ZFvLV6I+lz4rH1VEy
         W5JGBtDRE2gEQl6nYjwRp3QYEKweuBo/4YW3jzqCPny/PCDBXzmdwRVYHwrdE4SzXfZM
         zZ/ngqj5oL2XCFpMX9zt1Qn4tBnB7qLHIpVp2jh/80naUTDFq337rf3m4I/wQ6yQpYP3
         IexkR7l7U/d0g7Z7l8gS2ravpLnrIzolahTgZRr/XWH6yh1FeSMFAdR72Jy9XVxj2EZZ
         Tbmg==
X-Gm-Message-State: AOAM532klInvuwRx+drhaiwp0Md02ygpP5N0hCHLeyr5qAuRmmNOmF+a
        xir66gE32heVSjIu0pD6v1ym1g==
X-Google-Smtp-Source: ABdhPJz6JLPuDNMFwxqmJ1GcafhE8zHgR7FEQxVDTVdvZhZXVSbw57wLOQgSHBaBl2SW/gE+cnHvNQ==
X-Received: by 2002:a63:1d0f:0:b0:365:7d07:ac44 with SMTP id d15-20020a631d0f000000b003657d07ac44mr10967207pgd.526.1645307752940;
        Sat, 19 Feb 2022 13:55:52 -0800 (PST)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:31ab:1e81:9550:f30a])
        by smtp.gmail.com with ESMTPSA id i17sm13447337pgn.82.2022.02.19.13.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 13:55:52 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>, devicetree@vger.kernel.org,
        Drew Fustini <dfustini@baylibre.com>,
        Keerthy <j-keerthy@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>, s-anna@ti.com,
        khilman@baylibre.com
Subject: [PATCH 10/11] ARM: dts: am43xx: Add scale data fw to wkup_m3_ipc node
Date:   Sat, 19 Feb 2022 13:53:27 -0800
Message-Id: <20220219215328.485660-11-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220219215328.485660-1-dfustini@baylibre.com>
References: <20220219215328.485660-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

Add appropriate scale-data-fw names for all am43xx platforms.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts  | 1 +
 arch/arm/boot/dts/am437x-sk-evm.dts  | 4 ++++
 arch/arm/boot/dts/am43x-epos-evm.dts | 4 ++++
 3 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 91b67b428a06..ad561f81af3a 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -1129,6 +1129,7 @@ &cpu {
 
 &wkup_m3_ipc {
 	ti,set-io-isolation;
+	ti,scale-data-fw = "am43x-evm-scale-data.bin";
 };
 
 &pruss1_mdio {
diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 20a34d2d85df..7b518aff5f8f 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -893,6 +893,10 @@ vpfe0_ep: endpoint {
 	};
 };
 
+&wkup_m3_ipc {
+	ti,scale-data-fw = "am43x-evm-scale-data.bin";
+};
+
 &pruss1_mdio {
 	status = "disabled";
 };
diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 2f4d2e4e9b3e..a734bdc5e126 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -1019,6 +1019,10 @@ &cpu {
 	cpu0-supply = <&dcdc2>;
 };
 
+&wkup_m3_ipc {
+	ti,scale-data-fw = "am43x-evm-scale-data.bin";
+};
+
 &pruss1_mdio {
 	status = "disabled";
 };
-- 
2.32.0

