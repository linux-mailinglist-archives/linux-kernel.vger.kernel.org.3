Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCBA4FC070
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347852AbiDKPZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241470AbiDKPY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:24:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FC03A184;
        Mon, 11 Apr 2022 08:22:43 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v2so9861753wrv.6;
        Mon, 11 Apr 2022 08:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bq4dIdtXKyheEXERu/dkokTXmvj3klAE4IhWeKTikkc=;
        b=eEcwqL/0GMlDAli3FSZbUpl+NygNa18VLEwUBUq9iSth5Lqd/KsZ0V+ClTULeod8M+
         Fu3jsyrAA1MGtPFvLBv3NGvuymp4aA22DKFtHEpZDRMsdgOMipPaU5XxnF8FL9nHGHiV
         Wjnud9/NFYOoUAnI9QrwAc6bUCDm+/fLtHsPYOqwyVEQhtiXQZs5D8NYuFiatPtMqoIV
         xmaY+1TY1jGEZ932auNCY8lsJ2HEB93AuzbUQEqpyLayPte77b6RRg1uQA9ZGXgLP/0S
         88CHK3mgNy+NRl3nxa8KlhGs7rLzfsWGqUn5ExaLh65Eht8dVpeOHGS1leYCktxhUT5B
         /SHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bq4dIdtXKyheEXERu/dkokTXmvj3klAE4IhWeKTikkc=;
        b=zo/Yqrs1nyW6bkUd1rCxNYoNCDmOQHVoMG50cOIaZxBgCa7IQxc76/8KKgwJmgY6tR
         tU2c/ZDQ4wCPa98kxWJDnPoDP7z2F+3UvP2YN8u9iodzKN0YkVITfFQ41Zk3u9+9n8QS
         Ha6nAMOC2RwJ3XAxryeno0ix9Gh8qr2cVlzd78HgGbgBA9QpSAE37uywb3k1gAWsSoTg
         tDVLBSHo28kYnRk03xkychIsHSb6CAoTyLQJcmZ0CjvHZNmTvhjI5wnVDqin3rByCrta
         VRm02X0JlnJ6idSaOLK4jV+gjgS9g1Xs692aXZFa6XkH/jQA8Sdv+Kr1Qv3xRwksy63J
         arkA==
X-Gm-Message-State: AOAM531UrT0JWfj1txLPNm9MGAGqc795OxruGLlvhRqksaGKsR+Mcf1D
        BrdMezXhnB0KC3TV+UD1Q+g=
X-Google-Smtp-Source: ABdhPJzHLV5ITxizeFBwNp55Gv/lQjWoN2lKXUbEs96hO2MWAFI78oKQWP4tE+HZdnGCba3gg8YLOw==
X-Received: by 2002:adf:e84a:0:b0:207:a697:462c with SMTP id d10-20020adfe84a000000b00207a697462cmr4511198wrn.312.1649690562040;
        Mon, 11 Apr 2022 08:22:42 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id a9-20020a7bc1c9000000b0038eb67e966esm5209374wmj.29.2022.04.11.08.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:22:41 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Alistair Francis <alistair@alistair23.me>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Douglas Anderson <dianders@chromium.org>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Olof Johansson <olof@lixom.net>,
        Otavio Salvador <otavio@ossystems.com.br>,
        Pascal Zimmermann <pzimmermann@dh-electronics.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
Subject: [PATCH v2 00/14] ARM: dts: imx6dl-colibri: Misc improvements and newly added carriers
Date:   Mon, 11 Apr 2022 17:22:20 +0200
Message-Id: <20220411152234.12678-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>


This is a general update of the Colibri iMX6 device tree files.

The Toradex Colibri family is composed of a SoM that can be plugged on
various carrier boards, with carrier boards allowing multiple optional
accessories (e.g. display, camera, ...).

The device tree sources are structured into a SoM dtsi and a carrier dts
which then includes the SoM dtsi. The SoM dtsi defines and enables the
functionality self contained on the SoM and prepares for functionality
provided by the carrier HW or accessories, so that the carrier dts then
can enable or amend nodes provided. Accessories are enabled in overlays
depending on HW configuration.

The series improves the existing Colibri Evaluation Board device tree and
adds new device trees for the Aster, Iris, and Iris V2 carrier boards.

Additionally it drops the dedicated device tree for SoM V1.1 HW used in a
Evaluation board. The regular device tree works well in that combination.
The higher SD card speed possible with SoM V1.1 would require HW
modification on the carrier board.

Improvements:
- Specifies GPIO line names for use with libgpiod.
- Disables optional accessories. They would be enabled in overlays
  depending on HW configuration.
- Lower power consumption after poweroff.
- Move more functionality into the SoM dtsi file to reduce code
  duplication.
- General cleanup to adhere to dtbs bindings and missed alphabetically
  ordering.

Fixes:
- Copy/paste error in i2c2 pinmuxing resulting in i2c2 being
  nonfunctional.

Adds:
- imx6dl-colibri-aster.dtb: used for a Colibri iMX6 mated in an Aster
  carrier board.
- imx6dl-colibri-iris.dtb: used for a Colibri iMX6 mated in an
  Iris V1.x carrier board.
- imx6dl-colibri-iris-v2.dtb: used for a Colibri iMX6 mated in an
  Iris V2.x carrier board.

Drops:
- imx6dl-colibri-v1_1-eval-v3.dtb, imx6dl-colibri-eval-v3.dtb is good
  enough.

Changes in v2:
- Addressed 'From' address as reported by checkpatch / Shawn's feedback.
- Added Rob's Ack to the 'dt-bindings' patches.

Max Krummenacher (13):
  dt-bindings: arm: fsl: imx6dl-colibri: Drop dedicated v1.1 bindings
  dt-bindings: arm: fsl: Add carriers for toradex,colibri-imx6dl
  ARM: dts: imx6dl-colibri: Drop dedicated v1.1 device tree
  ARM: dts: imx6dl-colibri: Fix I2C pinmuxing
  ARM: dts: imx6dl-colibri: Disable add-on accessories
  ARM: dts: imx6dl-colibri: Command pmic to standby for poweroff
  ARM: dts: imx6dl-colibri: Add additional pingroups
  ARM: dts: imx6dl-colibri: Move common nodes to SoM dtsi
  ARM: dts: imx6dl-colibri: Cleanup
  ARM: dts: imx6dl-colibri: Add usdhc1 sleep pin configuration
  ARM: dts: imx6dl-colibri: Add support for Toradex Iris carrier boards
  ARM: dts: imx6dl-colibri: Add support for Toradex Aster carrier board
  ARM: imx_v6_v7_defconfig: Enable the ADC part of the STMPE MFD

Oleksandr Suvorov (1):
  ARM: dts: imx6dl-colibri: Add gpio-line-names

 .../devicetree/bindings/arm/fsl.yaml          |  11 +-
 arch/arm/boot/dts/Makefile                    |   4 +-
 arch/arm/boot/dts/imx6dl-colibri-aster.dts    | 113 +++
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts  | 110 +--
 arch/arm/boot/dts/imx6dl-colibri-iris-v2.dts  |  46 ++
 arch/arm/boot/dts/imx6dl-colibri-iris.dts     | 152 ++++
 .../boot/dts/imx6dl-colibri-v1_1-eval-v3.dts  |  31 -
 .../boot/dts/imx6qdl-colibri-v1_1-uhs.dtsi    |  44 -
 arch/arm/boot/dts/imx6qdl-colibri.dtsi        | 771 ++++++++++++++----
 arch/arm/configs/imx_v6_v7_defconfig          |   1 +
 10 files changed, 919 insertions(+), 364 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-colibri-aster.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-colibri-iris-v2.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-colibri-iris.dts
 delete mode 100644 arch/arm/boot/dts/imx6dl-colibri-v1_1-eval-v3.dts
 delete mode 100644 arch/arm/boot/dts/imx6qdl-colibri-v1_1-uhs.dtsi

-- 
2.20.1

