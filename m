Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30929573940
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbiGMOwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiGMOwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:52:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3B4163C14D;
        Wed, 13 Jul 2022 07:52:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 708E11424;
        Wed, 13 Jul 2022 07:52:21 -0700 (PDT)
Received: from [10.1.29.153] (e121487-lin.cambridge.arm.com [10.1.29.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D1E53F73D;
        Wed, 13 Jul 2022 07:52:19 -0700 (PDT)
Message-ID: <653f4dd9-1325-22f5-1fe0-79e0ec9d2283@arm.com>
Date:   Wed, 13 Jul 2022 15:52:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] random: vary jitter iterations based on cycle counter
 speed
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220422132027.1267060-1-Jason@zx2c4.com>
 <eb74e1b8-af7e-21e8-658f-af6c7975264e@arm.com> <Ys7ZURKkoHw8Bp+q@zx2c4.com>
From:   Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <Ys7ZURKkoHw8Bp+q@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 7/13/22 15:40, Jason A. Donenfeld wrote:
> Hi Vladimir,
> 
> On Wed, Jul 13, 2022 at 03:31:05PM +0100, Vladimir Murzin wrote:
>> I've just seen on the platform with slow(ish) timer that it is now considered
>> as a source of entropy with samples_per_bit set to 27 (5.19-rc6 has MAX_SAMPLES_PER_BIT
>> set to 32). Because of that I see significant delays and I'm trying to understand what
>> could be wrong with my setup.
>>
>> I observe one credit_init_bits(1) call (via entropy_timer()) per ~970 schedule() calls.
>> Is that somewhat expected? Does it make sense at all?
> 
> How slow are we talking? Seconds? Minutes? Is it too slow? It's possible
> that MAX_SAMPLES_PER_BIT=32 is a bit high as a threshold and I should
> reduce that a bit.
> 

TBH, I run out of patience and never seen it completes, more then seconds. I just was
curious how much it is should take to get crng_ready() return true.

> Also, out of curiosity, why is your timer so slow?

It is part of slow(ish) FPGA.

Cheers
Vladimir

> 
> Jason

