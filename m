Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA1A57F4EB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 14:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiGXMYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 08:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbiGXMYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 08:24:36 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B8C13F8F
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 05:24:34 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id f3-20020a17090ac28300b001f22d62bfbcso6495794pjt.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 05:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l+btaMwUX7v8ihc2NfU+GcnNfj68sCUMhrZsdXfz3fc=;
        b=LQbS1Q5tT8sKQMuJa2PUmTLNPX1oC6UJahF2ymKRWfYZWAuKu0Q2OyyG7o9DrO21c/
         OzCE4OfpdV5WEYRM5sgEgoVbcfQ0uzxzmgOUJCl5PDDx0SuGJMlLB4MPd/9KpGNjWDwO
         2xPMExcLzg4ySr5zSFw9dpQhhZ+OWYsWT7He5jMr/Cr6PKvsSCSeUQqj5fKpZ816OGxm
         MvRdH8YKxrImk2zF1qmXtrp7QAuzM0R4+j8Xl002IJ0AApJBk/XuS6umo6Zi4EO7F1jY
         8lzbFi/SIg0QAE7lzjukjdGmy4+5TEyyeYYCdmBm3M2JlydxMHkRH8wBu62jrLtsZWxk
         eR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l+btaMwUX7v8ihc2NfU+GcnNfj68sCUMhrZsdXfz3fc=;
        b=5rR3XF48W5RlzhP4C+7vJf+30jbQPH63bBBy082ZBHfUs+nuDydrV5dKCJzTFSiOE0
         zO/tCC/EQPM55Wo8+m7CrHXiowMtuD+DGwO9VklLRZjRvpmSsm71vOhf/8JcVOVgCyA6
         H4/Ji62C0aLgSCLZGovhFy3ekijNnE4Jai7wVJWPgo7zePYv1AGJE4Z+Dy1Yv0nfRrH1
         +X+461BedrCN641gFmtSb9tMwSIhZIEeBRMCBSUWumBKun6ZR4lKAWTzzgCH+P2UeBVO
         SZ4waHnKVdC9+RrftshthfaB9o5D27/BlOy+5pyUfrIXD9pkdOgh6IRYpcBRz1GsSD3C
         eDVQ==
X-Gm-Message-State: AJIora+w8mWglofTC8/dYGPmFKul7+7rXy2blIpyoQdbuximrjO8XmIs
        L86CqmU0dNm9vvTa/Kp5uXz6XA==
X-Google-Smtp-Source: AGRyM1sYCvCsRCtt9w8IPY37YxQScow1V24ahLiJixa54hS9ywLAnMc+zhN4WByor+lecg8MO6xl5A==
X-Received: by 2002:a17:90b:1d01:b0:1f2:104:6424 with SMTP id on1-20020a17090b1d0100b001f201046424mr9063527pjb.101.1658665473874;
        Sun, 24 Jul 2022 05:24:33 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1f3a:5a45:a9cd:d7dd:fd01:73c0])
        by smtp.gmail.com with ESMTPSA id p23-20020a1709027ed700b0016c0474fbd0sm7048133plb.34.2022.07.24.05.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 05:24:33 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org, robh+dt@kernel.org, rafael@kernel.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Subject: [PATCH v2 0/5] Add support for tsens controller reinit via trustzone
Date:   Sun, 24 Jul 2022 17:54:19 +0530
Message-Id: <20220724122424.2509021-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:
-----------------
- v1 can be viewed here: https://lore.kernel.org/linux-arm-msm/20220701145815.2037993-1-bhupesh.sharma@linaro.org/
- Addressed several comments from Bjorn regarding locking, serialization
  etc received on v1.
- Addressed Konrad's concerns about the tsens controller found on sm6375
  SoC which seems to start in a bad state or is disabled when entering
  the linux world.
- This series would depend on sm6375 tsens controller changes being
  added by Konrad. It is based on linux-next (master branch) tip.

Some versions of Qualcomm tsens controller might enter a
'bad state' causing sensor temperatures/interrupts status
to be in an 'invalid' state.

It is recommended to re-initialize the tsens controller
via trustzone (secure registers) using scm call(s) when that
happens.

This patchset adds the support for the same.

Cc: bjorn.andersson@linaro.org
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org

Bhupesh Sharma (5):
  firmware: qcom: scm: Add support for tsens reinit workaround
  thermal: qcom: tsens: Add hooks for supplying platform specific reinit
    quirks
  thermal: qcom: tsens: Add driver support for re-initialization quirk
  thermal: qcom: tsens: Add reinit quirk support for tsens v2
    controllers
  thermal: qcom: tsens: Add reinit quirk support for sm6375 controller

 drivers/firmware/qcom_scm.c     |  15 +++
 drivers/firmware/qcom_scm.h     |   4 +
 drivers/thermal/qcom/tsens-v2.c |  15 +++
 drivers/thermal/qcom/tsens.c    | 213 ++++++++++++++++++++++++++++++++
 drivers/thermal/qcom/tsens.h    |  18 ++-
 include/linux/qcom_scm.h        |   2 +
 6 files changed, 266 insertions(+), 1 deletion(-)

-- 
2.35.3

