Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928384FAE3D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 16:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242317AbiDJO2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 10:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbiDJO2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 10:28:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7879C25C75;
        Sun, 10 Apr 2022 07:26:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2081B80B73;
        Sun, 10 Apr 2022 14:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1C7C385A4;
        Sun, 10 Apr 2022 14:26:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Xd0Enayl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1649600764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ACW34jCdChesB8O9mr3A3gFQd+fZkgemUpW2KIQGTs8=;
        b=Xd0Enayl8UdMOLK8hb+p9ElFGR/nkOk182JQ3t/5PAWGrTN3GF03N95qlf3rrZl/Mt+RZI
        7g+OoLToQKHdL9+kdXKajZ1a3hsadEW5sVaIiDYC9L5V8y9LrnjV28ZvqwgrOh6rFPazES
        NrUCO3Ev2CsBJg7e3SN1A3lzDB/MMQU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8a808d78 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sun, 10 Apr 2022 14:26:04 +0000 (UTC)
Date:   Sun, 10 Apr 2022 16:25:52 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>
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
Message-ID: <YlLo8JVOS6FDmWUM@zx2c4.com>
References: <20220408182145.142506-1-Jason@zx2c4.com>
 <87wnfxhm3n.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wnfxhm3n.ffs@tglx>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Sun, Apr 10, 2022 at 01:29:32AM +0200, Thomas Gleixner wrote:
> But the below uncompiled hack gives you access to the 'best' clocksource
> of a machine, i.e. the one which the platform decided to be the one
> which is giving the best resolution. The minimal bitwidth of that is
> AFAICT 20 bits. In the jiffies case this will at least advance every
> tick.

Oh, huh, that's pretty cool. I can try to make a commit out of that. Are
you suggesting I use this as the fallback for all platforms that
currently return zero, or just for m68k per Arnd's suggestion, and then
use sched_clock() for the others? It sounds to me like you're saying
this would be best for all of them. If so, that'd be quite nice.


> The price, e.g. on x86 would be that RDTSC would be invoked via an
> indirect function call. Not the end of the world...

Well on x86, random_get_entropy() is overridden in the arch/ code to
call get_cycles(). So this would really just be for 486 and for other
architectures with no cycle counter that are currently returning zero.
However, this brings up a good point: if your proposed
ktime_read_raw_clock() function really is so nice, should it be used
everywhere unconditionally with no arch-specific overrides? On x86, is
it really guaranteed to be RDTSC, and not, say, some off-core HPET
situation? And is this acceptable to call from the hard irq handler?

Not yet having too much knowledge, I'm tentatively leaning toward the
safe side, of just using ktime_read_raw_clock() in the current places
that return zero all the time -- that is, for the purpose this patchset
has.

Jason
