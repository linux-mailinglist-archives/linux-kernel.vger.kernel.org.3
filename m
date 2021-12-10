Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E49C470894
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239304AbhLJS0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:26:44 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:40184 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbhLJS0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:26:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 60A19CE2C88;
        Fri, 10 Dec 2021 18:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB134C00446;
        Fri, 10 Dec 2021 18:23:03 +0000 (UTC)
Date:   Fri, 10 Dec 2021 18:23:00 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        gregkh <gregkh@linuxfoundation.org>, quic_psodagud@quicinc.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCHv6 1/5] arm64: io: Use asm-generic high level MMIO
 accessors
Message-ID: <YbObBCB2+9hei7ZM@arm.com>
References: <cover.1638858746.git.quic_saipraka@quicinc.com>
 <a5287f999f7e42e66de0729f367959fdb28462e0.1638858746.git.quic_saipraka@quicinc.com>
 <YbOZi+akT0+1EIoi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbOZi+akT0+1EIoi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 06:16:43PM +0000, Catalin Marinas wrote:
> On Tue, Dec 07, 2021 at 12:24:45PM +0530, Sai Prakash Ranjan wrote:
> > Remove custom arm64 MMIO accessors read{b,w,l,q} and their relaxed
> > versions in support to use asm-generic defined accessors. Also define
> > one set of IO barriers (ar/bw version) used by asm-generic code to
> > override the arm64 specific variants.
> > 
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> > ---
> >  arch/arm64/include/asm/io.h | 41 ++++++++-----------------------------
> >  1 file changed, 8 insertions(+), 33 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> > index 7fd836bea7eb..1b436810d779 100644
> > --- a/arch/arm64/include/asm/io.h
> > +++ b/arch/arm64/include/asm/io.h
> > @@ -91,7 +91,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
> >  }
> >  
> >  /* IO barriers */
> > -#define __iormb(v)							\
> > +#define __io_ar(v)							\
> >  ({									\
> >  	unsigned long tmp;						\
> >  									\
> > @@ -108,39 +108,14 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
> >  		     : "memory");					\
> >  })
> >  
> > -#define __io_par(v)		__iormb(v)
> > -#define __iowmb()		dma_wmb()
> > -#define __iomb()		dma_mb()
> > -
> > -/*
> > - * Relaxed I/O memory access primitives. These follow the Device memory
> > - * ordering rules but do not guarantee any ordering relative to Normal memory
> > - * accesses.
> > - */
> > -#define readb_relaxed(c)	({ u8  __r = __raw_readb(c); __r; })
> > -#define readw_relaxed(c)	({ u16 __r = le16_to_cpu((__force __le16)__raw_readw(c)); __r; })
> > -#define readl_relaxed(c)	({ u32 __r = le32_to_cpu((__force __le32)__raw_readl(c)); __r; })
> > -#define readq_relaxed(c)	({ u64 __r = le64_to_cpu((__force __le64)__raw_readq(c)); __r; })
> > +#define __io_bw()		dma_wmb()
> > +#define __io_br(v)
> > +#define __io_aw(v)
> >  
> > -#define writeb_relaxed(v,c)	((void)__raw_writeb((v),(c)))
> > -#define writew_relaxed(v,c)	((void)__raw_writew((__force u16)cpu_to_le16(v),(c)))
> > -#define writel_relaxed(v,c)	((void)__raw_writel((__force u32)cpu_to_le32(v),(c)))
> > -#define writeq_relaxed(v,c)	((void)__raw_writeq((__force u64)cpu_to_le64(v),(c)))
> > -
> > -/*
> > - * I/O memory access primitives. Reads are ordered relative to any
> > - * following Normal memory access. Writes are ordered relative to any prior
> > - * Normal memory access.
> > - */
> > -#define readb(c)		({ u8  __v = readb_relaxed(c); __iormb(__v); __v; })
> > -#define readw(c)		({ u16 __v = readw_relaxed(c); __iormb(__v); __v; })
> > -#define readl(c)		({ u32 __v = readl_relaxed(c); __iormb(__v); __v; })
> > -#define readq(c)		({ u64 __v = readq_relaxed(c); __iormb(__v); __v; })
> > -
> > -#define writeb(v,c)		({ __iowmb(); writeb_relaxed((v),(c)); })
> > -#define writew(v,c)		({ __iowmb(); writew_relaxed((v),(c)); })
> > -#define writel(v,c)		({ __iowmb(); writel_relaxed((v),(c)); })
> > -#define writeq(v,c)		({ __iowmb(); writeq_relaxed((v),(c)); })
> > +/* arm64-specific, don't use in portable drivers */
> > +#define __iormb(v)		__io_ar(v)
> > +#define __iowmb()		__io_bw()
> > +#define __iomb()		dma_mb()
> 
> More of a nitpick but I'd keep the __iormb()/__iowmb() as they currently
> are and just define the generic __io_ar() etc. in terms of the former.

Ah, I now noticed this was discussed in v5. Well, you can leave it as
here and hopefully we get to remove the __io*mb() from various drivers.

-- 
Catalin
