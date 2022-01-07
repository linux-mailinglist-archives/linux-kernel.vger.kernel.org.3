Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7654870E2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 04:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345629AbiAGDDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 22:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbiAGDDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:03:18 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B0EC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 19:03:18 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id a18so15824903edj.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 19:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=edPTzEAV1hVzS2HKTkNPYzKZ/466ozy+AT9vQnB4coE=;
        b=TKJRp3LPKmjJ3b36zVPp0s/0cqBJpINGn0zaSw3y+OdfzHEolQhieDfHDUSTJ1VZAW
         lNISfdKs92nUGEeasV1w5sg86TFv7o/MWeN33Ok9j3sa2XYvlQ0RDvwm1CWp2XqU67H7
         fNHKftVjzcqE4iBbWBJAbokffKXE9LZrSN9DI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edPTzEAV1hVzS2HKTkNPYzKZ/466ozy+AT9vQnB4coE=;
        b=7Zli3R0R5NGjGQazrZ9t/+LO5VhrHxrh288i4RXxiXvpf0+Iud677a9v8h1UCuy+Ac
         xaXvK8QDQfd0v8EGGh4pqdvRGjaGr/sLE25fCQEfsKdM4cS5PE6kcAB7hAugMb1l37Lr
         bjT5rpn8lHNH8x5NKqVLhx3LbV7FfjDf91C/yiACfy5mt1mFZc2D0nzG4+0v8cVxmmrK
         /mpFGLUyBCQ/SG1dM3iz2+x6fRKx6Dl04zfs6i1NMotost5TD94K6SVLPksifs0RYf3p
         236Y5sOoXbtGj5MzEmcmBWMOpplTF9s+offes+/dbHDAIz87epoKUP+H6+0uhUQk9MQ4
         4l+A==
X-Gm-Message-State: AOAM532mvSsiG7SJSZW/tsNawdbDp+34SKksl6OCLGJ+svwZWqRNQEwC
        auw8IEnjG6AWVCvTVbZEstwAA0TrznToCdoJ
X-Google-Smtp-Source: ABdhPJyhZ9Gq9VYE84xqAzNd0x+NgfDCKMoKG2XArSrHbLfqENcWBR1UCt6KPKEfA/Kqlt1UgmEmnQ==
X-Received: by 2002:a17:907:97d4:: with SMTP id js20mr42785554ejc.273.1641524596710;
        Thu, 06 Jan 2022 19:03:16 -0800 (PST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id 13sm984384ejh.225.2022.01.06.19.03.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jan 2022 19:03:15 -0800 (PST)
Received: by mail-wr1-f43.google.com with SMTP id i22so8370784wrb.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 19:03:14 -0800 (PST)
X-Received: by 2002:a05:6000:10d2:: with SMTP id b18mr52431797wrx.193.1641524594244;
 Thu, 06 Jan 2022 19:03:14 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e8f8f505d0e479a5@google.com> <20211211015620.1793-1-hdanton@sina.com>
 <YbQUSlq76Iv5L4cC@sol.localdomain> <YdW3WfHURBXRmn/6@sol.localdomain>
 <CAHk-=wjqh_R9w4-=wfegut2C0Bg=sJaPrayk39JRCkZc=O+gsw@mail.gmail.com>
 <CAHk-=wjddvNbZBuvh9m_2VYFC1W7HvbP33mAzkPGOCHuVi5fJg@mail.gmail.com>
 <CAHk-=wjn5xkLWaF2_4pMVEkZrTA=LiOH=_pQK0g-_BMSE-8Jxg@mail.gmail.com>
 <YddnuSh15BAGdjAD@slm.duckdns.org> <CAHk-=whhcoeTOZB_de-Nh28Fy4iNTu2DXzKXEPOubzL36+ME=A@mail.gmail.com>
 <YdeFx9i/LaAC346s@sol.localdomain>
In-Reply-To: <YdeFx9i/LaAC346s@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Jan 2022 19:02:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiCv6m9g2=tGSVkf8KEdZFFJp47hiepo93NyLruYoGLAQ@mail.gmail.com>
Message-ID: <CAHk-=wiCv6m9g2=tGSVkf8KEdZFFJp47hiepo93NyLruYoGLAQ@mail.gmail.com>
Subject: Re: psi_trigger_poll() is completely broken
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 4:14 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> I had to make the following changes to Linus's patch:

Ack. Thanks.

> This is one way to fix the use-after-free, but the fact that it allows anyone
> who can write to a /proc/pressure/* file to cause the kernel to allocate an
> unbounded number of 'struct psi_trigger' structs is still really broken.

Yeah, I agree. Very non-optimal - that patch really was trying to just
keep the status quo, and fixing the immediate problems.

Modifying that patch to only allow a previous NULL value in
psi_trigger_replace() would be fairly simple - it would basically just
get rid of the "stale_trigger" list (and the loops it creates).

You'd still want the psi_trigger_release() model to separate that
whole "release" from "new trigger".

But that does require that nobody ever does more than a single write
to one file.

Debian code search finds those "/proc/pressure/xyz" files mentioned at
least by systemd and the chromium chrome browser sources. Whether they
actually write triggers to them, I can't say.

Maybe we just need to try.

               Linus
