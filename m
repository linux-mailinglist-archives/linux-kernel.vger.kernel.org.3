Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C074EE04C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbiCaSXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiCaSXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:23:32 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C373A1E533F;
        Thu, 31 Mar 2022 11:21:43 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22VILc1V023698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 14:21:38 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0F7B715C003E; Thu, 31 Mar 2022 14:21:38 -0400 (EDT)
Date:   Thu, 31 Mar 2022 14:21:38 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Michael Brooks <m@sweetwater.ai>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v2] random: mix build-time latent entropy into pool at
 init
Message-ID: <YkXxMpAW+rZd+Wyx@mit.edu>
References: <20220331150706.124075-1-Jason@zx2c4.com>
 <20220331152641.169301-1-Jason@zx2c4.com>
 <CAOnCY6Sv1goLQMJkvjsVb+TGdowUk6_vQ4ELQ_GkHu8Wjs3PAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOnCY6Sv1goLQMJkvjsVb+TGdowUk6_vQ4ELQ_GkHu8Wjs3PAA@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 09:02:27AM -0700, Michael Brooks wrote:
> mix_pool_bytes() has numerous problems, as discussed in prior emails.
> Do we still want to be putting so much effort into a development dead
> end?

Michael, with respect, there were a number of things in your analysis
which simply didn't make any sense.  Discussing it on an e-mail thread
relating to stable bacports wasn't the right place, so I didn't extend
the discussion there.

You believe that max_pool_bytes() has numerous problems.  That's not
the same thing as it having problems.

And making incremental changes, with code review, is the much better
approach than just doing a rip-and-replace with some something else
--- which might have different, even more exciting problems.

Something for you to consider, since your comments seem to indicate
that you are not familiar with the full random driver design.  There
are two halves to how the random driver works.  The first half is the
collection of entropy, and the priamry way this is accomplished is by
taking timestamps of various events that an external attacker
hopefully won't have access to.  For example, keystrokes from the
user, mouse motion events, network and disk interrupts, etc.  Where
possible, we don't just use jiffies, but we also use high preceision
counters, such as the CPU counter.  The idea here is that even if the
external interrupts sources can be seen by an attacker, when the
interrupt is serviced when measured by a high precision cycle counter
(for example) is not going to be as easily guessed.  That being said,
we only get a tiny amount of entropy (by which I mean uncertainty by
the attacker) out of each event.  This is why it is important to
distill it in an input pool, so that as we add more and more
unpredictable inputs into the pool, it becomes less and less tractible
for the attacker to make educating guesses about what is in the pool.

Then periodically (and doing this periodically is important, because
we want to wait until there we have a large amount of uncertainty with
respect to the attacker accumulated in the pool) we extract from the
input pool and use that to reseed the second part of the random
driver, which is used to be called the "output pool".

It used to be that both the input pool and output pool were literally
bitpools that were mixed using an LFSR scheme, and then extracted
using cryptographic hash.

The output pool is now a ChaCha-based CRNG, and most recently the
"input pool" is a accumulating entropy using a Blake2 hash.  So in
many ways, the term "input pool" is a bit of a misnomer now, and
perhaps should be renamed.

For more information, I direct you to the Yarrow paper[1].  The basic
idea of using two pools coupled with a catastrophic reseed was
shamelessly stolen from Bruce Schneier's work.

[1] https://www.schneier.com/wp-content/uploads/2016/02/paper-yarrow.pdf

Are there reasons why we didn't just implement Yarrow?  That's because
/dev/random predates Yarrow, and we made incremental changes to adopt
("steal") good ideas from other sources, which hopefully don't
invalidate previous analysis and reviews about /dev/random.  Please
note that there are a number of academic researches who have published
peer previews of /dev/random, and that is incredibly useful.

We've made changes over time to improve /dev/random and to addresses
various theoretical weaknesses noted by these academic reviewers.  So
when you claim that there are "numerous problems" with the input pool,
I'll have to note that /dev/random has undergone reviews by
cryptographers, and they have not identified the problems that you
claim are there.

Regards,

						- Ted
