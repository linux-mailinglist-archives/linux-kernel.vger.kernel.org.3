Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE52469104
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 08:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbhLFICB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhLFICA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:02:00 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D363AC0613F8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 23:58:31 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id x5so9472373pfr.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 23:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=C4WipaUxfhDiSh2nCvJGYNrM8Bp0J6D2g1Zv1ag3WeE=;
        b=qjf0ySyuDxctyBJqiBSnM52a191lDIcHBABi9DBQcCOsK/lrGRAWeRyUtLZqSeALIC
         YS2AOewuAmBRHRlb844cQjQpv0uWJyDcvY94rrSQRf+0WmB3cDRxD41QGvSyecRFrrhq
         YmgQM+6zRoLvggbv/xLgWM+aEYx5ejwds8fvGJUIPxL/qOPqLp+1IozIAjM34T6a7ZdI
         cWC1zAPJnHPeuRzH7Faj1TZfQaq/gYpeXyeMDeaBo0PdSDOz6tZtkldN4S3y+5OKZdLy
         UQSNcIz2K0ixlDqpbdNyhTSY0zkkgiOlo0/4lNbWJ7++/zI09O8CYA+54nqTL/aJlSMP
         En5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=C4WipaUxfhDiSh2nCvJGYNrM8Bp0J6D2g1Zv1ag3WeE=;
        b=451sVrFfLNLEgCAGpmHYv0PcrWV3Hz9sAVEOqQq4eZx/T1CRNGlus0nBR2NO7dVWdI
         WpjmoBkjyxyfblMcZfyhrdPY1xH3HrnTIggYCjbu3k9BrP+v5rKl2yBoDA/7aBA3yoSO
         kgW1QF7nCL0FQi4jB3TWAFusRuriJwLO+nPsaz2yq3YrYGdQrjmcBDcMK10eBWd2kliK
         Au+h4DqOB76t6o1WHPgb1dfCRuEwbTnJurNQlxpVsmJy7nnYrqpdOPycs+X6DzazL2Q+
         PYIIcc10mffhubLe9WYaACGumwHj3kRX6utDbZyETJqpJLeUBiz1H002Ak/GKMDPW7wL
         A3Rw==
X-Gm-Message-State: AOAM530TnoIc9AxaOnDvYlraQ+5WASyr6qiNUIDVhwMmN+Fo8XQE3ZUU
        HVYs5Eix/z9S6hn3pLbsdj6Qmg==
X-Google-Smtp-Source: ABdhPJxOl0lieK+9Dn12NxkK4IvbwugF7/9+L1O5CCeBBYIxZd4I8Ts6Zegje7N30Tk1z9krpA2MAg==
X-Received: by 2002:a63:1d60:: with SMTP id d32mr3779976pgm.148.1638777511262;
        Sun, 05 Dec 2021 23:58:31 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id p15sm11794476pfo.143.2021.12.05.23.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 23:58:30 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 0/6] Add QCM2290 interconnect support
Date:   Mon,  6 Dec 2021 15:58:02 +0800
Message-Id: <20211206075808.18124-1-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The series begins with a separate cleanup on icc-rpm, followed by a few
prep changes for QCM2290 support, and then adds bindings and
interconnect driver for QCM2290 platform.

Changes for v3:
- Update bindings to define child interconnect provider nodes

Changes for v2:
- Drop unneeded include of <dt-bindings/clock/qcom,gcc-qcm2290.h> from
  bindings.

Shawn Guo (6):
  interconnect: icc-rpm: Use NOC_QOS_MODE_INVALID for qos_mode check
  interconnect: icc-rpm: Define ICC device type
  interconnect: icc-rpm: Add QNOC type QoS support
  interconnect: icc-rpm: Support child NoC device probe
  dt-bindings: interconnect: Add Qualcomm QCM2290 NoC support
  interconnect: qcom: Add QCM2290 driver support

 .../bindings/interconnect/qcom,qcm2290.yaml   |  137 ++
 drivers/interconnect/qcom/Kconfig             |    9 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/icc-rpm.c           |   56 +-
 drivers/interconnect/qcom/icc-rpm.h           |   14 +-
 drivers/interconnect/qcom/msm8916.c           |    4 +-
 drivers/interconnect/qcom/msm8939.c           |    5 +-
 drivers/interconnect/qcom/qcm2290.c           | 1363 +++++++++++++++++
 drivers/interconnect/qcom/sdm660.c            |    7 +-
 .../dt-bindings/interconnect/qcom,qcm2290.h   |   94 ++
 10 files changed, 1678 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
 create mode 100644 drivers/interconnect/qcom/qcm2290.c
 create mode 100644 include/dt-bindings/interconnect/qcom,qcm2290.h

-- 
2.17.1

