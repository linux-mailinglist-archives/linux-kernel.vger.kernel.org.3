Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8891E5703DB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbiGKNJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiGKNJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:09:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7E421E16
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:08:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 04E9C2032C;
        Mon, 11 Jul 2022 13:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657544938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LXJV6Ro7QK4Kg3M8IFFDmUrFwW9Xqt0bYHpGMudRffk=;
        b=XHvYmBFSWZpBj3OgsDShY0I9WDSekX7E4saKXTUJDoUIwqF5KfqAKZOAqWb2uAskekmW2m
        aVqAgYgElp/0z+RGj7/dTFdJZ7z3q1JdNWM0xO21hNy9FPLH/vw/LQXwZctN7dt3AtUM+c
        qOJpzIsg1SfZCJ02DEGfeefbc9RJtwg=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D6B4A2C143;
        Mon, 11 Jul 2022 13:08:57 +0000 (UTC)
Date:   Mon, 11 Jul 2022 15:08:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jia He <justin.he@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH RFCv4 3/4] lib/test_printf.c: split write-beyond-buffer
 check in two
Message-ID: <Yswg5/eJXVl2/AxP@alley>
References: <20210615154952.2744-1-justin.he@arm.com>
 <20210615154952.2744-4-justin.he@arm.com>
 <YMtZcVy4gvmMtYv+@alley>
 <d0798b26-9c77-7209-8c16-0d067ea5720c@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0798b26-9c77-7209-8c16-0d067ea5720c@rasmusvillemoes.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-06-17 09:15:53, Rasmus Villemoes wrote:
> On 17/06/2021 16.17, Petr Mladek wrote:
> > On Tue 2021-06-15 23:49:51, Jia He wrote:
> >> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >>
> >> Before each invocation of vsnprintf(), do_test() memsets the entire
> >> allocated buffer to a sentinel value. That buffer includes leading and
> >> trailing padding which is never included in the buffer area handed to
> >> vsnprintf (spaces merely for clarity):
> >>
> >>   pad  test_buffer      pad
> >>   **** **************** ****
> >>
> >> Then vsnprintf() is invoked with a bufsize argument <=
> >> BUF_SIZE. Suppose bufsize=10, then we'd have e.g.
> >>
> >>  |pad |   test_buffer    |pad |
> >>   **** pizza0 **** ****** ****
> >>  A    B      C    D           E
> >>
> >> where vsnprintf() was given the area from B to D.
> >>
> >> It is obviously a bug for vsnprintf to touch anything between A and B
> >> or between D and E. The former is checked for as one would expect. But
> >> for the latter, we are actually a little stricter in that we check the
> >> area between C and E.
> >>
> >> Split that check in two, providing a clearer error message in case it
> >> was a genuine buffer overrun and not merely a write within the
> >> provided buffer, but after the end of the generated string.
> >>
> >> So far, no part of the vsnprintf() implementation has had any use for
> >> using the whole buffer as scratch space, but it's not unreasonable to
> >> allow that, as long as the result is properly nul-terminated and the
> >> return value is the right one. However, it is somewhat unusual, and
> >> most %<something> won't need this, so keep the [C,D] check, but make
> >> it easy for a later patch to make that part opt-out for certain tests.
> > 
> > Excellent commit message.
> > 
> >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >> Tested-by: Jia He <justin.he@arm.com>
> >> Signed-off-by: Jia He <justin.he@arm.com>
> > 
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Hi Petr
> 
> It seems Justin's series got stalled, but I still think this patch makes
> sense on its own (especially since another series in flight mucks about
> in this area), so can you please pick it up directly?

I have just committed this patch into printk/linux.git, branch for-5.20.

I am sorry that it took so long. Too many things have happened during
last weeks.

Best Regards,
Petr
