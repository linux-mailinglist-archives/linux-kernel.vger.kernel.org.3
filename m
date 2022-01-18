Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1EEB492CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 18:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347611AbiARRws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 12:52:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23448 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347579AbiARRwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 12:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642528366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xHlvo7QWK5LPEIMsgEhcwsrS7X3dVRtPwrg1PSoq2kI=;
        b=H/ncG+j3+X5fwOYAPYKHsRaqxSQezkd1OM/4BYaUdaBMKecg4h2n4SK33reXzkoJ1h4hVP
        Gux8AlDzdzSJVZbEMDjMUTiR96U2fmNr7qW+EMZJwEjx/X9LFtQd1Zboj++nCbpq0NSjJw
        N1fAAOR/RHk6/lgkoWSvosF9TFDMUIY=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-v9XVSt2MPi-YQfXUAhUwTg-1; Tue, 18 Jan 2022 12:52:44 -0500
X-MC-Unique: v9XVSt2MPi-YQfXUAhUwTg-1
Received: by mail-oi1-f199.google.com with SMTP id s131-20020acac289000000b002c6a61fd43fso13969590oif.23
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 09:52:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xHlvo7QWK5LPEIMsgEhcwsrS7X3dVRtPwrg1PSoq2kI=;
        b=r+RbInHhW/McxTQYIeHmJqgv3PvHzxuxXRcTXLeMTEfEXBCJxHzUE1/kRL0zMb+i2D
         hFCvpmNj/dSHU+tzH8gETytbcgR5gA9QDQZ60d+wa7vZxpvTpjmAKCNBQojCmTbUDits
         ZQrjW5M4+lGDnm+IOJjAIAu+fB5SXLklh929d++GQmN9Uf96NsZnco18rN9ZKPaSnrYB
         mSTLQbG7QrJ4ANpZWMN+n5vHQFIAYA/7VwO4vcuIbwFN8Nkykt2+dIeIbvAVlKjIpnmh
         uSbTi9Fcm6uzvL+SOLCT+4Ks4uMPasCEDHyyJ3TrOSsJJguCwbx4ox+eEXtA6tAoaPiy
         42/Q==
X-Gm-Message-State: AOAM532V9L9sWBazE7Tjo3K2nFTjb7sPvg8HegaJH+FzI9piqVtXKMr0
        90ZsMpF/EZx8NKg/eSoP0htF7oipvNWM2PAWTtIVUr9dGzCk7e3C95fFTy6t9JZPaoBocM7H/r3
        UEgr0vIJ0xsPlZJnNCJ8cLGXp
X-Received: by 2002:a05:6808:358:: with SMTP id j24mr14202760oie.134.1642528362475;
        Tue, 18 Jan 2022 09:52:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvVcNmkskHyhTreEEzS9pNPBANVdlgKxVDSDUChABCQT/JWSRNCjaMFTZjLIpxYA1SbT7TbQ==
X-Received: by 2002:a05:6808:358:: with SMTP id j24mr14202741oie.134.1642528362174;
        Tue, 18 Jan 2022 09:52:42 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::c])
        by smtp.gmail.com with ESMTPSA id c15sm6758402ooq.30.2022.01.18.09.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 09:52:41 -0800 (PST)
Date:   Tue, 18 Jan 2022 09:52:39 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chi-Thanh Hoang <chithanh.hoang@gmail.com>
Subject: Re: Issue using faddr2line on kernel modules
Message-ID: <20220118175239.lqxi2ycgeusk5pxl@treble>
References: <CAPDLWs_iSrbXwfKa6CQ0f6H6GE4U88uRhaFgabRjMmSuSEpsiA@mail.gmail.com>
 <20220117194836.vj2rxr3wocrtdx7k@treble>
 <20220117202751.bmwvfsnqxokob6d2@treble>
 <CAPDLWs-yX4FNrmnF3rHrEoHNktcw2Yi8X6qidss-qKpdw=r4RQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDLWs-yX4FNrmnF3rHrEoHNktcw2Yi8X6qidss-qKpdw=r4RQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 08:10:28AM +0530, Kaiwan N Billimoria wrote:
> Hi Josh,
> 
> Actually your first patch - the one you mentioned had other issues -
> worked perfectly when applied:
> 
> scripts/faddr2line ./oops_tryv2.ko do_the_work+0x16f/0x194
> do_the_work+0x16f/0x0000000000000194:
> do_the_work at <...>/oops_tryv2/oops_tryv2.c:62
> 
> The second one still failed in the same manner:
> 
> scripts/faddr2line ./oops_tryv2.ko do_the_work+0x16f/0x194
> bad symbol size: base: 0x0000000000000000 end: 0x0000000000000000
> 
> So, is it possible to fixup issues with the first version?
> What are these issues?

The first patch basically reverts the fix in commit efdb4167e676
("scripts/faddr2line: Fix "size mismatch" error").  That would be nice
as it's simpler and more robust, but unfortunately it would cause a lot
of "size mismatch" errors with vmlinux symbols.

Can you give the output of 'nm -n ./oops_tryv2.ko'?  There must be some
text symbol immediately after the do_the_work() symbol which is either
out of order, or part of another section.

Is do_the_work() in the .text section?

> On Tue, Jan 18, 2022 at 1:57 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Mon, Jan 17, 2022 at 11:48:39AM -0800, Josh Poimboeuf wrote:
> > > On Mon, Jan 17, 2022 at 10:27:14AM +0530, Kaiwan N Billimoria wrote:
> > > > Hi there,
> > > >
> > > > Am researching using the cool faddr2line script to help debug Oops'es
> > > > from kernel modules..
> > > > I find it works just fine when used against the unstripped vmlinux
> > > > with debug symbols.
> > > >
> > > > My use case is for a kernel module which Oopses, though. Here's my scenario:
> > > > I built a module on a custom debug kernel (5.10.60) with most debug
> > > > options enabled...
> > > > KASLR is enabled by default as well.
> > > >
> > > > A test kernel module Oopses on my x86_64 guest running this kernel with:
> > > > RIP: 0010:do_the_work+0x15b/0x174 [oops_tryv2]
> > > >
> > > > So, i try this:
> > > >
> > > > $ <...>/linux-5.10.60/scripts/faddr2line ./oops_tryv2.ko do_the_work+0x15b/0x174
> > > > bad symbol size: base: 0x0000000000000000 end: 0x0000000000000000
> > > > $
> > > >
> > > > (It works fine with addr2line though!).
> > > > Now I think I've traced the faddr2line script's failure to locate
> > > > anything down to this:
> > > > ...
> > > > done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$3 ==
> > > > fn { found=1; line    =$0; start=$1; next } found == 1 { found=0;
> > > > print line, "0x"$1 } END {if (found == 1) print     line, end; }')
> > > >
> > > > The nm output is:
> > > > $ nm -n ./oops_tryv2.ko |grep -i do_the_work
> > > > 0000000000000000 t do_the_work
> > > > $
> > > >
> > > > nm shows the text addr as 0x0; this is obviously incorrect (same 0x0
> > > > with objdump -d on the module).
> > > > Am I missing something? Any suggestions as to what I can try, to get
> > > > faddr2line working?
> > >
> > > Hi Kaiwan,
> > >
> > > Thanks for reporting this issue.  The module text address of 0x0 is not
> > > necessarily incorrect, as the address is relative the the module, where
> > > all text usually starts at zero.
> > >
> > > I was able to recreate this problem using a module which only has a
> > > single function in .text.  Does this fix it?
> >
> > Actually, that patch has other problems.  Try this one?
> >
> > ----
> >
> > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > Subject: [PATCH] scripts/faddr2line: Only look for text symbols when
> >  calculating function size
> >
> > With the following commit:
> >
> >   efdb4167e676 ("scripts/faddr2line: Fix "size mismatch" error")
> >
> > ... it was discovered that faddr2line can't just read a function's ELF
> > size, because that wouldn't match the kallsyms function size which is
> > printed in the stack trace.  The kallsyms size includes any padding
> > after the function, whereas the ELF size does not.
> >
> > So faddr2line has to manually calculate the size of a function similar
> > to how kallsyms does.  It does so by starting with a sorted list of
> > symbols and subtracting the function address from the subsequent
> > symbol's address.
> >
> > That calculation is broken in the case where the function is the last
> > (or only) symbol in the .text section.  The next symbol in the sorted
> > list might actually be a data symbol, which can break the function size
> > detection:
> >
> >   $ scripts/faddr2line sound/soundcore.ko sound_devnode+0x5/0x35
> >   bad symbol size: base: 0x0000000000000000 end: 0x0000000000000000
> >
> > Similar breakage can occur when reading from a .o file.
> >
> > Fix it by only looking for text symbols.
> >
> > Fixes: efdb4167e676 ("scripts/faddr2line: Fix "size mismatch" error")
> > Reported-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> >  scripts/faddr2line | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/faddr2line b/scripts/faddr2line
> > index 6c6439f69a72..2a130134f1e6 100755
> > --- a/scripts/faddr2line
> > +++ b/scripts/faddr2line
> > @@ -189,7 +189,7 @@ __faddr2line() {
> >
> >                 DONE=1
> >
> > -       done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
> > +       done < <(${NM} -n $objfile | awk -v fn=$func -v end=$file_end '$2 !~ /[Tt]/ {next} $3 == fn { found=1; line=$0; start=$1; next } found == 1 { found=0; print line, "0x"$1 } END {if (found == 1) print line, end; }')
> >  }
> >
> >  [[ $# -lt 2 ]] && usage
> > --
> > 2.31.1
> >
> 

-- 
Josh

