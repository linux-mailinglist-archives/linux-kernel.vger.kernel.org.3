Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80A549BAC6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386714AbiAYR5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:57:24 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:44874 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1357574AbiAYRzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:55:04 -0500
X-UUID: 780410943c914273a37e948af8ad6595-20220126
X-UUID: 780410943c914273a37e948af8ad6595-20220126
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 823797339; Wed, 26 Jan 2022 01:54:59 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 26 Jan 2022 01:54:58 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 Jan
 2022 01:54:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Jan 2022 01:54:58 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Kiran Kumar S" <kiran.kumar1.s@intel.com>
CC:     Miles Chen <miles.chen@mediatek.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] pinctrl: fix a discarded-qualifiers build error
Date:   Wed, 26 Jan 2022 01:54:55 +0800
Message-ID: <20220125175457.23728-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix COMPILER=gcc ARCH=arm64 DEFCONFIG=allyesconfig build:

log:
drivers/pinctrl/pinctrl-thunderbay.c:815:29: error: assignment discards
'const' qualifier from pointer target type [-Werror=discarded-qualifiers]

Fixes: 12422af8194d ("pinctrl: Add Intel Thunder Bay pinctrl driver")
Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/pinctrl/pinctrl-thunderbay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-thunderbay.c b/drivers/pinctrl/pinctrl-thunderbay.c
index b5b47f4dd774..4e6d718c03fc 100644
--- a/drivers/pinctrl/pinctrl-thunderbay.c
+++ b/drivers/pinctrl/pinctrl-thunderbay.c
@@ -812,7 +812,7 @@ static int thunderbay_add_functions(struct thunderbay_pinctrl *tpc, struct funct
 				}
 			}
 
-			grp = func->group_names;
+			grp = (const char **)func->group_names;
 			while (*grp)
 				grp++;
 
-- 
2.18.0

