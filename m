Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5EB5427CC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242604AbiFHHMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347064AbiFHGNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:13:01 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4123CC366F;
        Tue,  7 Jun 2022 22:39:55 -0700 (PDT)
X-UUID: 4d1341d6bf1b4c72b87222a3247d5988-20220608
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:79cb48ab-0312-40dc-8802-87df0af67eee,OB:0,LO
        B:10,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:90
X-CID-INFO: VERSION:1.1.5,REQID:79cb48ab-0312-40dc-8802-87df0af67eee,OB:0,LOB:
        10,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:90
X-CID-META: VersionHash:2a19b09,CLOUDID:d8d5967e-c8dc-403a-96e8-6237210dceee,C
        OID:932e8ed994a5,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 4d1341d6bf1b4c72b87222a3247d5988-20220608
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <guodong.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1449899651; Wed, 08 Jun 2022 13:39:16 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 8 Jun 2022 13:39:14 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 8 Jun 2022 13:39:13 +0800
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
Subject: [PATCH v1 0/4] pinctrl: mediatek: add driver support driving and resistance property  on mt8192
Date:   Wed, 8 Jun 2022 13:39:05 +0800
Message-ID: <20220608053909.1252-1-guodong.liu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Guodong Liu (4):
  pinctrl: add generic driving setup property on mt8192
  pinctrl: add drive for I2C related pins on mt8192
  pinctrl: mediatek: add rsel setting on mt8192
  pinctrl: mediatek: fix the pinconf definition of some GPIO pins

 drivers/pinctrl/mediatek/pinctrl-mt8192.c | 295 ++++++++++++----------
 1 file changed, 163 insertions(+), 132 deletions(-)

-- 
2.25.5

