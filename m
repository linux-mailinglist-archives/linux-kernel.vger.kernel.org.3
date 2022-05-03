Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA79517DA8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiECGzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 02:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiECGz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 02:55:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8875918E2C
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 23:51:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id i19so31587646eja.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 23:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hzyexYYHTVVceyCDRefMu5hge5wA4LNQaOHRHQLKu0Y=;
        b=mM88rH1C8S5pDxpV4amTFfDcXnzdViiOsspaUW8fCfQB0zxEA15Kr6DS4FZkRi8YHj
         +DKEqaLMA1bq41tXi1zYy8MssTEq5iYai4nfsleG/C9DFNUGx4U6PDcNRa+5dfoXenzl
         xr3C9k0q9ktDiJV5UtQoQpj1V89rUXzwCGHdYO8f3tFQhoup2Y6ZQh70eqCmMpe/Iuuj
         jKvtb7J6s4qNwZc08axR12xzgcp7A/3lhtCuZfJ1XHjgTQx8YObztebBqJwol+nzByDe
         CRMBZh7DjBbVdelcJ32U30pDDijAgQ0rTA1SCrImjabE6UEK0ADP1cCJIHnM1q/vXS3b
         peqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hzyexYYHTVVceyCDRefMu5hge5wA4LNQaOHRHQLKu0Y=;
        b=Jz1vZoBYYYCaMFnr/TjOmDPUuq7PJ8qtj71McxDabeSRPlzF/e1jk5uLx/1gvj8i6k
         2sF/ecYFWbAn/EqK3tnrxW2QnF/0tgu/Pnm15wbFKpA5kp8hOOxcEsEJNAh/21bSGMwR
         Xrj9e0ehLsRGZ807yVwRd5knDBIzOECi5b/lQL/7WW+NevYpfluRLQqAV0j4M/T7o/pc
         x1y6D7u0euNa7XBOd8ttlw09hVlR4mPhxYIZrE4QEt7AdPl8C16TDIFhMpXtucASLAKS
         tPc06qvgfiAed1fRpFY4mmPA9fd9HDLHUH+D/SRbWFCG/pksY7pF9okBF/tyxeo4/trK
         DXYQ==
X-Gm-Message-State: AOAM530PHXykbXkqmS/zQI1SoFSVloet+TiQmrlv5uslH+L88fzRoNMt
        Xmd7bKRYZNTePxyfXyytjGqk6A==
X-Google-Smtp-Source: ABdhPJxwVQyW5xY+aQ+VGiYOnREVtkDZxV2eljzfWoEsSDuYXa4ABaNDp/P84m1lCOUeWhrYH3nJ0Q==
X-Received: by 2002:a17:906:9b8d:b0:6f4:3618:5f8a with SMTP id dd13-20020a1709069b8d00b006f436185f8amr9713239ejc.589.1651560714135;
        Mon, 02 May 2022 23:51:54 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h20-20020a1709070b1400b006f3ef214db8sm4246237ejl.30.2022.05.02.23.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 23:51:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/3] dmaengine/ARM: sprd: use proper 'dma-channels/requests' properties
Date:   Tue,  3 May 2022 08:51:44 +0200
Message-Id: <20220503065147.51728-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
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

The core DT schema defines generic 'dma-channels' and 'dma-requests'
properties, so in preparation to moving bindings to DT schema, convert
existing users of '#dma-channels' and '#dma-requests' to the generic
variant.

Not tested on hardware.

The patchset is bisectable - please pick up through independent trees.

Changes since v2
================
1. Keep old properties, so the patchset is bisectable.
2. Add review tags.

See also:
[1] https://lore.kernel.org/linux-devicetree/fedb56be-f275-aabb-cdf5-dbd394b8a7bd@linaro.org/T/#m6235f451045c337d70a62dc65eab9a716618550b

Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  dt-bindings: dmaengine: sprd: deprecate '#dma-channels'
  dmaengine: sprd: deprecate '#dma-channels'
  arm64: dts: sprd: use new 'dma-channels' property

 Documentation/devicetree/bindings/dma/sprd-dma.txt | 7 +++++--
 arch/arm64/boot/dts/sprd/whale2.dtsi               | 4 ++++
 drivers/dma/sprd-dma.c                             | 6 +++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.32.0

