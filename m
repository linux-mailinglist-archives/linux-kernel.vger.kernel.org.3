Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1D350AC0F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 01:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442624AbiDUXnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 19:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbiDUXnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 19:43:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D34DEC1;
        Thu, 21 Apr 2022 16:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0E3BB82936;
        Thu, 21 Apr 2022 23:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B228C385A5;
        Thu, 21 Apr 2022 23:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650584413;
        bh=r+B+a9qe9EGZlPpgDWEZE6L+yz+T/1PvmPc0KaKhDYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sobvn5CG7XBpSKCjyxvscvOwImJG/D8eqprsf19Qhp+zHZhtwyvjrRsMUr9w/5uzc
         ucQgCgpFJVsz0QYzvQh8lWjF0OXMP+vDCAfUDgm070ndKhYvGkD6n2zqmrLJBCGzt5
         AJD2jDjHglKV6jfpISWIu8ZmxjRszam9eh7BTdv0n7SKBeRNhbHspp886URJ1muxMT
         GQZY7BxqP9e+bVlZ0Q56bER4HSemcEwOHYWJfMFtGjitT4xB8sF+Mrm3NeMFBhW00P
         PuXSnEODDXKK9ycqkvtIVwT7jT9zA1C7p/sFzWGygc0b4+rttXEG2D+Lw9Vsq7dfTw
         4jztugeDkfg/Q==
Date:   Thu, 21 Apr 2022 16:40:11 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] siphash: update the HalfSipHash documentation
Message-ID: <YmHrWy2o72k2cFLM@sol.localdomain>
References: <20220421204320.258010-1-ebiggers@kernel.org>
 <CAHmME9rtrjyE0Cqk9qvW_xxhFduvbMt5-cmjD134JCxk2iLKDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9rtrjyE0Cqk9qvW_xxhFduvbMt5-cmjD134JCxk2iLKDQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 01:08:01AM +0200, Jason A. Donenfeld wrote:
> Hi Eric,
> 
> On Thu, Apr 21, 2022 at 10:44 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > -Danger!
> > +**Danger!** HalfSipHash should only be used in a very limited set of use cases
> > +where nothing better is possible, namely:
> >
> > -Do not ever use HalfSipHash except for as a hashtable key function, and only
> > -then when you can be absolutely certain that the outputs will never be
> > -transmitted out of the kernel. This is only remotely useful over `jhash` as a
> > -means of mitigating hashtable flooding denial of service attacks.
> > +- Hashtable key functions, where the outputs will never be transmitted out of
> > +  the kernel. This is only remotely useful over `jhash` as a means of mitigating
> > +  hashtable flooding denial of service attacks.
> 
> I think we should actually drop this chunk of the patch. You wrote in
> your commit message, "HalfSipHash-1-3 is not entirely limited to
> hashtable functions, with it now being used in the interrupt entropy
> accumulator." But in fact, random.c uses HalfSipHash-1, with no three
> round finalization (since we use BLAKE2s for that). So it's not
> _quite_ the same thing. If it were, we could have gotten away by just
> calling the actual hsiphash function, but instead it's just applying
> the round function as a permutation.
> 
> If you feel strongly that somebody might accidentally copy and paste
> that after grepping for halfsiphash and trying to figure out how to
> use it, I suppose we could keep this. But it strikes me as very much
> not the same thing as the hsiphash_* family of functions.

Well, this documentation starts out by introducing HalfSipHash, and then moves
on to the the hsiphash functions.  This part is still talking about HalfSipHash,
so in that context the mention of its use in random.c is relevant.  But I could
certainly reword it to make it all about the hsiphash functions, with
HalfSipHash being mentioned more as an implementation detail.

- Eric
