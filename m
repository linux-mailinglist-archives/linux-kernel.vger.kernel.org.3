Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4CF53C5A5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 09:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242354AbiFCHCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 03:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242312AbiFCHBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 03:01:39 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0728C1BEAA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 23:59:25 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id i10so11267544lfj.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 23:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uHHSbDnZ/bF7lajp7vTP8YfXHDgm/E1EH3J8pYDB/2s=;
        b=F/AULqPCtZBiCUilifqAqRx2So9Qwsagb72FMO0MNPzJ4301vaQttdd9K/JhgGSMqd
         K/0ty9l/AJO+Xc2TEf0LGeQlk11P4GBVVuf0s5KKfx0wa+EYYWofBMfWMTD1uQhEHts4
         cS8gfT+uE/9itueOqBVZZGeEaVOst1MQeZs8lHBIKTwPBUetD0wJSBBigxuF0C7zkekR
         djAt7RO459OqtbxSbSoF92WPfasvC44yrVDJwJgG6lIqmpWaL/n4xOb8UvpwSyVWZAjX
         9IKOBvmRetMt+00FDjh3KWxbQ1spntXWevCUU/5YD0woTdwwGkgCRhiu7PCyGOOp+rTf
         uKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uHHSbDnZ/bF7lajp7vTP8YfXHDgm/E1EH3J8pYDB/2s=;
        b=Gu5QgXjmAoyVrIi5LqepvKMeCEzTjeCWylpmee9IaMuvLneofgDnO68vAmon1RBHWi
         sYAl9DCrBpJaGsmem4o9puZj+Y3BRBMSaf9VPIF+KpqOLkPLKeVj6p6BqX/u5MYT/8iX
         Io5sfIEcu2ozGHPnZ5qlhS7g6yUVRHRNV03HC2/RU7af1gCCjQ3t+jOnRJkBRI7yk2ES
         QvLV2yAV1z1Bq+aLmSqd1/OOOhNP2ulJvAsaLFGcaJV9t6Ts7pre3s+oxl7Yz0pgSnhu
         O8g7yKLJfxB3JDO5ne1WDtwgqd2Op9gS6/+AiivItg9LvFvuSxSyWEL2SwchIWwMO/76
         OKIQ==
X-Gm-Message-State: AOAM531Y9Jg7xZY8NxV4qF5UT8a1qBF/sPIASQYhK3qstMw2hQOoe8u4
        fpzeDZZutqBsKeFxH4DwA41P2w==
X-Google-Smtp-Source: ABdhPJwM15KC7C35p1opodl0rOSnPgWWTtcG0VIkjhLzTitZd/a0kBAh72H9S1IbrKJIJCA1dEF4SQ==
X-Received: by 2002:a05:6512:1315:b0:474:40c9:41a7 with SMTP id x21-20020a056512131500b0047440c941a7mr55705471lfu.319.1654239563171;
        Thu, 02 Jun 2022 23:59:23 -0700 (PDT)
Received: from panikiel.roam.corp.google.com (staticline-31-182-204-250.toya.net.pl. [31.182.204.250])
        by smtp.gmail.com with ESMTPSA id b8-20020ac247e8000000b004786321c697sm1056447lfp.138.2022.06.02.23.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 23:59:22 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dinguyen@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, amstan@chromium.org,
        upstream@semihalf.com,
        =?UTF-8?q?Pawe=C5=82=20Anikiel?= <pan@semihalf.com>
Subject: [PATCH v3 0/5] Add Chameleon v3 devicetree
Date:   Fri,  3 Jun 2022 08:58:11 +0200
Message-Id: <20220603065816.87952-1-pan@semihalf.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The Google Chameleon v3 is a board made for testing both video and audio
interfaces of external devices. It acts as a base board for the
Mercury+ AA1 module.

socfpga_arria10_mercury_aa1.dtsi and socfpga_arria10_chameleonv3.dts
have also been sent to u-boot:
https://lists.denx.de/pipermail/u-boot/2022-May/485107.html
https://lists.denx.de/pipermail/u-boot/2022-May/485111.html

v3 changes:
 - make seperate group for Chameleon v3 in dt-bindings
 - add blank line after copyright header

v2 changes:
 - split first patch into three
 - move sdmmc-ecc node to socfpga_arria10.dtsi (instead of removing it entirely)
 - use generic names for dts node names
 - keep the enclustra,mercury-aa1 compatible

Paweł Anikiel (5):
  ARM: dts: socfpga: Change Mercury+ AA1 dts to dtsi
  ARM: dts: socfpga: Move sdmmc-ecc node to Arria 10 dts
  ARM: dts: socfpga: Add atsha204a node to Mercury+ AA1 dts
  ARM: dts: socfpga: Add Google Chameleon v3 devicetree
  dt-bindings: altera: Add Chameleon v3 board

 .../devicetree/bindings/arm/altera.yaml       |  8 ++
 arch/arm/boot/dts/Makefile                    |  2 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi        | 10 +++
 .../boot/dts/socfpga_arria10_chameleonv3.dts  | 90 +++++++++++++++++++
 ...1.dts => socfpga_arria10_mercury_aa1.dtsi} | 48 ++--------
 5 files changed, 117 insertions(+), 41 deletions(-)
 create mode 100644 arch/arm/boot/dts/socfpga_arria10_chameleonv3.dts
 rename arch/arm/boot/dts/{socfpga_arria10_mercury_aa1.dts => socfpga_arria10_mercury_aa1.dtsi} (70%)

-- 
2.36.1.255.ge46751e96f-goog

