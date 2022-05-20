Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E2652EC55
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349369AbiETMky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349276AbiETMkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:40:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A392DD6;
        Fri, 20 May 2022 05:40:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 7F4261F462A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653050443;
        bh=xWMNR+zE+UnsdH+9w2byRvIquFAh3MbREE3UdlA2/kw=;
        h=From:To:Cc:Subject:Date:From;
        b=eZa/Mw01gwpR5TW2F0uF/2dR9lSUFwkMtgGkX5+74375/19+cXM3TmNM1Y/4yfH8A
         nUX/owvhX/WQE0lBu3nnf9ojmkg71Os26Xgx/pXC2Al30rxd1EGDTWWiyCAfs5+Ufs
         5xAD92MHp6keq828bjx2tkC4mgx0XcuX8xX5bsFoSOMG6NhnZcDfBElzsLoiTKOJUr
         EayO3WQfU/vRIhPhiO+rVA2zhwxPm7N/rJWZiDFSKdvVtLZAJOATke/0lCCUg6KVsu
         i3nwyqKgXFg9U8uJvQJVjF28yUMbOTRSO/ne7jJJuvrMzHOI15PPngogFtgeGbD0Ql
         d6XSX5MN4143w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     lee.jones@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        zhiyong.tao@mediatek.com, henryc.chen@mediatek.com,
        johnson.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] MediaTek Helio X10 MT6795 - MT6331/6332 PMIC Wrapper
Date:   Fri, 20 May 2022 14:40:32 +0200
Message-Id: <20220520124039.228314-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an effort to give some love to the apparently forgotten MT6795 SoC,
I am upstreaming more components that are necessary to support platforms
powered by this one apart from a simple boot to serial console.

This series introduces support in the PMIC Wrapper for a different PMIC
topology, which is commonly found on smartphone boards, using one main
PMIC and one Companion PMIC;
be aware that this kind of topology is not *specific to* the Helio X10
SoC, but common across many kinds of MediaTek smartphone oriented SoCs
and board designs.

That said, support for the PMIC combo MT6331+MT6332 is provided in this
series in a form that will be able to initialize the PMICs with crypto
and DualIO but nothing else: these PMICs are very featureful, so I have
decided to add this support in more than just one step, as there will
be multiple patches for multiple different subsystems (..it's a mfd!..).

Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.

AngeloGioacchino Del Regno (7):
  soc: mediatek: pwrap: Move PMIC read test sequence in function
  soc: mediatek: pwrap: Add kerneldoc for struct pwrap_slv_type
  soc: mediatek: mtk-pmic-wrap: Add support for companion PMICs
  dt-bindings: mfd: Add compatible for MT6331 PMIC
  soc: mediatek: mtk-pmic-wrap: Add support for MT6331 w/ MT6332
    companion
  dt-bindings: mediatek: pwrap: Add a compatible for MT6795 Helio X10
  soc: mediatek: pwrap: Add support for MT6795 Helio X10

 .../devicetree/bindings/mfd/mt6397.txt        |   1 +
 .../bindings/soc/mediatek/pwrap.txt           |   1 +
 drivers/soc/mediatek/mtk-pmic-wrap.c          | 287 ++++++++++++++++--
 3 files changed, 263 insertions(+), 26 deletions(-)

-- 
2.35.1

