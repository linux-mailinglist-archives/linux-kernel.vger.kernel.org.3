Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18A749095D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbiAQNV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 08:21:28 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52860 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbiAQNV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:21:27 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 9FE951F439D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642425686;
        bh=cLpfRqHBURM9rPTwgK+plOEmXlOGSYOFoD1NYi3A9mc=;
        h=From:To:Cc:Subject:Date:From;
        b=AuQBprJ8i3XCaq30qQMFk4a9PThm05/O46+YIvsdbm1F+SQT5ZBUWBz4gAhyQiSj1
         ll7IXNX9lzGT1dFT8+Y6yppTQeRGlFzdji++G2JEcXNxHah7P13D1RYZQPwkWZG1SH
         ueqe792bXa1IwliwmL0uQW4/DBSVFVoYxHYL/LbBeWqSPneJiVIH7LlO7ana3HqGWE
         H0oDsoH004kaMx7wt/Fn3qBd3JpBzmMUpOKlScZ/YZG0CXxOP+/8fxzD/qZVisSZQ+
         aHdfRBtNkPgVNmPw7KGYTObE/6NySch99Pr7G29on7YxfuDeS//DZ7jPX8YSq7FdAd
         speTeoYIXz7Uw==
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
To:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Xiubo.Lee@gmail.com, ariel.dalessandro@collabora.com,
        bcousson@baylibre.com, broonie@kernel.org, festevam@gmail.com,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        michael@amarulasolutions.com, nicoleotsuka@gmail.com,
        perex@perex.cz, robh+dt@kernel.org, shengjiu.wang@gmail.com,
        tiwai@suse.com, tony@atomide.com
Subject: [PATCH v2 0/5] fsl-asoc-card: Add optional dt property for setting mclk-id
Date:   Mon, 17 Jan 2022 10:21:04 -0300
Message-Id: <20220117132109.283365-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow up of patchset:

    [RFC patch 0/5] Support BCLK input clock in tlv320aic31xx

Sound cards may allow using different main clock inputs. In the generic
fsl-asoc-card driver, these values are hardcoded for each specific card
configuration.

Let's make it more flexible, allowing setting mclk-id from the
device-tree node.

Changes in v2:
* Split patch adding mckl-id property.

Ariel D'Alessandro (5):
  dt-bindings: sound: Rename tlv320aic31xx-micbias as tlv320aic31xx
  dt-bindings: tlv320aic31xx: Define PLL clock inputs
  ASoC: bindings: fsl-asoc-card: Add mclk-id optional property
  ASoC: fsl-asoc-card: Add optional dt property for setting mclk-id
  ASoC: fsl-asoc-card: Remove BCLK default value for tlv320aic31xx card

 .../devicetree/bindings/sound/fsl-asoc-card.txt    |  1 +
 .../devicetree/bindings/sound/tlv320aic31xx.txt    |  2 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |  2 +-
 include/dt-bindings/sound/tlv320aic31xx-micbias.h  |  9 ---------
 include/dt-bindings/sound/tlv320aic31xx.h          | 14 ++++++++++++++
 sound/soc/codecs/tlv320aic31xx.c                   |  2 +-
 sound/soc/fsl/fsl-asoc-card.c                      |  7 ++++++-
 7 files changed, 24 insertions(+), 13 deletions(-)
 delete mode 100644 include/dt-bindings/sound/tlv320aic31xx-micbias.h
 create mode 100644 include/dt-bindings/sound/tlv320aic31xx.h

-- 
2.34.1

