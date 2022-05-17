Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1139529FBD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236864AbiEQKra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344576AbiEQKrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:47:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E25D3527C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:47:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 19BE71F444CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652784436;
        bh=bYMgEgCn3a8Bcf/XO+hS7bqnZvVx/+/SMVYi/R86hPs=;
        h=From:To:Cc:Subject:Date:From;
        b=NylxLWVXYMVBcdkxgTPEB8p03eKsjx9cQt5xMlhTzkmfHsvfib0WxViszQYLn+tQ+
         Ge9In22rDXzuJI1067vaG1+sVMC6cSEoIrnWx9uqcMEVGfdlbDYaGK2L+BZrOo/PU5
         oIchXHL08sb4evV/StxHXLlWJ1E9AzDcSB+b6eh+Xu0QULnSubC16Lncu2PSELqAAz
         pIU6JPmBJNfncSgiVA1EsN9jAh2RXlQp5Vks5bS05jF2S0eCVFNp3hNjw8P2CiQoDv
         coMhtuPr0xo8AmOEOr5RTwtrCGw602fY1lP1X9305bP8KOxB1BJktSM7UEfyIR3KFA
         +NuOd5qkobs7w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        zhiyong.tao@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v4 0/5] MediaTek PMIC Wrap improvements and cleanups
Date:   Tue, 17 May 2022 12:47:07 +0200
Message-Id: <20220517104712.24579-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series is meant to improve the mtk-pmic-wrap driver;
that's done by removing the custom pwrap_wait_for_state() function
and correctly using the readx_poll_timeout macro instead, which is
doing exactly the same as the former.

As also shown in a patch [1] by Zhiyong Tao (MediaTek), performing
a tight loop is not desired: because of the operation timing in the
SPMI PMICs on these platforms, it makes more sense to wait for some
microseconds before trying to read again, reducing CPU busy time
around these state waits. For this purpose, a ~10uS delay was chosen.

While at it, I also took the occasion to tidy up this driver a
little by optimizing its probe() function.

[1]: https://patchwork.kernel.org/project/linux-mediatek/patch/20220329115824.13005-2-zhiyong.tao@mediatek.com/

Changes in v4:
 - Avoided moving call to platform_get_irq in patch 3/5
 - Dropped Nicolas' tags from patch 3/5 as it's different now
 - Added newline for readability in comment on patch 5/5

Changes in v3:
 - Added two more cleanup patches (4/5, 5/5)

Changes in v2:
 - Fixed a critical typo in patch 1/5. Thanks Nicolas!

AngeloGioacchino Del Regno (5):
  soc: mediatek: pwrap: Use readx_poll_timeout() instead of custom
    function
  soc: mediatek: pwrap: Switch to
    devm_platform_ioremap_resource_byname()
  soc: mediatek: pwrap: Check return value of platform_get_irq()
  soc: mediatek: pwrap: Move IO pointers to new structure
  soc: mediatek: pwrap: Compress of_device_id entries to one line

 drivers/soc/mediatek/mtk-pmic-wrap.c | 225 ++++++++++++---------------
 1 file changed, 97 insertions(+), 128 deletions(-)

-- 
2.35.1

