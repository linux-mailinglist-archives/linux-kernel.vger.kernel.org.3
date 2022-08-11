Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC2658FA79
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234702AbiHKKJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbiHKKJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:09:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43759923CD
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 03:09:35 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id ha11so17277160pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 03:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=lSBY1yS1Xw97HWveifQYja2PT0/x+CrBFQy17+c0BDU=;
        b=TUL9B3XAN9V+HnYPC7vRcSjCTLS5cPUYnF6JXKd1JQONfRAsJEkpfUx9cmUNxU699x
         Qua5/zKAuevA2FrhFoT3DTPyaHF2bD79odM6WGIo7ABmiA35Ovhiybpe1y9JXE5Ku1yI
         7d/r+qC0FYVRLz9mMyvyRNTIWWcpVeGIwH3QM8UWtQlAXt3PMYR/pKNzfAWt6B6HjLwD
         7TAaiA84zBJMFG7S15iQgnppjkrRW5V4TMAVBTm9lLbrg5tyCNeJ4zRlmgGYes/qqyeN
         2IQfUwYWCVXCUAD4pYxDyi2rENe9YbhcEJAVqKo20AhsuO5zJEonfESC8MzeZhCR0MEv
         Ymjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=lSBY1yS1Xw97HWveifQYja2PT0/x+CrBFQy17+c0BDU=;
        b=NxLMouIeoTgRyCnxO/DCjpVSuKgN8RGTwP3PH59iXOodxFRV+Q3c8P0JRaQVyDr9kP
         NtSc1nU+V5cnZOI+sE9fMGKGxdtwacL+vJyfA/yiYCcEQTZcR6M2Eam+FOKFlmyVnCaR
         p5nJUPoJ8g7x9fb9U7zvla08R8IaJkSJNLGkarOJOl1LvHKhlfFesbPcdUxEP5RvYnAJ
         /sE5ObGDtl9sNB+Vh1GnFgtWrr2/YONmL99BhUGBuxPFzBsAqW/fWIBEDcSTe9SyrWO4
         +QR4KYDt/UYQMujSF3y7e/xY5m9Q9sDMPhcPbeYb+wZsAdEymNS7TT338E8VTt010dUr
         d4jQ==
X-Gm-Message-State: ACgBeo1WKWzsN5SJCFN01qNo6LcNDrbnAzeKUt387/0vjpnLETc7kLmX
        nO8GduA1b2PnNSoonHqBIkBu
X-Google-Smtp-Source: AA6agR43LqVirfFoBL1a+ABeiKghnUDzWk5veNNYowKakZi591/NWu4gjeClnI0TrFP2aMtmahs7mg==
X-Received: by 2002:a17:90a:5517:b0:1f8:a7ce:ac33 with SMTP id b23-20020a17090a551700b001f8a7ceac33mr3024058pji.83.1660212574700;
        Thu, 11 Aug 2022 03:09:34 -0700 (PDT)
Received: from localhost.localdomain ([59.92.103.103])
        by smtp.gmail.com with ESMTPSA id 1-20020a621501000000b0052b9351737fsm3714839pfv.92.2022.08.11.03.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 03:09:34 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org, ckadabi@quicinc.com,
        vnkgutta@quicinc.com, bp@alien8.de, mchehab@kernel.org
Cc:     james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 0/2] Fix crash when using Qcom LLCC/EDAC drivers
Date:   Thu, 11 Aug 2022 15:39:22 +0530
Message-Id: <20220811100924.79505-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series fixes the crash seen on the Qualcomm SM8450 chipset with the
LLCC/EDAC drivers. The problem was due to the Qcom EDAC driver using the
fixed LLCC register offsets for detecting the LLCC errors.

This seems to have worked for SoCs till SM8450. But in SM8450, the LLCC
register offsets were changed. So accessing the fixed offsets causes the
crash on this platform.

So for fixing this issue, and also to make it work on future SoCs, let's
pass the LLCC offsets from the Qcom LLCC driver based on the individual
SoCs and let the EDAC driver make use of them.

This series has been tested on SM8450 based dev board.

Thanks,
Mani

Manivannan Sadhasivam (2):
  soc: qcom: llcc: Pass SoC specific EDAC register offsets to EDAC
    driver
  EDAC/qcom: Get rid of hardcoded register offsets

 drivers/edac/qcom_edac.c           | 112 ++++++++++++++---------------
 drivers/soc/qcom/llcc-qcom.c       |  64 +++++++++++++++++
 include/linux/soc/qcom/llcc-qcom.h |  35 +++++++--
 3 files changed, 147 insertions(+), 64 deletions(-)

-- 
2.25.1

