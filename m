Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157B4552412
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 20:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245670AbiFTSgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 14:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245616AbiFTSgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:36:47 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF871EEE5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:36:44 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p3-20020a17090a428300b001ec865eb4a2so6405913pjg.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r8NdoW5AddDmipkvsjih16CXPQjsU0eZxi3OxKkBmN8=;
        b=H+lKfc53MfoKWbnqFT89h/mhsoe7NhhEKrckelerE5pE/432Z3iaw7F1SU5lSMGrqJ
         FnKa6NPxdxUeaC+s00glxACfjiGk/WGnMJlbQIH6u00gpgD9cckUxtxVCnf1jyvOPQoU
         +fOslEDBVTSL1Gy7THBQtu2BMSdTLxqQeFir4ZRti+VfxfwhPYYzcwujuor+6XA5+K6l
         MO5/6PRdBvYtwVWe+/26N26yUtMeZgxY8fqyDx3J3uqp8zTy0Cu2L3YwStQF9WTEZpAb
         DWpePaBt/jlMP9L50HQ27nqGppXu167xQ65N079vLwRk9Ybn982GujmmWrz52Kjfdw0x
         84xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r8NdoW5AddDmipkvsjih16CXPQjsU0eZxi3OxKkBmN8=;
        b=45HOJf2kgxV1FTygAQ/lNCE5whfxFD1FtcVznl5OA1XkYNmlZMLVO5/S6GLRqJbPQ9
         WKWJBGZYh4XKRQriPvXwC2QBRCQS9aZONU1hyXOFo1hVRw5EOrSNYznv2hQxFLITo6T9
         VD92RIEs7dYGfIKWTkfvP2MohL4pbxWH2guFbrpRXffFKbDMtvZxAE4LFa+pgJZmKhwK
         pE57QBjthtBg/pAmBsUVUXcSj3VnNwPjntFC7SchfbTc9Vi9q4tz7v0nXv1FvSbDxSfW
         WX8a3yDNv4+uCARzGfhlh9YPvdJxXDIKKTRncxHNoe5mq4ha1ZIAPZUWm/n9bqMmkjcT
         az+w==
X-Gm-Message-State: AJIora83rTNmAORBX9aaJErCvhnq3nUoOnslon5d/XXOpQFO8J8HvfNW
        fS6EnnlqQALsoHMDN+k6ySR6OQ==
X-Google-Smtp-Source: AGRyM1uQfz7pZ9DWLMJTwN2MFiyDfq/jBEgrSB5FWoXIJh1Yc8zL8k5KuFSfqFGI+JOH70LUpG/riQ==
X-Received: by 2002:a17:902:d718:b0:168:d9df:4f1c with SMTP id w24-20020a170902d71800b00168d9df4f1cmr25205344ply.41.1655750204246;
        Mon, 20 Jun 2022 11:36:44 -0700 (PDT)
Received: from wildbow.anholt.net ([97.115.187.17])
        by smtp.gmail.com with ESMTPSA id ds12-20020a17090b08cc00b001e0c1044ceasm8500041pjb.43.2022.06.20.11.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 11:36:43 -0700 (PDT)
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
        linux-arm-kernel@lists.infradead.org, Emma Anholt <emma@anholt.net>
Subject: [PATCH v2 0/2] per-process page tables for qcom 8250
Date:   Mon, 20 Jun 2022 11:36:31 -0700
Message-Id: <20220620183633.1131760-1-emma@anholt.net>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enable per-process page tables on the Qualcomm RB5 boards I'm
setting up for Mesa CI.  Has survived a full deqp-vk run.

v2: moved qcom,adreno-smmu compatible earlier

Emma Anholt (2):
  iommu: arm-smmu-impl: Add 8250 display compatible to the client list.
  arm64: dts: qcom: sm8250: Enable per-process page tables.

 arch/arm64/boot/dts/qcom/sm8250.dtsi       | 2 +-
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.36.1

