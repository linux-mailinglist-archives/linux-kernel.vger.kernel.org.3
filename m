Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B628584335
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiG1PjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiG1PjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:39:21 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D117558EA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:39:20 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id e16so2227880pfm.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CqSVW/Ueq6eSKuuwfz5Rq7CFA5+wXLwAWIYxDZSpO44=;
        b=Mr16A+PaQ/QvRlFTof2HXImkabcfMVdsACcFH/i8ptMJGW1+/4dSaqJ2BBBZbr8sj1
         T/xZiOYHH9TxqQMvAbuFv+TD6zRIiIZWvOjT+sFZppRity0mktOZJF6Gn+Hajj67uf5z
         9Pv1twnvGQC0/BWmgqg9CgZVs82EDjtuTntDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CqSVW/Ueq6eSKuuwfz5Rq7CFA5+wXLwAWIYxDZSpO44=;
        b=T+yYjbLP/6JStr+R32MSBqO6G8yY647V+TOOpKw9NiAOwMq+hC3tNqcUTFHqx2z85h
         y3zJi5h4IiPI2+ts2fuwoOSokbGFPOWnhr6rzyAKCavD3jKANl6OOhUqfv8KTbHJbF8p
         lhYboRKsw++Zlfah8zEAXDJ9Nfjd1NDQLQY+GRo7yIXonpwZU9OPOdb8xGSKVAOO4GNF
         tUf/mGyYjJUtr80mV/Sh/a5RxKk2t74iL782Puqd3U0wh3Ji5Sbwfe5+pkrPPZGJmJni
         1S9RuStxvBTvxFKITGPZ6z4QQTc3iJfh5unuJZ9gPNWmB18Im7AVWe1wxsRUkoO5tbk4
         /FAw==
X-Gm-Message-State: AJIora+boUSTu1+f1WhmVH9BsZ47UaeiBy8NbCpNZRvbjlv5dbya2upP
        upja2BLKuxXhgGHpiGB+ctV/2tY9vre0xQ==
X-Google-Smtp-Source: AGRyM1u7RU0iN+DYfRvTGeLIPu8TkCTXOx9aEqO/5m1pJbFtITJo9P6lOu6fitsB9UUSmxcut8h8eg==
X-Received: by 2002:a63:1c24:0:b0:41b:40c5:f114 with SMTP id c36-20020a631c24000000b0041b40c5f114mr8543848pgc.3.1659022760163;
        Thu, 28 Jul 2022 08:39:20 -0700 (PDT)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:7c0f:5963:f38d:5645])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902e54500b0016c0593876csm1462148plf.157.2022.07.28.08.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 08:39:19 -0700 (PDT)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Eizan Miyamoto <eizan@chromium.org>,
        Evan Benn <evanbenn@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Pin-yen Lin <treapking@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3] arm64: dts: mt8173-oak: Switch to SMC watchdog
Date:   Thu, 28 Jul 2022 23:39:13 +0800
Message-Id: <20220728153913.2652153-1-treapking@chromium.org>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to SMC watchdog because we need direct control of HW watchdog
registers from kernel. The corresponding firmware was uploaded in
https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/3405.

Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

Changes in v3:
- Remove /delete-node/ and create a new node for SMC watchdog.

Changes in v2:
- Move the modifications to mt8173-elm.dtsi and add some comments.

 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
index e21feb85d822..fc8203297bac 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
@@ -161,6 +161,19 @@ hdmi_connector_in: endpoint {
 			};
 		};
 	};
+
+
+	smc_watchdog {
+		compatible = "arm,smc-wdt";
+	};
+};
+
+/*
+ * Disable the original MMIO watch dog and switch to the SMC watchdog, which
+ * operates on the same MMIO.
+ */
+&watchdog {
+	status = "disabled";
 };
 
 &mfg_async {
-- 
2.37.1.359.gd136c6c3e2-goog

