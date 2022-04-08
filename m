Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BD04F8E8A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbiDHDhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 23:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiDHDhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 23:37:07 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA581F6F21
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 20:35:05 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id m16so6815424plx.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 20:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c5Z2BjAgFDB5ffwCfSBrzazo1i97nTuEbiqPvTikdzI=;
        b=QPooFwjpoVXbBo/yF32DprJzh2jp8GfVrl5P9+XT9kwTzYYENmJk4xw0GGFBLWj/Iq
         GMhv/UezKT4E2kmvUMBZ4s/gc5wmri/JW6SUyt7euSt6rL7PjvTNoV+CBCKgYPmo4lxL
         2X59eAzIg2u3BRkGPGEQ+PR9JbFlCxYZ3dboI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c5Z2BjAgFDB5ffwCfSBrzazo1i97nTuEbiqPvTikdzI=;
        b=Wn/VMjTbW4PesPTl3xolV5jyWlxvOmmZCBOazFpjZYe9tNQPps3PxFVJyb7ump6JHu
         AwkeLi5Ij7j3VJNRhxI73abhAtHM3hr3DgGL4WFoaVgZtocw9hHR44qIxMQ23YnmMfdx
         ZGuwjS5+naVRwrRqvXCOLtTAutqOszhu7hhwLWhOuZxIBrMJFwMBxNCoevAtwBESQOlN
         rkBYrF6Pg15A8qfdlLjtUZsqXhFrQNrZzmHIIj8f9uN5wL7Ugg+OYD4i+Ikde894QBUf
         uvcKXOu/RpKbjmQg6vgfDt2QPHnEDOXJnPYvkSNB30iZNmgtXO5EIG8WApDO5bXG3vWU
         7bJw==
X-Gm-Message-State: AOAM532dF3MrBHWucDZcF+J55+a5jKkM4fyctlGaA+wgVazmtbhBgy0L
        bERsLdO2AHLU5PIc9KJKzCVtTg==
X-Google-Smtp-Source: ABdhPJziwzJ1ICU9SwuFvDJ7vjL/gv5LeD8177ZammEm6ZOExt3vp3NvbLGxStbnXY0bF3kA1O1j3A==
X-Received: by 2002:a17:90b:4a06:b0:1c7:2020:b5b9 with SMTP id kk6-20020a17090b4a0600b001c72020b5b9mr19354192pjb.58.1649388904769;
        Thu, 07 Apr 2022 20:35:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c8-20020a17090a558800b001ca81981f51sm10266434pji.44.2022.04.07.20.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 20:35:04 -0700 (PDT)
Date:   Thu, 7 Apr 2022 20:35:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH v4] /dev/mem: Revoke mappings when a driver claims the
 region
Message-ID: <202204072030.43D5BFDB@keescook>
References: <159009507306.847224.8502634072429766747.stgit@dwillia2-desk3.amr.corp.intel.com>
 <202005211950.D56130B81@keescook>
 <202204061243.FB134CA4B1@keescook>
 <CAPcyv4htK6Ur4-B=cfkQeOD__9s7ZfxMTo+uCCPVDLG=_WNy7A@mail.gmail.com>
 <CAPcyv4hFxVAKgUqt-mua5_1NZkfyKKFL-3F0tSWuSmD=4Z1sBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hFxVAKgUqt-mua5_1NZkfyKKFL-3F0tSWuSmD=4Z1sBw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 04:43:10PM -0700, Dan Williams wrote:
> On Thu, Apr 7, 2022 at 11:47 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Wed, Apr 6, 2022 at 12:46 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > *thread necromancy*
> >
> > It's alive!
> >
> > >
> > > Hi Dan,
> > >
> > > I'm doing a KSPP bug scrub and am reviewing
> > > https://github.com/KSPP/linux/issues/74 again.
> > >
> > > Do you have a chance to look at this? I'd love a way to make mmap()
> > > behave the same way as read() for the first meg of /dev/mem.
> >
> > You want 0-reads or SIGBUS when attempting to access the first 1MB?
> >
> > Because it sounds like what you want is instead of loudly failing with
> > -EPERM in drivers/char/mem.c::mmap_mem() you want it to silently
> > succeed but swap in the zero page, right? Otherwise if it's SIGBUS
> > then IO_STRICT_DEVMEM=y + marking that span as IORESOURCE_BUSY will
> > "Do the Right Thing (TM).".
> 
> In other words, if IO_STRICT_DEVMEM is enabled then the enforcement is
> already there at least for anything marked IORESOURCE_BUSY. So if
> tools are ok with that protection today, maybe there is no need to do
> the zero page dance. I.e. legacy tools the read(2) /dev/mem below 1MB
> get zeroes, and apparently no tools were mmap'ing below 1MB otherwise
> they would have complained by now? At least Fedora is shipping
> IO_STRICT_DEVMEM these days:
> 
> https://src.fedoraproject.org/rpms/kernel/blob/rawhide/f/kernel-x86_64-fedora.config#_2799

When I try to mmap a RAM area <1MiB, mmap succeeds (range_is_allowed()
is non-zero), so I don't think IO_STRICT_DEVMEM would trip anything
using mmap on /dev/mem there.

I am only reading 0s from there, though, but I don't see what's all
happening. I thought maybe it was just literally unused, but even with
CONFIG_PAGE_POISONING=y booted with page_poison=1, I still read 0s (not
0xaa), but I'd like to understand _why_ (i.e. I can't tell if it is
accidentally safe, intentionally safe, or my test is bad.)

For example:

# cat /proc/iomem
00000000-00000fff : Reserved
00001000-0009fbff : System RAM
0009fc00-0009ffff : Reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000c99ff : Video ROM
...

If I mmap page 0, it's rejected (non-RAM). If I mmap page 1, it works,
but it's all 0s. (Which is what I'd like, but I don't see where this is
happening.)

Hmmm.

-- 
Kees Cook
