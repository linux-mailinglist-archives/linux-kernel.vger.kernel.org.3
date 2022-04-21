Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D412650A3F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390017AbiDUP0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389997AbiDUP0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:26:03 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA033F31A;
        Thu, 21 Apr 2022 08:23:13 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id A4749100002;
        Thu, 21 Apr 2022 15:23:08 +0000 (UTC)
MIME-Version: 1.0
Date:   Thu, 21 Apr 2022 08:23:08 -0700
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, hjl.tools@gmail.com,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        andrew.cooper3@citrix.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@linux.intel.com, gabriel.gomes@linux.intel.com,
        rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 00/11] Kernel FineIBT Support
In-Reply-To: <20220421074920.GK2731@worktop.programming.kicks-ass.net>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420074044.GC2731@worktop.programming.kicks-ass.net>
 <20220420151714.fderdz4dzea75rvg@treble>
 <CAKwvOdm6J9TFUWJA2Q7VRjx1CpBme9z_Dp99+7YTjN5Jqp5=Aw@mail.gmail.com>
 <bf3273120d8d48a79357f229c5890576@overdrivepizza.com>
 <20220421074920.GK2731@worktop.programming.kicks-ass.net>
Message-ID: <643dac8c3ccb0720b4a8e67a472b08de@overdrivepizza.com>
X-Sender: joao@overdrivepizza.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-21 00:49, Peter Zijlstra wrote:
> On Wed, Apr 20, 2022 at 03:40:41PM -0700, Joao Moreira wrote:
>> > >
>> > > If FineIBT needs it, I could reconsider.  But I think there's a strong
>> > > case to be made that the linker should be doing that instead.
>> >
>> > That sounds reasonable to me (and reminds me of linker relaxation).
>> > Joao, can you please work with Fangrui (LLD) and HJ (GNU binutils) to
>> > determine how feasible this would be? I assume code outside the kernel
>> > might enjoy such an optimization, too.  When that's the case, then it
>> > probably makes more sense to "upstream" such "optimizations" from the
>> > kernel-specific objtool into the toolchains.
>> 
>> Alright, these are the greenlights I was hoping for.
>> 
>> I went quickly into this with HJ and he mentioned that it should be 
>> doable
>> in the linker, and that he has a patch for it in gcc (for local 
>> function,
>> from what I could see):
>> https://gcc.gnu.org/pipermail/gcc-patches/2022-February/590832.html
>> 
>> If @Fangrui is fine with it, I would like to try implementing this 
>> myself in
>> lld (I'm still learning a lot about lld and having an actual problem 
>> to
>> solve is the kind of fuel I need). Should take me a while, but I think 
>> this
>> is not urgent, right? I can also go ahead and replicate HJ's gcc patch 
>> into
>> clang, so we can also handle the local functions within the compiler 
>> (I
>> think this makes a lot of sense).
>> 
>> Once we have these in, I'll revisit FineIBT and extend the features to
>> handle the FineIBT instrumentation. Hopefully we'll be released from 
>> needing
>> objtool (famous last words?!).
>> 
>> This sounds like a plan, but I'm ofc open to suggestions or different
>> ideas/plans.
> 
> So trivially the plan sounds like: compiler fixes STB_LOCAL because it
> has the scope, and the linker fixes everything else. However, that 
> seems
> to assume that !STB_LOCAL will have ENDBR.
> 
> This latter isn't true; for one there's __attribute__((nocf_check)) 
> that
> can be used to suppress ENDBR generation on a function.
> 
> Alternatively the linker will need to 'read' the function to determine
> if it has ENDBR, or we need to augment the ELF format such that we can
> tell from that.
> 
> So what exactly is the plan?

I ran into too many broken dreams by trying to infer the presence of 
ENDBRs just by the symbol locality/linkage... not only because of the 
attribute, but also because of ancient assembly.

So, my first thought was to use something similar to the 
__patchable_function_entries section 
(https://man7.org/linux/man-pages/man1/gcc.1.html), where we would have 
a section to mark all the placed ENDBR. But then it occurred to me that 
if we follow that road we'll miss the ENDBR placed in assembly unless we 
mark it manually, so I started thinking that reading the target 
instructions from the ELF object could be a more simplified approach, 
although a little more treacherous.

I didn't decide yet what to try first -- any thoughts?

@Fangrui's and @HJ's thoughts about this could be gold.
