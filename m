Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3185236A0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 17:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245526AbiEKPDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 11:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245544AbiEKPBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:01:30 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AC8E026;
        Wed, 11 May 2022 08:01:27 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id hf18so2211602qtb.0;
        Wed, 11 May 2022 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1+0VMWvkb5KhIaQ1vIx5DoEhMwYXv8cN9xgLJnTJYLQ=;
        b=mRKrlFNGn5IbBhXKT/0K+CcQIBoIcJDeXtaQHe6SoiiJ3T1hka4jtIcnqUuffq725v
         hPzBAl/d5PCCjf/aFdsx1HSmuwEhBOSHm0CmAlgqWws19GOF0Qw2+6amUhSeXnTuwbrR
         RbZ1J27qWdAePKn8X195kQVjfqgz0VZDQVPM0Sd2p+u2SB7/yjzRZCJ18dGoOWk+cYcq
         GIbgTWKbfZoDyV0O6YN02szADxJb0ot8l5O7l6CX+GxKz4OV2mtoEg2gDClc+klt1O/A
         Eyqij7JRO9QkV342d8baxgcl1dDfGhvmAz9TU1tGP5DJLbkbLbgmrSTJ0vRiFSeX67k1
         lQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1+0VMWvkb5KhIaQ1vIx5DoEhMwYXv8cN9xgLJnTJYLQ=;
        b=lTVuHtqs05YXg+1d27NLsbbxzxn4wdotEcjFLljusMc03XmxQ02GkQ4TYhsj3KgcaD
         78xpNdQ/U8ww760WwN/QUC8IFdlp0urndxTfGS2OhGvfLQmDB/bY74BUfVg3Y6PRMjZ7
         pfVqtTeAKZJzUaNYJJLWuR+YnpTtS6dkxm6+eIqhx3RxAqjmFg6rWYnil7HWXYWmTuTl
         2gOqLv2BVazMIgKw/U2vxmpRJvKGPuBMqsxGqdYKlVqwxhthmfSP438RDtkLByr5NqD0
         qM7wZGhg1MAqUKHzoxlfYCWEA1fkfiISQMkzvFVqIsqZw8icPGOTN/a6qG0Q5hbBEoCv
         nUlg==
X-Gm-Message-State: AOAM531u4ZBjC1geufnMidjDghXDadw203+FSm8LhvDb+oBcNFt4bDYP
        k0tZ4dDCuUkcRE47MgHyspA=
X-Google-Smtp-Source: ABdhPJxjiw+10SAJyJBRk1SuW3dIg3jBhQFMKieH82FSOH5Tb12OHXebD6jBjE/GmPefF6g0dMS8nw==
X-Received: by 2002:ac8:7f43:0:b0:2f3:d55d:7296 with SMTP id g3-20020ac87f43000000b002f3d55d7296mr15820698qtk.635.1652281286126;
        Wed, 11 May 2022 08:01:26 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id h1-20020a05620a244100b0069fc6484c06sm1487134qkn.23.2022.05.11.08.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 08:01:25 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v1 6/6] arm64: dts: rockchip: enable sfc controller on Quartz64 Model A
Date:   Wed, 11 May 2022 11:01:17 -0400
Message-Id: <20220511150117.113070-7-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511150117.113070-1-pgwipeout@gmail.com>
References: <20220511150117.113070-1-pgwipeout@gmail.com>
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

Add the sfc controller binding for the Quartz64 Model A. This is not
populated by default, so leave it disabled.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 .../boot/dts/rockchip/rk3566-quartz64-a.dts      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index 71df64655de5..6ec349e7e521 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -603,6 +603,22 @@ &sdmmc1 {
 	status = "okay";
 };
 
+&sfc {
+	pinctrl-0 = <&fspi_pins>;
+	pinctrl-names = "default";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "disabled";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <24000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <1>;
+	};
+};
+
 /* spdif is exposed on con40 pin 18 */
 &spdif {
 	status = "okay";
-- 
2.25.1

