Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4BA522DD0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243267AbiEKIDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239763AbiEKIDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:03:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC22A8B085
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:03:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DEC8106F;
        Wed, 11 May 2022 01:03:00 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.3.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8E5C3F73D;
        Wed, 11 May 2022 01:02:58 -0700 (PDT)
Date:   Wed, 11 May 2022 09:02:45 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, will@kernel.org
Subject: Re: [PATCH v2 03/13] stackleak: remove redundant check
Message-ID: <YnttpThLX0tgrw5i@FVFF77S0Q05N>
References: <20220427173128.2603085-1-mark.rutland@arm.com>
 <20220427173128.2603085-4-mark.rutland@arm.com>
 <a604fa2b-e7c3-3fff-dd81-1a0585a9e2fa@linux.com>
 <YnpQqBwYjlVffJk8@FVFF77S0Q05N>
 <202205101958.2A33DE20@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202205101958.2A33DE20@keescook>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 08:00:38PM -0700, Kees Cook wrote:
> On Tue, May 10, 2022 at 12:46:48PM +0100, Mark Rutland wrote:
> > On Sun, May 08, 2022 at 09:17:01PM +0300, Alexander Popov wrote:
> > > On 27.04.2022 20:31, Mark Rutland wrote:
> > > > In __stackleak_erase() we check that the `erase_low` value derived from
> > > > `current->lowest_stack` is above the lowest legitimate stack pointer
> > > > value, but this is already enforced by stackleak_track_stack() when
> > > > recording the lowest stack value.
> > > > 
> > > > Remove the redundant check.
> > > > 
> > > > There should be no functional change as a result of this patch.
> > > 
> > > Mark, I can't agree here. I think this check is important.
> > > The performance profit from dropping it is less than the confidence decrease :)
> > > 
> > > With this check, if the 'lowest_stack' value is corrupted, stackleak doesn't
> > > overwrite some wrong kernel memory, but simply clears the whole thread
> > > stack, which is safe behavior.
> > 
> > If you feel strongly about it, I can restore the check, but I struggle to
> > believe that it's worthwhile. The `lowest_stack` value lives in the
> > task_struct, and if you have the power to corrupt that you have the power to do
> > much more interesting things.
> > 
> > If we do restore it, I'd like to add a big fat comment explaining the
> > rationale (i.e. that it only matter if someone could corrupt
> > `current->lowest_stack`, as otherwise that's guarnateed to be within bounds).
> 
> Yeah, let's restore it and add the comment. While I do agree it's likely
> that such an corruption would likely mean an attacker had significant
> control over kernel memory already, it is not uncommon that an attack
> only has a limited index from a given address, etc. Or some manipulation
> is possible via weird gadgets, etc. It's unlikely, but not impossible,
> and a bounds-check for that value is cheap compared to the rest of the
> work happening. :)

Fair enough; I can go spin a patch restoring this. I'm somewhat unhappy with
silently fixing that up, though -- IMO it'd be better to BUG() or similar in
that case.

Thanks,
Mark.
