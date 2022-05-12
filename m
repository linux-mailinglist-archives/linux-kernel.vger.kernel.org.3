Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41095524F66
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355007AbiELOFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355012AbiELOFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:05:19 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FAB25BA42;
        Thu, 12 May 2022 07:05:18 -0700 (PDT)
X-UUID: 1052439a0201400e874d6a3e1cc9c8d2-20220512
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:13e3ac3b-558a-4e05-939a-0b8f1f09d03e,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:db1dfef1-ab23-4aed-a67b-f96514452486,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:-5,EDM:-3,File:nil,QS:0,BEC:ni
        l
X-UUID: 1052439a0201400e874d6a3e1cc9c8d2-20220512
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1315451063; Thu, 12 May 2022 22:05:13 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 12 May 2022 22:05:12 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 May 2022 22:05:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 May 2022 22:05:12 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <wenst@chromium.org>
CC:     <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <mturquette@baylibre.com>,
        <rex-bc.chen@mediatek.com>, <sboyd@kernel.org>
Subject: Re: [PATCH v2 03/11] clk: mediatek: Convert mtk_{alloc,free}_clk_data to struct clk_hw
Date:   Thu, 12 May 2022 22:05:12 +0800
Message-ID: <20220512140512.10718-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220510104804.544597-4-wenst@chromium.org>
References: <20220510104804.544597-4-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-struct clk_onecell_data *mtk_alloc_clk_data(unsigned int clk_num)
>+struct clk_hw_onecell_data *mtk_alloc_clk_data(unsigned int clk_num)
> {
> 	int i;
> 	struct clk_onecell_data *clk_data;

This struct clk_onecell_data also be struct clk_hw_onecell_data?
> 
>-	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
>+	clk_data = kzalloc(struct_size(clk_data, hws, clk_num), GFP_KERNEL);
> 	if (!clk_data)
> 		return NULL;
> 
>-	clk_data->clks = kcalloc(clk_num, sizeof(*clk_data->clks), GFP_KERNEL);
>-	if (!clk_data->clks)
>-		goto err_out;
>-
>-	clk_data->clk_num = clk_num;
>+	clk_data->num = clk_num;
> 
> 	for (i = 0; i < clk_num; i++)
>-		clk_data->clks[i] = ERR_PTR(-ENOENT);
>+		clk_data->hws[i] = ERR_PTR(-ENOENT);
> 
> 	return clk_data;
>-err_out:
>-	kfree(clk_data);
>-
>-	return NULL;
> }
> EXPORT_SYMBOL_GPL(mtk_alloc_clk_data);
> 
>-void mtk_free_clk_data(struct clk_onecell_data *clk_data)
>+void mtk_free_clk_data(struct clk_hw_onecell_data *clk_data)
> {
>-	if (!clk_data)
>-		return;
>-
>-	kfree(clk_data->clks);
> 	kfree(clk_data);
> }
>+EXPORT_SYMBOL_GPL(mtk_free_clk_data);
 
