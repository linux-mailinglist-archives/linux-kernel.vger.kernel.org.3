Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CDF5773CF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 05:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiGQDlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 23:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiGQDln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 23:41:43 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ABC17E08
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 20:41:42 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id by10-20020a056830608a00b0061c1ac80e1dso6644685otb.13
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 20:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/JOrR1/M+i6rGhgWi4WxqILV1OdRgnXn1zMgwXAIeTc=;
        b=NylzmEc3fiKWfYcEFOLLP7EbLMjz04vnLqKONw+cUWw9wQqSO112+2pJUIyYR0/1Cp
         vGwv7igOtIoOT4vH2CvghUEJxaq8jp8sCpWICPk4Aqu/Ug+nTyV7XMqJ/CQGEtPOsR8Q
         Nu0b/WQ4KPCvgLCfJUWLNDOdYAuScvpovsy/3la8Wg+szbzo8IKrDwDiIORD/IsmZasD
         4Mjj6Vks8LRS3jwe04OZZLm2C0dI/xHSb72ZlKQoY9JuxELbOrF5dgjOp5/CzlYI95bs
         A3Wf+jtRho4ZO2cqdOd+QE0u9XKhlHusAiQrtfSTHSm1h/j8Q95Y9+pCuLPfnRt5JXC3
         jbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/JOrR1/M+i6rGhgWi4WxqILV1OdRgnXn1zMgwXAIeTc=;
        b=dWsYHMlk0mT2kj4TiKuRAc403HHyn9z9amBbr1gUtGdensf1ba+xtrP9Li7MQk8oPw
         w899wW1M5QgKS1QevAVwgRrLyCFeBgsp4H2fw1Xj5NW7IxkG4FtJ+Jc0nFFYrg2YSF0v
         0VlkH4uDYfJlTaJ1jOd4VSlr0TIw1W+Sxf9NgFC42NCcBpkNrzjV+q0Hu3bYrCfov7F6
         z7+P+4f1/TuW258v2grcR2xGt9ko91bSiz0TWlM1xPYEiOvW5++Jk5m432dI8XRw1Rpc
         i+5wtiJqmLxb2qm37P+uZMaCA6PsWenLBhBk2n7H9TFH3OjGJviHw6k+3flAY7RDeZ/j
         6+Ow==
X-Gm-Message-State: AJIora9SE/7OnS3OaASPP8ZfZYaHUcU99HQ/w8DJYje0UIf8CaW2/ytC
        JehC2efAf4Z0F5jC2Hl2x+KhJQ==
X-Google-Smtp-Source: AGRyM1urzjSQucayh8NCJZv3JprA/A3+73wLFE1N1Njobpt6/w1An+z2F0y8NwYofXs/BQkb/exTzA==
X-Received: by 2002:a9d:630f:0:b0:618:da60:4c62 with SMTP id q15-20020a9d630f000000b00618da604c62mr8404491otk.296.1658029301931;
        Sat, 16 Jul 2022 20:41:41 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p4-20020a544604000000b00326cb6225f8sm3218010oip.44.2022.07.16.20.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 20:41:41 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vinod.koul@linaro.org
Subject: [PATCH 0/3] arm64: dts: qcom: sdm845-db845: Some i2c fixes
Date:   Sat, 16 Jul 2022 20:44:00 -0700
Message-Id: <20220717034403.2135027-1-bjorn.andersson@linaro.org>
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

On my db845c (perhaps old firmware?) i2c14 is using GPI, so this enables that.
And while I'm touching it I added dma properties to all the geni i2c and spi
nodes and specified a default clock to avoid two warnings in the log during
boot.

Bjorn Andersson (3):
  arm64: dts: qcom: sdm845: Fill in GENI DMA references
  arm64: dts: qcom: sdm845-db845c: Enable gpi_dma1
  arm64: dts: qcom: sdm845-db845c: Specify a i2c bus clocks

 arch/arm64/boot/dts/qcom/sdm845-db845c.dts |  6 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi       | 90 ++++++++++++++++++++++
 2 files changed, 96 insertions(+)

-- 
2.35.1

