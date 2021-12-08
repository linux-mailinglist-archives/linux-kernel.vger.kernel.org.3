Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0FF46D0ED
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhLHK0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:26:11 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:43474 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231403AbhLHK0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:26:11 -0500
X-UUID: cb86363ecfc240349ecf8ec1f965af5f-20211208
X-UUID: cb86363ecfc240349ecf8ec1f965af5f-20211208
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1299886303; Wed, 08 Dec 2021 18:22:37 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 8 Dec 2021 18:22:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 8 Dec 2021 18:22:36 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <rppt@kernel.org>
CC:     <akpm@linux-foundation.org>, <arnd@arndb.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux@armlinux.org.uk>,
        <linux@roeck-us.net>, <mark-pk.tsai@mediatek.com>,
        <matthias.bgg@gmail.com>, <rmk+kernel@armlinux.org.uk>,
        <wangkefeng.wang@huawei.com>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH] arm: remove [_text, _stext) from kernel code resource
Date:   Wed, 8 Dec 2021 18:22:37 +0800
Message-ID: <20211208102237.19706-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <YbB+O80Th2QI8sTl@kernel.org>
References: <YbB+O80Th2QI8sTl@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Dec 08, 2021 at 10:26:23AM +0800, Mark-PK Tsai wrote:
> > > On Fri, Dec 03, 2021 at 10:14:16PM +0800, Mark-PK Tsai wrote:
> > > > Remove the [_text, _stext) from Kernel Code.
> > > > Although there are some startup code in head.text, they
> > > > are freed to the buddy system after kernel boot.
> > >
> > > Hmm, I don't see it is being freed anywhere. Can you elaborate when and how
> > > the range [_text, _stext) is freed?
> > 
> > arm_memblock_init() reserve [KERNEL_START, KERNEL_END) which are defined as following.
> > 
> > #define KERNEL_START            _stext
> > #define KERNEL_END              _end
> > 
> > free_low_memory_core_early() free all the non-reserved range in lowmem,
> > so the range [_text, _stext) is also freed here.
> 
> Right, I've misread KERNEL_START as if it was _text...
>  
> > >
> > > > And we have memory protection mechanism use this
> > > > which have false alarm when some other IPs doing dma
> > > > if the dma page frame is in the [_text, _stext).
> > > >
> > > > Below are my iomem resource and reserved memory information:
> > > > console:/ # grep Kernel /proc/iomem
> > > >   20208000-219fffff : Kernel code
> > > >   21b00000-21c2e76f : Kernel data
> > > >
> > > > console:/ # cat /sys/kernel/debug/memblock/reserved
> > > > 0: 0x20201000..0x20207fff
> > > > 1: 0x20300000..0x21c2e76f
> > >
> > > What are the addresses of _text and _stext in your configuration?
> > 
> > va	 pa
> > c0008000 20208000 _text
> > c0100000 20300000 _stext
> > 
> > >
> > > What these dumps are supposed to show here?
> > >
> > 
> > Below is the dump info after applied this patch.
> > 
> > console:/ # grep Kernel /proc/iomem
> >   20300000-219fffff : Kernel code
> >   21b00000-21c2e76f : Kernel data
> > 
> > console:/ # cat /sys/kernel/debug/memblock/reserved
> > 0: 0x20201000..0x20207fff
> > 1: 0x20300000..0x21c2e76f
> > 
> > The difference is that Kernel Code resource match the reserved memblock 1
> > which is reserved in arm_memblock_init().
> 
> For that I'd extend the reservation in arm_memblock_init() to include
> [_text, _stext). 
> 
> Even if the code there is not needed after init, at least we'll keep this
> consistent with other architectures.
>  

Extending the reservation in arm_memblock_init() will consume up to SECTION_SIZE
memory for SECTION_SIZE alignment when CONFIG_STRICT_KERNEL_RWX=y.
So we really don't want to extend the reservation because it affect
the low RAM devices.

And arm64_memblock_init() also reserve [_stext, _end) in the recent kernel.
