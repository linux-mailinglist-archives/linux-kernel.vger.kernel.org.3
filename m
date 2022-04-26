Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FE7510CB1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356108AbiDZXgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 19:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356106AbiDZXgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:36:21 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A9A2CC95
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:33:12 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id r14-20020a9d750e000000b00605446d683eso7843otk.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2rWRDWP0a5f/QFMglO+k4EsyMZUyMz/wbOdfsseufEI=;
        b=zLGCBAHdg0gWeCFkr5arjA98SduUEQePrk5yA8MINItmqFvAtFnTX76haYkWEbqQIc
         oj6qzo47XVBFlXjjSk89keHfEV6bvqGYjq2/wxoi2MmXjOcSLe3FNo/icHxtBCdnf8+C
         SHOcAaZnY9YsAg8P9d2a1y0VjPhOHxc4lJ1k8VqB30H56SGH512n5Q2V0sTbFlUTu9dS
         +fzwm4g+KAJKk/sGkf+2eXEGrkGLwSzKTl2Ac0gStaBNOaNjau12aeCd2ytX/VaPbCGP
         Dv58mbS3/Zs9ECBYZFy4KbSbv3Y4rr3+0xMccqGtAHVmOlSYYsO2+86Z34JmZnaxGD3B
         eowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2rWRDWP0a5f/QFMglO+k4EsyMZUyMz/wbOdfsseufEI=;
        b=bhEN6iJerReOTTRgLHCKsDJGcKLRDnlEXlNEa4IUZAWS5JX+Qwb6DC3ha0Mhd7OB6v
         RgfEUf++C8hBpMreSKNJv2GwfnoGfm369Uhn/0maCJmxM8DODDLkK2VOpm0xPuhK8qBD
         71EQVK6qVkrYRRd8e0YYkAfyI10HlR3zlF7ikdDExLP7e+BZ5yPw5UEBVnS60gqcZzmi
         /XthkTITXBIEw/PnHlK0LRxAluSBGCk6+JRlIF5FLrW0p889dQAzryT/bh5k+V81ObLJ
         OmZ7SP8k1RGB+gustqXlLH9TDZnn3e+WVxSoDnxPIWFwJic4ylaypwSrNuHqU34lQbix
         /YHg==
X-Gm-Message-State: AOAM532SniGdeUbEl6HQsIoNLrv73MYte7iiDC86z0S5gNaKBIV4tzdg
        k4z9jRewq5c2a4NBKSA99fEBuw==
X-Google-Smtp-Source: ABdhPJz3jcPffvaggSe8FfChkFNVgRvkTqkw8eUkmEnYTaivYzF4HopEe36ocJMIopf1mVTasUOPdw==
X-Received: by 2002:a05:6830:408e:b0:605:5af2:b124 with SMTP id x14-20020a056830408e00b006055af2b124mr9129644ott.201.1651015991423;
        Tue, 26 Apr 2022 16:33:11 -0700 (PDT)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id k2-20020a4adfa2000000b0033a3381a7f1sm6151658ook.44.2022.04.26.16.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 16:33:10 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] soc: qcom: rpmhpd: Add sc8280xp and sa8540p
Date:   Tue, 26 Apr 2022 16:35:05 -0700
Message-Id: <20220426233508.1762345-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
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

Add compatibles and power-domain definitions for the sc8280xp and sa8540p
platforms.

Bjorn Andersson (3):
  dt-bindings: power: rpmpd: Add sc8280xp RPMh power-domains
  soc: qcom: rpmhpd: Don't warn about sparse rpmhpd arrays
  soc: qcom: rpmhpd: add sc8280xp & sa8540p rpmh power-domains

 .../devicetree/bindings/power/qcom,rpmpd.yaml |  2 +
 drivers/soc/qcom/rpmhpd.c                     | 57 ++++++++++++++++++-
 include/dt-bindings/power/qcom-rpmpd.h        | 18 ++++++
 3 files changed, 74 insertions(+), 3 deletions(-)

-- 
2.35.1

