Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F804D39BC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237457AbiCITQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbiCITQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:16:21 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDF810F20A;
        Wed,  9 Mar 2022 11:15:22 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id q20so1959424wmq.1;
        Wed, 09 Mar 2022 11:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y2ijFt03dHXxcoDcQFOfQPjXrq4H+kU/r+XzRRWfdfM=;
        b=Q+XEkPytADDQssHntRockYd8wU+dmOUlrbwnNGE8V4BuNSNFvY5YGQ2rFqErTLXyt9
         Kf5tcMstqdM+sbkQsfXZraBGsjzqtSAwOp5yV/FHFIY9+C0lD00gmpEOKJ31LUhWpn3l
         jdooePwS3t22OeyEQYUXkcH2lNqShdqekJd4abDHMm2+F//BRaZx/6xwvDH9XEgwLjh0
         CCmRj5rRyx2VwImwSLqNZfODOAIej9WpYc0PiS6juAytrgwSAw4ZPLrsy2pP9gJKC5fj
         3SUA+qOFrIE4H5Epueo7pvU22gx/2u/VZtOtGmCXc1ccQhF1em7gNgmQQqrdeHhQdCAn
         0NpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2ijFt03dHXxcoDcQFOfQPjXrq4H+kU/r+XzRRWfdfM=;
        b=zp2xEpgPWNZcAuU4+SGsVusJlAyklxNov6kICMwYjlWpNutuIjABkSu+ZLWtSnjGGB
         FtEwQHBH/WeP1u/QAHREmP0pcXIyuNJMu83MOhuTBBoeQR+gMjUCxXjzhWRTCfkYRL0X
         bXQuIpvR4wxBr/gawzHJVY9Z3VoThAe5tz+zvhA9vfhDsucea9Fm8ot/s8V1D2LeqPZe
         ChdtVJXmheFuyVroZ4lLl/IGVC//uskF4Q44FCmPPcreKR2eNJZP+zV1tV+sA+JwmkL2
         BcnnYM8Ey2cJfjbDyKTBaBs7HysbaN02Prjs75ZC3Z+l95gR5va0fx2+R7pyoHH3disA
         qptw==
X-Gm-Message-State: AOAM533cf9PVJYdIRImQr9kWm+Aqrmo/Qb2H69Fr7bQKSg+Fh+C1HEHK
        G8/6T4nIWlI2MWdfb73FtxY=
X-Google-Smtp-Source: ABdhPJwhhHukP5Xme3/WHx/+AroRz1g8CAhtoAKHUjWl4zoPomq9a2EsGsPqCWqyvxrvRe+K3t28Bg==
X-Received: by 2002:a05:600c:1d15:b0:389:cf43:da5e with SMTP id l21-20020a05600c1d1500b00389cf43da5emr4567350wms.200.1646853320449;
        Wed, 09 Mar 2022 11:15:20 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-79-47-249-147.retail.telecomitalia.it. [79.47.249.147])
        by smtp.googlemail.com with ESMTPSA id w6-20020a5d6806000000b002036515dda7sm2396699wru.33.2022.03.09.11.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:15:19 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH v3 04/18] ARM: dts: qcom: disable smb208 regulators for ipq8064-rb3011
Date:   Wed,  9 Mar 2022 20:01:38 +0100
Message-Id: <20220309190152.7998-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309190152.7998-1-ansuelsmth@gmail.com>
References: <20220309190152.7998-1-ansuelsmth@gmail.com>
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

Mikrotik RB3011 have a special configuration where the regulators are
not the common smb208 controlled by RPM but they use a TPS563900
controlled via i2c. Disable the smb208 for this specific device.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Jonathan McDowell <noodles@earth.li>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064-rb3011.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
index 596d129d4a95..611a4a19631c 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
+++ b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
@@ -216,6 +216,10 @@ led@7 {
 	};
 };
 
+&smb208_regulators {
+	status = "disabled";
+};
+
 &adm_dma {
 	status = "okay";
 };
-- 
2.34.1

