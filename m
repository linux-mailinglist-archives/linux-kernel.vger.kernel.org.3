Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81E9559A6D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbiFXNhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiFXNhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:37:18 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E15403CB;
        Fri, 24 Jun 2022 06:37:10 -0700 (PDT)
X-UUID: 8a594478fc1c4e89bef7eccb6dfe713f-20220624
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:d932a952-0dea-4457-a195-0c61fdcd5daf,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:8a72f82d-1756-4fa3-be7f-474a6e4be921,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 8a594478fc1c4e89bef7eccb6dfe713f-20220624
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <guodong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1107029862; Fri, 24 Jun 2022 21:37:07 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 24 Jun 2022 21:37:06 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Jun 2022 21:37:05 +0800
From:   Guodong Liu <guodong.liu@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?q?N=EDcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
Subject: [PATCH v2 0/5] pinctrl: mediatek: add driver support driving and resistance property  on mt8192
Date:   Fri, 24 Jun 2022 21:36:55 +0800
Message-ID: <20220624133700.15487-1-guodong.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes since v1:

- Patch 1 Add commit only, add "mediatek:" on the commit title for this
patch, describe the patch modification in detail.

- Patch 2  Add commit only, add "mediatek:" on the commit title for this
patch, use space instead of tab before the =, Dropping E1, E0, and EN
arrays in this patch, which were used by the original advanced
drive configuration.

- Patch 3 Add commit describe the patch modification in detail,
add the missing pull type array for mt8192 to document the pull type of
each pin and prevent invalid pull type settings. use space instead of
tab after the ,.

- Patch 4 Remove the original advanced drive configuration.

- Patch 5 Remove pin definitions that do not support the R0 & R1
pinconfig property.

v1:

Patch 1 make driver consistent with "drive-strength" properties
  description of  pinctrl-mt8192.yaml

Patch 2 make driver consistent with "mediatek,drive-strength-adv"
  description pinctrl-mt8192.yaml, however, "mediatek,drive-strength-adv"
  description of pinctrl-mt8192.yaml needs to be synchronize a little bit.

Patch 3 Since the bias-pull-{up,down} is generic properties, make
  driver to be used for setting type {PUPD/R1/R0 , PU/PD, PU/PD/RSEL}.

Patch 4 Remove some pins definitions not support PUPD/R1/R0.

Please see the following for detailed  description 

Patch 1 provides generic driving setup, which support 2/4/6/8/10/12/14/16mA
  driving.

Patch 2 provides I2C pins specific driving setup property, can support
  0.125/0.25/0.5/1mA adjustment, and also support driving setup with
  unit microamp.

Patch 3 provides I2C pins pull up/down type which is RSEL. It can support
  RSEL define or si unit value(ohm) to set different resistance

Patch 4 Remove pin definitions that do not support the R0 & R1 pinconfig
  property

Guodong Liu (5):
  pinctrl: mediatek: add generic driving setup property on mt8192
  pinctrl: mediatek: add drive for I2C related pins on mt8192
  pinctrl: mediatek: add rsel setting on mt8192
  pinctrl: mediatek: dropping original advanced drive configuration
    function
  pinctrl: mediatek: fix the pinconf definition of some GPIO pins

 drivers/pinctrl/mediatek/pinctrl-mt8192.c | 296 ++++++++++++----------
 1 file changed, 163 insertions(+), 133 deletions(-)

-- 
2.25.5

