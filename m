Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FD24F8B4C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 02:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiDGXsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 19:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiDGXss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 19:48:48 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F06F10E57C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 16:46:47 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y6so6450382plg.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 16:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T2ZSBezV+f6piMbIWQu4Bg05zBONMw4MFkVYAUPknE0=;
        b=FGPFYssugxMdDKKPrbzXyPUdSY8SlSjAl3J4V8yiXxt5A7uHo07eafozgA06mInERz
         CkwMo601Kn/O1YSTCAOMVAx/rl0egoGpwYx5Tlwgbg0p3kRh/8GVGfsWBsqFw7ZpLLMg
         wJYcjHf0Et/w6IImST71JfLD3voKPg7RXZ/I8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T2ZSBezV+f6piMbIWQu4Bg05zBONMw4MFkVYAUPknE0=;
        b=ERZC0LwsjqY2YQnunw1QFljMs5sa4fGogsVSn3G/V9MlKLLY/H4MjZqFd8DwfsE9Y/
         yTDqL43EE0W5RwfO0BcARk1isAl8EPBfCrURk9GRjn+w2+ls64kpsjK4wXE31kx3PNyf
         y/ik/6rA8RGGWKt3ZEljtDtsUQNeP+eZCFbXxisQp6tibPDMoIiFhpQjOSOVw24Bwh4k
         xZ9uz84/QOnFcjsD8G4wjtx96hLeF8reqeWSXgh8tKG6z4qrjzrIuS0VzSvXzdb/i1Gr
         KJoZa6ZTR/8HpU5iUZCx+R75ultoiq1oEsmNE4rtMJXfy8nuCtC+n5Z5UOeIptSbyLry
         uyXg==
X-Gm-Message-State: AOAM533uw/H2sdaTfKUDttEQs93vX4pgOwS/4Pj9FM2a1pO8anRwUpuv
        7zDF9t7pYW73iecfKEQHMh2MEQ==
X-Google-Smtp-Source: ABdhPJwuDiF2YI6RHRwB5ITufJK/aIWQORhXPS0E3RZzPUYeFhnKdJ6zJmO95lnS3mYNygSJXc98zA==
X-Received: by 2002:a17:90b:4d88:b0:1ca:a5c5:1386 with SMTP id oj8-20020a17090b4d8800b001caa5c51386mr18742618pjb.43.1649375207069;
        Thu, 07 Apr 2022 16:46:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i187-20020a62c1c4000000b004faafada2ffsm24632609pfg.204.2022.04.07.16.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 16:46:46 -0700 (PDT)
Date:   Thu, 7 Apr 2022 16:46:45 -0700
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
Message-ID: <202204071526.37364B5E3@keescook>
References: <159009507306.847224.8502634072429766747.stgit@dwillia2-desk3.amr.corp.intel.com>
 <202005211950.D56130B81@keescook>
 <202204061243.FB134CA4B1@keescook>
 <CAPcyv4htK6Ur4-B=cfkQeOD__9s7ZfxMTo+uCCPVDLG=_WNy7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4htK6Ur4-B=cfkQeOD__9s7ZfxMTo+uCCPVDLG=_WNy7A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 11:47:40AM -0700, Dan Williams wrote:
> On Wed, Apr 6, 2022 at 12:46 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > *thread necromancy*
> 
> It's alive!

*lightning*

> > I'm doing a KSPP bug scrub and am reviewing
> > https://github.com/KSPP/linux/issues/74 again.
> >
> > Do you have a chance to look at this? I'd love a way to make mmap()
> > behave the same way as read() for the first meg of /dev/mem.
> 
> You want 0-reads or SIGBUS when attempting to access the first 1MB?
> 
> Because it sounds like what you want is instead of loudly failing with
> -EPERM in drivers/char/mem.c::mmap_mem() you want it to silently
> succeed but swap in the zero page, right? Otherwise if it's SIGBUS
> then IO_STRICT_DEVMEM=y + marking that span as IORESOURCE_BUSY will
> "Do the Right Thing (TM).".

I'd like it to just return zeros, which is what "read" currently does.
(i.e. if page_is_allowed(), really devmem_is_allowed(), returns 2, then
the user should see all zeros.)

So, yes, "silently succeed but swap in the zero page" is exactly what
I'd like. When I last looked, for the first meg, mmap did _not_ fail,
but _actually_ reads it.

-- 
Kees Cook
