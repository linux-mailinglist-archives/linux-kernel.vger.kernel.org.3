Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F66049EEDD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239508AbiA0XdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiA0XdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:33:17 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E24BC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:33:17 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id z131so3672594pgz.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pITh0ffjadrUQOaU2KwCuZyyLPNTIW84DGhaNVnbVqw=;
        b=Q7NtIHy4Hxp5NgKGxUh60134j+g5dctZA3EsK+hPi3Pe9Vp/2/wwA2Eob4c8d7J0I4
         ND1ViXWiZGyMdB+NDyuZZZX5vVc+QMiRVSjf6Gn1uchpPEFWIp/sZDKzTmyOgouUk/rX
         VQadx6vORLFxIz91QvmBcFE3M6yIaIO/SglMIGuoFP/4NUqZ5T9zc3N7Kn8n/h4uwHts
         zOYSS+ewSqKKAYiI2UPNooQFWu8QwqaCVhzMfiygHV7GQ0deAlGAvOVHEnSJp4I8Gbsv
         PmEctop8YVISDxI8rS7vFnvwGEjFyZlQS033mcz9hVbEdGnVIXmaohevHIuSp5n6Kq8e
         QZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pITh0ffjadrUQOaU2KwCuZyyLPNTIW84DGhaNVnbVqw=;
        b=MN/cWfm6f3vU4E/hd5E0h1gXCIuv4yLwZv62Fso1fcxH32eLvJW2PZGXljcALZqFNX
         J/Bmh3rw7Oa8/UvnTIR4vwa2x0bQX+Io88+rJp10Wn6fpMIjBZZZqx0zzhWvc8gNAnTR
         XMfFTjFNqFj1i/d0xCHBBmc2c1edEaGz6gs9ZjirNVs0oBy3GPSEcY3xLtoaZaDvK6Xz
         uEMnHd18ui7LJhdcOLAQsvBjn+fFiscx9dQ2kgmhMEPQwonZ01QFh9G8/A467qbVr5ds
         HELYkRFPLZsI6eT3xDZqHmbisEwkB7/ErJau2Cj92CqydjRDGP8HrY6h7B3OwurtiYPU
         BCvw==
X-Gm-Message-State: AOAM533l9K/kKtjqpwwrN/MK8zihw0N21cu4H0CuH+oWpGxXqMdFW45S
        eRYYG++AP8ty8/E+YP3yZfQyRA==
X-Google-Smtp-Source: ABdhPJwFU98JcQ0OAm4YbgoIGxfgDdE/Z28f64GtL1o7Gr6yY6tlbjG9r5yjHmX66IuBD9wFeMrOGA==
X-Received: by 2002:a05:6a00:a16:: with SMTP id p22mr5043763pfh.40.1643326396809;
        Thu, 27 Jan 2022 15:33:16 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q11sm3604085pfk.149.2022.01.27.15.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 15:33:16 -0800 (PST)
Date:   Thu, 27 Jan 2022 23:33:12 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, mark.rutland@arm.com,
        posk@posk.io, Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [RFC][PATCH v2 4/5] x86/uaccess: Implement
 unsafe_try_cmpxchg_user()
Message-ID: <YfMruK8/1izZ2VHS@google.com>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.852009966@infradead.org>
 <YfIAsHQv5Q84fOqO@google.com>
 <YfI9Y5l0fQAKuJav@google.com>
 <YfJsNcYNH8JTHrM/@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YfJsNcYNH8JTHrM/@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Nick

On Thu, Jan 27, 2022, Peter Zijlstra wrote:
> On Thu, Jan 27, 2022 at 06:36:19AM +0000, Sean Christopherson wrote:
> > On Thu, Jan 27, 2022, Sean Christopherson wrote:
> > > Doh, I should have specified that KVM needs 8-byte CMPXCHG on 32-bit kernels due
> > > to using it to atomically update guest PAE PTEs and LTR descriptors (yay).
> > > 
> > > Also, KVM's use case isn't a tight loop, how gross would it be to add a slightly
> > > less unsafe version that does __uaccess_begin_nospec()?  KVM pre-checks the address
> > > way ahead of time, so the access_ok() check can be omitted.  Alternatively, KVM
> > > could add its own macro, but that seems a little silly.  E.g. somethign like this,
> > > though I don't think this is correct
> > 
> > *sigh*
> > 
> > Finally realized I forgot to add back the page offset after converting from guest
> > page frame to host virtual address.  Anyways, this is what I ended up with, will
> > test more tomorrow.
> 
> Looks about right :-) (famous last words etc..)

And it was right, but clang-13 ruined the party :-/

clang barfs on asm goto with a "+m" input/output.  Change the "+m" to "=m" and
clang is happy.  Remove usage of the label, clang is happy.

I tried a bunch of different variants to see if anything would squeak by, but
clang found a way to die on everything I threw at it.

$ clang --version

  Debian clang version 13.0.0-9+build1
  Target: x86_64-pc-linux-gnu
  Thread model: posix
  InstalledDir: /usr/bin

As written, with a named label param, clang yields:

  $ echo 'int foo(int *x) { asm goto (".long (%l[bar]) - .\n": "+m"(*x) ::: bar); return *x; bar: return 0; }' | clang -x c - -c -o /dev/null
  <stdin>:1:29: error: invalid operand in inline asm: '.long (${1:l}) - .'
  int foo(int *x) { asm goto (".long (%l[bar]) - .\n": "+m"(*x) ::: bar); return *x; bar: return 0; }
                            ^
  <stdin>:1:29: error: unknown token in expression
  <inline asm>:1:9: note: instantiated into assembly here
          .long () - .
               ^
  2 errors generated.

While clang is perfectly happy switching "+m" to "=m":

  $ echo 'int foo(int *x) { asm goto (".long (%l[bar]) - .\n": "=m"(*x) ::: bar); return *x; bar: return 0; }' | clang -x c - -c -o /dev/null

Referencing the label with a numbered param yields either the original error:

  $ echo 'int foo(int *x) { asm goto (".long (%l1) - .\n": "+m"(*x) ::: bar); return *x; bar: return 0; }' | clang -x c - -c -o /dev/null
  <stdin>:1:29: error: invalid operand in inline asm: '.long (${1:l}) - .'
  int foo(int *x) { asm goto (".long (%l1) - .\n": "+m"(*x) ::: bar); return *x; bar: return 0; }
                            ^
  <stdin>:1:29: error: unknown token in expression
  <inline asm>:1:9: note: instantiated into assembly here
          .long () - .
                 ^
   2 errors generated.

Bumping the param number (more below) yields a different error (I tried defining
tmp1, that didn't work :-) ).

  $ echo 'int foo(int *x) { asm goto (".long (%l2) - .\n": "+m"(*x) ::: bar); return *x; bar: return 0; }' | clang -x c - -c -o /dev/null
  error: Undefined temporary symbol .Ltmp1
  1 error generated.

Regarding the param number, gcc also appears to have a goof with asm goto and "+m",
but bumping the param number in that case remedies its woes.

  $echo 'int foo(int *x) { asm goto (".long (%l1) - .\n": "+m"(*x) ::: bar); return *x; bar: return 0; }' | gcc -x c - -c -o /dev/null
  <stdin>: In function ‘foo’:
  <stdin>:1:19: error: invalid 'asm': '%l' operand isn't a label

  $ echo 'int foo(int *x) { asm goto (".long (%l2) - .\n": "+m"(*x) ::: bar); return *x; bar: return 0; }' | gcc -x c - -c -o /dev/null


So my immediate question: how do we want to we deal with this in the kernel?  Keeping
in mind that I'd really like to send this to stable@ to fix the KVM mess.

I can think of few options that are varying degrees of gross.

  1) Use a more complex sequence for probing CC_HAS_ASM_GOTO_OUTPUT.

  2) Use an output-only "=m" operand.

  3) Use an input register param.

Option #1 has the obvious downside of the fancier asm goto for  __get_user_asm()
and friends being collateral damage.  The biggest benefit is it'd reduce the
likelihood of someone else having to debug similar errors, which was quite painful.

Options #2 and #3 are quite gross, but I _think_ would be ok since the sequence
is tagged as clobbering memory anyways?
