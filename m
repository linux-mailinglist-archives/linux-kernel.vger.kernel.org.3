Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5400472285
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhLMI1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhLMI1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:27:13 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B057C061748
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 00:27:13 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y13so48936299edd.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 00:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cDtUj/hlSiO5g1FDUhurbeKUU4tNZcuIesr1T0TKlmc=;
        b=JKOAHe8dnpkJ+TQT5DUqrc58eXknAEVGELeBHJ/rxL00PXNiwSzVa9h9GvHAYUTF49
         bRyiRu6vfvaAQgbyzP4izYuA8ktOFudGnHGQi2DVZ6f/Ovnh2A5LOhwo7WgQSOIlPZjX
         B7e1CoewgPSIauAhJHo9BtEIgHuxVQeKY+MmgsL86+AlLfk67MVSNQyPTe1K51YmNpa2
         emQY1aEd0W6tsi1wZXQuHoqPZigOTFurJoeJ3/R2+m6gWooxdLnsld2kaYRp7Cdl5Rdw
         yPCYxnvVo9Wi7OIhs8LqE3yI+EFkSwa9REgXkqKDgM4ztv9qQ/Qm0tWchpYL8qTHKwpF
         h6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cDtUj/hlSiO5g1FDUhurbeKUU4tNZcuIesr1T0TKlmc=;
        b=0lVTooEyedoQDxNMxUgeSDXSKoHAo3TOpzA08mIj+ZnA+K6iDAfE8zXh8Y6BWdqg8C
         ZcTkNlXdiKcz6YjlZ8rbCxTS36rwnIK0JSQMBq1a63+0InP8jDHCjPsZW2F0E0HbLGi3
         GQgipoO86DzC5FkbQhErNQD6i+PMCmYGN5rzDH6F9CwX1kD417ZDHZmm1vUiNgOWXwq5
         qHz4Je5VlR2YA0IIcM0jSz/eloV9kvNbpIBJ3etGfI+6e3bM9Sff+xKkozKI48xlETqF
         CqowuorSr2x+Ypef/ZybXiqSSlOjztmHdTHH9yrYXgtE86mp1oCr+DQXncZ/Byj896fu
         4iOQ==
X-Gm-Message-State: AOAM531qNPoq7YeoQqGHsj6xicEpAn9dLtAEZNgZpl2E+zEW4LsI6bWg
        yqxDRc46RbVSkUPsYX//+PUuCA==
X-Google-Smtp-Source: ABdhPJw5onQbiuMOz/yLVf54mM8clTCXpShvsuZoDLU01mffQrGmnABnLtacCGAMfHCbMBCbL4J5EQ==
X-Received: by 2002:a05:6402:1450:: with SMTP id d16mr62634702edx.144.1639384032013;
        Mon, 13 Dec 2021 00:27:12 -0800 (PST)
Received: from localhost.localdomain ([2a02:a210:20c5:8c80:7d0a:cd68:c339:f426])
        by smtp.gmail.com with ESMTPSA id b11sm6062432ede.62.2021.12.13.00.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 00:27:11 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] dt-bindings: arm: msm: Add LLCC for SM6350
Date:   Mon, 13 Dec 2021 09:26:02 +0100
Message-Id: <20211213082614.22651-2-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213082614.22651-1-luca.weiss@fairphone.com>
References: <20211213082614.22651-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Add LLCC compatible for SM6350 SoC.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Please note, that this patch is a resend that wasn't picked up when
sent to the lists in August 2021.

 Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
index 62fcbd883392..e12fc7999356 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
@@ -24,6 +24,7 @@ properties:
       - qcom,sc7180-llcc
       - qcom,sc7280-llcc
       - qcom,sdm845-llcc
+      - qcom,sm6350-llcc
       - qcom,sm8150-llcc
       - qcom,sm8250-llcc
 
-- 
2.34.1

