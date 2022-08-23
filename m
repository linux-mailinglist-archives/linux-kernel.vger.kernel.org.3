Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F94F59D244
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241011AbiHWHbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241010AbiHWHbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:31:34 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620C162AA8;
        Tue, 23 Aug 2022 00:31:25 -0700 (PDT)
X-UUID: c791e7c7010e4ab199112539f59a0b9c-20220823
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0XpZgLgvQIhzD9OrA/D2oRDjY+6u93V0EFGksJPqrXM=;
        b=KI2iq0XbXSNL0G5QRHRPveIHTalEMzyTV4rbUwnhR684meDxcvWsYhkUMbugWhf/JxiVmIT1A2c9LPJlRVy0QDN5wHISl9MhABe8lriKvguYgzw+SfCOZpO6W7YF4jVnIkCbRuERDWvVETvOA5OuruMmolGoGQk/kaR7RXRTlH4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:1575b6a8-cd33-41c5-8670-9716c2af8626,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:100
X-CID-INFO: VERSION:1.1.10,REQID:1575b6a8-cd33-41c5-8670-9716c2af8626,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS9
        81B3D,ACTION:quarantine,TS:100
X-CID-META: VersionHash:84eae18,CLOUDID:5b780668-a9d9-4672-a3c8-12721739a220,C
        OID:e516b1b4fe73,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c791e7c7010e4ab199112539f59a0b9c-20220823
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1186259843; Tue, 23 Aug 2022 15:31:21 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 23 Aug 2022 15:31:19 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 mtkcas10.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 23 Aug 2022 15:31:17 +0800
From:   <xinlei.lee@mediatek.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <matthias.bgg@gmail.com>
CC:     <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>
Subject: [PATCH 0/2] Fix mtk_disp_pwm_get_state function disp_pwm enabled flag
Date:   Tue, 23 Aug 2022 15:31:13 +0800
Message-ID: <1661239875-19841-1-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xinlei Lee <xinlei.lee@mediatek.com>

Base on the branch of Linux-next/master.

The series mainly completes:
1. Add compatible for MediaTek MT8188 in the dt-bindings file.
2. Fix the parameters calculated by the enabled flag of disp_pwm in the
mtk_disp_pwm_get_state function;

xinlei lee (2):
  dt-bindings: pwm: Add compatible for Mediatek MT8188
  drivers: pwm: Add disp_pwm compatiable for MT8188

 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 +
 drivers/pwm/pwm-mtk-disp.c                                   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.18.0

