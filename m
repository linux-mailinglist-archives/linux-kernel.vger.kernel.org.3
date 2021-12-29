Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348AC4810AB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 08:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbhL2H2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 02:28:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239116AbhL2H2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 02:28:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640762898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XRWyNzE7/nzTYc6gOl/SNhYJNJt2Wa56SBzieY+UgOg=;
        b=bHuInvh5XdoB5FxOgajVRHDdNQIurX2zmik8d6YWL9BXb0Y1+3BZEsOPJvLCfETR6POO2l
        IGbzm32d3tPxAPMo+AKO+/c5WQ/G6LktmESD/5dhxPPqdpqik+fd5cEW/2AgCHPxhLm9xD
        G76+kjHzGy90h0gpvXePX6WVgJBbqrA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-EbCi6JunMdmnedIg4a3Ohg-1; Wed, 29 Dec 2021 02:28:15 -0500
X-MC-Unique: EbCi6JunMdmnedIg4a3Ohg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76A258042E1;
        Wed, 29 Dec 2021 07:28:12 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-131.pek2.redhat.com [10.72.12.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E50185ED31;
        Wed, 29 Dec 2021 07:27:51 +0000 (UTC)
Date:   Wed, 29 Dec 2021 15:27:48 +0800
From:   Dave Young <dyoung@redhat.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>
Subject: Re: [PATCH v19 02/13] x86/setup: Use parse_crashkernel_high_low() to
 simplify code
Message-ID: <YcwN9Mfwsh/lPbbd@dhcp-128-65.nay.redhat.com>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-3-thunder.leizhen@huawei.com>
 <Ycs3kpZD/vpoo1AX@zn.tnic>
 <b017a8ea-989b-c251-f5c8-a8a7940877cf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b017a8ea-989b-c251-f5c8-a8a7940877cf@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/21 at 10:27am, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/12/29 0:13, Borislav Petkov wrote:
> > On Tue, Dec 28, 2021 at 09:26:01PM +0800, Zhen Lei wrote:
> >> Use parse_crashkernel_high_low() to bring the parsing of
> >> "crashkernel=X,high" and the parsing of "crashkernel=Y,low" together, they
> >> are strongly dependent, make code logic clear and more readable.
> >>
> >> Suggested-by: Borislav Petkov <bp@alien8.de>
> > 
> > Yeah, doesn't look like something I suggested...
> > 
> >> @@ -474,10 +472,9 @@ static void __init reserve_crashkernel(void)
> >>  	/* crashkernel=XM */
> >>  	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
> >>  	if (ret != 0 || crash_size <= 0) {
> >> -		/* crashkernel=X,high */
> >> -		ret = parse_crashkernel_high(boot_command_line, total_mem,
> >> -					     &crash_size, &crash_base);
> >> -		if (ret != 0 || crash_size <= 0)
> >> +		/* crashkernel=X,high and possible crashkernel=Y,low */
> >> +		ret = parse_crashkernel_high_low(boot_command_line, &crash_size, &low_size);
> > 
> > So this calls parse_crashkernel() and when that one fails, it calls this
> > new weird parse high/low helper you added.
> > 
> > But then all three end up in the same __parse_crashkernel() worker
> > function which seems to do the actual parsing.
> > 
> > What I suggested and what would be real clean is if the arches would
> > simply call a *single* 
> > 
> > 	parse_crashkernel()
> > 
> > function and when that one returns, *all* crashkernel= options would
> > have been parsed properly, low, high, middle crashkernel, whatever...
> > and the caller would know what crash kernel needs to be allocated.
> > 
> > Then each arch can do its memory allocations and checks based on that
> > parsed data and decide to allocate or bail.
> 
> However, only x86 currently supports "crashkernel=X,high" and "crashkernel=Y,low", and arm64
> will also support it. It is not supported on other architectures. So changing parse_crashkernel()
> is not appropriate unless a new function is introduced. But naming this new function isn't easy,
> and the name parse_crashkernel_in_order() that I've named before doesn't seem to be good.
> Of course, we can also consider changing parse_crashkernel() to another name, then use
> parse_crashkernel() to parse all possible "crashkernel=" options in order, but this will cause
> other architectures to change as well.

Hi, I did not follow up all discussions, but if the only difference is
about the low -> high fallback, I think you can add another argument in
parse_crashkernel(..., *fallback_high),  and doing some changes in
__parse_crashkernel() before it returns.  But since there are two
many arguments, you could need a wrapper struct for crashkernel_param if
needed.

If you do not want to touch other arches, another function maybe
something like parse_crashkernel_fallback() for x86 and arm64 to use.

But I may not get all the context, please ignore if this is not the
case.  I agree that calling parse_crash_kernel* in the
reserve_crashkernel funtions looks not good though. 

OTOH there are bunch of other logics in param parsing code,
eg. determin the final size and offset etc. To split the logic out more
things need to be done, eg. firstly parsing function just get all the
inputs from cmdline string eg. an array of struct crashkernel_param with
mem_range, expected size, expected offset, high, or low, and do not do
any other things.   Then pass these parsed inputs to another function to
determine the final crash_size and crash_base, that part can be arch
specific somehow. 

So I think you can unify the parse_crashkernel* in x86 first with just
one function.  And leave the further improvements to later work. But
let's see how Boris think about this.

> 
> > 
> > So it is getting there but it needs more surgery...
> > 
> > Thx.
> > 
> 
> -- 
> Regards,
>   Zhen Lei
> 

Thanks
Dave

