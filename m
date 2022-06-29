Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D931B55FB5B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbiF2JHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiF2JHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:07:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F371F2AC49
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:07:05 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id t17-20020a1c7711000000b003a0434b0af7so6602512wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUi18BfABJfFdfrTy/zmZdsKXzzTHRjYZn6DAYr2OpM=;
        b=SbqRZ2lGoBj4MFROYCQz/qjnA+OfVT1NoH4TCsIICdxIY3XDK0tLMdH6vOxYVAiKEg
         t4f0CnvkczgFg+Y89hiBtWjI9lfG4lqTu0GHPFY8e1YHjSzOVDDNuvBcxYmNhv2pUVlt
         VEeBCpZjEy5hW0ImOSRG6M44PUYsxVJGN44H/C8IpUY2tZryK98kM8XzzHxMXFIiPlB4
         AxAULWW5UTYg7GaO0HtefCtiaqgRqE5ZPLjZBXK1fkJ3b711dfSYrZsmp+nlnfCr1nE1
         vqIHo7RWSv0qL6t1aYoQjLgq71ZOe4JeDSpARgiYArkzZrQd11BY3Z579lFfAk/hNtxD
         DKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FUi18BfABJfFdfrTy/zmZdsKXzzTHRjYZn6DAYr2OpM=;
        b=6h/sBNFpXk3qfWeKn0O0UAXY6RcKpg83fEQovAW28Pv+Jw0IsvMsotIxFs0bdlYA6W
         KALPZ4gjbsXgPQDhgZZzE0EeDKV9WtR3W4QAOQWZDoR64sA8H5IW7VVNuDTaLFRH7GjL
         G0iiq/nwtr5BeuXZOsVoBH/XgsSXsoYvlBn98+HBg5qEKN3WDpc4IKJSLmzM+8coXvTJ
         LkZ8WLwuvXg0au4D7rKAjCtxjwgTvbMgPzY/D64W934JTL/9l7TztI3mNyOUYAHQg9Tc
         DI7JV2VV18dHW7Px0doKkEFy0X8n4D7oeMdlsVDAu8DEkWpzijEn1tSA55evdAudjjAl
         W7IQ==
X-Gm-Message-State: AJIora/9ronNRfupDbzicJpPUe/lnwuSlBZlPyV69u8N77cz6Uq9nvrz
        FAQQHK7YLiEQ60oBpOONW4QC7Q==
X-Google-Smtp-Source: AGRyM1tzLUjJTsjzxmN9nAUGOrChMCfCFRxIO+WCDnxX53yn2Of1UbeD0rdgyezMd7l2GLDtoswLaQ==
X-Received: by 2002:a05:600c:4e8f:b0:39c:89dd:ae3b with SMTP id f15-20020a05600c4e8f00b0039c89ddae3bmr2472844wmq.200.1656493624411;
        Wed, 29 Jun 2022 02:07:04 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id e12-20020a5d530c000000b002185d79dc7fsm15993341wrv.75.2022.06.29.02.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 02:07:03 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] ASoC: codecs: add WSA883x support
Date:   Wed, 29 Jun 2022 10:06:40 +0100
Message-Id: <20220629090644.67982-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
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

This patchset adds support for WSA883x smart speaker amplifier codec
connected via SoundWire. This codec also has a temperature sensor used
for speaker protection, support for this is not added yet.

Most of the code is derived from Qualcomm downstream msm-5.10 kernel.
Thanks to Patrick Lai's Team.

This codec is tested on SM8450 MTP.

Thanks,
Srini

Srinivas Kandagatla (4):
  ASoC: dt-bindings: Add WSA883x bindings
  ASoC: codecs: add wsa883x amplifier support
  ASoC: codecs: wsa883x: add control, dapm widgets and map
  MAINTAINERS: add ASoC Qualcomm codecs

 .../bindings/sound/qcom,wsa883x.yaml          |   74 +
 MAINTAINERS                                   |    4 +
 sound/soc/codecs/Kconfig                      |   10 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/wsa883x.c                    | 1498 +++++++++++++++++
 5 files changed, 1588 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa883x.yaml
 create mode 100644 sound/soc/codecs/wsa883x.c

-- 
2.25.1

