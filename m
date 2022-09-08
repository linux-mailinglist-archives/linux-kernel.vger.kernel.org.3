Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9725B232F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiIHQMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIHQMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:12:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371FCE5580;
        Thu,  8 Sep 2022 09:12:02 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [70.107.189.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7C7D66601FA8;
        Thu,  8 Sep 2022 17:11:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662653520;
        bh=s1PBe/pF5jJRbyhX3WY2pGtR1K/IVs/yQHt+cEPY7+0=;
        h=From:To:Cc:Subject:Date:From;
        b=V7N5SxKgNXkE3uhhv7ZXVkgT4pvDUknukRkXkl61R4/jVZ4XBueUDpfCU1lxCPOwH
         LvJSO6jNTMRoOWPJGXIvz10MNmkDuCn9oi7WK1IurPMc+Qh74TKrzlDSt0U7SCcOqU
         MZhGzF6qsaA1i9eXPUFJJ0Gv38EZwaXcu2ELIplCvJCX9ivQkykgO2PkN85j6VxssY
         6vL/OwMn8f4Vm2jWxrj9Umayk+m33VIBt7i3gAXRghoKsZhArCMG0dbI8W+prz+EIt
         h6v7GWRjdI6+DINlzVa8Fy+v8DBRSouseVm9wT43xDi1joxYUxFzkxVpkYyA8txfop
         9djx3x4z6uSRg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Akihiko Odaki <akihiko.odaki@gmail.com>,
        Chunxu Li <chunxu.li@mediatek.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 00/10] ASoC: mediatek: Set i2s clock sharing from machine drivers
Date:   Thu,  8 Sep 2022 12:11:44 -0400
Message-Id: <20220908161154.648557-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.3
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


The i2s ports on MediaTek SoCs only support a single data lane. In order
to achieve full-duplex operation thus two i2s ports, one for input and
one for output, need to be used together and sharing a single clock from
one of the ports.

This clock sharing setting was previously read by the sound platform
driver from the devicetree, but given that the input/output pairing is
closely related to which codecs are connected to which ports, the
machine sound driver can infer and set it, so that no DT property is
required.

At this point only mt8183-kukui was using the DT property, but given
that this property was never documented, and that the API introduced in
this series makes it obsolete, the undocumented DT property can safely
be removed.

This series adds a function to allow setting the i2s shared clocks,
makes use of it in the machine drivers as required, and removes the no
longer required DT properties and support for them in the drivers, for
all of mt8192, mt8183 and mt8186.


Nícolas F. R. A. Prado (10):
  ASoC: mediatek: mt8192: Allow setting shared clocks from machine
    driver
  ASoC: mediatek: mt8192-mt6359: Make i2s9 share the clock from i2s8
  ASoC: mediatek: mt8192: Remove clock share parsing from DT
  ASoC: mediatek: mt8183: Allow setting shared clocks from machine
    driver
  ASoC: mediatek: mt8183: Configure shared clocks
  ASoC: mediatek: mt8183: Remove clock share parsing from DT
  arm64: dts: mediatek: kukui: Remove i2s-share properties
  ASoC: mediatek: mt8186: Allow setting shared clocks from machine
    driver
  ASoC: mediatek: mt8186: Configure shared clocks
  ASoC: mediatek: mt8186: Remove clock share parsing from DT

 .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  5 --
 sound/soc/mediatek/mt8183/mt8183-afe-common.h |  3 ++
 .../mediatek/mt8183/mt8183-da7219-max98357.c  | 33 +++++++++++++
 sound/soc/mediatek/mt8183/mt8183-dai-i2s.c    | 45 ++++++++---------
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c   | 33 +++++++++++++
 sound/soc/mediatek/mt8186/mt8186-afe-common.h |  3 ++
 sound/soc/mediatek/mt8186/mt8186-dai-i2s.c    | 44 ++++++++---------
 .../mt8186/mt8186-mt6366-da7219-max98357.c    | 18 +++++++
 .../mt8186/mt8186-mt6366-rt1019-rt5682s.c     | 18 +++++++
 sound/soc/mediatek/mt8192/mt8192-afe-common.h |  3 ++
 sound/soc/mediatek/mt8192/mt8192-dai-i2s.c    | 49 ++++++++-----------
 .../mt8192/mt8192-mt6359-rt1015-rt5682.c      |  9 ++++
 12 files changed, 180 insertions(+), 83 deletions(-)

-- 
2.37.3

