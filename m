Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C54482D41
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 00:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiABXql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 18:46:41 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:35554 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229555AbiABXqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 18:46:40 -0500
X-UUID: e16f94d125c744a79ed82d7091faa024-20220103
X-UUID: e16f94d125c744a79ed82d7091faa024-20220103
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1794068794; Mon, 03 Jan 2022 07:46:36 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 3 Jan 2022 07:46:34 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 3 Jan
 2022 07:46:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Jan 2022 07:46:34 +0800
From:   <miles.chen@mediatek.com>
To:     <matthias.bgg@gmail.com>, Nathan Chancellor <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        Jie Qiu <jie.qiu@mediatek.com>,
        "Junzhi Zhao" <junzhi.zhao@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <airlied@linux.ie>, <chunkuang.hu@kernel.org>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <miles.chen@mediatek.com>,
        <llvm@lists.linux.dev>
Subject: Re: [PATCH v3] drm/mediatek: Fix unused-but-set variable warning
Date:   Mon, 3 Jan 2022 07:46:32 +0800
Message-ID: <20220102234633.31709-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <fcaccc97-e920-08eb-ec3f-4c4b11ea8925@gmail.com>
References: <fcaccc97-e920-08eb-ec3f-4c4b11ea8925@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm still not happy with the commit subject, I think it is misleading. Clang 
> only helped to find the bug, but the we are fixing something else, that's not 
> just a clang warning. But I don't want to nit-pick too much so:
> 
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

thanks. I think you are right.
I will change the subject to "drm/mediatek: Fix mtk_cec_mask()", remove the 
clang part and submit patch v4.

e.g,
"""
drm/mediatek: Fix mtk_cec_mask()

In current implementation, mtk_cec_mask() writes val into target register
and ignores the mask. After talking to our hdmi experts, mtk_cec_mask()
should read a register, clean only mask bits, and update (val | mask) bits
to the register.

Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")
"""
