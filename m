Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11AB56049B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbiF2P3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiF2P3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:29:43 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CC131349
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:29:42 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id fw3so5681248ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1bQ5xBUeicswiCyCgoWOXSzl8HXEc/zsS/C+nRnRHLw=;
        b=UXZZ5/4q4pr77stZG3P8VQIwogWOKHwYhIS5It2Sx9BolDzfNk+Yuc1JF2shx7UsAH
         Xq++CtPNitIyfBZtlLUdWS0+ihvdKPDXE/hNZB2JAaIFmrA9MBdHD5rIaf8pLTaNdVoQ
         F+XuyQyprFA7FPOhjdXRGx1NU6H4ttjF9igJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1bQ5xBUeicswiCyCgoWOXSzl8HXEc/zsS/C+nRnRHLw=;
        b=ulabfjjr2kOn/SwqHjTrVxkKm4EX3mu4aUN7fUr2b3yEzNYtsrdDS7sQVRkp8H5bau
         RaMPHL+V7hQkmeRi+vfrFknT7c4L+s0XoICqC6/tdR6gO5yw5no612RIQF0Mktocnpr7
         fD4wPA9KPDPqXcjC0hmIk2xElvLG5WFYuIzk4vWGBB0l8Jtx8Q3WhAC8WRrp1GBV9VZW
         OD/9aRclUOD9h92QHW4rHg1pjpf7ltqHHAkZKZTg2KLZsU+sBhBRtfJSZ0u5Qq3Fvngn
         AwUN59bDQCvUTLkdgbQxjelBe1Uhr+oVtdeo7tPRJJd7vMKVSMdJq0RZ2CIpB3YP2oVK
         3QCg==
X-Gm-Message-State: AJIora/ZmnLRNWzg3YY0k6hVhRWNRcOtZWQjasljkRWSVpBbYRrw0/6Q
        +/OXdDhVD3mV1XdjniR9iQMvvg==
X-Google-Smtp-Source: AGRyM1tDWQEMtvf4hXHgyrPUc2fqiuAcG98p75PvC0duiCzSjgsmt/Q90pY/bLmXO2KY88j/9Fz5pw==
X-Received: by 2002:a17:907:60c9:b0:726:d038:9968 with SMTP id hv9-20020a17090760c900b00726d0389968mr3915400ejc.468.1656516581370;
        Wed, 29 Jun 2022 08:29:41 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id h1-20020a1709063c0100b006feec47dae9sm7821853ejg.157.2022.06.29.08.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 08:29:40 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     tommaso.merciai@amarulasolutions.com
Cc:     linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] media: ov5693: cleanup code and add dts support
Date:   Wed, 29 Jun 2022 17:29:27 +0200
Message-Id: <20220629152933.422990-1-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
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

Hi All,
This series cleanup code on ov5693 driver and bring up dts support, also add
documentation for ov5693 camera sensor

Inspired by recently Quentin series:

 - https://patchwork.kernel.org/project/linux-media/list/?series=64807

Tommaso Merciai (6):
  media: ov5693: count num_supplies using array_size
  media: ov5693: add dvdd into ov5693_supply_names array
  media: ov5693: rename clk into xvclk
  media: ov5693: move hw cfg functions into ov5693_hwcfg
  media: dt-bindings: ov5693: document YAML binding
  media: ov5693: add ov5693_of_match, dts support

 .../bindings/media/i2c/ovti,ov5693.yaml       | 106 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 drivers/media/i2c/ov5693.c                    |  86 ++++++++------
 3 files changed, 159 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov5693.yaml

-- 
2.25.1

