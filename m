Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644BD5B1025
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 01:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiIGXEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 19:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiIGXEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 19:04:51 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C062647BB0;
        Wed,  7 Sep 2022 16:04:49 -0700 (PDT)
X-UUID: e35e2d48047f4bb4a56b98aa1c728807-20220908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=w3RdqVd1gkkXkZVjFlpJYrbMBbFDmrTcM7nhqoe7Ckc=;
        b=Fq5PPwrlPdf04Mc7k6Z0nz4g43WDqVRMof6okhajJyWIY9Qj5XhVoJhWKcZjha3I60pY9H7unFKU5G7u/aP/AvSaxLAO0TaoTh3RxnAMxVFucNX/kE+7v7+sOMenjLZKMx0ymfgOdkX6UsDg0HuftB1eQSfLYsH80FiwZ/mRqEg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:0a230f38-1199-415c-ace6-9f5ca2e10dc7,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:fb0f8d21-1c20-48a5-82a0-25f9c331906d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:-5,EDM:-3,IP:nil,URL:0,File:ni
        l,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e35e2d48047f4bb4a56b98aa1c728807-20220908
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1440695343; Thu, 08 Sep 2022 07:04:44 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 8 Sep 2022 07:04:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 8 Sep 2022 07:04:42 +0800
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
Subject: Re: [PATCH 04/10] clk: mediatek: mt8183: Add clk mux notifier for MFG mux
Date:   Thu, 8 Sep 2022 07:04:42 +0800
Message-ID: <20220907230442.10633-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220905100416.42421-5-angelogioacchino.delregno@collabora.com>
References: <20220905100416.42421-5-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> When the MFG PLL clock, which is upstream of the MFG clock, is changed,
> the downstream clock and consumers need to be switched away from the PLL
> over to a stable clock to avoid glitches.
> 
> This is done through the use of the newly added clk mux notifier. The
> notifier is set on the mux itself instead of the upstream PLL, but in
> practice this works, as the rate change notifitcations are propogated
> throughout the sub-tree hanging off the PLL. Just before rate changes,
> the MFG mux is temporarily and transparently switched to the 26 MHz
> main crystal. After the rate change, the mux is switched back.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> [Angelo: Rebased to assign clk_ops in mtk_mux_nb]
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Miles Chen <miles.chen@mediatek.com> 
