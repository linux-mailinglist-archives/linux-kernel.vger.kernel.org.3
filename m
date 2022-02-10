Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0F74B0A41
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239414AbiBJKGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:06:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239405AbiBJKGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:06:47 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3ACFCF3;
        Thu, 10 Feb 2022 02:06:48 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k3-20020a1ca103000000b0037bdea84f9cso3535772wme.1;
        Thu, 10 Feb 2022 02:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y0ck2+Flg1Nv+YQQJK1Oj0F4moGp+OjHs+CYNxD2uz8=;
        b=a8P87qlqFA2/4FEtvmwzeI04KHyNPH7+FoKcSsiUykIs6yJnsgjWIEfGl0isyS0AF7
         UVKWLkp7E/7V4BLJuADG13m9FJ0VkF8Em2nIIg0r5B4Xukfwkd8x321smxXu7gPWjZYF
         uI5qpYl28fMUIjslfV3PkD7e+o256HXnQb4iJJgcR9LhIYP+4z2oUUtXPxIPPyMsHWaz
         J+gbEXh4zMbr01YpqRcX3HYcyuBfy9DKL5SIOJ6tfr0n0nbEn5ZXosFqLexLT5sq6Sbh
         2updAThX82ERiy8d4a3ocCBFPM2Q4usaLnKsHoZZlj62axCFkW2SVVFgwAnJ3BJEb6R0
         RZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y0ck2+Flg1Nv+YQQJK1Oj0F4moGp+OjHs+CYNxD2uz8=;
        b=Vh0yDdtpqp2gf5v0MyfLWjHk6Eaf/l5w7qzpikYZbJNnKxHlOtnr3ql6BCrX+0slie
         rNuL09AGG8laPuB6ZnWcVnqc3S0SrNHLmIxyzTEVJ17aBXUFz8EioZlOW9T27/EusoW4
         a7bckNzWyfmdhr6aZZmms4L/ejklsOeMwQA0zgezuyCn1a6K1ZcupsZRSwj0ykvOMpS8
         JYF3mz0YtM8gn5WGrcBreFuo4odroJtyIXF9eEtpadhhV+qvjx7m5Yh9siO1z+ZoihvO
         XyfxN0DYgQt/u/7HmUlbBUX0ZlBaug6SrXNdo42lmaSw2zC9O+2Xa7YgVqcPzkcy16qK
         rnJw==
X-Gm-Message-State: AOAM532YVq9luOJp1Rj+SKhF2/D/fM2TD4oEgZDTO5n194GN65W6aQHN
        MYqetVP4QduVSsxuAKsIxXgpcfDFW/WqTw==
X-Google-Smtp-Source: ABdhPJythzp7JbMzxyxftp7l97OVurj1aMwR3pc9YOlmUz+tTRyenoz4dHM6xCWl5VM+txLC23vzOw==
X-Received: by 2002:a7b:c201:: with SMTP id x1mr1546625wmi.102.1644487607336;
        Thu, 10 Feb 2022 02:06:47 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id g15sm18817494wri.82.2022.02.10.02.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 02:06:46 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 2/2] arm64: dts: meson: remove CPU opps below 1GHz for SM1 boards
Date:   Thu, 10 Feb 2022 10:06:38 +0000
Message-Id: <20220210100638.19130-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220210100638.19130-1-christianshewitt@gmail.com>
References: <20220210100638.19130-1-christianshewitt@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic SM1 devices experience CPU stalls and random board wedges when
the system idles and CPU cores clock down to lower opp points. Recent
vendor kernels include a change to remove 100-250MHz and other distro
sources also remove the 500/667MHz points. Unless all 100-667Mhz opps
are removed or the CPU governor forced to performance stalls are still
observed, so let's remove them to improve stability and uptime.

Fixes: 3d9e76483049 ("arm64: dts: meson-sm1-sei610: enable DVFS")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index 3c07a89bfd27..80737731af3f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -95,26 +95,6 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp-100000000 {
-			opp-hz = /bits/ 64 <100000000>;
-			opp-microvolt = <730000>;
-		};
-
-		opp-250000000 {
-			opp-hz = /bits/ 64 <250000000>;
-			opp-microvolt = <730000>;
-		};
-
-		opp-500000000 {
-			opp-hz = /bits/ 64 <500000000>;
-			opp-microvolt = <730000>;
-		};
-
-		opp-667000000 {
-			opp-hz = /bits/ 64 <666666666>;
-			opp-microvolt = <750000>;
-		};
-
 		opp-1000000000 {
 			opp-hz = /bits/ 64 <1000000000>;
 			opp-microvolt = <770000>;
-- 
2.17.1

