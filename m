Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006484F1F02
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382289AbiDDVvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379901AbiDDSUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 14:20:41 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05257DF21
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 11:18:44 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m12-20020a17090b068c00b001cabe30a98dso71193pjz.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 11:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uc2JgILBBIGGteHeEA8udkgkI4ku5XbZtnJzvUa5oOs=;
        b=hEyBhz6cZxnXixT/I4n2Ix076X/e8T2cj1dSgutpj5j72hGPyV/MyRuKFnYbOKDNoh
         lR0sNobji3iDxqHkl8NPVbzkHFEsYVMPZNBfx6YikEIHqOh4l5+SFdwAIt4WCnkPuJPV
         /oaWeDOV9OJAOzVrfnvEbOp0mrES0RlO1R8hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uc2JgILBBIGGteHeEA8udkgkI4ku5XbZtnJzvUa5oOs=;
        b=imrEh25E646JNGqIf+BOzHUdP0lzerOwoDkHurGcwb3lAYo/JbcpD/AMvyrb0rP3cz
         eUkfJhsbfZnAqFCgXvszfrUokirICMs1DULNXdUs3mudbJ1/dNVCzPuJDuHjjMG8URhD
         iN4k/B/M/eyZTuZQqe2gZW0F6qX95H4uCJhb+svc/4VNYgCTYCKCeRDxgkspZUYMWZNY
         oH5QeReC3K1AjFBzQWMDumagw9hgYeAfdb0j/UcV2PoEQhqfBU2iT1IP0MpgcAOGNHeM
         NJ9WBmWC0qwXkmJhKX83cqmElQgZd4zDn2dvhiBRUIhJGCzlkyLXRTmqb2Un+NvSLFem
         F+yA==
X-Gm-Message-State: AOAM530SsHkM+EEZjIwZ5u7TjExkzebeovZvR6uGGHNVcwIjUSagOd0D
        W49HJB4lzVHewKJLIRU0T7n5SQ==
X-Google-Smtp-Source: ABdhPJw/aFKXyOfDmmysPNSvVztAXZd396o1OW83XcrBVThqc8lKvqismPy8xHmatxgzXi233JRU1g==
X-Received: by 2002:a17:90a:a78c:b0:1b8:b769:62d0 with SMTP id f12-20020a17090aa78c00b001b8b76962d0mr443076pjq.227.1649096323485;
        Mon, 04 Apr 2022 11:18:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k20-20020aa788d4000000b004fb07f819c1sm12863944pff.50.2022.04.04.11.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 11:18:43 -0700 (PDT)
Date:   Mon, 4 Apr 2022 11:18:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "'Maciej W. Rozycki'" <macro@orcam.me.uk>,
        James Jones <linux@theinnocuous.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: Remove a.out support
Message-ID: <202204041117.0CD04EB@keescook>
References: <4c449fab-8135-5057-7d2c-7b948ce130cc@theinnocuous.com>
 <0b31b1d3-852d-6cab-82ae-5eecaec05679@theinnocuous.com>
 <202203151150.1CDB1D8DA@keescook>
 <bfbd9394-161b-0e70-00c5-79d0dd722e08@theinnocuous.com>
 <alpine.DEB.2.21.2204022255430.47162@angie.orcam.me.uk>
 <67CF27C5-5013-4EF4-B24C-8D9EB52536FB@chromium.org>
 <alpine.DEB.2.21.2204041135210.47162@angie.orcam.me.uk>
 <08c095230941445f9139ab89bc70da43@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08c095230941445f9139ab89bc70da43@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 05:07:11PM +0000, David Laight wrote:
> From: Maciej W. Rozycki
> > Sent: 04 April 2022 12:04
> > 
> > On Sat, 2 Apr 2022, Kees Cook wrote:
> > 
> > > > Chiming in late as I'm scanning outstanding mailing list traffic: if this
> > > >is as you say all statically linked stuff, then converting from a.out to
> > > >ELF might be as easy as:
> > > >
> > > >$ objcopy -I a.out-i386-linux -O elf32-i386 a.out-binary elf-binary
> > >
> > > Based on my research (and the wrapper I ended up writing), I don't think
> > > this is sufficient because entry point handling is different between ELF
> > > and a.out (specifically the stack layout and initial sp register value).
> > 
> >  Fair enough.  I guess the exact value of %esp doesn't matter that much
> > (why would it?), but the arguments and environment may well be structured
> > differently (and indeed based on a glance over binfmt_aout.c there's extra
> > indirection involved compared to the ELF i386 psABI).
> 
> You could write a custom 'elf interpreter'.
> Hacking at those isn't for the faint-hearted :-)

A thread on LWN pointed to:
https://github.com/siegfriedpammer/run-aout
which appears to be a much more complete a.out wrapper.

-- 
Kees Cook
