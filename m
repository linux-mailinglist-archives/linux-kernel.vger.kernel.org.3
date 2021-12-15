Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4A64759DA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242961AbhLONmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242949AbhLONmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:42:46 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F81C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 05:42:46 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso24898472otf.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 05:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfb1hHh+jEUJyg5oHU56w+oIv0TGKGKVkmbpW3/jT9Q=;
        b=OAXVsucVPs0VIj433jyl+gRmsQotXnJlQXt/04KL+qswwJO992dnHpSyB10ATWe2tW
         6hXyHkGFsxRyuV1u0g4K4tPlLpiapDjEoDfwYrnSY/BqFeHnjTrCj4memJBJQCPlLGxy
         LgyAaK0BMKh/QCeP+rDp6GWC9mtr6mF+doHjnqRfit5N2bToAZic4FrqPzle6BEHMq0m
         RCgQf/F1zKiBv9dJnWO2VO8pQFJ3AYB6ih60C/uycpHga92dD2O80ndjU18INxVJ0fgV
         GBcwOyyEXbVoLaV4r61xUOL+PJRllWvTMmqx3TCgd2i4XLO1z9IB7NijZkm2r1LEK+3+
         Jehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfb1hHh+jEUJyg5oHU56w+oIv0TGKGKVkmbpW3/jT9Q=;
        b=gd9MuLiNPE+a6wz6aO5hLLGh12rTHCrz+gmTE+pGC8ktB1Xdkj0GMzA6GTrAuIFhsI
         U7cYkEfWI+rkY8TTs63N0FaIAsugoVnq5CJEkGcFs1SIMz8V8jrkpyMOW6Kah5AJlqiY
         qxVk5hp33/yKCOZABGp4kZOCwyChCYfvHGP6SFAAuzL8xXUikT8lsfI1hbndKuwJZVFE
         4gfl5HfC4V+QMkgLv5NBZeOYrM/JR1y3YJuGEqyD2iQNkmK4OomHldbgHEz5leUpRt9X
         0f2b1o3gBgnQyeB2fnyDNiQ8JY7Eg1SJWSCKIjINExpM/MZVMy7xVTCg5r+zFz3hxR35
         h24w==
X-Gm-Message-State: AOAM5331ZqFx4hiTNYwHGVJ9T9y4oBaP3vrqkxBae8qERT0WXLDcoiWK
        jzzjjI3zCbmgGhjsXNP3gBkoMkNVxxXXhu4SNcfflw==
X-Google-Smtp-Source: ABdhPJzoZ8jOaeAoizAPgwP30MeM4Fzdv/GIS8MXqSpUto4s4aPMYCNk/eQ0Dd5/yEX75uc40cxjN5gaZ3DZb0/4Lqc=
X-Received: by 2002:a05:6830:138b:: with SMTP id d11mr8678273otq.235.1639575765536;
 Wed, 15 Dec 2021 05:42:45 -0800 (PST)
MIME-Version: 1.0
References: <20211206120533.602062-1-xiaolei.wang@windriver.com>
 <CAFA6WYN+0751=feb-O9Drmm5V_Gz-1qsgiHmLsA88=49MoK_dg@mail.gmail.com>
 <PH0PR11MB507734019F54C2BB24D1456F95719@PH0PR11MB5077.namprd11.prod.outlook.com>
 <CAFA6WYMOHUEve8cbZdwzsijer3fRsy=50q67ndsC6U2JD6gK5Q@mail.gmail.com>
 <ede44051-41db-60b4-d5a3-97a789dd52bc@forissier.org> <CAFA6WYM1oCs9gE4b5DaRez+jhCXPb_c25ausj0yWdS5tawX0MA@mail.gmail.com>
 <20211210154915.hjbgrnvtitmwluhz@maple.lan> <CAFA6WYPd+SLT+XZgLPVjLph27P1D5RpYuLwNu4KC+2nOQH07_Q@mail.gmail.com>
 <20211213130400.npccyt36r5sysca3@maple.lan> <CAFA6WYPEjQDyt4g-dftMyzd8RKkagDs3hj5ThQfvdpmmV5dF7A@mail.gmail.com>
 <20211215101954.oggnubww6ywz6fu7@maple.lan> <CAHUa44Hm4WNg3JE6phOo_qcKmq3Pq8N1d6ntStQ4nh6DnpqLFw@mail.gmail.com>
In-Reply-To: <CAHUa44Hm4WNg3JE6phOo_qcKmq3Pq8N1d6ntStQ4nh6DnpqLFw@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 15 Dec 2021 19:12:34 +0530
Message-ID: <CAFA6WYPbfrLV3hDYhjDJPpyCGjxpJxd0h7fqG6BhPyNhP9_y6g@mail.gmail.com>
Subject: Re: [PATCH] optee: Suppress false positive kmemleak report in optee_handle_rpc()
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jerome Forissier <jerome@forissier.org>,
        "Wang, Xiaolei" <xiaolei.wang@windriver.com>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 at 17:55, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> On Wed, Dec 15, 2021 at 11:19 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Tue, Dec 14, 2021 at 12:33:08PM +0530, Sumit Garg wrote:
> > > On Mon, 13 Dec 2021 at 18:34, Daniel Thompson
> > > <daniel.thompson@linaro.org> wrote:
> > > > On Mon, Dec 13, 2021 at 02:28:01PM +0530, Sumit Garg wrote:
> > > > > On Fri, 10 Dec 2021 at 21:19, Daniel Thompson
> > > > > <daniel.thompson@linaro.org> wrote:
> > > > > > On Fri, Dec 10, 2021 at 03:08:21PM +0530, Sumit Garg wrote:
> > > > > > > On Fri, 10 Dec 2021 at 13:40, Jerome Forissier <jerome@forissier.org> wrote:
> > > > > > > > On 12/10/21 06:00, Sumit Garg wrote:
> > > > > > > > > On Fri, 10 Dec 2021 at 09:42, Wang, Xiaolei <Xiaolei.Wang@windriver.com> wrote:
> > > > > > IIUC this patch adds kmemleak_not_leak() at (pretty much) the last
> > > > > > possible point before *ownership* of the SHM block is passed from kernel
> > > > > > to OP-TEE.
> > > > >
> > > > > I wouldn't say it's a transfer of ownership from kernel to OP-TEE but
> > > > > rather a way for OP-TEE to access kernel's memory in order to pass
> > > > > info or execute further RPC commands.
> > > >
> > > > The RPC handler allocates a pointer (e.g. now the RPC handler owns the
> > > > allocated memory). The RPC handler then passes that pointer to OP-TEE and
> > > > forgets what it's value was.
> > > >
> > > > That is a transfer of ownership: the RPC handler does not hold any pointer
> > > > to the memory and is incapable of freeing it. Moreover this situation is
> > > > what kmemleak_no_leak() is for! Its job it to inform kmemleak that the
> > > > pointer is owned/stored somewhere that is does not scan.
> > >
> > > Let me put this another way. If the memory allocator belongs to the
> > > kernel then how does OP-TEE get to know which memory is currently
> > > allocated and it is to be scanned?
> >
> > OP-TEE explicitly requested that the be allocated and responsible for
> > figuring out where to store the pointer. How could it *not* know this
> > information? More specifically OP-TEE is perfectly capable of recording
> > what memory it has allocated and where to scan to find out if it has
> > been lost.
> >
> >
> > > I think the complete solution would be to extend kmemleak to support
> > > OP-TEE memory scanning via OP-TEE invocation to check if it's holding
> > > any kernel memory references.
> >
> > This is the part I get stuck on... and the reason I'm still posting on
> > the thread.
> >
> > I struggle to see any value in using kmemleak to identify this type of
> > leak. That is the fundamental issue. False positives from kmemleak are
> > damaging to user confidence in the tool and are especially harmful when
> > it is complex and time consuming to verify that is actually is a false
> > positive (which would certainly be the case for OP-TEE false positives).
> > In short it is *not* always the case failure-to-detect is worse than
> > false-positive.
> >
> > As discussed already the firmware/kernel contract prevents kmemleak from
> > working as it is designed to and I am unconvinced that relying on
> > fragile timeouts is sufficient.
> >
> > Extending kmemleak to support OP-TEE memory scanning is also, IMHO,
> > pointless. The reason for this is that OP-TEE cannot perform any scan on
> > behalf of kmemleak without first validating the information provided to
> > it by the kernel (to avoid information leaks). However if OP-TEE tracks
> > enough state to validate the kernel input than it already has enough
> > state to do a scan for leaks independently anyway (apart from being
> > donated an execution context). Therefore it follows that any OP-TEE
> > extension to handle leaks should be independent of kmemleak because it
> > would still be useful to be able to ask OP-TEE to run a self-consistency
> > check even if kmemleak is disabled.
> >
> > Or, in short, even if you implement improved leak detection for OP-TEE
> > (whether that is based on timers or scanning) then kmemleak_not_leak()
> > is still the right thing to do with pointers whose ownership we have
> > transferred to OP-TEE.
> >
> >
> > > > > > Sure, after we change ownership it could still be leaked... but it can
> > > > > > no longer be leaked by the kernel because the kernel no longer owns it!
> > > > > > More importantly, it makes no sense to run the kernel memory detector on the
> > > > > > buffer because it simply can't work.
> > > > > >
> > > > > > After the RPC completes, doesn't it become impossible for kmemleak to
> > > > > > scan to see if the pointer is lost[1]?
> > > > >
> > > > > Apart from the special OP-TEE prealloc SHM cache stuff, I can't think
> > > > > of any scenario where an OP-TEE thread should hold off kernel's memory
> > > > > pointers for more than 5 seconds before being passed onto kernel for
> > > > > further RPC commands or RPC free action. So the kmemleak should be
> > > > > able to detect if a pointer is lost.
> > > >
> > > > Or putting this a different way: there is known to be firmware in the
> > > > field that allocates pointers for more then five seconds!
> > >
> > > If it's known that upstream OP-TEE doesn't hold any kernel memory
> > > references for more than 5 seconds then IMO we should be fine to not
> > > disable kmemleak until we have a future kmemleak extension. Otherwise
> > > it would be very hard to keep track of kernel memory lost in this way.
> >
> > In essence I am arguing for using the right tool for the right job (and
> > against turning down a correct patch because the right tool isn't yet
> > implemented). A memory scanning leak detector is the wrong tool to
> > search for leaks in memory that cannot be scanned.
> >
> > For me having to rely on fragile implied contracts and undocumented
> > assumptions about timing further reinforces my view that kmemleak is not
> > the wrong tool. Especially so when we know that those assumptions are
> > not met by existing firmware.
>
> I agree, this patch makes sense. It fixes a problem and I can't see a
> downside with that. In a not too distant future we may change the way
> this memory is passed to OP-TEE by keeping a reference in the driver,
> but until then this patch will fix a problem.

Fair enough, I was just trying to be more optimistic about leveraging
existing kmemleak infrastructure as shared memory bugs are catching on
us.

-Sumit

>
> Cheers,
> Jens
