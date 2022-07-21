Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E458457D05B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233506AbiGUPyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiGUPyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:54:02 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC6554044
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:54:01 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id o12so2342599ljc.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9nLGNhoNf4Voy480b5Pk+iT6tUcYySn3oFp235i7EnA=;
        b=Xormtx+3w0AkAYy82BWI5py02GzG9dTy/6dEMmOnRFS5TRjYz2GrFvOhRG5JMhhLQ2
         FaTRboEEMZWBkkDBDXvqzFZlypTpyeFSPQ14ze523yIcJvU76NYvavOkncxIIhi/3XLx
         DoTMe735WHWjoD9GeQ6l040n3Vdkr/0IVsECSUhCaoz0vndR2lyhse8HzloVyMtxqNQd
         v8URQ3xulGVoWbb/PeZpTAhAjonbXgWrLOa0POAT6IaL47IjW7l2q75JN2X0SVHI93S8
         3WpnhpRNIYS2kZoaR96MC96nTvdjt88SRv+NHIar7EOakdbgV5/6/ac8J3UsNHiUpi1j
         4NdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9nLGNhoNf4Voy480b5Pk+iT6tUcYySn3oFp235i7EnA=;
        b=A4TcJLYq6dEXuUjgFFJCM+DOj9OaBl7MlZxJm1m3Jt8YPYjM3JW4jwa959ol4LTlgf
         9dElYVZv6izFG20wv/bHZbgjKvUW19P/DqrfUpjDt+Kdto91FwX+TO+wnwuZwYTuVj95
         Geczn1SsAIRwukmgTV8hMqBDO0/jQsPpL7L5k+r2Qr59+V8ZYlq029xh3m1Ya3441o+N
         pEC/u4Yh9H3nOuMpiaaQreh18kIR++/lTuIE6ZfBrNoKMFkodl20msc4XietaKEnWGt1
         nqm0wRobcnJqT4b2BtH716UuQ5hNbemd+x9LY/rBLmFRFzluMG+3/8eYXL7NICCEcDYm
         2DUA==
X-Gm-Message-State: AJIora8g69a2hvdZB4FriM8qEPj/JDgGaLQd6KTEDO0o3xnBdKPHEh6o
        sPArU+9D07xk8mFoVxCX4f8Rag==
X-Google-Smtp-Source: AGRyM1vIzC9/PwUQ6dM7nJwDfIudNc4gJT9freeiOOqJAWeIM+ZO4wzJHh+ASa27AXn5beLKYnPpoA==
X-Received: by 2002:a2e:a7cf:0:b0:25d:6b92:9c1a with SMTP id x15-20020a2ea7cf000000b0025d6b929c1amr18221021ljp.107.1658418839689;
        Thu, 21 Jul 2022 08:53:59 -0700 (PDT)
Received: from krzk-bin.. (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id s14-20020a056512214e00b0048110fd06c4sm516432lfr.53.2022.07.21.08.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 08:53:59 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 0/3] ARM: qcom: defconfig: socinfo + cleanup
Date:   Thu, 21 Jul 2022 17:53:53 +0200
Message-Id: <20220721155356.248319-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Hi,

v1 from June [1] was did not hit Qualcomm patchwork due to missing maintainers
entry.

Resending with changes:
Patch 1: no changes
Patch 2: new patch
Patch 3: resending although recently Arnd posted global rework.

[1] https://lore.kernel.org/all/20220623110535.177326-1-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  ARM: qcom_defconfig: enable socinfo driver
  ARM: qcom: include defconfig in MAINTAINERS
  ARM: qcom_defconfig: order items with savedefconfig

 MAINTAINERS                     |  1 +
 arch/arm/configs/qcom_defconfig | 57 +++++++++++++++++----------------
 2 files changed, 30 insertions(+), 28 deletions(-)

-- 
2.34.1

