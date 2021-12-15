Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39ABC474F11
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238440AbhLOAXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238429AbhLOAXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:23:45 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ED5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 16:23:45 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id r130so19246079pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 16:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=9JW3yyJwaNZhtBuZJ3jDcXTPLUxJwHsCr5uKwfCfrj4=;
        b=agigs3ZY+UFqmXiA74+p7leMm6bCpcAFw7Wv0bhdIXJAzuy/RNsZhpoR3WKP87+bbg
         WkFD+JYiP0ZPC/RgQqhdl16Gzm6jHHmg94YxVmeuHvkGunyjnVnH1GinHhGSBGJQ+i2P
         kvOnTcAy+AmfdQRDFNo4RMWvuQxL8GFrSxsFP/LD2umNzfkijAbupJmGwglG6TC9zAfp
         cSyX5j2OdesN14VKcpNvswKjt0fnzbni+VghtiNPOrfxB56sLw+fIqy+lk8mv22HNRz4
         elrDCpBOUXG3EUcCxb/fxe6vXAoErolEIxcHmoBfRyi4l2wUZpTAc5jZxrTxx+xgwWhr
         ZbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9JW3yyJwaNZhtBuZJ3jDcXTPLUxJwHsCr5uKwfCfrj4=;
        b=qymV3wWs+OQbzq+zcMFEIu0d0ul7xE0fwQ0Mc/KEa1N3JZCMdmBSr/6E+7OygP61YG
         u8a4EI1J/vkm9orU48haegMBRPxU0o3DBBjf3sHLFFwc5F39FeioQB/qfMXiWWxPFsIv
         s9kzZYZsjO3BdAN7LAaH1VI/SROAVxhqmeRzCqRac9q5vCbWq0F6OAoGaK5Trw6EFQGJ
         /VVwM/tPLDO25b5Y09LwHKhsI6Ft0bHiyosIE6zHr+fZrZ8+CWEykq3yaLZK88+DXo2c
         z81X2YG36mSlogEGICt6mENk2sB5+I1Wm1yK9AVLi91FPlHlbnJImwbTvWb8h67vfsdk
         n7+A==
X-Gm-Message-State: AOAM531H6J7dYAJsOTuYiNX1r7Rjv0l60PNE9G4MJPLjNvT2hd0xLiMR
        YP7joAMvv1FcTuN+3cm8atRiCA==
X-Google-Smtp-Source: ABdhPJygzKgajtWbWb3H4ho6iZNsIhQPk7qNBbFUmunw7Zkup7CRkh50BFi/TT+duaxtSIjZb5XYCw==
X-Received: by 2002:a63:8f02:: with SMTP id n2mr6005844pgd.270.1639527824621;
        Tue, 14 Dec 2021 16:23:44 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id a12sm185840pgg.28.2021.12.14.16.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 16:23:42 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v4 0/5] Add QCM2290 interconnect support
Date:   Wed, 15 Dec 2021 08:23:19 +0800
Message-Id: <20211215002324.1727-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes for v4:
- Fix the compile error on msm8996 driver.

Changes for v3 resend:
- Rebase on linux-next
- Drop NOC_QOS_MODE_INVALID patch which has been applied by Georgi
- Pick up Rob's Reviewed-by on the binding patch

Changes for v3:
- Update bindings to define child interconnect provider nodes

Changes for v2:
- Drop unneeded include of <dt-bindings/clock/qcom,gcc-qcm2290.h> from
  bindings.

Shawn Guo (5):
  interconnect: icc-rpm: Define ICC device type
  interconnect: icc-rpm: Add QNOC type QoS support
  interconnect: icc-rpm: Support child NoC device probe
  dt-bindings: interconnect: Add Qualcomm QCM2290 NoC support
  interconnect: qcom: Add QCM2290 driver support

 .../bindings/interconnect/qcom,qcm2290.yaml   |  137 ++
 drivers/interconnect/qcom/Kconfig             |    9 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/icc-rpm.c           |   52 +-
 drivers/interconnect/qcom/icc-rpm.h           |   14 +-
 drivers/interconnect/qcom/msm8916.c           |    4 +-
 drivers/interconnect/qcom/msm8939.c           |    5 +-
 drivers/interconnect/qcom/msm8996.c           |    9 +-
 drivers/interconnect/qcom/qcm2290.c           | 1363 +++++++++++++++++
 drivers/interconnect/qcom/sdm660.c            |    7 +-
 .../dt-bindings/interconnect/qcom,qcm2290.h   |   94 ++
 11 files changed, 1684 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
 create mode 100644 drivers/interconnect/qcom/qcm2290.c
 create mode 100644 include/dt-bindings/interconnect/qcom,qcm2290.h

-- 
2.17.1

