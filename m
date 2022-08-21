Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDCB59B5E6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 20:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiHUSSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 14:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiHUSSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 14:18:48 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D314167DE;
        Sun, 21 Aug 2022 11:18:46 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so9289455pjl.0;
        Sun, 21 Aug 2022 11:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=c7bGOCwCut3qJRTlJSLX/tQ+GZfNMJd7MaxTPLedcU4=;
        b=P3dwVwj3ElFzcjZaUJDdt6flBmuan50tBUY6b7hDWZFmqDSN9OLs2alfaT6XMsOYo3
         FDeIDa7PRo/TtuGvXJKZ4NVPSkCSL474me2baWzTNoG357uWKrB7Q4EgSSs4nfKSXQvz
         XJXmoQzgm937dSG/jaMw2T5DcO9bkCUFOVfSDbBhMU8vbYIxJQCv5dIw5RFfora9fEYI
         99bzHsi1qj6q6qYPa7IXMLHGy7PW/Ru61aTfqSe/xvbDlTiC6eNjy2N9F312nnmsaKN+
         urYPskRD8xI5V/iv8VRKsKUgP08hQwaJU+7b0yjDnyi3EF73NNjEDnGnCbdq6/+Gsrns
         Vlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=c7bGOCwCut3qJRTlJSLX/tQ+GZfNMJd7MaxTPLedcU4=;
        b=MdlK6AhVG9T8iu8hQwE0ggk4rvTQQCMTX+bvmyYN/3frsvwnXBhpYXk7fNG1ubP22K
         WFi+ZMck4qvnBlqOse3cBJyQZv5LXa7JH+KtI0W1Owwsh6agq3rTR2P2xTLdvYP4mCGM
         MI1hcPY6qiiOeBfvUQucAKa/AlYDefaS5owKXFXg3m87jUb5ZdsVDZUGYfBYg00vN2dy
         /rh4U5qs2UbNZ1oPMIxHsdcf3yEEiXompB8vqD+Pzupp+c5Ed3cpk71gKdrtCkcHJlj0
         RwFMaf1s28zbmyFEYzl3IXFB/SCj3ockVJ08hkr3BNfTfisb2+/kbwVoWW13GNVl1+AM
         DBCQ==
X-Gm-Message-State: ACgBeo3M2salMa7XUap+mTnQp3AXIY/Vn0LD3ZusoqrRKU4OnPmjycwH
        URAUKnaqebt5Cj2o7KhCStc=
X-Google-Smtp-Source: AA6agR57mA7zNviZGDBPe/nd5LlRYobJ2Lt2nZD/kVP6bCUNXwMGM4G4e4fsuQBTH/AKetIff6wKKA==
X-Received: by 2002:a17:90b:514:b0:1f5:59b2:fceb with SMTP id r20-20020a17090b051400b001f559b2fcebmr19459511pjz.82.1661105925043;
        Sun, 21 Aug 2022 11:18:45 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id z10-20020aa7990a000000b005364e0ec330sm3098307pff.59.2022.08.21.11.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:18:43 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        iommu@lists.linux.dev (open list:IOMMU DRIVERS),
        iommu@lists.linux-foundation.org (open list:IOMMU DRIVERS),
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
        linux-kernel@vger.kernel.org (open list),
        Loic Poulain <loic.poulain@linaro.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sean Paul <sean@poorly.run>,
        Sibi Sankar <sibis@codeaurora.org>,
        Vinod Koul <vkoul@kernel.org>, Will Deacon <will@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 0/5] drm/msm+iommu/arm-smmu-qcom: tlbinv optimizations
Date:   Sun, 21 Aug 2022 11:19:01 -0700
Message-Id: <20220821181917.1188021-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.37.2
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

From: Rob Clark <robdclark@chromium.org>

Two additions to adreno_smmu_priv to allow for a couple of
optimizations:

 + Use a separate ASID for each set of pgtables to avoid
   over-invalidation.
 + Detect the case of unmapping from non-current pgtables
   where we can skip the redundant tlbinv

Rob Clark (5):
  iommu/arm-smmu-qcom: Fix indentation
  iommu/arm-smmu-qcom: Provide way to access current TTBR0
  iommu/arm-smmu-qcom: Add private interface to tlbinv by ASID
  drm/msm: Use separate ASID for each set of pgtables
  drm/msm: Skip tlbinv on unmap from non-current pgtables

 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      |  6 +++
 drivers/gpu/drm/msm/msm_iommu.c            | 44 +++++++++++++++++++---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 10 +++++
 drivers/iommu/arm/arm-smmu/arm-smmu.c      | 43 +++++++++++++++++++--
 drivers/iommu/arm/arm-smmu/arm-smmu.h      |  1 +
 include/linux/adreno-smmu-priv.h           | 18 +++++----
 6 files changed, 106 insertions(+), 16 deletions(-)

-- 
2.37.2

