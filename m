Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE3D522FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbiEKJoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234489AbiEKJmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:42:15 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 000592657C;
        Wed, 11 May 2022 02:41:06 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,216,1647270000"; 
   d="scan'208";a="119357492"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 11 May 2022 18:41:06 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 650F54236226;
        Wed, 11 May 2022 18:41:03 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] pinctrl: renesas: pinctrl-rzg2l: Return -EINVAL for pins which have input disabled
Date:   Wed, 11 May 2022 10:40:57 +0100
Message-Id: <20220511094057.3151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pin status reported by pinconf-pins file always reported pin status as
"input enabled" even for pins which had input disabled. Fix this by
returning -EINVAL for the pins which have input disabled.

Fixes: c4c4637eb57f2 ("pinctrl: renesas: Add RZ/G2L pin and gpio controller driver")
Reported-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index af2c739cdbaa..a63535ea47f5 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -527,6 +527,8 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_dev *pctldev,
 		if (!(cfg & PIN_CFG_IEN))
 			return -EINVAL;
 		arg = rzg2l_read_pin_config(pctrl, IEN(port_offset), bit, IEN_MASK);
+		if (!arg)
+			return -EINVAL;
 		break;
 
 	case PIN_CONFIG_POWER_SOURCE: {
-- 
2.25.1

