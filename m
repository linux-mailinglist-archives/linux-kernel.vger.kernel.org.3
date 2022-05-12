Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1107524D79
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353962AbiELMta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353944AbiELMtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:49:17 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961DC24D5BA
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:49:16 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id l18so10000749ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JRHr7fdKzwvGcxbeg/0F2EjB5DJIbPSUWRot3RR3KEM=;
        b=5qOD4m+rBHldN3nysblgLsH8WptxZXeWg5hx6uJu3cbY2IGpK+yqPo0D9LlT2NN16E
         E4OyeFyGj8+nWQkxMG8rwSFnrfjUh5s8zg/81RhxraPhqufoajLtqieo5ayU+N7neqd3
         etBerYcEppc3g1dczYesZFKENQWRT0NwCJaILKYNQLpJ/QQ/olSeXlsikKdYeDNNg77t
         KiJVbi7iyF3TcBkZpDGTblA++wOYF3NOivBt+zUs7zdVvoJwilBBiCZ4WKeRj++svovi
         ePsQubUWVxw1v87rHF1GKT/qmQtofag1Vpkn025cWjwVpPwnGVMOVE2SgThziS/AXCvu
         qwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JRHr7fdKzwvGcxbeg/0F2EjB5DJIbPSUWRot3RR3KEM=;
        b=02yPfOfG6iCINURCCzJ/WKEF9QIah65htVIXm6ASX9EXwPCE7Kec44OGLfeMd0TJuM
         I7+rpcEuuE80lyemLl09QzB7WB5cHYhTSqycDFHku46TukUoOZr2V/ZxDREtsKmrQICY
         EH5KGiWef/tXq04dBw5TTz9xMw3WCaORELYnq3f8v3ljDw+0XpL3mIak9xyTpP67++Lx
         BTAr5IYZTHLHnMN/EByCYlxmQjo/9NXoNtPx/nuI2U9TWEaK8kzTfvEqVEk2qVhVNSW2
         WQz5f3e24QV5yhHVH/FQ1FVYtxojfQJ5OAYA3ARU2H25oshnpQEkhttqe3kyXwx0w5A3
         fmvA==
X-Gm-Message-State: AOAM533ljYwsT5D0MT42vECpMYRL4YMedGGMJ1WC6oJLb1WE4Y5LpOAg
        mJeO3YwLhypWdwWwvMl137ZLLw==
X-Google-Smtp-Source: ABdhPJypzDPM2tzbDNyHxubPQ3WDgA0YQyMnGC3nOD27vkwpwtsGZKgEbnWRKML0sYHEC6aYdbAS5w==
X-Received: by 2002:a17:907:7b89:b0:6f4:9b92:c2ac with SMTP id ne9-20020a1709077b8900b006f49b92c2acmr29566908ejc.409.1652359755126;
        Thu, 12 May 2022 05:49:15 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-58.xnet.hr. [88.207.98.58])
        by smtp.googlemail.com with ESMTPSA id h3-20020a170906828300b006f3ef214dc2sm2109475ejx.40.2022.05.12.05.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:49:14 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 03/11] arm64: dts: marvell: espressobin-ultra: add generic Espressobin compatible
Date:   Thu, 12 May 2022 14:48:57 +0200
Message-Id: <20220512124905.49979-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512124905.49979-1-robert.marko@sartura.hr>
References: <20220512124905.49979-1-robert.marko@sartura.hr>
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

