Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BDF47701D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbhLPLWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:22:10 -0500
Received: from foss.arm.com ([217.140.110.172]:42374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236635AbhLPLWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:22:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E4CD1474;
        Thu, 16 Dec 2021 03:22:00 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.67.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C2CA3F774;
        Thu, 16 Dec 2021 03:21:59 -0800 (PST)
Date:   Thu, 16 Dec 2021 11:21:56 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/17] fortify: Detect struct member overflows in
 memcpy() at compile-time
Message-ID: <YbshVApl8kBYtCzZ@FVFF77S0Q05N>
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
> 
>   This patch makes it possible to detect when memcpy() of a struct member may
>   go past the bounds of that member. When CONFIG_FORTIFY_SOURCE=y, runtime
>   checks are always emitted where the compiler cannot guarantee a memcpy() is
>   safely bounded, and compile-time warnings are enabled for W=1 builds.
> 
>   This catches a large class of common buffer overflow flaws, and would have
>   caught all of the memcpy()-related buffer write overflow flaws identified in
>   the last three years.
> 
> As an aside, since W=1 is chock-full of (IMO useless) warnings, is there any
> way to enable *just* the FORTIFY_SOURCE warnings?
> 
> [...]
> 
> > Implementation:
> > 
> > Tighten the memcpy() destination buffer size checking to use the actual
> > ("mode 1") target buffer size as the bounds check instead of their
> > enclosing structure's ("mode 0") size. Use a common inline for memcpy()
> > (and memmove() in a following patch), since all the tests are the
> > same. All new cross-field memcpy() uses must use the struct_group() macro
> > or similar to target a specific range of fields, so that FORTIFY_SOURCE
> > can reason about the size and safety of the copy.
> > 
> > For now, cross-member "mode 1" read detection at compile-time will be
> > limited to W=1 builds, since it is, unfortunately, very common. As the
> > priority is solving write overflows, read overflows can be part of the
> > next phase.
> 
> I had a go at testing this on arm64, and could get build-time warnings from GCC
> 11.1.0, but not from Clang 13.0.0.

Looking again, I see this is down to __compiletime_warning() only being usable
from clang 14.0 onwards (and the final patch mentions that in passing), so I
guess that's expected.

It would be nice to call that out somewhere in this patch (e.g. in that
introductory paragraph), since it's very each to miss that and get confused...
;)

Thanks,
Mark.
