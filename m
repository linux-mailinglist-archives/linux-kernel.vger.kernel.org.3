Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFB2569F84
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbiGGKVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiGGKVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:21:05 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5D12BFE;
        Thu,  7 Jul 2022 03:21:04 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id os14so1351393ejb.4;
        Thu, 07 Jul 2022 03:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HrlXbWcFJrYmmGnhnXwnzHQ6nR1vAZ5/Ttv5TKyVVz4=;
        b=UCj6ApGM3N18S4Dt6+Q/gWKy471ZadLbdHEBNZYY7fAFoj96ja0DQ8peadnrNHhcpj
         SgKq0gPFfER74+4i9/CVV/ydJR0Nhe05d+1v8qBAW50OLh22cNNJqDwDzKODt9EIZrv8
         MzJKifym6vd44Tr00zz8PKAYu7c0VgR0Dg22MVYDwGR9RwPpaRhB/IuJZVxnjnis/xxo
         1Kg3gqw0aW8DaD1qhEd27dqCPUsx3qbNkVlIHReBo6OauksoixspoXUd9yZN338gs7H5
         6RzNGRoagTdEqOxyr7dOq53ElZhRSC7W6DwYYDbklAUrNiRCJCXvd9gYfp8RrDX7rugi
         5sFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HrlXbWcFJrYmmGnhnXwnzHQ6nR1vAZ5/Ttv5TKyVVz4=;
        b=fKgvPKp/1TxG37eHxrMx4gT/Nwas9JetJiDk3ipTbW6GLMWMt6c1D6yS6cLDZwACxf
         cBP7Jz2Xygl8MABS4ShG0HwF7HLJy9v0oZ67q8qOHzruWfUkXLJgYPTKXEbJsMjfS7qm
         L+ZeA9RNsbkAb8hnF+gXxIxRDetcYXfUMJcg6tVK+VlsA3vVh6GtDF1zywotkaJ/99wC
         x9qaDIIUHe2SLnWstcAMZ3/qbe0vCI7rTAFTR6NHGHtXC8NpFKEHeoOoueSQZCHBuqag
         8TRuY4DUpZn6VPXSznfVy8sBMoM4uN2VqNT2bpQVS9wJzVfoKbG6r6B9+d45jyctlFaH
         Deqw==
X-Gm-Message-State: AJIora8YLUkSc3e/Iz7go+gAb1WyfBxoID3wcjpUuSOnDsRXl8ieMADb
        OzqvCKXJLfxkfMyeA7wG0ng=
X-Google-Smtp-Source: AGRyM1sq7ZRcrYah2UHhGSyBOrApze7sDmVHy7kME8pHSFycaghvbLni6IQQc4763QMY6dWCY2z0QQ==
X-Received: by 2002:a17:907:9725:b0:726:c820:7653 with SMTP id jg37-20020a170907972500b00726c8207653mr45191077ejc.633.1657189262747;
        Thu, 07 Jul 2022 03:21:02 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id s22-20020a170906a19600b0071cef8bafc3sm18701117ejy.1.2022.07.07.03.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 03:21:02 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/3] ARM: dts: qcom: add missing smem compatible for ipq8064 dtsi
Date:   Thu,  7 Jul 2022 12:20:40 +0200
Message-Id: <20220707102040.1859-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707102040.1859-1-ansuelsmth@gmail.com>
References: <20220707102040.1859-1-ansuelsmth@gmail.com>
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

Add missing smem compatible and hwlocks phandle for ipq8064 dtsi
smem node.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index cd1b43e2cab4..ff1a2acb1d83 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -292,8 +292,11 @@ nss@40000000 {
 		};
 
 		smem: smem@41000000 {
+			compatible = "qcom,smem";
 			reg = <0x41000000 0x200000>;
 			no-map;
+
+			hwlocks = <&sfpb_mutex 3>;
 		};
 	};
 
-- 
2.36.1

