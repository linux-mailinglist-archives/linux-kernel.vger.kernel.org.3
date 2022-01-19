Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E4E493269
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 02:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350720AbiASBmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 20:42:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51420 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238680AbiASBmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 20:42:51 -0500
X-UUID: 362a9280a10a4806bdaa4d8485ecdbad-20220119
X-UUID: 362a9280a10a4806bdaa4d8485ecdbad-20220119
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <guodong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2088102564; Wed, 19 Jan 2022 09:42:49 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Jan 2022 09:42:47 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Jan 2022 09:42:47 +0800
Message-ID: <eca4a0c18fe75536c8276410628b9459c040dce2.camel@mediatek.com>
Subject: Re: [PATCH 2/7] pinctrl: mediatek: paris: Fix
 PIN_CONFIG_BIAS_DISABLE readback
From:   Guodong Liu <guodong.liu@mediatek.com>
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-mediatek@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Zhiyong Tao" <zhiyong.tao@mediatek.com>,
        Hui Liu <hui.liu@mediatek.com>,
        Light Hsieh <light.hsieh@mediatek.com>
Date:   Wed, 19 Jan 2022 09:42:46 +0800
In-Reply-To: <20220111112244.1483783-3-wenst@chromium.org>
References: <20220111112244.1483783-1-wenst@chromium.org>
         <20220111112244.1483783-3-wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Chen-Yu Tsai <wenst@chromium.org>
To: Sean Wang <sean.wang@kernel.org>, Linus Walleij <
linus.walleij@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, 
linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
Zhiyong Tao <zhiyong.tao@mediatek.com>, Guodong Liu <
guodong.liu@mediatek.com>
Subject: [PATCH 2/7] pinctrl: mediatek: paris: Fix
PIN_CONFIG_BIAS_DISABLE readback
Date: Tue, 11 Jan 2022 19:22:39 +0800

When reading back pin bias settings, if the pin is not in a
bias-disabled state, the function should return -EINVAL.

Fix this in the mediatek-paris pinctrl library so that the read back
state is not littered with bogus a "input bias disabled" combined with
"pull up" or "pull down" states.

Fixes: 805250982bb5 ("pinctrl: mediatek: add pinctrl-paris that
implements the vendor dt-bindings")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pinctrl/mediatek/pinctrl-paris.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c
b/drivers/pinctrl/mediatek/pinctrl-paris.c
index f9f9110f2107..1ca598ea7ba7 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -97,8 +97,8 @@ static int mtk_pinconf_get(struct pinctrl_dev
*pctldev,
 			if (err)
 				goto out;
 			if (param == PIN_CONFIG_BIAS_DISABLE) {
-				if (ret == MTK_PUPD_SET_R1R0_00)
-					ret = MTK_DISABLE;
+				if (ret != MTK_PUPD_SET_R1R0_00)
+					err = -EINVAL;
Hi Chen-Yu

When tht API "hw->soc->bias_get_combo(hw, desc, &pullup, &ret)" is
called,
The ret vaule of may be MTK_DISABLE OR MTK_PUPD_SET_R1R0_00 or  (pullen
== 0),  All those cases are expected to be as "bias-disable".
We advices to keep original code,

+				if (ret == MTK_PUPD_SET_R1R0_00)
+	
				ret = MTK_DISABLE;
+				if (ret != MTK_DISABLE)
+					err = -EINVAL;

Thanks
 			} else if (param == PIN_CONFIG_BIAS_PULL_UP) {
 				/* When desire to get pull-up value,
return
 				 *  error if current setting is pull-
down

