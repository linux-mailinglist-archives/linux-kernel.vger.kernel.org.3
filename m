Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62729581E63
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 05:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240220AbiG0DyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 23:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiG0DyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 23:54:15 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F7337FB1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 20:54:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lt0Jd1lSnz4x1b;
        Wed, 27 Jul 2022 13:54:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1658894049;
        bh=kTFbGZYtIh0aDw7GS0DUle8DHhfypCpsBdzMprXBryI=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=CTwtJY9kCA6+M/ptApfbp6/9reKR4ShVxwLL0EJjUPHG4PXAiOmjjYhxsuHeYpQAW
         I+5/0wjOc2Az68kRZR5G0qOkAZdXXO3ZRxcioyYhqG+eujM/+SEfJd1dNtPadWsdzo
         7dih3yxPJg3mRiXtP2O7/e5dL5bsJklnNiVBPhqgl8lgdtIy5jGyhWgnc9cpLO9/Mr
         OQ6P5a+v91ZPHG1M97w4PGQZP/jsg4jA+ub5vF6y1HiKlo1/0WhdID5XDmnZQ4TJiK
         pJztQm0NhAsOok1r+EmBP/wh+BV188GTbEfsGQKK+cczIqk428epxZP8Za1TmKgI4Z
         6aHAcZFlLkEng==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] powerpc rng cleanups
In-Reply-To: <CAHmME9pMOQKnMUQQyOA+CkN5scQjtLN79pvdYSu70MkuU207cw@mail.gmail.com>
References: <20220711232448.136765-1-Jason@zx2c4.com>
 <YtVbbMpRbfCWEIFn@zx2c4.com>
 <CAHmME9pMOQKnMUQQyOA+CkN5scQjtLN79pvdYSu70MkuU207cw@mail.gmail.com>
Date:   Wed, 27 Jul 2022 13:54:07 +1000
Message-ID: <87wnbz9pnk.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:
> On Mon, Jul 18, 2022 at 3:09 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> On Tue, Jul 12, 2022 at 01:24:46AM +0200, Jason A. Donenfeld wrote:
>> > These are two small cleanups for -next. This v5 rebases on the latest
>> > git master, as some whitespace was added that made v4 no longer apply.
>> >
>> > Jason A. Donenfeld (2):
>> >   powerpc/powernv: rename remaining rng powernv_ functions to pnv_
>> >   powerpc/kvm: don't crash on missing rng, and use darn
>> >
>> >  arch/powerpc/include/asm/archrandom.h |  7 +--
>> >  arch/powerpc/kvm/book3s_hv_builtin.c  |  7 +--
>> >  arch/powerpc/platforms/powernv/rng.c  | 66 ++++++++++-----------------
>> >  drivers/char/hw_random/powernv-rng.c  |  2 +-
>> >  4 files changed, 30 insertions(+), 52 deletions(-)
>>
>> I think v5 has reached a completion point. Could you queue these up in
>> some PPC tree for 5.20?
>
> Just paging again. Do you think you could queue these up for 5.20?
> This trivial series is over a month old now.

It can't claim to fix a guest-triggerable hypervisor crash and also be
"trivial" :)

But yes I plan to queue it for v5.20.

cheers
