Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEE14A313A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 18:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352921AbiA2R4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 12:56:36 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:36356
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229895AbiA2R4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 12:56:25 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 824143F1D8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 17:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643478984;
        bh=LryPbZU3HL9KmZlfDg9bneZraOek6aRqFlYMuXq3mpw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=HA4L09+YaaNZLklpOrGWclbPmDqvIcbaMpdV93rxUWXCku+FQdf38XjmwmOudGsF+
         DUjlUKKv7uy9SXCyXRQywUxMWZvm7yre1+iGTkIXpL+rxomTdfpnnNdyKtIoJN+/B/
         NfbL4yNCnWilWvyNvuY3AEq/rql8TOxTw/CDq4ihYvvBCRvLxh9U/tD9H0gM0DTTvd
         XhJ9h7IE2MkSdb+e0GvNNP0kgWY27NOlzZWmIo38m7bTpqmflR1Kv4BGk6TGXx6bNl
         PXJljYeYzuiNIhmDfIIqXEmDXJL4XcxECtTwNdKwtaTArP8/lwqj8gAcPl2g4T7S6b
         lEzU7bwYRvFlg==
Received: by mail-ed1-f72.google.com with SMTP id en7-20020a056402528700b00404aba0a6ffso4691492edb.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 09:56:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LryPbZU3HL9KmZlfDg9bneZraOek6aRqFlYMuXq3mpw=;
        b=ZQAd0fR6ncB2g3glengap4OaSw772ts/L3SuOtBkVQ+O5wj1KKH6lkWHqXfU7aDcu3
         ydT/Ww192I2wJT6P+ggarENxmc/x0VgbyVw0vqlipnPYceBVv7G2mmsWGVlusaUPyEvR
         WLxcMhTkN01JOr+SU+rYmZv343sq0gEbM/8jjr/HLskhW1pdW2iFH8PJT9173iKslGu/
         EH2IwAwxWPXGa8zZm5Tb3vOFdrzSaSDMrlq3KRk3/SB73F4KB2tlaPPy2Q6GD5D/GkoD
         aEtxm7RxrmFscF7v75x+2UjTl3WOkGJx4fu3XkdEv8lDrtI+ad6msjOOqrsgSbPqyCEF
         V/sw==
X-Gm-Message-State: AOAM530jk/pWSKveG7mNGydJTTxxGbb/q9NnMWDHENSBy/RchI0CLJn3
        78S6fBni0ok99Maxa+3r8QEAw56eYpSH79hqHnBEHfpk1H2NQYs7hjPmfw7HK3CzkW/AnCShowa
        Bub0pOayHdrQ++gUpRc/jq+ZMC6xOIWiG93fGjtnt7g==
X-Received: by 2002:a05:6402:3450:: with SMTP id l16mr13560068edc.225.1643478984185;
        Sat, 29 Jan 2022 09:56:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxTH+NRh1IzmpsqhdmewAwK3hAzmotycMGgQdOxX6eEG5QNIYKiYvc8CndgmQTmEkSScXgNoA==
X-Received: by 2002:a05:6402:3450:: with SMTP id l16mr13560062edc.225.1643478984066;
        Sat, 29 Jan 2022 09:56:24 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id d6sm12676759eds.25.2022.01.29.09.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 09:56:23 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH] arm64: dts: juno: align pl330 node name with dtschema
Date:   Sat, 29 Jan 2022 18:56:21 +0100
Message-Id: <20220129175621.299254-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes dtbs_check warning:

  dma@7ff00000: $nodename:0: 'dma@7ff00000' does not match '^dma-controller(@.*)?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index 6288e104a089..af499049cb00 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -672,7 +672,7 @@ smmu_usb: iommu@7fb30000 {
 		dma-coherent;
 	};
 
-	dma@7ff00000 {
+	dma-controller@7ff00000 {
 		compatible = "arm,pl330", "arm,primecell";
 		reg = <0x0 0x7ff00000 0 0x1000>;
 		#dma-cells = <1>;
-- 
2.32.0

