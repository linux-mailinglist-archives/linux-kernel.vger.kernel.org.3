Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFE953EB07
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbiFFLyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 07:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbiFFLyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 07:54:37 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4319B6B65E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 04:54:36 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id q21so28495633ejm.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 04:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tCfEaCTmvlZCtvhCPDXCmD7gDry6e4O6kLx1z85mKmU=;
        b=W3DJ1tsfWtPLZKkgIsuYZW7tTfuEoAwbOefZLTm0SHGJPtOTHM73b9DNMp8gI++BPZ
         muBTERNhZbWHi/6S3bnthLDH5tH+onDJFaCr9O1pP9A0HXZJqUviD61efDI+mbpqA83u
         jEW+i7j41OXcdVLQtkKa5x6bRu6VRSniqHwtZ9mYyLEIqD/VcQYZPWnfw0y0F97bJDow
         uUN+vpjqeLNTHIiA3TLAyKoeif8XY/M3ixrRdsQzkcG1T0kT+IGa01M4tAPqGQ97cgMR
         O9CEUs5KVJ0ejrjlZdVBK11HuT3aMm+IXr+YIUMq2N8iGJym3ZtNIpUuUG7F03CJbDNL
         il/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tCfEaCTmvlZCtvhCPDXCmD7gDry6e4O6kLx1z85mKmU=;
        b=Lqa8eFH5FkJ+FwDZF+w/k9/eQ0TAlQlJ6H3mV7S+ASRqHg3xjliJEybgR/01DCPSVq
         Xdbw574x4YytBuzXhYUDH2XWeZtvMUb4SpMlUVYvBkrI9CXYOuhj0KF6qJG8dnTNKwWa
         UFrIDf4+ydaevs/rxp4YDzFJmM1xaFEAgwP7q3v1z4BOTebQHI9MjiTTgYYurtXOZZNZ
         ueDWUrS2QWwJbu7hVw0NJSvGL9FnhthORqnTHTv0eHSZDqUe64kcw5CSkIlSEhLTy//O
         Qm8IYl6lH7e1n/TjvxGruHc+iRjXE+qrDooitjfKEbc2w5LrOkAO5k6lfoZyAOnW/3EQ
         ai2w==
X-Gm-Message-State: AOAM531nq0wI2LDJtiICAS0yNblx+K+DnqDg7eQPM+Boj46p8zTxzFSE
        1yo4RNkFqqcm4cFTAURlYGMj88nJuPnndPy4
X-Google-Smtp-Source: ABdhPJxbGY9paeIgfEjANpJCdURIV9u5Tu3TRDDzUh9m+hUHKjyvUZ2Q7sIn73+7y1dI+yLyF1Cb+Q==
X-Received: by 2002:a17:906:1f52:b0:6f4:ebc2:da82 with SMTP id d18-20020a1709061f5200b006f4ebc2da82mr20899229ejk.176.1654516474634;
        Mon, 06 Jun 2022 04:54:34 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id i15-20020aa7c70f000000b0042bc97322desm8782639edq.43.2022.06.06.04.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 04:54:34 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org
Cc:     Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v2 0/5] mfd: max597x: Add support for max597x
Date:   Mon,  6 Jun 2022 13:54:07 +0200
Message-Id: <20220606115413.3875433-7-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220606115413.3875433-1-Naresh.Solanki@9elements.com>
References: <20220606115413.3875433-1-Naresh.Solanki@9elements.com>
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
 drivers/mfd/max597x_iio.c                     | 141 +++++
 include/linux/leds.h                          |   2 +-
 8 files changed, 1032 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/max5970.yaml
 create mode 100644 drivers/mfd/max597x.c
 create mode 100644 drivers/mfd/max597x.h
 create mode 100644 drivers/mfd/max597x_iio.c


base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.35.3

