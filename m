Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89F94F8752
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346954AbiDGSt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiDGStw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:49:52 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0222125D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:47:52 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id b2-20020a17090a010200b001cb0c78db57so4002380pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 11:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S46G+gKDAU34CljtUSVCQy2MOODLf1LihM7Ocrf0Vuo=;
        b=DygKSKiCNhgVcxtq3DiAD06376sY3jECT84gmxJblZpafIYjcgwrxiOe5F10xAQ9O9
         w1xGVUjat+QPTTl/EzVTnJeyYyJT49U2cmE5px5IwpjOJ357BPKTntm/onGZg98XxCZW
         zgG2sGmaK2tUIAmpi/ocoDIBSmHvtWpzOePyOYMSO898QN4VAcsWhGK9EM2r4louLePn
         otwEWUaJtVZVWL45gYTiGipL5+0qR4AfWRZFW97Be02iA+5ohDtrLiz7YzYPmeo1YU7/
         U36MzQeRwmF9P6QmCv8E8LdVL/+0/iKzYF0b+b1IWmiOsBoNatZtDiDqzMzr05xva39i
         8txQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S46G+gKDAU34CljtUSVCQy2MOODLf1LihM7Ocrf0Vuo=;
        b=0BbcpcXqmdvOH2JBq6//dkWmSjGqCFEOWvRZ/UVhL9RuFEaSmupDt/+TQkZmovtkOX
         bWfPiKHWh5Rb/9I4aZhvtGhOllRLVs/zg23vrtQn40M8X0TPtTg5+eqo1cpVxnAkW174
         5JjyQztlAX5Erq6+XTQpewu8YS1pj2LbITe9o52awEFHq2nHf99L2rnSMOZnR16IlKpp
         4qESJ2Idx3V98XDNChpwSn9S9uzPdZF1+1BVeY/akTCGK6AMrmBSUd1wi9L5fLkhTQ4S
         1t8erf612H81v2ilRpr9Lvgx87cWAj9GgQ6HKhFPVE3n+rvcXvy5Vxie0JVKOmzvs2MQ
         2Ajg==
X-Gm-Message-State: AOAM530do8pWlP86eCE7BuIikUPS5zqEvfwB/fUENl7Cu6V/8yyagF1Y
        vR4LBrSmgD72mo+p3nC5AH93W5ZArY+mSmlu4IGTUckNgn4=
X-Google-Smtp-Source: ABdhPJw9/IpkKKhR6EnCIY/WXpzJgOf3e9ulD8IP32MxuddGp7gH9Gj4bh6ZS3UogK83pw5r9EpLBvN29W4qaaowgAI=
X-Received: by 2002:a17:902:d512:b0:156:b23f:ed62 with SMTP id
 b18-20020a170902d51200b00156b23fed62mr15625969plg.147.1649357271479; Thu, 07
 Apr 2022 11:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <159009507306.847224.8502634072429766747.stgit@dwillia2-desk3.amr.corp.intel.com>
 <202005211950.D56130B81@keescook> <202204061243.FB134CA4B1@keescook>
In-Reply-To: <202204061243.FB134CA4B1@keescook>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 7 Apr 2022 11:47:40 -0700
Message-ID: <CAPcyv4htK6Ur4-B=cfkQeOD__9s7ZfxMTo+uCCPVDLG=_WNy7A@mail.gmail.com>
Subject: Re: [PATCH v4] /dev/mem: Revoke mappings when a driver claims the region
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 6, 2022 at 12:46 PM Kees Cook <keescook@chromium.org> wrote:
>
> *thread necromancy*

It's alive!

>
> Hi Dan,
>
> I'm doing a KSPP bug scrub and am reviewing
> https://github.com/KSPP/linux/issues/74 again.
>
> Do you have a chance to look at this? I'd love a way to make mmap()
> behave the same way as read() for the first meg of /dev/mem.

You want 0-reads or SIGBUS when attempting to access the first 1MB?

Because it sounds like what you want is instead of loudly failing with
-EPERM in drivers/char/mem.c::mmap_mem() you want it to silently
succeed but swap in the zero page, right? Otherwise if it's SIGBUS
then IO_STRICT_DEVMEM=y + marking that span as IORESOURCE_BUSY will
"Do the Right Thing (TM).".


>
> -Kees
>
> On Thu, May 21, 2020 at 08:01:53PM -0700, Kees Cook wrote:
> > On Thu, May 21, 2020 at 02:06:17PM -0700, Dan Williams wrote:
> > > The typical usage of unmap_mapping_range() is part of
> > > truncate_pagecache() to punch a hole in a file, but in this case the
> > > implementation is only doing the "first half" of a hole punch. Namely it
> > > is just evacuating current established mappings of the "hole", and it
> > > relies on the fact that /dev/mem establishes mappings in terms of
> > > absolute physical address offsets. Once existing mmap users are
> > > invalidated they can attempt to re-establish the mapping, or attempt to
> > > continue issuing read(2) / write(2) to the invalidated extent, but they
> > > will then be subject to the CONFIG_IO_STRICT_DEVMEM checking that can
> > > block those subsequent accesses.
> >
> > Nice!
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> >
> > And a thread hijack...   ;)
> >
> > I think this is very close to providing a way to solve another issue
> > I've had with /dev/mem, which is to zero the view of the first 1MB of
> > /dev/mem via mmap. I only fixed the read/write accesses:
> > a4866aa81251 ("mm: Tighten x86 /dev/mem with zeroing reads")
> > I.e. the low 1MB range should be considered allowed, but any reads will see
> > zeros.
> >
> > > +   unmap_mapping_range(inode->i_mapping, res->start, resource_size(res), 1);
> >
> > Is unmap_mapping_range() sufficient for this? Would it need to happen
> > once during open_port() or something more special during mmap_mem()?
> >
> > --
> > Kees Cook
>
> --
> Kees Cook
