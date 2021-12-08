Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A655546CAE1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 03:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbhLHC36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 21:29:58 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:60194 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233825AbhLHC36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 21:29:58 -0500
X-UUID: 08f4c16915664d40bd4f61679bd4939d-20211208
X-UUID: 08f4c16915664d40bd4f61679bd4939d-20211208
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1615868517; Wed, 08 Dec 2021 10:26:24 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Dec 2021 10:26:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 8 Dec 2021 10:26:23 +0800
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
Date:   Wed, 8 Dec 2021 10:26:23 +0800
Message-ID: <20211208022623.15103-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <Ya+EUDVYdBvRa7xI@kernel.org>
References: <Ya+EUDVYdBvRa7xI@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Dec 03, 2021 at 10:14:16PM +0800, Mark-PK Tsai wrote:
> > Remove the [_text, _stext) from Kernel Code.
> > Although there are some startup code in head.text, they
> > are freed to the buddy system after kernel boot.
>
> Hmm, I don't see it is being freed anywhere. Can you elaborate when and how
> the range [_text, _stext) is freed?

arm_memblock_init() reserve [KERNEL_START, KERNEL_END) which are defined as following.

#define KERNEL_START            _stext
#define KERNEL_END              _end

free_low_memory_core_early() free all the non-reserved range in lowmem,
so the range [_text, _stext) is also freed here.

>
> > And we have memory protection mechanism use this
> > which have false alarm when some other IPs doing dma
> > if the dma page frame is in the [_text, _stext).
> >
> > Below are my iomem resource and reserved memory information:
> > console:/ # grep Kernel /proc/iomem
> >   20208000-219fffff : Kernel code
> >   21b00000-21c2e76f : Kernel data
> >
> > console:/ # cat /sys/kernel/debug/memblock/reserved
> > 0: 0x20201000..0x20207fff
> > 1: 0x20300000..0x21c2e76f
>
> What are the addresses of _text and _stext in your configuration?

va	 pa
c0008000 20208000 _text
c0100000 20300000 _stext

>
> What these dumps are supposed to show here?
>

Below is the dump info after applied this patch.

console:/ # grep Kernel /proc/iomem
  20300000-219fffff : Kernel code
  21b00000-21c2e76f : Kernel data

console:/ # cat /sys/kernel/debug/memblock/reserved
0: 0x20201000..0x20207fff
1: 0x20300000..0x21c2e76f

The difference is that Kernel Code resource match the reserved memblock 1
which is reserved in arm_memblock_init().

>
> > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > ---
> >  arch/arm/kernel/setup.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> > index 284a80c0b6e1..85ffc9501e38 100644
> > --- a/arch/arm/kernel/setup.c
> > +++ b/arch/arm/kernel/setup.c
> > @@ -851,7 +851,7 @@ static void __init request_standard_resources(const struct machine_desc *mdesc)
> >  	struct resource *res;
> >  	u64 i;
> >
> > -	kernel_code.start   = virt_to_phys(_text);
> > +	kernel_code.start   = virt_to_phys(_stext);
> >  	kernel_code.end     = virt_to_phys(__init_begin - 1);
> >  	kernel_data.start   = virt_to_phys(_sdata);
> >  	kernel_data.end     = virt_to_phys(_end - 1);
> > --
> > 2.18.0
> >
>
> --
> Sincerely yours,
> Mike.
