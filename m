Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176DB5AE41E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbiIFJ1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiIFJ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:27:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E05BCD9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 02:27:37 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C837F6600375;
        Tue,  6 Sep 2022 10:27:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662456456;
        bh=JpEcgC6jYLZbY4tQDi6ZRqCoL5pekVUoZKTqmNe+EIo=;
        h=From:To:Cc:Subject:Date:From;
        b=eSkU6oLC56uV4TWJxoKjhECXppBMxt0BdBBkgQ5zPLRbdSSZo3vtrLPa0E+5f4Hed
         h8UMA/dJWZKbG8i1AwbGlDjDaTJc4wXYzjUBr5QCQjWDYkXi5gZZ3kSLlIeTq0TauB
         B+B4jNe1q4H8DCM4nK56nWCmrK2t7g+qNA3hfwzBR756VMBk8dNZKT/xOPX6CMWMmB
         nDf2vPe8G0rJxqEnYdn5zAtY8asnCPFW2ylM/IVp2pf8WveyBYswJ7kstc33M0UY4R
         2+gYIQMZat6aTSqdWCRRz+uppT8w6LRZ+oj82ui2SvXa740I1d0Kod6PSmE9bt6Iri
         pfJlsrGoOASZQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, wenst@chromium.org,
        pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, trevor.wu@mediatek.com, tzungbi@google.com,
        angelogioacchino.delregno@collabora.com, yc.hung@mediatek.com,
        Allen-KH.Cheng@mediatek.com, geert@linux-m68k.org,
        chunxu.li@mediatek.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org, kernel@collabora.com
Subject: [PATCH 0/5] ASoC: Fixes for MT8195 SOF support
Date:   Tue,  6 Sep 2022 11:27:22 +0200
Message-Id: <20220906092727.37324-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes Sound Open Firmware support for MT8195 by making
sure that the sound card driver is actually able to probe and IPC
can finally happen.
It is now possible to get DSP support for audio.

Tested on MT8195 Tomato - Acer Chromebook Spin 513 CP513-2H (Pipewire).

AngeloGioacchino Del Regno (5):
  ASoC: mediatek: mt8195-mt6359: Properly register sound card for SOF
  ASoC: SOF: mediatek: mt8195: Import namespace SND_SOC_SOF_MTK_COMMON
  ASoC: SOF: mediatek: mt8195: Add mailbox generic callbacks for IPC
  ASoC: SOF: mediatek: mt8195: Add generic pcm_{open,close} callbacks
  ASoC: SOF: mediatek: mt8195: Add devicetree support to select
    topologies

 sound/soc/mediatek/mt8195/mt8195-mt6359.c |  6 +++++
 sound/soc/sof/mediatek/mt8195/mt8195.c    | 32 ++++++++++++++++-------
 2 files changed, 29 insertions(+), 9 deletions(-)

-- 
2.37.2

