Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D36349E258
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbiA0M1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:27:19 -0500
Received: from foss.arm.com ([217.140.110.172]:58694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbiA0M1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:27:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4FD551063;
        Thu, 27 Jan 2022 04:27:18 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.14.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA4B83F7D8;
        Thu, 27 Jan 2022 04:27:16 -0800 (PST)
Date:   Thu, 27 Jan 2022 12:27:04 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Yinan Liu <yinan@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linuxppc-dev@lists.ozlabs.org, Sachin Sant <sachinp@linux.ibm.com>,
        linux-kernel@vger.kernel.org, ardb@kernel.org,
        keescook@chromium.org
Subject: Re: [powerpc] ftrace warning kernel/trace/ftrace.c:2068 with
 code-patching selftests
Message-ID: <YfKPmFJ2MGsem4VB@FVFF77S0Q05N>
References: <944D10DA-8200-4BA9-8D0A-3BED9AA99F82@linux.ibm.com>
 <e9422643-a210-b77f-a037-da63a9d2e925@linux.alibaba.com>
 <20220124114548.30241947@gandalf.local.home>
 <0fa0daec-881a-314b-e28b-3828e80bbd90@linux.alibaba.com>
 <YfFclROd+0/61q2d@FVFF77S0Q05N>
 <YfKGKWW5UfZ15kCW@FVFF77S0Q05N>
 <yt9dy231gzae.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dy231gzae.fsf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 01:04:41PM +0100, Sven Schnelle wrote:
> Mark Rutland <mark.rutland@arm.com> writes:
> 
> >> Isn't x86 relocatable in some configurations (e.g. for KASLR)?
> >> 
> >> I can't see how the sort works for those cases, because the mcount_loc entries
> >> are absolute, and either:
> >> 
> >> * The sorted entries will get overwritten by the unsorted relocation entries,
> >>   and won't be sorted.
> >> 
> >> * The sorted entries won't get overwritten, but then the absolute address will
> >>   be wrong since they hadn't been relocated.
> >> 
> >> How does that work?
> 
> From what i've seen when looking into this ftrace sort problem x86 has a
> a relocation tool, which is run before final linking: arch/x86/tools/relocs.c
> This tools converts all the required relocations to three types:
> 
> - 32 bit relocations
> - 64 bit relocations
> - inverse 32 bit relocations
> 
> These are added to the end of the image.
> 
> The decompressor then iterates over that array, and just adds/subtracts
> the KASLR offset - see arch/x86/boot/compressed/misc.c, handle_relocations()
> 
> So IMHO x86 never uses 'real' relocations during boot, and just
> adds/subtracts. That's why the order stays the same, and the compile
> time sort works.

Ah, so those non-ELF relocations for the mcount_loc table just mean "apply the
KASLR offset here", which is equivalent for all entries.

That makes sense, thanks!

Mark.
