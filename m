Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3701852AD10
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 22:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353105AbiEQUyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 16:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353043AbiEQUxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 16:53:54 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C6E52525;
        Tue, 17 May 2022 13:53:51 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id en5so497547edb.1;
        Tue, 17 May 2022 13:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PAidMuA0ZfVLTFeYOY0jFETaKP5wFrL8y0MLkBWu2Mo=;
        b=f4MOu4Orlds854J3Sjm8sYUcUV6qSn/fZ3l9OYZ5K4F6E9Y+oC9AAPkLy1eqvHjE1x
         UuvM6w59Yo6rsmK78I+ZHrd/IztXVyb/mRdR4OH0jE2mytYs8Yd5ezAwobp/wQ1b3WeD
         RgwIR/h8ABXxMXdBQylEYsuJZORtjxui+R2NfAtNZGsDkZ21LCgCFvIMGzxJUBOEMfG5
         pyN9n9jLL5Vctr/o3kXuIdl0xfyC2UXnNiXVUY9j7ZnTwPTh3bmMWEyPSeJVZxpzDFE5
         NRZfhXtqNBvEKJzO/I48LMBCd17P38CmAO74EMEki0I0d0K2uiGnx1k78oKjx0/c79k0
         4l8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PAidMuA0ZfVLTFeYOY0jFETaKP5wFrL8y0MLkBWu2Mo=;
        b=SvylEEoHuclOLFxf1kLZI+4jQxDOjUQxlDPninok2g1TiTpsHqM2eNcnhtHOjPHFzn
         rhJxeokdKWSj7BuxYufI+z45xduItz8OKC74YAQTTN71A5niYvrsW0rpw5ZVYSEi+vOP
         kTfUtorQO1kMprnBD3b0iJVYpuEFTXmz/u3oUVvp9ZoXmrYKrUoWJhbvdRUc9kMwFUsy
         x4MWu3EAgNYE3zSb3w9xhX/yA3hwq3skKPhfGnyudtobUNwmrcYMAISA2eQJTuLcQu+y
         05jKK0C2M0sM8vOarMwaiUvA+tBfJlng4JtX+znSaGunpHo1Lrn0aeDOK0qvaltZz76X
         8UJQ==
X-Gm-Message-State: AOAM5321dqhfZYDj9ScOv0pAHHGbRjxO9yb+Upk+TzuV2hY0ZnTYB7om
        fb4cq8bN8c3pv2FcVFCKtwc=
X-Google-Smtp-Source: ABdhPJzHrBMHkcmpaUrEVq9M2mG0iY3Zq86tClH9XaiJXLfERoeVAlOjyc20MwK4KfGezBnTR1SIdQ==
X-Received: by 2002:a50:fa8e:0:b0:42a:b1f4:91c7 with SMTP id w14-20020a50fa8e000000b0042ab1f491c7mr12779105edr.140.1652820831573;
        Tue, 17 May 2022 13:53:51 -0700 (PDT)
Received: from fedora.robimarko.hr ([188.252.220.143])
        by smtp.googlemail.com with ESMTPSA id v22-20020a17090651d600b006f3ef214e10sm120907ejk.118.2022.05.17.13.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 13:53:51 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v3 6/6] arm64: dts: ipq8074: add VQMMC supply
Date:   Tue, 17 May 2022 22:53:41 +0200
Message-Id: <20220517205341.536587-6-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220517205341.536587-1-robimarko@gmail.com>
References: <20220517205341.536587-1-robimarko@gmail.com>
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

SDHCI controller claims DDR, HS200 and HS400 1.8V support, however it
cannot achieve those using the 2.95V I/O that is the default set by
firmware.

Since we know have access to the PMP8074 PMIC provided LDO that provides
the I/O voltage set it as VQMMC supply so that higher speeds can actually
be achieved.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index d1a0b77c38a4..fea3c4ee3565 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -476,6 +476,8 @@ sdhc_1: sdhci@7824900 {
 			mmc-hs400-1_8v;
 			bus-width = <8>;
 
+			vqmmc-supply = <&l11>;
+
 			status = "disabled";
 		};
 
-- 
2.36.1

