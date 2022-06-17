Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E689F54F466
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381053AbiFQJef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381237AbiFQJec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:34:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3559266FA8;
        Fri, 17 Jun 2022 02:34:31 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3F027660179B;
        Fri, 17 Jun 2022 10:34:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655458469;
        bh=qNXMzT2jD6Hu7vIEmFarbDuyoK/cbMytCaqq9CTTLMw=;
        h=From:To:Cc:Subject:Date:From;
        b=Ip5v8GWPyv6LpjgOCKtwoBTlu9lna799wxt6GSE76YD1KQlS2QRBYwmiKjUI4N7hg
         4oBZBHkAK7kaXaYo6GpG2xcMKPWyKRERNjO7Nd1PdsJkqb8JQx4mNcKL9FX7OJHrzn
         FnOkIt9Quc0wyfhXylWYhO5tRUEr8KgTqsm1LRJgQyAhfpo0z6uy2BCB+LM1PFA1jG
         t/7NQIbZcYq4O/o7zAOYnuLlbNsGMEGK+djRIz2mnBEd3LiI4dcjaLaVpV5GZfia0u
         Gr4tJ+brHdnTdPeqd0iqZspEipLE3n2RFj2iRseG90BGp4SP1/KU5c1A4nnfTnEQ6p
         38GhCGc1mCbkQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, wenst@chromium.org,
        angelogioacchino.delregno@collabora.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] MediaTek Kompanio 1200 MT8195 - DisplayPort clocks fixes
Date:   Fri, 17 Jun 2022 11:34:22 +0200
Message-Id: <20220617093424.75589-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
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

This series fixes the two DPINTF clocks to propagate rate change
requests to their own parent (and also fixes vdo1_dpintf's parent name).

This is needed in order to stay clean in the DisplayPort driver and
avoid adding (now useless) custom handling of clocks reparenting based
on the wanted final clock rate.

AngeloGioacchino Del Regno (2):
  clk: mediatek: clk-mt8195-vdo0: Set rate on vdo0_dp_intf0_dp_intf's
    parent
  clk: mediatek: clk-mt8195-vdo1: Reparent and set rate on vdo1_dpintf's
    parent

 drivers/clk/mediatek/clk-mt8195-vdo0.c | 7 ++++++-
 drivers/clk/mediatek/clk-mt8195-vdo1.c | 6 +++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.35.1

