Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E710753EE68
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiFFTUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiFFTT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:19:58 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEF3113A21;
        Mon,  6 Jun 2022 12:19:54 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1654543191; bh=/hmKUt7bKZ+vS3xQgBgBubVAOQI0iUYXfBsj1iDGvNo=;
        h=From:To:Cc:Subject:Date;
        b=NTBH9HEpba5B0vY0Fb0D/5XET+BqBriweMvoXzWlV2IMrfLln9CzCQR4ds1HgKSun
         n9hBgB5grSVVoF5dVG5IoXB84nUpb6FFpU63OJD808r5gtjeNKHp7Ri68QE6uuFXMr
         16xzkpyosI07VekfptdOMf614aGaP6bxlswQ/QYU=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, asahi@lists.linux.dev
Subject: [RFC PATCH v2 0/5] Apple Macs machine/platform ASoC driver
Date:   Mon,  6 Jun 2022 21:19:05 +0200
Message-Id: <20220606191910.16580-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is again RFC with a machine-level ASoC driver for recent Apple Macs
with the M1 line of chips. This time I attached the platform driver too
for good measure. What I am interested in the most is checking the overall
approach, especially on two points (both in some ways already discussed
in previous RFC [0]):

 - The way the platform/machine driver handles the fact that multiple I2S
   ports (now backend DAIs) can be driven by/connected to the same SERDES
   unit (now in effect a frontend DAI). After previous discussion I have
   transitioned to DPCM to model this. I took the opportunity of dynamic
   backend/frontend routing to support speakers/headphones runtime
   switching. More on this in comments at top of the machine and platform
   driver.

 - The way the machine driver deactivates some of the controls where
   suitable, and limits volume on others. I added a new ASoC card method
   to that end.

Kind regards,
Martin

[0] https://lore.kernel.org/linux-devicetree/20220331000449.41062-1-povik+lin@cutebit.org/

Martin Povišer (5):
  dt-bindings: sound: Add Apple MCA I2S transceiver
  dt-bindings: sound: Add Apple Macs sound peripherals
  ASoC: apple: Add MCA platform driver for Apple SoCs
  ASoC: Introduce 'fixup_controls' card method
  ASoC: apple: Add macaudio machine driver

 .../bindings/sound/apple,macaudio.yaml        |  157 +++
 .../devicetree/bindings/sound/apple,mca.yaml  |  102 ++
 include/sound/soc-card.h                      |    1 +
 include/sound/soc.h                           |    1 +
 sound/soc/Kconfig                             |    1 +
 sound/soc/Makefile                            |    1 +
 sound/soc/apple/Kconfig                       |   25 +
 sound/soc/apple/Makefile                      |    5 +
 sound/soc/apple/macaudio.c                    | 1004 +++++++++++++++
 sound/soc/apple/mca.c                         | 1122 +++++++++++++++++
 sound/soc/soc-card.c                          |    6 +
 sound/soc/soc-core.c                          |    1 +
 12 files changed, 2426 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/apple,macaudio.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/apple,mca.yaml
 create mode 100644 sound/soc/apple/Kconfig
 create mode 100644 sound/soc/apple/Makefile
 create mode 100644 sound/soc/apple/macaudio.c
 create mode 100644 sound/soc/apple/mca.c

-- 
2.33.0

