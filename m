Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A37D478C67
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 14:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbhLQNez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 08:34:55 -0500
Received: from foss.arm.com ([217.140.110.172]:57510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231836AbhLQNey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:34:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1455012FC;
        Fri, 17 Dec 2021 05:34:54 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56E973F5A1;
        Fri, 17 Dec 2021 05:34:53 -0800 (PST)
Date:   Fri, 17 Dec 2021 13:34:50 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/17] fortify: Detect struct member overflows in
 memcpy() at compile-time
Message-ID: <YbyR+gt0ku65NJrM@FVFF77S0Q05N>
References: <20211213223331.135412-1-keescook@chromium.org>
 <20211213223331.135412-7-keescook@chromium.org>
 <YbseKuBwHEfvzykO@FVFF77S0Q05N>
 <202112160942.01254B408@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112160942.01254B408@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 10:00:09AM -0800, Kees Cook wrote:
> On Thu, Dec 16, 2021 at 11:08:26AM +0000, Mark Rutland wrote:
> > On Mon, Dec 13, 2021 at 02:33:20PM -0800, Kees Cook wrote:
> > > memcpy() is dead; long live memcpy()
> > > 
> > > tl;dr: In order to eliminate a large class of common buffer overflow
> > > flaws that continue to persist in the kernel, have memcpy() (under
> > > CONFIG_FORTIFY_SOURCE) perform bounds checking of the destination struct
> > > member when they have a known size. This would have caught all of the
> > > memcpy()-related buffer write overflow flaws identified in at least the
> > > last three years.
> > > 
> > 
> > Hi Kees,
> > 
> > Since there's a *lot* of context below, it's very easy to miss some key details
> > (e.g. that the compile-time warnings are limited to W=1 builds). It would be
> > really nice if the summary above could say something like:
> 
> Hm, I do need to write a better summary! I think there's still some
> misunderstanding, and I will attempt some clarity here... :)

Thanks! Sorry if that came across as a complaint; this looks really useful and
I just couldn't figure out if I was holding things wrong or whether I was
hitting an unexpected issue. :)

> >   This patch makes it possible to detect when memcpy() of a struct member may
> >   go past the bounds of that member. When CONFIG_FORTIFY_SOURCE=y, runtime
> >   checks are always emitted where the compiler cannot guarantee a memcpy() is
> >   safely bounded, and compile-time warnings are enabled for W=1 builds.
> 
> For GCC and Clang 14, compile-time _write_ overflow warnings are meant
> to be emitted under FORTIFY_SOURCE. _read_ overflow warnings are meant
> to be emitted under FORTIFY_SOURCE + W=1 (or when the same statement
> also has a write overflow).

Cool.

I'll await a clang 14 release, or go build my own copy in the mean time.

> >   This catches a large class of common buffer overflow flaws, and would have
> >   caught all of the memcpy()-related buffer write overflow flaws identified in
> >   the last three years.
> > 
> > As an aside, since W=1 is chock-full of (IMO useless) warnings, is there any
> > way to enable *just* the FORTIFY_SOURCE warnings?
> 
> To see them all (i.e. not shove some into W=1), you can remove the "W=1
> or write overflow" part of the read overflow test in fortify-string.h.
> e.g.:
> 
> -                if ((IS_ENABLED(KBUILD_EXTRA_WARN1) || p_size_field < size) &&
> -                    q_size_field < size)
> +                if (q_size_field < size)
> 
> > I had a go at testing this on arm64, and could get build-time warnings from GCC
> > 11.1.0, but not from Clang 13.0.0.
> 
> This is correct and expected due to Clang 13's lack of support for
> compiletime_warning().

Thanks for confirming!

Thanks,
Mark.
