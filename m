Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F400049318B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 01:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350339AbiASADj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 19:03:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34855 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350331AbiASADi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 19:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642550618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tVYvA6k75j8gln9tRsgy3BBh8Hq7EurwC1H6Kup6Uac=;
        b=g3EcQiM/e/lFDvp0/Sivwfg5+r0TS+z1CTV5i/rhLmnfMRhAXcuMHwi/ScFfJZ/tDVtJ96
        5iISZKg62zXx624F1McbTyN8gR4S5iDPSa1L+aYrNgHh5LOEOOTnfZI12tyN7Dksu3TBmx
        mRbpFztR//CuHPu8g4FOPQzbMW65i94=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-DYXUu7DRMnSdBs1LlpSNUg-1; Tue, 18 Jan 2022 19:03:36 -0500
X-MC-Unique: DYXUu7DRMnSdBs1LlpSNUg-1
Received: by mail-oi1-f200.google.com with SMTP id d205-20020aca36d6000000b002c890f38d80so554486oia.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 16:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tVYvA6k75j8gln9tRsgy3BBh8Hq7EurwC1H6Kup6Uac=;
        b=v82AMBrdFYVbuv0nfwCZVlOHhS+h/mnxQvl3syjjMPAUmlVUoZe+TebvAW6JGKe9fa
         t7v6IdIu3WjglzikqN6P3XsvX8BLG6jv98gamwOWjs8cXBF8NcaSc12t79PZ+npODvbj
         1byizjUsZFH7Vs1VOSzZmpZFlQdg80zzQWzYH7Nmr3KITBkhffYrAFKCUO7QZYCRIwvG
         162eo1KBkNoLkwZJKWQEOh9GMB8uSiAQwahdBeqo2+ce9/NzlAtfXfOon0RV3mtqUxqm
         iCuvZUwWQUpQ/8CFw0RiZUEUru2cGKwJwqQF4XuOOYpA+F9tDBa2XT+1uxUixmcYTXp3
         xmJA==
X-Gm-Message-State: AOAM530UXCXY9RxDavCRUzXwUsZSL/xYk5qcB4pxd4rutfaD97z7mj8I
        2vMUphyhquAhzk/nNub9OQIoNaidVDTRGUFATnKGrITRMa+kgfDxqraekdex7OC2wciAS2FHzz5
        LXaoB1dPN7Q2jHf+/oxyoC8lm
X-Received: by 2002:a05:6830:2785:: with SMTP id x5mr22537881otu.187.1642550616005;
        Tue, 18 Jan 2022 16:03:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFSVupUWPVUpDZy728lBKKhw+a+1HU1Pevbh8pLavUmbWJOKEDeq0ntl5K4b6WWPcLn98w6Q==
X-Received: by 2002:a05:6830:2785:: with SMTP id x5mr22537853otu.187.1642550615767;
        Tue, 18 Jan 2022 16:03:35 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::c])
        by smtp.gmail.com with ESMTPSA id ay40sm9106563oib.1.2022.01.18.16.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 16:03:35 -0800 (PST)
Date:   Tue, 18 Jan 2022 16:03:27 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        x86@kernel.org, llvm@lists.linux.dev, linux-sparse@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] objtool: prefer memory clobber & %= to volatile &
 __COUNTER__
Message-ID: <20220119000327.oapghqad4lebnsra@treble>
References: <20220114010526.1776605-1-ndesaulniers@google.com>
 <YeQei0xNzMq7bFdg@zn.tnic>
 <20220118192256.jzk5dnceeusq7x7u@treble>
 <20220118230120.pivvson7qekfiqic@treble>
 <YedOLva0zos3A1JE@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YedOLva0zos3A1JE@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 12:33:02AM +0100, Borislav Petkov wrote:
> On Tue, Jan 18, 2022 at 03:01:20PM -0800, Josh Poimboeuf wrote:
> > With the two WARN_ONs in media_request_object_complete(), GCC apparently
> > considers the two reachable() asm statements as duplicates, and it
> > removes the second one.
> 
> Could that be the same thing:
> 
> net/xfrm/xfrm_output.o: warning: objtool: xfrm_output_resume()+0x2e0: unreachable instruction
> 
> I see two WARN_ONs in asm output there too...

If one of the '__bug_table' asm snippets isn't immediately followed by
the .L[un]reachable asm, then yeah, it's the same issue.


For example it's supposed to look something like this:


# 472 "net/xfrm/xfrm_output.c" 1
	1:	.byte 0x0f, 0x0b
.pushsection __bug_table,"aw"
2:	.long 1b - 2b	# bug_entry::bug_addr
	.long .LC4 - 2b	# bug_entry::file	#
	.word 472	# bug_entry::line	#
	.word 2307	# bug_entry::flags	#
	.org 2b+12	#
.popsection
# 0 "" 2
# 472 "net/xfrm/xfrm_output.c" 1
	.Lreachable1666:
	.pushsection .discard.reachable
	.long .Lreachable1666 - .
	.popsection


NOT just this:


# 472 "net/xfrm/xfrm_output.c" 1
	1:	.byte 0x0f, 0x0b
.pushsection __bug_table,"aw"
2:	.long 1b - 2b	# bug_entry::bug_addr
	.long .LC4 - 2b	# bug_entry::file	#
	.word 472	# bug_entry::line	#
	.word 2307	# bug_entry::flags	#
	.org 2b+12	#
.popsection
# some other code here...


There's a bunch of those throughout the code base.  The current
annotate_[un]reachable() implementations are carefully written to avoid
that happening.

-- 
Josh

