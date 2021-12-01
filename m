Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0525C464AB6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348280AbhLAJgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:36:49 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34082 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348268AbhLAJgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:36:48 -0500
X-UUID: 94e3c8832fd04e2fa134a12e7893a8f6-20211201
X-UUID: 94e3c8832fd04e2fa134a12e7893a8f6-20211201
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 206444515; Wed, 01 Dec 2021 17:33:23 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 1 Dec 2021 17:33:22 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 1 Dec
 2021 17:33:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 1 Dec 2021 17:33:21 +0800
From:   <miles.chen@mediatek.com>
To:     <zhou1615@umn.edu>
CC:     <kjlu@umn.edu>, <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <wendell.lin@mediatek.com>
Subject: Re: [PATCH] clk: mediatek: mt6779: Fix a NULL pointer dereference in clk_mt6779_top_probe()
Date:   Wed, 1 Dec 2021 17:33:21 +0800
Message-ID: <20211201093321.31312-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211130173634.212143-1-zhou1615@umn.edu>
References: <20211130173634.212143-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qingyang,

> Fix this bug by adding a check of clk_data.
> 
> Another way to fix this bug is to add a check of clk_data in
> mtk_clk_register_muxes(), which may solve many similar bugs but could
> cause potential problems to previously correct cases as the API is changed.
> 
> This bug was found by a static analyzer. The analysis employs
> differential checking to identify inconsistent security operations
> (e.g., checks or kfrees) between two code paths and confirms that the
> inconsistent operations are not recovered in the current function or
> the callers, so they constitute bugs.
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
> Builds with CONFIG_COMMON_CLK_MT6779=y show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: 710774e04861 ("clk: mediatek: Add MT6779 clock support")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
>

thanks,
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
