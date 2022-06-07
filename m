Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FC154051A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 19:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345949AbiFGRVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 13:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345561AbiFGRTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 13:19:03 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CE71053F0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 10:18:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id n10so36593174ejk.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 10:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dkxGKqfjlk2BseBFR/4rpL2eqUgP+7L5CxVKR6PZDHY=;
        b=jWjQn4yiof6z1wOf4VVqd3sJCsADu0ZkWQWoYH0kyxK0F/zYWpWqecY6/eNv/pHRcl
         9v66ISeM4TY7zIRNTjX3CvR/Mdq6CrwMAgtErEbS1t9qzOeSnlckxG2NypIYOLTfkxVA
         7tmfaMituYRQsf9F51jWJCtHhk98nZ+5pD42ToFN11jW/VrWZPA7jgck/yNqDoq8p3jG
         huMKxoaJyUZb1haqDcqBwEn8HJj0mNkN1qXj+6OGtgdh7iYgIqnfUy4gA9HvCWbU/di8
         2LHkBh0Q8YhLsHzsyGDH3jWmiwu+4tsclhTo7W0VpRPnEstPIodPDiQ/JXqYEqNJRJx5
         7I1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dkxGKqfjlk2BseBFR/4rpL2eqUgP+7L5CxVKR6PZDHY=;
        b=0FEaXjaEBSQf7uLqTCoES5BvCLihM4gdhdRUG1ANwNi9f9MYDcI9OG8c0EG2U8azib
         3+2Tdfue2uEkEBw40/7VNeoUZDRfoEmDzGy0oiaWyWuaZ/xJaQktVRAUcC5tp+mW/+oV
         xnuDqlh2uemRPBuM/ARQyjkznRe3kKD0dSrHnFvkDCdV1EsqOC4grXX7DO2zZpzX0S+G
         SZzpbvn0vyCNjTbWdfNemSnT9X+xyghyxKGzDHCiTP+hRIfVBC/x/uwfK70L2JOJ5VZ4
         ODZI6e5hi1x2ILAh7DtSnne0qrcNhgQh7CZetMhWWBCIZcgPr54CAp4QC4kw7fKnfn3G
         C5xw==
X-Gm-Message-State: AOAM530CxH6dj/PiIX7OxKu0NohVcs5+hNXeP1Sj/1xbzHFExdeA7jRQ
        AHDxYDemCgKyhCZb2VaS9OW3Kju+mBmX0w==
X-Google-Smtp-Source: ABdhPJwvVpI5kUxoZUY5o27MdTOXLLE+WxNK8SL79kihah8urA6NRTQcJkTareJ4XD6xl4j9eOMKFQ==
X-Received: by 2002:a17:906:2a86:b0:711:d8a5:cb0c with SMTP id l6-20020a1709062a8600b00711d8a5cb0cmr7919603eje.426.1654622338378;
        Tue, 07 Jun 2022 10:18:58 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i7-20020a170906444700b0070e238ff66fsm5876540ejp.96.2022.06.07.10.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 10:18:58 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 07/14] ARM: dts: qcom: msm8974: add required ranges to OCMEM
Date:   Tue,  7 Jun 2022 19:18:41 +0200
Message-Id: <20220607171848.535128-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607171848.535128-1-krzysztof.kozlowski@linaro.org>
References: <20220607171848.535128-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OCMEM bindings require ranges property.

Fixes: a2cc991ed634 ("ARM: dts: qcom: msm8974: add ocmem node")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Not tested on HW. Testing might be useful.
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 5e6b2ae72e62..add03309b3b4 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1608,6 +1608,7 @@ sram@fdd00000 {
 			reg = <0xfdd00000 0x2000>,
 			      <0xfec00000 0x180000>;
 			reg-names = "ctrl", "mem";
+			ranges = <0 0xfec00000 0x180000>;
 			clocks = <&rpmcc RPM_SMD_OCMEMGX_CLK>,
 				 <&mmcc OCMEMCX_OCMEMNOC_CLK>;
 			clock-names = "core", "iface";
-- 
2.34.1

