Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E001B4FB0C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 01:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243134AbiDJXFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 19:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbiDJXFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 19:05:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2848318352;
        Sun, 10 Apr 2022 16:03:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68840B80EC9;
        Sun, 10 Apr 2022 23:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2BEC385A4;
        Sun, 10 Apr 2022 23:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649631804;
        bh=3UW/ugtsAFc3LmqMEdhTjA4sBbB84OlrF236JWrXPJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NR9pk0uBM1asFnTpcfZ/n5egUA0L5wn0LwY4g0wU3t6o8+s1sxwXOHR2AYAWEi6pV
         I2vKpdgHuCEtkbj5jgEl+6Q+z2lm60QHNjVPUndluZnUmfI2C4+KbpzY9A5VH3UpK3
         P5r9Evysc6lL+rwlKglGhMFJbnFeXyKAGFovS8I7ute7Bmg1zu32YUyz4TLsfBLCTE
         fC/iqfphZbrVckNWFSyEQ+mV/51gW4BSq6CcPUm/8Qyydr7JRQY1FMsyTuSVmBdOKr
         0g+a0Sxr4+W04a25Z9gGkMyiR61smTiTbf6h82pbMVql8l89m1uCYkKbbielAEJF1K
         7i38S8/QIO/7A==
Date:   Sun, 10 Apr 2022 16:03:22 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        arnd@arndb.de, Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, x86@kernel.org,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH RFC v1 00/10] archs/random: fallback to using
 sched_clock() if no cycle counter
Message-ID: <YlNiOunUd5xfQiSL@sol.localdomain>
References: <20220408182145.142506-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408182145.142506-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 08:21:35PM +0200, Jason A. Donenfeld wrote:
> By my first guess, we have ktime_get_boottime_ns(), jiffies, and
> sched_clock(). It seems like sched_clock() has already done a lot of
> work in being always available with some incrementing value, falling
> back to jiffies as necessary. So this series goes with that as a
> fallback, for when the architecture doesn't define random_get_entropy in
> its own way and when there's no working cycle counter.

Won't this interact badly with how try_to_generate_entropy() (a.k.a. the "Linus
Jitter Dance") detects the presence of an appropriate timer currently?

        stack.cycles = random_get_entropy();

        /* Slow counter - or none. Don't even bother */
        if (stack.cycles == random_get_entropy())
                return;

So if random_get_entropy() always returns 0, then try_to_generate_entropy()
won't run.  However, if random_get_entropy() is even just a low-precision timer,
then try_to_generate_entropy() will have a chance of running, since the timer
might change between the two calls to random_get_entropy().  And if
try_to_generate_entropy() does run, then it credits 1 bit of entropy for every
iteration, regardless of the timer's precision.

This is an existing problem, but this patchset will make it worse, as it changes
a lot of cases from "no timer" to "low precision timer".

Perhaps try_to_generate_entropy() should check the timer at least 3 times and
verify that it changed each time?

- Eric
