Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDF749E31A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 14:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241562AbiA0NJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 08:09:01 -0500
Received: from foss.arm.com ([217.140.110.172]:60666 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241485AbiA0NJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 08:09:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78C161063;
        Thu, 27 Jan 2022 05:09:00 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.14.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 169AE3F766;
        Thu, 27 Jan 2022 05:08:58 -0800 (PST)
Date:   Thu, 27 Jan 2022 13:08:46 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Yinan Liu <yinan@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Sachin Sant <sachinp@linux.ibm.com>,
        linux-kernel@vger.kernel.org, ardb@kernel.org,
        keescook@chromium.org
Subject: Re: [powerpc] ftrace warning kernel/trace/ftrace.c:2068 with
 code-patching selftests
Message-ID: <YfKZXvB9vCN1bA1c@FVFF77S0Q05N>
References: <944D10DA-8200-4BA9-8D0A-3BED9AA99F82@linux.ibm.com>
 <e9422643-a210-b77f-a037-da63a9d2e925@linux.alibaba.com>
 <20220124114548.30241947@gandalf.local.home>
 <0fa0daec-881a-314b-e28b-3828e80bbd90@linux.alibaba.com>
 <YfFclROd+0/61q2d@FVFF77S0Q05N>
 <YfKGKWW5UfZ15kCW@FVFF77S0Q05N>
 <yt9dy231gzae.fsf@linux.ibm.com>
 <YfKPmFJ2MGsem4VB@FVFF77S0Q05N>
 <20220127074601.41a3773d@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127074601.41a3773d@rorschach.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 07:46:01AM -0500, Steven Rostedt wrote:
> On Thu, 27 Jan 2022 12:27:04 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > Ah, so those non-ELF relocations for the mcount_loc table just mean "apply the
> > KASLR offset here", which is equivalent for all entries.
> > 
> > That makes sense, thanks!
> 
> And this is why we were having such a hard time understanding each other ;-)

;)

With that in mind, I think that we understand that the build-time sort works
for:

* arch/x86, becuase the non-ELF relocations for mcount_loc happen to be
  equivalent.
 
* arch/arm, because there's no dynamic relocaiton and the mcount_loc entries
  have been finalized prior to sorting.

... but doesn't work for anyone else (including arm64) because the ELF
relocations are not equivalent, and need special care that is not yet
implemented.

So we should have arm and x86 opt-in, but for now everyone else (including
arm64, powerpc, s390) should be left with the prior behaviour with the runtime
sort only (in case the build-time sort breaks anything, as I mentioned in my
other mail).

Does that sound about right?

In future we might be able to do something much smarter (e.g. adding some
preprocessing to use relative entries).

I'll take a look at shelf. :)

Thanks,
Mark.

> I started a new project called "shelf", which is a shell interface to
> read ELF files (Shelf on a ELF!).
> 
> It uses my ccli library:
> 
>    https://github.com/rostedt/libccli
> 
> and can be found here:
> 
>    https://github.com/rostedt/shelf
> 
> Build and install the latest libccli and then build this with just
> "make".
> 
>   $ shelf vmlinux
> 
> and then you can see what is stored in the mcount location:
> 
>   shelf> dump symbol __start_mcount_loc - __stop_mcount_loc
> 
> I plan on adding more to include the REL and RELA sections and show how
> they affect symbols and such.
> 
> Feel free to contribute too ;-)
> 
> -- Steve
