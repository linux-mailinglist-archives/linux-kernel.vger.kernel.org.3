Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C87B5B101E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIGXAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIGXAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:00:12 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682129D8ED;
        Wed,  7 Sep 2022 16:00:04 -0700 (PDT)
X-UUID: e508533bb1eb470bbfe9013aaeec0aa2-20220908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WVN2su0W6cfg/UUYRpHd6lSdOO4U2GGb7/TQBMhg9MY=;
        b=q3+BhORkSzOMfYpwhwdq/eeCPCIxaLa4AvXvrmYVEHTfaeRUwhFdPwHVzcs5T+6mydDcVJJX8KJEW6f0sMvWorBL5DtE8qkqGg45SnN3VlkvahsnC96WJRkoz9YtB7Dpyd6sJ0X1UMboiPRDn/w2wFr307xlyq0tTHzdlTbmYoQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:c9a13087-87c7-4326-9ad2-c46e2b4e6d0f,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release
        _Ham,ACTION:release,TS:45
X-CID-INFO: VERSION:1.1.10,REQID:c9a13087-87c7-4326-9ad2-c46e2b4e6d0f,OB:0,LOB
        :0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:45
X-CID-META: VersionHash:84eae18,CLOUDID:70f78c21-1c20-48a5-82a0-25f9c331906d,C
        OID:0c2de187faa6,Recheck:0,SF:28|17|19|48,TC:nil,Content:-5,EDM:-3,IP:nil,
        URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e508533bb1eb470bbfe9013aaeec0aa2-20220908
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 674545052; Thu, 08 Sep 2022 06:59:58 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 8 Sep 2022 06:59:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 8 Sep 2022 06:59:57 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <angelogioacchino.delregno@collabora.com>
CC:     <chun-jie.chen@mediatek.com>, <devicetree@vger.kernel.org>,
        <drinkcat@chromium.org>, <jose.exposito89@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <mturquette@baylibre.com>,
        <nfraprado@collabora.com>, <rex-bc.chen@mediatek.com>,
        <robh+dt@kernel.org>, <sboyd@kernel.org>, <weiyi.lu@mediatek.com>,
        <wenst@chromium.org>
Subject: Re: [PATCH 03/10] clk: mediatek: mux: add clk notifier functions
Date:   Thu, 8 Sep 2022 06:59:57 +0800
Message-ID: <20220907225957.10541-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220905100416.42421-4-angelogioacchino.delregno@collabora.com>
References: <20220905100416.42421-4-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Chen-Yu Tsai <wenst@chromium.org>
> 
> With device frequency scaling, the mux clock that (indirectly) feeds the
> device selects between a dedicated PLL, and some other stable clocks.
> 
> When a clk rate change is requested, the (normally) upstream PLL is
> reconfigured. It's possible for the clock output of the PLL to become
> unstable during this process.
> 
> To avoid causing the device to glitch, the mux should temporarily be
> switched over to another "stable" clock during the PLL rate change.
> This is done with clk notifiers.
> 
> This patch adds common functions for notifiers to temporarily and
> transparently reparent mux clocks.
> 
> This was loosely based on commit 8adfb08605a9 ("clk: sunxi-ng: mux: Add
> clk notifier functions").
>

Reviewed-by: Miles Chen <miles.chen@mediatek.com>

