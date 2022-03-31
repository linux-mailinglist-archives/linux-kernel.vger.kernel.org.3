Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83244ED510
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbiCaIAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCaIAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:00:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B652013EAE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 00:58:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 119661F463AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648713502;
        bh=q+KkXh4Pi0KibB5c7kl1SmkyDO/TsKJGH9MCkwBZDHU=;
        h=From:To:Cc:Subject:Date:From;
        b=GMvRcREW1cy7oMzB9xtXztHtyYLyMopePT1upmpmVdQUDsKoWudWaIdGFyDAN1dps
         NUcctXekdvSAi2VJf7bc5ElGnw2PneAE1o7ESKBIEIoXvdEeTQj6jiFoozKShnAxHw
         tmpYfL2vSdSxvyoNJlT8fje7gyXC3VJWqdtxPAKC6+vlY8d1PbSkEOH2TeWPSzaMSD
         zUGrJCuYgZHS91v6KDZhv2Lln88+fwyKAVR4HgQQ2Yl6n341xcOlYMpUNK0RtljRNF
         JZHpbvIIKYQyqGFr7GH923Ta0H73SCYH7Wo4kkFY+5QWaN7SD95UuXsA5P1kNcUlii
         gnu3ptbYxkzHw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 0/3] MediaTek PMIC Wrap improvements and cleanups
Date:   Thu, 31 Mar 2022 09:58:14 +0200
Message-Id: <20220331075817.7122-1-angelogioacchino.delregno@collabora.com>
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

Changes in v2:
 - Fixed a critical typo in patch 1/3. Thanks Nicolas!

AngeloGioacchino Del Regno (3):
  soc: mediatek: pwrap: Use readx_poll_timeout() instead of custom
    function
  soc: mediatek: pwrap: Switch to
    devm_platform_ioremap_resource_byname()
  soc: mediatek: pwrap: Move and check return value of
    platform_get_irq()

 drivers/soc/mediatek/mtk-pmic-wrap.c | 73 +++++++++++++++-------------
 1 file changed, 39 insertions(+), 34 deletions(-)

-- 
2.35.1

