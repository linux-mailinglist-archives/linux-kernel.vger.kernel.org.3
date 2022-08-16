Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8625759633A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 21:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237153AbiHPTdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 15:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237146AbiHPTdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:33:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09708876AD;
        Tue, 16 Aug 2022 12:33:03 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [70.107.189.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DCDE3660159A;
        Tue, 16 Aug 2022 20:33:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1660678382;
        bh=NDZOYYtE7Z7aJgkBinWoKrxMwniorPfp7MHSzfu5Mmk=;
        h=From:To:Cc:Subject:Date:From;
        b=dZbky2nCHVH0QRnFC1mUdc0o0fJ2I2afS2OKokeQglstEyosRSwGdiHi4l/MQWb1/
         +LWG8GI8AoA0jfk32bVYxSjDpjw2+oJ/Ze1/4umZwbevfBrui0ftCdVNSsOT3dX3P6
         TsiUVH1uYkJGi34+30XCMXJ/697KhVR2xA9Of8OqY+ZKGF/obOlfwJczmEZCEzUjXC
         oHc3LpP0ce1rpJofE+8lKdwy8LrtO8Dqep5fqWeiPLyuaGXb+s7yUAEAv1JP8Py1U7
         hvOZ5YrWaYPnB5ry7IQgd69LpShv4++oJe7e+RaCbxrs12mN0Im9FsXdeYDfp2clS9
         cwKHFCRX3wdqg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     Bo-Chen Chen <rex-bc.chen@mediatek.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [RESEND PATCH v3 0/2] MediaTek Kompanio 1200 MT8195 - DisplayPort clocks fixes
Date:   Tue, 16 Aug 2022 15:32:54 -0400
Message-Id: <20220816193257.658487-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.1
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


This series fixes the two DPINTF clocks to propagate rate change
requests to their own parent (and also fixes vdo1_dpintf's parent name).

This is needed in order to stay clean in the DisplayPort driver and
avoid adding (now useless) custom handling of clocks reparenting based
on the wanted final clock rate.

Original v3: https://lore.kernel.org/all/20220617111248.90505-1-angelogioacchino.delregno@collabora.com/

Changes in v3:
- Fixed tags ordering.

AngeloGioacchino Del Regno (2):
  clk: mediatek: clk-mt8195-vdo0: Set rate on vdo0_dp_intf0_dp_intf's
    parent
  clk: mediatek: clk-mt8195-vdo1: Reparent and set rate on vdo1_dpintf's
    parent

 drivers/clk/mediatek/clk-mt8195-vdo0.c | 7 ++++++-
 drivers/clk/mediatek/clk-mt8195-vdo1.c | 6 +++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.37.1

