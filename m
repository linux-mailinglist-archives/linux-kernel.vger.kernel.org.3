Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3E650930C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345803AbiDTWoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359233AbiDTWn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:43:58 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B0633E16;
        Wed, 20 Apr 2022 15:40:47 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPA id AA7401BF204;
        Wed, 20 Apr 2022 22:40:41 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 20 Apr 2022 15:40:41 -0700
From:   Joao Moreira <joao@overdrivepizza.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, hjl.tools@gmail.com,
        Fangrui Song <maskray@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        andrew.cooper3@citrix.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@linux.intel.com, gabriel.gomes@linux.intel.com,
        rick.p.edgecombe@intel.com
Subject: Re: [RFC PATCH 00/11] Kernel FineIBT Support
In-Reply-To: <CAKwvOdm6J9TFUWJA2Q7VRjx1CpBme9z_Dp99+7YTjN5Jqp5=Aw@mail.gmail.com>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
 <20220420074044.GC2731@worktop.programming.kicks-ass.net>
 <20220420151714.fderdz4dzea75rvg@treble>
 <CAKwvOdm6J9TFUWJA2Q7VRjx1CpBme9z_Dp99+7YTjN5Jqp5=Aw@mail.gmail.com>
Message-ID: <bf3273120d8d48a79357f229c5890576@overdrivepizza.com>
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

>> 
>> If FineIBT needs it, I could reconsider.  But I think there's a strong
>> case to be made that the linker should be doing that instead.
> 
> That sounds reasonable to me (and reminds me of linker relaxation).
> Joao, can you please work with Fangrui (LLD) and HJ (GNU binutils) to
> determine how feasible this would be? I assume code outside the kernel
> might enjoy such an optimization, too.  When that's the case, then it
> probably makes more sense to "upstream" such "optimizations" from the
> kernel-specific objtool into the toolchains.

Alright, these are the greenlights I was hoping for.

I went quickly into this with HJ and he mentioned that it should be 
doable in the linker, and that he has a patch for it in gcc (for local 
function, from what I could see): 
https://gcc.gnu.org/pipermail/gcc-patches/2022-February/590832.html

If @Fangrui is fine with it, I would like to try implementing this 
myself in lld (I'm still learning a lot about lld and having an actual 
problem to solve is the kind of fuel I need). Should take me a while, 
but I think this is not urgent, right? I can also go ahead and replicate 
HJ's gcc patch into clang, so we can also handle the local functions 
within the compiler (I think this makes a lot of sense).

Once we have these in, I'll revisit FineIBT and extend the features to 
handle the FineIBT instrumentation. Hopefully we'll be released from 
needing objtool (famous last words?!).

This sounds like a plan, but I'm ofc open to suggestions or different 
ideas/plans.

Tks,
Joao
