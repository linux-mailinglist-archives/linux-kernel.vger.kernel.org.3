Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE175B0651
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiIGOVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiIGOVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:21:40 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D7172FEB;
        Wed,  7 Sep 2022 07:21:35 -0700 (PDT)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 20F56200002;
        Wed,  7 Sep 2022 14:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662560494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7RATQ1JbATm9X+Wc/5gqBHh5cXHWLcY7/Zz0xbFDNbo=;
        b=e71aa7ZeQb+9niVLutMjhbHbiGoOVQXyA8/LYnJf6HK/XgDE2v/9cdl/QMBMw0CBJA83wA
        xQMwsyTWB1jngIHRUMyqlxrTakDtZsGdB2iEE3oFTOlOcONVb5V6RwXiV+Sz9uENIZBgb0
        tkcriO403wd1xDp0mW+Ju7ShSvsJiJhVdIMkf5hCNe6c58QDR/sukT7fefkIofgjXft5UA
        ZxnZ3K7/6l8ACrICnNUQOh0ZKVvt4vBja9CLE5I2G1tTPSWs9rs0Gr1xvyYsIzqc6m3ZHi
        xiQdInb+cbNKXyPL0Vj/5Per31+MIKNsHcGRhKBOg8Z79DH3E2rFmDxYPYnclA==
From:   luca.ceresoli@bootlin.com
To:     alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/8] Add support for the internal RK3308 audio codec
Date:   Wed,  7 Sep 2022 16:21:16 +0200
Message-Id: <20220907142124.2532620-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Ceresoli <luca.ceresoli@bootlin.com>

This series of patches adds support to use the internal audio codec of the
Rockchip RK3308 SoC. This codec is internally connected to the I2S
peripherals on the same chip, and it has some peculiarities arising from
that interconnection.

For proper bidirectional operation with the internal codec, the I2S
peripheral needs two clock sources (tx and rx), while connection with an
external codec commonly needs only one. Since v5.16 there is a driver for
the I2S in sound/soc/rockchip/rockchip_i2s_tdm.c, but it does not correctly
handle receiving those two clocks via the .set_sysclk op. Patch 5 fixes
that.

However the simple-audio-card and audio-graph-card sound card drivers do
not support calling .set_sysclk twice, thus patch 6 makes the .init op of
struct asoc_simple_priv overridable by a driver in order to be able to call
.set_sysclk twice and thus configure both clocks.

Patch 7 adds the codec driver and patch 8 builds on top of all the above by
implementing a simple RK3308-specific audio card, based on
audio-graph-card. This card sets all the I2S input clocks.

Patches 1-2 add DT bindings for the codec and the card. Patches 3-4 add to
the SoC DT file two I2S controllers (those which are internally connected
to the internal codec) and the codec itself.

Luca

Luca Ceresoli (8):
  ASoC: rockchip: rk3308: add internal audio codec bindings
  ASoC: rockchip: rk3308: add audio card bindings
  arm64: dts: rockchip: add i2s_8ch_2 and i2s_8ch_3
  arm64: dts: rockchip: add the internal audio codec
  ASoC: rockchip: i2s-tdm: Fix clk_id usage in .set_sysclk()
  ASoC: audio-graph: let dai_link->init be overridable
  ASoC: codecs: Add RK3308 internal audio codec driver
  ASoC: rockchip: add new RK3308 sound card

 .../rockchip,rk3308-audio-graph-card.yaml     |   50 +
 .../bindings/sound/rockchip,rk3308-codec.yaml |  102 +
 MAINTAINERS                                   |   14 +
 arch/arm64/boot/dts/rockchip/rk3308.dtsi      |   68 +
 .../dt-bindings/sound/rockchip,rk3308-codec.h |   15 +
 include/sound/simple_card_utils.h             |    1 +
 sound/soc/codecs/Kconfig                      |   11 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/rk3308_codec.c               | 2122 +++++++++++++++++
 sound/soc/codecs/rk3308_codec.h               |  648 +++++
 sound/soc/generic/audio-graph-card.c          |    2 +
 sound/soc/rockchip/Kconfig                    |   14 +
 sound/soc/rockchip/Makefile                   |    1 +
 sound/soc/rockchip/rockchip_i2s_tdm.c         |   18 +-
 sound/soc/rockchip/rockchip_rk3308_card.c     |   97 +
 15 files changed, 3159 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3308-audio-graph-card.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3308-codec.yaml
 create mode 100644 include/dt-bindings/sound/rockchip,rk3308-codec.h
 create mode 100644 sound/soc/codecs/rk3308_codec.c
 create mode 100644 sound/soc/codecs/rk3308_codec.h
 create mode 100644 sound/soc/rockchip/rockchip_rk3308_card.c

-- 
2.34.1

