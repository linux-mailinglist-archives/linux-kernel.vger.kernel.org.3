Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF13528468
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbiEPMrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiEPMrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 08:47:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CC338BDF
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 05:47:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 282BE1F42F47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652705224;
        bh=2PcZ+zkUSpMcxhBp3CiBe+pfAkAQuOrvGTi0wVPJs0M=;
        h=From:To:Cc:Subject:Date:From;
        b=oNm3J4QXNtgsvm5b31db9EYGCF9KzLiwRMYlcJgmmH1ve1K95gtKAW+4QLvAcJ0Z1
         nMkVjFUa48f4wYXNqbqdZf6gNeP/zRW1r95lcxAK+P1G2YB3Dw1bEi6pYe0D3nL6xp
         Xz9uqMPD9Cdhf7xB5UubIVoHssKmDSvBbH3gLDCGPAkn+6DcI8DnWEMvLTiTJkCys5
         tyXA6825/NhiWRXslyfPRBe2ino6iowlsxICR7i1p/GFN+TcZa+QiayXrLhVT7AzgN
         +oRCvjyD8VX7sWPLKV8pYKEiBpJeNwR9rgCYaDuXzm0fEF8xUvmKDZqyydWTXII+/u
         bTxRIqh5qg7sg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        zhiyong.tao@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 0/5] MediaTek PMIC Wrap improvements and cleanups
Date:   Mon, 16 May 2022 14:46:54 +0200
Message-Id: <20220516124659.69484-1-angelogioacchino.delregno@collabora.com>
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

Changes in v3:
 - Added two more cleanup patches

Changes in v2:
 - Fixed a critical typo in patch 1/3. Thanks Nicolas!

AngeloGioacchino Del Regno (5):
  soc: mediatek: pwrap: Use readx_poll_timeout() instead of custom
    function
  soc: mediatek: pwrap: Switch to
    devm_platform_ioremap_resource_byname()
  soc: mediatek: pwrap: Move and check return value of
    platform_get_irq()
  soc: mediatek: pwrap: Move IO pointers to new structure
  soc: mediatek: pwrap: Compress of_device_id entries to one line

 drivers/soc/mediatek/mtk-pmic-wrap.c | 224 ++++++++++++---------------
 1 file changed, 95 insertions(+), 129 deletions(-)

-- 
2.35.1

