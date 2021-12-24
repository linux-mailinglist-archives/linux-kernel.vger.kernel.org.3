Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4824047EA72
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 03:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350906AbhLXCFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 21:05:54 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:58451 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhLXCFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 21:05:53 -0500
Received: (Authenticated sender: joao@overdrivepizza.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPA id C46F620003;
        Fri, 24 Dec 2021 02:05:50 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 23 Dec 2021 18:05:50 -0800
From:   joao@overdrivepizza.com
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
In-Reply-To: <20211122170805.338489412@infradead.org>
References: <20211122170301.764232470@infradead.org>
 <20211122170805.338489412@infradead.org>
Message-ID: <6ebb0ab131c522f20c094294d49091fc@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-22 09:03, Peter Zijlstra wrote:
> Objtool based IBT validation in 3 passes:
> 
>  --ibt-fix-direct:
> 
>     Detect and rewrite any code/reloc from a JMP/CALL instruction
>     to an ENDBR instruction. This is basically a compiler bug since
>     neither needs the ENDBR and decoding it is a pure waste of time.
> 
>  --ibt:
> 
>     Report code relocs that are not JMP/CALL and don't point to ENDBR
> 
>     There's a bunch of false positives, for eg. static_call_update()
>     and copy_thread() and kprobes. But most of them were due to
>     _THIS_IP_ which has been taken care of with the prior annotation.
> 
>  --ibt-seal:
> 
>     Find and NOP superfluous ENDBR instructions. Any function that
>     doesn't have it's address taken should not have an ENDBR
>     instruction. This removes about 1-in-4 ENDBR instructions.
> 

I did some experimentation with compiler-based implementation for two of 
the features described here (plus an additional one). Before going into 
details, just a quick highlight that the compiler has limited visibility 
over handwritten assembly sources thus, depending on the feature, a 
compiler-based approach will not cover as much as objtool. All the 
observations below were made when compiling the kernel with defconfig, + 
CLANG-related options, + LTO sometimes. Here I used kernel revision 
0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1 with PeterZ's IBT Beginning 
patches applied on top (plus changes to Kbuild), thus, IBT was not 
really enforced. Tests consisted mostly of Clang's synthetics tests + 
booting a compiled kernel.

Prototypes of the features are available in: 
https://github.com/lvwr/llvm/tree/joao/ibt -- I fixed as many corner 
cases I could find while trying it out, but I believe some might still 
be haunting. Also, I'm not very keen to Kbuild internals nor to however 
the kernel patches itself during runtime, so I may have missed some 
details.

Finally, I'm interested in general feedback about this... better ways of 
implementing, alternative approaches, new possible optimizations and 
everything. I should be AFK for a few days in the next weeks, but I'll 
be glad to discuss this in January and then. Happy Holidays :)

The features:

-mibt-seal:

Add ENDBRs exclusively to address-taken functions regardless of its 
linkage visibility. Only make sense together with LTO.

Observations: Reduced drastically the number of ENDBRs placed in the 
kernel binary (From 44383 to 33192), but still missed some that were 
later fixed by objtool (Number of fixes by objtool reduced from 11730 to 
540). I did not investigate further why these superfluous ENDBRs were 
still left in the binary, but at this point my hypotheses spin around 
(i) false-positive address-taken conclusions by the compiler, possibly 
due to things like exported symbols and such; (ii) assembly sources 
which are invisible to the compiler (although this would more likely 
hide address taken functions); (iii) other binary level transformations 
done by objtool.

Runtime testing: The kernel was verified to properly boot after being 
compiled with -mibt-seal (+ LTO).

Note: This feature was already submitted for upstreaming with the 
llvm-project: https://reviews.llvm.org/D116070

-mibt-fix-direct:

Direct calls to functions which are known to have ENDBR instructions are 
fixed to target the first instruction after the ENDBR (+4 offset). Does 
not necessarily depend on LTO, but is meaningfully improved by it 
because it depends on after-linking stuff to successfully identify 
targets that will have ENDBRs (aliases and assembly functions are a big 
complication here, so this currently won't try to optimize calls to 
functions which exist in the compiler context as declarations).

Observations: I did a quick change on objtool to collect stats on the 
number of fixes applied. Without -mibt-fix-direct objtool had to fix 
227552 direct calls/jmps. Without LTO, -mibt-fix-direct reduced this 
number to 218455. With LTO this number was reduced to 1728.

Runtime testing: The kernel was verified to properly boot when compiled 
with -mibt-fix-direct both with and without LTO. I tried a more 
aggressive approach for non-LTO compilation, which was trying to 
optimize based on declarations (when functions were not visible) and 
noticed that in this scenario the kernel would crash very early in the 
boot process. I did not investigate further, but my hypothesis is that 
this approach mistakenly optimizes calls to assembly functions without 
ENDBRs, leading to random weirdness and doom.

-mibt-preceding-endbr:

Instead of placing ENDBRs after the function entry label, place it right 
before. Indirect calls are fixed (using a sub instr) to target 4 bytes 
before the function entry point. Address values which are reused after 
the indirect call are fixed back to their original value (using an add 
instr). Indirect calls that use in-memory pointers are transformed to 
first load the function pointer from memory into a free register, then 
do the sub, then call it. This does not depend on LTO.

Runtime testing: The runtime test was done using a kernel whose asm 
functions were not fixed regarding the position of ENDBRs. Yet, perhaps 
surprisingly, the kernel still boots when compiled with 
-mibt-preceding-endbr. I don't really know how many indirect calls to 
assembly functions happened, but I assume that these would have crashed 
if IBT was being enforced due to the misplaced ENDBRs (and it could also 
have crashed in these early tests due to indirect calls targeting 
unknown instruction 4 bytes before assembly functions, thus the surprise 
factor when I saw the kernel booting). Kernel booted alright with 
-mibt-preceding-endbr with and without LTO. CONFIG_RETPOLINE was 
disabled for testing this.
