Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939D652A104
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345636AbiEQMAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345716AbiEQMAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:00:21 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9284CD44;
        Tue, 17 May 2022 05:00:10 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id i19so34183722eja.11;
        Tue, 17 May 2022 05:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PAidMuA0ZfVLTFeYOY0jFETaKP5wFrL8y0MLkBWu2Mo=;
        b=Nk38ea2oeCbD8O058H3VMyJ5yxX8JNiGPQpf+RzwZfoUMwizfXVES2qnc9DmjDPskO
         mdfUkp40tpgTIdf47RFecu2Jcdrw/5mMPCwVREBWaF7qwSwbX7ptM7FpV6GQIsoJkyRJ
         E65deQoZm31KLlt7aSQfFSKyC0j6rwfTIUCmg5AjVW9YZfTlp7mtbwi7k2bubvbQSolJ
         xWoFprG43WD5xZNMKS62A7dfGGM/L5IYE2WD0yTwBGxbwwJ6XxAKYHrtw8OI0FHnVf5g
         Ezkd4GYMaaCCiUzlnXmkn9P6dlzdsKO0yQCL6xI6v32ujTsjkac2WUYmaH8dS3JLt5HP
         AS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PAidMuA0ZfVLTFeYOY0jFETaKP5wFrL8y0MLkBWu2Mo=;
        b=vXx7jm7Ol55tQjJuZZYdkDCHVwRAguPZu9rnlgPyjweVHiJAbhnGOE3EYvGns9UtFr
         2GtY8RkpkNRWejhQIrK1IZ0vcDTs2HvR8qqtNorGMEcNoK6sYGxtb59d45GKSSaed+Zv
         /MUQX/PIX452/v1Zul6qid3k+fHv7WXjI9Mj6yf4GKCHd0NzEyQhF4wEiQM7X/l6AGvO
         J8bVk3/Wk/3RUoHRO2Jp9DQZys9rDcGLyzkOvJUPq+RWs0AD/VQogWhnSVrTXy+Hk8p8
         o08N/hXnmrhuGM56Wm31c/QGbxfjYNaXb6BgVkVjGX2ng7EvFgu7pIMm8iDGBamBFved
         55ow==
X-Gm-Message-State: AOAM530MI1DZjGa/KzX11z5J+LfZnGoyTxN13Eoi89HQv1hqlO/fc4E4
        LBPtNvi7B9Nz9rrciBnUI8w=
X-Google-Smtp-Source: ABdhPJx0xq/cRbDvNlIWIcAne3Bp5H3b6MmvrYn/C0TdCB8KTbJZ+25ILBRKVac9wWnRXsboSjTLwQ==
X-Received: by 2002:a17:907:7e85:b0:6f4:78f1:75b5 with SMTP id qb5-20020a1709077e8500b006f478f175b5mr19728011ejc.54.1652788809052;
        Tue, 17 May 2022 05:00:09 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id hg16-20020a1709072cd000b006f3ef214e20sm948793ejc.134.2022.05.17.05.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 05:00:08 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 6/6] arm64: dts: ipq8074: add VQMMC supply
Date:   Tue, 17 May 2022 14:00:00 +0200
Message-Id: <20220517120000.71048-6-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220517120000.71048-1-robimarko@gmail.com>
References: <20220517120000.71048-1-robimarko@gmail.com>
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

