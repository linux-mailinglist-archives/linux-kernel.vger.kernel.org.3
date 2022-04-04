Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B673D4F204B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 01:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiDDXgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 19:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiDDXgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:36:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E6813EB7;
        Mon,  4 Apr 2022 16:34:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98A43B81A12;
        Mon,  4 Apr 2022 23:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F290C2BBE4;
        Mon,  4 Apr 2022 23:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649115243;
        bh=eyAsMKYGzvH+3OrgXnEs+25VO7XTUXzbVRM181PAF5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eh2BN5YS5fjaSbHOqWp41DWSblIIt/lekO/Z/1O6HKNmGiF5IWQXxVme0XUwPkRPv
         pawsPW+56uspMKlkm+7O+ogN6DC0h2iPHD3D1UgUvWEg1ZxvhiuEGMCZb54YD8NlG+
         5sDNJnUwcfyPShs5oL8e4ryBW/WwUfu/uwofE2neiFuz8gymutRaZhIH0+B9/Uc3Y5
         Gcu8/PrKrz+fRPQGInplyt2Eo6kO1XrwNOvkdljXSihi2o6L4DXo2zwCgF+AZvvR68
         JZeqJDK0d9Q2J24LBQxG5eIwgbXc8oMJJQcZiO60Dk7oqoeUWKjCXg4MgAaG651P3t
         Kjl/GGM1oeDdw==
Date:   Mon, 4 Apr 2022 16:34:01 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: testmgr - test in-place en/decryption with two
 sglists
Message-ID: <YkuAaabISmyqcjoS@sol.localdomain>
References: <20220326071159.56056-1-ebiggers@kernel.org>
 <CAOtvUMfpqxrdgmnzpkCW=EdUmquXYC6F=rwW+n8koJAt0Wg38g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOtvUMfpqxrdgmnzpkCW=EdUmquXYC6F=rwW+n8koJAt0Wg38g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2022 at 09:04:43AM +0300, Gilad Ben-Yossef wrote:
> On Sat, Mar 26, 2022 at 10:13 AM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > From: Eric Biggers <ebiggers@google.com>
> >
> > As was established in the thread
> > https://lore.kernel.org/linux-crypto/20220223080400.139367-1-gilad@benyossef.com/T/#u,
> > many crypto API users doing in-place en/decryption don't use the same
> > scatterlist pointers for the source and destination, but rather use
> > separate scatterlists that point to the same memory.  This case isn't
> > tested by the self-tests, resulting in bugs.
> >
> > This is the natural usage of the crypto API in some cases, so requiring
> > API users to avoid this usage is not reasonable.
> >
> > Therefore, update the self-tests to start testing this case.
> >
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> 
> Thank you Eric.
> 
> I have given this a lot of thought and here is what I predict will
> happen thanks to this added test:
> - We will not find a driver that this breaks, in the sense of
> producing wrong results and triggering failure in this test.
> - We probably will see drivers that when running this test when DMA
> debug is compiled and enabled trigger the debug warning about double
> DMA mapping of the same cache line.
> 
> The reason is that these double mapping stemming from this test will
> be from mapping the same buffer as source and destination.
> As such, the situation that is the cause for the DMA debug warning, of
> a mapping causing  cache flush invalidate, followed by DMA, followed
> by another mapping causing cache flush/invalidate while the DMA is in
> flight, will not happen. Instead we will have mapping ->
> flush/invalidate -> another mapping -> flush/invalidate -> DMA ...
> 
> Note, this is certainly not a claim we should not add this test! on
> the contrary ...
> 
> In fact, I would be tempted to claim that this means the real problem
> is with an over zealous DMA debug logic. Unfortunately, I can think of
> other scenarios where things are not so simple:
> 
> For example, what happens if a crypto API user has a buffer, which it
> divides into two parts, and then submit a crypto op on one part and
> another crypto op on the 2nd part (say encrypt and hash, just as an
> example). For the best of my knowledge, there is nothing forcing the
> split between the two parts to fall on a cache line. This can cause a
> double mapping of the same cache line - and this time the warning is
> real, because we are not guaranteed a single DMA operation following
> the two mappings. There is nothing much a crypto driver can do even -
> the two operations don't have to be done by the same driver at all...
> 
> I believe the scenario you are proposing to test is a benign example
> of a larger issue. I also believe this is an example of Worse in
> Better* and that the right solution is to dictate certain rules on the
> callers of the crypto API. Whether these rules should or should not
> include a limitation of not passing the same buffer via two different
> scatter gather list to the same crypto op is debatable, but I think we
> cannot run away from defining some rules.
> 
> I would really love for others to voice an opinion on this. It seems a
> rather narrow discussion so far between the two of us on what I feel
> is  a broader issue.

I don't have an answer, sorry.

I personally don't actually have a lot of interest in the crypto accelerator
support in the crypto API, since in the domain I work in (storage encryption)
it's much more common for inline encryption hardware to be used instead, and
that has its own support in the Linux block layer, separate from the crypto API.

If there are fundamental issues with how crypto accelerators are supported in
the crypto API, then I think that the people who actually care about such
hardware need to get together to create a plan for correctly supporting it.
Doing separate crypto operations on contiguous buffers is absolutely something
that users can expect to work, so if that in fact cannot work, then I expect
that this limitation will need to be very explicitly documented and checked in
the crypto API, and users will need to explicitly opt-in to being able to use
crypto accelerators rather than having them (sort of) be used by default.

- Eric
