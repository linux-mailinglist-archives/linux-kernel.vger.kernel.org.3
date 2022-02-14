Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FE74B52EB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354989AbiBNOO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:14:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiBNOOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:14:21 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE1CCF2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:14:13 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id q198-20020a1ca7cf000000b0037bb52545c6so11739649wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Qlx3M3VCN3nCqu4bI8JyGJh06irEHdbGlG/oT1ZjMhU=;
        b=gQFJOAp2Q+AzI8Su0EMz6HKbPu1N5NVGn97XCp3UKOjDpZmMPryQQYbsD0tHQ2i0Gz
         yKx8+53C22mzIQd2DW5P+6OmayW62fV3/XtS23BjNjaLgsR7/JmvmMuzdKZFaPtbKE5a
         mYxyvdZ568rpy1VfhVn+uHFY9M8YWLi63CsNCxdjfm8MOcUH2x3fBXZ3rQmbqyvbhwFs
         WMY6rf1DJLuGeq0YVVW9gA95n6S57CJP2uMO9Vb8iwwD1MLHFMjy3r/BQPwF/aevblyN
         u/ktz/bxe8OZkZJqoDtQ9AvE9DhHcoZGilhFpGBPGzIQBy5wozE41f+NyOANSvJcx9h2
         skCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Qlx3M3VCN3nCqu4bI8JyGJh06irEHdbGlG/oT1ZjMhU=;
        b=K4r/A2tYVNiDWaoCZc+7i6ZKo7bDCslucBt1W5G3kMlpRuc20JvsrH/9OgXFh96PVJ
         ENbKve8MRvsclDkAa0HNsfeADrE05lZzIVGJfgO6Cnl6DQm9I9p7EzWFAkbbXZiOy6wG
         7y1A/xzjH7NnBFS5CcHrou3GSZ93BSnNeV5ttcc+NZh5Nn0nuva04rGwItclL3i6qkIp
         QRPW1omdZFVYmFR1LSpfzYKBXrEHtPn/z/RWt1E2Zdk/5XmgDLVHULRLNgb/7yiKKJ8P
         o9IZzf0jBq9pZ1TYGtPWCRzftCcO261IySACt802lxvH+KbfuDnWuNwGAKprDM/vHM0F
         5j2Q==
X-Gm-Message-State: AOAM530DVhFOFgT7uLDQ5BXeZ4NUj/DHaRSq/YT1j7gzzoLjof49ncoz
        N+44xeNk+uUgH7NVCcYaQ9dZiQ==
X-Google-Smtp-Source: ABdhPJyzOLNlTml69X38/WjrjlwiHmHj2m7e1npBw/8IARt6cOUC8677/fPFoMZ1iVt902GZI9MeSw==
X-Received: by 2002:a05:600c:4783:: with SMTP id k3mr11028626wmo.177.1644848051846;
        Mon, 14 Feb 2022 06:14:11 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id az7sm14882560wmb.14.2022.02.14.06.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 06:14:11 -0800 (PST)
Date:   Mon, 14 Feb 2022 14:14:09 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD, LED, Power and Regulator
 due for the v5.18 merge window 
Message-ID: <YgpjsW5an5uLjzi+@google.com>
References: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220111175017.223966-1-krzysztof.kozlowski@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-led-power-regulator-v5.18

for you to fetch changes up to b38213c6118b6b3fe163bd9acb7f723c379dd833:

  dt-bindings: mfd: maxim,max77693: Convert to dtschema (2022-02-14 13:53:01 +0000)

----------------------------------------------------------------
Immutable branch between MFD, LED, Power and Regulator due for the v5.18 merge window

----------------------------------------------------------------
Krzysztof Kozlowski (4):
      dt-bindings: leds: maxim,max77693: Convert to dtschema
      dt-bindings: power: supply: maxim,max77693: Convert to dtschema
      regulator: dt-bindings: maxim,max77693: Convert to dtschema
      dt-bindings: mfd: maxim,max77693: Convert to dtschema

 .../devicetree/bindings/leds/maxim,max77693.yaml   | 105 +++++++++++
 Documentation/devicetree/bindings/mfd/max77693.txt | 194 ---------------------
 .../devicetree/bindings/mfd/maxim,max77693.yaml    | 143 +++++++++++++++
 .../bindings/power/supply/maxim,max77693.yaml      |  70 ++++++++
 .../bindings/regulator/maxim,max77693.yaml         |  60 +++++++
 MAINTAINERS                                        |   3 +-
 6 files changed, 380 insertions(+), 195 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/maxim,max77693.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/max77693.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77693.yaml

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
