Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FEE477B2D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 19:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240533AbhLPSAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 13:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240154AbhLPSAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 13:00:12 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1788FC06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 10:00:12 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v16so7992981pjn.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 10:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1fPT1fxMD4M41ep+YbnYY0HQb7OLtTBScUVmQTagGoI=;
        b=U/D1E2Z3OM+/yCH/xNkD7RSmGqCThzwjuSxJMQkJAUs1geWML30QUUPboI/6qyyNVR
         JIeYzCHvZOLMLZfHy1RCHOt20aJwNHIha8E3K0dLd7CRmy7MuHvSgfQq3Krv4K+gGOG+
         as6GPVCzvEA9Nt2CM4OmBDGSKJpu9cDq3+4nE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1fPT1fxMD4M41ep+YbnYY0HQb7OLtTBScUVmQTagGoI=;
        b=GIqgBlqL5N1AXAUNQJuC6uggwMO0xFLWEzw9Zmjdl97CN9ZTpRW37jdXth7c4gkqos
         SYmK/dK+NoU9mMPLBW2vsIHZN5GxhmdHDFp8MGKaAEZ8sxO+YssYf+I9hHXC37+/Jmpm
         /MZUBeU6IdebSq7NWp1ENnFBOaOqOSVsEhGP3yIWYAwmQDGYIumIT9Lua56RuWw3n90h
         Eu5n+l6MhWGvYFQWiLGubZqpYfLJaTW2zA84a30PWLsYlnahIMnlQI16XALZcZwWbEor
         3stPnNugPZ2qL1MRcoMIKbZDXbGtSvFUGEmt3xpMkE4qcwVgieqOwkF2vH4zlzZZo1CP
         +W2g==
X-Gm-Message-State: AOAM531tXlkJDBP3DDIaMhrMnVPAL0Zv3aUZSYq40V4FjMm/fgu0GFsm
        J1tLcOke5jZiwDN6R2D+uhgqP4wXLwgD3g==
X-Google-Smtp-Source: ABdhPJw7nwSjZ+xcHGQtrWqYIbiv59UD24ERoOUO8c+Ozl5SJ7AJDXHx+hQFrQfOIPGG/kpIjbWrvA==
X-Received: by 2002:a17:902:9a8a:b0:148:d8aa:16ae with SMTP id w10-20020a1709029a8a00b00148d8aa16aemr208554plp.139.1639677611298;
        Thu, 16 Dec 2021 10:00:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w7sm5956977pgo.56.2021.12.16.10.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 10:00:10 -0800 (PST)
Date:   Thu, 16 Dec 2021 10:00:09 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/17] fortify: Detect struct member overflows in
 memcpy() at compile-time
Message-ID: <202112160942.01254B408@keescook>
References: <20211213223331.135412-1-keescook@chromium.org>
 <20211213223331.135412-7-keescook@chromium.org>
 <YbseKuBwHEfvzykO@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbseKuBwHEfvzykO@FVFF77S0Q05N>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 11:08:26AM +0000, Mark Rutland wrote:
> On Mon, Dec 13, 2021 at 02:33:20PM -0800, Kees Cook wrote:
> > memcpy() is dead; long live memcpy()
> > 
> > tl;dr: In order to eliminate a large class of common buffer overflow
> > flaws that continue to persist in the kernel, have memcpy() (under
> > CONFIG_FORTIFY_SOURCE) perform bounds checking of the destination struct
> > member when they have a known size. This would have caught all of the
> > memcpy()-related buffer write overflow flaws identified in at least the
> > last three years.
> > 
> 
> Hi Kees,
> 
> Since there's a *lot* of context below, it's very easy to miss some key details
> (e.g. that the compile-time warnings are limited to W=1 builds). It would be
> really nice if the summary above could say something like:

Hm, I do need to write a better summary! I think there's still some
misunderstanding, and I will attempt some clarity here... :)

> 
>   This patch makes it possible to detect when memcpy() of a struct member may
>   go past the bounds of that member. When CONFIG_FORTIFY_SOURCE=y, runtime
>   checks are always emitted where the compiler cannot guarantee a memcpy() is
>   safely bounded, and compile-time warnings are enabled for W=1 builds.

For GCC and Clang 14, compile-time _write_ overflow warnings are meant
to be emitted under FORTIFY_SOURCE. _read_ overflow warnings are meant
to be emitted under FORTIFY_SOURCE + W=1 (or when the same statement
also has a write overflow).

> 
>   This catches a large class of common buffer overflow flaws, and would have
>   caught all of the memcpy()-related buffer write overflow flaws identified in
>   the last three years.
> 
> As an aside, since W=1 is chock-full of (IMO useless) warnings, is there any
> way to enable *just* the FORTIFY_SOURCE warnings?

To see them all (i.e. not shove some into W=1), you can remove the "W=1
or write overflow" part of the read overflow test in fortify-string.h.
e.g.:

-                if ((IS_ENABLED(KBUILD_EXTRA_WARN1) || p_size_field < size) &&
-                    q_size_field < size)
+                if (q_size_field < size)

> I had a go at testing this on arm64, and could get build-time warnings from GCC
> 11.1.0, but not from Clang 13.0.0.

This is correct and expected due to Clang 13's lack of support for
compiletime_warning().

> No relevant warnings, but code was generated for runtime warnings:
> 
> | 0000000000000000 <foo_copy>:
> |    0:   d503233f        paciasp
> |    4:   a9bf7bfd        stp     x29, x30, [sp, #-16]!
> |    8:   910003fd        mov     x29, sp
> |    c:   52800080        mov     w0, #0x4                        // #4
> |   10:   52800101        mov     w1, #0x8                        // #8
> |   14:   94000000        bl      0 <__write_overflow_field>
> |   18:   52800080        mov     w0, #0x4                        // #4
> |   1c:   52800101        mov     w1, #0x8                        // #8
> |   20:   94000000        bl      0 <__read_overflow2_field>
> |   24:   90000008        adrp    x8, 8 <foo_copy+0x8>
> |   28:   f9400108        ldr     x8, [x8]
> |   2c:   90000009        adrp    x9, 0 <foo_copy>
> |   30:   f9000128        str     x8, [x9]
> |   34:   a8c17bfd        ldp     x29, x30, [sp], #16
> |   38:   d50323bf        autiasp
> |   3c:   d65f03c0        ret
> 
> Have I misunderstood how that's meant to work, or am I doing something wrong?

The generally stated requirement from Linus for these kinds of
kernel changes was to never break the build (i.e. we cannot use
compiletime_error() -- which Clang 13 falls back to with a link-time
failure).

Since this phase of the series is only compile-time warnings (not the
run-time warnings), it's rather a no-op for Clang 13. However, the final
patch in the series brings the earlier ("mode 0") FORTIFY behaviors to
Clang finally.

Clang 14 implements compiletime_warning(), so in that situation, the
warnings appear.

It's a pretty wacky Venn Diagram, and I will attempt to include some
sort of illustration for it, as the behavioral differences are complex.

-Kees

-- 
Kees Cook
