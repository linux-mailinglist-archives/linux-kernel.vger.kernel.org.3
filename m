Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1E958F94E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 10:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbiHKInn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 04:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbiHKInj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:43:39 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8527490C61
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:43:37 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id y23so18569442ljh.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=NrZYSX3ODzXpebRjPy8XkH0oC+vo00qnzndpmnYi1I4=;
        b=m/bMng6FLs+7CY7pNO/OXjLamFk5vNDVIYCWtUPKj/IkXQzBoV6anAhzutPnrJRFaZ
         HeBjbhXlzaLqXzaPoXjxuRHANKJ6CakE+EI+DM2biMX6tmgK2fBBK7BDU0PEsmPjDf13
         D5tHCuds81IC08ZxRPyiX+gal6ahW1Ax2qm1yYNAY3fIYtGNyRxLckxRL9tz3bPLukwx
         7WRwQKHV+VRBNEdLcNPnOohmhFheYf/P6hcxgRlUCcX/9ZoqmBhrRx5vzZzYTxOt0IMm
         qBKyPtX1sWOIQO6uEWsu2AIt8IalZpmBZUkMNxw0EXH4zfYTsH72+O8OmbA3Kdl80UUq
         ZrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=NrZYSX3ODzXpebRjPy8XkH0oC+vo00qnzndpmnYi1I4=;
        b=4h8hrbBPIvHoKTey3XAu/xbZl9e7QYYN/TeTznsXHuPVZ1hh7A37EYOqCUPqUVe0vn
         RG8yK+izXrAdSJW59cONx5HCE5WV4x3rxpPFxOaneCbtR4cHzsQqQnsnoeK0tBkbxIYY
         KRnPX7EAWW+7QK3NMA+talWJwl2KVkvUrcfshKz4QF7LMb20NGjhahYTPBTmAuxK78Ij
         SWebzdD2hmTT9bv/WQdv1RAp83PBujOyEIj2VkqwfBbVqbDqLFaD9ZQE+neUI5vpvQsp
         iCrvs+HUC6HchjLKnpspNjPDiNgNwd34MkJXUoRt6/tJX1dI/cw5Uoxcv9hy2iARjoBt
         aJ4w==
X-Gm-Message-State: ACgBeo1KR96duFwQ7yBxCjNIG5eR2SxIwSKKiSnVLrGq1Ovag1GKVWWz
        xoNucpHe1r83fKapJiobirbTlg==
X-Google-Smtp-Source: AA6agR7Zr+6RGGNJ3TJfgUxJlv4C80I+M+wAqypsOzqPCjDyqyfXzIF+2P0VGvZu1oKh1YSgGOQsKQ==
X-Received: by 2002:a2e:9056:0:b0:25d:64c0:27b1 with SMTP id n22-20020a2e9056000000b0025d64c027b1mr214976ljg.396.1660207415823;
        Thu, 11 Aug 2022 01:43:35 -0700 (PDT)
Received: from localhost.localdomain ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id f4-20020a056512360400b0048af379957asm631077lfs.72.2022.08.11.01.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 01:43:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Del Regno <angelogioacchino.delregno@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/5] dt-bindings: display/msm: dpu: opp-table fixes
Date:   Thu, 11 Aug 2022 11:43:26 +0300
Message-Id: <20220811084331.83715-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

There is a conflicting series of
https://lore.kernel.org/all/20220710090040.35193-1-dmitry.baryshkov@linaro.org/
but I think this one here should go before to fix the issue before the
refactoring.

Best regards,
Krzysztof

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Sean Paul <sean@poorly.run>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>

Krzysztof Kozlowski (5):
  dt-bindings: display/msm: dpu-msm8998: add missing DPU opp-table
  dt-bindings: display/msm: dpu-qcm2290: add missing DPU opp-table
  dt-bindings: display/msm: dpu-sc7180: add missing DPU opp-table
  dt-bindings: display/msm: dpu-sc7280: add missing DPU opp-table
  dt-bindings: display/msm: dpu-sdm845: add missing DPU opp-table

 Documentation/devicetree/bindings/display/msm/dpu-msm8998.yaml | 3 +++
 Documentation/devicetree/bindings/display/msm/dpu-qcm2290.yaml | 2 ++
 Documentation/devicetree/bindings/display/msm/dpu-sc7180.yaml  | 2 ++
 Documentation/devicetree/bindings/display/msm/dpu-sc7280.yaml  | 2 ++
 Documentation/devicetree/bindings/display/msm/dpu-sdm845.yaml  | 3 +++
 5 files changed, 12 insertions(+)

-- 
2.34.1

