Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF151518A00
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 18:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbiECQg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 12:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239497AbiECQgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 12:36:18 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B488B3BBD0
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 09:32:45 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id i25-20020a9d6259000000b00605df9afea7so11649796otk.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 09:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=04yCZmGU5lzqSzWtLJBB88QnMJDZZhNGZmMLSUs6I88=;
        b=dLEzH+9nn42NpH9bp99fDk9o5mkKZIcYnxCBOKQGouxka2F4MSSjRNZhNb0Si8y9Sc
         70ud6rEYUP4HkVo6/wzp9yRcJRHmD4gFTLZUwJXVrVLFsvucctGevfPap7Yl2wT5CCL0
         FhNNP4zM2iICGBHY0TQ4C1vInUNTRBcHT32zKf5hBDcWQIVR9ErcIBjE1fB1vYgmPsQ2
         1cdQs6vehNNQ9nZbj0WRVqfzghWEGRtIsuRGrCT3ljv3ZELdqmRvA7PsdxF0yKF3dFlk
         cug3+bTG1pjOtdIcPDbL3xw/ODrwWrnDOj3BCTurkEXIfGa9Zxi0s7Cg33dZkDyMhayj
         vksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=04yCZmGU5lzqSzWtLJBB88QnMJDZZhNGZmMLSUs6I88=;
        b=Bv3Nxd0vH4PNKGkboNjoD8jGKHXj3iBZmp9TbEsI75yEfrR5pgzpjgTWaDF+53R4LA
         DS6vI8TfisiCTdeH4FSs4tsXHcnCsfRP4t+uy0LcPtCTUF7mjrU5o2J0MwcM9z+1tVV2
         lwsQUFcHIGpPSJXFYKF4etNh3b5B+iCGD2cWVpgluiJQpVDlp/rUSoLCuCiuQlRtFX/8
         1TeT2zfoNu5tBONpX2nsj1Z7W3YjbD1OhWrTekLH1AkgZM0P43KxxOTxfyF7T3LYLxOF
         ryBP9gKYcT0OEAGn2DF2MwCyd8JuLL5wVjXeU+j7w3dSymBqHL2Djaar21AHtcHrUihn
         sohA==
X-Gm-Message-State: AOAM531kXjer4TAdi79D/gr/crfmwdy1nd4A9mSUAq1x3OLJuob48ejc
        vLTyQ5Dd5Sy8O7CY8MF5LEKTmJRsUxfTpSyq
X-Google-Smtp-Source: ABdhPJywDb/F99erOQU7c9Pw2zLureldWnS8L5dkzeqKygYCexJlFz0vSdciswu6uJcP2b2UdmE59w==
X-Received: by 2002:a9d:68cd:0:b0:606:13c7:97c4 with SMTP id i13-20020a9d68cd000000b0060613c797c4mr4377387oto.312.1651595565017;
        Tue, 03 May 2022 09:32:45 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id v15-20020a4ae6cf000000b0035eb4e5a6cdsm5027404oot.35.2022.05.03.09.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 09:32:44 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iommu/arm-smmu-qcom: Add SC8280XP support
Date:   Tue,  3 May 2022 09:34:27 -0700
Message-Id: <20220503163429.960998-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
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

This adds the compatible for the Qualcomm SC8280XP platform and associate the
Qualcomm impl in the ARM SMMU driver to it.

Bjorn Andersson (2):
  dt-bindings: arm-smmu: Add compatible for Qualcomm SC8280XP
  iommu/arm-smmu-qcom: Add SC8280XP support

 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c            | 1 +
 2 files changed, 2 insertions(+)

-- 
2.35.1

