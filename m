Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2075215D8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241990AbiEJMxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241961AbiEJMxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:53:37 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB811A0750
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:49:39 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id i27so32700289ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JRHr7fdKzwvGcxbeg/0F2EjB5DJIbPSUWRot3RR3KEM=;
        b=7D+vrVq8SA9FoVNefbDHdQ5HvTkCS8UrjB4ImiKDgRwrJ/fNixNn1wMl7oNxsL8vp5
         ptxtc4frm8gMQrkMBmpvi+qhcIc4yNYlqteBz8662mxEpy2T+hXdzWlR83ycKXR44eUT
         goF/UgCIq4yYl2y7JmgKu4mxberGycujdng7KVT7o45eXt0jNFhGoeF7aW9pTt3GpuaZ
         BalF62lA9VjP5wkiegCS5tq7L35Bcj7QsMu1J9dU7fbXkIEa1sgpKD0Q3RliUiOaLK9N
         xCOSgXUmlmiXzDPTYDG4+LvxmPsqlweDBbfkGVtuFgw3gnTyhXtklu6+924qYJVKYsDF
         JXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JRHr7fdKzwvGcxbeg/0F2EjB5DJIbPSUWRot3RR3KEM=;
        b=n4gzCmrZ2h3RUMQuoSEw3Cp+9h3FaiGxl1Hdg2swMeavYsHFIXTwymVfr/uVSlKE5m
         IRiog8HRR/kAxrKJXj8tRzaODTv88A4vSmC70IY6CMdptMmWTeEInijgA7PNd94ZEFya
         /u63WX/hc+VNb4lUEO+LnOX1NjT/Cl8hsFPPvQAC8pT/YQV/Ntk8xefaDmBc465jVwh2
         vCtvlJXmPAXxQgMMLuH63vjkQDsG/PaI2iHtOlKzG2j1lUbWdUMjTcorSy8STtzGF1Ui
         dVAoRNEuGcajIva34XlIYgWVUXx8ebZHoZu+ZFEEEQTMhop6Qyt4FcC4eIPaFzG5gwlb
         6BHg==
X-Gm-Message-State: AOAM530c1Epxc/1Jh2DdnNiNzpW83t3dNrcWKKY+2he38L5fGDhm6JMn
        G4rNkJwlUoyPTRdvBq8H0igvrA==
X-Google-Smtp-Source: ABdhPJx/IJLiklgOedQhCBVh5VP4GbNTBuqGvGM91QlsILf4QLz6AJpZ3liRF45O7ycq7tF91hrmEA==
X-Received: by 2002:a17:907:62aa:b0:6e0:f208:b869 with SMTP id nd42-20020a17090762aa00b006e0f208b869mr19568202ejc.270.1652186978368;
        Tue, 10 May 2022 05:49:38 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-75-cbl.xnet.hr. [94.253.144.75])
        by smtp.googlemail.com with ESMTPSA id gz14-20020a170907a04e00b006f3ef214e62sm6094290ejc.200.2022.05.10.05.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 05:49:38 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, pali@kernel.org,
        marek.behun@nic.cz
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 03/11] arm64: dts: marvell: espressobin-ultra: add generic Espressobin compatible
Date:   Tue, 10 May 2022 14:49:21 +0200
Message-Id: <20220510124929.91000-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220510124929.91000-1-robert.marko@sartura.hr>
References: <20220510124929.91000-1-robert.marko@sartura.hr>
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

Espressobin Ultra is part of the Espressobin family and shares the basic
design, so add the generic "globalscale,espressobin" compatible to it as
well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
index 070725b81be5..1b2ed63ae6a2 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
@@ -12,8 +12,8 @@
 
 / {
 	model = "Globalscale Marvell ESPRESSOBin Ultra Board";
-	compatible = "globalscale,espressobin-ultra", "marvell,armada3720",
-		     "marvell,armada3710";
+	compatible = "globalscale,espressobin-ultra", "globalscale,espressobin",
+		     "marvell,armada3720", "marvell,armada3710";
 
 	aliases {
 		/* ethernet1 is WAN port */
-- 
2.36.1

