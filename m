Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCCB5400B8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245112AbiFGOGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245080AbiFGOGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:06:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBD77A456;
        Tue,  7 Jun 2022 07:06:31 -0700 (PDT)
X-UUID: a9a47d3a242d4318be3c2b9eb43b7a7e-20220607
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:b1113a88-ed15-414b-947b-840f974a7474,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:417ef5e4-2ba2-4dc1-b6c5-11feb6c769e0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: a9a47d3a242d4318be3c2b9eb43b7a7e-20220607
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 770820792; Tue, 07 Jun 2022 22:06:10 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 7 Jun 2022 22:06:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Jun 2022 22:06:06 +0800
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <cw00.choi@samsung.com>, <krzk+dt@kernel.org>,
        <robh+dt@kernel.org>, <kyungmin.park@samsung.com>
CC:     <khilman@kernel.org>, <djakov@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <jia-wei.chang@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>
Subject: [PATCH v7 0/2] Introduce MediaTek CCI devfreq driver
Date:   Tue, 7 Jun 2022 22:05:54 +0800
Message-ID: <20220607140556.6278-1-johnson.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cache Coherent Interconnect (CCI) is the management of cache
coherency by hardware. CCI DEVFREQ is DVFS driver for power saving by
scaling clock frequency and supply voltage of CCI. CCI uses the same
input clock source and power rail as LITTLE CPUs on Mediatek SoCs.

This series depends on:
Chanwoo's repo: kernel/git/chanwoo/linux.git
branch: devfreq-testing
[1]: PM / devfreq: Export devfreq_get_freq_range symbol within devfreq
[2]: PM / devfreq: Add cpu based scaling support to passive governor
[3]: PM / devfreq: passive: Reduce duplicate code when passive_devfreq case
[4]: PM / devfreq: passive: Update frequency when start governor

Changes in v7:
- remove the 'ret' printing from dev_err_probe().

Changes in v6:
- Remove unnecessary "goto" statement.

Changes in v5:
- Modify some binding description.
- Remove pre_voltage member.
- Not to enable/disable intermediate clock.
- Not to "put" resources that using devm_ variants.

Resend v4:
- CC interconnect maintainer.
- Change sign-off sequence in commit message.

Changes in v4:
- Add a maintainer in the binding document.
- Modify clock description.
- Add binding document into MAINTAINERS.
- Replace format specifier %d with %ld.

Changes in v3:
- Move binding document to 'interconnect' and rename it.
- Add COMPILE_TEST dependence symbol.
- Remove need_voltage_tracking variable.
- Move mtk_ccifreq_voltage_tracking() code into mtk_ccifreq_set_voltage().
- Add an interation limit in the while() loop.
- Replace 'cci_dev' with 'dev'
- Replace old_* with pre_*
- Remove of_match_ptr()
- Use module_platform_driver()

Changes in v2:
- Take MT8183 as example in binding document.
- Use dev_err() instead of pr_err().
- Use 'goto' statement to handle error case.
- Clean up driver code.

Johnson Wang (2):
  dt-bindings: interconnect: Add MediaTek CCI dt-bindings
  PM / devfreq: mediatek: Introduce MediaTek CCI devfreq driver

 .../bindings/interconnect/mediatek,cci.yaml   | 140 ++++++
 MAINTAINERS                                   |   1 +
 drivers/devfreq/Kconfig                       |  10 +
 drivers/devfreq/Makefile                      |   1 +
 drivers/devfreq/mtk-cci-devfreq.c             | 474 ++++++++++++++++++
 5 files changed, 626 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/mediatek,cci.yaml
 create mode 100644 drivers/devfreq/mtk-cci-devfreq.c

-- 
2.18.0

