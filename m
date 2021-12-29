Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D588480F26
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 04:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238470AbhL2DEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 22:04:11 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:60548 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238461AbhL2DEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 22:04:11 -0500
X-UUID: 56cfc70957c541ad88d21b43a29142f0-20211229
X-UUID: 56cfc70957c541ad88d21b43a29142f0-20211229
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 415292584; Wed, 29 Dec 2021 11:04:07 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 29 Dec 2021 11:04:06 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 29 Dec
 2021 11:04:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Dec 2021 11:04:06 +0800
From:   <miles.chen@mediatek.com>
To:     <matthias.bgg@gmail.com>
CC:     <airlied@linux.ie>, <chunkuang.hu@kernel.org>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <miles.chen@mediatek.com>,
        <p.zabel@pengutronix.de>
Subject: Re: [PATCH] drm/mediatek: Fix unused-but-set variable warning
Date:   Wed, 29 Dec 2021 11:04:03 +0800
Message-ID: <20211229030405.4338-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <fcaccc97-e920-08eb-ec3f-4c4b11ea8925@gmail.com>
References: <fcaccc97-e920-08eb-ec3f-4c4b11ea8925@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 28/12/2021 10:25, Miles Chen wrote:
> Fix unused-but-set variable warning:
>> drivers/gpu/drm/mediatek/mtk_cec.c:85:6: warning: variable 'tmp' set but not used [-Wunused-but-set-variable]
>> 
>
>Actually we ignore the value passed to mtk_cec_mask. In case of
>mtk_cec_mask(cec, CEC_CKGEN, 0 | CEC_32K_PDN, PDN | CEC_32K_PDN);
>
>
>We are not setting CEC_32K_PDN. I wonder which side effect will it have to set 
>that bit.

I am confused about "not setting CEC_32K_PDN" part,
in case mtk_cec_mask(cec, CEC_CKGEN, 0 | CEC_32K_PDN, PDN | CEC_32K_PDN);
CEC_32K_PDN (BIT(19)) is set.

for exmaple:
CEC_32K_PDN is BIT(19)
PDN is BIT(16)
say tmp = 0xffffffff;

mask = PDN | CEC_32K_PDN;
val = 0 | CEC_32K_PDN;

tmp = fff6ffff, mask = 90000
val = 80000, tmp = fffeffff

u32 tmp = readl(cec->regs + offset) & ~mask; // tmp = fff6ffff
tmp |= val & mask; // tmp = fffeffff
writel(val, cec->regs + offset); // val = 80000, tmp = fffeffff

in both val and tmp case, CEC_32K_PDN is set.

>Anyway, if it's the right thing to do, we should add:
>
>Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")

I will add the Fixes tag, thanks.
