Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCD9494272
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 22:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357364AbiASVVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 16:21:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39004 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229675AbiASVVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 16:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642627291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pMBGEfdUp32njygoehJuHz49mNSt4sh9Umtdihp9UCc=;
        b=Z/T6m8DG0F0/abOtWSvTGhO4fd1vL3aJ/q3q7ftR4Nyy9O3CgKBrGfJznb8Eu7FUWsCuKs
        75Url5mf/XiCNEWKwaY8xQIXZdYzjMpUXgwwWkxqInrDQ60tRV3kY9kgyx5Dyf8J1HBVTF
        DxTAW5tO9/1Pc7DTxdJmBq6dAmztJ2k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-XCEShU3fOVS0kZBcVqYIPA-1; Wed, 19 Jan 2022 16:21:30 -0500
X-MC-Unique: XCEShU3fOVS0kZBcVqYIPA-1
Received: by mail-qv1-f69.google.com with SMTP id gg10-20020a056214252a00b0041eeb1c2684so3999942qvb.21
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 13:21:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pMBGEfdUp32njygoehJuHz49mNSt4sh9Umtdihp9UCc=;
        b=2iGBSnVwvymITfV1YaT7CxT/XEJCQ686il+a1ERdfvGQu4v8zTmMyQEJYxlSsfBMy6
         +ZIDlEut/CpXsnivs3RovTmkYkPf8w9I4sKrkMKAlhp/EG4aPs8LOJKSxEwfef64wXF2
         wUB3Sx3HUNMNgoPY3JIoiVsnqwNse2AKuZuwMR7rjImrTtX9rxlF3WZpAs3V88MYnZ8V
         AK+TMEG/B3/n8de5iBEUltUVieVfNlcAiAFPmGet5dw97iBZrGKzAYo1tnN8zyfjf+fR
         MmZMQkRRgGNN1a2G6NWu5ViN9mgQnzSIQNl2FxQFAQ+kMjEkYiBUYtd30Q9EFcxw0Xqe
         Negg==
X-Gm-Message-State: AOAM532wa7L4M/Dlk5yIA6p5IjW1zDX4af0NUWzgSR53qboXsgT3bR/R
        lTEeL084NuhfzbyD8ZZ1OuVQzgJzQ9m+V03/NBQuP94O4bSRIlvJ5VZQFT9KSe0cUlh90YTYxNZ
        1l93Em8bn97oAzsWM6LIJwpVp
X-Received: by 2002:a05:622a:164a:: with SMTP id y10mr26483454qtj.441.1642627289331;
        Wed, 19 Jan 2022 13:21:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyqqOeJV/AJ+vp7CrsYh4ibzZlHWti6pzMRwEvIYY3pb4EGXkFQ0HSUlq5DmuQ+lXlpj3LQCw==
X-Received: by 2002:a05:622a:164a:: with SMTP id y10mr26483444qtj.441.1642627289051;
        Wed, 19 Jan 2022 13:21:29 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::c])
        by smtp.gmail.com with ESMTPSA id v18sm398742qtw.14.2022.01.19.13.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 13:21:28 -0800 (PST)
Date:   Wed, 19 Jan 2022 13:21:26 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chi-Thanh Hoang <chithanh.hoang@gmail.com>
Subject: Re: Issue using faddr2line on kernel modules
Message-ID: <20220119212126.aydgx62abbngumwy@treble>
References: <CAPDLWs_iSrbXwfKa6CQ0f6H6GE4U88uRhaFgabRjMmSuSEpsiA@mail.gmail.com>
 <20220117194836.vj2rxr3wocrtdx7k@treble>
 <20220117202751.bmwvfsnqxokob6d2@treble>
 <CAPDLWs-yX4FNrmnF3rHrEoHNktcw2Yi8X6qidss-qKpdw=r4RQ@mail.gmail.com>
 <20220118175239.lqxi2ycgeusk5pxl@treble>
 <CAPDLWs_mirot76g==TPRZDsB6Qn99kxw2N5V=PaDYqBLf=ZSCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDLWs_mirot76g==TPRZDsB6Qn99kxw2N5V=PaDYqBLf=ZSCQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 09:27:18AM +0530, Kaiwan N Billimoria wrote:
> On Tue, Jan 18, 2022 at 11:22 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Tue, Jan 18, 2022 at 08:10:28AM +0530, Kaiwan N Billimoria wrote:
> > > Hi Josh,
> > >
> > > Actually your first patch - the one you mentioned had other issues -
> > > worked perfectly when applied:
> > >
> > > scripts/faddr2line ./oops_tryv2.ko do_the_work+0x16f/0x194
> > > do_the_work+0x16f/0x0000000000000194:
> > > do_the_work at <...>/oops_tryv2/oops_tryv2.c:62
> > >
> > > The second one still failed in the same manner:
> > >
> > > scripts/faddr2line ./oops_tryv2.ko do_the_work+0x16f/0x194
> > > bad symbol size: base: 0x0000000000000000 end: 0x0000000000000000
> > >
> > > So, is it possible to fixup issues with the first version?
> > > What are these issues?
> >
> > The first patch basically reverts the fix in commit efdb4167e676
> > ("scripts/faddr2line: Fix "size mismatch" error").  That would be nice
> > as it's simpler and more robust, but unfortunately it would cause a lot
> > of "size mismatch" errors with vmlinux symbols.
> 
> I see... if it comes to it, could there be a workaround where the
> script detects a vmlinux image and works in a given manner,
> else in this manner for other images - in effect, for modules?

I think I misspoke about the vmlinux behavior being different, so I
don't think that would work.

> > Can you give the output of 'nm -n ./oops_tryv2.ko'?  There must be some
> > text symbol immediately after the do_the_work() symbol which is either
> > out of order, or part of another section.
> >
> > Is do_the_work() in the .text section?
> Yes...
> Here's the output I get:
> 
> $ nm -n ./oops_tryv2.ko |grep -C5 do_the_work
> 0000000000000000 r __func__.24215
> 0000000000000000 r __param_bug_in_workq
> 0000000000000000 D __this_module
> 0000000000000000 r _note_7
> 0000000000000000 T cleanup_module
> 0000000000000000 t do_the_work
> 0000000000000000 t do_the_work.cold
> 0000000000000000 b gctx
> 0000000000000000 T init_module
> 0000000000000000 t try_oops_exit
> 0000000000000000 t try_oops_init
> 0000000000000008 b t1
> $
> 
> BTW, here's the code:
> https://github.com/PacktPublishing/Linux-Kernel-Debugging/tree/main/ch7/oops_tryv2

Ok, it looks like the symbols aren't sorted like the code expects.  I
need to do a more robust fix.

-- 
Josh

