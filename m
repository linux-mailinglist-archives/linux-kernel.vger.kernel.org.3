Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86ED54678BE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380987AbhLCNxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbhLCNxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:53:15 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2A9C06173E;
        Fri,  3 Dec 2021 05:49:51 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id AE14E1F46E6B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638539389; bh=AnDiFrsgV5WgdCgD8vjRtGdtU3v0T9/rxm9SYGxtvnE=;
        h=From:To:Cc:Subject:Date:From;
        b=U4qKWwHGBDOLXZNq09fFcdqG5Z0XOoQSRBlzu69SNN/pCMIkTqYPVmTGrVflpYhZc
         wzOEwvU7RzU3bn1wHyYOVfLkpJJK1hGOlA1NsHggtOJcgnv0zLSIGNN7MnNk6DgDC4
         gPtCqQ8n4X9+cI1JrO8ofbrC6wh4bl2ittvPPsrYO8P6Hh37HmwLEZRN6nh4BS+Yte
         THRnwVeBVc4rbY4EKE8SF8QfgE0B9Fvyagc++Js66UmJrzbscdgNnneNl5toYzxWXa
         DwFILZWXXsrD4plKThLJ+R3Lto9OsxPBJbGGN81MmGURWGYr5rq/MV3uDmaVBJIPbd
         hm6Qgag1EZ4Kg==
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
Subject: [PATCH 0/4] fsl-asoc-card: Add optional dt property for setting mclk-id
Date:   Fri,  3 Dec 2021 10:49:26 -0300
Message-Id: <20211203134930.128703-1-ariel.dalessandro@collabora.com>
X-Mailer: git-send-email 2.30.2
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

Ariel D'Alessandro (4):
  dt-bindings: sound: Rename tlv320aic31xx-micbias as tlv320aic31xx
  dt-bindings: tlv320aic31xx: Define PLL clock inputs
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
2.30.2

