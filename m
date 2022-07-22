Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38B557E0C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 13:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiGVLWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 07:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiGVLWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 07:22:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7605363910;
        Fri, 22 Jul 2022 04:22:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25D7AB827CE;
        Fri, 22 Jul 2022 11:22:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE79C341C6;
        Fri, 22 Jul 2022 11:22:27 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="A72kHDjI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1658488946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tEMNMB2Z49B1S8tRR73A3k1qlwc8qZ7y2Lb47TLNcJY=;
        b=A72kHDjIhCKy1SCFFNVSX+Vp2BEvkV7ka1UD5j32SfhxQnO0X7LJ74HcDr+imBz9vI5rhm
        6080JFv+KzAAK4056Y1qyXv5he1wWynhSKqQTQdQz1e06bV9uLXXkXAsiCX/HmW32WQCQu
        qilfUhpkwlG/HTO/fr6WxsF3nMcVXzM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 18cc06f4 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 22 Jul 2022 11:22:26 +0000 (UTC)
Date:   Fri, 22 Jul 2022 13:22:22 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Holger Dengler <dengler@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        x86@kernel.org, Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Harald Freudenberger <freude@linux.ibm.com>
Subject: Re: [PATCH v2] random: handle archrandom in plural words
Message-ID: <YtqIbrds53EuyqPE@zx2c4.com>
References: <YtP1+MJ1tNdJA60l@zx2c4.com>
 <20220717200356.75060-1-Jason@zx2c4.com>
 <46c1a7be-080b-3315-50cc-d3c848fd99e3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <46c1a7be-080b-3315-50cc-d3c848fd99e3@linux.ibm.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Holger,

On Fri, Jul 22, 2022 at 10:08:05AM +0200, Holger Dengler wrote:
> Why not changing the API to take bytes instead of words? Sure, at the
> moment it looks like all platforms with TRNG support are able to
> deliver at least one word, but bytes would be more flexible. 

The idea is to strike a sweet spot between capabilities. S390x is fine
with byte-level granularity up to arbitrary lengths, while x86 is best
with word-level granularity of length 1. The happy intersection between
the two is just word-level granularity of arbitrary length. Yes we
_could_ introduce a lot of code complexity by cascading the x86 case
down into smaller and smaller registers, ignoring the fact that it's no
longer efficient below 32- or 64-bit registers depending on vendor. But
then we're relying on the inliner to remove all of that extra code,
since all callers actually only ever want 32 or 64 bytes. Why bloat for
nothing? The beauty of this approach is that it translates very
naturally over all the various quirks of architectures without having to
have a lot of coupling code.

The other reason is that it's simply not necessary. The primary use for
this in random.c is to fill a 32- or 64-*byte* block with "some stuff",
preferring RDSEED, then RDRAND, and finally falling back to RDTSC. These
correspond with arch_get_random_seed_longs(), arch_get_random_longs(),
and random_get_entropy() (which is usually get_cycles() underneath),
respectively. With the cycle counter being (at least) ~word-sized on all
platforms, keeping the granularity of the arch_get_random_*_longs()
functions the same lets us fill these with a basic cascade that doesn't
require a lot of code:

    unsigned long array[whatever];
    for (i = 0; i < ARRAY_SIZE(array);) {
        longs = arch_get_random_seed_longs(&array[i], ARRAY_SIZE(array) - i);
        if (longs) {
            i += longs;
            continue;
        }
        longs = arch_get_random_longs(&array[i], ARRAY_SIZE(array) - i);
        if (longs) {
            i += longs;
            continue;
        }
        array[i++] = random_get_entropy();
    }

By using a word as the underlying unit, the above cascade generates
optimal code on basically all archrandom platforms, no matter what their
byte-vs-word or one-vs-three-vs-many semantics are.

That's a bit long winded, but hopefully that gives a bit of insight on
why going from _long -> _longs is so "lazy" looking.

Jason
