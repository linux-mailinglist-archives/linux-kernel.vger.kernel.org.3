Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3DD53EB22
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbiFFL05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 07:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235404AbiFFL0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 07:26:54 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602D11406DD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 04:26:53 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n10so28336162ejk.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 04:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qN20goYH08UNNKYoZTr4Js8fYsFIajOnmIvyhD2zjRo=;
        b=WKpE5XV7LDIwM4iUsVjH6vlpPAR5/mPZtMilXL5Eis2WCnWDXpVzUS4VAwD1qgU2Rj
         kFUV2d8YCaxK6he4K4qfr2ESrEuF1luyQ8kejja1GIlX0Z/1xIF1R1ODk/ODsOHi997a
         vIshLwbh+A1o5RrhG9+DgPhq1Yep08ocKqp4NnwFAyPWps2KHNLeHX/QCj9sksGjePc8
         DrF/4cHyJvq1Spqx0znl0XmK0nLce6457LXMh4tlmO8iAbKAoutmSdWq39ltH2HEmIn3
         ynzryoPavWMtk+Q44C9qc5+bYebht87fU2YcEEYGCBipxa5VNuI2NeJXnb9rsnzryKdu
         3C4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qN20goYH08UNNKYoZTr4Js8fYsFIajOnmIvyhD2zjRo=;
        b=kXNpey8JlnX0HwYITvuOpbTG3cqTKNboFoFbod20gHkllOkBVNiasY1bB3IZZjinpv
         JbQmDLOt2iXykwdK3i7yKTyn8gB4B8ybWUybxQQnvXMJ80slMMGZdM8nDDAjVsD6Nt2a
         x8XhMqixiGvW4qnpJd65dcgbCcCSgVgmaX2HOWYQYCdepiL0hN7khIQZaXGrHPnhXxbg
         QRYgqmXG4j5kaD8k1P04vIA3VpYU0oRNgOUB08CSkIp4xBTNp7PDXlwBVWg8CqdahNOt
         dI0Q3M5w+Avjvidawg48VCumduUyqXOJYT+F6Ws8PWcmsnP+WbmX5nQn6zpFtjlTYFyk
         R8Bg==
X-Gm-Message-State: AOAM531GCDHv67jnCq1KhcQ7JmEPOt1DZPAJRq3FCJ/cD8A/DdoqGhee
        4XLt7Zfq8gnt6FfdEdAVChx1bg==
X-Google-Smtp-Source: ABdhPJzhdEVF8MICsI3brmUTBgtmSKv+oTpZ4eF6OfI/YP+KaC2AUV5Dn4y6D8Ba45KTJKrTkvngeQ==
X-Received: by 2002:a17:906:40c4:b0:70a:5d82:4e68 with SMTP id a4-20020a17090640c400b0070a5d824e68mr21043795ejk.172.1654514806451;
        Mon, 06 Jun 2022 04:26:46 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906308a00b006fece722508sm6223915ejv.135.2022.06.06.04.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 04:26:45 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH 0/5] mfd: max597x: Add support for max597x
Date:   Mon,  6 Jun 2022 13:25:54 +0200
Message-Id: <20220606112559.3863149-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.35.3
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

max597x is multifunction device with power switch for output voltage
control, voltage/current monitor & 4 leds.

max5978 has single power switch wehereas max5970 has dual switch.

Additionally the chip also provide fault protection like over voltage,
over current & under voltage protection.


Marcello Sylvester Bauer (1):
  dt-bindings: mfd: Add bindings for MAX5970 and MAX5978

Naresh Solanki (2):
  leds: Add driver_data for led_classdev
  mfd: max597x: Add led support

Patrick Rudolph (2):
  mfd: max597x: Add support for MAX5970 and MAX5978
  mfd: max597x: Add IIO support

 .../devicetree/bindings/mfd/max5970.yaml      | 151 +++++
 MAINTAINERS                                   |   7 +
 drivers/mfd/Kconfig                           |  18 +
 drivers/mfd/Makefile                          |   3 +
 drivers/mfd/max597x.c                         | 594 ++++++++++++++++++
 drivers/mfd/max597x.h                         | 117 ++++
 drivers/regulator/max597x_iio.c               | 138 ++++
 include/linux/leds.h                          |   2 +-
 8 files changed, 1029 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/max5970.yaml
 create mode 100644 drivers/mfd/max597x.c
 create mode 100644 drivers/mfd/max597x.h
 create mode 100644 drivers/regulator/max597x_iio.c


base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.35.3

