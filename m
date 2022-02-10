Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE124B1022
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242734AbiBJOTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:19:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242717AbiBJOTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:19:36 -0500
X-Greylist: delayed 19727 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 06:19:37 PST
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E34F5;
        Thu, 10 Feb 2022 06:19:37 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 700821F46563
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644502776;
        bh=g15F7ALHJ8lVbIQkW5krJ5yH/z+6t06WcZS8hyKBtcM=;
        h=From:To:Cc:Subject:Date:From;
        b=TF4Doc9RYiO/wLbmcAi5heLv6I2KrzpbKWeVKnuS7FkNecx+cnjtOM5g5uPySLEjB
         Sug5IkO8agBqprdlpKAOV17ChHrN8BQ7BstGG1PKPm+zpXRYffdc0z1cUTExJlnJDM
         oLP5jkxco1y+r41HcfCmxRxDm9Gi7KjIqb5v55o8ElvbXJZr6cHYhcl3T4/NyS86Ci
         0sUDb3EgPXbTGQUFHzUy98rSc87HF8/uWqgDC3Kiz9ipKFerHMoSgprQN+a8hsPxIk
         +ziQaF1vyONJzdb26HS/ZEI8Lao892VZ2F4rdiAvSwa2juIgmNeXS07Ct+VyLPG+p6
         h2/vXoZrEeBJQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sean.wang@kernel.org
Cc:     linus.walleij@linaro.org, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/5] MediaTek pinctrl drivers cleanups
Date:   Thu, 10 Feb 2022 15:19:26 +0100
Message-Id: <20220210141931.291712-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
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

Hello!
This series performs some cleanups to the MediaTek pinctrl drivers
by commonizing some functions (reducing code duplication) hence also
simplifying the probe mechanism by removing unnecessary per-driver
probe functions.

This code was tested against multiple platforms.

AngeloGioacchino Del Regno (5):
  pinctrl: mediatek: paris: Unify probe function by using OF match data
  pinctrl: mediatek: common-v1: Add common probe function
  pinctrl: mediatek: common-v1: Use common probe function
  pinctrl: mediatek: common-v1: Commonize spec_pupd callback
  pinctrl: mediatek: common-v1: Commonize spec_ies_smt_set callback

 drivers/pinctrl/mediatek/pinctrl-mt2701.c     | 40 ++++--------
 drivers/pinctrl/mediatek/pinctrl-mt2712.c     | 44 +++----------
 drivers/pinctrl/mediatek/pinctrl-mt6765.c     |  9 +--
 drivers/pinctrl/mediatek/pinctrl-mt6779.c     |  9 +--
 drivers/pinctrl/mediatek/pinctrl-mt6797.c     |  9 +--
 drivers/pinctrl/mediatek/pinctrl-mt8127.c     | 39 +++---------
 drivers/pinctrl/mediatek/pinctrl-mt8135.c     | 17 ++---
 drivers/pinctrl/mediatek/pinctrl-mt8167.c     | 40 +++---------
 drivers/pinctrl/mediatek/pinctrl-mt8173.c     | 29 +++------
 drivers/pinctrl/mediatek/pinctrl-mt8183.c     |  9 +--
 drivers/pinctrl/mediatek/pinctrl-mt8192.c     |  9 +--
 drivers/pinctrl/mediatek/pinctrl-mt8195.c     |  9 +--
 drivers/pinctrl/mediatek/pinctrl-mt8365.c     | 40 +++---------
 drivers/pinctrl/mediatek/pinctrl-mt8516.c     | 40 +++---------
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 63 ++++++++++++++-----
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h | 33 +++++++---
 drivers/pinctrl/mediatek/pinctrl-paris.c      |  9 ++-
 drivers/pinctrl/mediatek/pinctrl-paris.h      |  3 +-
 18 files changed, 165 insertions(+), 286 deletions(-)

-- 
2.33.1

