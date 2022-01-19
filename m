Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CA949372F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353057AbiASJYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:24:47 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:40658 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1352766AbiASJYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:24:44 -0500
X-UUID: 1ac59f4b3b1f4caa826e0ff51a75370e-20220119
X-UUID: 1ac59f4b3b1f4caa826e0ff51a75370e-20220119
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1307031794; Wed, 19 Jan 2022 17:24:41 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 19 Jan 2022 17:24:40 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 19 Jan
 2022 17:24:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 19 Jan 2022 17:24:40 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <jason@zx2c4.com>
CC:     <ardb@kernel.org>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <herbert@gondor.apana.org.au>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>
Subject: Re: [PATCH] lib/crypto: blake2s: fix a CFI failure
Date:   Wed, 19 Jan 2022 17:24:40 +0800
Message-ID: <20220119092440.4045-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAHmME9pv4WWATjdqZgwrtHDmq3sX4ABfB9PoNT9Z4tSEduR2Lw@mail.gmail.com>
References: <CAHmME9pv4WWATjdqZgwrtHDmq3sX4ABfB9PoNT9Z4tSEduR2Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

>Thanks for the patch. Could you let me know which architecture and
>compiler this was broken on? If I had to guess, I'd wager arm32, and
>you hit this by enabling optimized blake2s?

Actually, I am merging android-common tree and test our device.
I use arm64 and clang-r437112b.

I'm not sure which option is the right one, grep 'BLAKE' .config shows:

CONFIG_CRYPTO_BLAKE2B=y
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y

and... I found that my patch breaks arm32 build, sorry for that.

>If so, I'm not sure the problem is with weak symbols. Why should CFI
>break weak symbols? Rather, perhaps the issue is that the function is
>defined in blake2s-core.S? Are there some CFI macros we need for that
>definition?

