Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2911532701
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 12:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbiEXKDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 06:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbiEXKDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 06:03:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 818BC72225
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 03:03:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F1441FB;
        Tue, 24 May 2022 03:03:35 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.3.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DBC63F66F;
        Tue, 24 May 2022 03:03:32 -0700 (PDT)
Date:   Tue, 24 May 2022 11:03:23 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, will@kernel.org
Subject: Re: [PATCH v2 03/13] stackleak: remove redundant check
Message-ID: <YoytaxHgqw5w1kIf@FVFF77S0Q05N>
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-4-mark.rutland@arm.com>
 <a604fa2b-e7c3-3fff-dd81-1a0585a9e2fa@linux.com>
 <YnpQqBwYjlVffJk8@FVFF77S0Q05N>
 <202205101958.2A33DE20@keescook>
 <YnttpThLX0tgrw5i@FVFF77S0Q05N>
 <33711C66-BB24-4A75-8756-3CDDA02BC0CD@chromium.org>
 <YnzQDWTw1qdtVJMJ@FVFF77S0Q05N>
 <8d8061c4-2a3e-cb3a-00c9-677fa8899058@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d8061c4-2a3e-cb3a-00c9-677fa8899058@linux.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2022 at 07:17:16PM +0300, Alexander Popov wrote:
> On 12.05.2022 12:14, Mark Rutland wrote:
> > On Wed, May 11, 2022 at 07:44:41AM -0700, Kees Cook wrote:
> > > 
> > > 
> > > On May 11, 2022 1:02:45 AM PDT, Mark Rutland <mark.rutland@arm.com> wrote:
> > > > On Tue, May 10, 2022 at 08:00:38PM -0700, Kees Cook wrote:
> > > > > On Tue, May 10, 2022 at 12:46:48PM +0100, Mark Rutland wrote:
> > > > > > On Sun, May 08, 2022 at 09:17:01PM +0300, Alexander Popov wrote:
> > > > > > > On 27.04.2022 20:31, Mark Rutland wrote:
> > > > > > > > In __stackleak_erase() we check that the `erase_low` value derived from
> > > > > > > > `current->lowest_stack` is above the lowest legitimate stack pointer
> > > > > > > > value, but this is already enforced by stackleak_track_stack() when
> > > > > > > > recording the lowest stack value.
> > > > > > > > 
> > > > > > > > Remove the redundant check.
> > > > > > > > 
> > > > > > > > There should be no functional change as a result of this patch.
> > > > > > > 
> > > > > > > Mark, I can't agree here. I think this check is important.
> > > > > > > The performance profit from dropping it is less than the confidence decrease :)
> > > > > > > 
> > > > > > > With this check, if the 'lowest_stack' value is corrupted, stackleak doesn't
> > > > > > > overwrite some wrong kernel memory, but simply clears the whole thread
> > > > > > > stack, which is safe behavior.
> > > > > > 
> > > > > > If you feel strongly about it, I can restore the check, but I struggle to
> > > > > > believe that it's worthwhile. The `lowest_stack` value lives in the
> > > > > > task_struct, and if you have the power to corrupt that you have the power to do
> > > > > > much more interesting things.
> > > > > > 
> > > > > > If we do restore it, I'd like to add a big fat comment explaining the
> > > > > > rationale (i.e. that it only matter if someone could corrupt
> > > > > > `current->lowest_stack`, as otherwise that's guarnateed to be within bounds).
> > > > > 
> > > > > Yeah, let's restore it and add the comment. While I do agree it's likely
> > > > > that such an corruption would likely mean an attacker had significant
> > > > > control over kernel memory already, it is not uncommon that an attack
> > > > > only has a limited index from a given address, etc. Or some manipulation
> > > > > is possible via weird gadgets, etc. It's unlikely, but not impossible,
> > > > > and a bounds-check for that value is cheap compared to the rest of the
> > > > > work happening. :)
> > > > 
> > > > Fair enough; I can go spin a patch restoring this. I'm somewhat unhappy with
> > > > silently fixing that up, though -- IMO it'd be better to BUG() or similar in
> > > > that case.
> > > 
> > > I share your desires, and this was exactly what Alexander originally proposed, but Linus rejected it violently. :(
> > > https://lore.kernel.org/lkml/CA+55aFy6jNLsywVYdGp83AMrXBo_P-pkjkphPGrO=82SPKCpLQ@mail.gmail.com/
> > 
> > I see. :/
> > 
> > Thinking about this some more, if we assume someone can corrupt *some* word of
> > memory, then we need to consider that instead of corrupting
> > task_struct::lowest_stack, they could corrupt task_struct::stack (or x86's
> > cpu_current_top_of_stack prior to this series).
> > 
> > With that in mind, if we detect that task_struct::lowest_stack is
> > out-of-bounds, we have no idea whether it has been corrupted or the other bound
> > values have been corrupted, and so we can't do the erase safely anyway.
> 
> :)
> 
> IMO, even if a kernel thread stack is moved somewhere for any weird reason,
> stackleak must erase it at the end of syscall and do its job.

I'm not talking about the stack being *moved*. I'm talking about the pointers
to it being *corrupted* (wince we use those to determine the bounds).

The problem is that we don't have a single source of truth here that we can
rely upon. 

We're stuck between a dichotomy:

* If we assume an attacker *can* corrupt a word of memory, they can corrupt any
  of the in-memory values we use to find the stack in the first place. If we
  detect a mismatch we cannot know which is bad, and if the attacker can
  corrupt the one(s) we choose to blindly trust, then they can weaponize the
  erasing code to corrupt memory.

  That's *worse* than the info leak problem stackleak was originally trying to
  solve.

  See below for one way we could avoid that.

* If we assume the attacker *cannot* corrupt a word of memory, then we know the
  values must always be within bounds, and there's no need for the check.

> > So AFAICT we must *avoid* erasing when that goes wrong. Maybe we could WARN()
> > instead of BUG()?
> 
> Mark, I think security features must not go out of service.
>
> The 'lowest_stack' value is for making stackleak faster. I believe if the
> 'lowest_stack' value is invalid, stackleak must not skip its main job and
> should erase the whole kernel thread stack.

My point is that the conditions which permit `lowest_stack` to become invalid
(e.g. an attacker having an arbitrary or constrained write gadget) also permit
all the other stack boundariy values to become invalid.

If we detect `lowest_stack` is out of bounds, we have no idea which of
`lowest_stack` or the bounds are corrupt -- so we *cannot* safely erase: if the
bounds are corrupt we'll corrupt arbitrary memory.

We *could* do better by always deriving the bounds from an SP value (current
for on-stack, passed in by asm for off-stack). If we did that, we could more
reasonably treat the bounds values as more reliable than the `lowest_stack`
value, and with that I'd be happy with the bounds check (though I still think
we want to make this WARN()).

> When I developed 'stackleak_erase()' I tried adding 'WARN_ON()', but it
> didn't work properly there, as I remember. Warning handling code is very
> complex. So I dropped that fragile part.

Do you recall any specific problem, or just that there were problems?

I ask because the entry code, and handling of BUG() and WARN() has changed
quite a bit over the last couple of years. We've fixed some latent issues
there, though IIUC this late in the exception return flow there are still some
potential issues with the RCU/lockdep/etc context that would need to be
saved/restored.

We need to solve some of that in general anyuway, since there are other BUG()
and WARN() instances hidden in noinstr entry code. I'm happy to dig into that
(time permitting).

Thanks,
Mark.
