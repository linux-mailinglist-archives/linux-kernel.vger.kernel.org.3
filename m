Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFBF4D10BF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344509AbiCHHNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344535AbiCHHM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:12:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0F53DA53;
        Mon,  7 Mar 2022 23:12:01 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id m2so10280976pll.0;
        Mon, 07 Mar 2022 23:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=dOUBo/Sc0yjq3ebr0wQH/B7bwQxh2odqELk9JgfPdwU=;
        b=LB/94ADMeswaD5pO59KrBobz0IlCQSDS646x7RnJ62nnUQK86bDW7ludK6KDoJ6XrX
         cMeCAN3HM4t0qrQJVGiQXUxRdcmybJTBeCXidCPvcfunKGOgmF5F8cuqaPH/EOx2kkBq
         /zBGqOsaflp4f8jRT8yUHWRxJ880rzU0O+avb0doPFW01+/yJ7ZsZRDRyKQZsD3OESrO
         NB9KpW6PpI41YRA9/fpWwRJhlNrX1FQJItUL/0X17435XAgZ7haBv4g0lKt71Js0TGBn
         n2m5UkoAEkcPuu9CAfjtjwtQvWUk82oy9lqGuG2QzcjiDxDoCgXUHTWIBsXVSPSHMcDW
         vAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dOUBo/Sc0yjq3ebr0wQH/B7bwQxh2odqELk9JgfPdwU=;
        b=f20WmJYo1CE7R9TMwWoXe9FJWKkv/26xG6EZrkv2a79ZLdEr64cUJlQR700eSl8NBY
         GQF/NSkTSa99IB57VFnMaiFHOJeboMbkifjNULbSiKXVwCH+0qLAdun6SrflDB9E6vcU
         OnENIHFy3FkUY1VZYcBuK9hkO0SB+mk7d/LyiGNcXnxxu+lt25o70kMVoiyiaQB3OQES
         do9I8VlUwJYpauvQgr0A9rkKD3nYEwLm1VzXij+cmAk6yqRbx8sETvx6xc4RwraIZ/+s
         01PBKqHWb/knM5aS4iVGTAjWBhDNUS5qsFJaMoL0lkYh6Ip01C432bnJ5Jem10g0O8nv
         WR0g==
X-Gm-Message-State: AOAM530FD4P69pDzt3WfZK5u2V0WI7o1pP96nWcavgilJm/yccdqfVBN
        JMFLfk0uRW5OUtxC6xierl0=
X-Google-Smtp-Source: ABdhPJxouGfigEMrShjCATvfXIOp5b0R3izV6OiagBsPFTLCsXQKjyip+qEPFuUh0IY/PvKVe9WlCA==
X-Received: by 2002:a17:90b:4f8f:b0:1bf:84ad:1fe6 with SMTP id qe15-20020a17090b4f8f00b001bf84ad1fe6mr3145309pjb.189.1646723520761;
        Mon, 07 Mar 2022 23:12:00 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id j7-20020a637a47000000b003803fbcc005sm5516633pgn.59.2022.03.07.23.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 23:12:00 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hongzhou Yang <hongzhou.yang@mediatek.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] pinctrl: mediatek: Fix missing of_node_put() in mtk_pctrl_init
Date:   Tue,  8 Mar 2022 07:11:54 +0000
Message-Id: <20220308071155.21114-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_node pointer is returned by of_parse_phandle()  with refcount
incremented. We should use of_node_put() on it when done.

Fixes: a6df410d420a ("pinctrl: mediatek: Add Pinctrl/GPIO driver for mt8135.")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 5f7c421ab6e7..334cb85855a9 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -1038,6 +1038,7 @@ int mtk_pctrl_init(struct platform_device *pdev,
 	node = of_parse_phandle(np, "mediatek,pctl-regmap", 0);
 	if (node) {
 		pctl->regmap1 = syscon_node_to_regmap(node);
+		of_node_put(node);
 		if (IS_ERR(pctl->regmap1))
 			return PTR_ERR(pctl->regmap1);
 	} else if (regmap) {
@@ -1051,6 +1052,7 @@ int mtk_pctrl_init(struct platform_device *pdev,
 	node = of_parse_phandle(np, "mediatek,pctl-regmap", 1);
 	if (node) {
 		pctl->regmap2 = syscon_node_to_regmap(node);
+		of_node_put(node);
 		if (IS_ERR(pctl->regmap2))
 			return PTR_ERR(pctl->regmap2);
 	}
-- 
2.17.1

