Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11174811B9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 11:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239770AbhL2KjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 05:39:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24288 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235553AbhL2KjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 05:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640774347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gQ3Cw+k3UMeBdiHPh9g0eM12SBQJLgdBY7UIBnA37XI=;
        b=MLZrw7vMFKPqBXrQQsDPZ+BZ0HR+aG/ED0jd7hw2bqcoYDlc9JuKPHvrY+ls839dt6JGez
        hN4+DsNHc8qu4wwc4F0mTWCKRjSwRh5kucVa03aDwrqBOgPfmYrZ4Im3qUUm3j8RFkBsCM
        jd0b2VHfkC97JSgm29l+IZgKgDOKRt8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-UEvHSK6OPI6jXkgkAr38Fw-1; Wed, 29 Dec 2021 05:39:03 -0500
X-MC-Unique: UEvHSK6OPI6jXkgkAr38Fw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FF581853028;
        Wed, 29 Dec 2021 10:39:01 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-131.pek2.redhat.com [10.72.12.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9634C6F11D;
        Wed, 29 Dec 2021 10:38:46 +0000 (UTC)
Date:   Wed, 29 Dec 2021 18:38:43 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
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
Message-ID: <Ycw6s6DwZuHjckXL@dhcp-128-65.nay.redhat.com>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-3-thunder.leizhen@huawei.com>
 <Ycs3kpZD/vpoo1AX@zn.tnic>
 <b017a8ea-989b-c251-f5c8-a8a7940877cf@huawei.com>
 <YcwN9Mfwsh/lPbbd@dhcp-128-65.nay.redhat.com>
 <YcwSCAuEgO10DFDT@dhcp-128-65.nay.redhat.com>
 <Ycw0V1CmBPCPqexn@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ycw0V1CmBPCPqexn@zn.tnic>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/21 at 11:11am, Borislav Petkov wrote:
> On Wed, Dec 29, 2021 at 03:45:12PM +0800, Dave Young wrote:
> > BTW, I would suggest to wait for reviewers to response (eg. one week at
> > least, or more due to the holidays) before updating another version
> > 
> > Do not worry to miss the 5.17.  I would say take it easy if it will
> > miss then let's just leave with it and continue to work on the future
> > improvements.  I think one reason this issue takes too long time is that it was
> > discussed some time but no followup and later people need to warm up
> > again.  Just keep it warm and continue to engage in the improvements, do
> > not hurry for the specific mainline release.
> 
> Can you tell this to *all* patch submitters please?

I appreciate you further explanation below to describe the situation.  I do not
see how can I tell this to *all* submitters,  but I am and I will try to do this
as far as I can.  Maintainers and patch submitters, it would help for both
parties show sympathy with each other, some soft reminders will help
people to understand each other, especially for new comers.

> 
> I can't count the times where people simply hurry to send the new
> revision just to get it in the next kernel, and make silly mistakes
> while doing so. Or not think things straight and misdesign it all.
> 
> And what this causes is the opposite of what they wanna achieve - pissed
> maintainers and ignored threads.
> 
> And they all *know* that the next kernel is around the corner. So why
> the hell does it even matter when?
> 
> What most submitters fail to realize is, the moment your code hits
> upstream, it becomes the maintainers' problem and submitters can relax.
> 
> But maintainers get to deal with this code forever. So after a while
> maintainers learn that they either accept ready code and it all just
> works or they make the mistake to take half-baked crap in and then they
> themselves get to clean it up and fix it.
> 
> So maintainers learn quickly to push back.
> 
> But it is annoying and it would help immensely if submitters would
> consider this and stop hurrying the code in but try to do a *good* job
> first, design-wise and code-wise by thinking hard about what they're
> trying to do.
> 
> Yeah, things could be a lot simpler and easier - it only takes a little
> bit of effort...
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 

Thanks
Dave

