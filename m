Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31EB54BE07
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 01:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357700AbiFNXBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 19:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiFNXBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 19:01:39 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC180532CF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:01:38 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso424881pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F4m9A8Qo6zOltjkzi0N0zgRLf5Grbh0WeCZKflLJ7DY=;
        b=vuq62C9vlXng27Gng4avkt6GXFI/9GQfRmTb1j/9RpzgytIr+h8bLihhhQ2Kdu8qxN
         U+0N/Nw3VoStnuJhi1y87mQxOG1cio2AKy7jHmg5PzX9HABxw99eoZH8NbNDLwKdran/
         fMfs22HceHQFa3ZNFgHaxWQzaVuRvEUx0a9d0DMc7Jqywcn0FIiLIIxTKKPYTkQZMJQi
         M71kLAhFrB9vsfTpMpS1gunPEJdIJ70J4KofJg1WUloyOIQVqeebQRQacQeatC2GYSUi
         XEiGzsqY2R9EQEVXD5wqx1AVGpGOSc9XCoMEGLgnWj17FTo4dnXsKWyPBO7FNhC+v8Um
         xy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F4m9A8Qo6zOltjkzi0N0zgRLf5Grbh0WeCZKflLJ7DY=;
        b=E93kfzerUwozJsc0Zbsp4bKPgzmmtu+MhfGYBhciHVRgM5CFCvRRCcukkVlac7YJ7d
         8WMzrOVztBOW0yjnSl1Udd/Gdkm6tJEBKQ+ptoQ66fJpXypJakYbfJNPjJrhdOsjCZVU
         kTQt6fA66vzkpgFgRx6Bu4oUdjW3AwJ3NzFxZMRKkKq2uk6igSDIE7J0UFrGFrxWS+Xx
         bnWsm/EMMK0R0Oa85Ax5E/x7w9Ebk1aaivPm5+30LkGs5++dR9FFhNhR8q5nL9UF6ryv
         H6idSzi5+ZEYmQ6zLGWjmbugy/NQ8+V3A4CbAjVjtb0LTOYgRMOfn9REYOlseqwWH1z6
         9erQ==
X-Gm-Message-State: AJIora8MU5QnXzEljeUWE0bJeLwC9008mhogrzCTnmFebZECBDKNUMEx
        w6HHVImRFnR5aTCpZDLUnvTT5A==
X-Google-Smtp-Source: AGRyM1sysLwTU+O4gfQ75Td7Y5l63JSZ6kQ5+2cLmKQHoxX1bX2xDe6Y/djjDLJekIO9y4ae3uDmHw==
X-Received: by 2002:a17:90b:1bcd:b0:1e2:c8da:7c29 with SMTP id oa13-20020a17090b1bcd00b001e2c8da7c29mr6858481pjb.4.1655247698383;
        Tue, 14 Jun 2022 16:01:38 -0700 (PDT)
Received: from wildbow.anholt.net (97-115-79-125.ptld.qwest.net. [97.115.79.125])
        by smtp.gmail.com with ESMTPSA id cp15-20020a170902e78f00b00168c5230332sm7787768plb.148.2022.06.14.16.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 16:01:38 -0700 (PDT)
From:   Emma Anholt <emma@anholt.net>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, Emma Anholt <emma@anholt.net>
Subject: [PATCH 2/2] arm64: dts: qcom: sm8250: Enable per-process page tables.
Date:   Tue, 14 Jun 2022 16:01:36 -0700
Message-Id: <20220614230136.3726047-2-emma@anholt.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614230136.3726047-1-emma@anholt.net>
References: <20220614230136.3726047-1-emma@anholt.net>
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

This is an SMMU for the adreno gpu, and adding this compatible lets
the driver use per-fd page tables, which are required for security
between GPU clients.

Signed-off-by: Emma Anholt <emma@anholt.net>
---

Tested with a full deqp-vk run on RB5, which did involve some iommu faults.

 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index a92230bec1dd..483c0e0f1d1a 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2513,7 +2513,7 @@ gpucc: clock-controller@3d90000 {
 		};
 
 		adreno_smmu: iommu@3da0000 {
-			compatible = "qcom,sm8250-smmu-500", "arm,mmu-500";
+			compatible = "qcom,sm8250-smmu-500", "arm,mmu-500", "qcom,adreno-smmu";
 			reg = <0 0x03da0000 0 0x10000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <2>;
-- 
2.36.1

