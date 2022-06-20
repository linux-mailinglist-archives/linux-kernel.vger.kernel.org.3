Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F520552410
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245721AbiFTSg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245659AbiFTSgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:36:47 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C891F620
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:36:47 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id k127so5753396pfd.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cuXafal7oQMsPKjaUnSX0izJjoMCagq43H5IBdJoY/0=;
        b=HcNySfWkztX+IpyLdapmB5uQv+0HIWkTNMKKAUBo24pLvsbYdt0MhDUZ8AamP/aZZs
         2GiClOnQwtLaUHbNNgwZvIlNV1NxAv09YX1qM+M8ZsC+t+woA8HTL0xrUUVHTaXgQtFA
         8FBuTsB4XH9nq191ZTS4LYUooQk7H8oCGm9lmcuJSIiPLFVJ0s8wxOaDHR7c3PAHwUYk
         kkRkFNINd50B/k8Y+kWGdSjF7SLflNWx8DLSASQPsU02g3sr+8mEyVN+hHwDVzV9fGJ+
         iLaRwn7xGaqfvxbirLEalktbZwqgl36/g2RknT6Z1hinMikKYh5wNN89zPcWPQ4H9C2P
         uU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cuXafal7oQMsPKjaUnSX0izJjoMCagq43H5IBdJoY/0=;
        b=Nl3U9HuAvfHV8yapbjorAv+pMEi8bddDTP25DaXftROUSaQhOvb7tQkseS1W3qkuPu
         VQy5Mm0MVFa0Q4UHAmRNTDe3m31VEgPvusCIbywPEfm/dO9f4j5NYM0jL1Aj7yJxdQ0p
         vDrHuHrsnkn+ck6T/8fQNi3heRttuWhlLUpD4zGrXofR0vlTZriNlbKTvwuucrc7/cMF
         MTFKCtxkmKNtHHx4ibokItaYOv4a0Lhr0thtMrJRtSuy7l6pUtRsysW9HOU+FwtpRqnm
         jNoJ0oMXGh+rUhSpsEMUMAQ2t7KK30JMfTvsvEyNaxW/2bHY0geAd4EBIfXw7m0PAD6K
         7vow==
X-Gm-Message-State: AJIora87zCMv9IrQoBi1Tb8BEQgsoRliKg3gNnhwquTwkltkmIozv73t
        OfepguwcVf6q5dN2s8LunC8ifw==
X-Google-Smtp-Source: AGRyM1uaVMxPdAdbEkr6R5BXQkH4b9IPtINsC+QUA2arv2IQf8W7zqXF2oWl6/UIv0I4Iw1fk1cI2w==
X-Received: by 2002:a65:404c:0:b0:3c6:4018:ffbf with SMTP id h12-20020a65404c000000b003c64018ffbfmr23272611pgp.408.1655750206723;
        Mon, 20 Jun 2022 11:36:46 -0700 (PDT)
Received: from wildbow.anholt.net ([97.115.187.17])
        by smtp.gmail.com with ESMTPSA id ds12-20020a17090b08cc00b001e0c1044ceasm8500041pjb.43.2022.06.20.11.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 11:36:46 -0700 (PDT)
From:   Emma Anholt <emma@anholt.net>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        Emma Anholt <emma@anholt.net>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 2/2] arm64: dts: qcom: sm8250: Enable per-process page tables.
Date:   Mon, 20 Jun 2022 11:36:33 -0700
Message-Id: <20220620183633.1131760-3-emma@anholt.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620183633.1131760-1-emma@anholt.net>
References: <20220620183633.1131760-1-emma@anholt.net>
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---

v2: moved qcom,adreno-smmu earlier

 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index a92230bec1dd..aae7b841b81a 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2513,7 +2513,7 @@ gpucc: clock-controller@3d90000 {
 		};
 
 		adreno_smmu: iommu@3da0000 {
-			compatible = "qcom,sm8250-smmu-500", "arm,mmu-500";
+			compatible = "qcom,sm8250-smmu-500", "qcom,adreno-smmu", "arm,mmu-500";
 			reg = <0 0x03da0000 0 0x10000>;
 			#iommu-cells = <2>;
 			#global-interrupts = <2>;
-- 
2.36.1

